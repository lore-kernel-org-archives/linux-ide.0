From: Rob Herring <robherring2@gmail.com>
Subject: [PATCH] ahci: add DT binding for Calxeda AHCI controller
Date: Fri,  2 Sep 2011 10:10:15 -0500
Message-ID: <1314976215-23902-1-git-send-email-robherring2@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57540 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab1IBPKi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Sep 2011 11:10:38 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Rob Herring <rob.herring@calxeda.com>, Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Rob Herring <rob.herring@calxeda.com>

Add devicetree match table to ahci platform driver for Calxeda Highbank
AHCI controller.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org
---
 .../devicetree/bindings/ata/calxeda-sata.txt       |   17 +++++++++++++++++
 drivers/ata/ahci_platform.c                        |    7 +++++++
 2 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/calxeda-sata.txt

diff --git a/Documentation/devicetree/bindings/ata/calxeda-sata.txt b/Documentation/devicetree/bindings/ata/calxeda-sata.txt
new file mode 100644
index 0000000..79caa56
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/calxeda-sata.txt
@@ -0,0 +1,17 @@
+* Calxeda SATA Controller
+
+SATA nodes are defined to describe on-chip Serial ATA controllers.
+Each SATA controller should have its own node.
+
+Required properties:
+- compatible        : compatible list, contains "calxeda,hb-ahci"
+- interrupts        : <interrupt mapping for SATA IRQ>
+- reg               : <registers mapping>
+
+Example:
+        sata@ffe08000 {
+		compatible = "calxeda,hb-ahci";
+                reg = <0xffe08000 0x1000>;
+                interrupts = <115>;
+        };
+
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 6fef1fa..9bfc970 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -171,11 +171,18 @@ static int __devexit ahci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ahci_of_match[] = {
+	{ .compatible = "calxeda,hb-ahci", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ahci_of_match);
+
 static struct platform_driver ahci_driver = {
 	.remove = __devexit_p(ahci_remove),
 	.driver = {
 		.name = "ahci",
 		.owner = THIS_MODULE,
+		.of_match_table = ahci_of_match,
 	},
 };
 
-- 
1.7.5.4

