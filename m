From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 01/35 linux-next] ata: constify of_device_id array
Date: Mon, 16 Mar 2015 20:17:07 +0100
Message-ID: <1426533469-25458-2-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay118.isp.belgacom.be ([195.238.20.145]:19876 "EHLO
	mailrelay118.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965587AbbCPTSK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Mar 2015 15:18:10 -0400
In-Reply-To: <1426533469-25458-1-git-send-email-fabf@skynet.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/ata/pata_macio.c       | 2 +-
 drivers/ata/pata_mpc52xx.c     | 2 +-
 drivers/ata/pata_octeon_cf.c   | 2 +-
 drivers/ata/pata_of_platform.c | 2 +-
 drivers/ata/sata_fsl.c         | 2 +-
 drivers/ata/sata_mv.c          | 2 +-
 drivers/ata/sata_rcar.c        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index a02f76f..4022ef4 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1328,7 +1328,7 @@ static int pata_macio_pci_resume(struct pci_dev *pdev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-static struct of_device_id pata_macio_match[] =
+static const struct of_device_id pata_macio_match[] =
 {
 	{
 	.name 		= "IDE",
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 252ba27..9730125 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -847,7 +847,7 @@ mpc52xx_ata_resume(struct platform_device *op)
 }
 #endif
 
-static struct of_device_id mpc52xx_ata_of_match[] = {
+static const struct of_device_id mpc52xx_ata_of_match[] = {
 	{ .compatible = "fsl,mpc5200-ata", },
 	{ .compatible = "mpc5200-ata", },
 	{},
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 80a8054..343cef3 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -1047,7 +1047,7 @@ static void octeon_cf_shutdown(struct device *dev)
 	}
 }
 
-static struct of_device_id octeon_cf_match[] = {
+static const struct of_device_id octeon_cf_match[] = {
 	{
 		.compatible = "cavium,ebt3000-compact-flash",
 	},
diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index b6b7af8..a15a4f8 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -72,7 +72,7 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 				     reg_shift, pio_mask, &pata_platform_sht);
 }
 
-static struct of_device_id pata_of_platform_match[] = {
+static const struct of_device_id pata_of_platform_match[] = {
 	{ .compatible = "ata-generic", },
 	{ },
 };
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 5389579..5e32f8a 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1611,7 +1611,7 @@ static int sata_fsl_resume(struct platform_device *op)
 }
 #endif
 
-static struct of_device_id fsl_sata_match[] = {
+static const struct of_device_id fsl_sata_match[] = {
 	{
 		.compatible = "fsl,pq-sata",
 	},
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index f8c33e3..baae776 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4263,7 +4263,7 @@ static int mv_platform_resume(struct platform_device *pdev)
 #endif
 
 #ifdef CONFIG_OF
-static struct of_device_id mv_sata_dt_ids[] = {
+static const struct of_device_id mv_sata_dt_ids[] = {
 	{ .compatible = "marvell,armada-370-sata", },
 	{ .compatible = "marvell,orion-sata", },
 	{},
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index d49a519..566bcaf 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -828,7 +828,7 @@ static void sata_rcar_init_controller(struct ata_host *host)
 	iowrite32(ATAPI_INT_ENABLE_SATAINT, base + ATAPI_INT_ENABLE_REG);
 }
 
-static struct of_device_id sata_rcar_match[] = {
+static const struct of_device_id sata_rcar_match[] = {
 	{
 		/* Deprecated by "renesas,sata-r8a7779" */
 		.compatible = "renesas,rcar-sata",
-- 
2.1.0

