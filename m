From: Peng Ma <peng.ma@nxp.com>
Subject: [PATCH 1/3] dt-bindings: ahci-fsl-qoriq: add ls1028a chip name to the list
Date: Mon, 11 Mar 2019 15:20:12 +0800
Message-ID: <20190311072014.36565-1-peng.ma@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, robh+dt@kernel.org, shawnguo@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, andy.tang@nxp.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peng Ma <peng.ma@nxp.com>
List-Id: linux-ide@vger.kernel.org

Add ls1028a compatible to bindings documentation.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
depends on:
	- http://patchwork.ozlabs.org/patch/1045217/

 .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
index 9ecc019..72fdeef 100644
--- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
@@ -3,7 +3,8 @@ Binding for Freescale QorIQ AHCI SATA Controller
 Required properties:
   - reg: Physical base address and size of the controller's register area.
   - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
-    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a, lx2160a, etc.
+    chip could be ls1021a, ls1028a, ls1043a, ls1046a, ls1088a, ls2080a,
+    lx2160a, etc.
   - clocks: Input clock specifier. Refer to common clock bindings.
   - interrupts: Interrupt specifier. Refer to interrupt binding.
 
-- 
1.7.1
