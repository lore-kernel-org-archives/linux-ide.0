Return-Path: <SRS0=HpzG=CG=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B104EC433E2
	for <linux-ide@archiver.kernel.org>; Fri, 28 Aug 2020 16:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C68D20737
	for <linux-ide@archiver.kernel.org>; Fri, 28 Aug 2020 16:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="OXM2N5qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgH1QQx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:16:53 -0400
Received: from mail-vi1eur05on2114.outbound.protection.outlook.com ([40.107.21.114]:59336
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbgH1QQu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 28 Aug 2020 12:16:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvWEVZwx+zS8kT/P6zT+tlGV7OQ+6vjHbNs9sATLx2dl0+wJ7fYVReXTDluOd2PKpp6Grznho38R3/gCrbcN4pltBqTsoI6nr4Cvkl7kQZgqhyBLIGcC5kQe4iJHzJphT2aurhsIMiluQwbjWH2gm7xRyb7sbGfCCdLi6/ywtr4lmhmBT2AE1jPRT728dNK2zYRaWLHEi9ZBssqrsuHYqqg26crS6Bfw2jWnjSAdkThQIfRreNRqLKD+wxT7vnl6oBhUHIkdoL0l4MYgc17WYwPVc9AMn9/cN8Hn378JYe16CgNFaH9JrInKHE9qqT/cqBImsg+JF+bLASebwEz8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbh9J22hGSc5HmiQ+67CQx0Ku6XmL6sEntyGoF43ry0=;
 b=F1wLkzoGXhsOyLltRgRf6fUy7y+Hu5NaB1VB+vit//3v7Fp4Lj3XRRBOwUVb9ZKg+/JDgoNQz1AUi2215fMw19B9EH6k4libfhYma3e/2YMUVrFmiEbVc/Rr+IsWqpgRWg5snv2eKm6mBhggaYKJ8mssrWPzbzfh/d9bA3MfQ4YY+nA2jmep/FLEowRVBz/OQqg8TnRyKeMgWWXp3iJ0AD4p5w3mf06aT1EQ/9D5UsCMkvaJVPyWyOQmyEpRHONwtLTNSBBRWq3nHAp9PVll9N2BCNbCL2nyToSgm3Ft7iGpMOYekuQnmKO5ouV+7lr2h5+G37v6+tOKLk3j/Nv15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbh9J22hGSc5HmiQ+67CQx0Ku6XmL6sEntyGoF43ry0=;
 b=OXM2N5qsZk2iGmitM5nMQHqDz5Wounu/Lc0/s1eE+3ynvkXW6jzFBe1I9Nmj16G36GRNskVWypUXIfHGZfvTQfNha6G/+mX2nNt9htfWOqO89Zy2oH3l/ngc52PuisSqYmcIdjm03evZkQT35W9G3hIsdPCa1LyRMPviAXacck4=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB4770.eurprd05.prod.outlook.com (2603:10a6:208:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 28 Aug
 2020 16:16:46 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::94b8:d700:da06:a7c]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::94b8:d700:da06:a7c%4]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 16:16:46 +0000
Date:   Fri, 28 Aug 2020 18:16:44 +0200
From:   Sven Auhagen <sven.auhagen@voleatech.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     miquel.raynal@bootlin.com, baruch@tkos.co.il,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        nadavh@marvell.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, axboe@kernel.dk, hdegoede@redhat.com,
        tglx@linutronix.de, marc.zyngier@arm.com, linux-ide@vger.kernel.org
Subject: Re: [PATCH v5 0/7] Armada8k enable per-port SATA interrupts and drop
 a hack in the IRQ subsystem
Message-ID: <20200828161644.lzfo7s225qbliodh@svensmacbookair.sven.lan>
References: <20200719065942.24693-1-sven.auhagen@voleatech.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200719065942.24693-1-sven.auhagen@voleatech.de>
X-ClientProxiedBy: AM0PR04CA0019.eurprd04.prod.outlook.com
 (2603:10a6:208:122::32) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from svensmacbookair.sven.lan (109.193.235.168) by AM0PR04CA0019.eurprd04.prod.outlook.com (2603:10a6:208:122::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 16:16:44 +0000
X-Originating-IP: [109.193.235.168]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b92e018-1733-4833-40cf-08d84b6dc236
X-MS-TrafficTypeDiagnostic: AM0PR05MB4770:
X-Microsoft-Antispam-PRVS: <AM0PR05MB47705666369F1866EFB762FEEF520@AM0PR05MB4770.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+ORauk/JbJNHVB2/Hz2wMEizmbDSmFKRwESewmVGIx4SaS7APbSBzSA8OqZizIWW2ZU0kII8WMIKF9eAkefSpE2PdLamWaF5VmjB7nlBzja++ZAklEtxoVKo2D/EvtcojL7ikOn3F8PiD5Y2qapwjEadVl0OkdAaPd1E0w7RLkD6Ieay7iYurT3Nfe3GTcprJnl1fCnpi1AZOSBpEnplsWtcdHaHKl28+ZeLvW1fqgmR6pnjf+qzd4Bwze/s9oXbGRyseqQOSgM9dV380aodj79O9x9AinrKNkDMXXofBhOdQ8e+mvxptnv2vR0gKioHWJ15lpY/YIAhhnetfXeosk4KwbsyRH7WqeCIdprRlSI7vJ6IegPdN3bBnWi7zPW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39830400003)(366004)(136003)(346002)(6916009)(4326008)(8936002)(6506007)(9686003)(55016002)(83380400001)(66574015)(316002)(52116002)(8676002)(7416002)(7696005)(16526019)(186003)(956004)(478600001)(2906002)(66556008)(86362001)(66946007)(66476007)(44832011)(26005)(1076003)(5660300002)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 41AGTBlxSi1/4cUHuI90BL6fKKrEGGIgPj9aqsYhxs40dOodo/sIiUs/zrPpQtvOLPC2BgkooDt0AiEWYU5NIaWE7Ha5DyfSayrhuvRxvaTXudrSg/QR92dzAOeUZM/YxYSylDY9aWMTkRBu9ikQC1rxkKEMUf5WrOwtmj5qNOycLMlf0OIjE9kIf/jaw1KHWR7pC8XW61DseVKuHK3xUi2Ms/Z7RJDotk6240tpoJlplsv80j2q3SpJxb5A5reK/8M8fl75phoudsPrnXQLwtedkGQ75l1lYh6k8XAYPufYcKBg3htN2FKYcOgrEyj6LbVa70NHR0G9XhiWGR+kwRaWca2bsGqAMkp7O5HFBjEOohXxzzmDLKTir0/m9sV1Bm7h0LnioptZvvWZJxN2N8hCwWzWjkmWeYosJD9XihUfOPT+jo9ZMw+ZtcHKdViJUWR7QYM6cIBy4jiFFjDpKq8A5bCBrd50ejpBUH8NfK0ZIxQ8kcX9YlImQqdpOlC4RxcueOVB5hFynTSv4eWkOhWE3hqVL3k1MOwbQKMD+Yu+vCTPz2vHTIevANM1YxaTJ14yrcDBpx2696aMluo6MY31Zsf8FVbIE8BbCJ2yKyPcmS9bv5KRAQ5uuu5aSGKNOHaHKSdE2VujKpk7ePxVbA==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b92e018-1733-4833-40cf-08d84b6dc236
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 16:16:46.0225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qerIiCRGWSQMntutaV28cxAQX21hleXsOp/FE9NOjiuaeoABD6ETu4GwK+XBVol41m6xhxU50Docb7zhEh1bu86zKj8a2UOm1BbXS8HY3cI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4770
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

does anyone have any feedback on this?
It has been over a month since I submitted this patch series.

Best
Sven

On Sun, Jul 19, 2020 at 08:59:35AM +0200, sven.auhagen@voleatech.de wrote:
> From: Sven Auhagen <sven.auhagen@voleatech.de>
> 
> Hello,
> 
> there were already 4 versions of this series from Miquèl.
> I talked to Miquèl and I fixed up the last comments from v4.
> I am looking for feedback if this patch series is now ready to be merged
> and what should be further changed.
> 
> Here is the original cover letter:
> 
> Some time ago, when the initial support for Armada CP110 was
> contributed, the SATA core was not able to handle per-port
> interrupts. Despite the hardware reality, the device tree only
> represents one main interrupt for the two ports. Having both SATA
> ports enabled at the same time has been achieved by a hack in the ICU
> driver(1) that faked the use of the two interrupts, no matter which
> SATA port was in use.
> 
> Now that the SATA core is ready to handle more than one interrupt,
> this series adds support for it in the libahci_platform code. The
> CP110 device tree must be updated to reflect the two SATA ports
> available and their respective interrupts. To do not break DT backward
> compatibility, the ahci_platform driver now embeds a special quirk
> which checks if the DT is valid (only for A8k compatible) and, if
> needed, creates the two missing sub-nodes, and assign them the
> relevant "reg" and "interrupts" properties, before removing the main
> SATA node "interrupts" one.
> 
> (1) The ICU is an irqchip aggregating the CP110 (south-bridge)
> interrupts into MSIs for the AP806 (north-bridge).
> 
> Best
> Sven
> 
> Changes in v5
> =============
> * Rebase on top of v5.8-rc3
> * Move code to ahci mvebu and use custom functions
> 
> Changes in v4
> =============
> * Rebase on top of v5.2-rc1
> * s/ARM64/arm64/ in the DT change commit title.
> 
> Changes in v3
> =============
> * Removed useless locking when acking the SATA host IRQ_STAT bit.
> * As spotted by Hans, do not enable the AHCI_HFLAG_MULTI_MSI flag only
>   if more than one port is enabled, DTs might declare only one
>   interrupt and have multiple ports. Added Hans' Reviewed-by tag.
> * Added Rob's Reviewed-by tags.
> * Added explicit references to the 'Device Tree' being the culprit
>   for the hacks which are being treated in patch "ata: ahci: mvebu:
>   Add support for A8k legacy bindings" as suggested by Marc.
> * Modified all DTs to avoid enabling/disabling the SATA ports
>   independently, which does not work. Either both ports are enabled, or
>   none. Tested on MacchiatoBin that all three availabe ports on the
>   board are functional.
> 
> Changes in v2
> =============
> * In the AHCI world, the 'irq' is now an '*irqs' array, I ensured it
>   is allocated even when not using *_platform drivers.
> * Moved the whole logic from the generic ahci_platform.c driver to the
>   Marvell's ahci_mvebu.c driver.
> * Dropped the whole DT manipulation quirk.
> * Instead used a hack to configure both interrupts when using the
>   deprecated bindings, this hack is a8k specific but there is a flag
>   that is passed to the core during the ahci_platform_get_resources()
>   to indicate that the number of ports must be forced to 2 no matter
>   the number of child nodes.
> * The A8k based Clearfog-GT actually uses the SATA IP (Baruch's info)
>   so do not remove the SATA node from the DT. Instead, change the DTS
>   to fit the new bindings (the board only uses the second port at
>   offset 1).
> * Added bindings documentation about the A8k AHCI compatible (existing
>   in DTs, missing in the doc).
> * SATA Sub-nodes representing ports already are documented, I just
>   added a mention that they can also have an interrupts property which
>   is mutually exclusive with the root SATA node.
> 
> Miquel Raynal (5):
>   ata: ahci: mvebu: Rename a platform data flag
>   ata: ahci: mvebu: Support A8k compatible
>   irqchip/irq-mvebu-icu: Remove the double SATA ports interrupt hack
>   dt-bindings: ata: Update ahci bindings with possible per-port
>     interrupts
>   dt-bindings: ata: Update ahci_mvebu bindings
> 
> Sven Auhagen (2):
>   ata: ahci: mvebu: Add support for A8k legacy DT bindings
>   arm64: dts: marvell: armada-cp110: Switch to per-port SATA interrupts
> 
>  .../devicetree/bindings/ata/ahci-platform.txt |   7 +
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   6 +-
>  drivers/ata/ahci.h                            |   3 +
>  drivers/ata/ahci_mvebu.c                      | 254 +++++++++++++++++-
>  drivers/ata/libahci.c                         |   3 +-
>  drivers/ata/libahci_platform.c                |   3 +
>  drivers/irqchip/irq-mvebu-icu.c               |  18 --
>  include/linux/ahci_platform.h                 |   1 +
>  8 files changed, 265 insertions(+), 30 deletions(-)
> 
> -- 
> 2.24.3 (Apple Git-128)
> 
