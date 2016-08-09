From: <yuantian.tang-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 2/2] ahci: qoriq: enable snoopable sata read and write
Date: Tue, 9 Aug 2016 09:51:22 +0800
Message-ID: <1470707482-13421-2-git-send-email-yuantian.tang@nxp.com>
References: <1470707482-13421-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470707482-13421-1-git-send-email-yuantian.tang-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, Tang Yuantian <Yuantian.Tang-3arQi8VN3Tc@public.gmane.org>, Tang Yuantian <yuantian.tang-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Tang Yuantian <Yuantian.Tang-3arQi8VN3Tc@public.gmane.org>

By default the SATA IP on the qoriq SoCs does not generating
coherent/snoopable transactions.  This patch enable it in the
sata axicc register.
In addition, the dma-coherent property must be set on the
SATA controller nodes.

Signed-off-by: Tang Yuantian <yuantian.tang-3arQi8VN3Tc@public.gmane.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 ++-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 2 ++
 drivers/ata/ahci_qoriq.c                       | 6 ++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 6bd46c1..bdcfa59 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -484,10 +484,11 @@
 		};
 
 		sata: sata@3200000 {
-			compatible = "fsl,ls1043a-ahci", "fsl,ls1021a-ahci";
+			compatible = "fsl,ls1043a-ahci";
 			reg = <0x0 0x3200000 0x0 0x10000>;
 			interrupts = <0 69 0x4>;
 			clocks = <&clockgen 4 0>;
+			dma-coherent;
 		};
 
 		msi1: msi-controller1@1571000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 3187c82..be243f8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -655,6 +655,7 @@
 			reg = <0x0 0x3200000 0x0 0x10000>;
 			interrupts = <0 133 0x4>; /* Level high type */
 			clocks = <&clockgen 4 3>;
+			dma-coherent;
 		};
 
 		sata1: sata@3210000 {
@@ -663,6 +664,7 @@
 			reg = <0x0 0x3210000 0x0 0x10000>;
 			interrupts = <0 136 0x4>; /* Level high type */
 			clocks = <&clockgen 4 3>;
+			dma-coherent;
 		};
 
 		usb0: usb3@3100000 {
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index ed357a1..925c4b6 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -30,17 +30,20 @@
 #define PORT_PHY3	0xB0
 #define PORT_PHY4	0xB4
 #define PORT_PHY5	0xB8
+#define PORT_AXICC	0xBC
 #define PORT_TRANS	0xC8
 
 /* port register default value */
 #define AHCI_PORT_PHY_1_CFG	0xa003fffe
 #define AHCI_PORT_TRANS_CFG	0x08000029
+#define AHCI_PORT_AXICC_CFG	0x3fffffff
 
 /* for ls1021a */
 #define LS1021A_PORT_PHY2	0x28183414
 #define LS1021A_PORT_PHY3	0x0e080e06
 #define LS1021A_PORT_PHY4	0x064a080b
 #define LS1021A_PORT_PHY5	0x2aa86470
+#define LS1021A_AXICC_ADDR	0xC0
 
 #define SATA_ECC_DISABLE	0x00020000
 
@@ -158,16 +161,19 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		writel(LS1021A_PORT_PHY4, reg_base + PORT_PHY4);
 		writel(LS1021A_PORT_PHY5, reg_base + PORT_PHY5);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
+		writel(AHCI_PORT_AXICC_CFG, reg_base + LS1021A_AXICC_ADDR);
 		break;
 
 	case AHCI_LS1043A:
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
+		writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
 
 	case AHCI_LS2080A:
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
+		writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
 	}
 
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
