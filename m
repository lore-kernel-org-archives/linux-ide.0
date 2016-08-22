From: Shaun Tancheff <shaun@tancheff.com>
Subject: [PATCH v6 4/4] SCT Write Same handle ATA_DFLAG_PIO
Date: Sun, 21 Aug 2016 23:23:21 -0500
Message-ID: <20160822042321.24367-5-shaun@tancheff.com>
References: <20160822042321.24367-1-shaun@tancheff.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33758 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbcHVEZK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2016 00:25:10 -0400
In-Reply-To: <20160822042321.24367-1-shaun@tancheff.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shaun Tancheff <shaun@tancheff.com>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, Tom Yan <tom.ty89@gmail.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>, Shaun Tancheff <shaun.tancheff@seagate.com>

Use non DMA write log when ATA_DFLAG_PIO is set.

Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
---
v6: Added check for ATA_DFLAG_PIO and fallback to non DMA write log for
    SCT Write Same

 drivers/ata/libata-scsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 37f456e..e50b7a7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3485,6 +3485,8 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 		tf->device = ATA_CMD_STANDBYNOW1;
 		tf->protocol = ATA_PROT_DMA;
 		tf->command = ATA_CMD_WRITE_LOG_DMA_EXT;
+		if (unlikely(dev->flags & ATA_DFLAG_PIO))
+			tf->command = ATA_CMD_WRITE_LOG_EXT;
 	}
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48 |
-- 
2.9.3

