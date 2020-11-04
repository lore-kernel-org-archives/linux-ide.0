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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1010DC4742C
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C3422280
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="NshuNQiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgKDP4L (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:56:11 -0500
Received: from mail-eopbgr10117.outbound.protection.outlook.com ([40.107.1.117]:28320
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730975AbgKDPwy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 4 Nov 2020 10:52:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qwwn+iKCdIadtIrbUzWUBHCk4GRAsB2b24giNsJu21FgzADI3x0wTGB86YCoE6AFHB/LlTeBoSP/oYz1GW20wqdXd0DgqJBJMW3VCjMeU5asL5saxowgQAgQv8l5RLHHRSijazqgR9jZDD4X1RkOfNek22h5b44+C1P93FcnfUXCrFt0RlYcfDV8EkskKD/ztgR8CEV05L4waCbqCbbxwJb0OMMkI+mlbqOP2AcgodPd/9P26RHy6zDt1kA3GkO9VU6299Ar0oBRklLnqhAM4EF/PwH469NXaS5NkAOoLOdEfI1WbzFXtRip09pcKahtK0uemzQEx6amF9ewDvoJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/3aCpme5/jOiY35WdC6yZmN76DTALab744ujxwEEUk=;
 b=JMER1w/EdUYxSzYXHu/RwRocGV4uWmWAPaeZDx/ITauOefMHVX/Wqpm0BTULk/utKr5l6QU4hfi1gdmXDTUkB3/FlahnNMzBAGFLJo8iZI23XCj4t5dq5badS4WKgKwf5cx1JtQOJ7WHgD8TZuLRYgaDFKNSrITTbJfU5PI7sr8KVxDKMUjw91NKosTq+ZQbRR6RP8rg63oBR5YDiaWW0HHqeAB60+h/MVL+WVf41xLUqz6AZTEPtso747pg/koGZHbupSsdIATanEYLvTykEvli4/ly3gjRuL9ObHmDbYDppa+g6NCaF0O9Ch+GRWXcEw803rqN6Dkvayuj31A6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/3aCpme5/jOiY35WdC6yZmN76DTALab744ujxwEEUk=;
 b=NshuNQiGGbIFhka1nWtPSLciYdU3iTbrexlNxWSGB5zHD6enG2lsmo5HY/PprSw6alY9qwjvFujBh0c0V0NMZQW/HEVnS4fcwvjnPnuHiMXPnpeyRFnWaZ2eEJt12fLaC9S33gnZX3EyOBJ2GLJlTyVPP5q/pWXgVd+g933xW3Y=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5075.eurprd05.prod.outlook.com (2603:10a6:208:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 15:52:44 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 15:52:44 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v2 4/9] ata: ahci: add ack callback to multi irq handler
Date:   Wed,  4 Nov 2020 16:52:32 +0100
Message-Id: <20201104155237.77772-5-sven.auhagen@voleatech.de>
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
Received: from localhost.localdomain (109.193.235.168) by AM8P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 4 Nov 2020 15:52:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccbed9be-2453-45ee-1208-08d880d9ab0b
X-MS-TrafficTypeDiagnostic: AM0PR05MB5075:
X-Microsoft-Antispam-PRVS: <AM0PR05MB5075A631FEFD542BC54B9CA9EFEF0@AM0PR05MB5075.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eOrwWKI0+0M8Q/c5JsVeendS4jMa26u08jVZHb8tfaTho/tzS6sRUs7yWFQljCjRGG77QIf5tMdvWw/bJc9Uc9oP45/uQr82HruqK/XZgiVQjeLhzsHnezyrzJCWBd0GpXR6pvmIvZM7rLRkh1f0gmSPMfNtDQXWRzRltAEv6kWKlcP94Lsd5WF5ojw7XO8dFu9052Z3skwzhjR7idk6iOSvgVvDoUK/ZwslfdWZ35qOg5apZHgXYle8/1gYqezlh0gM0EoYguNQQ7Q8m+DeEnXCJSvfxxsi1HV24wDxT8Py4vD01dcE8DYFzqkMZpyo66jmNY7dI23oIsma2Dqxp2Pz10wFe5+GBlbbR6b7utEp2yIjilNJn3jgnu6kzJri
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(346002)(376002)(136003)(396003)(366004)(8676002)(956004)(2906002)(52116002)(6666004)(316002)(4326008)(2616005)(5660300002)(8936002)(1076003)(6486002)(478600001)(66476007)(66556008)(6512007)(83380400001)(9686003)(66946007)(86362001)(186003)(36756003)(7416002)(16526019)(26005)(69590400008)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: v7u1a3W3RGIvQW/gXvRs3tA8GPpbaCYGC/LRhePGItkaZE6YN+s66dq6zxl8AuFHYM/Pv3brH4wSFbp2oFToFl4+TcA64yK69uqBS3tJgQQz3P8xGKWxF6V+HSQK9VLrtrLKy4pbRA3DRU9eFYDK6dBKfJMpegA0fqRO+Ex+uaX0Byzd053p7f2xxQfHgqOq6abn97bdeugRWXgjCnQdTvXOxZ5EgjQK+HPLcey16eRvyLk18YrDvm/nIlIo8r506Kcs7y0KpuoJu4LimDjaUPuF7DJvBuajIHPZqDYNpeOA7Z5inFB/ZCKqK8LBRIU6He1DOCEYOmhzNbTHyDKBsRzxVWGXi12tChlStu+QBxm79mlbvLm6zSndKHKSY78lG4pfKS3hJQPC1KjnWyD+C5uVdk+3E/rmiz77O1BNKt2c3nYnne1EBWorW/xZSl6Cz8wtTUi4QooICSQULxZjUWuoAvlr+W5urk9AbRlCVwWkCnPnuuerIqyD1ye91YtRFnRO7q2pChEfKlQTwV+Z11gHc9dKXIN9mc4+6iawyF/SdfUIZkzteljxFUusidX0SGDbHcXW1n/Cs68O0BJHrreS08CNpbjkoIEwkpPqzE9igROvOmZBOXo4s/bzOXKsS10jz4RPl+tPIkt3oQ8h8A==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbed9be-2453-45ee-1208-08d880d9ab0b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 15:52:43.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: em8+jt/aqsoaxOK1j614FfxGLJesvV+jiSORWz02+AoX0jlW3BH3OZZDSTh5RSrhGeg+SHTpIkDs59RLxX6Bj8MRDr9B7ZGGRIfCvZ76Zqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5075
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Sven Auhagen <sven.auhagen@voleatech.de>

In order to support custom actions at the end of the irq handler
a multi_irq_host_ack callback is added to the struct ahci_host_priv.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
---
 drivers/ata/ahci.h    | 2 ++
 drivers/ata/libahci.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 98b8baa47dc5..d8109e06794c 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -371,6 +371,8 @@ struct ahci_host_priv {
 	/* only required for per-port MSI(-X) support */
 	int			(*get_irq_vector)(struct ata_host *host,
 						  int port);
+
+	int			(*multi_irq_host_ack)(int irq, struct ata_port *ap);
 };
 
 extern int ahci_ignore_sss;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ea5bf5f4cbed..cf9839135a57 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1897,6 +1897,7 @@ static void ahci_port_intr(struct ata_port *ap)
 static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 {
 	struct ata_port *ap = dev_instance;
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 status;
 
@@ -1909,6 +1910,9 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	ahci_handle_port_interrupt(ap, port_mmio, status);
 	spin_unlock(ap->lock);
 
+	if (hpriv->multi_irq_host_ack)
+		hpriv->multi_irq_host_ack(irq, ap);
+
 	VPRINTK("EXIT\n");
 
 	return IRQ_HANDLED;
-- 
2.20.1

