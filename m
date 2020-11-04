Return-Path: <SRS0=Oljn=EK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ADEC55179
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46969204EF
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="j+bghGNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgKDPwt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:52:49 -0500
Received: from mail-eopbgr10117.outbound.protection.outlook.com ([40.107.1.117]:28320
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730939AbgKDPws (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 4 Nov 2020 10:52:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJOHukirbSK3njrPBlMEYYSnLZwqsRRVKqMqp4vVL0zE254B/KyD79/fRhRWzf+kHHZ1tFZHuIZdgu9k1BIOT3th4TVtGG49LdyOMXg4u3rDynBP0tzHnKJDfveGCg0KwbnUh84/CAqtTFyLvC4IspxbQ4cr9A8ZjDYsEGk5y/VzCehhL28cG7U+6uMtLQOBPQlrmwH+uY5qNTAa5dlsPpoDFPr6Ls7FTIAyDNLYwm08Bq8RFyVYYQGNkrCOIIpcfXRWYKQn59nvT3hjMqrYu2lvWxFVmd4qyCkKpMXkiL6YRLpiCAwuBVxquR1drhLuS3/53habzdL/jufezogCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ot9EscGPUlyy2wMyDW+lzmwM3CCokGpFFvcyPsrqVA=;
 b=DOy4aoao8IvjFaaMdQFsG3oHXjmDnct2y6RlwYUM0T4pz4k94Vp7teyrYEDn+cjSqhWCQsaj/bw9HU+8Yz9rcc7NRW+7mjbi/GDjF0PmpCzXcCevioCaWp2QPPwLpAM2AJw7fiyF168Q5I7C/rBf8495slW7Lpak5lmDaacrYe4JM+Lfc4hLLw6QDTed9ST7M0zk2+ePhrkW8mJrtqji89ZWBW7Dpf0Jf6iaBVhiYa0y6xYl7F37FhBgaKMV9JgtvLakaa/cUZp0ZgdlM25EKGKT3R5FI+vxKSXzUgvBkNuZ2/ixiRRtr0ws9UqsEM/Zz1LEFrqFV1OBMhCc9VRcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ot9EscGPUlyy2wMyDW+lzmwM3CCokGpFFvcyPsrqVA=;
 b=j+bghGNeQ6LHuZBKgNQvV8XKNMH2p7TCqTvypLsI+8J6RS/f4/XBzHaEG1qGJtEDdvQZ2gPwbojJZOXdR85NPwTbhImyCtRK0I+qgHEf7jPY8uS6itbUZCMB5hk/FWVcq1BN06nypUEeMW0RomuLo+2tbjvF0xACgnfhegbXwCc=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5075.eurprd05.prod.outlook.com (2603:10a6:208:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 15:52:40 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 15:52:40 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v2 0/9] Armada8k enable per-port SATA interrupts and drop a hack in the IRQ subsystem
Date:   Wed,  4 Nov 2020 16:52:28 +0100
Message-Id: <20201104155237.77772-1-sven.auhagen@voleatech.de>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.193.235.168]
X-ClientProxiedBy: AM8P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::35) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (109.193.235.168) by AM8P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 4 Nov 2020 15:52:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70c81fe3-7732-47d2-aa3e-08d880d9a8f6
X-MS-TrafficTypeDiagnostic: AM0PR05MB5075:
X-Microsoft-Antispam-PRVS: <AM0PR05MB50755D3D82402E73E6C6C8F4EFEF0@AM0PR05MB5075.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CWKpASKF5BgfjHNYTLbd44prYZDOSnKx1HAQO3B6fVCkzq2qjA8HkXfy8so1olmOMJ/ZxcpQ4r14rynWJm5SOQoU4SI9OPmt0eKHz1gIvgFSWureKVTSiT+Sr7YaUtK05KNepqxCB6RC/ssCRFyQjDFDvwibCgifWekrdisGk5HtkZG79/7uiZYEndmrR7YTrRJpDXsm4+7PaV/4IRnDUCnQPz0rHRwNwBckkOAAsmrFAITMdS4I+s/Z+HkCtO/sxezlbzJjvn4f79zULuklfNdSvAjZMgJzhq4Cv0DHc7+uyiH08UqB0tG+9YkEV2+Fvl13tqf51HB2cWgQrYn5RPHnc38uxJluk1p7xwqAmVjmE1YACThYIdNOYYxaJNj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(346002)(376002)(136003)(396003)(366004)(8676002)(956004)(2906002)(52116002)(6666004)(316002)(4326008)(2616005)(5660300002)(8936002)(1076003)(6486002)(66574015)(478600001)(66476007)(66556008)(6512007)(83380400001)(9686003)(66946007)(86362001)(186003)(36756003)(7416002)(16526019)(26005)(6506007)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tgLayRdzXo2dYZ4Gi+rWUloqmvlknUFJqanSuQdP3x57gAOC/lItSLfAWrKqxl+RvBlVNIFgPkAmKXTfAM9G9X8Sv9ufQ9zEbeTgxr0cRWHr6TYodd3CLw7xRo1K9nOx/mvP0qSrfF1cFiCi+xS8F9OwSKmxoH0bjQKZa69uWYkyR84iv76aDDkMSp/TcymqTCFFvLo1rEwaOkZRZZHakEp07CyrDEBodtq7XZWJIAvT+GSIQKv5iEi+PwH3u38Q1GH8M4EB0mkdobZTlIDhXscss9B9LRP2iy8rjE2nmIwV666IcAORaLdJb4bBoTvIJ+iDSy2TEIgR83T8TsM2vEzfpBZMY7lNs+i7IAnymdY5osK8Q1aPcouu6gYiZc6K4ciy/orV60XC92hfTDzkXi82TzJdfQEyqhbxL6y6fVZXHc/mPrnbITvj4/G2hgg2LuhinpeURmrxsiG1DFfRSzV4McEvsgpL0xE88Au9/HT+OX5xM/xW/XFUih/J3Gek1LxnL1epObMac132JD6lSPjpfzVwWFqROnmQncjGAs8evdkWRhtP8ORYkWtXtHOLSd1za52E0A0T5V2WqeLz4YWHZQsHzS/fR1CNBfkV+8vwvO6QRV94bGkhsHOby5nsxbMT0uN6hd92u5ic8rfYpQ==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c81fe3-7732-47d2-aa3e-08d880d9a8f6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 15:52:40.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMmmwTpxz1eAU1iLUgn2FHi356NF0bvDqgCqK8xhtF5qOMYVCCb/JWdVJ6liXYS1cIckjmsr7R1SAOQnW6Kb19BlRZWSftTmi6mnJHbvHBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5075
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Sven Auhagen <sven.auhagen@voleatech.de>

Hello,

There were already 4 versions of this series from Miquèl.
I talked to Miquèl and I fixed up the last comments from v4.
I am looking for feedback if this patch series is now ready to be merged
and what should be further changed.

Here is the original cover letter:

Some time ago, when the initial support for Armada CP110 was
contributed, the SATA core was not able to handle per-port
interrupts. Despite the hardware reality, the device tree only
represents one main interrupt for the two ports. Having both SATA
ports enabled at the same time has been achieved by a hack in the ICU
driver(1) that faked the use of the two interrupts, no matter which
SATA port was in use.

Now that the SATA core is ready to handle more than one interrupt,
this series adds support for it in the libahci_platform code. The
CP110 device tree must be updated to reflect the two SATA ports
available and their respective interrupts. To do not break DT backward
compatibility, the ahci_platform driver now embeds a special quirk
which checks if the DT is valid (only for A8k compatible) and, if
needed, creates the two missing sub-nodes, and assign them the
relevant "reg" and "interrupts" properties, before removing the main
SATA node "interrupts" one.

(1) The ICU is an irqchip aggregating the CP110 (south-bridge)
interrupts into MSIs for the AP806 (north-bridge).

Best
Sven

Change from v1:
  * Add a patch to enable custom irq initialization in 
    plattform init host
  * Add multi_irq_host_ack callback for the msi irq handler
  * Rework the ahci mvebu patch to initiate the irq and use
    the new multi_irq_host_ack to handle the custom irq code.
    Remove the custom irq handler and duplicate code.
  * Fix the armada8k backwards compatibility code
  * Rename AHCI_PLATFORM_A8K_QUIRK to AHCI_PLATFORM_ARMADA8K_QUIRK

Miquel Raynal (5):
  ata: ahci: mvebu: Rename a platform data flag
  ata: ahci: mvebu: Support A8k compatible
  irqchip/irq-mvebu-icu: Remove the double SATA ports interrupt hack
  dt-bindings: ata: Update ahci bindings with possible per-port
    interrupts
  dt-bindings: ata: Update ahci_mvebu bindings

Sven Auhagen (4):
  ata: ahci: custom irq init for host init
  ata: ahci: add ack callback to multi irq handler
  ata: ahci: mvebu: Add support for A8k legacy DT bindings
  arm64: dts: marvell: armada-cp110: Switch to per-port SATA interrupts

 .../devicetree/bindings/ata/ahci-platform.txt |   7 +
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   6 +-
 drivers/ata/ahci.h                            |   2 +
 drivers/ata/ahci_mvebu.c                      | 143 ++++++++++++++++--
 drivers/ata/libahci.c                         |   4 +
 drivers/ata/libahci_platform.c                |  19 ++-
 drivers/irqchip/irq-mvebu-icu.c               |  18 ---
 include/linux/ahci_platform.h                 |   1 +
 8 files changed, 160 insertions(+), 40 deletions(-)

-- 
2.20.1

