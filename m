Return-Path: <SRS0=Oljn=EK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44040C4741F
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4BFB22280
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="Ma7uoukC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbgKDP4E (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:56:04 -0500
Received: from mail-eopbgr10117.outbound.protection.outlook.com ([40.107.1.117]:28320
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731059AbgKDPxE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 4 Nov 2020 10:53:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POxjzpZ+jVpBoa97U75xtrBKaGePfzF/P+/4uYQLgE82B2gdC+Hd9LjGrRe3YCLGPNqHJBiFxSVwnWsOeT97jnGlreAo+lsp0JyAFi6AcBccfr036qDqLZ9/QBPAqpyJq9g1yhjQXjKF53GapzE53TAj5M41aszJg3zEdWpEDcZ0Z/nQkPMVtkC7AH6/F+OAfCQmCoNcZZ9NWvZ1Qzcwy/BQB51jFZWN2rlSNRA844LZTgRSv0EfKxnHE0Mh1YyW/ISmaiOyLgFFdb1tg7vuVJR3o0A17pr42eup++Y3FQXL1FgQiGpuAfrAriqFKrKoOQXp33FDLKFSFLkQsZPhLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tASzEdDMG8gJV427A0F/Ybc3XjatDlkF3KHobqVVyOk=;
 b=H8rWkft6nF4t4EQlmOUZm5CpDIY69rpdwHA2SWMHsQZmFAwX0fFtcqA1B5N3szmMs3r6qJWKe4Lm6UNhdl8dTzKHcFm9gyNP6Xc4kn7xE44o1QKNuDDpgkAnkHVdCQk5k9g31IGmrI7lO96f/5NWBTZrw1YbU3R92gg6OiheBIreGeetPaSxTT8IfDsUvTyOUPh63wpneTY9gu6be/HGlB/G3qeKsAat1P0L1bXelLdYEZb/AOz/hHPUL4FEJiXkvQsxjC+1r1/pnoitJ0d1gQUIX/g1f1HA8me66/9rjNDCo3xSAoMcPB2WwFhHtrT81gYpQUP666S5PYgiDbiZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tASzEdDMG8gJV427A0F/Ybc3XjatDlkF3KHobqVVyOk=;
 b=Ma7uoukChosXVHt911PijlUDNz1rjDQQExcIy84HBwfgRDuaI0iNi7nty1VaMiPcSyW+eu+dJG6HYgQTuKQWD1QuGszwNsygL9+w3jUHCq99TNbSFY1v+V/867r/mVKfBHkxO3alZtnBLUb0A3RNmzsF8Vhx/+i+lVc52lo/Aio=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5075.eurprd05.prod.outlook.com (2603:10a6:208:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 15:52:45 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 15:52:45 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v2 6/9] irqchip/irq-mvebu-icu: Remove the double SATA ports interrupt hack
Date:   Wed,  4 Nov 2020 16:52:34 +0100
Message-Id: <20201104155237.77772-7-sven.auhagen@voleatech.de>
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
Received: from localhost.localdomain (109.193.235.168) by AM8P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 4 Nov 2020 15:52:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2169717-f5d4-4ef7-329e-08d880d9ac18
X-MS-TrafficTypeDiagnostic: AM0PR05MB5075:
X-Microsoft-Antispam-PRVS: <AM0PR05MB50750ABA069352F6462C8BF0EFEF0@AM0PR05MB5075.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2Tr9RKjzzt044nWMXDG9oeQIDJb7f3SbYdfNZPAGc6hAEJAoutD6oXx8zPG7QED7Dq9qOrPGc+Dr5mElEwcYA9Kiw8t5I5tpOXiYgGjw41F7evX44Ci5VSPU8IzRSIrVyTdgbwidVxfwKbQzWJbPu3SUbn3DeUCRiwnNWFNcIA4nwIvFpz4rrRHKLPRY6HVsrQSfL3YD6a6KLaLYjRp0XJrVAp0C9QyvUTASvy5y+W7J842JkJ9nxqYpVkCBZZ1xNOROcafWE144QRUHRA3M6t6fiLrWV3zxAuY9xuNi5SnF16EH+lBNQenonQe1+SC5tYyoTNdNGU0SqJSH7IyrCq15CLXUoSxVi1HhdH0PFMyPEErl6BhOYE/7okjj7PS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(346002)(376002)(136003)(396003)(366004)(8676002)(956004)(2906002)(52116002)(6666004)(316002)(4326008)(2616005)(5660300002)(8936002)(1076003)(6486002)(478600001)(66476007)(66556008)(6512007)(83380400001)(9686003)(66946007)(86362001)(186003)(36756003)(7416002)(16526019)(26005)(69590400008)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: HsbAa804Qus4qTbV0hqrQ9fkwfZMoynZ5i3P6CRyuW6RW7Mt42Dq3Q1GQXfyPhXyJIh0tTkd2xBpySwz5CcV582PeYenSupSjazMibzK99oD2eck4zud8dwB1m4tIYqM39K3XUwK4tfPMyP+Pns2bgKGYLSqxjLUPR25SnCN1ysrgzPYngHbOWB5UM/UJZg4tO6O1syYsRjkbY58r75ijj4eHZDn3V5FCJyLVa/0USy3a/aUK4Ns+D/70VvzIZQT23jd8Eylbje9poDaFsdWMgzlNUmizM2B0oa3hvxl8DSuoXkozQTNqEwbIIJj4dzm69Ghett3kkfGOCjHT5pr6RJryLI4oe1SaOaAWxys5/wRGui1FfG5P54bh/cxgi29TKGPJ7V+Yc9uf5/HjrhvTrISnJRG6CiGEYdMJm+eyOqCOQcqHHgsq9YvTVLp6gXDtFvImue5s7am5M1rlhEU4irS27BvD2iOyZlFHuzUdD81BqdVZunIJ4Awxv2gAMsMm7ESwsBu0X7YmedUs8zqrJnIhezY+7BnkXjqdmvGKWd5zqK1OBngb1k+bQMpbYzCJsEnVrFXOrKh6Ws5aQjsNGd7P0mUd2MZkP4Kx8kK4rnBgLuk20/4O4o99FPdTEsves1iV+TW4O7JFGvLtLktTA==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d2169717-f5d4-4ef7-329e-08d880d9ac18
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 15:52:45.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8Jxp797hWRBC1C06pwXf6ghsWCoYLTdzBBQtSGhFRbqugi54qmGsOeKMagrrCZMjXGt3+bUnWQCaeRKnSgcF57DCWyPVGoNS498LZlmzsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5075
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

When writing the driver, a hack was introduced to configure both SATA
interrupts regardless of the port in use to overcome a limitation in
the SATA core. Now that this limitation has been addressed and the
hack moved in the (historically) responsible SATA driver,
ahci_{platform,mvebu}.c, let's clean this driver section.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/irqchip/irq-mvebu-icu.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 91adf771f185..3e29f8d5b33b 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -38,8 +38,6 @@
 
 /* ICU definitions */
 #define ICU_MAX_IRQS		207
-#define ICU_SATA0_ICU_ID	109
-#define ICU_SATA1_ICU_ID	107
 
 struct mvebu_icu_subset_data {
 	unsigned int icu_group;
@@ -111,22 +109,6 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 	}
 
 	writel_relaxed(icu_int, icu->base + ICU_INT_CFG(d->hwirq));
-
-	/*
-	 * The SATA unit has 2 ports, and a dedicated ICU entry per
-	 * port. The ahci sata driver supports only one irq interrupt
-	 * per SATA unit. To solve this conflict, we configure the 2
-	 * SATA wired interrupts in the south bridge into 1 GIC
-	 * interrupt in the north bridge. Even if only a single port
-	 * is enabled, if sata node is enabled, both interrupts are
-	 * configured (regardless of which port is actually in use).
-	 */
-	if (d->hwirq == ICU_SATA0_ICU_ID || d->hwirq == ICU_SATA1_ICU_ID) {
-		writel_relaxed(icu_int,
-			       icu->base + ICU_INT_CFG(ICU_SATA0_ICU_ID));
-		writel_relaxed(icu_int,
-			       icu->base + ICU_INT_CFG(ICU_SATA1_ICU_ID));
-	}
 }
 
 static struct irq_chip mvebu_icu_nsr_chip = {
-- 
2.20.1

