From: Tang Yuantian <Yuantian.Tang@freescale.com>
Subject: [PATCH 3/3] devicetree: bindings: Fixed a few typos
Date: Thu, 29 Oct 2015 14:22:17 +0800
Message-ID: <1446099737-41854-3-git-send-email-Yuantian.Tang@freescale.com>
References: <1446099737-41854-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446099737-41854-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: hdegoede@redhat.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tang Yuantian <Yuantian.Tang@freescale.com>
List-Id: linux-ide@vger.kernel.org

There is a few typos in Freescale QorIQ AHCI bindings, This
patch fixed them.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
index 3aafe27..032a760 100644
--- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
@@ -8,8 +8,8 @@ Required properties:
   - interrupts: Interrupt specifier. Refer to interrupt binding.
 
 Optional properties:
-  - dma-coherent: Enable ACHI coherency DMA operation.
-  - reg-names: register area names when there are more then 1 regster area.
+  - dma-coherent: Enable AHCI coherent DMA operation.
+  - reg-names: register area names when there are more than 1 register area.
 
 Examples:
 	sata@3200000 {
-- 
2.1.0.27.g96db324
