Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C49C388F7
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C070E20578
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="FQlsYThf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbgKIRkK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:40:10 -0500
Received: from mail-eopbgr150099.outbound.protection.outlook.com ([40.107.15.99]:6659
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731962AbgKIRkJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 9 Nov 2020 12:40:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny7re9RLreeQwIq1SyuadiVjbzzrWGp5JSaEVBQuDavd+4a+nWsO+W1KpfhoN2PiaWXMNnbRp9AA/FkZHPNJFTgPaYr6utn6Gbo7Q0VKjmg8zJTYLT/mpxY17eiYy9J0Kbo3E/wD8bCYM3YWrizXqEKjJH/UQ8BLjap775PhuThJgrh/jSRQ94D00nIxss+gc/bGUJD5j0hkcFDvOdjmbmUiylNVKAHPoWI44YOn4giMR6PWkx1z2EjX6cvjYhq12XUKfSEM/p16jhPxHia98SmJ7sRTExRTbkMzmJ+asD8Co6MklDYB4QA9ERURBxP/rslxwts0AgTsF6tHUqwefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tASzEdDMG8gJV427A0F/Ybc3XjatDlkF3KHobqVVyOk=;
 b=lhJoJl5pVvP+5zcdpkfXjz1RrcpeyCre8RCeA5+MDJOHhyNQiUm46e6LYt/4hpkvvMlagSUX0xmeRQ8QXjzT91mwpO+jxGTNzuQ4CYen+TuL++a+r7JYqfr83YqWOkwFlxV34ZTkP5k0pIS6kC9q/BINhRXxmJ5aG34quqwhS+poOipBVoKrtvRY8aIsS1Tq935E1ptFUjLIYciFDTX2aBeTyxopVX2OUJFuRJChlU7dLjvr45DQUCztV7zXYcVL7Ahz+5o3EHuFi6IKim6ZpylKc1P76OO9zKIuKG4wPpNdo27Zr0+4Qoe+cnoNjwmHe5CZmVKPRO8yTjkp3xEwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tASzEdDMG8gJV427A0F/Ybc3XjatDlkF3KHobqVVyOk=;
 b=FQlsYThf6AsevhGhRGMHVhC8kPbBLoT1SIjUkgWwW++whjvkh28A3S0a8b6MSzQmB7TxJZ7k9hWXYIM3sP+ZAoEr5z6oPPFlCkIpuGnECnFSVphifSfFortlH2h7TGA2HcT6RuQfce6tFqcw/rOLQutpaeAjGQhjoIWJ7rw7A7M=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5362.eurprd05.prod.outlook.com (2603:10a6:208:ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 17:39:56 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 17:39:56 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v3 6/9] irqchip/irq-mvebu-icu: Remove the double SATA ports interrupt hack
Date:   Mon,  9 Nov 2020 18:39:45 +0100
Message-Id: <20201109173948.96663-7-sven.auhagen@voleatech.de>
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
Received: from localhost.localdomain (109.193.235.168) by AM0PR04CA0135.eurprd04.prod.outlook.com (2603:10a6:208:55::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 17:39:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 866f7931-cb74-4400-f2e7-08d884d678f5
X-MS-TrafficTypeDiagnostic: AM0PR05MB5362:
X-Microsoft-Antispam-PRVS: <AM0PR05MB5362F833D0C3D642A49C61C6EFEA0@AM0PR05MB5362.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gp25IUKmGi568Uk0khixOaWL4HxiOlhAqlLiLMKPO6EHB4hvWT0s+49Gl60h7E75VXp0IEviAqsxjCW3SSu/P7XNScfaULtIrqLoPRkwJ1qCxl/Ar+YF/jY8PTI6R85wk+Sh8nr4+sRoP0jTTiuGtp4K9nY6zYd109pZvz0DAmm46CcvNvWOMCaGpchNiYbVDiGceJqAket1+SOsuScn66ccgkpWQq6/RL4+/Y6H1hzh6xtDJm2YrOOeMeAinZbxYmQ/C9S4TQd6G0IlKSEsVH2UCacSE365+Wvlkdz6vSrM9OjpeeOEUeA0b6ydlP4qEHI9nmKCYe9BODe34HpiAiH+BZXWsORXUiAhKehkSftaaZGA3cnGk9q+mrJXi3qx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39840400004)(52116002)(69590400008)(66946007)(5660300002)(1076003)(66476007)(66556008)(26005)(2906002)(478600001)(316002)(9686003)(6506007)(6512007)(86362001)(6666004)(16526019)(8936002)(956004)(4326008)(36756003)(7416002)(186003)(83380400001)(2616005)(8676002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QNopq2QnRwKsHOFo6ikF2i7H9F9Tw25xgi+uKrWsmmmK9f0gZYJ1iLXmPl0UHvXNnjBveV32dSAxwn1Yv2nb0ZQF9DYY2JsCXxd9SfZ9saLkdedxjkP1M940jgvvd3EAth4WETdmtXXrr4K15h/EfjGQS7nwl9dLSCGriGBphHcv7b+HM4kh688s6wKPZR14wrdYZwJQ8LTGqPx8RhlI+z/PWWGBIbeysvTQXvOvHs6q2zoMHDzSpDhBXL89/ervyCc4fuTYdTeXAb4bwpD3647IF8EDX8rJGOStXimFJAnEWVivEr8Ch9mb6qfLVShDvp8jUPKAGL74xUOky0aeQ+QpAIVKOx+yog5cHpTSKwgsnKKT6RHDm/81FsX4QCQEEvu+iS48OEThhGtIyaO2MUdzZcNTKZEbNiRWslXtxr/tvyEsqIGTSnbo8wAo0Pwd7Xo3dCNESR96zQsaS5B9j4w6e0WHnX9O1X528UcGxUVCPq4KBAckPhudQCFaPqs80xsb3GikRr8ci3IBvVttVqV3N5wtaLog1zBl31KWsr6ahzAtw+L6ndV+btDrtn6veCxNMnSvxGaHyIvIHxC0LxhoS3PJbza7RABU2uTyMWETS2aUYC1w6LjVqXawlV9YqKnB9upLmoJ4MBm0IH22HA==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 866f7931-cb74-4400-f2e7-08d884d678f5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 17:39:56.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OevWdlihMAF0xNWyvm/jCkpqPHsZtwx4jqJlnX18Ft/Wrwtwik5Ev6T8ItD43bfwuRmD9WXdYBPjKJkjxD72xM1plvEW4UGMkep9/DJsByc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5362
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

