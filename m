From: Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH] ide: fix memory leak when flush command is issued
Date: Thu, 16 Jul 2009 18:32:52 +0200
Message-ID: <1247761972.8418.46.camel@sakura.staff.proxad.net>
Reply-To: mbizon@freebox.fr
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:50998 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932719AbZGPQdC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Jul 2009 12:33:02 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>


Hi David, Bartlomiej

I'm using ide on 2.6.30.1 with xfs filesystem. I noticed a kernel memory
leak after writing lots of data, the kmalloc-96 slab cache keeps
growing. It seems the struct ide_cmd kmalloced by idedisk_prepare_flush
is never kfreed.

Commit a09485df9cda49fbde2766c86eb18a9cae585162 and
f505d49ffd25ed062e76ffd17568d3937fcd338c cause this regression, cmd->rq
must now be set for ide_complete_cmd to honor the IDE_TFLAG_DYN flag.

Candidate for stable I think, thanks !

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 6951811..7f87801 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -455,6 +455,7 @@ static void idedisk_prepare_flush(struct request_queue *q, struct request *rq)
 
 	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 	rq->special = cmd;
+	cmd->rq = rq;
 }
 
 ide_devset_get(multcount, mult_count);


-- 
Maxime


