From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH] libata: handle HDIO_SET_DMA & HDIO_GET_DMA ioctl
Date: Thu, 24 Jan 2013 15:39:22 +0900
Message-ID: <1359009562-22595-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:36716 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898Ab3AXGj0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2013 01:39:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

currently HDIO_SET_DMA & HDIO_GET_DMA are not handled in libata,
this patch add support to handle HDIO_SET_DMA & HDIO_GET_DMA ioctl,
which enables user to set ata device work in PIO or DMA mode.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/ata/libata-core.c |  2 +-
 drivers/ata/libata-scsi.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 71e8385..6b16952 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3136,7 +3136,7 @@ int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel)
 	return 0;
 }
 
-static int ata_dev_set_mode(struct ata_device *dev)
+int ata_dev_set_mode(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
 	struct ata_eh_context *ehc = &dev->link->eh_context;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 2222635..beac285 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -660,6 +660,8 @@ int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *scsidev,
 {
 	int val = -EINVAL, rc = -EINVAL;
 	unsigned long flags;
+	struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
+	int dma;
 
 	switch (cmd) {
 	case ATA_IOC_GET_IO32:
@@ -699,6 +701,40 @@ int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *scsidev,
 			return -EACCES;
 		return ata_task_ioctl(scsidev, arg);
 
+	case HDIO_GET_DMA:
+		return put_user(dev->xfer_mode == dev->dma_mode,
+				(long __user *) arg);
+	case HDIO_SET_DMA:
+		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			return -EACCES;
+
+		if (copy_from_user(&dma, arg, sizeof(dma)))
+			return -EFAULT;
+
+		if (dma) {
+			if (!ata_dma_enabled(dev))
+				return -EINVAL;
+
+			dev->xfer_mode = dev->dma_mode;
+			dev->xfer_shift = ata_xfer_mode2shift(dev->dma_mode);
+			if (ap->ops->set_dmamode)
+				ap->ops->set_dmamode(ap, dev);
+		} else {
+			if (dev->pio_mode == 0xff)
+				return -EINVAL;
+
+			dev->xfer_mode = dev->pio_mode;
+			dev->xfer_shift = ATA_SHIFT_PIO;
+			if (ap->ops->set_piomode)
+				ap->ops->set_piomode(ap, dev);
+		}
+
+		ata_eh_acquire(ap);
+		rc = ata_dev_set_mode(dev);
+		ata_eh_release(ap);
+
+		return rc;
+
 	default:
 		rc = -ENOTTY;
 		break;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6e887c7..88664b67 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1067,6 +1067,7 @@ extern int ata_cable_80wire(struct ata_port *ap);
 extern int ata_cable_sata(struct ata_port *ap);
 extern int ata_cable_ignore(struct ata_port *ap);
 extern int ata_cable_unknown(struct ata_port *ap);
+extern int ata_dev_set_mode(struct ata_device *dev);
 
 /* Timing helpers */
 extern unsigned int ata_pio_need_iordy(const struct ata_device *);
-- 
1.8.1.1

