Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1E3C55ABD
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B064C20639
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="f8kU6QMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbgKIRkD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:40:03 -0500
Received: from mail-db8eur05on2090.outbound.protection.outlook.com ([40.107.20.90]:23136
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730330AbgKIRkD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 9 Nov 2020 12:40:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esdWfK4oDjrwNZxEiZKNbNVIjZDD4t85XmpvZfAsvt+uOmYi7WRLP0YMT9kRnlN6KeY60xmqLk9lZZKVV715G2gnt/p9/21AkquVg3Rmv1/hI8e9/TyyH43KD4cTfAihdZbcU7VQrQTn/+JsYMIXzRe6x8gGLcIfxz2lPmsW42YE0y6BMubezGCMVFKGQiFKlQnkmar6r5kl8HNTxmAHaBqNE/3ysW0xU/4cZmMcXm/rg9xI/bZEO5EOCtI3aRfL0FTMByxD55HRAyOvTlkWk+vOe3z0V3op3llkh9tSdCZea71m+9aYSsUlqPWvRvJd4RqNntZImob2WX5fja1m8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj1Yu68StHzQhJMmJfnXSW8cIOerkdvHJ9nucUCe4tc=;
 b=gEEZ0fIAgJmK8Aqc/rGqBurItWzr0tlWYfqat+nhCejsrZfos0JGgVqoPlo5TetbZ7Y+KIXRnDj4OBeJlz6CfAx4rs7Sp4NOfU9MNCeYeUdGZqvLD5pVsuoHD7Ro1Y9rLNvXy1VKO6j3R5W9fcHdOrZQvMMe4u6QYeWfrpyi2iJoYnMUYcFPZtdHKBr9+neh41iz+ME6F9GnffS+HKN6ah/vxfGKqW7WKHAoTywRR+sJBFsJh75PfYS/DABZYgia986AD5vCOvTqRmzDLh39SZJvC/h1rpysMt8O/HhbgVSRptvGsY275ZVTWzOBuT523cFERNN0N93yjcB5cnLjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj1Yu68StHzQhJMmJfnXSW8cIOerkdvHJ9nucUCe4tc=;
 b=f8kU6QMhiihhkipwiAokXXcomgESd3ReriV8tPUkyQgc+V3/clm0Xn7qN1Yqfb6Vg+bxg6fatXdcFbbjFtrEL6v5DciDb47NVfO8EmDEPxhOZ7/J906uZceCJVWe+pzGBOUgAJmomFNWiG58DFnuGsr5SzQ5ZSTolC5a8cBIQiw=
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
 17:39:52 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v3 2/9] ata: ahci: mvebu: Support A8k compatible
Date:   Mon,  9 Nov 2020 18:39:41 +0100
Message-Id: <20201109173948.96663-3-sven.auhagen@voleatech.de>
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
Received: from localhost.localdomain (109.193.235.168) by AM0PR04CA0135.eurprd04.prod.outlook.com (2603:10a6:208:55::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 17:39:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78990a60-2aa0-4c7d-b20c-08d884d676f3
X-MS-TrafficTypeDiagnostic: AM0PR05MB5362:
X-Microsoft-Antispam-PRVS: <AM0PR05MB5362DD21DC4B9B18B2DC00E1EFEA0@AM0PR05MB5362.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngk2ZaqbsGQRs0lIUtp0IG9r6r1GnSUzrcBXNrZLvo92/NWkt42OjmmttNWrijYS7mDWrdJooHtZgtfxY1z22VWXG2ucNJSukweuE1WVtqiPNc2u1KAcBwUPWPcKmylXYtxdeqzOuaP1xPaJLcrXYA4FYpBUFLznyBkzhpaaNFuYm4sKAGgrMx9yTt01MOqAxmI7w0AvPWEoVuV8jsL7jTvmswRDya/dwK8RyQ8Pil+MSNq+2NNkr04AHSkF+xvYq+4S6wqKBSSgXt/oXaDdxq8EVBBpJk6iIzcalEz4vi3SLZNrtfni3cLwxjk3FKkYT/SKw/MMTOGSgEDB1j4dYAnJG/RJuE2i1bBDnS1i3LUJXbwkpuOpV52eGwWqF15R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39830400003)(52116002)(69590400008)(66946007)(5660300002)(1076003)(66476007)(66556008)(26005)(2906002)(478600001)(316002)(9686003)(6506007)(6512007)(86362001)(6666004)(16526019)(8936002)(956004)(4326008)(36756003)(7416002)(186003)(83380400001)(2616005)(8676002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: MTvwOOywnWreog+Posb4wQCCNQMkCMvLF98yiDgvL0E9215p7DTsP1wKb5V3NnJqik3nr47dsCQpNXISqbAkIYJBHvu+jU+wiKjqw2uSqnN4b3q7YBzXIc+F4AqplaA37ZNtvpZqlj4s6xzVH/PS1eEtdz8wFbPscTm9yWVbalYcow3COKdDkhfWJZK+TFoEAUX6HUYwzxVf24jIX7FD8JV/FFVXa+XHaH0sPkYSPDKayWvTONUSGzUCDRxmcMAll9MWkatHv10uFnmnbRhbOhQSXWr6La9ZFjmb+ptAepBCYet74H+Cal3JrJOVU9Ew2JcVjq0yKhoXprCq0KKGRa79LmyY6hhclxDe03YgJMlMPmgc1gyfFrbb9xWV6gYlE8U/SrN+g6G+4J7fm3kj8aFMDpSiXJxXp+2m8LwvEmt6z+rNKpttT5vmpAzmB3hIxl7C+I7v4kONAcq+8C0DebgZVsdpOLhOk2nVIOXYh3EmEJsKuUTDb/FV266QH4wTZuSgdKqASujf5WVn0q/cSYsSmoYnYt+csmZUGHJON/go90znkKIc/TCsI1F7Hj1RwTCG+hQlazTHw7W0Zn+gAc9MvRcUT4o7lAwCVNNoYDlc200FRtKT8D6JwFsZ9uvndg0MeVqgFVLfUv/ff0Kd0A==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 78990a60-2aa0-4c7d-b20c-08d884d676f3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 17:39:52.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cTLXqoliSc+3VoPRuQAPIZ4K3VPUn641/b9MiDyvTEtEJYYKqgPpQ6VEY2FhcP4Bw5PU5cVcHo/2vg/2AjgCo1jNwD1bpx0TmyEkEpY+uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5362
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

