Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EEFC2D0A3
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9056620639
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="G/WgwGGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbgKIRkC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:40:02 -0500
Received: from mail-eopbgr150099.outbound.protection.outlook.com ([40.107.15.99]:6659
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731177AbgKIRkC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 9 Nov 2020 12:40:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkNTLSLofs9Saidu9U7tj1uWbPE8WCMXR58ZYyscfQ/xsBEDCX7/9HuPF7Z7U2QsggQ8zLLyoE+SjCTCj83rPlXUDiX34/FIU4fdpzUbR4HDOfspiHlcHk3L6caStM/QvcTe4oa6YE/Pgqu1z7r1YtB7SddLlgG8u+j8U0ysrcZdALRx42r4eHeCQkVM7Rq8oFyzDmWQbCjNYLChVm4ItoS3Y32yZaM3pH0DJk5U5zxi+Zq7kr3Isk+Vy4ceN8zveAQdsbQZB8dahqcT3ETMEi4vlTh4efaFDs/J5q4Q98cTLKYY3Klp5M5UPG2http8ZizZAC5YZoEgE38hGDOZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekBpxwXSVONW5QZmfSebcodwkrfrP31EZtizj5j+ryk=;
 b=kYSU8ahysmvElHya5NbwQ4WKcMr2f29YT9DsSOug+I8Figo7sgVqAHvuUKQsL2GoCMW9LOzlgGiEPro7DssUDiHYWPnb/ppRLiBL6HUH6KLmcZSGlPxsnpZOR8bEoFUNfO55ihJt7hWr99iQ7zuuh9xK3dmn0QLJZLasv4Hl2aQRZcHylZfqZ2sXPk5dOK545NmYAmTO6n9/TJmxAuptuy0cghP7z2WI2DVHcoBPn0FqHgOY1MHNCPVDYGLU3VlMoiZgp19p/4FPlIKBouZOdDcc+8moVNhmUs70vrzzZistylCpz2qJoJBmoBjzAhNc6x8nMO6qY3z04fiBwrokbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekBpxwXSVONW5QZmfSebcodwkrfrP31EZtizj5j+ryk=;
 b=G/WgwGGFGFGkbz5MOc5NRKVLNA0BpHmcyj38a1r0oDJKri6EGOE7oJK1uUiSYDtBRP+aoZ4OtVOzY1tJ/fMKh6seyLE4hJZUhBkvwrtGjDHUfyibUlpmIKy7UhXDUJ4UV1JLb9dghNjQmqRfXGzTs9nWn3JsiR1jALreS3neapc=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5362.eurprd05.prod.outlook.com (2603:10a6:208:ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 17:39:53 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 17:39:53 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v3 3/9] ata: libahci_platform: Do not try to get an IRQ when AHCI_HFLAG_MULTI_MSI is set
Date:   Mon,  9 Nov 2020 18:39:42 +0100
Message-Id: <20201109173948.96663-4-sven.auhagen@voleatech.de>
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
X-MS-Office365-Filtering-Correlation-Id: db2aaf42-1665-4711-62dd-08d884d67779
X-MS-TrafficTypeDiagnostic: AM0PR05MB5362:
X-Microsoft-Antispam-PRVS: <AM0PR05MB53627F58A23C4BCF41FA14F0EFEA0@AM0PR05MB5362.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNwms+2dghsoTI9SBcX7yDzxpVc481yQ1tiEY6Okhwlbf+K8bXJ7SM4iMA7hFMd6P8otn3QNGIJuFZnOzv4UtQZClQfbEKovs9AcJHYnuBvSGzk0RDpFTTyoISWnd7M80KbmRM2M+bHw7QIf1cIDRHLON+FoKGenCxeQeRlDBL6tHHLTkzZETbhzh1i3Zf8odbRJJ9VkcPsyJ0N9pWcexBlDY200GaLqqGYnthA+FOeshKM+FVdXBrlnDGaMEb/cPf6MMM0bBajmctU4K3DcSPXmXvF3Is73mcFSruWHOedQBDg57Ka7iLhx1C3arCyA9fBfW1J/aSpPyHyvR8hswrwtxvkvq9o/uAMssrwTsyrmJSCGGbLlYhWm94Cxns1y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39830400003)(52116002)(69590400008)(66946007)(5660300002)(1076003)(66476007)(66556008)(26005)(2906002)(478600001)(316002)(9686003)(6506007)(6512007)(86362001)(6666004)(16526019)(8936002)(956004)(4326008)(36756003)(7416002)(186003)(83380400001)(2616005)(8676002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: oZ3lunCPTBezLqEHn5J8NQVT9Ahfpz759AK09Q96PG04pTTkmwf6qkvOijoy/xTNS8SwCEKye/WCBeDmXAqbkByBk/iYZ0xk+9x1byAiJz1L2liRhK6FNig+E9Hnnl+nqJaYpaG+uBTER4fWScCYaqFmbgDr+YixqmV9qgNoErGRmlEjyNojHtWBWEIA346IoSxWC9fOB8XieZ6Ufio8XPTdcgM2RiaOE2X8oN7HOBd6+bB0mjIp4wjr/NWkbNRa/wwia6oDJfUTssPC0iAjLmV1/dw70GfRW59/AW7M9ZSjLmemktbJAf+V854lvVU9N+yyV8uFh2ApjOBoYRiSLGDgIgv+7yh7tSVlAhM/Q0BkA/MT+hFX9+eWxqW9WQKEdd4dRbhYSTbnFkhylJbJglqWusmVHZowDefbJA6aGj7tx+n1qbYwwk/cvbtYCVAS/roYsPkCHGGXR9MQLvHtzcgaW9jKqOy4JeO2v4Z+eSa9OD6MXuOlsBO9XwJJYWeNeBMh0IdE4RMI6FKSXjw7cB0Z+cLFDQl4M2Eq6CHiJbZnL+ZcOReSVYp94yDKQgJMu9e+gQY6ojolzI39h636RXvFOkRHUVAEBkZHawSGZhR7ute7Ct73LPKYOBM7OxfHkPUgH2Pp88mZKFcca7/4+w==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: db2aaf42-1665-4711-62dd-08d884d67779
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 17:39:53.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqdszF7OohjbQ9F/P4JgQAi4HePimVSEbbu860f+aomUYa8UhvMrglFPPnnNk7XWgrksR+AmCIn4IGcFpNNw/FLwF1bpqK0w/3qgg1eGkNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5362
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Sven Auhagen <sven.auhagen@voleatech.de>

When the ahci-host AHCI_HFLAG_MULTI_MSI flag is set then the driver must
provide a get_irq_vector callback and take care of getting the IRQs itself.
So in this case ahci_platform_init_host() should not try to get an
IRQ itself.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
---
 drivers/ata/libahci_platform.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index de638dafce21..f6f2a111d226 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -581,14 +581,16 @@ int ahci_platform_init_host(struct platform_device *pdev,
 	struct ata_host *host;
 	int i, irq, n_ports, rc;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "no irq\n");
-		return irq;
-	}
+	if (!(hpriv->flags & AHCI_HFLAG_MULTI_MSI)) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq <= 0) {
+			if (irq != -EPROBE_DEFER)
+				dev_err(dev, "no irq\n");
+			return irq;
+		}
 
-	hpriv->irq = irq;
+		hpriv->irq = irq;
+	}
 
 	/* prepare host */
 	pi.private_data = (void *)(unsigned long)hpriv->flags;
-- 
2.20.1

