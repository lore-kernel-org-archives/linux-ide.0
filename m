Return-Path: <SRS0=UQRY=A6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C599C433E0
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 06:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD59207DA
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 06:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="eNao1fUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgGSG7t (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Jul 2020 02:59:49 -0400
Received: from mail-am6eur05on2111.outbound.protection.outlook.com ([40.107.22.111]:50369
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgGSG7t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 19 Jul 2020 02:59:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2xCq72FAWZm0VMf498UiADHz7NZUlQ9thsuVNQwy1fRpJbVajTVtcVUu8TF94LVxv2ObEashNkYMhgLF3GCWHjr/MINH56YOSQgY8SP2qCDkaSCbLXyhQnyZ9RzkbuOCoR+i7DwcdIk+41bwq/rH9SUP0Fz+cklpdZHN9Gvy7Nu7leE/RdsLWk7S86g0RQYdfE+0wg54UJbCWoiP4YvgVqMcEq474mhKLYHbNJdklTxYsG4MV91//42aLKqa7QdCg0g6glJqaYLGc3cd3r0rpaeuRhdUda48hTr5YRVcmLVuTanG3WVAkC7OuI5GoCV4aQ2+EJqanI2u8IPFdsMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGjZ1/ViDdjFpDJn6oquiUiE5uvTVkg71oPWAFLeU0Q=;
 b=MCWPK6F1m86adkZUq0tBp8HiEOs+PXyZ3oAn0qPFbULKfopbPlwI/uyJXQACtQ1p+OcKinHKH1kJwCksgMfEO5A3VfwnFdUU1/wrg+vVv77z0tz7o88niALXS6f8Yq8S53k2P0Cj9mgRHksxjAHYiaJWvx+vzr7UPuFEdATxxqjWuWBcoNmuGfbWCQULVpkEu6EalNmWANY8qG0t/VrnKfVSkuXiB/W1xyibKtyCV5/dGJYXZzxzhE9v+kiczlBFhg6F+RmGB8vYKSCfOm85gMRnMZHlVdI3ydxyI4mWHlaIHYCBBXyKGiBGGNoLCYLUciyNZLhxkpOVxPyE+iSU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGjZ1/ViDdjFpDJn6oquiUiE5uvTVkg71oPWAFLeU0Q=;
 b=eNao1fUqpjOL/EkxpoJ6/mcoiR9eDjiLxF3FM6NlamyMumuufZjkp4DGaWJaB9I8KfIp/ZALPt1IVtNygJiQy6IhSTAoxgrxgTNreNDl1J+EitpJaewLn0S3OEGoUu7tnHAy2mM8EdU003VIKdorpfdTTOjDujExkhH3MMeq1fg=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=voleatech.de;
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 (2603:10a6:200:5d::11) by AM0PR05MB6690.eurprd05.prod.outlook.com
 (2603:10a6:20b:146::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Sun, 19 Jul
 2020 06:59:45 +0000
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 ([fe80::39a1:e237:5fef:6f39]) by AM4PR0501MB2785.eurprd05.prod.outlook.com
 ([fe80::39a1:e237:5fef:6f39%11]) with mapi id 15.20.3195.025; Sun, 19 Jul
 2020 06:59:45 +0000
From:   sven.auhagen@voleatech.de
To:     linux-arm-kernel@lists.infradead.org
Cc:     miquel.raynal@bootlin.com, baruch@tkos.co.il,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        nadavh@marvell.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, axboe@kernel.dk, hdegoede@redhat.com,
        tglx@linutronix.de, marc.zyngier@arm.com, linux-ide@vger.kernel.org
Subject: [PATCH v5 1/7] ata: ahci: mvebu: Rename a platform data flag
Date:   Sun, 19 Jul 2020 08:59:36 +0200
Message-Id: <20200719065942.24693-2-sven.auhagen@voleatech.de>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200719065942.24693-1-sven.auhagen@voleatech.de>
References: <20200719065942.24693-1-sven.auhagen@voleatech.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::40) To AM4PR0501MB2785.eurprd05.prod.outlook.com
 (2603:10a6:200:5d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SvensMacBookAir.sven.lan (109.193.235.168) by AM0PR01CA0099.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Sun, 19 Jul 2020 06:59:44 +0000
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
X-Originating-IP: [109.193.235.168]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da25161c-4d18-4c77-a413-08d82bb151c7
X-MS-TrafficTypeDiagnostic: AM0PR05MB6690:
X-Microsoft-Antispam-PRVS: <AM0PR05MB66909BD2761F76BEE041C14FEF7A0@AM0PR05MB6690.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Y4OJfK2QK/I1PKRNpznF9gGqroR5fhLsztqpRl5ojOXBfUsazj4tUrOQEY1AxREMOBouG49LpkNtoEhvlkLwoJl3CGiyfPbJF4WTyzE+vpAfuIOmOKYHkzk2F6SEzc8+MY28onBrMqxFylYijsafzfaz9sOhkxTX3NJdSyaOouPOmIznkMHEwD91+WuDi9ey9H4fGQAGJP7stiQ9X/jlua6DTHItyEfYrmvWAziS5hG2i5ioceB18Hif80FSqhDw0rlgUtv0FgWpUCgXQVGhGLyieZee8H3kn3CalBFTCdn7kQATQxHtrW3tV0YzgHk7vabXrGtaSwuUk63WMie6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0501MB2785.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39830400003)(396003)(376002)(346002)(136003)(2616005)(4326008)(6916009)(7416002)(86362001)(508600001)(1076003)(956004)(316002)(16526019)(6486002)(6512007)(9686003)(186003)(66556008)(66476007)(6506007)(6666004)(52116002)(8676002)(2906002)(26005)(36756003)(66946007)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: JnrhrY5z+96CfHbZjK7S/85uCoR64OOWiCALR7ECyQE9pLs/BGqzL8Lbt5D0rYoO3yiXBtJLe4nMDROKmb2uzRumG1FglyIHCRVjv/yaC1PzRuPjVP+N4Vcu+EeBFjp3nfBnX459Qnlvel6l4QvaSS9fjYSQR+NknZ2mnIyYBSfedNjANy6BAuvis47knheDmycgVTiLPTh81IdZRk/8iuOe30vglXFZB1loWai8Zub8RINuJMiI4XjzKENDh82dPDfSH6ozd7/7LG4KX7MVHJcEyHtty1X6BvnTYtW00VYtzANj3vx9iCBxd+iCm7FLMUBhMneSaipDiEvTx4FbNFl+DXdv90ccYAi/yU8RgwElGs9e+VwZB0/guSLOXuIQJtM8ahVaRgj3c+dFummumydR2heznWCsKmYlf2ZxLL4zRzHctLMjFP4qK99xf3lqiQB1Lgrq7oLiuqUtds/7GGJC2oTlgGXfAke95CVF3MBQYCkwtfr7v1RxM6/GP7vP
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: da25161c-4d18-4c77-a413-08d82bb151c7
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0501MB2785.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2020 06:59:45.5798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmrsPJbvCQhcQ9uNVG6t5gK3i+vUVNOV44WbU8iiWv3676NAfR7XK0XvzmTAns0uNnkrnZt8aMkuwDiv4iuAPIWBxLrCHmG9hYouAxUAtkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6690
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Before adding more entries in the platform data structure, rename the
flags entry to be more precise and name it host_flags.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index d4bba3ace45d..43bb2db59698 100644
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
-	.flags = AHCI_HFLAG_SUSPEND_PHYS,
+	.host_flags = AHCI_HFLAG_SUSPEND_PHYS,
 };
 
 static const struct of_device_id ahci_mvebu_of_match[] = {
-- 
2.24.3 (Apple Git-128)

