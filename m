Return-Path: <SRS0=Oljn=EK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C27C5517A
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F9D20780
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="N/8dwyMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgKDPwt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:52:49 -0500
Received: from mail-db8eur05on2122.outbound.protection.outlook.com ([40.107.20.122]:47808
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730948AbgKDPws (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 4 Nov 2020 10:52:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnrtbvusQpGFsQRyyiZXPUpVJq6KqL8DBBAlNxIiQ+/P21L6GyLIIJt3+2dqaRG87Ttfh0wIaIQYc4VtQ6hBnzvl8aYQ55/A11ORC83HCk2xiBx7zl5mEYSgV/NEeUfNRr2shb1ldzbWPiMluUYYCLxCkIINHTjh3jjQdpWxW409dfgco0wJYbre3kag57VR45T3dYBiHbQjyZ4TMaC7L0NqpKyEt9Ve3XucVpfAoUf4tN/BditgyF/JxuUFrNXgBmy1TL1jUl4l6ryWvwol5s0S2SfpOwSQDW9eoo4FjQD9OU1rMF+0mlnyT/8j/E2fDQvcpLORm/8Ni8aHUq8DZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj1Yu68StHzQhJMmJfnXSW8cIOerkdvHJ9nucUCe4tc=;
 b=UJZEE9bg5xwdLAVI2ZVCW4YXqIQtHLTvGn36bU3OTWz4yymJQMi9dzojKaRjF+bSeWcbzDk/J34y211ragWLJcpQE1L1rEUuthotUe/AScmEYBhXMM9VzlAyrZhVZd5Z0Ss0Cqd2ptfF5N2dHoyvHXf0Suj8p7i4TYRbpVYgSDwDCrrGtXrEcGZeRZY7i6wPVcKUWsqCejKdTLlk481IC6gQDjV8/yVohgWKhqNgB+8I+EeTpornpdrConk5KeB7vawywNaBCyEp6YXtOFgzOyYGuRGGvv5seQNsl2kYn9GAKIf2Z0vxkuv+vyyraAvuinIHt8RHT6CCwjwaF2npVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj1Yu68StHzQhJMmJfnXSW8cIOerkdvHJ9nucUCe4tc=;
 b=N/8dwyMqwXrMZJG9hxO7WbhaINQ9+n0d0r0pW9JBVDwIFfk6smCBuI8tAQxaccObcHo7YYSu+iO2aDaXkyNVG+A6u/GochcQbkZyOqYJirPADS3ygNXAmOqzv6qhn4JECGdRA0YuPS7OA9S6JuqH26tw0mR1s+zpXGlcFLelO48=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM8PR05MB7522.eurprd05.prod.outlook.com (2603:10a6:20b:1c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 4 Nov
 2020 15:52:42 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 15:52:42 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v2 2/9] ata: ahci: mvebu: Support A8k compatible
Date:   Wed,  4 Nov 2020 16:52:30 +0100
Message-Id: <20201104155237.77772-3-sven.auhagen@voleatech.de>
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
Received: from localhost.localdomain (109.193.235.168) by AM8P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 4 Nov 2020 15:52:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a84d3b52-653f-4176-eae2-08d880d9a9f9
X-MS-TrafficTypeDiagnostic: AM8PR05MB7522:
X-Microsoft-Antispam-PRVS: <AM8PR05MB75221821BD3D0B0F4BFE211FEFEF0@AM8PR05MB7522.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXNjcrtctgz+dhyNTYo4PzACXQbdBWDgki1JjIsqMVwimqTwh3jvTsDqXcY9T+EjjGJJXG7hrRShQWXVI3KcYypjrbIVneARu3TpZCyQ0eAQQehv7GQlRSg+ss12+C+W+pcTQTJ8kuvuYdfQNvJBclVZSy1wsege6uAGtEt6bfmz3kSHvow/5Z+6Bo1fTTvbfUcOia2GcAM/XFynMe2gXFADbs9A5SXe88+y0tb/7oKUBVevKGLbBDBJk9eJrtWDmiu8lhWylfkcUtlDhI4rOhN1oJNvTJY/2GKhbonS6TSnj7UTQsC/YTQ57j0b5LKt5aPoMuOuGhyBsA7lZI5N46I35Wq4KUFzvzc4mMvS7S/n1d92ZoKtfc7yUVAlP/Nz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39830400003)(26005)(8676002)(36756003)(956004)(83380400001)(2616005)(86362001)(186003)(69590400008)(16526019)(1076003)(4326008)(66476007)(66556008)(52116002)(2906002)(6506007)(6666004)(316002)(8936002)(5660300002)(9686003)(478600001)(6512007)(7416002)(66946007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: qMSnk/K+a/3BAVoTmwr1oh+i0iOA+zLbisavU8HeenbPBkLxG34cdpSIkAbdb7YlDA1mqAL+PfdMOQ8cuyAuCopTnE4MPSMGwCfApKJprAlR2y7LfqqhanGSwjw4TezKYk2OOp18KtUjMhP4McvIpXTor5uSEmvHbG1cjwU0WuBSdoYGhDFFZWHcL8sIG65NObcjpvdmUyz1OxxYSxu2UXv9zyTAZgFS3vrP3D03w7l2aIltOXRzv02qP/mJFmGdJjVgIuxFEU33Wo6QmenZQW2GQEINOnTIq+Rjz7lerONQRpQH5iflV2E6niVZvfudz0r4fuCnBOhFXxF0oNCIdP2ZwAcCK/8QQMH+e/XE5AOdJSC6tnas83v7B8qHkS8hN2vykulVmIb7nSuSJuYOrrh7Y2aIA0fP+jyvngrS7L/OdbOJeDtV9Zoju+On6d0NWLayqQQNglAAzXvZsuOIoERzDtTIQxmc03B7LcQ+oCMc95yyvsELEYhECuwmONC5K5Fw3ekBKHEyGUI6of+zVkKMykuv9uAyZfoAeNYkPasuTO0QOQQT6fsHRr4pCYf7fskDS8m/11TslwfXLp+NFOQgl8CPwwYFouq+8TMPoX61KDRamtSLjugLgZq7X1eumVbVIy/GPrbPp2kb/rBGBA==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a84d3b52-653f-4176-eae2-08d880d9a9f9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 15:52:42.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbyBPo+iXnh/NQvZUknEwCOu/10DQy91bKX8jOkIpUeWUMkrxL6unMfQjA3YKjHP7YGh90jems4Q9Pz2LtdgY9eogiv1IVHB1wu+7rslwLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB7522
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

The ahci_platform.c driver was historically the one bound to the A8k
AHCI compatible string, but before adding a quirk for this compatible,
it is probably cleaner to put all Marvell EBU code in one place: the
ahci_mvebu.c driver.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 563cc4c64d96..ed82381dc4a7 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -96,6 +96,11 @@ static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv)
 	return 0;
 }
 
+static int ahci_mvebu_armada_8k_config(struct ahci_host_priv *hpriv)
+{
+	return 0;
+}
+
 /**
  * ahci_mvebu_stop_engine
  *
@@ -230,6 +235,10 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
 	.host_flags = AHCI_HFLAG_SUSPEND_PHYS | AHCI_HFLAG_IGN_NOTSUPP_POWER_ON,
 };
 
+static const struct ahci_mvebu_plat_data ahci_mvebu_armada_8k_plat_data = {
+	.plat_config = ahci_mvebu_armada_8k_config,
+};
+
 static const struct of_device_id ahci_mvebu_of_match[] = {
 	{
 		.compatible = "marvell,armada-380-ahci",
@@ -239,6 +248,10 @@ static const struct of_device_id ahci_mvebu_of_match[] = {
 		.compatible = "marvell,armada-3700-ahci",
 		.data = &ahci_mvebu_armada_3700_plat_data,
 	},
+	{
+		.compatible = "marvell,armada-8k-ahci",
+		.data = &ahci_mvebu_armada_8k_plat_data,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
-- 
2.20.1

