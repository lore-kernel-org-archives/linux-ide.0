From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/6] libata: call ->scsi_done from ata_scsi_simulate
Date: Tue, 10 Jan 2017 09:41:46 +0100
Message-ID: <1484037708-654-5-git-send-email-hch@lst.de>
References: <1484037708-654-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030266AbdAJImH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2017 03:42:07 -0500
In-Reply-To: <1484037708-654-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: geert@linux-m68k.org, linux-ide@vger.kernel.org

We always need to call ->scsi_done after we've finished emulating a
command, so do it in a single place at the end of ata_scsi_simulate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-scsi.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 28e2530..6078bc2 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -484,13 +484,6 @@ struct device_attribute *ata_common_sdev_attrs[] = {
 };
 EXPORT_SYMBOL_GPL(ata_common_sdev_attrs);
 
-static void ata_scsi_invalid_field(struct ata_device *dev,
-				   struct scsi_cmnd *cmd, u16 field)
-{
-	ata_scsi_set_invalid_field(dev, cmd, field, 0xff);
-	cmd->scsi_done(cmd);
-}
-
 /**
  *	ata_std_bios_param - generic bios head/sector/cylinder calculator used by sd.
  *	@sdev: SCSI device for which BIOS geometry is to be determined
@@ -2139,7 +2132,6 @@ static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
 
 	if (rc == 0)
 		cmd->result = SAM_STAT_GOOD;
-	cmd->scsi_done(cmd);
 }
 
 /**
@@ -4360,7 +4352,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 	switch(scsicmd[0]) {
 	case INQUIRY:
 		if (scsicmd[1] & 2)		   /* is CmdDt set?  */
-		    ata_scsi_invalid_field(dev, cmd, 1);
+			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
 		else if ((scsicmd[1] & 1) == 0)    /* is EVPD clear? */
 			ata_scsi_rbuf_fill(&args, ata_scsiop_inq_std);
 		else switch (scsicmd[2]) {
@@ -4392,7 +4384,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 			}
 			/* Fallthrough */
 		default:
-			ata_scsi_invalid_field(dev, cmd, 2);
+			ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
 			break;
 		}
 		break;
@@ -4410,7 +4402,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 		if ((scsicmd[1] & 0x1f) == SAI_READ_CAPACITY_16)
 			ata_scsi_rbuf_fill(&args, ata_scsiop_read_cap);
 		else
-			ata_scsi_invalid_field(dev, cmd, 1);
+			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
 		break;
 
 	case REPORT_LUNS:
@@ -4420,7 +4412,6 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 	case REQUEST_SENSE:
 		ata_scsi_set_sense(dev, cmd, 0, 0, 0);
 		cmd->result = (DRIVER_SENSE << 24);
-		cmd->scsi_done(cmd);
 		break;
 
 	/* if we reach this, then writeback caching is disabled,
@@ -4442,23 +4433,24 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 		if ((tmp8 == 0x4) && (!scsicmd[3]) && (!scsicmd[4]))
 			ata_scsi_rbuf_fill(&args, ata_scsiop_noop);
 		else
-			ata_scsi_invalid_field(dev, cmd, 1);
+			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
 		break;
 
 	case MAINTENANCE_IN:
 		if (scsicmd[1] == MI_REPORT_SUPPORTED_OPERATION_CODES)
 			ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
 		else
-			ata_scsi_invalid_field(dev, cmd, 1);
+			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
 		break;
 
 	/* all other commands */
 	default:
 		ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST, 0x20, 0x0);
 		/* "Invalid command operation code" */
-		cmd->scsi_done(cmd);
 		break;
 	}
+
+	cmd->scsi_done(cmd);
 }
 
 int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
-- 
2.1.4

