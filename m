From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: [PATCH 1/7] dt-bindings: ata: rename brcm,sata-brcmstb.txt to brcm,sata-brcm.txt
Date: Thu, 16 Jun 2016 09:53:29 -0400
Message-ID: <1466085215-10246-2-git-send-email-yendapally.reddy@broadcom.com>
References: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Jaedon Shin <jaedon.shin@gmail.com>, Anup Patel <anup.patel@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-ide@vger.kernel.org, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
List-Id: linux-ide@vger.kernel.org

Renames the dt bindings document of Broadcom STB ahci driver to
common Broadcom ahci driver bindings document

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 .../bindings/ata/{brcm,sata-brcmstb.txt => brcm,sata-brcm.txt}    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/ata/{brcm,sata-brcmstb.txt => brcm,sata-brcm.txt} (81%)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
similarity index 81%
rename from Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
rename to Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
index 6087283..126ee13 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
@@ -1,13 +1,13 @@
-* Broadcom SATA3 AHCI Controller for STB
+* Broadcom SATA3 AHCI Controller
 
 SATA nodes are defined to describe on-chip Serial ATA controllers.
 Each SATA controller should have its own node.
 
 Required properties:
 - compatible         : should be one or more of
-                       "brcm,bcm7425-ahci"
-                       "brcm,bcm7445-ahci"
-                       "brcm,sata3-ahci"
+			"brcm,bcm7425-ahci"
+			"brcm,bcm7445-ahci"
+			"brcm,sata3-ahci"
 - reg                : register mappings for AHCI and SATA_TOP_CTRL
 - reg-names          : "ahci" and "top-ctrl"
 - interrupts         : interrupt mapping for SATA IRQ
-- 
2.1.0
