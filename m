Return-Path: <SRS0=HNFi=DO=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4C3C4727E
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FE52176B
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="SUC+cozO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgJGPqJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:46:09 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com ([40.107.8.90]:50658
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728728AbgJGPqI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Oct 2020 11:46:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2GSFr+SqgvRPtYRJtq6sXZ3swjN4ZBCj1IJqkErJPxHq/161gZ6CpCUJWUAed220NMZ2EATBmocHzn66KJk67w6w0vS4kWOULP28dtnxJw3qUS24vX1HJfrQHM5jSb+r66MuC2mLuIzqQ0dVAezlVuAsHKrVNjIt9k8A9D8TadhuPBQhy2DKW+KsecKnJ2kPaacYAmXVihbBbM2kTTU5/RRHfyjTmPBIqjT1LL1IcJ/4BMZWwnmt0PP1FuuK+u/4ziLcUD/5cpf3wvLiXw+GVcQp5GfwGd9KQ45gQOx2l/QCfwmktGQwsmyPbThKwhDsrb70KIzb7pxdSf7bzXiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h5/vCO46Bb1HuhsPmKw9tovodEjXYz4yQCFImF8KBM=;
 b=G2Da7ndRzSFLpk5eZbThjcRH5ODFTPo6aBkxDCm5sqdc13xZ4LM0v2u7zdsYqtazZoA/XBXc/CujNWQZbugriCuYhJBbrenNQJr1wGb0SX24zO6c34EsptCAf+L1jgT2vVYgwMxFHlnxfo1RmorRR8KhbC4smmKTsR0s2F9q0tZBuAZWp0fvslJqMVLXwOL7cfMifLm/CfetdAqj90GMly+9HuT6xWedINGq2/7SuMhZKxjpJkhAORjrsIZ+yTH6NVVZl0Tz1O+I1WuVj2xviGOxAfuVgVEgt7wC8XtebPZ9HID/qH6l2Oz2WidgFF6TEiO1eLaYc8O0zl0JsptjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h5/vCO46Bb1HuhsPmKw9tovodEjXYz4yQCFImF8KBM=;
 b=SUC+cozOCnuzzchMUIPCXzJg+b5O2JzHCX2xkqOxJgy4YRASZwWSxny/nT6i/j2KYfv8Z80NzWen7nnWMdG/tCuVS+OZXsg1EF24lfEbJP87wQHx5qX/oKf/+oWwMcAawhEvpoSQu679i4TsuHaqiWRyh3zmt29lwSNoVxkkqmQ=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR0502MB4018.eurprd05.prod.outlook.com (2603:10a6:208:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 15:45:59 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 15:45:59 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH 2/7] ata: ahci: mvebu: Support A8k compatible
Date:   Wed,  7 Oct 2020 17:45:49 +0200
Message-Id: <20201007154554.66650-3-sven.auhagen@voleatech.de>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201007154554.66650-1-sven.auhagen@voleatech.de>
References: <20201007154554.66650-1-sven.auhagen@voleatech.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.193.235.168]
X-ClientProxiedBy: AM0PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:208:1::24) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from svensmacbookair.sven.lan (109.193.235.168) by AM0PR04CA0047.eurprd04.prod.outlook.com (2603:10a6:208:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Wed, 7 Oct 2020 15:45:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17a5f477-d042-4e4a-d98f-08d86ad81642
X-MS-TrafficTypeDiagnostic: AM0PR0502MB4018:
X-Microsoft-Antispam-PRVS: <AM0PR0502MB4018B83C9E39933AB3F67676EF0A0@AM0PR0502MB4018.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjQSESItX2dlAVj/9MkpGxWLxLt/pKUFanFFT+BZgV91GoRKQdksA8/jpT6NDaHO0Y96IDLzVXqdIF+tIfnwPDGzwX8RkyflVbv7XfZEoEOmn4C0RWFm7UsOiMqGgz3UKbf1CDrIHa5HQFaQg3fbrD1DVD9zC7un2talNH9qQQIUajc5oDVrZAKy0S78fRS47oASFAhVl1FaZHVjscbrfnlDMP/SRrClAK9suTgYSjbSabMwzB4GaXoJ/jz+Kb/R58+2tg05RqLizMWdSVvbfqHeQzMvT+CEcsHLat+e2u5xS60dV3fiimsXt0NG4SRdhfnoJe4qvaEdLpU3vsSdRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(136003)(376002)(346002)(366004)(8936002)(956004)(5660300002)(66556008)(83380400001)(478600001)(66946007)(316002)(16526019)(2906002)(6666004)(66476007)(1076003)(4326008)(2616005)(26005)(86362001)(6486002)(36756003)(7416002)(6512007)(9686003)(8676002)(6506007)(186003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 8CeuZzvyuWvpj5Jl45bNc2y7Fo/XJDDERPW7I20an73NfpQ/sck1FTHxYDaWMoZhOvtpjCjia9AP+nHs8WSvxEOlHGAYyOwJ8L4WkXo/JYCScbhL13AWCnxkUzivaPUviWxo3sRlTyKABXmWieafbak2YMZNXTboM9GBrL78/mQO1TDmtCrBG8di7LgOFcSDdOEoJskLQk8EvHssp8ofhnFRiUtIHmdFvzpuCzvmToJLRTnRxI/Ny7MNEmDkN/fF+EmlA3c8o0r2MufupiyCxdAQS+KPYAsm8peotR/RbWt8dFUZfsLp9ZiJAWSPkZhBrex5QpG4QmhXtCAA/3kcJUazR9w8DbpMyKCK0tq6XUq5kH6og6iYieTPAO97lMDmi62E+exwsIg4bpuToSO6lTzW85Nfe/jDq+eAKL6s3G79mrCyHpXhSTFBaY7gm/hCJGierGIeoFsgfBVH7H4TvfUAA9G6XXnDhUgBUxna4HcwSgR5d3a5iThuH4jZ6IwWYJ8tu1rRCBbk7Nggx+ZNUJbLxzl1JZZL51ZPczcOZpH7Rvl/d0JQ+sIAGspinC0t7BhHdnRTMtdlg6QhWuyN2gyeRGysphqFYYzyGk38gCjpYo3Mr3F7bY49xXOa06wckEFLAlAxN/ghIwqCkSJIfA==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a5f477-d042-4e4a-d98f-08d86ad81642
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 15:45:59.3806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbx2zZie7ppn9+rKKHtefM4I6ESf4+mE1z8HUcSB4PrdP7+k1HH5iAdW1RyozsDCGwyT8o/n1bofRwsYq5mTDweI/wxy4tpxiPRfJUEl398=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB4018
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

The ahci_platform.c driver was historically the one bound to the A8k
AHCI compatible string, but before adding a quirk for this compatible,
it is probably cleaner to put all Marvell EBU code in one place: the
ahci_mvebu.c driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 43bb2db59698..1cdc126882eb 100644
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
 	.host_flags = AHCI_HFLAG_SUSPEND_PHYS,
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

