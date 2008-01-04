From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] ata_piix: kill unused constants and flags
Date: Fri,  4 Jan 2008 18:42:20 +0900
Message-ID: <11994397441617-git-send-email-htejun@gmail.com>
References: <1199439744356-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:58718 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756481AbYADJmc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 04:42:32 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6064376rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 01:42:31 -0800 (PST)
In-Reply-To: <1199439744356-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, torvalds@linux-foundation.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Kill PIIX_FLAG_SCR, PIIX_PORT_ENABLED and PIIX_PORT_PRESENT.  These
are unused.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c |   27 +++++++--------------------
 1 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 3ddbf8b..017422c 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -102,19 +102,12 @@ enum {
 	ICH5_PCS		= 0x92,	/* port control and status */
 	PIIX_SCC		= 0x0A, /* sub-class code register */
 
-	PIIX_FLAG_SCR		= (1 << 26), /* SCR available */
 	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
 
 	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS,
 	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
 
-	/* combined mode.  if set, PATA is channel 0.
-	 * if clear, PATA is channel 1.
-	 */
-	PIIX_PORT_ENABLED	= (1 << 0),
-	PIIX_PORT_PRESENT	= (1 << 4),
-
 	PIIX_80C_PRI		= (1 << 5) | (1 << 4),
 	PIIX_80C_SEC		= (1 << 7) | (1 << 6),
 
@@ -552,7 +545,7 @@ static struct ata_port_info piix_port_info[] = {
 	[ich6_sata] =
 	{
 		.sht		= &piix_sht,
-		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR,
+		.flags		= PIIX_SATA_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6,
@@ -562,8 +555,7 @@ static struct ata_port_info piix_port_info[] = {
 	[ich6_sata_ahci] =
 	{
 		.sht		= &piix_sht,
-		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
-				  PIIX_FLAG_AHCI,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6,
@@ -573,8 +565,7 @@ static struct ata_port_info piix_port_info[] = {
 	[ich6m_sata_ahci] =
 	{
 		.sht		= &piix_sht,
-		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
-				  PIIX_FLAG_AHCI,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6,
@@ -584,8 +575,7 @@ static struct ata_port_info piix_port_info[] = {
 	[ich8_sata_ahci] =
 	{
 		.sht		= &piix_sht,
-		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
-				  PIIX_FLAG_AHCI,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6,
@@ -595,8 +585,7 @@ static struct ata_port_info piix_port_info[] = {
 	[ich8_2port_sata] =
 	{
 		.sht		= &piix_sht,
-		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
-				  PIIX_FLAG_AHCI,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6,
@@ -606,8 +595,7 @@ static struct ata_port_info piix_port_info[] = {
 	[tolapai_sata_ahci] =
 	{
 		.sht		= &piix_sht,
-		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
-				  PIIX_FLAG_AHCI,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6,
@@ -617,8 +605,7 @@ static struct ata_port_info piix_port_info[] = {
 	[ich8m_apple_sata_ahci] =
 	{
 		.sht		= &piix_sht,
-		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
-				  PIIX_FLAG_AHCI,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6,
-- 
1.5.2.4

