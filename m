Return-Path: <SRS0=Oljn=EK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46D1C2D0A3
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C73204EF
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="VhJWhkSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgKDP43 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:56:29 -0500
Received: from mail-db8eur05on2122.outbound.protection.outlook.com ([40.107.20.122]:47808
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730832AbgKDPwp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 4 Nov 2020 10:52:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9uEGzn/7h0cZ02XL61l/0Shu8GY8eDeVIfT50tLzIZGCv3tDSYQ8eO7wCrwW4PnRRKFujEZPaB2SJ/pJoe2z/MZE/ZQ5u7vKcdAhvd8xNc2FGq2Nz+dgyXrdYZJkeRS5gwvl82885MuIt1g1rKN0Q447P8O+xCr8DUZd9Ayeil/6o5KhrpNPGAxGazNb7wwKwehEcbpMTWC+NIDPULhlUOerTDPV13wum4LWtRWFNXqDsla/qAMCASVdNX8l0mEqNSno++bEMuN5G2jIsE55RM/mKxmlQh/uKwcF0rrjKiAtfusm9K5sk2Slcwkbs7NIHayqumuaiiuxVUFWqPrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+AHlxDp/2rLfOqNx3TEGg5cFQmh1rhD6yRpxO8B3gA=;
 b=FjpEXdkubsFhO9rlSJuE7pOr6nz5rqBgvEgE5H4jm85FPeYMs+iSn7z13BfrTWoaq6RtJAxt/XYSVvIs5+C0/i2850rnL1LliYVdrILO0JWmQ3gfhNV27/rz1LsjjM/wxfndSoi4iRbutX1/Ylo5tGn3XYS+GB3GDljoSdEyJLdSLEmwDBl+ick8KKbAa+racG9b+eHF7MnJ0y6E9tmYegvbu/+1MOgSTrusX3QojMcOYKEpezr7z3XLtDFFgNLRnRQBhzXDs8IMfiLzM1vN16WI0brVpxqhT3eFGZTV8BAdtOGnU7Wzocl23vlNQa/Aiofq4YDDhnkkkvKTR4JB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+AHlxDp/2rLfOqNx3TEGg5cFQmh1rhD6yRpxO8B3gA=;
 b=VhJWhkShZepR2IseFvRQbpw/9bj5Bp/YNVpKfoHdieGWEx364SoHr2l6ej+dBoeucDWKCVHxfdUg6Zb8IVaWTMiHD14/Kgv27hiM7MzU6/rhwNX6IILm7hJ9OAQGRP8cv882N2ZkQqtjGYF3IeoaFDLhnoR5bzWszElaRuVTDig=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM8PR05MB7522.eurprd05.prod.outlook.com (2603:10a6:20b:1c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 4 Nov
 2020 15:52:41 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 15:52:41 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v2 1/9] ata: ahci: mvebu: Rename a platform data flag
Date:   Wed,  4 Nov 2020 16:52:29 +0100
Message-Id: <20201104155237.77772-2-sven.auhagen@voleatech.de>
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
Received: from localhost.localdomain (109.193.235.168) by AM8P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 4 Nov 2020 15:52:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91b3b023-144b-4096-9bdd-08d880d9a980
X-MS-TrafficTypeDiagnostic: AM8PR05MB7522:
X-Microsoft-Antispam-PRVS: <AM8PR05MB7522708B542CCCC507027307EFEF0@AM8PR05MB7522.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpqf3EGaW54+CPUExLD0MpTz2ZqNNkqk64JBlFpopnqWpKC7bEl/TvtJ1shTrhSxeTjJueGWcjlv5clDr7O1mLQY2Ra9uIuRSLwyUDZCzVPNQl7xvHgCphXPaYEdLDJxiKY/9Da9e2iyzqOHWbSrcNSjUH1CfwyxHEkoS6V2leWuLbjpPKqmnq9zLxOPw+8JqsfWN8+iyGnMtiRTYVCpXX7ymNi5UkFdxymsx6YgffhUS2xFVYNPNQjITTRpD4cvTiGkpXJy56nxFzLEpYxPNaZlVbd6t1WCE4yhbcq/itP5AD+6rGwR8vdXOQoyByOJ7uOvZOXZeWW87V9E1DnHjMXn9OFc2l8pZVHxrDy/OzgCGqkrjAH2WbbBTbtzDUzl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39830400003)(26005)(8676002)(36756003)(956004)(83380400001)(2616005)(86362001)(186003)(69590400008)(16526019)(1076003)(4326008)(66476007)(66556008)(52116002)(2906002)(6506007)(6666004)(316002)(8936002)(5660300002)(9686003)(478600001)(6512007)(7416002)(66946007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: pPNywJ3yC8nrOwVCJo105ZkCE8HdJ03VkSt/hUlZ3wJ2gLFeLl6Y68trMmZ4BzfNvvHfB8uHUhU+/l0tSONvJUILewzqdNzQZRjfmG5ovlqPm2hleS4s0oX+2u2dbi6wIEyRJ/cTIWbe3skOM+SRxRcdKcdHzhdjf/jRdak6VhXXkeoNrCLXIRrQB4xqDug4abMH3XpOgT7wwCjQcC7c2dORw3Huuw02FCx8CyELGyTGNHnB077rTD8ZIn5OLrsUJJMbWJVBnjcfHIUWRamiV9M613xteJi/FK/JNlSzBg1KngCzQuyO8NFsTjTaigQRrfNrge1fGG3Xp/KJBsXGquOO+PlzpPRAXv4cZbf99P/3EPJK816JffwcZMxTrNeMA+k/fSbTUJJvGInFPzRyk9z2+xhTlIETb9nK/MYhUhM2QIUSBY/NmzDqxjz30A+Tps7qcJoijPwqPnVSDDHjOVA4nltdQD+a2Xl/WCmJ7zrueML9UP2pYpd9krmEIqkk8T2Sb4Wor8gFJA15xtprlzgj2NIamofVRzebzLGzNXCvZzh2xrwr+PYeactXUYzHL+oN3t6hZ8A9sxzMGwn/OwLNMN63Va6N/7awvbvko9qRuWGIhhW1dg183XdMhks5UXwE9l6hi/d6txHbl0Nq4Q==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b3b023-144b-4096-9bdd-08d880d9a980
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 15:52:41.4151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CxfhG7TRDTZU0FpCBCekYoLxhvdIGmXbjsDQX7Edm34fLhEb2PQgDdoyxKEG8adLJkTGxA51/vXVy+qffPoxqcKuAEGbKKv4UEx5snkJmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB7522
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

