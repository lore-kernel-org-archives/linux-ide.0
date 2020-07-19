Return-Path: <SRS0=UQRY=A6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FD8C433E3
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 06:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF7F2073A
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 06:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="izIvLi3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgGSG7y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Jul 2020 02:59:54 -0400
Received: from mail-eopbgr60138.outbound.protection.outlook.com ([40.107.6.138]:29674
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbgGSG7x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 19 Jul 2020 02:59:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/h+D/FHaeeXr+qFnEtUK85QGkv//NsNKTnU0YPa5IMLdv1DKIEPrFfNjTT5xVYoPpXqD4c4EiiTinN0LWyfgkqIZXmAcVoSAlLF8iA68b7FdCQLcSHWbxTwnXShS0rCz+qEGjPzhMV/eU4W/TAX/7S/aCh1nEnLXVMjkSvVzkq0y5NEbloww8/xTQeLbBAYwACJBsHd333F5XrKdceNlZ6rvYVfk137EQzoMNHrZNxOkoyrPT6HG307iSNWm3lhMaiZovjqTvFE8+V+CV7z1vZdWBOg0wAx+9kHcrqHodR5hBgOx8WaiqT9D2uwB4GYMBx0WCP1vUQofZIQK4Bh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1W+rcX4qhXUIUoCj8g+SMPjANoyubk0uFu4xCICvFg=;
 b=ZNQrWOUm7m7UNMgq2F1zceuqqreD4kpmITTfCzaYFxoXuKbPzsvtA4fy6TIwmynGFTqaSJd6CcbTc5iJw5y8eTaKM8wbRoq31MHiy7IWXvyIIml74epyniL90/iwiXhu8hsg1w0HbVRp1AW5Po1uByR3kHe+mMiF5R6ZgLVPv6HW7jlT6uVMoTYTSHVidtWtMfJnRItxFnFp7DGgvpqkJAM4vWz6o82yTzGwBBSqUCqEPpYlk+WUpkX9gqQEodTrV8Sh0y/R77BwsC4THa5VwgGwBN30wmah3vK3X45fqzF0wLmUbX1le2mjrkmJsqJ++ULCAkNghOOPlMsaGuAGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1W+rcX4qhXUIUoCj8g+SMPjANoyubk0uFu4xCICvFg=;
 b=izIvLi3mylAhMmaaBp/omEVekKREu71fW/YZHhmzy8cqNgaTtc5ONZi7lNo6ZpxfnBLDxL8QsjCKxYYnLWrvf6EWyH969yS9FW1wGddtrEjI99+l66L4QzWuqEGHkzbykap9mxf/t1WkwY1357FbD1ynz7r4WgByOnrW3jjvx/A=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=voleatech.de;
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 (2603:10a6:200:5d::11) by AM4PR05MB3396.eurprd05.prod.outlook.com
 (2603:10a6:205:5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Sun, 19 Jul
 2020 06:59:48 +0000
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 ([fe80::39a1:e237:5fef:6f39]) by AM4PR0501MB2785.eurprd05.prod.outlook.com
 ([fe80::39a1:e237:5fef:6f39%11]) with mapi id 15.20.3195.025; Sun, 19 Jul
 2020 06:59:48 +0000
From:   sven.auhagen@voleatech.de
To:     linux-arm-kernel@lists.infradead.org
Cc:     miquel.raynal@bootlin.com, baruch@tkos.co.il,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        nadavh@marvell.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, axboe@kernel.dk, hdegoede@redhat.com,
        tglx@linutronix.de, marc.zyngier@arm.com, linux-ide@vger.kernel.org
Subject: [PATCH v5 4/7] irqchip/irq-mvebu-icu: Remove the double SATA ports interrupt hack
Date:   Sun, 19 Jul 2020 08:59:39 +0200
Message-Id: <20200719065942.24693-5-sven.auhagen@voleatech.de>
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
Received: from SvensMacBookAir.sven.lan (109.193.235.168) by AM0PR01CA0099.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Sun, 19 Jul 2020 06:59:47 +0000
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
X-Originating-IP: [109.193.235.168]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69543b68-a8bf-40bc-d7f2-08d82bb1535e
X-MS-TrafficTypeDiagnostic: AM4PR05MB3396:
X-Microsoft-Antispam-PRVS: <AM4PR05MB339653BBDFAEC50672209A52EF7A0@AM4PR05MB3396.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZYmjL6RJM2lkQPHYEoTq1AHXhl7D5oIflGWCKYIWa5Ip6YgaSB9t/ciyaUaKXdxxG35cJ620GICuhS9XOLtqKEyXq9Rav1JNL9SJXIWAedQZY2aij63hPGCz6IQBLPZ6NW9hP5QxwKR/QmkTdbBJUBrEV2YVCzZo0ym5CNRsSun1mDv4W7aOBfm/SULb4LBO1ctwFm8+I7B6ne8SiO/0IphHlmXMNNw8eGugeOJ47LwH00smw7R/pKPkE1IbYyg7QwJT72EEqhmKs6ByxLjlWEORMK5GR7P/Wa/Q3w/pPzY9+qoYN7vQ8YfgRRz5OhkGn4cOcWBOi393xk2UkqlGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0501MB2785.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(396003)(39830400003)(136003)(36756003)(316002)(5660300002)(2906002)(6666004)(6486002)(7416002)(66556008)(508600001)(6916009)(83380400001)(8676002)(66476007)(8936002)(6506007)(956004)(1076003)(4326008)(2616005)(26005)(16526019)(86362001)(9686003)(6512007)(186003)(66946007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ONDFQr4r9yKF9OIN4+esgfE1IqbtzH8yG2m8C30BjbmB1n4SVnZvu15VWUdcRUeIO25t/spDZWoelImA5W2AASSc9mXsgE/znQH1gG1UIvxzs9ZZeHT4cs3OrYXt+TK6w672vRypBN8MExsIY2WVSZ10udgx5Dy7v/7YRdKvXaP8N9q0hWtBuPIhu03LBLykh2FTjM45INJ15vxTnsrGMtkk+byXbHoBzoRcTAVrqGpR0k1S+imlmKksQy+3DBpvtjTmKNU45hMUddu7cXg4a0es7NyYPyQB67d6hC6LdN6bD/ukGo07wCgy9eD4QNkJy3CqL2PCvdEAv67cuAInDS3B1/bObEDgf0PD2miriuM/7kUxQ06kRMvLie8pPUp28GqCDhvu/9bQHxWGzUJnMOxxzXv4sLWkIPfVlKmI2OZpaNc4QxJs92clvmieCJME0caBgmcqq2crLyFoNCMXw0SbDs++8Efp9zZox88GoPhsRUzAn73ByWrtwJq57uo1
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 69543b68-a8bf-40bc-d7f2-08d82bb1535e
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0501MB2785.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2020 06:59:48.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsZavzUmcTFZYKSmOIeC/sLC6iannBFT7wQoBk7Rf3WK5JF2rXDka4p7IV5kApCcsldxOeYNzss1Lojs3cJI9Kao3ME+S8o46BP+lcnL+es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3396
Sender: linux-ide-owner@vger.kernel.org
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
2.24.3 (Apple Git-128)

