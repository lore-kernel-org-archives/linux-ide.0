Return-Path: <SRS0=HNFi=DO=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68C9C41604
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917992177B
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="TpqF77mI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgJGPqP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:46:15 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com ([40.107.8.90]:50658
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728038AbgJGPqL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Oct 2020 11:46:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/ikbelQPioJKIBbycPx9xLYPRKrLEKu5u8zDW7jqsBDQ9yQe4+qN+P066Uc7JAYHJZ5Xnv6yqQdxSn+MaWM/h+ZpjwhdJ5q0RllXj+W52XVbpu7qToBUDij5IsbiQytEkwsoXaMQDMXtQVajzyHupWFc9ZQk2695f+sWpu3XjhHuU/yJAN4Os/O+PxYDij/Re9qCVexzs3HSCDZRZOW5ygqYxJ2fRDuu7uSnzJLVS8TDkg2/lOWPi2QcI0FshGF7Gjqdjei6yurHrNsKgd709FIo7MDplpvfblHmz9wnTBXp2R4IgEt9sI9pp+Zpdt01/wthY31URJYmjPA/5/m1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oNkHhHy+eRnp6MbnjKvlP+YoHuqwrg3T8zmFFmwiK4=;
 b=mHXyEzHwfNM4C+oVSLyM46NNTHgjfR36LLNUbjz44ZnJOseoGd6/U6adONSccY3XSpAchL9+u7N0eUZlzmqz3SzTnqqU94wDqThjbUPPmA+jGS4VPvZVX/a9rsRr9auy9IKxeIqYgB6hp36iIGjhKThef+e3QFopj1kWwFkbwiQGcMnHr4GjGD3hwmSIvN9MEotepsh+KMZCLpLF0ay1oBV384S/OdMnhLK83IDO/M0bxqQiJdy0oZ/vcDyNJbBF46lGDTZEkyOuHUylll8UH9JWkI2gyCNrJ/mInThVVLp7U58nQxIjqe+ri9Yw6Tk22UkJtXnL1UmdW5kpp945Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oNkHhHy+eRnp6MbnjKvlP+YoHuqwrg3T8zmFFmwiK4=;
 b=TpqF77mIPZfuhSPMh/1lTPQz9aWNKR7wcINq538L9AK6TWoF7NDPOjr+bb+ouyEbq8Wiov2GQsgPNpIfmbm81DazRCQqzAlRXNW/vmy1RWAbrX73MQ6xAzrBjO4n4q9OV8XurCe2mnPMjZdCWEzyH8tba58O9AaIzHTnbDPiELs=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR0502MB4018.eurprd05.prod.outlook.com (2603:10a6:208:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 15:46:01 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 15:46:01 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH 4/7] irqchip/irq-mvebu-icu: Remove the double SATA ports interrupt hack
Date:   Wed,  7 Oct 2020 17:45:51 +0200
Message-Id: <20201007154554.66650-5-sven.auhagen@voleatech.de>
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
Received: from svensmacbookair.sven.lan (109.193.235.168) by AM0PR04CA0047.eurprd04.prod.outlook.com (2603:10a6:208:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Wed, 7 Oct 2020 15:46:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b528e64a-ce94-470f-448e-08d86ad81751
X-MS-TrafficTypeDiagnostic: AM0PR0502MB4018:
X-Microsoft-Antispam-PRVS: <AM0PR0502MB4018D5B80D7EF25955D29A22EF0A0@AM0PR0502MB4018.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k6yXNUP+TM4IsB8qNIgulZn/0SOaMih6uwFfKQ/x7miP3KT+fRIetspQgs2HDkjg2DFHjpqxyHbYRtLOH1HLJI07yxerFD20oWbu1QoRlhrW2ykaBW1NcA7AR8iuMeshmg/srrnQCTiaTY1XV05qHBJVocTOjIck5Cm6laRV6BN6LhCpTJAnzeOqUQHZPu5A+LVawoHPmRzGRjeuqYLdWH5KuPP5Nw//Jb9QY5Ny6e/vEBDz2n01mV+p5AH7WvPxCqysrR5CWpRakU2fB785a4BKdohZ711FhbiijFTvSFrZmGrR/gjVRW1l1GcUFFxB1sJm9f13ak81EZhNwFhdRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(136003)(376002)(346002)(366004)(8936002)(956004)(5660300002)(66556008)(83380400001)(478600001)(66946007)(316002)(16526019)(2906002)(6666004)(66476007)(1076003)(4326008)(2616005)(26005)(86362001)(6486002)(36756003)(7416002)(6512007)(9686003)(8676002)(6506007)(186003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: DkgkcMvbFxZMfXPasaTv4wMhcOnzoipG5Sz9Bi14fegwPFNRyP/LFDoAro96sRNspzXm7KjmDv7rwjFxORLKiukuZdkzzoiK5QTH2xB24WC/Pj6aNIoojlYbEwo0+Wv776rY4i+fFNCN6dPsz0xhWnGqbA6nl7d2eLYm++WlYt1kVMB+imwI8zFD5/FGMiSOILhbMT7Hp+UPGPDucYegKlK6FuHgA9pFw8p8Eh9gCWVeJlUkd7MprJ58b05j11DnGBJDujVOz2ufNxC4mxwMGKEyAXmgzDXIWAUNGUxJoD+u6XbBAH2zKn6KMvutcsLix6yggjnAzMs44TXi8aP4+tZNBw18BCeVg8lipFx1zgRuxh04zXDmBF4uDxzhGw+yR0r8+yOtyUtvQV0qytPvxjlISYDwxlFcUmuOcLx4vcH4so3MXCI3f1C6+u30yIvV/Ge8OhZnEDhyJlgocb5YtRddykrm2+W63r1Yq7zXbDFD6nslAUoXPTXKKz19bOiH7k2S4C6Q6LQOL/xLNTWCaeCdT4PXkVU7qV2G2wDNMvviIVI+eLJCmRe4Te4S0GyrMiIm+XiTBLNf6lXdYs3I2AfKawuPcS6NimMnDz6ILa5U1JMYh9kJo4uEQgb4QkCvG9MTCkqTa6+0PCltgNzN/w==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b528e64a-ce94-470f-448e-08d86ad81751
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 15:46:01.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNoWyOVuoIUmBUUL5701W0ERXRn8V3rw/vo37ptg8q7t06neGc+j5v8cuDQPp1rItN4R08mAKvu1uuoxMoSxT6QfZBpXYLS6cNmOaD8gSx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB4018
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

When writing the driver, a hack was introduced to configure both SATA
interrupts regardless of the port in use to overcome a limitation in
the SATA core. Now that this limitation has been addressed and the
hack moved in the (historically) responsible SATA driver,
ahci_{platform,mvebu}.c, let's clean this driver section.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
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

