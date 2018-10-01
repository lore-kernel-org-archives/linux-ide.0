From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: ata: Document BCM63138 compatible string
Date: Mon,  1 Oct 2018 10:32:59 -0700
Message-ID: <20181001173302.25398-2-f.fainelli@gmail.com>
References: <20181001173302.25398-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001173302.25398-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:LIBATA SUBSYSTEM Serial and
        Parallel ATA drivers" <linux-ide@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Document the compatible string "brcm,bcm63138-ahci" as a valid
compatible string for the standard Broadcom AHCI controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
index 0a5b3b47f217..7713a413c6a7 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
@@ -9,6 +9,7 @@ Required properties:
 			"brcm,bcm7445-ahci"
 			"brcm,bcm-nsp-ahci"
 			"brcm,sata3-ahci"
+			"brcm,bcm63138-ahci"
 - reg                : register mappings for AHCI and SATA_TOP_CTRL
 - reg-names          : "ahci" and "top-ctrl"
 - interrupts         : interrupt mapping for SATA IRQ
-- 
2.17.1
