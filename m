From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/13] libata-hp: implement SCSI part of hotplug
Date: Sat, 20 May 2006 00:48:27 +0900
Message-ID: <1148053707416-git-send-email-htejun@gmail.com>
References: <11480537063293-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:1649 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932391AbWESPsf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 11:48:35 -0400
Received: by py-out-1112.google.com with SMTP id z59so966321pyg
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 08:48:34 -0700 (PDT)
In-Reply-To: <11480537063293-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement SCSI part of hotplug.

This must be done in a separate context as SCSI makes use of EH during
probing.  Unfortunately, SCSI probing fails silently if EH is active.
ata_eh_scsi_hotplug() does its best to avoid such conditions but,
theoretically, it may fail to associate SCSI device to newly found ATA
device; however, the chance is very slim and I haven't experienced any
such event during testing.

Device removal synchronization is somewhat complex but I think I've
got it right and haven't seen it malfunction.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-eh.c   |   70 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/libata-scsi.c |   59 +++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata.h      |    2 +
 include/linux/libata.h     |    2 +
 5 files changed, 132 insertions(+), 2 deletions(-)

6a1cd6180ac9e13e29446378bd15245c4c7efd5d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1809f98..7600b5f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5347,6 +5347,7 @@ static void ata_host_init(struct ata_por
 	ap->last_ctl = 0xFF;
 
 	INIT_WORK(&ap->port_task, NULL, NULL);
+	INIT_WORK(&ap->hotplug_task, ata_eh_scsi_hotplug, ap);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 
 	/* set cable type */
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index fff93d9..0ab7d52 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -286,9 +286,13 @@ void ata_scsi_error(struct Scsi_Host *ho
 	/* clean up */
 	spin_lock_irqsave(hs_lock, flags);
 
+	if (ap->flags & ATA_FLAG_SCSI_HOTPLUG)
+		queue_work(ata_hotplug_wq, &ap->hotplug_task);
+
 	if (ap->flags & ATA_FLAG_RECOVERED)
 		ata_port_printk(ap, KERN_INFO, "EH complete\n");
-	ap->flags &= ~ATA_FLAG_RECOVERED;
+
+	ap->flags &= ~(ATA_FLAG_SCSI_HOTPLUG | ATA_FLAG_RECOVERED);
 
 	spin_unlock_irqrestore(hs_lock, flags);
 
@@ -1736,6 +1740,70 @@ static void ata_eh_finish(struct ata_por
 }
 
 /**
+ *	ata_eh_scsi_hotplug - SCSI part of hotplug
+ *	@data: Pointer to ATA port to perform SCSI hotplug on
+ *
+ *	Perform SCSI part of hotplug.  It's executed from a separate
+ *	workqueue after EH completes.  This is necessary because SCSI
+ *	hot plugging requires working EH and hot unplugging is
+ *	synchronized with hot plugging with a mutex.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_eh_scsi_hotplug(void *data)
+{
+	struct ata_port *ap = data;
+	unsigned long timeout;
+	int i, requeue = 0;
+
+	DPRINTK("ENTER\n");
+
+	/* SCSI hotplug is requested.  EH might still be running and
+	 * we wanna scan the bus after EH is complete; otherwise, SCSI
+	 * scan fails silently.  scsi_block_when_processing_errors()
+	 * cannot be used because we might not have a sdev to wait on.
+	 * Poll for !scsi_host_in_recovery() for 2 secs.
+	 */
+	timeout = jiffies + 2 * HZ;
+	do {
+		if (!scsi_host_in_recovery(ap->host))
+			break;
+		msleep(100);
+	} while (time_before(jiffies, timeout));
+
+	if (scsi_host_in_recovery(ap->host))
+		requeue = 1;
+
+	/* unplug detached devices */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		unsigned long flags;
+
+		if (!(dev->flags & ATA_DFLAG_DETACHED))
+			continue;
+
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+		dev->flags &= ~ATA_DFLAG_DETACHED;
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+		ata_scsi_remove_dev(dev);
+	}
+
+	/* scan for new ones */
+	ata_scsi_scan_host(ap);
+
+	if (requeue || scsi_host_in_recovery(ap->host)) {
+		/* we might have scanned while EH is active.  Repeat
+		 * scan after a sec.
+		 */
+		queue_delayed_work(ata_hotplug_wq, &ap->hotplug_task, HZ);
+	}
+
+	DPRINTK("EXIT\n");
+}
+
+/**
  *	ata_do_eh - do standard error handling
  *	@ap: host port to handle error for
  *	@prereset: prereset method (can be NULL)
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 5f46b11..5a9c08a 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2781,3 +2781,62 @@ int ata_scsi_offline_dev(struct ata_devi
 	}
 	return 0;
 }
+
+/**
+ *	ata_scsi_remove_dev - remove attached SCSI device
+ *	@dev: ATA device to remove attached SCSI device for
+ *
+ *	This function is called from ata_eh_scsi_hotplug() and
+ *	responsible for removing the SCSI device attached to @dev.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_scsi_remove_dev(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->ap;
+	struct scsi_device *sdev;
+	unsigned long flags;
+
+	/* Alas, we need to grab scan_mutex to ensure SCSI device
+	 * state doesn't change underneath us and thus
+	 * scsi_device_get() always succeeds.  The mutex locking can
+	 * be removed if there is __scsi_device_get() interface which
+	 * increments reference counts regardless of device state.
+	 */
+	mutex_lock(&ap->host->scan_mutex);
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	/* clearing dev->sdev is protected by host_set lock */
+	sdev = dev->sdev;
+	dev->sdev = NULL;
+
+	if (sdev) {
+		/* If user initiated unplug races with us, sdev can go
+		 * away underneath us after the host_set lock and
+		 * scan_mutex are released.  Hold onto it.
+		 */
+		if (scsi_device_get(sdev) == 0) {
+			/* The following ensures the attached sdev is
+			 * offline on return from ata_scsi_offline_dev()
+			 * regardless it wins or loses the race
+			 * against this function.
+			 */
+			scsi_device_set_state(sdev, SDEV_OFFLINE);
+		} else {
+			WARN_ON(1);
+			sdev = NULL;
+		}
+	}
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	mutex_unlock(&ap->host->scan_mutex);
+
+	if (sdev) {
+		ata_dev_printk(dev, KERN_INFO, "detaching (SCSI %s)\n",
+			       sdev->sdev_gendev.bus_id);
+
+		scsi_remove_device(sdev);
+		scsi_device_put(sdev);
+	}
+}
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index c8a3350..0176c40 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -76,6 +76,7 @@ extern struct scsi_transport_template at
 
 extern void ata_scsi_scan_host(struct ata_port *ap);
 extern int ata_scsi_offline_dev(struct ata_device *dev);
+extern void ata_scsi_remove_dev(struct ata_device *dev);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
 
@@ -110,5 +111,6 @@ extern void ata_schedule_scsi_eh(struct 
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
+extern void ata_eh_scsi_hotplug(void *data);
 
 #endif /* __LIBATA_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index df1cf91..4e7c839 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -518,7 +518,7 @@ struct ata_port {
 	struct ata_host_set	*host_set;
 	struct device 		*dev;
 
-	struct work_struct	port_task;
+	struct work_struct	port_task, hotplug_task;
 
 	unsigned int		hsm_task_state;
 
-- 
1.3.2


