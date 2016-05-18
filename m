From: Damien Le Moal <Damien.LeMoal@hgst.com>
Subject: [PATCH 2/3] libata-scsi: Fix ZBC management out command translation
Date: Wed, 18 May 2016 00:53:26 +0000
Message-ID: <BL2PR04MB1969643BA42447A6F3F8DB249F490@BL2PR04MB1969.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sjc00mx1.hgst.com ([199.255.44.36]:32459 "EHLO
	sjc00mx1.hgst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcERAx3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 May 2016 20:53:29 -0400
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Hannes Reinecke <hare@suse.com>

The subcommand for NCQ NON-DATA must be specified in
the feature (low byte), not the high-order count byte.
Also, the reset_all variable name is misleading as it
is the "all" bit also applicable to open, close, and
finish actions. So rename that variable and remove
unnecessary mask.

Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
---
  drivers/ata/libata-scsi.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8b375c7..dfb6a10 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3506,7 +3506,7 @@ static unsigned int ata_scsi_zbc_out_xlat(struct 
ata_queued_cmd *qc)
  	struct scsi_cmnd *scmd = qc->scsicmd;
  	struct ata_device *dev = qc->dev;
  	const u8 *cdb = scmd->cmnd;
-	u8 reset_all, sa;
+	u8 all, sa;
  	u64 block;
  	u32 n_block;
  	u16 fp = (u16)-1;
@@ -3533,20 +3533,20 @@ static unsigned int ata_scsi_zbc_out_xlat(struct 
ata_queued_cmd *qc)
  	if (block > dev->n_sectors)
  		goto out_of_range;

-	reset_all = cdb[14] & 0x1;
+	all = cdb[14] & 0x1;

  	if (ata_ncq_enabled(qc->dev) &&
  	    ata_fpdma_zac_mgmt_out_supported(qc->dev)) {
  		tf->protocol = ATA_PROT_NCQ;
  		tf->command = ATA_CMD_NCQ_NON_DATA;
-		tf->hob_nsect = ATA_SUBCMD_NCQ_NON_DATA_ZAC_MGMT_OUT;
+		tf->feature = ATA_SUBCMD_NCQ_NON_DATA_ZAC_MGMT_OUT;
  		tf->nsect = qc->tag << 3;
-		tf->auxiliary = sa | (reset_all & 0x1) << 8;
+		tf->auxiliary = sa | (all << 8);
  	} else {
  		tf->protocol = ATA_PROT_NODATA;
  		tf->command = ATA_CMD_ZAC_MGMT_OUT;
  		tf->feature = sa;
-		tf->hob_feature = reset_all & 0x1;
+		tf->hob_feature = all;
  	}
  	tf->lbah = (block >> 16) & 0xff;
  	tf->lbam = (block >> 8) & 0xff;
-- 
2.5.5


-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Group, HGST Research,
HGST, a Western Digital company
Damien.LeMoal@hgst.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.

