Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4957EC2D0A3
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE58B20578
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="WP/LeMr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbgKIRkO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:40:14 -0500
Received: from mail-eopbgr150099.outbound.protection.outlook.com ([40.107.15.99]:6659
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732041AbgKIRkM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 9 Nov 2020 12:40:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZzwUR3f1mAM2glVYXU/EaSSPOKB/BCPE9csIBHMct3ZEckX50KHhhbEA2Wcy75vLeQLyEcRCaMdRgrAv/HKk5H0wHYcnI3Q3ADsneOf46RqLjq8hP6s7ISE227sQsTmgAzkA0LIJGw9d4C6MQzSYjfLpJTGWaW5a1FR+GAtYZNsuOIno5OhA1+s3ltQ39P5H3CZD/fyfzUZWLq7xHhdQtd/oYNpyJZUi7UEOWndT1Ul5cD4GR4zpGAZvq/AzUOXeHVtgUVh0P9N0ObJj7XgpTDjg/4gq/neQDrZiefyTepfERbHhttTCdv8eyMW1e748AmvOcmx8Bg1x51WjFZDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FcmBVRT+xlb5/zXm2b0EfAxmZx1QcLG+/EDvqs1uMg=;
 b=CXwAmX/XA7pA0KBYe28u8scGV6j+xyfc7PVnz104V9JT682mignJ3iA1hBeGuVhWghsfAkh1/JMmm/WDO4kImEbaVjaO6SdjBsjRgTg2KozcPh9a3WrrQg2agELM2ljMk8C1fE03J3G9g6jueGQB8+Avx8RPmdIghkKsRSkNgMVTjvXfk1289ECr4pZzRS0MnSs9IC1CpPbivtdurdkbn6BHRFp6Ocs9adTFz7kLxINSqajUIMzo707WROQtKxwIqV3vJ3+QnvbwpeB7bsEl1tD/nVOACzUUZCwL5u2ncDivvWvsp+w8IqJNIqni/Nbf3lejRUWyRTBtKXr9GB3A+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FcmBVRT+xlb5/zXm2b0EfAxmZx1QcLG+/EDvqs1uMg=;
 b=WP/LeMr7JvFsJWzsHXrc2MgVtQiuKjDgLLZjKDi+/4BniNRxPAP1MIhXrc8qTdDu6BBhTZeD7dRUuZJ7XNb5MVMT9nZsnrhrzNx5mMxVJQyWuDbSWc/aMCmLyirYqDHk3EgqB+tWyOWyhKHprtm98gnO2Acd0ErqkqPhFUQGcy4=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5362.eurprd05.prod.outlook.com (2603:10a6:208:ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 17:39:57 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 17:39:57 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v3 8/9] dt-bindings: ata: Update ahci_mvebu bindings
Date:   Mon,  9 Nov 2020 18:39:47 +0100
Message-Id: <20201109173948.96663-9-sven.auhagen@voleatech.de>
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
Received: from localhost.localdomain (109.193.235.168) by AM0PR04CA0135.eurprd04.prod.outlook.com (2603:10a6:208:55::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 17:39:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6dad091-cb77-4f65-29c6-08d884d679f0
X-MS-TrafficTypeDiagnostic: AM0PR05MB5362:
X-Microsoft-Antispam-PRVS: <AM0PR05MB5362E5690371ADBF46CC5C60EFEA0@AM0PR05MB5362.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTaG7CBw/BTFZ+ps7QWutkgS4SDRF34U78z0nKErwLFBNI1VcWLhEoVnqAs0mZYxmUerhW2r/4vz2S+uV5dNtkpfvymIveUdFXvtPFN86Pb1wNtwiriqUFPEXNqc/Y4D66SOnRuOQj5fB+RRbLNgnC0OMkKBtBzkwImjD8wz9p1Hhmv5jBayxMgI9xnU6qieaIdQwP89tSS2iMleSPFnlwykc8Pw6N8zM6+X4kocyVlTuw1MDfH5b/9p7Zr0RdCBfTWvQD7niFHmJA2Q4kqxKyk7kXTC5X4R7cw0L9jxoL7UZL93+X/WjJw9eSRh/YVw59bdTNuSxoXNoRHh3FpN3zqVC2I9KzIvj3lSjSmu9FNHBeqrrHI111BNW9Ampq/X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39840400004)(15650500001)(52116002)(69590400008)(66946007)(5660300002)(1076003)(66476007)(66556008)(26005)(2906002)(478600001)(316002)(9686003)(6506007)(6512007)(86362001)(6666004)(16526019)(4744005)(8936002)(956004)(4326008)(36756003)(7416002)(186003)(83380400001)(2616005)(8676002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: jwetCaJBpaxWXf3x98E13k2t3azv/q58Lc9TQctacuFHuXLqYlGfo3CwY8z4cL0+LFlFFHaXHmDz3z74HCMBZJ/8rndE0lyAnWr2adGBy/Ryskxdz72UDH9Jnz6i3zFYj6xOSbmLFFxS1ZKOneUMsGE7tCfvA3ZZ8ymfGyT3NmaiXM6P09YdBtETObIHbodfRCtL/Hzn4Glvk+hxl22bDCItPRZFzoGDKHgfzt89ESMd5TkNbZH0vNyvpXUWFTk+eFD73PC/H9SEcNgJLUkR1nMQhgIuW5/4TWUNyqyACVtZ9xsvi1xOTBdMm2wfZvs0iSdK3Enj50PTjBSHFnHAc9IUvWlHnuSezIEZvxrS9sjd8PT3OOdH5HbUDfS1oXYNkklZaZsfT52/5ViTTGefxlSFXFbavRtWzEg3aDcTDBb6WDNWNAvbMi7tP5o4VgMJkY4m54bCibC7tKd7GL9/nb2nKE9refOFLcDgTLjUl62fImFEX53trHtzoualVdhSMuEsqG65j86qHQ5XXPBrnh3iL9X5fCJ3RJf3ZsE/SV2h3ojNVS2DPajRQg8wB4e0X0kkkfb5NzLQDc2mAbTWNh7ohFInekCUbMUpFfeK84NxMMPCn6ycFlu7IdIzbdm4jEXa4ASl4m9k+6KxzBG4Dw==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f6dad091-cb77-4f65-29c6-08d884d679f0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 17:39:57.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fNiJ/ioOyUbWxC4duJeoPGHVQBZviUXdMuNLdp7m0xvrFkbjSrvinshMrdJXXMUiXorcbkWoVB102UO7Be96jXB+wuqLFb0yDeshN8HEmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5362
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Update bindings with the already in use Armada 8k compatible.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 83d715cbcecd..78d9d413a5c6 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -15,6 +15,7 @@ Required properties:
   - "ibm,476gtr-ahci"
   - "marvell,armada-380-ahci"
   - "marvell,armada-3700-ahci"
+  - "marvell,armada-8k-ahci"
   - "snps,dwc-ahci"
   - "snps,spear-ahci"
   - "generic-ahci"
-- 
2.20.1

