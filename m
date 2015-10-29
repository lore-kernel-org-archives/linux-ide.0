From: Tang Yuantian <Yuantian.Tang@freescale.com>
Subject: [PATCH 1/3] ahci: qoriq: Rename LS2085A SoC support code to LS2080A
Date: Thu, 29 Oct 2015 14:22:15 +0800
Message-ID: <1446099737-41854-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tj@kernel.org
Cc: devicetree@vger.kernel.org, hdegoede@redhat.com, Tang Yuantian <Yuantian.Tang@freescale.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Freescale is renaming the LS2085A SoC to LS2080A.
This patch addresses the same.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt | 2 +-
 drivers/ata/ahci_qoriq.c                                 | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
index b614e3b..3aafe27 100644
--- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
@@ -3,7 +3,7 @@ Binding for Freescale QorIQ AHCI SATA Controller
 Required properties:
   - reg: Physical base address and size of the controller's register area.
   - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
-    chip could be ls1021a, ls2085a, ls1043a etc.
+    chip could be ls1021a, ls2080a, ls1043a etc.
   - clocks: Input clock specifier. Refer to common clock bindings.
   - interrupts: Interrupt specifier. Refer to interrupt binding.
 
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 58c1a94..b9b691e 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -45,7 +45,7 @@
 enum ahci_qoriq_type {
 	AHCI_LS1021A,
 	AHCI_LS1043A,
-	AHCI_LS2085A,
+	AHCI_LS2080A,
 };
 
 struct ahci_qoriq_priv {
@@ -57,7 +57,7 @@ struct ahci_qoriq_priv {
 static const struct of_device_id ahci_qoriq_of_match[] = {
 	{ .compatible = "fsl,ls1021a-ahci", .data = (void *)AHCI_LS1021A},
 	{ .compatible = "fsl,ls1043a-ahci", .data = (void *)AHCI_LS1043A},
-	{ .compatible = "fsl,ls2085a-ahci", .data = (void *)AHCI_LS2085A},
+	{ .compatible = "fsl,ls2080a-ahci", .data = (void *)AHCI_LS2080A},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_qoriq_of_match);
@@ -159,7 +159,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		break;
 
 	case AHCI_LS1043A:
-	case AHCI_LS2085A:
+	case AHCI_LS2080A:
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		break;
 	}
-- 
2.1.0.27.g96db324
