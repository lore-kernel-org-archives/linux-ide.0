From: <Yuantian.Tang@freescale.com>
Subject: [PATCH 2/3] devicetree:bindings: add devicetree bindings for Freescale AHCI
Date: Mon, 7 Sep 2015 16:23:15 +0800
Message-ID: <1441614196-4284-2-git-send-email-Yuantian.Tang@freescale.com>
References: <1441614196-4284-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-by2on0133.outbound.protection.outlook.com ([207.46.100.133]:42432
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754066AbbIGI3J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Sep 2015 04:29:09 -0400
In-Reply-To: <1441614196-4284-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hdegoede@redhat.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tang Yuantian <Yuantian.Tang@freescale.com>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

adds bindings for Freescale QorIQ AHCI SATA controller.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 .../devicetree/bindings/ata/ahci-fsl-qoriq.txt      | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
new file mode 100644
index 0000000..b614e3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
@@ -0,0 +1,21 @@
+Binding for Freescale QorIQ AHCI SATA Controller
+
+Required properties:
+  - reg: Physical base address and size of the controller's register area.
+  - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
+    chip could be ls1021a, ls2085a, ls1043a etc.
+  - clocks: Input clock specifier. Refer to common clock bindings.
+  - interrupts: Interrupt specifier. Refer to interrupt binding.
+
+Optional properties:
+  - dma-coherent: Enable ACHI coherency DMA operation.
+  - reg-names: register area names when there are more then 1 regster area.
+
+Examples:
+	sata@3200000 {
+		compatible = "fsl,ls1021a-ahci";
+		reg = <0x0 0x3200000 0x0 0x10000>;
+		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&platform_clk 1>;
+		dma-coherent;
+	};
-- 
2.1.0.27.g96db324

