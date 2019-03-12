From: Peng Ma <peng.ma@nxp.com>
Subject: [v7 1/3] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to the list
Date: Tue, 12 Mar 2019 09:50:17 +0800
Message-ID: <20190312015019.30628-1-peng.ma@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peng Ma <peng.ma@nxp.com>
List-Id: linux-ide@vger.kernel.org

Add lx2160a compatible to bindings documentation.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
changed for V7:
	- add Reviewed by tag.

 .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
index 7c3ca0e..9ecc019 100644
--- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
@@ -3,7 +3,7 @@ Binding for Freescale QorIQ AHCI SATA Controller
 Required properties:
   - reg: Physical base address and size of the controller's register area.
   - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
-    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a etc.
+    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a, lx2160a, etc.
   - clocks: Input clock specifier. Refer to common clock bindings.
   - interrupts: Interrupt specifier. Refer to interrupt binding.
 
-- 
1.7.1
