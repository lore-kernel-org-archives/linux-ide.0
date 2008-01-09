From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata and starting/stopping ATAPI floppy devices
Date: Thu, 10 Jan 2008 08:41:13 +0900
Message-ID: <47855B99.3080302@gmail.com>
References: <200801051647.58866.linux@rainbow-software.org> <4784344C.5060208@gmail.com> <200801091853.15601.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:2512 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757789AbYAIXlT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 18:41:19 -0500
Received: by wa-out-1112.google.com with SMTP id v27so700039wah.23
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 15:41:19 -0800 (PST)
In-Reply-To: <200801091853.15601.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

From: Ondrej Zary <linux@rainbow-software.org>

Prevent libata from starting/stopping non-ATA devices (like ATAPI floppy 
drives) as they don't seem to like it:

sd 1:0:1:0: [sdb] Starting disk
ata2.01: configured for PIO2
sd 1:0:1:0: [sdb] Result: hostbyte=0x00 driverbyte=0x08
sd 1:0:1:0: [sdb] Sense Key : 0x2 [current]
sd 1:0:1:0: [sdb] ASC=0x3a ASCQ=0x0

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Trimmed message body and reformatted such that it's script friendly.

 drivers/ata/libata-scsi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.23-orig/drivers/ata/libata-scsi.c	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6.23-pentium/drivers/ata/libata-scsi.c	2008-01-05 15:50:16.000000000 +0100
@@ -802,7 +802,8 @@
 
 	blk_queue_max_phys_segments(sdev->request_queue, LIBATA_MAX_PRD);
 
-	sdev->manage_start_stop = 1;
+	if (dev->class == ATA_DEV_ATA)
+		sdev->manage_start_stop = 1;
 
 	if (dev)
 		ata_scsi_dev_config(sdev, dev);

