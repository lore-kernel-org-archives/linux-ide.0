Return-Path: <SRS0=Oljn=EK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD715C388F9
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC91205ED
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="SdBhv5wT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgKDP4R (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:56:17 -0500
Received: from mail-db8eur05on2122.outbound.protection.outlook.com ([40.107.20.122]:47808
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730972AbgKDPwv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 4 Nov 2020 10:52:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8m82ojk4T2qbgtzrNlpwOZMVqbJq9vOaDEdUPuj1m0lvXCncRXaQ0YL0ZsSW6PgN0WQ1hheRPH+RZ18yARkcGR5S75WHwRUx0fpUaQmtsnxVt0WdjDYrU3iS2tsDyiahGW88CZaxuFJoteIF9jvMHaj+0G6E+mBmuTio1yfu/QmcnV4glzduFvjGpS6qU9wW3XgoY9byzwHVYZrJBLI6ZuhbcakhBXV/WJE3kY6pHEcmjNi03fmrKVKKLdGtHQhurxM+VkybCGFc4AHOl8qwoh7/NRiyFSm9XEWDfU9peklL9KM/tPk+W/+LTjPsqosTI3psR10xv7zOwB0Qjw51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGh8gm4fxG7CPEVbuaNZ529cl9J5n29Ky6yFdYxE6JI=;
 b=EEWnHyHvGz1Z0pD5QrB3hRlQpYqtPEYQ4G3JAv/EsVN0e+vPlDqVKcrcp1X/2U3SGGYPdq1MGFlL9DOeENmNwLMJACMFo2kC97bFOsp//9pTVlICeiKbbKYAj+Mm9OjL13vDMuk665bLbBMQkZkPqDrbVyvafiRFwJ6+SxVFBCMBqJAhSrJJzYtCvZjP7ZxPg4DnUEEZ6xVvEIIEtBnqUZ8fbNb2zFAi1+U8YrQ6A7EPQfrB/46zVpAL7WfQ/TgW3BvfRZPoquxcqT4r8qSzcXVFEIsrYb+mFcuKURfMqv+8gk5nCgf7zeNS9tz86/sH2VGrkBSQ4oI3YRTwtNdgbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGh8gm4fxG7CPEVbuaNZ529cl9J5n29Ky6yFdYxE6JI=;
 b=SdBhv5wTiEGKMt+xFj5+Z8RJsLSrLAS90T5YKiImIWTLcuRRcQVFeNkDD6FjpfRPIcRofizRZUzoRnErmMhsKo7V1P/lekBrSELdCzEhffW8iAyJkBPrNQZbyOTgQutGHzIQ8vBpA0UwaNz0c9QHa3pVg2CRl9/AG4yIucXxGek=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM8PR05MB7522.eurprd05.prod.outlook.com (2603:10a6:20b:1c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 4 Nov
 2020 15:52:43 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 15:52:43 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v2 3/9] ata: ahci: custom irq init for host init
Date:   Wed,  4 Nov 2020 16:52:31 +0100
Message-Id: <20201104155237.77772-4-sven.auhagen@voleatech.de>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201104155237.77772-1-sven.auhagen@voleatech.de>
References: <20201104155237.77772-1-sven.auhagen@voleatech.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.193.235.168]
X-ClientProxiedBy: AM8P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::35) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (109.193.235.168) by AM8P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 4 Nov 2020 15:52:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8035cf02-f4b0-43f0-bf36-08d880d9aa80
X-MS-TrafficTypeDiagnostic: AM8PR05MB7522:
X-Microsoft-Antispam-PRVS: <AM8PR05MB7522FDD9DAD73E21CEBC3307EFEF0@AM8PR05MB7522.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agSk88d3ncHcPqM15aGwdqetfa8bm1UrFdIpuCCSHSoKcy9VJJzLMJxFtkaFtOVLui2Cs6vO3l2mBdLR1ydEVGzc1JJKuQP5ZNfgEnHywmyayFmHuXO0nllFUtXVdG6nqKlJQ4UPLkRdmifUILY435LK413a3n4IrhX0fv2UasVDTPniqQoWigPiLNYTdNrpfeFN/Y9kTeIZMM7P/sZcpVcPe0GO6qVX25oPZPqH9gkF3DMBvVu1NurwIACTd3L6Qo/YO1qjKhRgJNPVPZqpCLlyrtHpQHNWFbgTfZjVnzivMDWxzGLy/Y4ZvTFiOBcv58g0CXNR/c8sKMIig6/aF4PG6NbyP4naazucMaAjG+QeCeKluF668jhNZayTJ9i0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39830400003)(26005)(8676002)(36756003)(956004)(83380400001)(2616005)(86362001)(186003)(69590400008)(16526019)(1076003)(4326008)(66476007)(66556008)(52116002)(2906002)(6506007)(6666004)(316002)(8936002)(5660300002)(9686003)(478600001)(6512007)(7416002)(66946007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: EVs8g/cjZOlpRSnUX5qBClmf/bb3q9K4oA5Pz88We3sdBqLhzdl70wGayltiPD/dacKIij11IdGmA0Eofkw8JgXh8lKiU1aCZTwM+aPS++MacU/6+EEDdgk8Iiuho13UW8OcmP9gOaa3EZ9XVPLX30btNOnLvEiRba3kI8EC32VVffT+5CjP243U1REaP56GniKl992AKcKmWo2/YgvNqeR/c759BtsC3YN1sDf+xJ7sZJXdsPdEChW7Y5zpCc+g+OqXgfM+KDl20uywEUiReIYj97hNZXRaggvqO5KhQ/wVymDU9K0ATyWO4eeNnKLl6H1sgYsKvcevpRZIKNBe4cYkCMCENc7ib0m/tz5+6Ni4JhFud5cKtFckyIKKKKpdRQu6ij0DHLna1kDn9/8OPtMnCFfxoL+Saq83agrrIsbbU5o8qU63Mjgdru6K1uBQU1clUJ9dQeChCYmtcL+GxMuZ/Y+jLqqZZBzFiWLoImMhZtt9J/mV07SbXlz4g23mgnYFp3wpPue7BdQkxfHIcT0+kqUX//k+GoQ2IXO9CzFrMTuGnis9EqdkYPSserJwshk/wWg6+GceP7xqCwCAXssVj8HrrTgBn2Z1N1aM5u+wsuyGbDdwrLJiXko2QaA4SQYbkdEKEdc8ph28Hgf6eQ==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8035cf02-f4b0-43f0-bf36-08d880d9aa80
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 15:52:43.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfC8YBeqOernBWwy8I8X9wMAxsyr6SFXJZFPR1qSGcFykNPEwBPzRot9xPnMSevjqi/rD0Vqfip+sTxsI9SwMFoj2pbSstT/lS5TjVhu4no=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB7522
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Sven Auhagen <sven.auhagen@voleatech.de>

Disable the platform irq init in ahci init platform host
if it was initiated by a custom function.
To check for it I am using the AHCI_HFLAG_MULTI_MSI flag.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
---
 drivers/ata/libahci_platform.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index de638dafce21..f6f2a111d226 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -581,14 +581,16 @@ int ahci_platform_init_host(struct platform_device *pdev,
 	struct ata_host *host;
 	int i, irq, n_ports, rc;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "no irq\n");
-		return irq;
-	}
+	if (!(hpriv->flags & AHCI_HFLAG_MULTI_MSI)) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq <= 0) {
+			if (irq != -EPROBE_DEFER)
+				dev_err(dev, "no irq\n");
+			return irq;
+		}
 
-	hpriv->irq = irq;
+		hpriv->irq = irq;
+	}
 
 	/* prepare host */
 	pi.private_data = (void *)(unsigned long)hpriv->flags;
-- 
2.20.1

