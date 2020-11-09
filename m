Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C5EC388F7
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149FA216C4
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="b/CyjaST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbgKIRjz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:39:55 -0500
Received: from mail-db8eur05on2090.outbound.protection.outlook.com ([40.107.20.90]:23136
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730330AbgKIRjz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 9 Nov 2020 12:39:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG4TnV/Sonnbmunww/G57lWsunZ3Gd/9NVj50fUyAx+mzl/9EBeHjRUTS3rP7U88k2B8XGYaQK5PsfgZTZWhY4w44mu8zA+j4Pwsdt/2FHwk4Xu6Lp3zNA3Eber5om6tPjg5x4vww19611z7vgm9Qipoa6ewg02L3byfqpR/YCPAs738Rgsx9IRMRWzVZkxqXDFCkhtFTZ29RVOxs6+E+Ks2eNhNo5UpabdUa/PmXYn3mAN6+aIDnX++iWgFovSHU50z8cxZahCaCQQUvN3ufVP3WSGdUv3n47JpFDah0e8mtZNHoILyZ7XL1o60p+uUefe9Ku5B4KDrGvGq/YcRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VoXS8Ae5uMaF7YdmY4F9ejMbHg0XaCmFz1xRyYDknI=;
 b=YNZyxAEzWrTRGKaCmNnZZof9r2wphPDsddIkPPdgQhN26FVG1FswmvqcSIvY5C1XszAx9rJolWEq87jWcWj5mrO8t+JA5vsP9rTvK+5/XpkPw2JjlmQDMCgyObV86zz1QtUpxPnaRGJDZG6NA3nFdeI/LoAF5G1PXrr4puklq0UwwUCPImMoLOOnTQQwUua5yPghmTB7XDfRuKT0Rr0152FUlxBPL2AxaWNBLONFLzOM0f71G+zwe/e1k7Dzkc2ZhvkeItTfZLAGcCBSfbbtyseb9Zhy89nAHiysYkcD4cEuxvFZCTr1JZ4VH0KPlvRMGUardTH79OoP6Z0QI2Qbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VoXS8Ae5uMaF7YdmY4F9ejMbHg0XaCmFz1xRyYDknI=;
 b=b/CyjaST/q0CJybrRbedOd+u7kKU535NpNpX2IbNtgIJi4/4DDmfAeRSb0MMSi5w8RBvLbcu0ntGiakHpdi7VigC+cxIPZFB/kGN0le6h9bRG5Qy/oRp5RvAEAdI45Rvkq2Xqllm52cRvB/RmZWlkzzslPCh06fPQ67FoB3ajEk=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5362.eurprd05.prod.outlook.com (2603:10a6:208:ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 17:39:51 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 17:39:51 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v3 0/9] Armada8k enable per-port SATA interrupts and drop a hack in the IRQ subsystem
Date:   Mon,  9 Nov 2020 18:39:39 +0100
Message-Id: <20201109173948.96663-1-sven.auhagen@voleatech.de>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.193.235.168]
X-ClientProxiedBy: AM0PR04CA0135.eurprd04.prod.outlook.com
 (2603:10a6:208:55::40) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (109.193.235.168) by AM0PR04CA0135.eurprd04.prod.outlook.com (2603:10a6:208:55::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 17:39:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d357c0a-6302-4ff0-aedc-08d884d675f5
X-MS-TrafficTypeDiagnostic: AM0PR05MB5362:
X-Microsoft-Antispam-PRVS: <AM0PR05MB5362055521638EB8CBBAC18BEFEA0@AM0PR05MB5362.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tEdYQdODy/fuWUNo7Sxn35mBYgkhObeVqZJgr0He+8S7YQV7LzC5JiqjLF0b27EQ886Sg0mrpudbUug8FI8XevjVx4zA9K0aUabgsqP3sF7MQxngwJ4RxOFiK+22a3G7SZkw8D/IxQHHCcHHMIHoenhFOxNeY3hmqLFjjqjCT2MfhAj5WclK7xVcnhLh9AFf61ipP4Mj7JhrGlkSupyJCv8SGOhrWUJVH9k36E/oZKRQMPPwT68EO/PnvlXA3//zMe6fy+h6QY6sjbodlzmYHL2eeKb5yKXe6W7etS7fEeIzHFKmfgjsdMHIRhI2gCLUxCmrvi5ty7qL+cCxqWhRJB94PasbINT/tbdp0CArekoKSUvPW9NA38+oblIped/T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39830400003)(52116002)(66946007)(5660300002)(1076003)(66476007)(66556008)(26005)(2906002)(478600001)(316002)(9686003)(6506007)(66574015)(6512007)(86362001)(6666004)(16526019)(8936002)(956004)(4326008)(36756003)(7416002)(186003)(83380400001)(2616005)(8676002)(6486002)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 0DRvAu29Rkqm7FL62I5hF1PUlotTY9HUb1HvYTeSmOkx0+Zxb8xCAfElsCBV5tiNS42Gn6iYB8wHKotW/+iBEl8Xy56ygCj+EhokFx6wajmVSMHHasOlsWbietN9nT39bjgO3h53Vx14gmOGb9YxXfEMip/olHCid2l4A7Ul5LV1yvmg4kOD7ndL5Zcd9+owNsFWGjoEmO2iCCRnGidIUOgnFVx9BW+Mf+9WLTTIiFBeEBzx2UXmuTeDABMWXiuFeAa+Irla4xMr7JEf3BNRAtenZOnxSqJ9ecF848f6O8SNbkso4olWHV4yKU/iezLHrxSHZ44JFQqqnE5ljVA46/2NNZDrRNDmf80yTinqK4IsYh7eG71hFMhOohwLyqBmHO68xffQDNgS1TJ0Se9tKHghHX6g8UvY26BuAG9160vrLrwcp3lj8UC4aMwOeLZwBb1CnR2bCeCZ719gDjv1ZYjJP2dOsge3OZ06I2bUsJwdcIdDAl2CItHDxgUujfdsjlk89YfmXzVYwf7QPfNOjLHDN5ez2K0EfW41AbHzJINlxy36bachUVT41r0uR+cc6r1Yv6XwoF6R6VWbyn/15Chirh+7Kk8OQHw8iwcoK6vegVITayZBWo+4UY/VDoVkrU2IU1HFknumnaFxw6YbaQ==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d357c0a-6302-4ff0-aedc-08d884d675f5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 17:39:51.0823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqL/A1WpMyQBtZlZjUKDtAkRmCVcHjMFcd6512B4VUTzdJUJZGLEF8l/UOkq1Y9sglOds+we6W1c2914ewa7Hw62LMn4OENYMJ6AafWV1sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5362
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

Change from v2:
  * Fix commit message of custom irq init for host init

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
  ata: libahci_platform: Do not try to get an IRQ when
    AHCI_HFLAG_MULTI_MSI is set
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

