From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 3/9] ata: ceva: Add gen 3 mode support in driver
Date: Mon, 21 Aug 2017 13:17:18 +0200
Message-ID: <1432a5195784dbdc9305855aa2de5795531cdc98.1503314240.git.michal.simek@xilinx.com>
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

This patch sets gen 3 mode as default mode in ahci_ceva driver.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 drivers/ata/ahci_ceva.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 59de2ca1885c..aa32c8a0f083 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -60,6 +60,7 @@
 #define PORT1_BASE	0x180
 
 /* Port Control Register Bit Definitions */
+#define PORT_SCTL_SPD_GEN3	(0x3 << 4)
 #define PORT_SCTL_SPD_GEN2	(0x2 << 4)
 #define PORT_SCTL_SPD_GEN1	(0x1 << 4)
 #define PORT_SCTL_IPM		(0x3 << 8)
@@ -136,8 +137,8 @@ static void ahci_ceva_setup(struct ahci_host_priv *hpriv)
 		tmp = PTC_RX_WM_VAL | PTC_RSVD;
 		writel(tmp, mmio + AHCI_VEND_PTC);
 
-		/* Default to Gen 2 Speed and Gen 1 if Gen2 is broken */
-		tmp = PORT_SCTL_SPD_GEN2 | PORT_SCTL_IPM;
+		/* Default to Gen 3 Speed and Gen 1 if Gen2 is broken */
+		tmp = PORT_SCTL_SPD_GEN3 | PORT_SCTL_IPM;
 		if (cevapriv->flags & CEVA_FLAG_BROKEN_GEN2)
 			tmp = PORT_SCTL_SPD_GEN1 | PORT_SCTL_IPM;
 		writel(tmp, mmio + PORT_SCR_CTL + PORT_BASE + PORT_OFFSET * i);
-- 
1.9.1
