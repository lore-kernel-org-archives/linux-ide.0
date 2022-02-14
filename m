Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC3FC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 14 Feb 2022 21:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiBNVKJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Feb 2022 16:10:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiBNVKJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Feb 2022 16:10:09 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED7B7D2A2
        for <linux-ide@vger.kernel.org>; Mon, 14 Feb 2022 13:09:59 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 5952220669A3
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-scsi: use *switch* statements to check SCSI
 command codes
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <7440bd27-b841-c3f0-2b47-4ab3f0ac0c83@omp.ru>
Date:   Mon, 14 Feb 2022 23:14:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Replace strings of the *if* statements checking the SCSI command code
with the *switch* statements that fit better here...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
repo.

 drivers/ata/libata-scsi.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

Index: libata/drivers/ata/libata-scsi.c
===================================================================
--- libata.orig/drivers/ata/libata-scsi.c
+++ libata/drivers/ata/libata-scsi.c
@@ -1362,19 +1362,22 @@ static unsigned int ata_scsi_verify_xlat
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->protocol = ATA_PROT_NODATA;
 
-	if (cdb[0] == VERIFY) {
+	switch (cdb[0]) {
+	case VERIFY:
 		if (scmd->cmd_len < 10) {
 			fp = 9;
 			goto invalid_fld;
 		}
 		scsi_10_lba_len(cdb, &block, &n_block);
-	} else if (cdb[0] == VERIFY_16) {
+		break;
+	case VERIFY_16:
 		if (scmd->cmd_len < 16) {
 			fp = 15;
 			goto invalid_fld;
 		}
 		scsi_16_lba_len(cdb, &block, &n_block);
-	} else {
+		break;
+	default:
 		fp = 0;
 		goto invalid_fld;
 	}
@@ -1506,8 +1509,13 @@ static unsigned int ata_scsi_rw_xlat(str
 	int rc;
 	u16 fp = 0;
 
-	if (cdb[0] == WRITE_10 || cdb[0] == WRITE_6 || cdb[0] == WRITE_16)
+	switch (cdb[0]) {
+	case WRITE_6:
+	case WRITE_10:
+	case WRITE_16:
 		tf_flags |= ATA_TFLAG_WRITE;
+		break;
+	}
 
 	/* Calculate the SCSI LBA, transfer length and FUA. */
 	switch (cdb[0]) {
@@ -2817,7 +2825,8 @@ static unsigned int ata_scsi_pass_thru(s
 	 * 12 and 16 byte CDBs use different offsets to
 	 * provide the various register values.
 	 */
-	if (cdb[0] == ATA_16) {
+	switch (cdb[0]) {
+	case ATA_16:
 		/*
 		 * 16-byte CDB - may contain extended commands.
 		 *
@@ -2843,7 +2852,8 @@ static unsigned int ata_scsi_pass_thru(s
 		tf->lbah = cdb[12];
 		tf->device = cdb[13];
 		tf->command = cdb[14];
-	} else if (cdb[0] == ATA_12) {
+		break;
+	case ATA_12:
 		/*
 		 * 12-byte CDB - incapable of extended commands.
 		 */
@@ -2856,7 +2866,8 @@ static unsigned int ata_scsi_pass_thru(s
 		tf->lbah = cdb[7];
 		tf->device = cdb[8];
 		tf->command = cdb[9];
-	} else {
+		break;
+	default:
 		/*
 		 * 32-byte CDB - may contain extended command fields.
 		 *
@@ -2880,6 +2891,7 @@ static unsigned int ata_scsi_pass_thru(s
 		tf->device = cdb[24];
 		tf->command = cdb[25];
 		tf->auxiliary = get_unaligned_be32(&cdb[28]);
+		break;
 	}
 
 	/* For NCQ commands copy the tag value */
