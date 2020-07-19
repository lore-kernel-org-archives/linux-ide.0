Return-Path: <SRS0=UQRY=A6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C1CC433E4
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 06:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DF22073A
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 06:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="H/zHJQKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgGSG75 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Jul 2020 02:59:57 -0400
Received: from mail-eopbgr60138.outbound.protection.outlook.com ([40.107.6.138]:29674
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbgGSG74 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 19 Jul 2020 02:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dljspi5wyOjspkvmolR9mfTKA0jNAXQ2AsL/0tld68bJb/2D9f0/r7ZbfLepDPlxwvT2KBch5YZ+87Qy3x7x7m6qNt24deSRLtw6YtZpP7CYDQLaVB5DFF3D1rBt1YoUDbq8MBJev26IOSVyH3oVHgDE56eWLoZ4fpPKE8v7cOuhjJKo3yUHLs4PAs/ArunWtRDQgLlix8g3EulaLNUUe2CnEQteiTrGYue6YGgXhFL78y6z5kGoHMX9TqY4DuaRoypPccwau2/fUaFyVnja/+T1/bkOArSnPbOS2FffIZASCVzg8FTBZ8GibWX7DGtYnovu4C+Tw4MSi/GXTj5VLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGQwZ6WvpTr5qSvW+tXuIm1L5RQLeAew0OCO/xPoW0Q=;
 b=Uny6VdsA0hqlvNtSrikHqFO3xioomWwePXC7ZcpMFOOtp47M4Uyt7m154IpIL/atKr311L8qLECGVqn1sNA3tP8ca4hS29JeER1a2qs0x7iH31BoN8Q7CvAWwo7jfI5j0iqrmdABVbDsTWoTlYFDzyV/ovW4wUDqsRHRBPKbD8jpIJ+Tb2A+i6H+ntwsjTnLGQfLhRdXJU1Mgt5/d4xI8OkSoxnqW/Ism/SEkkiRmww8V5xH23eJC7p4F8Ht4NDOMCfS02BbLbfMqxSv2EaaZPuhrUB8fZVy0IQ7BIhuKeafqWX5sakRmfB8B0lO2r8gm2sBRSQhe3P0FciyeWpqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGQwZ6WvpTr5qSvW+tXuIm1L5RQLeAew0OCO/xPoW0Q=;
 b=H/zHJQKkG1GIZqyRf01tZF5RNrwH/2kIrUePS0lzBYCW964Zp947zgR5zYGeRHM0OaTtoaPfZqD6sVJPRvJd56O/7n+bjWZ2/Q7E5GeaBy2D4lGwuE6Y1CVT9u4l8dRoB3Z6nPPIQLzlgacyciM/NaL4I4aMSEAgyz8lAOrjXso=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=voleatech.de;
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 (2603:10a6:200:5d::11) by AM4PR05MB3396.eurprd05.prod.outlook.com
 (2603:10a6:205:5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Sun, 19 Jul
 2020 06:59:49 +0000
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 ([fe80::39a1:e237:5fef:6f39]) by AM4PR0501MB2785.eurprd05.prod.outlook.com
 ([fe80::39a1:e237:5fef:6f39%11]) with mapi id 15.20.3195.025; Sun, 19 Jul
 2020 06:59:49 +0000
From:   sven.auhagen@voleatech.de
To:     linux-arm-kernel@lists.infradead.org
Cc:     miquel.raynal@bootlin.com, baruch@tkos.co.il,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        nadavh@marvell.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, axboe@kernel.dk, hdegoede@redhat.com,
        tglx@linutronix.de, marc.zyngier@arm.com, linux-ide@vger.kernel.org
Subject: [PATCH v5 5/7] dt-bindings: ata: Update ahci bindings with possible per-port interrupts
Date:   Sun, 19 Jul 2020 08:59:40 +0200
Message-Id: <20200719065942.24693-6-sven.auhagen@voleatech.de>
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
Received: from SvensMacBookAir.sven.lan (109.193.235.168) by AM0PR01CA0099.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Sun, 19 Jul 2020 06:59:48 +0000
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
X-Originating-IP: [109.193.235.168]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e64294b6-b93a-4b83-e673-08d82bb153e4
X-MS-TrafficTypeDiagnostic: AM4PR05MB3396:
X-Microsoft-Antispam-PRVS: <AM4PR05MB3396B2DCF63B05E841039DD1EF7A0@AM4PR05MB3396.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/70upInJ4tWZToMt9OjR0o0nQZr1v3uShERh5AjLoThGb3c+k0Pa42bM7Bo6S7poSaTo4bxETgME3tBQd8J1Jc01r1id9nvI3dOrPwdJaJGp/y9yaAtg+SF0luYj3DRMpefUZex28zHcTYB8IM44Frhkm3oh2mrlMCd9IAOCURBU+wSry9fKR2bgM/XAANtEJkj1fknh3afS8VXvP/ftkoaTOL2qAspnRAJrVjubyMAQyhPMAzisfGkkA2ShrCjWiXiIyI1w/WMMSgy+uxFaHIZLV/EgVdwbOj6nQJSxmtIh3IkVT1ESzncIAqWNoA9QtaG4ijA7Hce13TOEXXstSTlRBb8gt6s1Bk8R04SJh+nX5wxUxgHdD5+ZwAWetJh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0501MB2785.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39840400004)(366004)(346002)(376002)(396003)(136003)(36756003)(316002)(5660300002)(2906002)(6666004)(6486002)(7416002)(66556008)(508600001)(6916009)(83380400001)(15650500001)(8676002)(66476007)(8936002)(6506007)(956004)(1076003)(4326008)(2616005)(26005)(16526019)(86362001)(9686003)(6512007)(186003)(66946007)(52116002)(46800400005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 9Rzdo73YMCjIK2IB4/WK3H/2eqdPVWhvHhF2mjPtJbfiYhH8Qr3dwE3mfdy4IBq/eSeT97HvOCRGApcnSd/uzCLLS5lFsNVHYPX097y7Tps6wVdbt9H/6Jyl4j7H1qmS2bRbXH9rzthdrcdxaKhT04vrUurxKrqXcOQageiizUCmHGxoRctYrtCHMHWd++WJNNIyVwi/MhTN0XEbHYs7bC2QspSPaVVDgNUCpCIPlgxQ2REcRN4amFTBzBxi07/7231VqByf40DtOLmC4JOQPjV+/dN3A9w4+LoYSEnWiC3Va/SPT0ULBkmEsnb7nRB2qlYPLY+DsP81kDCc4PghmPUrH2rwFXpfmQzrAVKsZE/9MCjdqY/TQ4rX4P168+7G3rrAK35zZ0jtXho/j7ZmeqbEZL8SKUFS3RA01SS96y+mi2BXQ1LOkvTqNjAoeQAuwaWcpoq8PyeKeUCnaKLKiFabdYEN2QLikRMCf9nbgJeKYr9eg7PnuSlYu0MZAJQd
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e64294b6-b93a-4b83-e673-08d82bb153e4
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0501MB2785.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2020 06:59:49.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37lJefJAxeHkMvPZeBIvk3xEuxHNQVQlF13iunqlo/eYCHK4RcMd7Jqr1A9jlmvz8PwaLD7ZZpFWkJDpg5TaOu/hkT2qwVpNXtrwr4zOYok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3396
Sender: linux-ide-owner@vger.kernel.org
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

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.24.3 (Apple Git-128)

