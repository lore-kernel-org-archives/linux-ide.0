Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605B3C388F7
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137A5221F7
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="iwJxkmjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbgKIRkM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:40:12 -0500
Received: from mail-db8eur05on2090.outbound.protection.outlook.com ([40.107.20.90]:23136
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732040AbgKIRkL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 9 Nov 2020 12:40:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9CVrLY3SRXJcnTJhJ/EZjiPI2zQXu4jHUyo7ODJvJ2DZexh+IwlIz2ji+75uHqeoF5Aem7rutjQ4JCGGztDE+ioignIHuV9SQcQy6xlUPza8tOuEbfDNafQ3bDAhCqAy0hia7F3NZKoCTbG/5NgXPhjKTCbm2nOXY1gWsc7BnwXvaFMrBn68Sy4KWyhC8YJz1jL7fYoL+kx9+k+rNkUqU0AUJu5sn5NVqfn6zs4vjV/yWYM6fBSKxFRN2b9DOJkenaj2I3RxS4+uPyYisnKAO2dW9lTlahaxsTHy1RQacvdvUlKYzYD2mQWRsawFC+IOeevFnxLFDEPg9IEPrrQcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6owgh1Jmkf4KJRh5HqXTdxRQXgqy2bKyEbNmGmbSlg=;
 b=jAjejhuI2beNbfOc9DvujKcGjWCzltj6FcKtLbgAN5XwTGXIUXZJt0Ijw/EI0EQT8bW+4GPX+Ao42z1YyJ6teTDgC1aRkkwCfzN2w833CFwYeOZDUbVrSgqxBPwx6yjTskFrK+Pej7BaF2yr5SHUvo+66FuJNWPbQQaHUew8WNh9/vCTooDnxxnj5dxR26r6Pg7NP5m88+KalYTRtqqb+9+wHioYFqezuG1u9mBoSfKRsfWGrcueux2n1UdQS+lvRD8AK8CfR9u7Vd0GYb8Y8hOKt3R0tYdh3LAswulOdbxU9HNPaPPfQhEU1gges1NcC+leBf3hEbCKMJcamepb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6owgh1Jmkf4KJRh5HqXTdxRQXgqy2bKyEbNmGmbSlg=;
 b=iwJxkmjosEA+RFc/4+ZVPKKo09e1KV3ibhfWcqBuirF0FzboFL/SjDamdHvE0UwTfykCPAlBRBkdbuyC/qiRsQyaB2B5YQkCUMDGjF7MCVRhYiY8jfdMXjNXEUieLHWDOv2Yd3dMYPUOLSiAC+O+wn+F+QtVpvtTB3TUJ133t9c=
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
Subject: [PATCH v3 7/9] dt-bindings: ata: Update ahci bindings with possible per-port interrupts
Date:   Mon,  9 Nov 2020 18:39:46 +0100
Message-Id: <20201109173948.96663-8-sven.auhagen@voleatech.de>
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
Received: from localhost.localdomain (109.193.235.168) by AM0PR04CA0135.eurprd04.prod.outlook.com (2603:10a6:208:55::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 17:39:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 156959d8-f131-4ae9-a9a7-08d884d6796d
X-MS-TrafficTypeDiagnostic: AM0PR05MB5362:
X-Microsoft-Antispam-PRVS: <AM0PR05MB53626B80A94583539AC3AB61EFEA0@AM0PR05MB5362.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCpHVG5WyYwSDu9w+IxuJZ4Izh9lJ4qAn0tyCTmGobKQ+9M9gfcZPhTkdQuQkqJG1IAmLUR4fHnPlutRZYKkZuRBPA5Rhn9cDpIwZ2BKAgmOMxM4ysFJj7UvGdHTUemoDwRHZMq4MFKEIkqYrlrdtcVTvDr8sonozVIIcO7V33f1opEYvPF67ZLCwEeaT3yY3dO/wAifV88W+awusVqGRn+1yysGQBKIo+B0LeLb2fEY2jNkopc+77BUEb44o3kyk7zZdD+cw5g8ZwJcFnIdKBbuX65vtwS5iOVDLb7PcNMS6AyoGBl610CKpCkF/O05GEkdbXtNBL6b5Wsjrp3xM1kT6egdJS7KSN5TfVjthILAgy6Z2uX80/kT3K43wkoR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39840400004)(15650500001)(52116002)(69590400008)(66946007)(5660300002)(1076003)(66476007)(66556008)(26005)(2906002)(478600001)(316002)(9686003)(6506007)(6512007)(86362001)(6666004)(16526019)(8936002)(956004)(4326008)(36756003)(7416002)(186003)(83380400001)(2616005)(8676002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rvv1SYHsA5yNSwBcBqB/bufY0K5Wmzac7VGaEDaN8olwxWz4TbHNuXPBr7qbTOPXJkvwlbyHQYW6wSWryBiB3HrBTG5UgUkLQDg5mNvLMhJlPCTKKJF3q3AlchmQWYqFdP3eUu5kj15g6Ulg5kH5Q491jXihloGMB3gr386bYgZNmFhNMdn+y/3k6LT8cB9OiLE+G4YhcnmPYBT9o8bIGvCoJ+AvZXSaPRwLCfxwJhkfKhp0QZgF9RJ56AB720EynSc11rMRANcdZcRNsLWfguExhpeUvm+QF/sERV6m/ouVOX/xglBdnnQOyB68+0Dc86FPOIuV8VcDerELSg0QpSXQQfwkB2Ny54ydX/Vl0/hvWWSFOnB44aq+e6lyKGBj0zdSx+o7X94nupkt3cy6PFwPTWcECpIrZ+/KefnrZfeHrscjPJFURxkIVDiuFmN8+YEcwhj0CB7cfE4pHMKFIDkBm3UJ+XaCSIiOwWgkEyhUMG8K9L4rib8rRUeKhaGqP61Sbp1s07sUm/zyJhX5pPMgAvlkbQv2cR3bcIBAs4RpXve/on+g33yVpircbQDvXzbywUyVE6q2XOzoegdP855AOE0lM+fFGW7SBsQk16bWvfPfPPXoB8vQLvqJCwsbXVQtEsXHT9+t3JAIDdYt0g==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 156959d8-f131-4ae9-a9a7-08d884d6796d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 17:39:56.9834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipgPbij0xzn0zha2nraKUuVzC3qjBmStQeqJ618m6VRisnG8Y22w6pQlghb178hrkKeC64oEOoRgf94P6Wp/MKxQUopZagCLUn2H58Zzm0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5362
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

