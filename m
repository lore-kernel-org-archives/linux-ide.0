From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH v2] [libata] Fix HDIO_DRIVE_CMD ioctl sense data check
Date: Fri, 29 Mar 2013 10:12:46 -0700
Message-ID: <1364577166-17930-1-git-send-email-gwendal@google.com>
References: <1364576992-17598-1-git-send-email-gwendal@google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f201.google.com ([74.125.82.201]:63673 "EHLO
	mail-we0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3C2RSx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Mar 2013 13:18:53 -0400
Received: by mail-we0-f201.google.com with SMTP id d46so48326wer.2
        for <linux-ide@vger.kernel.org>; Fri, 29 Mar 2013 10:18:51 -0700 (PDT)
In-Reply-To: <1364576992-17598-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ronald645@gmail.com
Cc: krzysiek@podlesie.net, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

commit 84a9a8cd9d0aa93c17e5815ab8a9cc4c0a765c63 changed the sense key
used for returning task registers, but HDIO_DRIVE_CMD ioctl was
not changed accordingly.

Tested: check that SMART ENABLE sent using HDIO_DRIVE_CMD returns 0
instead of EIO.

Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/ata/libata-scsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 318b413..5eae74b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -532,8 +532,8 @@ int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg)
 			struct scsi_sense_hdr sshdr;
 			scsi_normalize_sense(sensebuf, SCSI_SENSE_BUFFERSIZE,
 					     &sshdr);
-			if (sshdr.sense_key == 0 &&
-			    sshdr.asc == 0 && sshdr.ascq == 0)
+			if (sshdr.sense_key == RECOVERED_ERROR &&
+			    sshdr.asc == 0 && sshdr.ascq == 0x1D)
 				cmd_result &= ~SAM_STAT_CHECK_CONDITION;
 		}
 
@@ -618,8 +618,8 @@ int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
 			struct scsi_sense_hdr sshdr;
 			scsi_normalize_sense(sensebuf, SCSI_SENSE_BUFFERSIZE,
 						&sshdr);
-			if (sshdr.sense_key == 0 &&
-				sshdr.asc == 0 && sshdr.ascq == 0)
+			if (sshdr.sense_key == RECOVERED_ERROR &&
+			    sshdr.asc == 0 && sshdr.ascq == 0x1D)
 				cmd_result &= ~SAM_STAT_CHECK_CONDITION;
 		}
 
-- 
1.8.1.3

