From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/3] ide-tape: fix potential fs requests bug
Date: Fri,  1 May 2009 22:14:22 +0200
Message-ID: <1241208864-23421-2-git-send-email-petkovbb@gmail.com>
References: <1241208864-23421-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:45816 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbZEAUO3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 May 2009 16:14:29 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1237627fkq.5
        for <linux-ide@vger.kernel.org>; Fri, 01 May 2009 13:14:28 -0700 (PDT)
In-Reply-To: <1241208864-23421-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org

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

