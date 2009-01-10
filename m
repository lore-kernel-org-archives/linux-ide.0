From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH] tx4938ide: Fix build error due to read_sff_dma_status moving
Date: Sun, 11 Jan 2009 02:20:19 +0900
Message-ID: <1231608019-28679-1-git-send-email-anemo@mba.ocn.ne.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:54504 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752204AbZAJRUU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jan 2009 12:20:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, sshtylyov@ru.mvista.com

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/ide/tx4938ide.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
index b4ef218..d909534 100644
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -202,7 +202,6 @@ static const struct ide_tp_ops tx4938ide_tp_ops = {
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-	.read_sff_dma_status	= ide_read_sff_dma_status,
 
 	.set_irq		= ide_set_irq,
 
-- 
1.5.6.3

