Return-Path: <SRS0=Oljn=EK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B35C388F9
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7897022250
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="BJi78SV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbgKDPxW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:53:22 -0500
Received: from mail-eopbgr10117.outbound.protection.outlook.com ([40.107.1.117]:28320
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731114AbgKDPxS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 4 Nov 2020 10:53:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PX9aNKUrUagF/dlWG6IrWW4Pjnuco0OfzpC0VXJAFP6XqufCpZx/HAT1ecByfoV6oCu9r2oQlvnz3IMli0GikP3dFYYjOvsOycIbhXRL69WLkcnDKU1p55Rw7sdHf7P9M7cEvs7OJntMm3SjleXaGbAMvWbDbz8Joh6sHe419bDcdy0+bXoM1zjh0hsMF7J9ZpRoYpMeDIqHNz+k72TqpCln7M/RuwMFV1usrONv4RAoDiINFbJ7dkYR4DH6/1N7esirq/0QO0R3QXBihvWo/uyaeiSsT64gU5b0yHmXaQomNIAKzm6m5ihV4hV7Me/cvHr7Cofx1MluhjDW/pB7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FcmBVRT+xlb5/zXm2b0EfAxmZx1QcLG+/EDvqs1uMg=;
 b=AIosXCGq9JU7CJyGs3XM1fr3igeonAS5GK+t59Yqll180RbKEH9eOOtRJopG3SnaMKlX5uXgBbJSLdooxSULKBFD1nanLEy+kC5KxxvR+1Fhy8qGZn/pNJ/q3vdL3vCVb7LD27ENe7Um3mb+BIr6h6JO7Jv8O2ame/0wo3HExNw65r2oWUekLrb8vW4BnvZaKRLkp2Qjq7TPXwelvRfaMcq2JxvjB7juFPVghpvDRAl5bHSjkWImCwEka8NrkfUwLiqhkyouCH4UdNR1eqFdxUPWyNyl1wuTReA23YZYs5jwNimcWiNyNPyvU7oxcNRBZnirD76mdkEBuFRs5ihTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FcmBVRT+xlb5/zXm2b0EfAxmZx1QcLG+/EDvqs1uMg=;
 b=BJi78SV47VrACX8YiE2n21XoHCnua6HIkK2hvJhiKcbQocLr/Vr2kyh7iSB8uZKWyceDL1pG60L9vHkpF8Rb4L3Ni0PCjRUeP++hqkZ2RfwIpHNqz6mmDpc7EN+hvA26y3YFESx1LVS/oRSetPgnGKi9igBdAdUH9yD4Zj5MexQ=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5075.eurprd05.prod.outlook.com (2603:10a6:208:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 15:52:47 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 15:52:47 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v2 8/9] dt-bindings: ata: Update ahci_mvebu bindings
Date:   Wed,  4 Nov 2020 16:52:36 +0100
Message-Id: <20201104155237.77772-9-sven.auhagen@voleatech.de>
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
Received: from localhost.localdomain (109.193.235.168) by AM8P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 4 Nov 2020 15:52:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 005b7051-a8c1-49a0-dfd1-08d880d9ad48
X-MS-TrafficTypeDiagnostic: AM0PR05MB5075:
X-Microsoft-Antispam-PRVS: <AM0PR05MB50756093C023EEFE1DBF965EEFEF0@AM0PR05MB5075.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYPgXtSexwoIfn+AtqGYaQonxTFsUu8Lp2NbDKv2gimp7+V2V+OG/P6wyJ4/vEY25B0kvficmnCw5jBTvFU2LeJ7gAFs8jCAdClPSViUuIgnS+q01O7nu1fBM7rdM0ZxyCp9lUDzfWD09rRcNqZpZkqcxiuCUwlz906yN4pVUtmx1H63qwcNNVu7Hflsd2ui8DSb1T2XWeKo83Bqguv93FU0tqXQIWfcNB4iFfzP7mpdNNK6JdDwIq/PN/XmAtXuhPXHwzxnQjRcqzqxkNn/8XcSXwUilGEAS75zd6gTiIXc/booxf2jZyAlrSAEU8qqg5YbFtYc7PKv/P6gvYTtZpQN8qVMQQoEdSpZvQXr4uPXZkq9kd9uBdJkc6MqdoCw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39840400004)(376002)(136003)(396003)(366004)(8676002)(956004)(2906002)(52116002)(6666004)(316002)(4326008)(2616005)(5660300002)(8936002)(1076003)(6486002)(478600001)(66476007)(66556008)(6512007)(83380400001)(9686003)(66946007)(4744005)(86362001)(186003)(36756003)(7416002)(16526019)(26005)(69590400008)(15650500001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: jKYjYDl8x7+krEDes5FjQoZIxvoWMIt2WcvR/QudpaNTAKeZ1WgAL1gWYBxXb4SzMzPa2WjnLXLiPf09RgpHRRJuvAXhW7GrbpOCjFmT34LPv03D1InKZKsrNwdsmZO/zoMIpfyou6wd+mPIpaKY+va61L9j9UmBqIKCaEpGcHRIzYVLZBQn4R3BTHDzVkZHZodCd4gadF0Y9sTsMJSX21v+BnJ4+bXBLjDA7jbnHka93OV1rnfUCc9hF8XVGPOdYuJTuZT3goQmV/GyW+ECjobZUwxrum2zmVOE7Q4GQvmm+5QA9T05TNIeWQi6u4i1fZ+nd7mR12watw05WAsgbXDjsK2CraJJERvx95ypbj/rmYJd8MTOKoVKb86ZuIqyd+i8t3kKLuTIpIYfs0AfGaicmmKvxB9P92WfJDw+cCVyrcW6tj/s831qkml/ILPw2R5c4CPGe8MYLKnvaphz4VcE3MBk11bSndS77UEiyrhZ0LM6oLTjxQUaJHyUs1pimjgJ+s6cb4NyIfBK03IG4aa86YcWC8z98slmGQ1eCRteO2wR1YE7El3yK+0CvaP3h+Ei/eGRnZj/NcjXmRgsdAom9ZU2ltYrcSF5tuO5ZxCcYFZV/rNfcheVMIpeCiUT/tWvf3chQpzu8IleCaveaA==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 005b7051-a8c1-49a0-dfd1-08d880d9ad48
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 15:52:47.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dZl6/dQjRYqIZzFtA57h4YmOEbHRaX4BUq4F9dZLpIPCRk5YHo+NWeJl60/9PvZEpPDFzr6KVyXMgvuBbH4/QbXqw5SJlYZSCGPqIpbCgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5075
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

