From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 15/22] ide-tape: remove unused "length" arg from idetape_create_read_buffer_cmd()
Date: Mon,  4 Feb 2008 14:40:33 +0100
Message-ID: <1202132440-26648-16-git-send-email-petkovbb@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:30309 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756146AbYBDNmt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 08:42:49 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1495433wra.23
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 05:42:49 -0800 (PST)
In-Reply-To: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index a80f8d9..342ec50 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1468,7 +1468,8 @@ static void idetape_create_read_cmd(idetape_tape_t *tape, idetape_pc_t *pc, unsi
 		pc->flags |= PC_FL_DMA_RECOMMENDED;
 }
 
-static void idetape_create_read_buffer_cmd(idetape_tape_t *tape, idetape_pc_t *pc, unsigned int length, struct idetape_bh *bh)
+static void idetape_create_read_buffer_cmd(idetape_tape_t *tape,
+		idetape_pc_t *pc, struct idetape_bh *bh)
 {
 	int size = 32768;
 	struct idetape_bh *p = bh;
@@ -1486,7 +1487,8 @@ static void idetape_create_read_buffer_cmd(idetape_tape_t *tape, idetape_pc_t *p
 		atomic_set(&p->b_count, 0);
 		p = p->b_reqnext;
 	}
-	pc->request_transfer = pc->buffer_size = size;
+	pc->request_transfer = size;
+	pc->buffer_size = size;
 }
 
 static void idetape_create_write_cmd(idetape_tape_t *tape, idetape_pc_t *pc, unsigned int length, struct idetape_bh *bh)
@@ -1607,7 +1609,7 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
 		if (!pc)
 			goto err;
 
-		idetape_create_read_buffer_cmd(tape, pc, rq->current_nr_sectors,
+		idetape_create_read_buffer_cmd(tape, pc,
 				(struct idetape_bh *)rq->special);
 		goto out;
 	}
-- 
1.5.3.7

