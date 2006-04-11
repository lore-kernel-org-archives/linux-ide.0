From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/15] libata-hp: implement ata_eh_hotplug()
Date: Tue, 11 Apr 2006 23:14:07 +0900
Message-ID: <11447648473440-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.226]:31678 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751289AbWDKOOJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:09 -0400
Received: by wproxy.gmail.com with SMTP id i3so967079wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:09 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This is ATA part of hotplug support.  This function is to be called
from ->error_handler after all regular EH stuff is complete.
ata_eh_hotplug() may automatically mark some devices for detach and
detaches all marked devices.  Then, if requested and makes sense,
ata_bus_probe() is invoked to probe newly attached devices.

ata_eh_hotplug() makes sure that a detached ATA device is not accessed
from its corresponding SCSI device by offlining the SCSI device before
reusing the ATA device.  The rest of SCSI hotplug will be implemented
in the next patch.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 
 drivers/scsi/libata-eh.c   |  103 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-scsi.c |   18 ++++++++
 drivers/scsi/libata.h      |    1 
 include/linux/libata.h     |    1 
 5 files changed, 124 insertions(+), 0 deletions(-)

adf5feec346d7dea425d98a9e473a8704b2751d6
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8f50a99..85f0600 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5489,3 +5489,4 @@ EXPORT_SYMBOL_GPL(ata_eh_autopsy);
 EXPORT_SYMBOL_GPL(ata_eh_report);
 EXPORT_SYMBOL_GPL(ata_eh_revive);
 EXPORT_SYMBOL_GPL(ata_eh_finish_qcs);
+EXPORT_SYMBOL_GPL(ata_eh_hotplug);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 1f55cc9..7dc6ea6 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -237,6 +237,9 @@ int ata_scsi_error(struct Scsi_Host *hos
 
 	scsi_eh_flush_done_q(&ap->eh_done_q);
 
+	/* bookkeeping for hotplug */
+	ata_clr_hotplug_flags(ap, ATA_HOTPLUG_PROBE | ATA_HOTPLUG_DID_PROBE);
+
 	DPRINTK("EXIT\n");
 	return 0;
 }
@@ -1369,3 +1372,103 @@ void ata_eh_finish_qcs(struct ata_port *
 		}
 	}
 }
+
+/**
+ *	ata_eh_hotplug - ATA part of hot [un]plugging
+ *	@ap: ATA port to perform ATA hot [un]plugging on
+ *
+ *	Perform ATA port of hot [un]plugging.  Devices to be removed
+ *	are offlined and marked gone.  If probing is requested,
+ *	ata_bus_probe() is called.  This function only handles ATA
+ *	part of hot [un]plugging.  After ATA part is complete SCSI
+ *	operation is requested using SCSI_HOT[UN]PLUG host flags.
+ *	ata_eh_scsi_hotplug() performs the SCSI part.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_eh_hotplug(struct ata_port *ap)
+{
+	int scr_valid = ap->cbl == ATA_CBL_SATA && ap->ops->scr_read;
+	int i;
+
+	/* Turn off probing request and mark disabled device gone if
+	 * SStatus says no device is attached.
+	 */
+	if (scr_valid && !sata_dev_present(ap)) {
+		struct ata_device *dev = &ap->device[0];
+
+		ata_clr_hotplug_flags(ap, ATA_HOTPLUG_PROBE);
+		if (ata_dev_disabled(dev))
+			ata_eh_detach_dev(ap, dev);
+	}
+
+	/* probe only once per EH run to prevent EH->probe->EH->probe cycle */
+	if (ap->hotplug_flags & ATA_HOTPLUG_DID_PROBE)
+		ata_clr_hotplug_flags(ap, ATA_HOTPLUG_PROBE);
+	ata_set_hotplug_flags(ap, ATA_HOTPLUG_DID_PROBE);
+
+	/* detach all !enabled devices if probing is requested */
+	if (ap->hotplug_flags & ATA_HOTPLUG_PROBE) {
+		for (i = 0; i < ATA_MAX_DEVICES; i++) {
+			struct ata_device *dev = &ap->device[i];
+
+			if (!ata_dev_enabled(dev))
+				ata_eh_detach_dev(ap, dev);
+		}
+	}
+
+	/* offline and detach devices marked for ATA detach */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		unsigned long flags;
+
+		if (!(dev->flags & ATA_DFLAG_DETACH_ATA))
+			continue;
+
+		/* probably already disabled, but make sure */
+		ata_dev_disable(ap, dev);
+
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+		dev->class = ATA_DEV_UNKNOWN;
+		dev->flags &= ~ATA_DFLAG_DETACH_ATA;
+		ata_scsi_offline_dev(ap, dev);
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	}
+
+	/* probe requested? */
+	if (!(ap->hotplug_flags & ATA_HOTPLUG_PROBE))
+		return;
+
+	/* do we have any unoccupied slot? */
+	if (ap->device[0].class == ATA_DEV_UNKNOWN ||
+	    ((ap->flags & ATA_FLAG_SLAVE_POSS) &&
+	     ap->device[1].class == ATA_DEV_UNKNOWN)) {
+		unsigned long flags;
+
+		printk("ata%u: probing bus for new devices\n", ap->id);
+
+		/* make sure the port is frozen */
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+		ata_port_freeze(ap);
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+		ata_eh_wait_before_reset(ap);
+
+		/* probe */
+		if (ata_bus_probe(ap) == 1) {
+			/* An existing device has failed, we need to
+			 * repeat EH.  Freeze the port forcing EH
+			 * framework to reinvoke EH.
+			 */
+			ata_eh_schedule_port(ap, ATA_EH_FREEZE);
+		}
+	}
+
+	/* Probing is allowed only once per EH invocation and probing
+	 * request isn't maintained acress multiple EH runs.  To
+	 * implement these rules, HOTPLUG_PROBE and HOTPLUG_DID_PROBE
+	 * are cleared at the tail of ata_scsi_error() after the
+	 * current EH run is complete.
+	 */
+}
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 1793474..2e8fb2f 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2760,3 +2760,21 @@ void ata_scsi_scan_host(struct ata_port 
 	}
 }
 
+/**
+ *	ata_scsi_offline_dev - offline attached SCSI device
+ *	@ap: ATA port @dev is on
+ *	@dev: ATA device to offline attached SCSI device for
+ *
+ *	This function is called from ata_eh_hotplug() and responsible
+ *	for taking the SCSI device attached to @dev offline.  This
+ *	function is called with host_set lock which protects dev->sdev
+ *	against clearing.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_scsi_offline_dev(struct ata_port *ap, struct ata_device *dev)
+{
+	if (dev->sdev)
+		scsi_device_set_state(dev->sdev, SDEV_OFFLINE);
+}
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 09fddf6..9e8adee 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -76,6 +76,7 @@ extern int ata_cmd_ioctl(struct scsi_dev
 extern struct scsi_transport_template ata_scsi_transport_template;
 
 extern void ata_scsi_scan_host(struct ata_port *ap);
+extern void ata_scsi_offline_dev(struct ata_port *ap, struct ata_device *dev);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ee86a87..b9dd793 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -734,6 +734,7 @@ extern int ata_eh_revive(struct ata_port
 			 ata_postreset_fn_t postreset);
 extern void ata_eh_finish_qcs(struct ata_port *ap, struct ata_queued_cmd *qc,
 			      struct ata_taskfile *tf);
+extern void ata_eh_hotplug(struct ata_port *ap);
 
 
 static inline int
-- 
1.2.4


