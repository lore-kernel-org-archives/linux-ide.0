From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/6] libata: don't call ata_scsi_rbuf_fill for command without a response buffer
Date: Tue, 10 Jan 2017 09:41:47 +0100
Message-ID: <1484037708-654-6-git-send-email-hch@lst.de>
References: <1484037708-654-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36398 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030266AbdAJImK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2017 03:42:10 -0500
In-Reply-To: <1484037708-654-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: geert@linux-m68k.org, linux-ide@vger.kernel.org

No need to copy a zeroed buffer to the caller if the command is defined
to not have a response in the SCSI spec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-scsi.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 6078bc2..395c859 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2453,23 +2453,6 @@ static unsigned int ata_scsiop_inq_b6(struct ata_scsi_args *args, u8 *rbuf)
 }
 
 /**
- *	ata_scsiop_noop - Command handler that simply returns success.
- *	@args: device IDENTIFY data / SCSI command of interest.
- *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
- *
- *	No operation.  Simply returns success to caller, to indicate
- *	that the caller should successfully complete this SCSI command.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-static unsigned int ata_scsiop_noop(struct ata_scsi_args *args, u8 *rbuf)
-{
-	VPRINTK("ENTER\n");
-	return 0;
-}
-
-/**
  *	modecpy - Prepare response for MODE SENSE
  *	@dest: output buffer
  *	@src: data being copied
@@ -4425,14 +4408,11 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 	case SEEK_6:
 	case SEEK_10:
 	case TEST_UNIT_READY:
-		ata_scsi_rbuf_fill(&args, ata_scsiop_noop);
 		break;
 
 	case SEND_DIAGNOSTIC:
 		tmp8 = scsicmd[1] & ~(1 << 3);
-		if ((tmp8 == 0x4) && (!scsicmd[3]) && (!scsicmd[4]))
-			ata_scsi_rbuf_fill(&args, ata_scsiop_noop);
-		else
+		if (tmp8 != 0x4 || scsicmd[3] || scsicmd[4])
 			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
 		break;
 
-- 
2.1.4

