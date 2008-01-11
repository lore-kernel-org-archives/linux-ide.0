From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 18/21] ide-floppy: fix error handling in idefloppy_probe()
Date: Fri, 11 Jan 2008 12:58:16 +0100
Message-ID: <1200052699-28420-19-git-send-email-bbpetkov@yahoo.de>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-2-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-3-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-4-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-5-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-6-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-7-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-8-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-9-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-10-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-11-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-12-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-13-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-14-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-15-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-16-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-17-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-18-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp113.plus.mail.re1.yahoo.com ([69.147.102.76]:39740 "HELO
	smtp113.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759058AbYAKMDk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 07:03:40 -0500
In-Reply-To: <1200052699-28420-18-git-send-email-bbpetkov@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej@gollum.tnic, Zolnierkiewicz@gollum.tnic, bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-floppy.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 89b26ea..0729df5 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1737,7 +1737,8 @@ static int ide_floppy_probe(ide_drive_t *drive)
 				" emulation.\n", drive->name);
 		goto failed;
 	}
-	if ((floppy = kzalloc(sizeof (idefloppy_floppy_t), GFP_KERNEL)) == NULL) {
+	floppy = kzalloc(sizeof(idefloppy_floppy_t), GFP_KERNEL);
+	if (!floppy) {
 		printk(KERN_ERR "ide-floppy: %s: Can't allocate a floppy"
 				" structure\n", drive->name);
 		goto failed;
-- 
1.5.3.7

