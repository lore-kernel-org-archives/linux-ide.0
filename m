From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 2/4] ata: ahci_platform: Update DT compatible list
Date: Mon, 20 Jan 2014 16:41:26 +0200
Message-ID: <1390228888-5537-3-git-send-email-rogerq@ti.com>
References: <1390228888-5537-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390228888-5537-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: sergei.shtylyov@cogentembedded.com, kishon@ti.com, b.zolnierkie@samsung.com, hdegoede@redhat.com, arnd@arndb.de, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-ide@vger.kernel.org

The ahci_platform driver supports "snps,exynos5440-ahci", "ibm,476gtr-ahci"
and "snps,dwc-ahci". Add this to the DT binding information.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 89de156..08ba647 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -4,7 +4,9 @@ SATA nodes are defined to describe on-chip Serial ATA controllers.
 Each SATA controller should have its own node.
 
 Required properties:
-- compatible        : compatible list, contains "snps,spear-ahci"
+- compatible        : compatible list, contains "snps,spear-ahci",
+		      "snps,exynos5440-ahci", "ibm,476gtr-ahci",
+		      or "snps,dwc-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
 
-- 
1.8.3.2
