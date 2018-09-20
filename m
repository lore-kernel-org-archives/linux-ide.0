From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/9] dt-bindings: phy: Document BCM63138 compatible string
Date: Thu, 20 Sep 2018 12:16:35 -0700
Message-ID: <20180920191646.18198-2-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kishon Vijay Abraham I <kishon@ti.com>, Al Cooper <alcooperx@gmail.com>, Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>, "open list:LIBATA SUBSYSTEM Serial and
        Parallel ATA drivers" <linux-ide@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org

Document the compatible string "brcm,bcm63138-sata-phy" as a valid
compatible string describing the standard Broadcom SATA PHY block.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/phy/brcm-sata-phy.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt b/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
index 0aced97d8092..b640845fec67 100644
--- a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
+++ b/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
@@ -8,6 +8,7 @@ Required properties:
      "brcm,iproc-nsp-sata-phy"
      "brcm,phy-sata3"
      "brcm,iproc-sr-sata-phy"
+     "brcm,bcm63138-sata-phy"
 - address-cells: should be 1
 - size-cells: should be 0
 - reg: register ranges for the PHY PCB interface
-- 
2.17.1
