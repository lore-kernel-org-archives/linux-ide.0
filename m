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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C65C5DF9D
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5AB222228
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="CzmTG1I2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbgKDPxP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:53:15 -0500
Received: from mail-eopbgr10117.outbound.protection.outlook.com ([40.107.1.117]:28320
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731108AbgKDPxO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 4 Nov 2020 10:53:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTpkKPyTV3cQSFJvefd7HUXGG1GXXMmGJOfToPgG9JehcotWNx7LmaGRCbvsXyTqeEDuyWR3r2VqGJUBxHBS71xJujiU04Oi5XKv22yAYVpONHHVb8ZtayJwkLCBErymMG9kMmFfNWQuSBLB/mBf8wb6KZGi6onh1+HK791k+eEs05DTrNhSvEuzVtfsyivnMVnclfQmRZ+IGRANIPjSGTxhFMRuWnmuontWaGKSgZnboXXyXtwFn+AtN1x+u8SzSp0pmKrUnYBTnLEPo/Jd43GAZEVacIPhaId5Tz43z7DviSbd/pKwkXZUeB/KE3FU3MgYKllNYHGtmVIHRos5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6owgh1Jmkf4KJRh5HqXTdxRQXgqy2bKyEbNmGmbSlg=;
 b=R0ZLMPiTwo60a+8YtoQXgFPbEoDxfQKVleiO0/SSy3Rd6KkQ11T0SLrAj8IeFzpX0mMkv018XLx214UadhszE7Gocfge0ygqPtukJnKOahqFv6hwyruNDdMF74lCfToAB03OrMkT9lisCXrmYjD+HpjotsC2tU+iZ/4UIRU3M3Ono9HVeSM284t5lshH3IpdWHW9zQvA41s5usrjnMcFBfg9anUc4lM59rY+SrqzVS3yiOQPgDhTfTgYqYMTAysfAJ2NkyY/XJmERRbipOAiWbIjc308ktGf4W7RPqKkwSiV9r/fkBuHLa3sWdI0KTDKER1R/aijmXUbCtVhvM8HFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6owgh1Jmkf4KJRh5HqXTdxRQXgqy2bKyEbNmGmbSlg=;
 b=CzmTG1I2mZxBHLes9wtKVDd6KKGBOVoC+D/KN+g5VzhAoEEcugPHY5pREQ45khXFZs+wMtrAW/S2i65qg87mxUDEyQ8rUCgZGkC/J2tR59TMhXLy1kaWQ8V90jdi8kUU0GwZXHSiy1SrrvwRtJz6LvGVLkD4DvEBNtpRTnR3tDQ=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5075.eurprd05.prod.outlook.com (2603:10a6:208:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 15:52:46 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 15:52:46 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v2 7/9] dt-bindings: ata: Update ahci bindings with possible per-port interrupts
Date:   Wed,  4 Nov 2020 16:52:35 +0100
Message-Id: <20201104155237.77772-8-sven.auhagen@voleatech.de>
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
X-MS-Office365-Filtering-Correlation-Id: eed085ef-c7e5-4ab1-61c1-08d880d9aca1
X-MS-TrafficTypeDiagnostic: AM0PR05MB5075:
X-Microsoft-Antispam-PRVS: <AM0PR05MB5075C92B57DDC4930909F3A1EFEF0@AM0PR05MB5075.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxXGQCsw1WkCMa0XLlkd7+qqcRQvg/d7tdiohoIwXBrOrvIV9+rPVQsorC4DCbv/D3OhMZFziZruKx94q2M+BUimIBkW9at5wWGOklHKXXFeeFxHau2hojf+r/xAetALMYaWWJ5IwEtvanOt+HAsA0l+kW72vMU1tg/8FaqOfJzRxLXxWCl77HwDOCQjbjZpYeFAFVUjf/HcBefnvbWacJlHWdTwjeBqElP72Ca8OgvDuQg6VTtH7QGiFVxnWk672bw17lODDouMehBSzUGltiMNcU/exNjCQlHglYuWC0L3qLXOPfM7uuHj3Ky4N0Bz0RFDahZ0HBLK5tJXWYNfcS4qMzY+LU+qQgSuBsftwxU/oaBEOec4JUfvbCTnQnwC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39840400004)(376002)(136003)(396003)(366004)(8676002)(956004)(2906002)(52116002)(6666004)(316002)(4326008)(2616005)(5660300002)(8936002)(1076003)(6486002)(478600001)(66476007)(66556008)(6512007)(83380400001)(9686003)(66946007)(86362001)(186003)(36756003)(7416002)(16526019)(26005)(69590400008)(15650500001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6rBceN3oXQHDdniBDwxS4H+h5JKeA4hQoiBtTZvTjT3B8HhRswtqHR0vprsfyoOy1eU6GgmSSZRkRMFLsPNApXexv2mCN1keIAsr1Hs0XFtpmRWVjQoK6IVx/B51HaWmun1Ckfjf7RxZ68pBLTNqrrNI8Cl7ksohSLYaTGk39ZcxQvC/Vbih0Ne/dTHuyTFLUZVy8ZG7ytAEO6yuaNio3lZIwlqIIJUIJZssWDJKqk6AL96uNGx+XMo748RH/nedXJzy5gsM3TvvvHmaeH6ipp7Xt7Z5I1+oSr5M5sMwRwO3B5sPq/ByiXFhQNjbqzku8qq9kXP9Dsq+lNK0lt4dlWbPGjDTd319yug5rtOKBKSY78dzODkJT3IonHrKXXS1aJsYrA4Hh5MqoFHWAV5Px8ojeZlD/cV4FTK3fsJRiF/O92t54InN69tRq9wQgPZcre0HQQp/uIg7sRyNvgQuUjmj/2fWrmggUxQzoWCV8I/gD8CsC52KiFGQoYPLKi4dOJK2D/Zo34tpdl1vmcbbD32Q9E6gxXHaKAMeDYujfQyHmW87CRbPXp3k90HXNrRCm0DU4hrS5P0aittNb12jNTihYWm1HEbGX1LvhNXmruKGImqBs3v8MD+6ob7HOcBnvUBo/ki3ybcydTN2ew5IMQ==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eed085ef-c7e5-4ab1-61c1-08d880d9aca1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 15:52:46.8174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGP0bhPUAipxsLMvLk9jaClhgbDdcTaE0FtJWamVAfRvi5SkOcS88FUNZ4y3oeXSasTEoTT1805Ialw31+u0NY1yavoktpMJIhtPljWQkIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5075
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Update bindings to reflect the fact that a SATA IP can either have:
- only one interrupt: in this case an 'interrupts' property is
  declared at the root of the node;
or
- each SATA port can have their own interrupt: in this case there is
  one 'interrupts' property per port/sub-node and none at the root.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 77091a277642..83d715cbcecd 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -49,6 +49,12 @@ And at least one of the following properties:
 - phys		    : reference to the SATA PHY node
 - target-supply     : regulator for SATA target power
 
+Sub-nodes optional properties:
+- interrupts        : <interrupt mapping for SATA ports IRQ>, please
+                      note that either the root SATA node has the
+                      interrupts property, or there is one per SATA
+                      port, but not both at the same time.
+
 Examples:
         sata@ffe08000 {
 		compatible = "snps,spear-ahci";
-- 
2.20.1

