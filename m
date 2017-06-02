From: Preetham Chandru Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V4 2/3] arm64: tegra: Enable AHCI on Tegra210
Date: Fri, 2 Jun 2017 18:23:19 +0530
Message-ID: <1496408000-24856-3-git-send-email-pchandru@nvidia.com>
References: <1496408000-24856-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1496408000-24856-1-git-send-email-pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, cyndis-/1wQRMveznE@public.gmane.org
Cc: preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Enable AHCI on Tegra210 systems.

Signed-off-by: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
index 8f26c4d..2de5bee 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -795,6 +795,22 @@
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
