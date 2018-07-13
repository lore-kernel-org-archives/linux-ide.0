From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 5/9] dt-bindings: ata: ahci-platform: fix indentation of target-supply
Date: Fri, 13 Jul 2018 11:03:02 +0000
Message-ID: <1531479786-4911-6-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, maxime.ripard@free-electrons.com, robh+dt@kernel.org, tj@kernel.org, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, thierry.reding@gmail.com, icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

This patch fix the indentation of target-supply's ':'.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index a5281d7557e3..47652521a6ed 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -50,7 +50,7 @@ Sub-nodes required properties:
 - reg		    : the port number
 And at least one of the following properties:
 - phys		    : reference to the SATA PHY node
-- target-supply    : regulator for SATA target power
+- target-supply     : regulator for SATA target power
 
 Examples:
         sata@ffe08000 {
-- 
2.16.4
