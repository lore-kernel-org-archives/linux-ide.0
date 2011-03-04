From: hare@suse.de (Hannes Reinecke)
Subject: [PATCH] libata: Include WWN ID in inquiry VPD emulation
Date: Fri, 04 Mar 2011 09:55:01 +0100
Message-ID: <20110304085501.8B331F90E1@ochil.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:37199 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754237Ab1CDIpG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Mar 2011 03:45:06 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org


As per SAT-3 the WWN ID should be included in the VPD page 0x83
(device identification) emulation.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-scsi.c |   11 +++++++++++
 include/linux/ata.h       |    9 +++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 600f635..e60d9e4 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2056,6 +2056,17 @@ static unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf)
 		      ATA_ID_SERNO_LEN);
 	num += ATA_ID_SERNO_LEN;
 
+	if (ata_id_has_wwn(args->id)) {
+		/* SAT defined lu world wide name */
+		/* piv=0, assoc=lu, code_set=binary, designator=NAA */
+		rbuf[num + 0] = 1;
+		rbuf[num + 1] = 3;
+		rbuf[num + 3] = ATA_ID_WWN_LEN;
+		num += 4;
+		ata_id_string(args->id, (unsigned char *) rbuf + num,
+			      ATA_ID_WWN, ATA_ID_WWN_LEN);
+		num += ATA_ID_WWN_LEN;
+	}
 	rbuf[3] = num - 4;    /* page len (assume less than 256 bytes) */
 	return 0;
 }
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 0c4929f..f62463e 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -89,6 +89,7 @@ enum {
 	ATA_ID_SPG		= 98,
 	ATA_ID_LBA_CAPACITY_2	= 100,
 	ATA_ID_SECTOR_SIZE	= 106,
+	ATA_ID_WWN		= 108,
 	ATA_ID_LOGICAL_SECTOR_SIZE	= 117,	/* and 118 */
 	ATA_ID_LAST_LUN		= 126,
 	ATA_ID_DLF		= 128,
@@ -103,6 +104,7 @@ enum {
 	ATA_ID_SERNO_LEN	= 20,
 	ATA_ID_FW_REV_LEN	= 8,
 	ATA_ID_PROD_LEN		= 40,
+	ATA_ID_WWN_LEN		= 8,
 
 	ATA_PCI_CTL_OFS		= 2,
 
@@ -815,6 +817,13 @@ static inline int ata_id_has_unload(const u16 *id)
 	return 0;
 }
 
+static inline int ata_id_has_wwn(const u16 *id)
+{
+	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
+		return 0;
+	return id[ATA_ID_CSF_DEFAULT] & (1 << 8);
+}
+
 static inline int ata_id_form_factor(const u16 *id)
 {
 	u16 val = id[168];
-- 
1.6.0.2

