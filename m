From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 01/14] ide-tape: fix potential fs requests bug
Date: Sat,  9 May 2009 09:45:21 +0200
Message-ID: <1241855134-4984-2-git-send-email-petkovbb@gmail.com>
References: <1241855134-4984-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63017 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbZEIHph (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 May 2009 03:45:37 -0400
In-Reply-To: <1241855134-4984-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

ide-tape had a potential bug for fs requests when preparing the command
packet: it was writing the transfer length as a number of fixed blocks.
However, the block layer implies 512 byte blocks and ide-tape can have
other block sizes so account for that too.

ide-floppy does this calculation properly with the block size factor
(floppy->bs_factor).

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index e166045..fc79cf4 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -586,7 +586,7 @@ static void ide_tape_create_rw_cmd(idetape_tape_t *tape,
 				   struct ide_atapi_pc *pc, struct request *rq,
 				   u8 opcode)
 {
-	unsigned int length = blk_rq_sectors(rq);
+	unsigned int length = blk_rq_sectors(rq) / (tape->blk_size >> 9);
 
 	ide_init_pc(pc);
 	put_unaligned(cpu_to_be32(length), (unsigned int *) &pc->c[1]);
-- 
1.6.2.4

