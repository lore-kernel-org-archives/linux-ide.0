From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/6] ata_piix: clean up port flags
Date: Sat, 30 Sep 2006 15:46:49 +0900
Message-ID: <1159598809262-git-send-email-htejun@gmail.com>
References: <11595988092938-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:42834 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751091AbWI3GrB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 02:47:01 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1150186nfa
        for <linux-ide@vger.kernel.org>; Fri, 29 Sep 2006 23:47:00 -0700 (PDT)
In-Reply-To: <11595988092938-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: nabiki@teleline.es, kaos@ocs.com.au, stevenm@umd.edu, jfs@keytradebank.com, 0602@eq.cz, jgarzik@pobox.com, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* move common flags into PIIX_PATA_FLAGS and PIIX_SATA_FLAGS
* kill unnecessary ATA_FLAG_SRST

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c |   34 +++++++++++++++-------------------
 1 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 5719704..cdb99dc 100644
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
@@ -453,7 +456,7 @@ static struct ata_port_info piix_port_in
 	/* piix_pata_33: 0:  PIIX3 or 4 at 33MHz */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags		= PIIX_PATA_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x06, /* mwdma1-2 ?? CHECK 0 should be ok but slow */
 		.udma_mask	= ATA_UDMA_MASK_40C,
@@ -463,7 +466,7 @@ static struct ata_port_info piix_port_in
 	/* ich_pata_33: 1 	ICH0 - ICH at 33Mhz*/
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SRST | ATA_FLAG_SLAVE_POSS,
+		.flags		= PIIX_PATA_FLAGS,
 		.pio_mask 	= 0x1f,	/* pio 0-4 */
 		.mwdma_mask	= 0x06, /* Check: maybe 0x07  */
 		.udma_mask	= ATA_UDMA2, /* UDMA33 */
@@ -472,7 +475,7 @@ static struct ata_port_info piix_port_in
 	/* ich_pata_66: 2 	ICH controllers up to 66MHz */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SRST | ATA_FLAG_SLAVE_POSS,
+		.flags		= PIIX_PATA_FLAGS,
 		.pio_mask 	= 0x1f,	/* pio 0-4 */
 		.mwdma_mask	= 0x06, /* MWDMA0 is broken on chip */
 		.udma_mask	= ATA_UDMA4,
@@ -482,7 +485,7 @@ static struct ata_port_info piix_port_in
 	/* ich_pata_100: 3 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SRST | ATA_FLAG_SLAVE_POSS | PIIX_FLAG_CHECKINTR,
+		.flags		= PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x06, /* mwdma1-2 */
 		.udma_mask	= ATA_UDMA5, /* udma0-5 */
@@ -492,7 +495,7 @@ static struct ata_port_info piix_port_in
 	/* ich_pata_133: 4 	ICH with full UDMA6 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SRST | ATA_FLAG_SLAVE_POSS | PIIX_FLAG_CHECKINTR,
+		.flags		= PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
 		.pio_mask 	= 0x1f,	/* pio 0-4 */
 		.mwdma_mask	= 0x06, /* Check: maybe 0x07  */
 		.udma_mask	= ATA_UDMA6, /* UDMA133 */
@@ -502,8 +505,7 @@ static struct ata_port_info piix_port_in
 	/* ich5_sata: 5 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR |
-				  PIIX_FLAG_IGNORE_PCS,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_IGNORE_PCS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -513,8 +515,7 @@ static struct ata_port_info piix_port_in
 	/* i6300esb_sata: 6 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_IGNORE_PCS,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_IGNORE_PCS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -524,8 +525,7 @@ static struct ata_port_info piix_port_in
 	/* ich6_sata: 7 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -535,8 +535,7 @@ static struct ata_port_info piix_port_in
 	/* ich6_sata_ahci: 8 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
 				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -547,8 +546,7 @@ static struct ata_port_info piix_port_in
 	/* ich6m_sata_ahci: 9 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
 				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -559,8 +557,7 @@ static struct ata_port_info piix_port_in
 	/* ich7m_sata_ahci: 10 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
 				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -571,8 +568,7 @@ static struct ata_port_info piix_port_in
 	/* ich8_sata_ahci: 11 */
 	{
 		.sht		= &piix_sht,
-		.flags		= ATA_FLAG_SATA |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
 				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
-- 
1.4.2.1


