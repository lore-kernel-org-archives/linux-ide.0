Return-Path: <SRS0=UQRY=A6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80038C433E6
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 06:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC7E2073A
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 06:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="Y10QCkdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgGSG77 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Jul 2020 02:59:59 -0400
Received: from mail-eopbgr60138.outbound.protection.outlook.com ([40.107.6.138]:29674
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgGSG76 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 19 Jul 2020 02:59:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5zNwvq4ElwnVDpZl4NzHyTwWnYCn0IynsE164M4WvBz8pFhBOwHSMVOpukJNJU12cIyWHZ0gLojOKH0JiKwCri+anLSdvdB/4GC8HBCWnfP+jF3S/gRoROFFme88v2aLlgHGQFMIA+vYguqkFS45FVLkECU7Sl6XMRkoO3j26nryz97E6KXEkrqB32F3mipaFg1c5JJiMRr6VuahByabrAZF4mmrQZVqFxZGDw68UVL0u0PgG7bA5vJz5S6PuHvVue7zOybfSbHh/ptcSzTUDxpxEVECUu/LspDTSO3hcveesOuiRi8CvcqVXypnYKviRL2sjFrpqZUM2biSeK0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9uVZJRsZoOmIdSRf9o96KbG1ZzdFolaCXF5yILt1ZA=;
 b=VzXYl6OV+dll6viMUnldvAEmPXZ1xM4emcZAJtR1HyzrSlR8ea6lPFr+cPNCHyTv20yynXTO6cUBK9uSsMCtLtQTGOzG590hhktxEqXu0mvipjeBXoBDr/qQdHxtrE0C+L+uouIrIe5Un1jJxDhU1icZDf0OsJl/isUZb5HxJXq5aGIrAw1hCgUytK4J1VXartBMhgQQFTDGeJB5H2cNMBjTk7Pc4omKPcvQDCwOfs0v16LSnCt3xK+K8gFpl9tR1GJLg4qmOkAetJO2N0l1x9guZOMuKcozSI4f/TBlOCu0E3uqF6RXYOCzWsN6031KvNU1qSKdkO3+UwqU2qeHww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9uVZJRsZoOmIdSRf9o96KbG1ZzdFolaCXF5yILt1ZA=;
 b=Y10QCkdWjFoKvHlUMi2PJu91V4AlJUzTEa7zTG7PlByULMVWOYr+MVCR+fae4Fubn8dejajG0CHfkiyhdqTIsL/8Yatl7L/N1gFnYpmPwIORog0RuFAmS1rHX0ztOwYGfvAGL1TJMEu2Qw1/UWWGIFCBOXct1lDs+I+9Jo83/+o=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=voleatech.de;
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 (2603:10a6:200:5d::11) by AM4PR05MB3396.eurprd05.prod.outlook.com
 (2603:10a6:205:5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Sun, 19 Jul
 2020 06:59:50 +0000
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
Subject: [PATCH v5 6/7] dt-bindings: ata: Update ahci_mvebu bindings
Date:   Sun, 19 Jul 2020 08:59:41 +0200
Message-Id: <20200719065942.24693-7-sven.auhagen@voleatech.de>
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
Received: from SvensMacBookAir.sven.lan (109.193.235.168) by AM0PR01CA0099.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Sun, 19 Jul 2020 06:59:49 +0000
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
X-Originating-IP: [109.193.235.168]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 847f1b99-b40e-45a5-fdda-08d82bb15466
X-MS-TrafficTypeDiagnostic: AM4PR05MB3396:
X-Microsoft-Antispam-PRVS: <AM4PR05MB33965B1A7F453EE2D60BBE57EF7A0@AM4PR05MB3396.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GmzCWk/417Gs/6LxyXuNW8c0dieGssG8AA9r24HE6cY4acxRtwX1XeCRhyivc5H+jeTsvXcfTuVia70EQULPkzYzsEtmznChBeLNazJoeR00jqFl34RyhusELA62b+Qf0E6nUpjdnY8BeMliJF03Le9FDjIVekuhSn2Tk/yTD7QL6OvYMe1dXYIhkne6LaD3j5FyB1Un9/HdFCd7bAw3Ugske5YEgFBY9Gt67eEzbdDDcQzmnL1TXVbb01Glk8cWRAidXf1eXLCk9ayaMcBlM3LrxFo+nsK0ApCAYBtrBMJM4C+UXF/TA8rQpajzMYeqadHVlM8Jk1xVcqrdsoZ7+CT2aMCgXFM2t8cV0HuKFJ4TO4UzMA8J3K464vaM3IK/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0501MB2785.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39840400004)(366004)(346002)(376002)(396003)(136003)(36756003)(316002)(5660300002)(2906002)(6666004)(6486002)(7416002)(66556008)(508600001)(6916009)(83380400001)(15650500001)(8676002)(66476007)(4744005)(8936002)(6506007)(956004)(1076003)(4326008)(2616005)(26005)(16526019)(86362001)(9686003)(6512007)(186003)(66946007)(52116002)(46800400005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: p/y9vG17fKw+WmlpvfNZOmAjJqWKIJc2LxlEjcJ5LGBSfQBUuwcaxxKdUIqm4aVdCIy9VLTy+GSn0t3onOVzTRWe79EuuzVGaH/JDu3wlMITXg2aQjoL52LlnaWT7r0U28UEhG424H7d3zmbMcRTHxAetlXLb5gNxgmahEqifdWyB28i7I4QA4/ZEmMB1GfcRTmioOHmcmupzYnJvg3kA+049GUAHVAWUUSNDYa4mQ3BNWkXN4BId01RPFMr19xchos4qtAPs3IjGEFls7ZXQCeZaZSSUCt9CeW58x2Fdd6BprXQvjEAKv9N/M6oh0vH35qyqFoFRG+weWU8zt96kL/5hubtKlfDYkmFqaMFOReGLrt4fdysCWZsB3tBa2+WPIxdygFYnN5omvsNoXHNz6jTRT3F9sBSnNtUskTt80FvpiEW+tmNNNHtcRTGiDkBsSeDHu2/U5dv2juRDqDjMWHnuYw22fLkTp0BGVrocouB7jialZlES2qfWrPUwGMs
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 847f1b99-b40e-45a5-fdda-08d82bb15466
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0501MB2785.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2020 06:59:49.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VSGtyC/7YnQ7+KK5lciuWz2WAKJ/iMk17a3RPKIriNZqCbv/lV+VSVzXs4JFivgLXqooeiFNA/O5owWBms20G5MBnth8qGcaKcNWR8EYio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3396
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Update bindings with the already in use Armada 8k compatible.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.24.3 (Apple Git-128)

