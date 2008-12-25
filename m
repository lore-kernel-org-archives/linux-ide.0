From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH] tx4939ide: Do not use zero count PRD entry
Date: Thu, 25 Dec 2008 23:32:37 +0900
Message-ID: <1230215558-9197-1-git-send-email-anemo@mba.ocn.ne.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:61382 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbYLYOcn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Dec 2008 09:32:43 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, sshtylyov@ru.mvista.com, linux-mips@linux-mips.org, stable <stable@kernel.org>

This fixes data corruption on some heavy load.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: stable <stable@kernel.org>
---
 drivers/ide/tx4939ide.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
index bafb7d1..30d0d25 100644
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -259,6 +259,12 @@ static int tx4939ide_build_dmatable(ide_drive_t *drive, struct request *rq)
 			bcount = 0x10000 - (cur_addr & 0xffff);
 			if (bcount > cur_len)
 				bcount = cur_len;
+			/*
+			 * This workaround for zero count seems required.
+			 * (standard ide_build_dmatable do it too)
+			 */
+			if ((bcount & 0xffff) == 0x0000)
+				bcount = 0x8000;
 			*table++ = bcount & 0xffff;
 			*table++ = cur_addr;
 			cur_addr += bcount;
-- 
1.5.6.3

