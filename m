From: "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH] ide: Fix IDE PIO size calculation
Date: Wed, 19 Jun 2013 23:14:27 -0500
Message-ID: <1371701667-3908-1-git-send-email-Steven.Hill@imgtec.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from home.bethel-hill.org ([63.228.164.32]:59622 "EHLO
	home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab3FTEy4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Jun 2013 00:54:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S . Miller" <davem@davemloft.net>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, linux-ide@vger.kernel.org

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

IDE PIO calculates the size wrong when passing the parameter
"ide-core.nodma=0.0" to the kernel.

Change-Id: Id82c2bc5965d85960846db53d84846d9a05d75a3
Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 drivers/ide/ide-taskfile.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 729428e..dabb88b 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -239,9 +239,6 @@ void ide_pio_bytes(ide_drive_t *drive, struct ide_cmd *cmd,
 		unsigned nr_bytes = min(len, cursg->length - cmd->cursg_ofs);
 		int page_is_high;
 
-		if (nr_bytes > PAGE_SIZE)
-			nr_bytes = PAGE_SIZE;
-
 		page = sg_page(cursg);
 		offset = cursg->offset + cmd->cursg_ofs;
 
@@ -249,6 +246,8 @@ void ide_pio_bytes(ide_drive_t *drive, struct ide_cmd *cmd,
 		page = nth_page(page, (offset >> PAGE_SHIFT));
 		offset %= PAGE_SIZE;
 
+		nr_bytes = min_t(unsigned, nr_bytes, (PAGE_SIZE - offset));
+
 		page_is_high = PageHighMem(page);
 		if (page_is_high)
 			local_irq_save(flags);
-- 
1.7.2.5

