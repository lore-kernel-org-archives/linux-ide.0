From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/13] ahci: consolidate common port flags
Date: Mon, 23 Apr 2007 02:41:05 +0900
Message-ID: <1177263665394-git-send-email-htejun@gmail.com>
References: <11772636651400-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11772636651400-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

Consolidate common port flags into AHCI_FLAG_COMMON.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   29 ++++++++++-------------------
 1 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7c61bc7..34c5534 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -170,6 +170,10 @@ enum {
 	AHCI_FLAG_IGN_IRQ_IF_ERR	= (1 << 25), /* ignore IRQ_IF_ERR */
 	AHCI_FLAG_HONOR_PI		= (1 << 26), /* honor PORTS_IMPL */
 	AHCI_FLAG_IGN_SERR_INTERNAL	= (1 << 27), /* ignore SERR_INTERNAL */
+
+	AHCI_FLAG_COMMON		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+					  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
+					  ATA_FLAG_SKIP_D2H_BSY,
 };
 
 struct ahci_cmd_hdr {
@@ -323,54 +327,41 @@ static const struct ata_port_operations ahci_vt8251_ops = {
 static const struct ata_port_info ahci_port_info[] = {
 	/* board_ahci */
 	{
-		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY,
+		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
 	},
 	/* board_ahci_pi */
 	{
-		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY | AHCI_FLAG_HONOR_PI,
+		.flags		= AHCI_FLAG_COMMON | AHCI_FLAG_HONOR_PI,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
 	},
 	/* board_ahci_vt8251 */
 	{
-		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY |
-				  ATA_FLAG_HRST_TO_RESUME | AHCI_FLAG_NO_NCQ,
+		.flags		= AHCI_FLAG_COMMON | ATA_FLAG_HRST_TO_RESUME |
+				  AHCI_FLAG_NO_NCQ,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_vt8251_ops,
 	},
 	/* board_ahci_ign_iferr */
 	{
-		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY |
-				  AHCI_FLAG_IGN_IRQ_IF_ERR,
+		.flags		= AHCI_FLAG_COMMON | AHCI_FLAG_IGN_IRQ_IF_ERR,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
 	},
 	/* board_ahci_sb600 */
 	{
-		.sht		= &ahci_sht,
-		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY |
+		.flags		= AHCI_FLAG_COMMON |
 				  AHCI_FLAG_IGN_SERR_INTERNAL,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
 	},
-
 };
 
 static const struct pci_device_id ahci_pci_tbl[] = {
-- 
1.5.0.3


