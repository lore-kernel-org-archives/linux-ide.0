From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 7/9] ata: ceva: Correct the AXI bus configuration for SATA ports
Date: Mon, 21 Aug 2017 13:17:22 +0200
Message-ID: <069945209dd6ee0f22bd3a1ccf9484e737d56f8e.1503314240.git.michal.simek@xilinx.com>
References: <cover.1503314240.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1503314240.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1503314240.git.michal.simek@xilinx.com>
References: <cover.1503314240.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

Previously PAXIC register was programmed before configuring PCFG
register. PCFG should be programmed with the address of the port
for which PAXIC should be configured for.
This was not happening before, so only one port PAXIC was written
correctly and the other port was having wrong value.
This patch moves the PXAIC register write after configuring PCFG,
doing so will correct the axi bus settings for sata port0 & port1.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 drivers/ata/ahci_ceva.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index ec9cfb52c6f6..113c1f617da9 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -134,14 +134,6 @@ static void ahci_ceva_setup(struct ahci_host_priv *hpriv)
 	u32 tmp;
 	int i;
 
-	/*
-	 * AXI Data bus width to 64
-	 * Set Mem Addr Read, Write ID for data transfers
-	 * Transfer limit to 72 DWord
-	 */
-	tmp = PAXIC_ADBW_BW64 | PAXIC_MAWIDD | PAXIC_MARIDD | PAXIC_OTL;
-	writel(tmp, mmio + AHCI_VEND_PAXIC);
-
 	/* Set AHCI Enable */
 	tmp = readl(mmio + HOST_CTL);
 	tmp |= HOST_AHCI_EN;
@@ -152,6 +144,14 @@ static void ahci_ceva_setup(struct ahci_host_priv *hpriv)
 		tmp = PCFG_TPSS_VAL | PCFG_TPRS_VAL | (PCFG_PAD_VAL + i);
 		writel(tmp, mmio + AHCI_VEND_PCFG);
 
+		/*
+		 * AXI Data bus width to 64
+		 * Set Mem Addr Read, Write ID for data transfers
+		 * Transfer limit to 72 DWord
+		 */
+		tmp = PAXIC_ADBW_BW64 | PAXIC_MAWIDD | PAXIC_MARIDD | PAXIC_OTL;
+		writel(tmp, mmio + AHCI_VEND_PAXIC);
+
 		/* Set AXI cache control register if CCi is enabled */
 		if (cevapriv->is_cci_enabled) {
 			tmp = readl(mmio + AHCI_VEND_AXICC);
-- 
1.9.1
