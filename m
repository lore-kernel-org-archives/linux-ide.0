From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH v2] ata: sata_rcar: Add r8a7793 device support
Date: Wed, 15 Oct 2014 17:59:37 +0900
Message-ID: <1413363577-25969-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is against for-next branch of Tejun's libata repo.

v2 [Yoshihiro Kaneko]
* Update the binding documentation

 Documentation/devicetree/bindings/ata/sata_rcar.txt | 3 ++-
 drivers/ata/sata_rcar.c                             | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
index 1e61113..74b1130 100644
--- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -4,7 +4,8 @@ Required properties:
 - compatible		: should contain one of the following:
 			  - "renesas,sata-r8a7779" for R-Car H1
 			  - "renesas,sata-r8a7790" for R-Car H2
-			  - "renesas,sata-r8a7791" for R-Car M2
+			  - "renesas,sata-r8a7791" for R-Car M2-W
+			  - "renesas,sata-r8a7793" for R-Car M2-N
 - reg			: address and length of the SATA registers;
 - interrupts		: must consist of one interrupt specifier.
 
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 61eb6d7..6f8ed8e 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -841,6 +841,10 @@ static struct of_device_id sata_rcar_match[] = {
 		.compatible = "renesas,sata-r8a7791",
 		.data = (void *)RCAR_GEN2_SATA
 	},
+	{
+		.compatible = "renesas,sata-r8a7793",
+		.data = (void *)RCAR_GEN2_SATA
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sata_rcar_match);
@@ -850,6 +854,7 @@ static const struct platform_device_id sata_rcar_id_table[] = {
 	{ "sata-r8a7779", RCAR_GEN1_SATA },
 	{ "sata-r8a7790", RCAR_GEN2_SATA },
 	{ "sata-r8a7791", RCAR_GEN2_SATA },
+	{ "sata-r8a7793", RCAR_GEN2_SATA },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, sata_rcar_id_table);
-- 
1.9.1

