From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 2/8] ide: use get_unaligned_* helpers
Date: Thu, 01 May 2008 20:52:55 -0700
Message-ID: <1209700376.22362.17.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:48822 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193AbYEBDwf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 May 2008 23:52:35 -0400
Received: by wa-out-1112.google.com with SMTP id j37so54231waf.23
        for <linux-ide@vger.kernel.org>; Thu, 01 May 2008 20:52:35 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ide/ide-tape.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 1e1f263..d285da5 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -538,7 +538,7 @@ static void idetape_analyze_error(ide_drive_t *drive, u8 *sense)
 	if (pc->flags & PC_FLAG_DMA_ERROR) {
 		pc->xferred = pc->req_xfer -
 			tape->blk_size *
-			be32_to_cpu(get_unaligned((u32 *)&sense[3]));
+			get_unaligned_be32(&sense[3]);
 		idetape_update_buffers(pc);
 	}
 
-- 
1.5.5.1.350.gbbbf


