From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 12/22] ide-tape: dump gcw fields on error in idetape_identify_device()
Date: Mon,  4 Feb 2008 14:40:30 +0100
Message-ID: <1202132440-26648-13-git-send-email-petkovbb@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:27138 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755975AbYBDNmb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 08:42:31 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2951090wah.23
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 05:42:31 -0800 (PST)
In-Reply-To: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

goes before "ide-tape: remove IDETAPE_DEBUG_INFO" patch in IDE quilt tree

Cc: Borislav Petkov <bbpetkov@yahoo.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 1c4f94c..712c5df 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -3402,16 +3402,17 @@ static int idetape_identify_device (ide_drive_t *drive)
 
 	/* Check that we can support this device */
 
-	if (gcw.protocol !=2 )
-		printk(KERN_ERR "ide-tape: Protocol is not ATAPI\n");
+	if (gcw.protocol != 2)
+		printk(KERN_ERR "ide-tape: Protocol (0x%02x) is not ATAPI\n",
+				gcw.protocol);
 	else if (gcw.device_type != 1)
-		printk(KERN_ERR "ide-tape: Device type is not set to tape\n");
+		printk(KERN_ERR "ide-tape: Device type (0x%02x) is not set "
+				"to tape\n", gcw.device_type);
 	else if (!gcw.removable)
 		printk(KERN_ERR "ide-tape: The removable flag is not set\n");
 	else if (gcw.packet_size != 0) {
-		printk(KERN_ERR "ide-tape: Packet size is not 12 bytes long\n");
-		if (gcw.packet_size == 1)
-			printk(KERN_ERR "ide-tape: Sorry, padding to 16 bytes is still not supported\n");
+		printk(KERN_ERR "ide-tape: Packet size (0x%02x) is not 12 "
+				"bytes long\n", gcw.packet_size);
 	} else
 		return 1;
 	return 0;
-- 
1.5.3.7

