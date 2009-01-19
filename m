From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH] tx4939ide: typo fix and minor cleanup
Date: Mon, 19 Jan 2009 23:10:25 +0900
Message-ID: <1232374225-5325-1-git-send-email-anemo@mba.ocn.ne.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:60352 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854AbZASOKX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jan 2009 09:10:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, sshtylyov@ru.mvista.com, linux-mips@linux-mips.org

The bcount is greater than 0 and less than or equal to 0x10000.
Thus '(bcount & 0xffff) == 0x0000' can be simplified as 'bcount == 0x10000'.

Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/ide/tx4939ide.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
index 882f6f0..40b0812 100644
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -261,9 +261,9 @@ static int tx4939ide_build_dmatable(ide_drive_t *drive, struct request *rq)
 				bcount = cur_len;
 			/*
 			 * This workaround for zero count seems required.
-			 * (standard ide_build_dmatable do it too)
+			 * (standard ide_build_dmatable does it too)
 			 */
-			if ((bcount & 0xffff) == 0x0000)
+			if (bcount == 0x10000)
 				bcount = 0x8000;
 			*table++ = bcount & 0xffff;
 			*table++ = cur_addr;
-- 
1.5.6.3

