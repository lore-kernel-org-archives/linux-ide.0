From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] ata: Make of_device_id array const
Date: Wed, 18 Jun 2014 12:40:27 +0900
Message-ID: <005001cf8aa7$0b871f50$22955df0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49508 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932489AbaFRDke (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2014 23:40:34 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N7C00GCCI7KJNC0@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Wed, 18 Jun 2014 12:40:32 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Make of_device_id array const, because all OF functions handle
it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ata/ahci_st.c          |    2 +-
 drivers/ata/pata_macio.c       |    2 +-
 drivers/ata/pata_mpc52xx.c     |    2 +-
 drivers/ata/pata_octeon_cf.c   |    2 +-
 drivers/ata/pata_of_platform.c |    2 +-
 drivers/ata/sata_fsl.c         |    2 +-
 drivers/ata/sata_mv.c          |    2 +-
 drivers/ata/sata_rcar.c        |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index 2595598..29821b9 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -221,7 +221,7 @@ static int st_ahci_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(st_ahci_pm_ops, st_ahci_suspend, st_ahci_resume);
 
-static struct of_device_id st_ahci_match[] = {
+static const struct of_device_id st_ahci_match[] = {
 	{ .compatible = "st,ahci", },
 	{},
 };
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
index ccd1c83..212a2f7 100644
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
index 2a97d3a..8bac55b 100644
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
index a7e95a5..8b23a3e 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -77,7 +77,7 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 				     reg_shift, pio_mask);
 }
 
-static struct of_device_id pata_of_platform_match[] = {
+static const struct of_device_id pata_of_platform_match[] = {
 	{ .compatible = "ata-generic", },
 	{ .compatible = "electra-ide", },
 	{},
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 616a6d2..33b14a5 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1610,7 +1610,7 @@ static int sata_fsl_resume(struct platform_device *op)
 }
 #endif
 
-static struct of_device_id fsl_sata_match[] = {
+static const struct of_device_id fsl_sata_match[] = {
 	{
 		.compatible = "fsl,pq-sata",
 	},
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 391cfda..072290a 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4265,7 +4265,7 @@ static int mv_platform_resume(struct platform_device *pdev)
 #endif
 
 #ifdef CONFIG_OF
-static struct of_device_id mv_sata_dt_ids[] = {
+static const struct of_device_id mv_sata_dt_ids[] = {
 	{ .compatible = "marvell,armada-370-sata", },
 	{ .compatible = "marvell,orion-sata", },
 	{},
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 61eb6d7..d0792fc 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -823,7 +823,7 @@ static void sata_rcar_init_controller(struct ata_host *host)
 	iowrite32(ATAPI_INT_ENABLE_SATAINT, base + ATAPI_INT_ENABLE_REG);
 }
 
-static struct of_device_id sata_rcar_match[] = {
+static const struct of_device_id sata_rcar_match[] = {
 	{
 		/* Deprecated by "renesas,sata-r8a7779" */
 		.compatible = "renesas,rcar-sata",
-- 
1.7.10.4


