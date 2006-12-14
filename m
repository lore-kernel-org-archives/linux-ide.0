From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] Fix ata_task_ioctl to return ATA registers on check condition
Date: Thu, 14 Dec 2006 09:59:19 -0600
Message-ID: <458174D7.1020307@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060703070502090308030905"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:49675 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932837AbWLNP51 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Dec 2006 10:57:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060703070502090308030905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The HDIO_DRIVE_TASK ioctl should output the taskfile register values, 
the smartctl utility checks the values of the lba registers specifically 
the values of lbam and lbah for failure status (0xf4 and 0x2c 
respectively). This patch will copy the ATA registers back to the 
user-space application on a check condition similiar to ata_cmd_ioctl().

Please ACK or comment.

Thanks,
David

--------------060703070502090308030905
Content-Type: text/x-patch;
 name="linux-2.6.19-ata-task-ioctl-sense.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.19-ata-task-ioctl-sense.patch"

--- linux-2.6.19-rc5/drivers/ata/libata-scsi.c.smart
+++ linux-2.6.19-rc5/drivers/ata/libata-scsi.c
@@ -273,8 +273,8 @@ int ata_task_ioctl(struct scsi_device *s
 {
 	int rc = 0;
 	u8 scsi_cmd[MAX_COMMAND_SIZE];
-	u8 args[7];
-	struct scsi_sense_hdr sshdr;
+	u8 args[7], *sensebuf = NULL;
+	int cmd_result;
 
 	if (arg == NULL)
 		return -EINVAL;
@@ -282,10 +282,14 @@ int ata_task_ioctl(struct scsi_device *s
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
@@ -295,11 +299,46 @@ int ata_task_ioctl(struct scsi_device *s
 
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
+					     &sshdr);
+			if (sshdr.sense_key==0 &&
+			    sshdr.asc==0 && sshdr.ascq==0)
+				cmd_result &= ~SAM_STAT_CHECK_CONDITION;
+		}
+
+		/* Send userspace ATA registers */
+		if (sensebuf[0] == 0x72 &&     /* format is "descriptor" */
+		    desc[0] == 0x09) {         /* code is "ATA Descriptor" */
+			args[0] = desc[13];    /* status */
+			args[1] = desc[3];     /* error */
+			args[2] = desc[5];     /* sector count (0:7) */
+			args[3] = desc[7];     /* lbal */
+			args[4] = desc[9];     /* lbam */
+			args[5] = desc[11];    /* lbah */
+			args[6] = desc[12];    /* select */
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
 

--------------060703070502090308030905--
