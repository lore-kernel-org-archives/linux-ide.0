From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: implement HDIO_GET_IDENTITY
Date: Tue, 2 Jan 2007 20:20:07 +0900
Message-ID: <20070102112007.GF10987@htj.dyndns.org>
References: <20070102111849.GD10987@htj.dyndns.org> <20070102111940.GE10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [221.139.199.108] ([221.139.199.108]:44478 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932853AbXABLUK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 06:20:10 -0500
Content-Disposition: inline
In-Reply-To: <20070102111940.GE10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

'hdparm -I' doesn't work with ATAPI devices and sg_sat is not widely
spread yet leaving no easy way to access ATAPI IDENTIFY data.
Implement HDIO_GET_IDENTITY such that at least 'hdparm -i' works.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -149,6 +149,45 @@ int ata_std_bios_param(struct scsi_devic
 }
 
 /**
+ *	ata_get_identity - Handler for HDIO_GET_IDENTITY ioctl
+ *	@sdev: SCSI device to get identify data for
+ *	@arg: User buffer area for identify data
+ *
+ *	LOCKING:
+ *	Defined by the SCSI layer.  We don't really care.
+ *
+ *	RETURNS:
+ *	Zero on success, negative errno on error.
+ */
+static int ata_get_identity(struct scsi_device *sdev, void __user *arg)
+{
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	struct ata_device *dev = ata_scsi_find_dev(ap, sdev);
+	u16 __user *dst = arg;
+	char buf[40];
+
+	if (!dev)
+		return -ENOMSG;
+
+	if (copy_to_user(dst, dev->id, ATA_ID_WORDS * sizeof(u16)))
+		return -EFAULT;
+
+	ata_id_string(dev->id, buf, ATA_ID_PROD, ATA_ID_PROD_LEN);
+	if (copy_to_user(dst + ATA_ID_PROD, buf, ATA_ID_PROD_LEN))
+		return -EFAULT;
+
+	ata_id_string(dev->id, buf, ATA_ID_FW_REV, ATA_ID_FW_REV_LEN);
+	if (copy_to_user(dst + ATA_ID_FW_REV, buf, ATA_ID_FW_REV_LEN))
+		return -EFAULT;
+
+	ata_id_string(dev->id, buf, ATA_ID_SERNO, ATA_ID_SERNO_LEN);
+	if (copy_to_user(dst + ATA_ID_SERNO, buf, ATA_ID_SERNO_LEN))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
  *	ata_cmd_ioctl - Handler for HDIO_DRIVE_CMD ioctl
  *	@scsidev: Device to which we are issuing command
  *	@arg: User provided data for issuing command
@@ -159,7 +198,6 @@ int ata_std_bios_param(struct scsi_devic
  *	RETURNS:
  *	Zero on success, negative errno on error.
  */
-
 int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg)
 {
 	int rc = 0;
@@ -320,6 +358,9 @@ int ata_scsi_ioctl(struct scsi_device *s
 			return -EINVAL;
 		return 0;
 
+	case HDIO_GET_IDENTITY:
+		return ata_get_identity(scsidev, arg);
+
 	case HDIO_DRIVE_CMD:
 		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 			return -EACCES;
