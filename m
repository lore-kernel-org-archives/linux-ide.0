From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] ide-disk: Fix request requeuing
Date: Fri, 30 Sep 2011 08:45:32 +0200
Message-ID: <1317365132-9422-1-git-send-email-bp@alien8.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:37613 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756945Ab1I3Gpg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Sep 2011 02:45:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Simon Kirby <sim@hostway.ca>, David Miller <davem@davemloft.net>, Borislav Petkov <bp@alien8.de>

Simon Kirby reported that on his RAID setup with idedisk underneath
the box OOMs after a couple of days of runtime. Running with
CONFIG_DEBUG_KMEMLEAK pointed to idedisk_prep_fn() which unconditionally
allocates an ide_cmd struct. However, ide_requeue_and_plug() can be
called more than once per request, either from the request issue or the
IRQ handler path and do blk_peek_request() ends up in idedisk_prep_fn()
repeatedly, allocating a struct ide_cmd everytime and "forgetting" the
previous pointer.

Make sure the code reuses the old allocated chunk.

Reported-and-tested-by: Simon Kirby <sim@hostway.ca>
Cc: <stable@kernel.org> [ 39.x, 3.0.x ]
Link: http://marc.info/?l=linux-kernel&m=131667641517919
Link: http://lkml.kernel.org/r/20110922072643.GA27232@hostway.ca
Signed-off-by: Borislav Petkov <bp@alien8.de>
---
 drivers/ide/ide-disk.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 274798068a54..16f69be820c7 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -435,7 +435,12 @@ static int idedisk_prep_fn(struct request_queue *q, struct request *rq)
 	if (!(rq->cmd_flags & REQ_FLUSH))
 		return BLKPREP_OK;
 
-	cmd = kzalloc(sizeof(*cmd), GFP_ATOMIC);
+	if (rq->special) {
+		cmd = rq->special;
+		memset(cmd, 0, sizeof(*cmd));
+	} else {
+		cmd = kzalloc(sizeof(*cmd), GFP_ATOMIC);
+	}
 
 	/* FIXME: map struct ide_taskfile on rq->cmd[] */
 	BUG_ON(cmd == NULL);
-- 
1.7.5.3.401.gfb674

