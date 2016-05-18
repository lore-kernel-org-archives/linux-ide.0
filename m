From: Damien Le Moal <Damien.LeMoal@hgst.com>
Subject: [PATCH 1/3] libata-scsi: Fix translation of REPORT ZONES command
Date: Wed, 18 May 2016 00:53:18 +0000
Message-ID: <BL2PR04MB19693FF61F004AA64A6541BC9F490@BL2PR04MB1969.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sjc00mx1.hgst.com ([199.255.44.36]:43885 "EHLO
	sjc00mx1.hgst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcERAxV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 May 2016 20:53:21 -0400
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Hannes Reinecke <hare@suse.com>

Set reporting options when translating REPORT ZONES
commmand to ATA NCQ.

Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
---
  drivers/ata/libata-scsi.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b86af14..8b375c7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3454,7 +3454,7 @@ static unsigned int ata_scsi_zbc_in_xlat(struct 
ata_queued_cmd *qc)
  		goto invalid_param_len;
  	}
  	sect = n_block / 512;
-	options = cdb[14];
+	options = cdb[14] & 0xbf;

  	if (ata_ncq_enabled(qc->dev) &&
  	    ata_fpdma_zac_mgmt_in_supported(qc->dev)) {
@@ -3464,7 +3464,7 @@ static unsigned int ata_scsi_zbc_in_xlat(struct 
ata_queued_cmd *qc)
  		tf->nsect = qc->tag << 3;
  		tf->feature = sect & 0xff;
  		tf->hob_feature = (sect >> 8) & 0xff;
-		tf->auxiliary = ATA_SUBCMD_ZAC_MGMT_IN_REPORT_ZONES;
+		tf->auxiliary = ATA_SUBCMD_ZAC_MGMT_IN_REPORT_ZONES | (options << 8);
  	} else {
  		tf->command = ATA_CMD_ZAC_MGMT_IN;
  		tf->feature = ATA_SUBCMD_ZAC_MGMT_IN_REPORT_ZONES;
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

