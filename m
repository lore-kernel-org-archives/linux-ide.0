From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 3/5] ide-tape: mv tape->pages_per_stage tape->pages_per_buffer
Date: Sat, 29 Mar 2008 18:46:07 +0100
Message-ID: <1206812769-10065-4-git-send-email-petkovbb@gmail.com>
References: <1206812769-10065-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:50354 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbYC2RqE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 13:46:04 -0400
Received: by ug-out-1314.google.com with SMTP id z38so136812ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 10:45:56 -0700 (PDT)
In-Reply-To: <1206812769-10065-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 7fa0cc0..cf4351c 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -315,8 +315,7 @@ typedef struct ide_tape_obj {
 	char *b_data;
 	int b_count;
 
-	/* Pipeline parameters. */
-	int pages_per_stage;
+	int pages_per_buffer;
 	/* Wasted space in each stage */
 	int excess_bh_size;
 
@@ -1302,7 +1301,7 @@ static idetape_stage_t *ide_tape_kmalloc_buffer(idetape_tape_t *tape, int full,
 {
 	idetape_stage_t *stage;
 	struct idetape_bh *prev_bh, *bh;
-	int pages = tape->pages_per_stage;
+	int pages = tape->pages_per_buffer;
 	unsigned int order, b_allocd;
 	char *b_data = NULL;
 
@@ -2746,9 +2745,9 @@ static void idetape_setup(ide_drive_t *drive, idetape_tape_t *tape, int minor)
 		tape->buffer_size = *ctl * tape->blk_size;
 	}
 	buffer_size = tape->buffer_size;
-	tape->pages_per_stage = buffer_size / PAGE_SIZE;
+	tape->pages_per_buffer = buffer_size / PAGE_SIZE;
 	if (buffer_size % PAGE_SIZE) {
-		tape->pages_per_stage++;
+		tape->pages_per_buffer++;
 		tape->excess_bh_size = PAGE_SIZE - buffer_size % PAGE_SIZE;
 	}
 
-- 
1.5.4.1

