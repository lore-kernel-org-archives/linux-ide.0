From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/15] libata-hp: implement ata_eh_scsi_hotplug()
Date: Tue, 11 Apr 2006 23:14:07 +0900
Message-ID: <11447648472694-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.237]:40126 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751290AbWDKOOO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:14 -0400
Received: by wproxy.gmail.com with SMTP id i11so931978wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:13 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This is SCSI part of hotplug support.  Devices marked for SCSI unplug
are scsi_remove'd, and, if SCSI plug is requested, all enabled but
unattached ATA devices get scanned and attached.  This patch only
implements SCSI hotplug support.  The next patch will connect ATA
hotplug events to SCSI hotplug.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c   |   59 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-scsi.c |   41 +++++++++++++++++++++++++++++++
 drivers/scsi/libata.h      |    2 +
 3 files changed, 102 insertions(+), 0 deletions(-)

14867aadbb30dc446856a73ff519456a38e1758d
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 7dc6ea6..ee46221 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1472,3 +1472,62 @@ void ata_eh_hotplug(struct ata_port *ap)
 	 * current EH run is complete.
 	 */
 }
+
+/**
+ *	ata_eh_scsi_hotplug - SCSI part of hot [un]plugging
+ *	@data: Pointer to ATA port to perform SCSI hot [un]plugging on
+ *
+ *	Perform SCSI part of hot [un]plugging.  It's executed from a
+ *	separate workqueue after EH completes.  This is necessary
+ *	because SCSI hot plugging requires working EH and hot
+ *	unplugging is synchronized with hot plugging with a mutex.
+ */
+void ata_eh_scsi_hotplug(void *data)
+{
+	struct ata_port *ap = data;
+	unsigned long timeout;
+	int i;
+
+	ata_clr_hotplug_flags(ap, ATA_HOTPLUG_SCSI_UNPLUG);
+
+	/* always unplug detached devices */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+
+		if (dev->flags & ATA_DFLAG_DETACH_SCSI) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&ap->host_set->lock, flags);
+			dev->flags &= ~ATA_DFLAG_DETACH_SCSI;
+			spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+			ata_scsi_remove_dev(ap, dev);
+		}
+	}
+
+	/* SCSI hotplug is requested.  EH might still be running and
+	 * we wanna scan the bus after EH is complete; otherwise, SCSI
+	 * scan fails silently.  scsi_block_when_processing_errors()
+	 * cannot be used because we might not have a sdev to wait on.
+	 * Poll for !scsi_host_in_recovery() for at most 5 secs.
+	 *
+	 * The worst that can happen here is bus scan failure, well,
+	 * the user will have to replug the device.  No biggie.
+	 */
+	timeout = jiffies + 5 * HZ;
+	do {
+		if (!scsi_host_in_recovery(ap->host))
+			break;
+		msleep(100);
+	} while (time_before(jiffies, timeout));
+
+	if (scsi_host_in_recovery(ap->host))
+		printk(KERN_WARNING "ata%u: EH still in progress after "
+		       "5 secs, SCSI scan might fail\n", ap->id);
+
+	/* scan if plug operation is requested */
+	if (ap->hotplug_flags & ATA_HOTPLUG_SCSI_PLUG) {
+		ata_clr_hotplug_flags(ap, ATA_HOTPLUG_SCSI_PLUG);
+		ata_scsi_scan_host(ap);
+	}
+}
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 2e8fb2f..fac37cd 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2778,3 +2778,44 @@ void ata_scsi_offline_dev(struct ata_por
 	if (dev->sdev)
 		scsi_device_set_state(dev->sdev, SDEV_OFFLINE);
 }
+
+/**
+ *	ata_scsi_remove_dev - remove attached SCSI device
+ *	@ap: ATA port @dev is on
+ *	@dev: ATA device to remove attached SCSI device for
+ *
+ *	This function is called from ata_eh_scsi_hotplug() and
+ *	responsible for removing the SCSI device attached to @dev.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_scsi_remove_dev(struct ata_port *ap, struct ata_device *dev)
+{
+	struct scsi_device *sdev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	sdev = dev->sdev;
+	if (!sdev) {
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+		return;
+	}
+
+	/* clearing dev->sdev is protected by host_set lock */
+	dev->sdev = NULL;
+
+	/* The following ensures the attached sdev is offline on
+	 * return from ata_scsi_offline_dev() regardless it wins or
+	 * loses the race against this function.
+	 */
+	scsi_device_set_state(sdev, SDEV_OFFLINE);
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	printk(KERN_INFO "ata%u: dev %u detaching (SCSI %s)\n",
+	       ap->id, dev->devno, sdev->sdev_gendev.bus_id);
+
+	scsi_remove_device(sdev);
+}
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 9e8adee..88f697a 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -77,6 +77,7 @@ extern struct scsi_transport_template at
 
 extern void ata_scsi_scan_host(struct ata_port *ap);
 extern void ata_scsi_offline_dev(struct ata_port *ap, struct ata_device *dev);
+extern void ata_scsi_remove_dev(struct ata_port *ap, struct ata_device *dev);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
 
@@ -110,5 +111,6 @@ extern void ata_scsi_rbuf_fill(struct at
 extern void ata_ering_init(struct ata_ering *ering, int size);
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 extern void ata_eh_schedule_qc(struct ata_queued_cmd *qc);
+extern void ata_eh_scsi_hotplug(void *data);
 
 #endif /* __LIBATA_H__ */
-- 
1.2.4


