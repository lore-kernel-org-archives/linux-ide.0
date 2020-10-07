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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8064C47428
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CAE216C4
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="SMqok/+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgJGPqU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:46:20 -0400
Received: from mail-eopbgr80101.outbound.protection.outlook.com ([40.107.8.101]:61507
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728756AbgJGPqS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Oct 2020 11:46:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFz3hXihA14UTw8ZdKzR9G4vo9PkO9BReN94Ytcm/D+BK+bqQOqPJbBCMrjpSvfozsStYZVconWJN3xtwjN2p2p5REZdSZNR9p/6qAq32VZBmy7K7584OGIdpGFp4GJMooSVK6Eed+MnCiaB9MLy+6kaW1E6ChQBakufuNs24fDxTnlvZHzcg8o0dVCu2Z/T3THcxA6Q4osHo8ceovoLyCzhocLGdtrwxlYs1m/HDJWSEa6wsijzuDzeHsgS7Nf4SW8NH7kX4ml+gqWUSglYlKj5I6PPv2n8bzJK7PZvKC/e9IRnIGe/ufxx31YDNO1cVZdU4BFMkh9zKI5FoSxL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht3SwZF/1kaFhy1E85zrXYO08GkuSItrpVZukCmpmh8=;
 b=fhfHAEhoBorpJFqPiNWPXGXCacmSiqKvcW+BV/YQ1B5qETfi0LKzfPXu+mRXJQvhYwB6XNZBFZze5JIeg1fS8m4shyeiG/5ldWi16L2/zakScXvS9LjwdwN3pmpTzdSq3EjLmsXnpKe9LgeIOhdyWAF0XZPQX0oEXN93zE2Oya3bAgXhdWKFxe5n6UnU6YZ8Tv+5Ls8C0Yz80oYI922XVwcjpsm4SuAt+ykYqo1nDxpa2xp9V/9jdlnmj/9LmeZ2CORiL5X4Fu0HHtikp+tDeDAYO0+vPxBbRWdCbvULm+i7uVhkPmJwKcEoMN4Nn/r8mOixwKyPJQhH8eeXgysTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht3SwZF/1kaFhy1E85zrXYO08GkuSItrpVZukCmpmh8=;
 b=SMqok/+ZHIlUo7bq6s5GOjNQYHt98OZXKDGpZTgnWlTLuWsiq8Na0J6jjzn1qkEXj6PKn+R3B63gLxk5UsD65df68Omqi+tGVUd4K07xmjrX7IDhrGbZtKHcTEf7xjm0H9eLVxE1GTKluD9BDKPkzrCfxm2BmFIjdsfTc11+wvM=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR0502MB4018.eurprd05.prod.outlook.com (2603:10a6:208:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 15:46:02 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 15:46:02 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH 5/7] dt-bindings: ata: Update ahci bindings with possible per-port interrupts
Date:   Wed,  7 Oct 2020 17:45:52 +0200
Message-Id: <20201007154554.66650-6-sven.auhagen@voleatech.de>
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
Received: from svensmacbookair.sven.lan (109.193.235.168) by AM0PR04CA0047.eurprd04.prod.outlook.com (2603:10a6:208:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Wed, 7 Oct 2020 15:46:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cdcf0be-ea50-42dd-732c-08d86ad81829
X-MS-TrafficTypeDiagnostic: AM0PR0502MB4018:
X-Microsoft-Antispam-PRVS: <AM0PR0502MB4018D106CBF8FA13CB3E021EEF0A0@AM0PR0502MB4018.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOsOrBtrNTsm+56iZidVqqw7Vw66GulY8sQq11JyIjvqHveec961AkEaGBOuieRe4cKxpCvUoUx3MEQPXrIb9z2F9OwcvAU6kcj3skEauS/2qUuArQpCneOBxGiJb+9dSIf6lF1aZLIeyGlaRTFmujhZtY+2veQhTt8Fgbz0Kk77O2t9TeTeK3gLCwlB6e1rcRbLfZDsbdUFz47mEykjJ7LKhw6US2ibAWyhGajPaGYK+f3oVmqUGoBJJXOcf6q/byDN9qpWGB/yI2aheWB3qjXPw/gE+gAIHvx39+X0tdgOApdQptw4ATC8q+j1qbsWYZUHM4cPtJPVDvhSY2nyMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(376002)(346002)(366004)(8936002)(956004)(5660300002)(66556008)(83380400001)(478600001)(66946007)(316002)(16526019)(2906002)(6666004)(66476007)(1076003)(4326008)(2616005)(26005)(86362001)(6486002)(36756003)(7416002)(6512007)(9686003)(8676002)(15650500001)(6506007)(186003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zpvAfBnNVYFcnzuxivrRDkhmT3DYk08r0eodYte5oGy2vQKPl1k+Kuj/SHCVqi+ZG2cB5cMOQ/1mtEEPdnGwTSckUBneoempS3XwZR1Jb8YP3fixqf+LbhIjjrlbvlp4m9M6iRFUp/71Xub6kKRCfEi9XhuAecIng5NjYgr7kOfum2m1/TL5cRWQzFoHGZYCwgsOjhk+GARmBB/ZOkbR2aYWU4giQQflhTsFTylgofUYGLrR/SNfCsoKoYAvq0B2YbtzpJCYWvUvcSqeXFzIcqQUKJmfyTIMM3uz2wc/JcTnqNpkNMrMwiD7+/ZTQZ0cFHA25CXLv0lVEicU99xmuRZSPpxraEnY889td8nRAfK6RLiF93qOzUd7Kx9cuCPkO/8qSsCJdc75wodskWXko3+l9wY88ZuE9tLQjj0OsSbvKkIkUBg6YQnUb4TzxMXHJnXpVf5yeglK7BS2rmM9MuGc9mwbgaePn7KdHXbQdZDCbGT8W7Wvapm+Mb4jkmUIjnGqHftC1ePJgF1+Ia6jlmXTK/LzwUgpCDyIyZNYSs7Lx1IHO9kxf+piHZ/36O4CS/RfGMiED92OSUo4QpEhfGMG8+gVb20Vm9ZUKM9kqkLjjvVRLA0y3i/Ti0UrAz/ple2h13TDye+nXapD9euiOw==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdcf0be-ea50-42dd-732c-08d86ad81829
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 15:46:02.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsoHfRkCc+xe/p4Wojng8bHCVax8IRPVkrADs77dIlGgfF+QF04zqcY/1ui+d+LFRircOzIwD4bl1evtUhQwsm9pPFVlToKVJ30tymWEVvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB4018
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
2.20.1

