Return-Path: <SRS0=rcVg=B3=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170C7C433E1
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 08:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15A920658
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 08:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgHQI3Z (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:29:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45170 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbgHQI3X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 17 Aug 2020 04:29:23 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 451011A0078;
        Mon, 17 Aug 2020 10:29:21 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D409F1A0CB3;
        Mon, 17 Aug 2020 10:29:18 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7B9A6402BE;
        Mon, 17 Aug 2020 10:29:15 +0200 (CEST)
From:   andy.tang@nxp.com
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuantian Tang <andy.tang@nxp.com>,
        Udit Kumar <udit.kumar@nxp.com>
Subject: [PATCH] ahci: qoriq: enable acpi support in qoriq ahci driver
Date:   Mon, 17 Aug 2020 16:22:04 +0800
Message-Id: <20200817082204.13523-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

This patch enables ACPI support in qoriq ahci driver.

Signed-off-by: Udit Kumar <udit.kumar@nxp.com>
Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 drivers/ata/ahci_qoriq.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index a330307d3201..5b46fc9aeb4a 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -6,6 +6,7 @@
  *   Tang Yuantian <Yuantian.Tang@freescale.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pm.h>
@@ -80,6 +81,12 @@ static const struct of_device_id ahci_qoriq_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ahci_qoriq_of_match);
 
+static const struct acpi_device_id ahci_qoriq_acpi_match[] = {
+	{"NXP0004", .driver_data = (kernel_ulong_t)AHCI_LX2160A},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, ahci_qoriq_acpi_match);
+
 static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline)
 {
@@ -255,6 +262,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 static int ahci_qoriq_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	const struct acpi_device_id *acpi_id;
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	struct ahci_qoriq_priv *qoriq_priv;
@@ -267,14 +275,18 @@ static int ahci_qoriq_probe(struct platform_device *pdev)
 		return PTR_ERR(hpriv);
 
 	of_id = of_match_node(ahci_qoriq_of_match, np);
-	if (!of_id)
+	acpi_id = acpi_match_device(ahci_qoriq_acpi_match, &pdev->dev);
+	if (!(of_id || acpi_id))
 		return -ENODEV;
 
 	qoriq_priv = devm_kzalloc(dev, sizeof(*qoriq_priv), GFP_KERNEL);
 	if (!qoriq_priv)
 		return -ENOMEM;
 
-	qoriq_priv->type = (enum ahci_qoriq_type)of_id->data;
+	if (of_id)
+		qoriq_priv->type = (enum ahci_qoriq_type)of_id->data;
+	else
+		qoriq_priv->type = (enum ahci_qoriq_type)acpi_id->driver_data;
 
 	if (unlikely(!ecc_initialized)) {
 		res = platform_get_resource_byname(pdev,
@@ -288,7 +300,8 @@ static int ahci_qoriq_probe(struct platform_device *pdev)
 		}
 	}
 
-	qoriq_priv->is_dmacoherent = of_dma_is_coherent(np);
+	if (device_get_dma_attr(&pdev->dev) == DEV_DMA_COHERENT)
+		qoriq_priv->is_dmacoherent = true;
 
 	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
@@ -354,6 +367,7 @@ static struct platform_driver ahci_qoriq_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_qoriq_of_match,
+		.acpi_match_table = ahci_qoriq_acpi_match,
 		.pm = &ahci_qoriq_pm_ops,
 	},
 };
-- 
2.17.1

