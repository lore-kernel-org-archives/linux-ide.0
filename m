From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH v3] ata: sata_rcar: Add r8a7793 device support
Date: Tue, 28 Oct 2014 12:45:32 +0900
Message-ID: <1414467932-17688-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is against for-3.19 branch of Tejun's libata repo.

v3 [Yoshihiro Kaneko]
* Rebased on top of for-3.19

v2 [Yoshihiro Kaneko]
* Update the binding documentation

 Documentation/devicetree/bindings/ata/sata_rcar.txt | 3 ++-
 drivers/ata/sata_rcar.c                             | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
index 7dd32d3..80ae87a 100644
--- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -5,7 +5,8 @@ Required properties:
 			  - "renesas,sata-r8a7779" for R-Car H1
 			  - "renesas,sata-r8a7790-es1" for R-Car H2 ES1
 			  - "renesas,sata-r8a7790" for R-Car H2 other than ES1
-			  - "renesas,sata-r8a7791" for R-Car M2
+			  - "renesas,sata-r8a7791" for R-Car M2-W
+			  - "renesas,sata-r8a7793" for R-Car M2-N
 - reg			: address and length of the SATA registers;
 - interrupts		: must consist of one interrupt specifier.
 
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 8732e42..ea1fbc1 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -850,6 +850,10 @@ static struct of_device_id sata_rcar_match[] = {
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
@@ -860,6 +864,7 @@ static const struct platform_device_id sata_rcar_id_table[] = {
 	{ "sata-r8a7790", RCAR_GEN2_SATA },
 	{ "sata-r8a7790-es1", RCAR_R8A7790_ES1_SATA },
 	{ "sata-r8a7791", RCAR_GEN2_SATA },
+	{ "sata-r8a7793", RCAR_GEN2_SATA },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, sata_rcar_id_table);
-- 
1.9.1

