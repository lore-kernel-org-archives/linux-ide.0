From: Suneel Garapati <suneel.garapati@xilinx.com>
Subject: [PATCH 1/2] devicetree:bindings: add devicetree bindings for ceva ahci
Date: Thu, 21 May 2015 09:27:04 +0530
Message-ID: <1432180625-25159-2-git-send-email-suneel.garapati@xilinx.com>
References: <1432180625-25159-1-git-send-email-suneel.garapati@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1on0068.outbound.protection.outlook.com ([157.56.110.68]:54865
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750897AbbEUEaH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 May 2015 00:30:07 -0400
In-Reply-To: <1432180625-25159-1-git-send-email-suneel.garapati@xilinx.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tj@kernel.org, michals@xilinx.com, sorenb@xilinx.com, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Suneel Garapati <suneel.garapati@xilinx.com>

adds bindings for CEVA AHCI SATA controller. optional property
broken-gen2 is useful incase of hardware speed limitation.

Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
---
 Documentation/devicetree/bindings/ata/ahci-ceva.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
new file mode 100644
index 0000000..7ca8b97
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
@@ -0,0 +1,20 @@
+Binding for CEVA AHCI SATA Controller
+
+Required properties:
+  - reg: Physical base address and size of the controller's register area.
+  - compatible: Compatibility string. Must be 'ceva,ahci-1v84'.
+  - clocks: Input clock specifier. Refer to common clock bindings.
+  - interrupts: Interrupt specifier. Refer to interrupt binding.
+
+Optional properties:
+  - ceva,broken-gen2: limit to gen1 speed instead of gen2.
+
+Examples:
+	ahci@fd0c0000 {
+		compatible = "ceva,ahci-1v84";
+		reg = <0xfd0c0000 0x200>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 133 4>;
+		clocks = <&clkc SATA_CLK_ID>;
+		ceva,broken-gen2;
+	};
--
2.1.2
