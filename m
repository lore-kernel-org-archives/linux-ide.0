Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4793C10F29
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 08:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4CF20674
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 08:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="azb1qjUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgCQI4X (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:56:23 -0400
Received: from mail-eopbgr50058.outbound.protection.outlook.com ([40.107.5.58]:20355
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbgCQI4W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 17 Mar 2020 04:56:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD37Ht1ULx8DxYVFLsAuG1GuXdptmgp7lK01VPZgqwyBD8I7e0EiVgr7l/ognnb7RtE7A6pdOeK8jy1VQk7j/6ihu1i56LE0kndEyLidfqGtwL8ZD7sFf3Me4WEZ81JnbF2ZR0qp0y/TtTHD5KGIP2wPu0edpR62BuXLwennzJUpEuLmAfJbTjtCtJE7ADOVvpXppuwG2wKjYGyQgccVkbRmCukFFAWAmtZLnXb1J+/jBcZnqLyRz0KKb38eWvAWjREV+U7Hcvp4SqwGQP5+AWIXeqnCPs2xs/l9gQyM+ALEKHqVpDkCJNlemxxgKgtIY7USnwi5XbR+ZmQxUlr/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUwk74+bJFeLafMQBjpLQkYQnkx6+DwDjioK6mgjbLA=;
 b=C41pfnWrxvVrG4nlQ9xqFDzi6SwXznsJbAPBYxTLUA9nOjP+T5ClgwaLaJQzKL8mku8x+FGdHb5qWN/jiGjrP9MO5gVWS5PC3vLE3t+1suEq9Brkm86W3QtOmByUMblpxEzWdkmeORNDftYnf+C+nE7S3s7oIf2bt0dgnkVdXN6KULArF06jh9b26DfHXLkXvPjSbIUn1gzhXHY/BqfrB4pABbwuZEhaBRjqT2JlEjfob16oI1B2j7YsjmLzRWL1oMSJsD6C1NcdXukKVTuQwuHBga+pIoKBmbW2KmksRJ/lycOS0nWjmtIE/LBIzUDFsv+q9NM/OhXLvpn7esVCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUwk74+bJFeLafMQBjpLQkYQnkx6+DwDjioK6mgjbLA=;
 b=azb1qjUS8EtGERkLWHr3EpNMiITb70bolZabrHqXLvM6+wV5eomNudrsFCdstC71c2V4Lvm++1YO4qUrjlLIDZiYjNCq3p/i3yadkDKl6oAvy3/dXQOKMF+1p98wbGlVBFJT8WxPNFNgZR/MYEAXUzU6nhkbq+aU+iaxsLQ7sxw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
Received: from AM7PR04MB7016.eurprd04.prod.outlook.com (52.135.58.214) by
 AM7PR04MB7109.eurprd04.prod.outlook.com (52.135.57.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18; Tue, 17 Mar 2020 08:56:19 +0000
Received: from AM7PR04MB7016.eurprd04.prod.outlook.com
 ([fe80::14c2:8800:1248:ddfa]) by AM7PR04MB7016.eurprd04.prod.outlook.com
 ([fe80::14c2:8800:1248:ddfa%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 08:56:19 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     axboe@kernel.dk
Cc:     leoyang.li@nxp.com, andy.tang@nxp.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Udit Kumar <udit.kumar@nxp.com>,
        Peng Ma <peng.ma@nxp.com>
Subject: [PATCH] ahci_qoriq: enable acpi support in qoriq ahci driver
Date:   Tue, 17 Mar 2020 16:52:54 +0800
Message-Id: <20200317085254.40795-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0104.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::30) To AM7PR04MB7016.eurprd04.prod.outlook.com
 (2603:10a6:20b:11e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR01CA0104.apcprd01.prod.exchangelabs.com (2603:1096:3:15::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16 via Frontend Transport; Tue, 17 Mar 2020 08:56:16 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0bf27c23-a18d-446b-709c-08d7ca510f11
X-MS-TrafficTypeDiagnostic: AM7PR04MB7109:|AM7PR04MB7109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB71092A8FF47343A36AA88EC7EDF60@AM7PR04MB7109.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:299;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(6506007)(4326008)(52116002)(69590400007)(6512007)(66946007)(6666004)(66476007)(66556008)(1076003)(36756003)(2616005)(956004)(81166006)(44832011)(6486002)(54906003)(478600001)(2906002)(86362001)(16526019)(186003)(81156014)(8936002)(6916009)(8676002)(5660300002)(26005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR04MB7109;H:AM7PR04MB7016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyLzg0+UKp6ZPz31FD6sky+QvAsneZko+1f9Voh7OOwbm9GMruJBJ8mgGZVBD5zcZOgKr1XvDXy5OICcZwi3Djp6eVwE/j+nvz+ukpN716P20gzmSTk6mxnX00v4YmzvBsJi4skzcyxYQBYQhqrTRi3Ez7t3akRMiVyL9DqZxC/uQK4Tj3a7w5M1n41OtRTSn5rBOomIooP5ApoA676sff7CQRAb+1tVtwPifZAgYbDwj//QEjGrwQ9vDpGzYhQ7fm7vjnJYwRngkYnOj/taRD7jm45+Tch/ZZjQteljfH2szJF06Wh6Uuk8FTunpDyIusSce5ceszPSdhvaCbTESMWiZtlGtj7nq2hYsbfaQzpwTZoJPrzx540qOAze+oAp2pIHcAJ0u9fDqYIgVPFiILaRwpJ26lsYnUZXRsRqWIqyTJ/djz9Y/w3/KBGU/3Nd8Hen/V1Oel8pWgP02fZH7+6G8QvpJVYF1l6uHRy1HutXgrmt8HG4zZyZJF13O/ih
X-MS-Exchange-AntiSpam-MessageData: kJUCIILO+ACGkpLHBYDk3O/roTXF5OrR9GTfLQcQUsgqF5qlwxWOa5Rg0yvOmXSlqHN9udn0Zel6e4W/tnfyN+Uc12ywRGvvcr0LRa4j54XE+6z2uCbOHixzfIM5rNJtR7PI15DC6LpKuEBKHcs6Tg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf27c23-a18d-446b-709c-08d7ca510f11
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 08:56:19.2467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yltehquZr5N7FULKU2SgFaZIAMe586CNszG3n/+zUcz092XVvzDHBsaPrq87ejUa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7109
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Udit Kumar <udit.kumar@nxp.com>

This patch enables ACPI support in qoriq ahci driver.

Signed-off-by: Udit Kumar <udit.kumar@nxp.com>
Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 drivers/ata/ahci_qoriq.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index a330307..f0f7723 100644
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
@@ -261,25 +268,28 @@ static int ahci_qoriq_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	struct resource *res;
 	int rc;
+	const struct acpi_device_id *acpi_id;
 
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
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
-		res = platform_get_resource_byname(pdev,
-						   IORESOURCE_MEM,
-						   "sata-ecc");
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 		if (res) {
 			qoriq_priv->ecc_addr =
 				devm_ioremap_resource(dev, res);
@@ -288,7 +298,8 @@ static int ahci_qoriq_probe(struct platform_device *pdev)
 		}
 	}
 
-	qoriq_priv->is_dmacoherent = of_dma_is_coherent(np);
+	if (device_get_dma_attr(&pdev->dev) == DEV_DMA_COHERENT)
+		qoriq_priv->is_dmacoherent = true;
 
 	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
@@ -354,6 +365,7 @@ static struct platform_driver ahci_qoriq_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_qoriq_of_match,
+		.acpi_match_table = ahci_qoriq_acpi_match,
 		.pm = &ahci_qoriq_pm_ops,
 	},
 };
-- 
2.9.5

