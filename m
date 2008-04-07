From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 6/6] ide-tape: fix mem leak
Date: Mon,  7 Apr 2008 06:45:04 +0200
Message-ID: <1207543504-27888-7-git-send-email-petkovbb@gmail.com>
References: <1207543504-27888-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:44746 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbYDGEow (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2008 00:44:52 -0400
Received: by fk-out-0910.google.com with SMTP id 19so1749561fkr.5
        for <linux-ide@vger.kernel.org>; Sun, 06 Apr 2008 21:44:51 -0700 (PDT)
In-Reply-To: <1207543504-27888-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On failed struct idetape_bh allocation the logic frees only one buffer page
which was the old page-wise strategy. Doing that now would probably leak
2^order-1 pages so fix it to free all and not only the first buffer page.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 78a76a0..29870c4 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1348,7 +1348,7 @@ static struct idetape_bh *ide_tape_kmalloc_buffer(idetape_tape_t *tape,
 		prev_bh = bh;
 		bh = kmalloc(sizeof(struct idetape_bh), GFP_KERNEL);
 		if (!bh) {
-			free_page((unsigned long) b_data);
+			free_pages((unsigned long) b_data, order);
 			goto abort;
 		}
 		bh->b_reqnext = NULL;
-- 
1.5.4.1

