From: Tao Ma <tao.ma@oracle.com>
Subject: [PATCH] ide: Use kzalloc in idedisk_prepare_flush.
Date: Mon,  2 Aug 2010 17:22:31 +0800
Message-ID: <1280740951-13487-1-git-send-email-tao.ma@oracle.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:28528 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab0HBJX2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Aug 2010 05:23:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, linux-ide@vger.kernel.org, Tao Ma <tao.ma@oracle.com>

Signed-off-by: Tao Ma <tao.ma@oracle.com>
---
 drivers/ide/ide-disk.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 33d6503..127a5a2 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -430,12 +430,11 @@ static void ide_disk_unlock_native_capacity(ide_drive_t *drive)
 static void idedisk_prepare_flush(struct request_queue *q, struct request *rq)
 {
 	ide_drive_t *drive = q->queuedata;
-	struct ide_cmd *cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
+	struct ide_cmd *cmd = kzalloc(sizeof(*cmd), GFP_ATOMIC);
 
 	/* FIXME: map struct ide_taskfile on rq->cmd[] */
 	BUG_ON(cmd == NULL);
 
-	memset(cmd, 0, sizeof(*cmd));
 	if (ata_id_flush_ext_enabled(drive->id) &&
 	    (drive->capacity64 >= (1UL << 28)))
 		cmd->tf.command = ATA_CMD_FLUSH_EXT;
-- 
1.7.1.571.gba4d01

