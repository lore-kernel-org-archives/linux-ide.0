From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2] ata: sata_rcar: Disable DIPM mode for r8a7790 ES1
Date: Fri, 24 Oct 2014 11:05:19 +0900
Message-ID: <1414116319-16813-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-ide@vger.kernel.org

Unlike other SATA R-Car r8a7790 controllers the r8a7790 ES1 SATA R-Car
controller needs to be run with DIPM disabled.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Handle ES1 in sata_rcar_init_controller()
---
 Documentation/devicetree/bindings/ata/sata_rcar.txt |  3 ++-
 drivers/ata/sata_rcar.c                             | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
index 1e61113..7dd32d3 100644
--- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -3,7 +3,8 @@
 Required properties:
 - compatible		: should contain one of the following:
 			  - "renesas,sata-r8a7779" for R-Car H1
-			  - "renesas,sata-r8a7790" for R-Car H2
+			  - "renesas,sata-r8a7790-es1" for R-Car H2 ES1
+			  - "renesas,sata-r8a7790" for R-Car H2 other than ES1
 			  - "renesas,sata-r8a7791" for R-Car M2
 - reg			: address and length of the SATA registers;
 - interrupts		: must consist of one interrupt specifier.
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 61eb6d7..b398513 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -146,6 +146,7 @@
 enum sata_rcar_type {
 	RCAR_GEN1_SATA,
 	RCAR_GEN2_SATA,
+	RCAR_R8A7790_ES1_SATA,
 };
 
 struct sata_rcar_priv {
@@ -763,6 +764,10 @@ static void sata_rcar_setup_port(struct ata_host *host)
 	ap->udma_mask	= ATA_UDMA6;
 	ap->flags	|= ATA_FLAG_SATA;
 
+	if (priv->type == RCAR_R8A7790_ES1_SATA) {
+		ap->flags	|= ATA_FLAG_NO_DIPM;
+	}
+
 	ioaddr->cmd_addr = base + SDATA_REG;
 	ioaddr->ctl_addr = base + SSDEVCON_REG;
 	ioaddr->scr_addr = base + SCRSSTS_REG;
@@ -792,6 +797,7 @@ static void sata_rcar_init_controller(struct ata_host *host)
 		sata_rcar_gen1_phy_init(priv);
 		break;
 	case RCAR_GEN2_SATA:
+	case RCAR_R8A7790_ES1_SATA:
 		sata_rcar_gen2_phy_init(priv);
 		break;
 	default:
@@ -838,6 +844,10 @@ static struct of_device_id sata_rcar_match[] = {
 		.data = (void *)RCAR_GEN2_SATA
 	},
 	{
+		.compatible = "renesas,sata-r8a7790-es1",
+		.data = (void *)RCAR_R8A7790_ES1_SATA
+	},
+	{
 		.compatible = "renesas,sata-r8a7791",
 		.data = (void *)RCAR_GEN2_SATA
 	},
@@ -849,6 +859,7 @@ static const struct platform_device_id sata_rcar_id_table[] = {
 	{ "sata_rcar", RCAR_GEN1_SATA }, /* Deprecated by "sata-r8a7779" */
 	{ "sata-r8a7779", RCAR_GEN1_SATA },
 	{ "sata-r8a7790", RCAR_GEN2_SATA },
+	{ "sata-r8a7790-es1", RCAR_R8A7790_ES1_SATA },
 	{ "sata-r8a7791", RCAR_GEN2_SATA },
 	{ },
 };
-- 
2.1.1

