From: "John W. Linville" <linville@tuxdriver.com>
Subject: [patch libata-2.6] libata: SMART support via ATA pass-thru
Date: Thu, 30 Sep 2004 14:13:02 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040930141302.B14317@tuxdriver.com>
References: <20040928001633.A8363@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ra.tuxdriver.com ([24.172.12.4]:12814 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S269453AbUI3T0g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Sep 2004 15:26:36 -0400
Content-Disposition: inline
In-Reply-To: <20040928001633.A8363@florence.linkmargin.com>; from andyw@pobox.com on Tue, Sep 28, 2004 at 12:16:33AM -0500
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Patch to add support for SMART to libata via the HDIO_DRIVE_CMD and
HDIO_DRIVE_TASK ioctls.  These ioctls are translated to ATA pass-thru
CDBs and submitted via scsi_wait_req().

Signed-off-by: John W. Linville <linville@tuxdriver.com>
--- 
Obviously, this patch depends on the "T10/04-262 ATA pass thru" patch
posted on 9/28 by Andy Warner.  It will likely need some rework both
when check condition is supported for ATA pass-thru and when new
revisions of T10/04-262 are released.

 drivers/scsi/libata-scsi.c |  153 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata.h      |    2 
 2 files changed, 155 insertions(+)

--- libata-2.6/drivers/scsi/libata.h.orig
+++ libata-2.6/drivers/scsi/libata.h
@@ -43,6 +43,8 @@ extern void ata_dev_select(struct ata_po
                            unsigned int wait, unsigned int can_sleep);
 extern void ata_tf_to_host_nolock(struct ata_port *ap, struct ata_taskfile *tf);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
+extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
+extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 
 
 /* libata-scsi.c */
--- libata-2.6/drivers/scsi/libata-scsi.c.orig
+++ libata-2.6/drivers/scsi/libata-scsi.c
@@ -29,10 +29,13 @@
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
+#include <linux/hdreg.h>
 #include <asm/uaccess.h>
 
 #include "libata.h"
 
+#define SECTOR_SIZE	512
+
 typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, u8 *scsicmd);
 static void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
 			      struct scsi_cmnd *cmd,
@@ -70,6 +73,146 @@ int ata_std_bios_param(struct scsi_devic
 	return 0;
 }
 
+/**
+ *	ata_cmd_ioctl - Handler for HDIO_DRIVE_CMD ioctl
+ *	@dev: Device to whom we are issuing command
+ *	@arg: User provided data for issuing command
+ *
+ *	LOCKING:
+ *	Defined by the SCSI layer.  We don't really care.
+ *
+ *	RETURNS:
+ *	Zero on success, negative errno on error.
+ */
+
+int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg)
+{
+	int rc = 0;
+	u8 scsi_cmd[MAX_COMMAND_SIZE];
+	u8 args[4], *argbuf = NULL;
+	int argsize = 0;
+	struct scsi_request *sreq;
+
+	if (NULL == (void *)arg)
+		return -EINVAL;
+
+	if (copy_from_user(args, arg, sizeof(args)))
+		return -EFAULT;
+
+	sreq = scsi_allocate_request(scsidev, GFP_KERNEL);
+	if (!sreq)
+		return -EINTR;
+
+	memset(scsi_cmd, 0, sizeof(scsi_cmd));
+
+	if (args[3]) {
+		argsize = SECTOR_SIZE * args[3];
+		argbuf = kmalloc(argsize, GFP_KERNEL);
+		if (argbuf == NULL)
+			return -ENOMEM;
+
+		scsi_cmd[1]  = (4 << 1); /* PIO Data-in */
+		sreq->sr_data_direction = DMA_FROM_DEVICE;
+	} else {
+		scsi_cmd[1]  = (3 << 1); /* Non-data */
+		sreq->sr_data_direction = DMA_NONE;
+	}
+
+	scsi_cmd[0] = ATA_16;
+	scsi_cmd[2] = 0x1f;     /* no off.line or cc, yes all registers */
+
+	scsi_cmd[4] = args[2];
+	if (args[0] == WIN_SMART) { /* hack -- ide driver does this too... */
+		scsi_cmd[6]  = args[3];
+		scsi_cmd[8]  = args[1];
+		scsi_cmd[10] = 0x4f;
+		scsi_cmd[12] = 0xc2;
+	} else {
+		scsi_cmd[6]  = args[1];
+	}
+	scsi_cmd[14] = args[0];
+
+	/* Good values for timeout and retries?  Values below
+	   from scsi_ioctl_send_command() for default case... */
+	scsi_wait_req(sreq, scsi_cmd, argbuf, argsize, (10*HZ), 5);
+
+	if (sreq->sr_result) {
+		rc = -EIO;
+		goto error;
+	}
+
+	/* Need code to retrieve data from check condition? */
+
+	if ((argbuf)
+	 && copy_to_user((void *)(arg + sizeof(args)), argbuf, argsize))
+		rc = -EFAULT;
+error:
+	scsi_release_request(sreq);
+
+	if (argbuf)
+		kfree(argbuf);
+
+	return rc;
+}
+
+/**
+ *	ata_task_ioctl - Handler for HDIO_DRIVE_TASK ioctl
+ *	@dev: Device to whom we are issuing command
+ *	@arg: User provided data for issuing command
+ *
+ *	LOCKING:
+ *	Defined by the SCSI layer.  We don't really care.
+ *
+ *	RETURNS:
+ *	Zero on success, negative errno on error.
+ */
+int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
+{
+	int rc = 0;
+	u8 scsi_cmd[MAX_COMMAND_SIZE];
+	u8 args[7];
+	struct scsi_request *sreq;
+
+	if (NULL == (void *)arg)
+		return -EINVAL;
+
+	if (copy_from_user(args, arg, sizeof(args)))
+		return -EFAULT;
+
+	memset(scsi_cmd, 0, sizeof(scsi_cmd));
+	scsi_cmd[0]  = ATA_16;
+	scsi_cmd[1]  = (3 << 1); /* Non-data */
+	scsi_cmd[2]  = 0x1f;     /* no off.line or cc, yes all registers */
+	scsi_cmd[4]  = args[1];
+	scsi_cmd[6]  = args[2];
+	scsi_cmd[8]  = args[3];
+	scsi_cmd[10] = args[4];
+	scsi_cmd[12] = args[5];
+	scsi_cmd[14] = args[0];
+
+	sreq = scsi_allocate_request(scsidev, GFP_KERNEL);
+	if (!sreq) {
+		rc = -EINTR;
+		goto error;
+	}
+
+	sreq->sr_data_direction = DMA_NONE;
+	/* Good values for timeout and retries?  Values below
+	   from scsi_ioctl_send_command() for default case... */
+	scsi_wait_req(sreq, scsi_cmd, NULL, 0, (10*HZ), 5);
+
+	if (sreq->sr_result) {
+		rc = -EIO;
+		goto error;
+	}
+
+	/* Need code to retrieve data from check condition? */
+
+error:
+	scsi_release_request(sreq);
+	return rc;
+}
+
 int ata_scsi_ioctl(struct scsi_device *scsidev, int cmd, void __user *arg)
 {
 	struct ata_port *ap;
@@ -99,6 +242,16 @@ int ata_scsi_ioctl(struct scsi_device *s
 			return -EINVAL;
 		return 0;
 
+	case HDIO_DRIVE_CMD:
+		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			return -EACCES;
+		return ata_cmd_ioctl(scsidev, arg);
+
+	case HDIO_DRIVE_TASK:
+		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			return -EACCES;
+		return ata_task_ioctl(scsidev, arg);
+
 	default:
 		rc = -EOPNOTSUPP;
 		break;
