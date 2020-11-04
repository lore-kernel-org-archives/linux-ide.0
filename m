Return-Path: <SRS0=Oljn=EK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39672C5517A
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32C522280
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="ln/q22YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgKDPze (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:55:34 -0500
Received: from mail-eopbgr10117.outbound.protection.outlook.com ([40.107.1.117]:28320
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730831AbgKDPxZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 4 Nov 2020 10:53:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgChGeysSLa/mTDa3lfwdR07Jw9nKukP8y4roeGODi3FzWQzc3J4DZfOGkFhpmRwskfG93sP2RFwKh6EC3CfZ0MH4XbL1QxdglDthPhyUIOsZagMhM7cK4fBvTSeoNbu3kMvXENyhFSNcLj5YtGHUCQI4JhN7NYgOgeV+r2zXCGUDI8OHBSu4EzdXOT1Rlk3zuGO1hdHc+zSNNmf2XMyWI9URrvgf/HGnGoqezzGJSG0LjK+otAhWSQ4IylU5KrEfJ/zgmu97TVM78bXlplGKzkRstVDEMtrv8A11LyNdBroXa50rqLk51n11CKKRXZIoorShCmMa61WwkxbmjgbAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87Q99SMU4MXkLq5cGEiez4Px+9uWDVh7KODXXBL9itk=;
 b=VU9GcPFz2KM5doSurYymeG0Hqip7u70HWzgmoCOlWzo5HCk+ywh1vsFjuHtHg/G/bZRlyNC02J46HUfZaWRgJAlVdKKZ7FSdNHGEGaj0ZktPAOeBReNNSJJe9SI5iOqlsbY7OEii2jDWYS1S0Bp2U11O0bIzd27JTesV++xujosXwQTu87mAEk7l2wMBVRHuRVCfnvSUGrU5TzghqvR9heVrn4EsmbuQElVEjvZAAAtQRzbdMPpn/VYfLS62SnpICEBQFgXQsT1EVmJs+dyhc00bdW9wf4m1yohd4KJBcS7PCeIUw2YxQQZ/AsFLuV4FBowpfiNW3W4VI1PFl5vMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87Q99SMU4MXkLq5cGEiez4Px+9uWDVh7KODXXBL9itk=;
 b=ln/q22YQu2vQD+aZKE9I5/Z7Y4gGkB/RPrYKhv5Xrj1pGi4/VrgYYGfegifUVxsHTAPjFr8dFKQtaTz438hcgRpge785jfm4w/kO1Q1Fn7g7WHr5lR3pMX7WPtHGwrAZQQ9xJ80uCFPsIgoC2FBHYhk6ZINR5JwYsfS/LabiQWQ=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5075.eurprd05.prod.outlook.com (2603:10a6:208:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 15:52:48 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 15:52:48 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v2 9/9] arm64: dts: marvell: armada-cp110: Switch to per-port SATA interrupts
Date:   Wed,  4 Nov 2020 16:52:37 +0100
Message-Id: <20201104155237.77772-10-sven.auhagen@voleatech.de>
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
X-MS-Office365-Filtering-Correlation-Id: 51573852-115d-479d-fe7f-08d880d9adca
X-MS-TrafficTypeDiagnostic: AM0PR05MB5075:
X-Microsoft-Antispam-PRVS: <AM0PR05MB50759326D8F3DA92687C3459EFEF0@AM0PR05MB5075.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvKU1L5ks6D4MSSBIJxph9LUANCvaBaVuqMvGc7Qpm1QZWV7+jEdwB8KTZo8oRdS0qT1rZMLtfF8XrVIgEHvtcp+8UwfbpGMA2Oc1xZkGU23QBfMgZk0v2plSZ+IuV4U7NlG/0r5v0q3C50v5L8AIwAoQHfTy58aVMwB8A33ofC1dqYwEXotzDRqUl8wWKi5uYMknRS0BtfgCsqvDFvZ/G3/FKLrvRE6+1iSvlKBOwTpaHGMfo4Jm3X/Q8NCIOy6wtDZQFVp03YuYtCKIcgNHzafKwBMPhUsO3KfhpTtBbqFzfFese2JWMWZMm1YskOy63xaQKgBlyUt/N7sc50LnuyHR44+NZ2xDuZjl/syvcem2ahMxlG+1N9qkM8LAB4j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39840400004)(376002)(136003)(396003)(366004)(8676002)(956004)(2906002)(52116002)(6666004)(316002)(4326008)(2616005)(5660300002)(8936002)(1076003)(6486002)(478600001)(66476007)(66556008)(6512007)(83380400001)(9686003)(66946007)(86362001)(186003)(36756003)(7416002)(16526019)(26005)(69590400008)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Qvj9yod7xRazDJdc2wSU7m/PwISt9a9aSpO+Xxwa4NicWzMxLBeQGiudpCStxSmdo1Vbe7/TWmCt5rZTUa/qzwbGqpxCQolZ4ukIgq8lWsCao4kb9NtdhDt9vZ1OYph9Z2IJfCyAcPa1G1gjCBE5g/lAgnekbC1SmcU3jIOEe6m6411r+M002bd1XI9wbS/N8yTvpqOKtKL0TZlTVxh6pDJRX0oRLuOlkXx/BQ/tSrt3EYBBzTe07FRw5ELTf8siEm68FcqK81MNJcNSUJ9gA8bc+PqJNF3dGytzYDFAVrD5rs0a7RdbH/TQ6Sv+5VBFdmw/CW0FLmvDA0JG9ovC47yJscjlp1eXesnNfDMeTOfMHWaUWPcsq/+8E6Ia+AkTsrw3ybhaBAd3j/OXw1IhEdJzbp5j1L4tdzM6/z71i4q7Se6Mn58nL8huJF/j0YCqwh26dGotqQuLo2t7jRe09OBrFuZ98k41tb1TCOpmP4AvjZFryD1nRHr76iEskeMJ/PqrdgKhv5bHb+J4nHyKCzxJCNl7zICyqYsIyczICjk741YAxD5WcVtDenmpv0WNrDBgRvdei1CfR2GL3dHD6RY8dymUSODhYE8Eg7OtNpwmtMG8Ob1D4Xq1hiTCEYBE+o3cKBN9yV2Vf2r2Kgqgpw==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 51573852-115d-479d-fe7f-08d880d9adca
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 15:52:48.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBLpEURaDWJ4mZj0y55wNodU/X+MOR4Aausce6J5ogzvpD9u6a7f0FzhzMqGxZLOEL7GYSgFAX4/dV6eomru4r9Tf2KYoB9Q/Swe1GVhICQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5075
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Sven Auhagen <sven.auhagen@voleatech.de>

There are two SATA ports per CP110. Each of them has a dedicated
interrupt. Describe the real hardware by adding two SATA ports to the
CP110 SATA node.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 9dcf16beabf5..ec27294f097b 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -300,11 +300,9 @@
 		};
 
 		CP11X_LABEL(sata0): sata@540000 {
-			compatible = "marvell,armada-8k-ahci",
-			"generic-ahci";
+			compatible = "marvell,armada-8k-ahci";
 			reg = <0x540000 0x30000>;
 			dma-coherent;
-			interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&CP11X_LABEL(clk) 1 15>,
 				 <&CP11X_LABEL(clk) 1 16>;
 			#address-cells = <1>;
@@ -312,10 +310,12 @@
 			status = "disabled";
 
 			sata-port@0 {
+				interrupts = <109 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0>;
 			};
 
 			sata-port@1 {
+				interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <1>;
 			};
 		};
-- 
2.20.1

