Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EF7C433E6
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 08:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2E364F70
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 08:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhCSIQv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Mar 2021 04:16:51 -0400
Received: from mail-db8eur05on2131.outbound.protection.outlook.com ([40.107.20.131]:52623
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234084AbhCSIQn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 19 Mar 2021 04:16:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZnuBxawezGPQAo1apPN6rsdkVy1TLPFjzaetJR9kgy4qizaP5py3HRtVet/Xe6OKOocFAzBHBo3+DWC8R57f2FQck6ezybtYBmXiUZTeQpHXNGLeSlMoQob/1NyC4wTDtDh/u4uWqJ6/9WAQ8Kx5svrftvtKNKAu496agon7eaW328To/GGJTN2d0biy0FvXhTShlBPWWqRa6a9OBIwLrpawAjYX22Hk0MziogZ0BsfasbzxoF0lI7juGu75HwSCsU8qx6ssGLVzBliaO7NiYQwxhyf7TposgtGTHb2CeZXr+Hz70QlPwy75y/dsMZ9jsxWQ1LytvqawtzLAkSZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BEjfWtKB6jYF6AGc2y7wdItfjlVm4oNLLBnxvKm734=;
 b=bK6CiJKncQglw7ruond2oKN3qQBZxMtgOY8S6Vp3h2FVNFl+8/e/jAaadg/YrFCVHGMHPjCP3wmQQdJG26N2PMWHKwjJkHjNJhk4XyzaPE6GwnjsZ09BOEYYDSogRDmG0mZJtCXu/skSwfMXEnuYZ+QCDEF1fZ5i/ze0m+yhmKAn0ezJGsnSPZbJ6azEySu6YYE7w5sV3F2zy1WseveVucxQzVGesGblr351xi+Nf5Ft98Q/5UX6nnZ3cZhcIo5NQLUT0gcZXmDXQcReJSSN2Yui3K1OuIVQkOhjBfZqc2ZMD3Q/EZ3pYNt64oIgv/iHAHkB1gRCO7X32BQaG5aDfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BEjfWtKB6jYF6AGc2y7wdItfjlVm4oNLLBnxvKm734=;
 b=jPpr7k5QknR2SrjsPYNTD6eBF5vc2mot/kLWk+6sNlxCugDiOKEOGDfpGRX6DBPStiQUU9RA8M38qdnhmqnfNmh+han3Voj2Uh+KmlSSHxD075T87PLniTPBBi7nHc1iOqHcBKMtZI0c+mCx2ICGlTuw1bvWHVRm4TJQiqOQqGE=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM8PR05MB7234.eurprd05.prod.outlook.com (2603:10a6:20b:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 08:16:40 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::a990:f21b:b88:e811]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::a990:f21b:b88:e811%5]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 08:16:40 +0000
Date:   Fri, 19 Mar 2021 09:16:38 +0100
From:   Sven Auhagen <sven.auhagen@voleatech.de>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        jason@lakedaemon.net, andrew@lunn.ch, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, antoine.tenart@bootlin.com,
        maxime.chevallier@bootlin.com, thomas.petazzoni@bootlin.com,
        miquel.raynal@bootlin.com
Subject: Re: [PATCH v3 0/9] Armada8k enable per-port SATA interrupts and drop
 a hack in the IRQ subsystem
Message-ID: <20210319081638.h25zcdkhu7nq7p6k@SvensMacBookAir.hq.voleatech.com>
References: <20201109173948.96663-1-sven.auhagen@voleatech.de>
 <20210227105723.7i42cw376qmnozcp@SvensMacBookAir-2.local>
 <87h7l7iozb.fsf@BL-laptop>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7l7iozb.fsf@BL-laptop>
X-Originating-IP: [37.24.174.41]
X-ClientProxiedBy: AM0PR04CA0079.eurprd04.prod.outlook.com
 (2603:10a6:208:be::20) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SvensMacBookAir.hq.voleatech.com (37.24.174.41) by AM0PR04CA0079.eurprd04.prod.outlook.com (2603:10a6:208:be::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 08:16:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c166d5f-0f36-4001-f945-08d8eaaf5282
X-MS-TrafficTypeDiagnostic: AM8PR05MB7234:
X-Microsoft-Antispam-PRVS: <AM8PR05MB7234ED84B2AB02FD37B4D3BCEF689@AM8PR05MB7234.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYeOzmWZsKRJVJAo43aAcBJd5hI8VgRlldYnGopBogivI3A9nf5stoQ09kuB2A44aVSbMOwT2ZXvaxxhIvbnm2mvsWI2NFiyT+G3r89ALxucqgqxrBxCqmek4hsgRGFa4rxqg6Xj7c3M6CtkT1+bgjJv184YUTiy1jal5ZDP8WxM7HxscmygpxarhoDWbi1/PW7W5mdvNVis5gnMxrsIy3xvKGpn3+ROOXTt17gVeti2Xvt16EdBOK/Mv7kVO67yufNFKuneK0MWx1gLWarlv5iRXz1izs9r+HPR1nzNivFEKtJBeaYT7AYhv53u2FHsXo3bGamMJ4/roj3P5zc27CD+qCTyQc8Ypfl42OQ8vF0ZHrNse5lJI9YkwPjdg+M1ucehLKiMrUx8n4HCl3OIYm6PhiQxEMZwWkehN6MYMqfLoKq8vL7BRAAwKuOnHEM5DArRTnMvPpG8AzAzZ/EEW7DD2nHblqRIYvFgp0LfD6j2R+ZEbCwmwNi7g7TiNgzVylOiOSKUIvXtObxPk4ddoB2pzNSHM36ugS6wkodvn3c2/heeMaGq2yvGoYN+dsaEvS6AgXChwLjVIbPHUHEKytzjHYRydXg0YYzem6gkw0OZ/hcrGLOIe0DftNEKtHZ7KXzuHfTlQPgXWlo81xGFy4OCA3DfF1w97Wng9N1Jm22V0JCkKsw7JKy1XfDYxvIpmMjF0CYvoURr1M8DWGfOOB0OSMYseqlBb8uQaCFMh4HAaB4GCTAzbDF3caoP0nzJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39830400003)(376002)(396003)(346002)(186003)(16526019)(8936002)(7416002)(6506007)(52116002)(55016002)(4326008)(86362001)(44832011)(83380400001)(316002)(956004)(66476007)(38100700001)(7696005)(9686003)(6916009)(966005)(8676002)(5660300002)(26005)(2906002)(66574015)(45080400002)(1076003)(478600001)(66946007)(66556008)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?qWCJwpxCjwqijr4txAZ4JMAnY7g77CGq7K1oTqXwjkcXRCCWt8VYMLtLjH?=
 =?iso-8859-1?Q?Q7V9f46dHqelEvoekfwoQL85XksdTKoqnindZM4OSiXb8iRcAyHfnQsSGD?=
 =?iso-8859-1?Q?cLrenjUPPSz+J6LwgOBJSEqgHYCq5ICNpZghksz2GwHK+pG69t7TH7s8Jd?=
 =?iso-8859-1?Q?Fm9Vw+H+Ixh3pfLxXoQJvnlyCy1ycV7zgJoQv+egK8l+Sh8bb//LcMef3j?=
 =?iso-8859-1?Q?JdGrOsDTkXUAJKlDPk6tXX1kGDnNpE3KlYGgXhHKMzT0COeufe5znnnOFw?=
 =?iso-8859-1?Q?e9r5WGYtzyCy70IYmoerov+1VpL3gqrd4Fv6GhytdVf5yBxBTpA4v2iOt2?=
 =?iso-8859-1?Q?wN4sZkQx7vEHgV66um9+waP6UHsewWJf6MIcN/yCgtJij8vy3iwLRwZC0a?=
 =?iso-8859-1?Q?nCUlBADX/dfsjyxjVAYXAbrZdagIV4g2okcDb/frlP6WOF2FOx2wq+Tsb9?=
 =?iso-8859-1?Q?W4agy34el5BvRMI9ebB7JzTHfgnlsf6tKJHWR5Ylamexa/06PDUc0FN1I0?=
 =?iso-8859-1?Q?5bQykzPHbsl2u4WOI2uck9EUuSCVJ4JTay3ipdykJGxCDGIbJiLLJMWXpU?=
 =?iso-8859-1?Q?YaERSSKDg7DI9VPf5MWLbfweMqr3M/cCfD0yR1J6YhBJLc+ZQU4V9t6TAC?=
 =?iso-8859-1?Q?U0bJXJIPOBwcRIb1yyoBr8C7pAPT2TF87mGf1N4gW+ZECmx991afepijcH?=
 =?iso-8859-1?Q?jyR0b1C3gAHeoN8Jv8+NfkemmSqn+W+aag0jzFNAayqMbQd50GIH3i6ZJ4?=
 =?iso-8859-1?Q?GosIdEY/tx38rH7h87WmTH3Vn1vV2T75OX61P3Dc9lXRcmxFgLmSVcmKap?=
 =?iso-8859-1?Q?F1HVqB9idlo53zGs94MY7KsQioFhx7OCiXnrWXGT1GYiF00X4uMB0kkt7D?=
 =?iso-8859-1?Q?XtrVymoEIc8cZ0ZlpMu6rXoyFwrij0kcHmod0cGcuKlM+QZ74vHd1hTD0c?=
 =?iso-8859-1?Q?TMg8mQfpcgKDq364/GKsZ9ol4LhUHGi7Rc5xOCYAn2aCzzDxq/4szXSw5K?=
 =?iso-8859-1?Q?ptN1Tji/DcEOkxsckmkzBUG7/19MpoQHcic814q4TqezV/r9crvuRgbD9A?=
 =?iso-8859-1?Q?axEY315+6tWL8X6Fwd1hdFzsxgHiQVpMa+rOLUuAwhqCZmHM85AstXmq73?=
 =?iso-8859-1?Q?bmgNnRYk+ZXXBp13no1zjVxFVZGSR0GftQm9hqs9Neia2fwrHcmBOYsjc9?=
 =?iso-8859-1?Q?PVGSss69PBOQOxh4ZyrwPN94kBU5QNutZZeczWhWFKNxmyMN6N5qI7WsOp?=
 =?iso-8859-1?Q?2OSXBqILBOyGRukuz9JDPFUU8dMb9CB/eO9MOeFtVg5GKxGqlXxIG8kGF2?=
 =?iso-8859-1?Q?wVMXO8F0NOTeG67m+qj9g0C3o0rRlDxy22Wjfjxoan0Fu8LFzLqa1SuRhU?=
 =?iso-8859-1?Q?LshWwIQ2vE?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c166d5f-0f36-4001-f945-08d8eaaf5282
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 08:16:40.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYRdLaxr+VOUL6b0PXiVJ8LZn2GwmpgzJ13GD7v25DRVectKXoCjzdL+FC5wLBpkZ95Z/d161l8Ig2IvmciVqUfNd6JUfHbyxp/LMvgKGSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB7234
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Mar 19, 2021 at 08:26:00AM +0100, Gregory CLEMENT wrote:

Hello Grégory,

> Hello Sven,
> 
> > Hello,
> >
> > can I ask about the status of this patch?
> > As far as I can tell it was not merged to ata and I did not receive
> > any further feedback that there was a problem with the patch series.
> >
> > As a matter of fact the device tree part was already merged by
> > Gregory Clement.
> 
> As the maintainer of the ahci subsytem reviewed the series, I really
> expected that he merged it, so me neither I don't understand what
> happened.
> 

I assumed the same and I did not get an answer to my last email
regarding the status of the page.

Best
Sven

> Hans,
> 
> is there still anything wrong that prevent you applying the series ?
> 
> Grégory
> 
> 
> >
> > Best and thanks
> > Sven
> >
> > On Mon, Nov 09, 2020 at 06:39:39PM +0100, sven.auhagen@voleatech.de wrote:
> >> From: Sven Auhagen <sven.auhagen@voleatech.de>
> >> 
> >> Hello, 
> >> 
> >> There were already 4 versions of this series from Miquèl.
> >> I talked to Miquèl and I fixed up the last comments from v4.
> >> I am looking for feedback if this patch series is now ready to be merged
> >> and what should be further changed.
> >> 
> >> Here is the original cover letter:
> >> 
> >> Some time ago, when the initial support for Armada CP110 was
> >> contributed, the SATA core was not able to handle per-port
> >> interrupts. Despite the hardware reality, the device tree only
> >> represents one main interrupt for the two ports. Having both SATA
> >> ports enabled at the same time has been achieved by a hack in the ICU
> >> driver(1) that faked the use of the two interrupts, no matter which
> >> SATA port was in use.
> >> 
> >> Now that the SATA core is ready to handle more than one interrupt,
> >> this series adds support for it in the libahci_platform code. The
> >> CP110 device tree must be updated to reflect the two SATA ports
> >> available and their respective interrupts. To do not break DT backward
> >> compatibility, the ahci_platform driver now embeds a special quirk
> >> which checks if the DT is valid (only for A8k compatible) and, if
> >> needed, creates the two missing sub-nodes, and assign them the
> >> relevant "reg" and "interrupts" properties, before removing the main
> >> SATA node "interrupts" one.
> >> 
> >> (1) The ICU is an irqchip aggregating the CP110 (south-bridge)
> >> interrupts into MSIs for the AP806 (north-bridge).
> >> 
> >> Best
> >> Sven
> >> 
> >> Change from v2:
> >>   * Fix commit message of custom irq init for host init
> >> 
> >> Change from v1:
> >>   * Add a patch to enable custom irq initialization in 
> >>     plattform init host
> >>   * Add multi_irq_host_ack callback for the msi irq handler
> >>   * Rework the ahci mvebu patch to initiate the irq and use
> >>     the new multi_irq_host_ack to handle the custom irq code.
> >>     Remove the custom irq handler and duplicate code.
> >>   * Fix the armada8k backwards compatibility code
> >>   * Rename AHCI_PLATFORM_A8K_QUIRK to AHCI_PLATFORM_ARMADA8K_QUIRK
> >> 
> >> Miquel Raynal (5):
> >>   ata: ahci: mvebu: Rename a platform data flag
> >>   ata: ahci: mvebu: Support A8k compatible
> >>   irqchip/irq-mvebu-icu: Remove the double SATA ports interrupt hack
> >>   dt-bindings: ata: Update ahci bindings with possible per-port
> >>     interrupts
> >>   dt-bindings: ata: Update ahci_mvebu bindings
> >> 
> >> Sven Auhagen (4):
> >>   ata: libahci_platform: Do not try to get an IRQ when
> >>     AHCI_HFLAG_MULTI_MSI is set
> >>   ata: ahci: add ack callback to multi irq handler
> >>   ata: ahci: mvebu: Add support for A8k legacy DT bindings
> >>   arm64: dts: marvell: armada-cp110: Switch to per-port SATA interrupts
> >> 
> >>  .../devicetree/bindings/ata/ahci-platform.txt |   7 +
> >>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   6 +-
> >>  drivers/ata/ahci.h                            |   2 +
> >>  drivers/ata/ahci_mvebu.c                      | 143 ++++++++++++++++--
> >>  drivers/ata/libahci.c                         |   4 +
> >>  drivers/ata/libahci_platform.c                |  19 ++-
> >>  drivers/irqchip/irq-mvebu-icu.c               |  18 ---
> >>  include/linux/ahci_platform.h                 |   1 +
> >>  8 files changed, 160 insertions(+), 40 deletions(-)
> >> 
> >> -- 
> >> 2.20.1
> >> 
> >> 
> 
> -- 
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Fbootlin.com%2F&amp;data=04%7C01%7Csven.auhagen%40voleatech.de%7C6500487ba77641ea9ae508d8eaa842b1%7Cb82a99f679814a7295344d35298f847b%7C0%7C0%7C637517355700947932%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=eP%2FQEvJ2oUeHeA0DH1N2yxp0CjRZLV50LJ9QbF9nDDs%3D&amp;reserved=0
