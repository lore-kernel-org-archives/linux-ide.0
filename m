From: Peng Ma <peng.ma@nxp.com>
Subject: [v4] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to the list
Date: Fri, 25 Jan 2019 11:32:21 +0800
Message-ID: <20190125033221.30333-2-peng.ma@nxp.com>
References: <20190125033221.30333-1-peng.ma@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125033221.30333-1-peng.ma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shawnguo@kernel.org, axboe@kernel.dk
Cc: robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.tang@nxp.com, Peng Ma <peng.ma@nxp.com>
List-Id: linux-ide@vger.kernel.org

Add lxx2160a compatible to bindings documentation.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
changed for V4:
	- add lx2160a compatible to bindings doc

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
