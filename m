Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E4BC2D0A3
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972DD20578
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="MyFtiOMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgKIRkR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:40:17 -0500
Received: from mail-db8eur05on2090.outbound.protection.outlook.com ([40.107.20.90]:23136
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731476AbgKIRkO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 9 Nov 2020 12:40:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ka10mZ+uOosj9as1CRsZgA+hsPS7zN1pM/+ytPQyXHHGsToE+11nbadASjycvR0YsHUNmgKR+Oa5gkjO4y3ixn9NXxwNrcU0YYZgwCjr3eXVI/8viYdZoOZaBr5T760xpK2eYkqgMs2JGfyKdRI+Umaal6NDJVPjbvIWnFLlhOAYYAtowZ4U2Oxf4ov1nEJJF8xVSrGcREJY9DnLvsZMgd6V8bPiMuCTSWJELdTSjEERqQPjHsdeddJhRKYcTdz/IBiLi5Etqyil4fe41A60sBvHl7nI1DGGIMM/IqY19COoDRy7wdar2QgIU96+of6qpy4BpwwRkFilRmZI2l/yQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87Q99SMU4MXkLq5cGEiez4Px+9uWDVh7KODXXBL9itk=;
 b=IBe+aHnVY2iJDNiElQIirdnrWHdZENknO/Ccgm6xHWqhea85uhDMWxkGlnvm+S+rg6yScPOvpRPLuuje8Gus6938qxmZpB8uFptZDZi8cwRh89yS0zCq/ffbRRdD8vjPMiFqZnvP+UmeKHYOSFP4VBbueVs6arqJQ8/jpGdwFb36gvX8oLnBvlLfXkM53b6qPEYXdLFCi/0WZHyav1zKtF+Ie9ERZEMbGJT/QpMzZTKuiJrYmCUvm0Mh//3sYl2Qm3MmAfrkcAo6iql+GRYkYzUicjt3knGWr9nU6hF+ssAZ4X5xpWh+ymqVcT/7dRW211JkDjBBwtqbregUTojldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87Q99SMU4MXkLq5cGEiez4Px+9uWDVh7KODXXBL9itk=;
 b=MyFtiOMft8sj9+FL3bHSRzSClTRygwaJTvtbxH5/pGxtNxt5gNg9QzS0x7RG6Wxa5SxbTivToJvuBmit1eu++YSCqJH9ThmIO9AMhyrlBrCf9qN5IGLZyncOD2cpMBxURekCvZWK99RL9TwrXvqEAo8UNNh6uyikDEONbaX1wNY=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5362.eurprd05.prod.outlook.com (2603:10a6:208:ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 17:39:58 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 17:39:58 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v3 9/9] arm64: dts: marvell: armada-cp110: Switch to per-port SATA interrupts
Date:   Mon,  9 Nov 2020 18:39:48 +0100
Message-Id: <20201109173948.96663-10-sven.auhagen@voleatech.de>
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
X-MS-Office365-Filtering-Correlation-Id: 61821f76-aec2-4dda-c074-08d884d67a71
X-MS-TrafficTypeDiagnostic: AM0PR05MB5362:
X-Microsoft-Antispam-PRVS: <AM0PR05MB5362D130477D584465D9A079EFEA0@AM0PR05MB5362.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: II15yzLM1DeoN758Zj7QCX//SeQh9tF3PmLSdbdDF1GRjJPjzbavll/lwGe91Xnq8JU24YgjJ+01aW1AA4NlqAB7nr1KpfO4k717WDSpdlfWXBQWjBiXu1JznekG5jDLCWKpWPnu6edTEv+OEOFAcamghw/QaQO26xrHIbGUq8H5f/WQJqWiFVvHJ5K4Ft1nWKHNQvDtE8ITvRwZH3adX+Yic+1b7pynA/cJlg/c+mL790T9QSg/gx0qHoin7R9Z9Y+Hqu5XQ0S1y/U1xNMWaEUGC0QiLUUpE7cvGIB5c6xm+P9iN8KgjP4ROP4jyucyzpP9evWUQkm0/tPhQJmKNJh/Obl23niw8/kBLo7V1B0qW40SvxV+v1dkEkJR+7b2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39840400004)(52116002)(69590400008)(66946007)(5660300002)(1076003)(66476007)(66556008)(26005)(2906002)(478600001)(316002)(9686003)(6506007)(6512007)(86362001)(6666004)(16526019)(8936002)(956004)(4326008)(36756003)(7416002)(186003)(83380400001)(2616005)(8676002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6Z+EGIrCqk4Ck5j1FczKR+CW3oCoaQwsjjjkDfYJpZV2kVA5c+zNVRUSQdPNTcl5OSG9oYttQc+tXALUpYBeRoFfa7Uyape4FlBADM0ji1hIpyAwsefeGHhJbPYXj8zrGGeKoLYkljB3ePh2WGfEOp4BS/h2PpXHFJPp7AUGpeJsH8pe9+xSzMOaywp+w8+qT400JjsQ3poYrgdudwcM/C2wp6TUKlhYfRq4/lfFslwAOHMzW/A41eeBjeCrnWdLCuxByZdIwG2s1VaRV53IbY2d9Ar7SupUJudijbzJXX+C5e2D5ZLMR4TnR/Y+743Ufzlk6TlSyl+iuE6qK/m3GJWdBiIcVG4BYd6IMLH75z5XFePEn+XYJPOfpKw2hU854lGR3JfBCV+ABXhgw43BxTvBki6Cz25ixrw72t1r+4Q7y/4chawliykUrjFTgaM4E++drb8AEkwfljbhCQRVgJYgQaV8r3ush9t+wgrgjnIQUaEpin3o5IcgCP7JwEaoR+ht0fPwtaIU+Yq3uiY351IN9BG531YYmVZpGYATgTnkjeEqS07uc57GwbpKMtdFKrDxWw5nAYT66XfKwrRBc2sB76voAXAuyh1CbIIoKO5II7m4+cZBhYT9a93jmI7IXKUCdxdeDc7a+2p2b1UORQ==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 61821f76-aec2-4dda-c074-08d884d67a71
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 17:39:58.6342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBZPtFjrgWu2c2Vv1bsdTAbT3sKYFsUUUyYtU5LVB/bltI9lhD7r/kK768BfrU5zerp+32qM2NtL4oMKNF9osa8wcSyqbR77e5Ba57lQBc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5362
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

