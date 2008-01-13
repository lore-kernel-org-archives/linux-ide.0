From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 7/12] ide-floppy: remove IDEFLOPPY_DEBUG_BUGS macro
Date: Sun, 13 Jan 2008 21:18:20 +0100
Message-ID: <1200255505-31418-8-git-send-email-bbpetkov@yahoo.de>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-2-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-3-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-4-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-5-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-6-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-7-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp101.plus.mail.re1.yahoo.com ([69.147.102.64]:26450 "HELO
	smtp101.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753616AbYAMUWL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 15:22:11 -0500
In-Reply-To: <1200255505-31418-7-git-send-email-bbpetkov@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-floppy.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index b826ac5..e7cc9dd 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -52,7 +52,6 @@
  */
 #define IDEFLOPPY_DEBUG_LOG		0
 #define IDEFLOPPY_DEBUG_INFO		0
-#define IDEFLOPPY_DEBUG_BUGS		1
 
 /* #define IDEFLOPPY_DEBUG(fmt, args...) printk(KERN_INFO fmt, ## args) */
 #define IDEFLOPPY_DEBUG( fmt, args... )
@@ -280,13 +279,11 @@ static void idefloppy_discard_data (ide_drive_t *drive, unsigned int bcount)
 		(void) HWIF(drive)->INB(IDE_DATA_REG);
 }
 
-#if IDEFLOPPY_DEBUG_BUGS
-static void idefloppy_write_zeros (ide_drive_t *drive, unsigned int bcount)
+static void idefloppy_write_zeros(ide_drive_t *drive, unsigned int bcount)
 {
 	while (bcount--)
 		HWIF(drive)->OUTB(0, IDE_DATA_REG);
 }
-#endif /* IDEFLOPPY_DEBUG_BUGS */
 
 
 /*
@@ -382,12 +379,10 @@ static void idefloppy_output_buffers (ide_drive_t *drive, idefloppy_pc_t *pc, un
 
 	idefloppy_do_end_request(drive, 1, done >> 9);
 
-#if IDEFLOPPY_DEBUG_BUGS
 	if (bcount) {
 		printk(KERN_ERR "%s: leftover data in idefloppy_output_buffers, bcount == %d\n", drive->name, bcount);
 		idefloppy_write_zeros(drive, bcount);
 	}
-#endif
 }
 
 static void idefloppy_update_buffers (ide_drive_t *drive, idefloppy_pc_t *pc)
-- 
1.5.3.7

