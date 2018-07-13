From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 4/9] dt-bindings: ata: ahci-platform: document AHCI reset
Date: Fri, 13 Jul 2018 11:03:01 +0000
Message-ID: <1531479786-4911-5-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, maxime.ripard@free-electrons.com, robh+dt@kernel.org, tj@kernel.org, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, thierry.reding@gmail.com, icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

This patch document the new optional resets for ahci node.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 5f362af2724c..a5281d7557e3 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -34,6 +34,8 @@ Optional properties:
 - phys              : reference to the SATA PHY node
 - phy-names         : must be "sata-phy"
 - ahci-supply       : regulator for AHCI controller
+- resets            : phandle to the reset line of AHCI controller
+                      If set, must have a reset-names set as "ahci"
 - ports-implemented : Mask that indicates which ports that the HBA supports
 		      are available for software to use. Useful if PORTS_IMPL
 		      is not programmed by the BIOS, which is true with
-- 
2.16.4
