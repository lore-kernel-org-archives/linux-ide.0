Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCB7C55ABD
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3983D20578
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="EuREpoQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbgKIRj5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:39:57 -0500
Received: from mail-db8eur05on2090.outbound.protection.outlook.com ([40.107.20.90]:23136
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731177AbgKIRj5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 9 Nov 2020 12:39:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3PYQdB8epLOnO5O05IrdO5Skm4QD5T4jUa/uMdyVDM2lw0vsFeskuK6pfkFn9C26sW3ycYlbe19Jaov9vBx+JLTSghkGqPb04DcdM8JQPPrfgDoaLSot3XK9eIsk7ptpj2JaH1puJilIHqyd/9IaUlCfVT1Gz2Vm2fK34tJFkTVXT+f1wdWVX39OrSkocNXuIJa1YcCoRmEy9IRREVerOqP5Ero6e++r1hIpnIuixUwW5YibrpJrC0VBmuGE9UbqEq7wkSqkPfPwQG8shfElnXq8HXx26ncfgH8yEFqg9Slx0i68xYAFVvrzmYOmVpIJUI+M8xPFKhMRA38NmeZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+AHlxDp/2rLfOqNx3TEGg5cFQmh1rhD6yRpxO8B3gA=;
 b=avJJzwGp6eRVQgVNTwBSIbFLrcwI5ByG4v34Vb1f6k2tIILMLoGCh2Kol2Y+1picGyOWlTnwxWqyu30826T5mOrjS3WgjnvfeVKZlUiDoTx+VoaXMTykMb4Ekuc4T7UZ/U77cnrHUIUBtEO+OYP+3rDIsyuQ4+Ff1cEX/xxpkCVWnS4/eurPguMz22c6TBq43jyhTe73XB6GzzKzVV0HRjJWd9iLTTQmfhokb8JBaameznOhLfJW97G+8QaRQUAklT0YpBYt5+G+Q08LH9tkliQsKI8w8TLvs1i/Y6CX0iZnP29xN2T8ey7TKMN1VMdwL0eH4oW7jYq49lVpwldkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+AHlxDp/2rLfOqNx3TEGg5cFQmh1rhD6yRpxO8B3gA=;
 b=EuREpoQArdCCS123aVTQS7loAMyHa5GAl1Hfa7BrAlMMrOu1o4w0ywTi6Q4TTFyu5STLSJ7Wj2opArg5LW8SElqrqj1pt+H07qnS2uDy4bJrqaoMiej3FKVssXP8VAgwZStkgOGF+dFU5OQwicR6GhII7oB8ae2PPP1nb4WcRkI=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5362.eurprd05.prod.outlook.com (2603:10a6:208:ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 17:39:52 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 17:39:51 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v3 1/9] ata: ahci: mvebu: Rename a platform data flag
Date:   Mon,  9 Nov 2020 18:39:40 +0100
Message-Id: <20201109173948.96663-2-sven.auhagen@voleatech.de>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201109173948.96663-1-sven.auhagen@voleatech.de>
References: <20201109173948.96663-1-sven.auhagen@voleatech.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.193.235.168]
X-ClientProxiedBy: AM0PR04CA0135.eurprd04.prod.outlook.com
 (2603:10a6:208:55::40) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (109.193.235.168) by AM0PR04CA0135.eurprd04.prod.outlook.com (2603:10a6:208:55::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 17:39:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76127a2f-128c-48f7-1b47-08d884d67672
X-MS-TrafficTypeDiagnostic: AM0PR05MB5362:
X-Microsoft-Antispam-PRVS: <AM0PR05MB5362210C8B8F932830DC3B9BEFEA0@AM0PR05MB5362.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y06Ujzvg6ILhURYx6btt3VW+Ma5pLU8npwJBkzY9qEFs3VqdE3u73o02YyzmUDzrKwtzkJcAuk98QUChuCOxqrSKxEpV6S6+8q2Bq3jILq2dalz/yeTF9ibHz089tdOFSvjnLM6CCg2rKwiT4IAR4D9hQqpUAnjZYg52lXahix/YzFDvcHMZfm747abcPSUDpSGw4QAzTE36nQsGSK6FRcluttlGJqTMvozKOBvi2rP7KdTnyyROlSlFD1pbRwXIF9+cTDED0W7sJ8CcI6ntxACG25bVOJRO1y+Olug3EX4rdjimWIt14XdC02DeGyT4MK6Mf9AQ0Vf6VWyw2qOIO2v1SWSkM5IMEA+Lu7Gf8zFVKBu9bYOp+w5j/XLKUv9o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39830400003)(52116002)(69590400008)(66946007)(5660300002)(1076003)(66476007)(66556008)(26005)(2906002)(478600001)(316002)(9686003)(6506007)(6512007)(86362001)(6666004)(16526019)(8936002)(956004)(4326008)(36756003)(7416002)(186003)(83380400001)(2616005)(8676002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /skJgeY7i9BYnyC2lC/ompH7zz0lxz2SUPqk0WZEQOrP0jrSo9xpChoCH5xUP6hhB+gq87xJ4SgK4vrbKs6CnvviEzJYsphRKAoEsbkFnS+zGYeDg3SNBQUBMl1Hbve9i5xmN5rJKLWgIO263QvHRq82ZZ2jJBCYyffTvWKCPQM400XFIO5HRoy3b85VhUCwbYoZYZk2oSMJSPopavyU3jFcExDuAXzovOpu3Dzglcmn4tiPo9mMxZNYeG7hcazHdF9vfnRVHzVRuX979jI6GfnFoChY3JI/bfq3sNM3ysJVXRz8d/3XhtPDauqWjfCWr+5zjkcUXpxwb5CTOI6Qotn4BqdSK6yCuXmCtJm3NqhnL1onVDCEM45R5X5HPtI0fC5t71CQrUjhQ+glvgs2K//DSHu3YBqvshou1Iqzz3803RLewuwSU+1hOw6YutqvlUso2YeAXUEmTiaU4SQGz6643BlN77IrTbwfo26AeJXXbdiBSxL+Bao2tk0DIIakeoYXaNqSRqYadjP/A3jGqFUF31ssTuV+yzuNKZtKQo/KjLHAQGfACb4oX3HaGPJxQBAfqklHQ+FUrRdnnh4fz1kjhnGzGh7ANRiu2lBI8joQwWBO5IcOSH/1LwUx49R67G4mgxC0JS3qFLd3RZO2PQ==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 76127a2f-128c-48f7-1b47-08d884d67672
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 17:39:51.9077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qN57ta8xDUFtQ7+iQa3hjL25BEnVqV2DHYqH1drh4LCaIUAR/NiGTA05dwRwRsJ1NaBipkfGFKu6KYDKhfogYgBit2aBVWjC+pQGI7Hgoc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5362
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Before adding more entries in the platform data structure, rename the
flags entry to be more precise and name it host_flags.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 3ad46d26d9d5..563cc4c64d96 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -30,7 +30,7 @@
 
 struct ahci_mvebu_plat_data {
 	int (*plat_config)(struct ahci_host_priv *hpriv);
-	unsigned int flags;
+	unsigned int host_flags;
 };
 
 static void ahci_mvebu_mbus_config(struct ahci_host_priv *hpriv,
@@ -196,7 +196,7 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
-	hpriv->flags |= pdata->flags;
+	hpriv->flags |= pdata->host_flags;
 	hpriv->plat_data = (void *)pdata;
 
 	rc = ahci_platform_enable_resources(hpriv);
@@ -227,7 +227,7 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_380_plat_data = {
 
 static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
 	.plat_config = ahci_mvebu_armada_3700_config,
-	.flags = AHCI_HFLAG_SUSPEND_PHYS | AHCI_HFLAG_IGN_NOTSUPP_POWER_ON,
+	.host_flags = AHCI_HFLAG_SUSPEND_PHYS | AHCI_HFLAG_IGN_NOTSUPP_POWER_ON,
 };
 
 static const struct of_device_id ahci_mvebu_of_match[] = {
-- 
2.20.1

