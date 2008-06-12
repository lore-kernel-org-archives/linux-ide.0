From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 15/18] ide-floppy: zero out the whole struct ide_atapi_pc on init
Date: Thu, 12 Jun 2008 08:41:07 +0200
Message-ID: <1213252870-20474-16-git-send-email-petkovbb@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:8685 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbYFLGlK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 02:41:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2381795fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 23:41:09 -0700 (PDT)
In-Reply-To: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

This is a precaution just to make sure a new pc is clean when allocd. There
should be functional change introduced by this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-floppy.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 615d3a3..8ce7513 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -355,9 +355,8 @@ static void idefloppy_init_pc(struct ide_atapi_pc *pc, unsigned char *cmd)
 	if (cmd)
 		memset(cmd, 0, 12);
 
-	pc->retries = 0;
-	pc->flags = 0;
-	pc->req_xfer = 0;
+	memset(pc, 0, sizeof(*pc));
+
 	pc->buf = pc->pc_buf;
 	pc->buf_size = IDEFLOPPY_PC_BUFFER_SIZE;
 	pc->callback = ide_floppy_callback;
-- 
1.5.5.1

