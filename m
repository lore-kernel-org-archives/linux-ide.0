From: Lucas Magasweran <lucas.magasweran@wdc.com>
Subject: [PATCH] Add HDIO_DRIVE_RESET ioctl to libata.
Date: Fri,  2 Aug 2013 16:10:28 -0700
Message-ID: <1375485028-11712-1-git-send-email-lucas.magasweran@wdc.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40145 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab3HBXJ6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Aug 2013 19:09:58 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so1153789pdj.21
        for <linux-ide@vger.kernel.org>; Fri, 02 Aug 2013 16:09:58 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org

This mimics the IDE interface implementation except it is
synchronous (i.e. the reset occurs in the same thread).
You can now use hdparm -w /dev/sda to issue an ATA
software reset after all pending commands are completed
(can be more than 1 when NCQ is used).

This ioctl has been of the list of things to do [1] so I
would like to get feedback on my proposed solution. I have
tested it using user-space tools to generate both queued
and non-queued commands. My inspection of the SATA bus
trace confirms that the SRST bit in the taskfile control
word is set and that the AHCI error handler does not kick
in causing a hard reset of the link when using hdparm
to issue a software reset.

[1] http://article.gmane.org/gmane.linux.ide/32474

Signed-off-by: Lucas Magasweran <lucas.magasweran@wdc.com>
---
 drivers/ata/libata-scsi.c |   65 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata.h      |    3 ++-
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 83c0890..87640a9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -649,6 +649,66 @@ int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
 	return rc;
 }
 
+/**
+ *  ata_drive_reset_ioctl - Handler for HDIO_DRIVE_RESET ioctl
+ *  @ap: Device to which we are issuing command
+ *
+ *  Execute a reset on the device as soon as the current IO
+ *  operation has completed. Multiple IO operations could be 
+ *  pending if NCQ is used.
+ *
+ *  TODO Executes an ATAPI soft reset if applicable, otherwise
+ *  executes an ATA soft reset on the controller.
+ *
+ *  LOCKING:
+ *  Defined by the SCSI layer.  We don't really care.
+ *
+ *  RETURNS:
+ *  Zero on success, negative errno on error.
+ */
+static int ata_drive_reset_ioctl(struct scsi_device *scsidev, struct ata_port *ap)
+{
+	unsigned long deadline = ata_deadline(jiffies, ATA_TMOUT_INTERNAL_QUICK);
+	unsigned int class;
+	int rc = 0;
+	unsigned long sleep_ms = ATA_TMOUT_INTERNAL_QUICK;
+	/* unsigned long flags; */
+
+	if (ap->ops->softreset) {
+		/* block further commands from being queued during reset */
+		rc = scsi_internal_device_block(scsidev);
+
+		/*
+		 * TODO Find the worst-case timeout value and sleep until it completes.
+		 * Alternatively, we can blk_abort_request in-flight commands as
+		 * done in ata_qc_schedule_eh() if the SRST should be immediate.
+		 */
+		while ( ap->qc_active && sleep_ms > 0 ) {
+			ata_msleep(ap, sleep_ms);
+			sleep_ms -= 1000;
+		}
+
+		/* should not need to acquire ap->lock since command queue is blocked */
+		/* spin_lock_irqsave(ap->lock, flags); */
+
+		/* send ATA Software Reset SRST */
+		rc = ap->ops->softreset(&ap->link, &class, deadline);
+
+		/* should not need to acquire ap->lock since command queue is blocked */
+		/* spin_unlock_irqrestore(ap->lock, flags); */
+
+		/* unblock command queue (restores RUNNING state) */
+		rc = scsi_internal_device_unblock(scsidev);
+	}
+	else
+	{
+		rc = -EOPNOTSUPP;
+		DPRINTK("ATA SOFTWARE RESET is not support by controller\n");
+	}
+
+	return rc;
+}
+
 static int ata_ioc32(struct ata_port *ap)
 {
 	if (ap->flags & ATA_FLAG_PIO_DMA)
@@ -702,6 +762,11 @@ int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *scsidev,
 			return -EACCES;
 		return ata_task_ioctl(scsidev, arg);
 
+	case HDIO_DRIVE_RESET:
+		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			return -EACCES;
+		return ata_drive_reset_ioctl(scsidev, ap);
+
 	default:
 		rc = -ENOTTY;
 		break;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 577d902..d5bef15 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -150,7 +150,8 @@ extern void ata_scsi_dev_rescan(struct work_struct *work);
 extern int ata_bus_probe(struct ata_port *ap);
 extern int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 			      unsigned int id, unsigned int lun);
-
+extern int scsi_internal_device_block(struct scsi_device *sdev);
+extern int scsi_internal_device_unblock(struct scsi_device *sdev);
 
 /* libata-eh.c */
 extern unsigned long ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd);
-- 
1.7.9.5

