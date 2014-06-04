From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 2/9] ARM: tegra: Add SATA controller to Tegra124 device tree
Date: Wed, 4 Jun 2014 14:32:32 +0300
Message-ID: <1401881559-18469-3-git-send-email-mperttunen@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, tj@kernel.org, pdeschrijver@nvidia.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

This adds the integrated AHCI-compliant Serial ATA controller present
in Tegra124 systems-on-chip to the Tegra124 device tree.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/tegra124.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 90f11ea..e647f30 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -787,6 +787,30 @@
 		status = "disabled";
 	};
 
+	sata@0,70020000 {
+		compatible = "nvidia,tegra124-ahci";
+
+		reg = <0x0 0x70027000 0x0 0x2000>, /* AHCI */
+			<0x0 0x70020000 0x0 0x7000>; /* SATA */
+
+		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&tegra_car TEGRA124_CLK_SATA>,
+			<&tegra_car TEGRA124_CLK_SATA_OOB>,
+			<&tegra_car TEGRA124_CLK_CML1>,
+			<&tegra_car TEGRA124_CLK_PLL_E>;
+
+		resets = <&tegra_car 124>,
+			<&tegra_car 123>,
+			<&tegra_car 129>;
+		reset-names = "sata", "sata-oob", "sata-cold";
+
+		phys = <&padctl TEGRA_XUSB_PADCTL_SATA>;
+		phy-names = "sata-phy";
+
+		status = "disabled";
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.1.5
