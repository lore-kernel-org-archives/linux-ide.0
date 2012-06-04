From: Jeffrin Jose <ahiliation@yahoo.co.in>
Subject: [PATCH]ata:fixed coding style issues related to braces
Date: Tue,  5 Jun 2012 01:33:37 +0530
Message-ID: <1338840217-4027-1-git-send-email-ahiliation@yahoo.co.in>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm29-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.236]:46243 "HELO
	nm29-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751406Ab2FDT7x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jun 2012 15:59:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, ahiliation@yahoo.co.in

Fixed coding style issues related to braces found
by checkpatch.pl in drivers/ata/ahci.c

Signed-off-by: Jeffrin Jose <ahiliation@yahoo.co.in>
---
 drivers/ata/ahci.c |   33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ebaf67e..c744a9f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -105,31 +105,27 @@ static struct ata_port_operations ahci_p5wdh_ops = {
 
 static const struct ata_port_info ahci_port_info[] = {
 	/* by features */
-	[board_ahci] =
-	{
+	[board_ahci] = {
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_ign_iferr] =
-	{
+	[board_ahci_ign_iferr] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_nosntf] =
-	{
+	[board_ahci_nosntf] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_SNTF),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_yes_fbs] =
-	{
+	[board_ahci_yes_fbs] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_YES_FBS),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
@@ -137,8 +133,7 @@ static const struct ata_port_info ahci_port_info[] = {
 		.port_ops	= &ahci_ops,
 	},
 	/* by chipsets */
-	[board_ahci_mcp65] =
-	{
+	[board_ahci_mcp65] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_FPDMA_AA | AHCI_HFLAG_NO_PMP |
 				 AHCI_HFLAG_YES_NCQ),
 		.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
@@ -146,24 +141,21 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_mcp77] =
-	{
+	[board_ahci_mcp77] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_FPDMA_AA | AHCI_HFLAG_NO_PMP),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_mcp89] =
-	{
+	[board_ahci_mcp89] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_FPDMA_AA),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_mv] =
-	{
+	[board_ahci_mv] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_MSI |
 				 AHCI_HFLAG_MV_PATA | AHCI_HFLAG_NO_PMP),
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA,
@@ -171,8 +163,7 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_sb600] =
-	{
+	[board_ahci_sb600] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
 				 AHCI_HFLAG_NO_MSI | AHCI_HFLAG_SECT255 |
 				 AHCI_HFLAG_32BIT_ONLY),
@@ -181,16 +172,14 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_pmp_retry_srst_ops,
 	},
-	[board_ahci_sb700] =	/* for SB700 and SB800 */
-	{
+	[board_ahci_sb700] = {	/* for SB700 and SB800 */
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_pmp_retry_srst_ops,
 	},
-	[board_ahci_vt8251] =
-	{
+	[board_ahci_vt8251] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_PMP),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
-- 
1.7.10

