Return-Path: <SRS0=HNFi=DO=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F71C47420
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1ADF2176B
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="PHyO0THm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgJGPqU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:46:20 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com ([40.107.8.90]:50658
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728728AbgJGPqT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Oct 2020 11:46:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVKa4QwxWv6GviJlUuXMhbhQOOXeoxVQTaPoWNcU/OYU1UK9uqTONmTWc2QizQ4RAH1efDMeRENFd/7CM7YdWmYhBSAGCLz0AD3vJQ6+4okwJRzZoACOCeC+eA4G3WW9P3OLVGtWYJvo3DKI849DME+Q39dDPsVVhY/XzJ//NTdBv8cQI7kzI9IZHUoNcEz4eWw5uy3wWT9pR4BM+GH6OfCR4Moz2o/ozw/gIOLRcM4Q6cG7isDimG28DHgZgOKzubRvrp4jqPZA7VaUliX95OO3YVU+me4EAHlO99yGWcZ9pVO4zhhHPbvBx3lOJmkrXQ3S5H70BfAjLuhrbVuwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0J0F+ZZfztLObf+ffDbTOb1C+UP0ppjG4fFyqlwRWI=;
 b=QlMbUD9HLes6NelAPZewlFcVy1nR4EsUeMenu7iAL/A4GXyg6T2ASQ9OkjVDgoNGuxadJgPcA9EPbbuwOWoa4bTos1s4fIvWsPWNURcJwROSqfOAqxVWrvxuI1G0cRXomMEKePl499pi3V6g+VqZjS22abqOiH+QXa1LDlDk6hGFGndy8Sjd7cnp7Ry5iAocjfcBHfOn2iiaa8sixGA5xZOGftrc8kHg94/whLbTcEJ+bNpyqykOeZIIsV90wyKUfPJHKP9UXOUgBeZ9jO9+FH9U6vaAvc0Gr+vQ/G8UcqdQLvYvigUkHdSZbLzOToLkJtBEPsU4NB+OAgmbaDpQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0J0F+ZZfztLObf+ffDbTOb1C+UP0ppjG4fFyqlwRWI=;
 b=PHyO0THmSR0Ko1uPY1zYhC+vDLZzl5GJI1NTM8M6CD/nGF1b8O73KCBC/ivNRgH1YOiZWnFVwCXWF5uAGSJt8VnpHpqOAjwvwGEP6U418uvlOCR7bmREeBRSSKBx9WHK48/KcTGSqAkrK31LCQmhOAQxyJ80PN8XTELOBic0U1c=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR0502MB4018.eurprd05.prod.outlook.com (2603:10a6:208:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 15:46:04 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 15:46:04 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH 7/7] arm64: dts: marvell: armada-cp110: Switch to per-port SATA interrupts
Date:   Wed,  7 Oct 2020 17:45:54 +0200
Message-Id: <20201007154554.66650-8-sven.auhagen@voleatech.de>
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
Received: from svensmacbookair.sven.lan (109.193.235.168) by AM0PR04CA0047.eurprd04.prod.outlook.com (2603:10a6:208:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Wed, 7 Oct 2020 15:46:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3018760e-2727-4a5e-e5d8-08d86ad81959
X-MS-TrafficTypeDiagnostic: AM0PR0502MB4018:
X-Microsoft-Antispam-PRVS: <AM0PR0502MB4018B9D3472911756E0AD941EF0A0@AM0PR0502MB4018.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esaMH/YjJkWviT/GcF7yNcmm+xm2Nmul1xF6A2ufjR8RT8RD6wm6hJ6ZDrIHWm19tBRGDxvxl3aCTSIiYgmGlNFTfa1WXW8x2SBlJUROy4twd65y1AA/inR5jpsuYmnGCZnsPt7n7uSpqr8p0TPuz53qdpcKUzDEI6FDzb5wJY1k66ke0r61rahsOU9ITWnDJHd6FQ7fRwE16GFimn/giA0TOJWvOzE1qT/kwopz5D1AtC6rh6TwBfXaS3UQh5VLV+bJ5E1Jiwa8UxGN630LBTKmH0eqt6yZiK9YDrEIHSuHTVbe5nUN5pkxoqMgsIc9ZmHhM4mtkPzvrEOMXb8Uwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(376002)(346002)(366004)(8936002)(956004)(5660300002)(66556008)(83380400001)(478600001)(66946007)(316002)(16526019)(2906002)(6666004)(66476007)(1076003)(4326008)(2616005)(26005)(86362001)(6486002)(36756003)(7416002)(6512007)(9686003)(8676002)(6506007)(186003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6GFO0XovvrfLyMr13wnE0PPqSfxJJBxoHuW/w5dmN6bhBLwY+vqJ4EqvhDHcMxLNuSWwjcOfnxDUrwuYTg1dVarf6qa8nVoLxcEgPV2utF5go1VlsSltDCw8cGD232Xk+1wjhSe8ebZ+jHgjE/AaGAOBp7Wc4dpJ3e2sFpeUQ26ionI6MTC9YrmU5Lop69b/svcbNGonkAvFGhm99tpy7hbdCaVRTEcGcfcFG2xcCIwRG+V62Mhvsl/6VL+JauKuuSpDdGgS6Zx1+7Gldxutu49j+xAnGQ4JViqSZt9q6w5VDzhq63d5ToQ6oo7Bx9LjUD3u1flp7O8Y7Mzd/d1QiP04x3hDieUhteaIFTmEZpdtwFraIeNMC6zJeE4XeFvyWWglfHtTOZGEvmQQVTmRht4LcV5bY9aURJzUre+nNu0T+XqCgQLAUxZ9evR28njb5o6bg7EWrG4MILcyWynN53IXUpdtYB8/6l+9QJdQVCuDkm5BexvWtFCthSf9rvm6Mo2LgbiF6pbGEj1uRk6Z9ZfpulgPushPOG6nmsu2V/cAIEUTWdZ2Pdy2L1DvlOz5mcPYw8gJbEKWPj2A6OqFKDHftVQ18cW/gHNTws2sEdZ4oyhX+vnbLJ1S/9vFtuWXblbB/KnMLh8fnaF0jpDhww==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3018760e-2727-4a5e-e5d8-08d86ad81959
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 15:46:04.5559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PM+2pHr8+/YViTeaHy39g2v34ZtqR9zjTtc1sBRggnY/fax7gLjmQ7SW/xnfDsSbn0E5NKxaFByFlCXFTQlrM7BIQEcjKa4zlDrqSVrnOkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB4018
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Sven Auhagen <sven.auhagen@voleatech.de>

There are two SATA ports per CP110. Each of them has a dedicated
interrupt. Describe the real hardware by adding two SATA ports to the
CP110 SATA node.

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

