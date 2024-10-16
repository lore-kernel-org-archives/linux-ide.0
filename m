Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E4220C03E
	for <linux-ide@vger.kernel.org>; Wed, 16 Oct 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088187; cv=none; b=H0PA2MqkThq9x3LWGLitXMNqEny91hE0Vhmwib9kgcccmN+kXPIAZPt0qY7z9Ws8KqDRgNbNkJZcMAP4jWEDO1Opqbg4AkjgAoPbvrjMQx34d3tWr40b4Ol8XOFNgysF9y1bVBsEozqs/xTfbL9PHO6Npj1T6TbhXDkP3RFZFck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088187; c=relaxed/simple;
	bh=vWIKPT2jD0h/J5XGaImIL9pHMDaCqO/1I7NREFgx56k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S9PwQYSITk9Lb/p7xaBaT8YfwKn5y//Ungcuyk5s53VHepk30xkVKKoOhUrfXUQUYOQG9gIFBlL4LmySAJUCptx9gfcmOfwM6RjVctGuS6T3zQg9YGwuwNVKLq64pIdt9oWLAX4QHEAkxsoWIN1iFb/5WADfc1PblZgPiVGnZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Qwuj6Qhb; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Qwuj6Qhb"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c94dd7e1c0so7300807a12.0
        for <linux-ide@vger.kernel.org>; Wed, 16 Oct 2024 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729088183; x=1729692983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oXloxXJzEyQWUcPe8HSSdcSMeQmgBuppB6liQFPUNB0=;
        b=Qwuj6QhbZsJ8q8USyKaldmbD/9Wmlj9DV2Nl9qCQitQqpPelXf+BFhLfIHDbDGcP7Z
         uKLHweV1fsPu9FBxKx0dUflRfEQ/FDZzh4WJOaVLhFUKLqsbNrtG8wQQwcYoM9B3DCOs
         27R8EPupZtD+Tb/U1Etc9vTSoh1o2JiMKsD+53DkPvsyJg+1QT6T556Q56BXhPFbK+8o
         VReOloZzcYBXOOdVD7o3mtR5kJJsjUR00iEIpNv85QkAM0e7vYbH9odAAH7XFlFS/pv1
         93Efl9ApDsROuIcse3BqKXnCEXoY4MjwBUyH2bmPCUYSnFob/O/+ETo/O+DCBDTBUORV
         yfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729088183; x=1729692983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXloxXJzEyQWUcPe8HSSdcSMeQmgBuppB6liQFPUNB0=;
        b=NgzYHxOdqX38+lBM/0TM5ZCMW41J1oF9GYUi+9bd3xaT+Cuclsn+D2CwPNzyQSFDzC
         u4veCFEuS+LRMu8cfyFja+osNLzHDb261z+czlImGApOzv6GX04HLVdlZto0yQBNIysS
         qsX3hS1LmqdB6pc68VsQB02k/Cn9J7K2zjLg9MI14vTTXNy9rWso+Bit+8braK5Fbb3r
         H7WvqAWwmSpAzWc3n1pwBh5WwN3LDy2ug0AzStTvUQ0SIu3ajk2hjsKVB0W6N7hp1V91
         gT+a4tkiYkJyKQN8sMgCDTi+RbYKqaoH6vDILNoQW080lWRGJQUbihnOz140Hlcc7zv5
         k6QQ==
X-Gm-Message-State: AOJu0Yz/0vrLdQKdaDBtKORXg1pwzhfJ+87pYT9ocu0gv77t9Wsg89c9
	thOsy25ZzkhU0lHCIAj82YZvL0s7Rb2F9Fbr64JSoaTF2T57XBK9RHAOJg3Lszg=
X-Google-Smtp-Source: AGHT+IFczaGwe+u7O1R8n5qQ4D8/jydEot8GD8O3YUioBzjQGS+isgKtQMpQo+e8Mw5Z1+o8mq6K3Q==
X-Received: by 2002:a05:6402:2685:b0:5c3:cc7d:c29d with SMTP id 4fb4d7f45d1cf-5c95ac09825mr11363593a12.6.1729088182497;
        Wed, 16 Oct 2024 07:16:22 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d778266sm1770643a12.70.2024.10.16.07.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 07:16:22 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH] ata: Switch back to struct platform_driver::remove()
Date: Wed, 16 Oct 2024 16:16:10 +0200
Message-ID: <20241016141609.27329-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=18577; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=vWIKPT2jD0h/J5XGaImIL9pHMDaCqO/1I7NREFgx56k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnD8qpr8nrz52MfIVwM41hg8S32eM9pXwbqbrB5 eLr8bFhTyKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZw/KqQAKCRCPgPtYfRL+ TnzrCACBMba9lIGz3OFPz/2M6ObIhDNV8NxvBLM3mlNOD8cjHRHnyLqvbnc/Om8B9ZngBzBQtM9 35+mWFWcurH5l3glfo5QSi93q4tg2GVksPJFrqZqfBlD3T/6G5m0GIUBIXg6U6Y2LYG1r4w+s9B 5L8hNZxe7M94/bKpjv7I4t2Re0aYFCadabXNVXWCfptUqXtOpuM1KkSeneS5p8wB/newL9SJpaZ 3laI9wsb/V3DnlhFjCRYSAARmTjFM9wl5bSTdBllqnMd+4wibuP0IsHmqcBCVGC1Y6DCJrO7JoV iwqfeHa9eBLJnacqiO6ETYFftiCHJSDrvHuUcmFoHm1G97uF
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/ata/ to use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

While touching these files, make indention of the struct initializer
consistent in several files.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I converted all of drivers/ata/ in a single patch because the individual
changes are really trivial. I also didn't Cc: the individual maintainers
to not trigger sending limits and spam filters.

Tell me if you want this split up.

Best regards
Uwe

 drivers/ata/ahci_brcm.c        |  2 +-
 drivers/ata/ahci_ceva.c        |  2 +-
 drivers/ata/ahci_da850.c       |  2 +-
 drivers/ata/ahci_dm816.c       |  2 +-
 drivers/ata/ahci_dwc.c         |  2 +-
 drivers/ata/ahci_imx.c         |  2 +-
 drivers/ata/ahci_mtk.c         |  2 +-
 drivers/ata/ahci_mvebu.c       |  2 +-
 drivers/ata/ahci_platform.c    |  2 +-
 drivers/ata/ahci_qoriq.c       |  2 +-
 drivers/ata/ahci_seattle.c     |  2 +-
 drivers/ata/ahci_st.c          |  2 +-
 drivers/ata/ahci_sunxi.c       |  2 +-
 drivers/ata/ahci_tegra.c       |  2 +-
 drivers/ata/ahci_xgene.c       |  2 +-
 drivers/ata/pata_arasan_cf.c   |  2 +-
 drivers/ata/pata_ep93xx.c      |  2 +-
 drivers/ata/pata_falcon.c      |  4 ++--
 drivers/ata/pata_ftide010.c    |  2 +-
 drivers/ata/pata_gayle.c       |  6 +++---
 drivers/ata/pata_imx.c         |  2 +-
 drivers/ata/pata_ixp4xx_cf.c   |  2 +-
 drivers/ata/pata_mpc52xx.c     |  2 +-
 drivers/ata/pata_of_platform.c |  2 +-
 drivers/ata/pata_platform.c    |  2 +-
 drivers/ata/pata_pxa.c         |  2 +-
 drivers/ata/pata_rb532_cf.c    |  2 +-
 drivers/ata/sata_dwc_460ex.c   |  2 +-
 drivers/ata/sata_fsl.c         |  2 +-
 drivers/ata/sata_gemini.c      |  2 +-
 drivers/ata/sata_highbank.c    | 12 ++++++------
 drivers/ata/sata_mv.c          |  2 +-
 drivers/ata/sata_rcar.c        |  2 +-
 33 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 2f16524c2526..ef569eae4ce4 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -571,7 +571,7 @@ static SIMPLE_DEV_PM_OPS(ahci_brcm_pm_ops, brcm_ahci_suspend, brcm_ahci_resume);
 
 static struct platform_driver brcm_ahci_driver = {
 	.probe = brcm_ahci_probe,
-	.remove_new = brcm_ahci_remove,
+	.remove = brcm_ahci_remove,
 	.shutdown = brcm_ahci_shutdown,
 	.driver = {
 		.name = DRV_NAME,
diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 11a2c199a7c2..1ec35778903d 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -402,7 +402,7 @@ MODULE_DEVICE_TABLE(of, ceva_ahci_of_match);
 
 static struct platform_driver ceva_ahci_driver = {
 	.probe = ceva_ahci_probe,
-	.remove_new = ata_platform_remove_one,
+	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ceva_ahci_of_match,
diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 55a6627d5450..ca0924dc5bd2 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -238,7 +238,7 @@ MODULE_DEVICE_TABLE(of, ahci_da850_of_match);
 
 static struct platform_driver ahci_da850_driver = {
 	.probe = ahci_da850_probe,
-	.remove_new = ata_platform_remove_one,
+	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_da850_of_match,
diff --git a/drivers/ata/ahci_dm816.c b/drivers/ata/ahci_dm816.c
index 4cb70064fb99..b08547b877a1 100644
--- a/drivers/ata/ahci_dm816.c
+++ b/drivers/ata/ahci_dm816.c
@@ -182,7 +182,7 @@ MODULE_DEVICE_TABLE(of, ahci_dm816_of_match);
 
 static struct platform_driver ahci_dm816_driver = {
 	.probe = ahci_dm816_probe,
-	.remove_new = ata_platform_remove_one,
+	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = AHCI_DM816_DRV_NAME,
 		.of_match_table = ahci_dm816_of_match,
diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
index ed263de3fd70..aec6d793f51a 100644
--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -478,7 +478,7 @@ MODULE_DEVICE_TABLE(of, ahci_dwc_of_match);
 
 static struct platform_driver ahci_dwc_driver = {
 	.probe = ahci_dwc_probe,
-	.remove_new = ata_platform_remove_one,
+	.remove = ata_platform_remove_one,
 	.shutdown = ahci_platform_shutdown,
 	.driver = {
 		.name = DRV_NAME,
diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 357aba1d5929..f01f08048f97 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -1027,7 +1027,7 @@ static SIMPLE_DEV_PM_OPS(ahci_imx_pm_ops, imx_ahci_suspend, imx_ahci_resume);
 
 static struct platform_driver imx_ahci_driver = {
 	.probe = imx_ahci_probe,
-	.remove_new = ata_platform_remove_one,
+	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = imx_ahci_of_match,
diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
index adc851cd5578..7295b9066ae2 100644
--- a/drivers/ata/ahci_mtk.c
+++ b/drivers/ata/ahci_mtk.c
@@ -174,7 +174,7 @@ MODULE_DEVICE_TABLE(of, ahci_of_match);
 
 static struct platform_driver mtk_ahci_driver = {
 	.probe = mtk_ahci_probe,
-	.remove_new = ata_platform_remove_one,
+	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_of_match,
diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index f3187351e8a6..8744dae41612 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -245,7 +245,7 @@ MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
 
 static struct platform_driver ahci_mvebu_driver = {
 	.probe = ahci_mvebu_probe,
-	.remove_new = ata_platform_remove_one,
+	.remove = ata_platform_remove_one,
 	.suspend = ahci_mvebu_suspend,
 	.resume = ahci_mvebu_resume,
 	.driver = {
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 81fc63f6b008..c18054333f7c 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -96,7 +96,7 @@ MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);
 
 static struct platform_driver ahci_driver = {
 	.probe = ahci_probe,
-	.remove_new = ata_platform_remove_one,
+	.remove = ata_platform_remove_one,
 	.shutdown = ahci_platform_shutdown,
 	.driver = {
 		.name = DRV_NAME,
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index b1a4e57578e2..30e39885b64e 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -357,7 +357,7 @@ static SIMPLE_DEV_PM_OPS(ahci_qoriq_pm_ops, ahci_platform_suspend,
 
 static struct platform_driver ahci_qoriq_driver = {
 	.probe = ahci_qoriq_probe,
-	.remove_new = ata_platform_remove_one,
+	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_qoriq_of_match,
diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
index 59f97aa7ac75..3f16c1678402 100644
--- a/drivers/ata/ahci_seattle.c
+++ b/drivers/ata/ahci_seattle.c
@@ -185,7 +185,7 @@ MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);
 
 static struct platform_driver ahci_seattle_driver = {
 	.probe = ahci_seattle_probe,
-	.remove_new = ata_platform_remove_one,
+	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.acpi_match_table = ahci_acpi_match,
diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index 79a8b0aa37bf..6b9b4a1dfa15 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -238,7 +238,7 @@ static struct platform_driver st_ahci_driver = {
 		.of_match_table = st_ahci_match,
 	},
 	.probe = st_ahci_probe,
-	.remove_new = ata_platform_remove_one,
+	.remove = ata_platform_remove_one,
 };
 module_platform_driver(st_ahci_driver);
 
diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 58b2683954dd..5d4584570ae0 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -292,7 +292,7 @@ MODULE_DEVICE_TABLE(of, ahci_sunxi_of_match);
 
 static struct platform_driver ahci_sunxi_driver = {
 	.probe = ahci_sunxi_probe,
-	.remove_new = ata_platform_remove_one,
+	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_sunxi_of_match,
diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 8703c2a4658b..44584eed6374 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -608,7 +608,7 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 
 static struct platform_driver tegra_ahci_driver = {
 	.probe = tegra_ahci_probe,
-	.remove_new = ata_platform_remove_one,
+	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = tegra_ahci_of_match,
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 7e6b4db8a1c2..dfbd8c53abcb 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -859,7 +859,7 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 
 static struct platform_driver xgene_ahci_driver = {
 	.probe = xgene_ahci_probe,
-	.remove_new = ata_platform_remove_one,
+	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = xgene_ahci_of_match,
diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index d0c6924d25b6..514d549286b5 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -964,7 +964,7 @@ MODULE_DEVICE_TABLE(of, arasan_cf_id_table);
 
 static struct platform_driver arasan_cf_driver = {
 	.probe		= arasan_cf_probe,
-	.remove_new	= arasan_cf_remove,
+	.remove		= arasan_cf_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.pm	= &arasan_cf_pm_ops,
diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index f3f5b2b0ecc9..e8cda988feb5 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -1015,7 +1015,7 @@ static struct platform_driver ep93xx_pata_platform_driver = {
 		.of_match_table = ep93xx_pata_of_ids,
 	},
 	.probe = ep93xx_pata_probe,
-	.remove_new = ep93xx_pata_remove,
+	.remove = ep93xx_pata_remove,
 };
 
 module_platform_driver(ep93xx_pata_platform_driver);
diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 18ceefd176df..334c4eea41ec 100644
--- a/drivers/ata/pata_falcon.c
+++ b/drivers/ata/pata_falcon.c
@@ -225,8 +225,8 @@ static void pata_falcon_remove_one(struct platform_device *pdev)
 
 static struct platform_driver pata_falcon_driver = {
 	.probe = pata_falcon_init_one,
-	.remove_new = pata_falcon_remove_one,
-	.driver   = {
+	.remove = pata_falcon_remove_one,
+	.driver = {
 		.name	= "atari-falcon-ide",
 	},
 };
diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 73a9a5109238..c3a8384c3e04 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -557,7 +557,7 @@ static struct platform_driver pata_ftide010_driver = {
 		.of_match_table = pata_ftide010_of_match,
 	},
 	.probe = pata_ftide010_probe,
-	.remove_new = pata_ftide010_remove,
+	.remove = pata_ftide010_remove,
 };
 module_platform_driver(pata_ftide010_driver);
 
diff --git a/drivers/ata/pata_gayle.c b/drivers/ata/pata_gayle.c
index 94df60ac2307..8602c3889948 100644
--- a/drivers/ata/pata_gayle.c
+++ b/drivers/ata/pata_gayle.c
@@ -202,9 +202,9 @@ static void pata_gayle_remove_one(struct platform_device *pdev)
 
 static struct platform_driver pata_gayle_driver = {
 	.probe = pata_gayle_init_one,
-	.remove_new = pata_gayle_remove_one,
-	.driver   = {
-		.name	= "amiga-gayle-ide",
+	.remove = pata_gayle_remove_one,
+	.driver = {
+		.name = "amiga-gayle-ide",
 	},
 };
 
diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index d0aa8fc929b4..b37682b0578f 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -249,7 +249,7 @@ MODULE_DEVICE_TABLE(of, imx_pata_dt_ids);
 
 static struct platform_driver pata_imx_driver = {
 	.probe		= pata_imx_probe,
-	.remove_new	= pata_imx_remove,
+	.remove		= pata_imx_remove,
 	.driver = {
 		.name		= DRV_NAME,
 		.of_match_table	= imx_pata_dt_ids,
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 8a9ee828478f..80f6a91acf6f 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -298,7 +298,7 @@ static struct platform_driver ixp4xx_pata_platform_driver = {
 		.of_match_table = ixp4xx_pata_of_match,
 	},
 	.probe		= ixp4xx_pata_probe,
-	.remove_new	= ata_platform_remove_one,
+	.remove		= ata_platform_remove_one,
 };
 
 module_platform_driver(ixp4xx_pata_platform_driver);
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 3f9258677915..210a63283f62 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -854,7 +854,7 @@ static const struct of_device_id mpc52xx_ata_of_match[] = {
 
 static struct platform_driver mpc52xx_ata_of_platform_driver = {
 	.probe		= mpc52xx_ata_probe,
-	.remove_new	= mpc52xx_ata_remove,
+	.remove		= mpc52xx_ata_remove,
 #ifdef CONFIG_PM_SLEEP
 	.suspend	= mpc52xx_ata_suspend,
 	.resume		= mpc52xx_ata_resume,
diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 4956f0f5b93f..178b28eff170 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -89,7 +89,7 @@ static struct platform_driver pata_of_platform_driver = {
 		.of_match_table = pata_of_platform_match,
 	},
 	.probe		= pata_of_platform_probe,
-	.remove_new	= ata_platform_remove_one,
+	.remove		= ata_platform_remove_one,
 };
 
 module_platform_driver(pata_of_platform_driver);
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 232c3dad7ee8..87479bc893b2 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -223,7 +223,7 @@ static int pata_platform_probe(struct platform_device *pdev)
 
 static struct platform_driver pata_platform_driver = {
 	.probe		= pata_platform_probe,
-	.remove_new	= ata_platform_remove_one,
+	.remove		= ata_platform_remove_one,
 	.driver = {
 		.name		= DRV_NAME,
 	},
diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 538bd3423d85..434f380114af 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -306,7 +306,7 @@ static void pxa_ata_remove(struct platform_device *pdev)
 
 static struct platform_driver pxa_ata_driver = {
 	.probe		= pxa_ata_probe,
-	.remove_new	= pxa_ata_remove,
+	.remove		= pxa_ata_remove,
 	.driver		= {
 		.name		= DRV_NAME,
 	},
diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 0fa253ad7c93..fd81e75c9402 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -164,7 +164,7 @@ static void rb532_pata_driver_remove(struct platform_device *pdev)
 
 static struct platform_driver rb532_pata_platform_driver = {
 	.probe		= rb532_pata_driver_probe,
-	.remove_new	= rb532_pata_driver_remove,
+	.remove		= rb532_pata_driver_remove,
 	.driver	 = {
 		.name   = DRV_NAME,
 	},
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 52f5168e4db5..6e1dd0d9c035 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1240,7 +1240,7 @@ static struct platform_driver sata_dwc_driver = {
 		.of_match_table = sata_dwc_match,
 	},
 	.probe = sata_dwc_probe,
-	.remove_new = sata_dwc_remove,
+	.remove = sata_dwc_remove,
 };
 
 module_platform_driver(sata_dwc_driver);
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 01aa05f4c3f5..87e91a937a44 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1589,7 +1589,7 @@ static struct platform_driver fsl_sata_driver = {
 		.of_match_table = fsl_sata_match,
 	},
 	.probe		= sata_fsl_probe,
-	.remove_new	= sata_fsl_remove,
+	.remove		= sata_fsl_remove,
 #ifdef CONFIG_PM_SLEEP
 	.suspend	= sata_fsl_suspend,
 	.resume		= sata_fsl_resume,
diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index f574e3c3f5b4..d040799bf9cb 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -425,7 +425,7 @@ static struct platform_driver gemini_sata_driver = {
 		.of_match_table = gemini_sata_of_match,
 	},
 	.probe = gemini_sata_probe,
-	.remove_new = gemini_sata_remove,
+	.remove = gemini_sata_remove,
 };
 module_platform_driver(gemini_sata_driver);
 
diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 63ef7bb073ce..b1b40e9551de 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -614,12 +614,12 @@ static SIMPLE_DEV_PM_OPS(ahci_highbank_pm_ops,
 		  ahci_highbank_suspend, ahci_highbank_resume);
 
 static struct platform_driver ahci_highbank_driver = {
-	.remove_new = ata_platform_remove_one,
-        .driver = {
-                .name = "highbank-ahci",
-                .of_match_table = ahci_of_match,
-                .pm = &ahci_highbank_pm_ops,
-        },
+	.remove = ata_platform_remove_one,
+	.driver = {
+		.name = "highbank-ahci",
+		.of_match_table = ahci_of_match,
+		.pm = &ahci_highbank_pm_ops,
+	},
 	.probe = ahci_highbank_probe,
 };
 
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 05c905827dc5..b8f363370e1a 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4255,7 +4255,7 @@ MODULE_DEVICE_TABLE(of, mv_sata_dt_ids);
 
 static struct platform_driver mv_platform_driver = {
 	.probe		= mv_platform_probe,
-	.remove_new	= mv_platform_remove,
+	.remove		= mv_platform_remove,
 	.suspend	= mv_platform_suspend,
 	.resume		= mv_platform_resume,
 	.driver		= {
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index c1469d076880..22820a02d740 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -1009,7 +1009,7 @@ static const struct dev_pm_ops sata_rcar_pm_ops = {
 
 static struct platform_driver sata_rcar_driver = {
 	.probe		= sata_rcar_probe,
-	.remove_new	= sata_rcar_remove,
+	.remove		= sata_rcar_remove,
 	.driver = {
 		.name		= DRV_NAME,
 		.of_match_table	= sata_rcar_match,

base-commit: 15e7d45e786a62a211dd0098fee7c57f84f8c681
-- 
2.45.2

