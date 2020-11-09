Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224B8C2D0A3
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BE820578
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="VUl0IwgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbgKIRkH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:40:07 -0500
Received: from mail-eopbgr150099.outbound.protection.outlook.com ([40.107.15.99]:6659
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731929AbgKIRkG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 9 Nov 2020 12:40:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0rZABduTWR79OZE52Y/M4b5+yxPMhQ3vxWA5AYr1hBAtQNBo1puI57QGQHtoe1FkTQXhCi22Y/UvxoqlBb+tpmQPl1EtHO/S8i1IorhbqTl7IC2+sfln3uWCsFf6qGcOLXftqOP+/W8IMqWpZapyPaFWPPyirxH+BG+hsyjc9wvHtBBFbrJ56LGB4QmDpoPNiBHGsc40SWFDDYn+mIp1PMnni8Hv8D0qS3HRgK3iwYd3ZGgVXwJ2IQxxgjWtRlVksaRQTbS8BT/lQH6MPHu5KgECt/coNzgK4aPXQraitRQ7AFdPB/V+FClyOXop5OMneXdT05fhKJlr1rQvLOQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPF6H6JxLZMYIurbdmVAJG3Qwok8XNcirQWPP7SWT4c=;
 b=T/WRtcK0iW6Q4KRea+FAgVwz2Iyv6ziikN5aj1TxJxhOk/30b8f9ySIwPygrPf0HTjLaUjIapIXThd14up4jTsG8/vHoiMmvOcaF5HS25pBmW4A+ZCSEfnlct1T3nShn9ChfQ5yY2Yn60rAAtzXQTT0FqjN4QHewrKSR6yeConn4/XiA8c7fKvrSa9/gBqQhT8erCxROwUruIYkhPQuifm8hKghSqjs02FgQxc1S/ca9zq3XVpzQX0pV5TnLxbJaWaHEnx40vDtk25Qv8aOmV82K52OnxFf7GKqRv+5Uq1x3frh1HXLD9TRoem2vWe1JYNjljzSn68dyDX5X9nLvAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPF6H6JxLZMYIurbdmVAJG3Qwok8XNcirQWPP7SWT4c=;
 b=VUl0IwgLuuZBHU5N8ZddbWn1MmCEGl61NFmhLkumJuejKxKSUdiD5qPieTB6hlvw+VO7uuorgyEbjWTaUHNIjaL/EV8HoG+R1Da9Pih4xFI6atxejFJNBAKU4FURGF7IJyVVL6NXzFLgTR9CjNp1woQnIenOOyEEdo3KuTXN8KI=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5362.eurprd05.prod.outlook.com (2603:10a6:208:ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 17:39:54 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 17:39:54 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v3 4/9] ata: ahci: add ack callback to multi irq handler
Date:   Mon,  9 Nov 2020 18:39:43 +0100
Message-Id: <20201109173948.96663-5-sven.auhagen@voleatech.de>
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
Received: from localhost.localdomain (109.193.235.168) by AM0PR04CA0135.eurprd04.prod.outlook.com (2603:10a6:208:55::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 17:39:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7a47d21-018c-4b07-16a2-08d884d677f8
X-MS-TrafficTypeDiagnostic: AM0PR05MB5362:
X-Microsoft-Antispam-PRVS: <AM0PR05MB53621E4EC434DE88883A1C68EFEA0@AM0PR05MB5362.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KM8NMiGvszGJo8DTpGnvb129WXgw2qzcJCpMElPcLWQOXcuWOM9gsv/EPC4y0Z8qlhZpA4VW/u2X5ePUs52sPAEI83FguKrel+6OYZEzUGV9pQjUhLyk6I9vxwWUmAM74Wf7L4hYeEHi/qk1OAbMremBjX8v4MxSTj4Sy5nzIdKa5p80iPpL/mR7qjZmmReE//QionLxb5NfcR+KA03Lem+z6N7f1o7lBPG5MCQ+7SNhXwxBhQd8HSyQjQXQdMdofpnK36MlYhT9W2YRRsQ46Df6QJq9OkgxlzAmo7yYw4e8jVQp6rIx5S4XCkXPXmbHIO+Xrhhf2rd0uCQKc2sT7IM9udhH/tcfUAWsPB5o85MRqd/bKJzxlfop9NrPTNdD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39830400003)(52116002)(69590400008)(66946007)(5660300002)(1076003)(66476007)(66556008)(26005)(2906002)(478600001)(316002)(9686003)(6506007)(6512007)(86362001)(6666004)(16526019)(8936002)(956004)(4326008)(36756003)(7416002)(186003)(83380400001)(2616005)(8676002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: b4+YQlbISVkjAsMd/kdQpcGCiWR5Di92cjOXUu1MSuGbTjGdpSc6HVCpW6RDdqlKm+nO7IftJe0/QrNSLjFizN/8XS1wZCMejsnCQK70OKVewtmDPbaKcWXsRJJ0Cc+lE2/AwWgif19423w3rV79HnjnUZ+AZzGM3G7R7Yub5IprQQxTH21EDjkp68ygQQYuqz3M6mHCsYu8MQNUveaDuaCB7XrVEMiFa7rWhRBvQgIEWi1oKb2f0c6W6rW56yR6QJVY/PMcceAQLrb6M/OhPe06X810qMIUitSexhNeWAOiTttOGPiDVmAMKUbm3uOBgOH46AyZ8EOPFcyK9C+eGae1BGGAJ2BVQAOjI4N+hEc2zQAdUgWgm9G7VfmnO2iZpevCIqV5SaP+Fg6k+xt7wFE4+y9pCJj176gVXX0e622vdfHtFaIMlrq4HhBRMbc8DHqXR1PKMb0vjfyynuO87IbBZP9uzTNT8ePzX+V8K1jp2AV0e/ij0cx+DCSNYeVeX7mEJ/Yg4UlFfi7efs9SibWuf7mZCyGQuw11UcDqbKPjZjSkNI5YnitR7IqEn7kUeX7A7I1tN536GfKcXqhYck7JBrtbSDqZQ3zxpRe05N1PcrvDVeYyLxX2aDF2zIbkW+lLaeyGgPEY277UXrS2DQ==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a47d21-018c-4b07-16a2-08d884d677f8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 17:39:54.4745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tD3chbxVavYggTK/nKH8mDk4Kd8swLX3C6LcToEGh/tnCwX/bjql0mzW5Nl6B3S0pIWjVeKVYYrmvG2wUpkt0u/B9cF5XRhEwmqUNc9Z/z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5362
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Sven Auhagen <sven.auhagen@voleatech.de>

In order to support custom actions at the end of the irq handler
a multi_irq_host_ack callback is added to the struct ahci_host_priv.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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

