From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/6] ata_piix: add a couple of flags
Date: Wed, 1 Mar 2006 01:25:39 +0900
Message-ID: <11411439393863-git-send-email-htejun@gmail.com>
References: <11411439383398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:50674 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751874AbWB1QZw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 11:25:52 -0500
Received: by wproxy.gmail.com with SMTP id 57so1138960wri
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 08:25:52 -0800 (PST)
In-Reply-To: <11411439383398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, jfs@keytradebank.com, 0602@eq.cz, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add PIIX_FLAG_IGN_PRESENT and SCR flags.  Thi patch doesn't cause any
functional change.  To be used by later init/scr updates.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

1d0bf89eeba0a60799460a23afae05363a395590
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 5988d5f..987a7cc 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -101,6 +101,8 @@ enum {
 	ICH5_PCS		= 0x92,	/* port control and status */
 	PIIX_SCC		= 0x0A, /* sub-class code register */
 
+	PIIX_FLAG_IGN_PRESENT	= (1 << 25), /* ignore PCS present bits */
+	PIIX_FLAG_SCR		= (1 << 26), /* SCR available */
 	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
 	PIIX_FLAG_COMBINED	= (1 << 29), /* combined mode possible */
@@ -314,7 +316,7 @@ static struct ata_port_info piix_port_in
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED |
-				  PIIX_FLAG_CHECKINTR,
+				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_IGN_PRESENT,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -325,7 +327,8 @@ static struct ata_port_info piix_port_in
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
-				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS,
+				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS |
+				  PIIX_FLAG_SCR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -337,7 +340,7 @@ static struct ata_port_info piix_port_in
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
 				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS |
-				  PIIX_FLAG_AHCI,
+				  PIIX_FLAG_SCR | PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -349,7 +352,7 @@ static struct ata_port_info piix_port_in
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
 				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS |
-				  PIIX_FLAG_AHCI,
+				  PIIX_FLAG_SCR | PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
-- 
1.2.1


