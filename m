From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ata: constify of_device_id structures
Date: Thu,  2 Mar 2017 01:03:28 +0530
Message-ID: <1488396808-12332-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33998 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbdCATeO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2017 14:34:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: julia.lawall@lip6.fr, b.zolnierkie@samsung.com, tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Declare of_device_id structures as const as they are either passed to
the macro MODULE_DEVICE_TABLE or stored in the of_match_table field of a
device_driver structure. This field is of type const, so of_device_id
structures having this property can be made const too.

Cross compiled the files drivers/ata/pata_macio.c and
drivers/ata/pata_mpc52xx.c for powerpc architecture.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/ata/pata_macio.c       | 2 +-
 drivers/ata/pata_mpc52xx.c     | 2 +-
 drivers/ata/pata_of_platform.c | 2 +-
 drivers/ata/sata_fsl.c         | 2 +-
 drivers/ata/sata_mv.c          | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index e347e7a..0adcb40 100644
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
@@ -847,7 +847,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 }
 #endif
 
-static struct of_device_id mpc52xx_ata_of_match[] = {
+static const struct of_device_id mpc52xx_ata_of_match[] = {
 	{ .compatible = "fsl,mpc5200-ata", },
 	{ .compatible = "mpc5200-ata", },
 	{},
diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 201a32d..01161c1 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -67,7 +67,7 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 				     reg_shift, pio_mask, &pata_platform_sht);
 }
 
-static struct of_device_id pata_of_platform_match[] = {
+static const struct of_device_id pata_of_platform_match[] = {
 	{ .compatible = "ata-generic", },
 	{ },
 };
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index a723ae9..01734d5 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1612,7 +1612,7 @@ static int sata_fsl_resume(struct platform_device *op)
 }
 #endif
 
-static struct of_device_id fsl_sata_match[] = {
+static const struct of_device_id fsl_sata_match[] = {
 	{
 		.compatible = "fsl,pq-sata",
 	},
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 00ce26d..b66bcda 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4286,7 +4286,7 @@ static int mv_platform_resume(struct platform_device *pdev)
 #endif
 
 #ifdef CONFIG_OF
-static struct of_device_id mv_sata_dt_ids[] = {
+static const struct of_device_id mv_sata_dt_ids[] = {
 	{ .compatible = "marvell,armada-370-sata", },
 	{ .compatible = "marvell,orion-sata", },
 	{},
-- 
1.9.1

