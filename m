From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/6] libata: remove the done allback from ata_scsi_args
Date: Tue, 10 Jan 2017 09:41:45 +0100
Message-ID: <1484037708-654-4-git-send-email-hch@lst.de>
References: <1484037708-654-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030266AbdAJImD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2017 03:42:03 -0500
In-Reply-To: <1484037708-654-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: geert@linux-m68k.org, linux-ide@vger.kernel.org

It's always the scsi_done callback, and we can get at that easily
in the place where ->done is called.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-scsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 43694f5..28e2530 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2061,7 +2061,6 @@ struct ata_scsi_args {
 	struct ata_device	*dev;
 	u16			*id;
 	struct scsi_cmnd	*cmd;
-	void			(*done)(struct scsi_cmnd *);
 };
 
 /**
@@ -2140,7 +2139,7 @@ static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
 
 	if (rc == 0)
 		cmd->result = SAM_STAT_GOOD;
-	args->done(cmd);
+	cmd->scsi_done(cmd);
 }
 
 /**
@@ -4357,7 +4356,6 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 	args.dev = dev;
 	args.id = dev->id;
 	args.cmd = cmd;
-	args.done = cmd->scsi_done;
 
 	switch(scsicmd[0]) {
 	case INQUIRY:
-- 
2.1.4

