Return-Path: <SRS0=UQRY=A6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9286EC433E7
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 07:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E858207DA
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 07:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="R8RJ+ym6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgGSHAM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Jul 2020 03:00:12 -0400
Received: from mail-eopbgr60138.outbound.protection.outlook.com ([40.107.6.138]:29674
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbgGSHAB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 19 Jul 2020 03:00:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJ7apAz7hT2z9iRQigY1oCLeopmCsrFw+TuVbLndkBAsevt3SiK1nQCd9mL7b88IUiHdQCZTx3vxUTENCw8StjYRkRcC6cj113kXv6lwn3vf7EF/f0jwM2ogkVllaiTEpvbdNBqDSbQokXQQonAEp3fXe2oC5rEFDOTuUxv1ld+fCKMBWa8YSUvtlhQhsjWQhN6HW3bX0MKvWWUupiSYSY4ajb1oQZBe5CGhKSChnXF7e3brSjog/8M7WnGjNCRkCF5QdL+DMp53onZ2/FecaLi990Tm81AxVHe6+g0oqzlOMFbjWVtKK3RbY6aFhA48Y3lDVQts7jKQza7U1oiN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RCUPf418NecbCLQsYeaMtPiy+ox+kdO8hMRCYh+bPk=;
 b=bZ8I5kZj/29ri0TtHp9A0mlpTWirh70Ri3X+ASuCeu0gd6mEbTyomaZDVnYBLg2hDUnK9WWeKwn6eDdMtBMhtq56H+wkwe0/jUtLs6OXG12fZU1VwAb0U4Th5qtY/gFRfBQfLCzjQnuOCrqp6NcSfi7sN10kfxCkb+hcO7EGICooJwBJtkuUlcjyHiui4rh/VdpqoSssOZPDLVwOfda5FnbLfzfH+Hccn/OLYOmoGstBM9H7AWUnJObsz+3brFsgA45pqqADEstAG5MDv9oMNs4rAsQX16mBiVz4o7t3qEGN0gon9l2Pn9p7kZmTlts3sG/NEIEG3YLRHQisM2xx0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RCUPf418NecbCLQsYeaMtPiy+ox+kdO8hMRCYh+bPk=;
 b=R8RJ+ym64IQjpAOammtQ7pOtpLFQRJU7og8He9ElXobzetg3pxKWvU2jXWdcAc+lXh3uVr9UjGoglY3F7wQi8YNHoOGGUrL3OWoHSszyN71dkHd5sQT2Z+kQ7kdnGkbha6UxRXbP9RDzllppYyUrxMlChQVXcAfFVvJms3CNk7I=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=voleatech.de;
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 (2603:10a6:200:5d::11) by AM4PR05MB3396.eurprd05.prod.outlook.com
 (2603:10a6:205:5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Sun, 19 Jul
 2020 06:59:51 +0000
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 ([fe80::39a1:e237:5fef:6f39]) by AM4PR0501MB2785.eurprd05.prod.outlook.com
 ([fe80::39a1:e237:5fef:6f39%11]) with mapi id 15.20.3195.025; Sun, 19 Jul
 2020 06:59:50 +0000
From:   sven.auhagen@voleatech.de
To:     linux-arm-kernel@lists.infradead.org
Cc:     miquel.raynal@bootlin.com, baruch@tkos.co.il,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        nadavh@marvell.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, axboe@kernel.dk, hdegoede@redhat.com,
        tglx@linutronix.de, marc.zyngier@arm.com, linux-ide@vger.kernel.org
Subject: [PATCH v5 7/7] arm64: dts: marvell: armada-cp110: Switch to per-port SATA interrupts
Date:   Sun, 19 Jul 2020 08:59:42 +0200
Message-Id: <20200719065942.24693-8-sven.auhagen@voleatech.de>
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
Received: from SvensMacBookAir.sven.lan (109.193.235.168) by AM0PR01CA0099.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Sun, 19 Jul 2020 06:59:50 +0000
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
X-Originating-IP: [109.193.235.168]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 149c6510-90cc-4594-5607-08d82bb154ef
X-MS-TrafficTypeDiagnostic: AM4PR05MB3396:
X-Microsoft-Antispam-PRVS: <AM4PR05MB339675EAD2C6EA3F0F4CD050EF7A0@AM4PR05MB3396.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hEti287mJXcw3dMQPt2Q1Bh23RytAoL7qWtt+AOXiXpiGO4SSQyWpHlmHhQ/2BLwj/s4IS9bNuEVdBMVfeMIyJa5fFbtdR5wY/AhqUrPzbpZPvgO2NbUHQn+l51gWjTFe7pG6ulsWwgb23Pb5Uezbnxx6wp4NAsYPdLgmf4uI+wgNbjcQewT5dfodWCdH2cCSamGs+rMxe0RnJ19Jg0r1axU7NTK5OSiUOQFazUkQ32ALW/g8/GR17R2Yq6ZX02ffAZFREPC8z+uqOLrs443FUvuU7nnbgvw80FUq01YOPQE6O2XJt8/OQU6+Hp8oGaAHnsIEP6lgVjYuOD5AhrNyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0501MB2785.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39840400004)(366004)(346002)(376002)(396003)(136003)(36756003)(316002)(5660300002)(2906002)(6666004)(6486002)(7416002)(66556008)(508600001)(6916009)(83380400001)(8676002)(66476007)(8936002)(6506007)(956004)(1076003)(4326008)(2616005)(26005)(16526019)(86362001)(9686003)(6512007)(186003)(66946007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: id0F0XFxvqhMU0wpQQrLOsLDQKzKtNRmE9TQ7stG4DsCkxqrczDCYXVT9hgWB25aryqegAI5FUQKrQ4CCPc8CPMUByxQv+vmGCebewE6KdZEBEgL6auW+g5AuaOZKvsebzinZt9rZQd4uARic+dnM3NYqsJ8nqfU9viv02PYTvyV02/5A9uHJTmaGDw/z3SZFcnUBAAr3l0MPUEh9N+xT9j/Cql4k+a1zLMf8LBSHpoNymV0OluH8ALw3GdOmpatuCszm0IjMCtOuQ9hwtf4D0A635cZND4H9O0mV3RCRIJd0Mv4Uh4PwQOd8jlSJKuVYchGVmnoI+x+c4RaKSCSgMs6UbBFaw9evmStimGGY8S8zR/N3GugTpaae9bxH+oBLqHXCBX/ydMEDzVnFUP4BQblDvVXAE+NqmlXF6FQKdpXdF1ef2kiKmJgatf2vi/V7lzqc3Qb5NV58qO9lkGhfuaRnLBHpzGiX/1vWgyQ61wSGdfzERt8SaZfZPGDh2k/
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 149c6510-90cc-4594-5607-08d82bb154ef
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0501MB2785.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2020 06:59:50.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpPJg6hCM0Ar9Lpdz76adz3jgsQJFG/BtI2vnLB2LbfUAkJGl1+NfmTPWuduPxefIQCAyWQgsJhNYKherIeOu6nklIojsaUEUt73Ay7pX60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3396
Sender: linux-ide-owner@vger.kernel.org
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
@@ -300,11 +300,9 @@ CP11X_LABEL(usb3_1): usb3@510000 {
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
@@ -312,10 +310,12 @@ CP11X_LABEL(sata0): sata@540000 {
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
2.24.3 (Apple Git-128)

