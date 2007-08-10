From: akpm@linux-foundation.org
Subject: [patch 22/25] libata: send event when AN received
Date: Fri, 10 Aug 2007 13:59:48 -0700
Message-ID: <200708102059.l7AKxmTe008633@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49974 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762539AbXHJVQN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:16:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, kristen.c.accardi@intel.com, James.Bottomley@steeleye.com, htejun@gmail.com

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

When we get an SDB FIS with the 'N' bit set, we should send an event to user
space to indicate that there has been a media change.  This will be done via
the scsi device.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/ahci.c        |   22 ++++++++++++++++++++++
 drivers/ata/libata-scsi.c |   16 ++++++++++++++++
 include/linux/libata.h    |    1 +
 3 files changed, 39 insertions(+)

diff -puN drivers/ata/ahci.c~libata-send-event-when-an-received drivers/ata/ahci.c
--- a/drivers/ata/ahci.c~libata-send-event-when-an-received
+++ a/drivers/ata/ahci.c
@@ -1529,6 +1529,28 @@ static void ahci_port_intr(struct ata_po
 		return;
 	}
 
+	if (status & PORT_IRQ_SDB_FIS) {
+		/*
+		 * if this is an ATAPI device with AN turned on,
+		 * then we should interrogate the device to
+		 * determine the cause of the interrupt
+		 *
+		 * for AN - this we should check the SDB FIS
+		 * and find the I and N bits set
+		 */
+		const u32 *f = pp->rx_fis + RX_FIS_SDB;
+
+		/* check the 'N' bit in word 0 of the FIS */
+		if (f[0] & (1 << 15)) {
+			int port_addr =  ((f[0] & 0x00000f00) >> 8);
+			struct ata_device *adev;
+			if (port_addr < ATA_MAX_DEVICES) {
+				adev = &ap->device[port_addr];
+				if (adev->flags & ATA_DFLAG_AN)
+					ata_scsi_media_change_notify(adev);
+			}
+		}
+	}
 	if (ap->sactive)
 		qc_active = readl(port_mmio + PORT_SCR_ACT);
 	else
diff -puN drivers/ata/libata-scsi.c~libata-send-event-when-an-received drivers/ata/libata-scsi.c
--- a/drivers/ata/libata-scsi.c~libata-send-event-when-an-received
+++ a/drivers/ata/libata-scsi.c
@@ -3218,6 +3218,22 @@ static void ata_scsi_remove_dev(struct a
 }
 
 /**
+ *	ata_scsi_media_change_notify - send media change event
+ *	@atadev: Pointer to the disk device with media change event
+ *
+ *	Tell the block layer to send a media change notification
+ *	event.
+ *
+ * 	LOCKING:
+ * 	interrupt context, may not sleep.
+ */
+void ata_scsi_media_change_notify(struct ata_device *atadev)
+{
+	scsi_device_event_notify(atadev->sdev, SDEV_MEDIA_CHANGE);
+}
+EXPORT_SYMBOL_GPL(ata_scsi_media_change_notify);
+
+/**
  *	ata_scsi_hotplug - SCSI part of hotplug
  *	@work: Pointer to ATA port to perform SCSI hotplug on
  *
diff -puN include/linux/libata.h~libata-send-event-when-an-received include/linux/libata.h
--- a/include/linux/libata.h~libata-send-event-when-an-received
+++ a/include/linux/libata.h
@@ -761,6 +761,7 @@ extern void ata_host_init(struct ata_hos
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
+extern void ata_scsi_media_change_notify(struct ata_device *atadev);
 extern void ata_sas_port_destroy(struct ata_port *);
 extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
 					   struct ata_port_info *, struct Scsi_Host *);
_
