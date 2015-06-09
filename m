From: Suneel Garapati <suneel.garapati@xilinx.com>
Subject: [PATCH v3 1/2] devicetree:bindings: add devicetree bindings for ceva ahci
Date: Tue, 9 Jun 2015 14:23:49 +0530
Message-ID: <1433840030-31453-2-git-send-email-suneel.garapati@xilinx.com>
References: <1433840030-31453-1-git-send-email-suneel.garapati@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433840030-31453-1-git-send-email-suneel.garapati@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tj@kernel.org, michals@xilinx.com, sorenb@xilinx.com, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Suneel Garapati <suneel.garapati@xilinx.com>
List-Id: linux-ide@vger.kernel.org

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
