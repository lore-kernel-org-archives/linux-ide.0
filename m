From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH v3] [libata] Fix HDIO_DRIVE_CMD ioctl sense data check
Date: Sat, 30 Mar 2013 14:43:49 -0700
Message-ID: <1364679829-13607-1-git-send-email-gwendal@google.com>
References: <5155F320.2020004@cogentembedded.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ea0-f202.google.com ([209.85.215.202]:45270 "EHLO
	mail-ea0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3C3Vnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Mar 2013 17:43:53 -0400
Received: by mail-ea0-f202.google.com with SMTP id a15so93741eae.5
        for <linux-ide@vger.kernel.org>; Sat, 30 Mar 2013 14:43:52 -0700 (PDT)
In-Reply-To: <5155F320.2020004@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ronald645@gmail.com
Cc: krzysiek@podlesie.net, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sergei.shtylyov@cogentembedded.com, Gwendal Grignou <gwendal@google.com>

commit 84a9a8 "Set proper SK when CK_COND is set" changed the sense key
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

