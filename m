From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] ata_piix: clean up port flags
Date: Fri, 10 Nov 2006 18:08:10 +0900
Message-ID: <11631496901309-git-send-email-htejun@gmail.com>
References: <11631496893280-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.204]:41236 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1946096AbWKJJIR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Nov 2006 04:08:17 -0500
Received: by nz-out-0102.google.com with SMTP id l1so257955nzf
        for <linux-ide@vger.kernel.org>; Fri, 10 Nov 2006 01:08:17 -0800 (PST)
In-Reply-To: <11631496893280-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* move common flags into PIIX_PATA_FLAGS and PIIX_SATA_FLAGS
* kill unnecessary ATA_FLAG_SRST
---
 drivers/ata/ata_piix.c |   31 ++++++++++++++-----------------
 1 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 14b726b..90ac33a 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -106,6 +106,9 @@ enum {
 	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
 
+	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS,
+	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
+
 	/* combined mode.  if set, PATA is channel 0.
 	 * if clear, PATA is channel 1.
 	 */
@@ -438,7 +441,7 @@ static struct ata_port_info piix_port_in
 	/* piix_pata_33: 0:  PIIX3 or 4 at 33MHz */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags		= PIIX_PATA_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x06, /* mwdma1-2 ?? CHECK 0 should be ok but slow */
 		.udma_mask	= ATA_UDMA_MASK_40C,
@@ -448,7 +451,7 @@ static struct ata_port_info piix_port_in
 	/* ich_pata_33: 1 	ICH0 - ICH at 33Mhz*/
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SRST | ATA_FLAG_SLAVE_POSS,
+		.flags		= PIIX_PATA_FLAGS,
 		.pio_mask 	= 0x1f,	/* pio 0-4 */
 		.mwdma_mask	= 0x06, /* Check: maybe 0x07  */
 		.udma_mask	= ATA_UDMA2, /* UDMA33 */
@@ -457,7 +460,7 @@ static struct ata_port_info piix_port_in
 	/* ich_pata_66: 2 	ICH controllers up to 66MHz */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SRST | ATA_FLAG_SLAVE_POSS,
+		.flags		= PIIX_PATA_FLAGS,
 		.pio_mask 	= 0x1f,	/* pio 0-4 */
 		.mwdma_mask	= 0x06, /* MWDMA0 is broken on chip */
 		.udma_mask	= ATA_UDMA4,
@@ -467,7 +470,7 @@ static struct ata_port_info piix_port_in
 	/* ich_pata_100: 3 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SRST | ATA_FLAG_SLAVE_POSS | PIIX_FLAG_CHECKINTR,
+		.flags		= PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x06, /* mwdma1-2 */
 		.udma_mask	= ATA_UDMA5, /* udma0-5 */
@@ -477,7 +480,7 @@ static struct ata_port_info piix_port_in
 	/* ich_pata_133: 4 	ICH with full UDMA6 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SRST | ATA_FLAG_SLAVE_POSS | PIIX_FLAG_CHECKINTR,
+		.flags		= PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
 		.pio_mask 	= 0x1f,	/* pio 0-4 */
 		.mwdma_mask	= 0x06, /* Check: maybe 0x07  */
 		.udma_mask	= ATA_UDMA6, /* UDMA133 */
@@ -487,8 +490,7 @@ static struct ata_port_info piix_port_in
 	/* ich5_sata: 5 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR |
-				  PIIX_FLAG_IGNORE_PCS,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_IGNORE_PCS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -498,8 +500,7 @@ static struct ata_port_info piix_port_in
 	/* i6300esb_sata: 6 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_IGNORE_PCS,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_IGNORE_PCS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -509,8 +510,7 @@ static struct ata_port_info piix_port_in
 	/* ich6_sata: 7 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -520,8 +520,7 @@ static struct ata_port_info piix_port_in
 	/* ich6_sata_ahci: 8 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
 				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -532,8 +531,7 @@ static struct ata_port_info piix_port_in
 	/* ich6m_sata_ahci: 9 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
 				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -544,8 +542,7 @@ static struct ata_port_info piix_port_in
 	/* ich8_sata_ahci: 10 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
 				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
-- 
1.4.3.3


