From: Preetham Chandru Ramchandra <pchandru@nvidia.com>
Subject: [PATCH V5 2/3] arm64: tegra: Enable AHCI on Tegra210
Date: Fri, 30 Jun 2017 19:26:32 +0530
Message-ID: <1498830993-24666-3-git-send-email-pchandru@nvidia.com>
References: <1498830993-24666-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:3409 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbdF3N56 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 30 Jun 2017 09:57:58 -0400
In-Reply-To: <1498830993-24666-1-git-send-email-pchandru@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: thierry.reding@gmail.com, tj@kernel.org, cyndis@kapsi.fi
Cc: preetham260@gmail.com, linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org, vbyravarasu@nvidia.com, pkunapuli@nvidia.com, Preetham Chandru R <pchandru@nvidia.com>

From: Preetham Chandru R <pchandru@nvidia.com>

Enable AHCI on Tegra210 systems.

Signed-off-by: Preetham Chandru R <pchandru@nvidia.com>
---
v4:
* Fixed missing space after 'AUX'
---
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi |  6 ++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi       | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index e5fc67b..58c28b9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1324,6 +1324,12 @@
 		status = "okay";
 	};
 
+	sata@70020000 {
+		status = "okay";
+		phys = <&{/padctl@7009f000/pads/sata/lanes/sata-0}>;
+		phy-names = "sata-0";
+	};
+
 	padctl@7009f000 {
 		status = "okay";
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 29f471e..d767972 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -797,6 +797,22 @@
 		#iommu-cells = <1>;
 	};
 
+	sata@70020000 {
+		compatible = "nvidia,tegra210-ahci";
+		reg = <0x0 0x70027000 0x0 0x2000>, /* AHCI */
+		      <0x0 0x70020000 0x0 0x7000>, /* SATA */
+		      <0x0 0x70001100 0x0 0x1000>; /* SATA AUX */
+		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA210_CLK_SATA>,
+			<&tegra_car TEGRA210_CLK_SATA_OOB>;
+		clock-names = "sata", "sata-oob";
+		resets = <&tegra_car 124>,
+			 <&tegra_car 123>,
+			 <&tegra_car 129>;
+		reset-names = "sata", "sata-oob", "sata-cold";
+		status = "disabled";
+	};
+
 	hda@70030000 {
 		compatible = "nvidia,tegra210-hda", "nvidia,tegra30-hda";
 		reg = <0x0 0x70030000 0x0 0x10000>;
-- 
2.1.4

