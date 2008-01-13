From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 5/12] ide-floppy: report DMA handling in idefloppy_pc_intr() properly
Date: Sun, 13 Jan 2008 21:18:18 +0100
Message-ID: <1200255505-31418-6-git-send-email-bbpetkov@yahoo.de>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-2-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-3-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-4-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-5-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp113.plus.mail.re1.yahoo.com ([69.147.102.76]:46595 "HELO
	smtp113.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753563AbYAMUWJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 15:22:09 -0500
In-Reply-To: <1200255505-31418-5-git-send-email-bbpetkov@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-floppy.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 00ea8d6..5004773 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -534,11 +534,17 @@ static ide_startstop_t idefloppy_pc_intr (ide_drive_t *drive)
 	unsigned int temp;
 	u16 bcount;
 	u8 stat, ireason;
+	int dma_error = 0;
 
 	debug_log("Reached %s interrupt handler\n", __FUNCTION__);
 
 	if (test_bit(PC_DMA_IN_PROGRESS, &pc->flags)) {
-		if (HWIF(drive)->ide_dma_end(drive)) {
+		dma_error = HWIF(drive)->ide_dma_end(drive);
+		if (dma_error) {
+			printk(KERN_ERR "%s: DMA %s error\n",
+				drive->name,
+				rq_data_dir(rq) == WRITE ? "write" :"read");
+
 			set_bit(PC_DMA_ERROR, &pc->flags);
 		} else {
 			pc->actually_transferred = pc->request_transfer;
-- 
1.5.3.7

