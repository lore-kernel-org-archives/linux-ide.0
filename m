From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] libata-scsi: ata_task_ioctl should return ATA registers (RESEND)
Date: Mon, 29 Jan 2007 16:30:47 -0600
Message-ID: <20070129223047.GA26503@dhcp-193.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56183 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbXA2Wdm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 17:33:42 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, htejun@gmail.com, akpm@osdl.org, dmilburn@redhat.com

User applications using the HDIO_DRIVE_TASK ioctl specific
ATA registers to be returned to userspace.

Signed-off-by: David Milburn <dmilburn@redhat.com>
Acked-by: Tejun Heo <htejun@gmail.com>
Acked-by: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7cc5a4a..2351aef 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -273,8 +273,8 @@ int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
 {
 	int rc = 0;
 	u8 scsi_cmd[MAX_COMMAND_SIZE];
-	u8 args[7];
-	struct scsi_sense_hdr sshdr;
+	u8 args[7], *sensebuf = NULL;
+	int cmd_result;
 
 	if (arg == NULL)
 		return -EINVAL;
@@ -282,10 +282,14 @@ int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
 	if (copy_from_user(args, arg, sizeof(args)))
 		return -EFAULT;
 
+	sensebuf = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_NOIO);
+	if (!sensebuf)
+		return -ENOMEM;
+
 	memset(scsi_cmd, 0, sizeof(scsi_cmd));
 	scsi_cmd[0]  = ATA_16;
 	scsi_cmd[1]  = (3 << 1); /* Non-data */
-	/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
+	scsi_cmd[2]  = 0x20;     /* cc but no off.line or data xfer */
 	scsi_cmd[4]  = args[1];
 	scsi_cmd[6]  = args[2];
 	scsi_cmd[8]  = args[3];
@@ -295,11 +299,46 @@ int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
 
 	/* Good values for timeout and retries?  Values below
 	   from scsi_ioctl_send_command() for default case... */
-	if (scsi_execute_req(scsidev, scsi_cmd, DMA_NONE, NULL, 0, &sshdr,
-			     (10*HZ), 5))
+	cmd_result = scsi_execute(scsidev, scsi_cmd, DMA_NONE, NULL, 0,
+				  sensebuf, (10*HZ), 5, 0);
+
+	if (driver_byte(cmd_result) == DRIVER_SENSE) {/* sense data available */
+		u8 *desc = sensebuf + 8;
+		cmd_result &= ~(0xFF<<24); /* DRIVER_SENSE is not an error */
+
+		/* If we set cc then ATA pass-through will cause a
+		 * check condition even if no error. Filter that. */
+		if (cmd_result & SAM_STAT_CHECK_CONDITION) {
+			struct scsi_sense_hdr sshdr;
+			scsi_normalize_sense(sensebuf, SCSI_SENSE_BUFFERSIZE,
+						&sshdr);
+			if (sshdr.sense_key==0 &&
+			    sshdr.asc==0 && sshdr.ascq==0)
+				cmd_result &= ~SAM_STAT_CHECK_CONDITION;
+		}
+
+		/* Send userspace ATA registers */
+		if (sensebuf[0] == 0x72 &&	/* format is "descriptor" */
+		    desc[0] == 0x09) {/* code is "ATA Descriptor" */
+			args[0] = desc[13];	/* status */
+			args[1] = desc[3];	/* error */
+			args[2] = desc[5];	/* sector count (0:7) */
+			args[3] = desc[7];	/* lbal */
+			args[4] = desc[9];	/* lbam */
+			args[5] = desc[11];	/* lbah */
+			args[6] = desc[12];	/* select */
+			if (copy_to_user(arg, args, sizeof(args)))
+				rc = -EFAULT;
+		}
+	}
+
+	if (cmd_result) {
 		rc = -EIO;
+		goto error;
+	}
 
-	/* Need code to retrieve data from check condition? */
+ error:
+	kfree(sensebuf);
 	return rc;
 }
 
