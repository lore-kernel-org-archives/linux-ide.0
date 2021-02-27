Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9343C433E0
	for <linux-ide@archiver.kernel.org>; Sat, 27 Feb 2021 10:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F1D64EC4
	for <linux-ide@archiver.kernel.org>; Sat, 27 Feb 2021 10:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhB0K6Q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 27 Feb 2021 05:58:16 -0500
Received: from mail-eopbgr50119.outbound.protection.outlook.com ([40.107.5.119]:39827
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229953AbhB0K6Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 27 Feb 2021 05:58:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax5JI3v+1p8GwMY/uD4wLd/mNsMYuZmv6WgZoiR06QJ4+D1Z3bdEJzKlXr0I2k7o1gYN9L+uy16thzOLZIZw5Jnk/E8A04UTqEXqLTvnir1164WrchpPeze8nDifi7Am+XVkkZBLzWDXaQFrLblPGYB042s1/yjsWX2zCfum7VpRjf/57KTDDyvjNVH02FRqrlpn6Ls9T9Hq/BXzCMwNar801C/nLV+Z0R3C0sDSjHJNJPbEM7wE52/lNYriGnNM8tQw0mJXUGM4SwdJ+vdmzWuSBS4KmGtw6yO00g+lAm8J8s1FdjD1CidmBdh70rFsyMphnHCjBF2iNzLVreT4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2dqxImKxSXJPYpWWLgXi97vY7QZM/EMwWdA0ftGcqs=;
 b=HkooGfEcd/OiDrneWEoUQ4Jk9dgInwIi/zqKAhANTTYNV3JsahBFemrnXbADbp/9yzfG6xjzGu+D/vul0M7PIKykSyWT7r/0k3A/eZbe/dsLpmeRkthfghVz6GU0+Nt6E34wnlm8NdvcRr9sY69tjOMrSt0/lGv7jdkpVS9hR2fhez51ZIImI/2HmF6ul3UL95dBiMDGL3gxqttojElyXvWAl3kRRlvKIvDSXeqoCXZ0663W0E5yMb/A2Edxl/vUB6FYlltRGnOf2RaQxqpnwSkba5taLqcBhquw8XIX7QtD9EIgLy42deP1P4YGIbi6XKE+g72VLyR5fxFtl3aQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2dqxImKxSXJPYpWWLgXi97vY7QZM/EMwWdA0ftGcqs=;
 b=eoDjWKQvG0WcdJvA1Wl06mkJBsS5Q+2tpbs9PBS4TH1ZKOUEBorqqaodXcxwUNyHa2f7RwPWaE7rcayl6CMmWCkR+TdOIC5pnyqMVWG0bSENxvGtKsUsc94uPMDhFA+4Qm69r+IoA1cgH1KZNJaQmoDN1sZYlDLnb8eIkKRJFT0=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5939.eurprd05.prod.outlook.com (2603:10a6:208:128::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Sat, 27 Feb
 2021 10:57:25 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::a990:f21b:b88:e811]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::a990:f21b:b88:e811%5]) with mapi id 15.20.3890.023; Sat, 27 Feb 2021
 10:57:25 +0000
Date:   Sat, 27 Feb 2021 11:57:23 +0100
From:   Sven Auhagen <sven.auhagen@voleatech.de>
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH v3 0/9] Armada8k enable per-port SATA interrupts and drop
 a hack in the IRQ subsystem
Message-ID: <20210227105723.7i42cw376qmnozcp@SvensMacBookAir-2.local>
References: <20201109173948.96663-1-sven.auhagen@voleatech.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201109173948.96663-1-sven.auhagen@voleatech.de>
X-Originating-IP: [93.237.79.66]
X-ClientProxiedBy: AM0PR04CA0070.eurprd04.prod.outlook.com
 (2603:10a6:208:1::47) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SvensMacBookAir-2.local (93.237.79.66) by AM0PR04CA0070.eurprd04.prod.outlook.com (2603:10a6:208:1::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Sat, 27 Feb 2021 10:57:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf2e3b19-6ca1-4ca0-605b-08d8db0e771b
X-MS-TrafficTypeDiagnostic: AM0PR05MB5939:
X-Microsoft-Antispam-PRVS: <AM0PR05MB5939239DA3DA7366FD8ED50EEF9C9@AM0PR05MB5939.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +K3UdVd+YaUnuxiOKbsUTEkOaGzSuo+ReYmNktqeQowcZgpLsCPa7C60AxOwc0w6i1aiEq9QswtAP1GG9++EDxrVwRL8TBgq08GXctR0QTyOjI/OV/n/ScdMkr1Oa1TgyYLFy64TbcCkz/psNs1P5UDp7D12SsHop9IERB0JjhBzJ0pv7vBmyWjU0s5v9MgL/x7nI4J97z95im52WZzAuWGxifYx/RlJqJJM2GQbZyRABTreU/QLcEdpznoiLfNU1SGzda7WSbGQLGvpKGmsNACboWYtZ5LOvI4Nn7yVQfshtfIZBmlur04fyzAJLHoM4R61/YA/dDaDWMaHXWRsRccKIe2iyiJ3sve47dVIRiruT9Nt1+JcXLroERlKIZVj1btF+ifqM4g9SJiz9T36+7SELuefhmJr1cyJkxMIt8f41ON3TntguaqsGqyjdIeltruLH3XAV+pl94hVd+3DoKZP9s++7/d9Fc8/rX2YwYsGl9T13HlNcW4ZTxGMQAsXV1brR2AFjXuLaWjcaEwx21Bm572R/icazL819W5ExyPHG8InPZ5y/9SsZJ2aqKy+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39830400003)(346002)(366004)(396003)(376002)(4326008)(6506007)(9686003)(55016002)(7696005)(44832011)(52116002)(83380400001)(316002)(186003)(66574015)(26005)(1076003)(2906002)(16526019)(66476007)(5660300002)(66556008)(66946007)(8936002)(7416002)(8676002)(956004)(478600001)(86362001)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?qbb2oiu82htl0pujQIPkzlRFUScbcnO3bukOmq2Gxf1i+72/eJT1TF6cf+?=
 =?iso-8859-1?Q?eMuqgwZEe+YATWpnfh4+alXTHPyo82VEAV2/HzWA77vnpRcPoHOPYdG2Nb?=
 =?iso-8859-1?Q?aee2NXf45KKjlOh1Mb+6VULkEirpuvzbsMyWfmIusmbu3DTatPkGBrbxN8?=
 =?iso-8859-1?Q?+w8/c7s3ILYdnU7IomrZlnHnIGr+Tc3t0cyYQoJjlZWN+Lo2bQywEKEcfd?=
 =?iso-8859-1?Q?MHdNwJ0dva2Xx3nDWtDZ2KqSDprUXY1tMA6vZ3RZdnDHC4j0HcoRfnDm3p?=
 =?iso-8859-1?Q?BmeBtkhyWWFr9k2TRkLGDJmX96GG4qiVDfSIvKY9l+4CtLHuU6mSErYUm7?=
 =?iso-8859-1?Q?gY2IhAwnlYIzAgOi6wo2vXtVVh68ctFKWV2MEjgZKddmqBm//njHbpySBp?=
 =?iso-8859-1?Q?3XVE1YJ7WMruS368zLAjh4mB6y7aaZ64KclcIz6zhP9FlQVQjC4kzTK2Gz?=
 =?iso-8859-1?Q?zdOEn7ixSBHyoYdP0ZrNMHN0eHVQoS8+wt9L4myEiw7S8apgTvezV3jxGQ?=
 =?iso-8859-1?Q?IwwMjQsVCqZHko3VGZMutptgvxfpk68jYBLDaAnNepijcJzOSwe+Jc5UtH?=
 =?iso-8859-1?Q?7Xed77LWK+bPaWyaJhnHSV2Dq5Sz6+gy05pOLR2pewH0bhrE+cILEWmmYO?=
 =?iso-8859-1?Q?JmvSzVjcpUfINLhSl9ZNdYWRcfWBl5twvTlcicsNZcUdy+70+zlkUn2CWt?=
 =?iso-8859-1?Q?WM6XUXNZVNi3+Tuwv4jSecWDRGWwnN/7/q11Nkl2ze+t07Ol07Xe8Q8Q++?=
 =?iso-8859-1?Q?j4lzxoN/zfItbd+TE4jW7zhXKCnddkyWfFAs+6R5f5NXp+Ket7AftBGjIH?=
 =?iso-8859-1?Q?WBGj7c0TXz3SE3ItlgGRGN1ttjObfGdUg9FINwpaGMLNs+S8UnUDp4CvZr?=
 =?iso-8859-1?Q?NhU8ijgTs2YbqOr8V0eAnB8ll0ExVv05ccIoxQBFs4V0ZIVdXpOYoY8Ons?=
 =?iso-8859-1?Q?CKkbmSKOexVW7hvEO3uMuyafrl+hruST3VoWyXbv3Eb1o1YVcU9UmM+QGR?=
 =?iso-8859-1?Q?Sou6eo6Mx/S0npyFOrgez6t5T/PM6aVYlUdU34jk6lzrf1pn0HJarqmMPi?=
 =?iso-8859-1?Q?2/e5uUCwMnW8+oTvz6ea29malpFjEsLvC/1JeFni9sKxBbNWsoBkE64QwO?=
 =?iso-8859-1?Q?cAq8lVXqI7unZk2BJfApLpcQnIeWeQMZy2nuX3nt5fRSryx1/9XuDAx6N7?=
 =?iso-8859-1?Q?IFyp04t9l5Xu/XYmKBZoU4+zUQgMG4VF033LMAjEgfv9yOZjNg9xnTo0fG?=
 =?iso-8859-1?Q?QcE4oJSYOHTwTx2L94OtUusdcNNhSjSkZ2JsCxFDP5naMiUyUDubENv3Q0?=
 =?iso-8859-1?Q?JQhu2n9MmiIGSJbIg2Y2EuG1Tj3h6gyCtOwmhiIEwizNfT3g8iqThK1Fu9?=
 =?iso-8859-1?Q?EIRBZW3cDr?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2e3b19-6ca1-4ca0-605b-08d8db0e771b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2021 10:57:25.2061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0hvPJTqeuVb8yH7Mp0O8MTTOqK0Bcy+YUkcfCJAaw+tGidf7jPpI3QZU+mRrtELPH4C35yu9r7qOwtHt6iA5gGnEtxZ5XksIN6Rh7k50Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5939
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello,

can I ask about the status of this patch?
As far as I can tell it was not merged to ata and I did not receive
any further feedback that there was a problem with the patch series.

As a matter of fact the device tree part was already merged by
Gregory Clement.

Best and thanks
Sven

On Mon, Nov 09, 2020 at 06:39:39PM +0100, sven.auhagen@voleatech.de wrote:
> From: Sven Auhagen <sven.auhagen@voleatech.de>
> 
> Hello,
> 
> There were already 4 versions of this series from Miquèl.
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
> Change from v2:
>   * Fix commit message of custom irq init for host init
> 
> Change from v1:
>   * Add a patch to enable custom irq initialization in 
>     plattform init host
>   * Add multi_irq_host_ack callback for the msi irq handler
>   * Rework the ahci mvebu patch to initiate the irq and use
>     the new multi_irq_host_ack to handle the custom irq code.
>     Remove the custom irq handler and duplicate code.
>   * Fix the armada8k backwards compatibility code
>   * Rename AHCI_PLATFORM_A8K_QUIRK to AHCI_PLATFORM_ARMADA8K_QUIRK
> 
> Miquel Raynal (5):
>   ata: ahci: mvebu: Rename a platform data flag
>   ata: ahci: mvebu: Support A8k compatible
>   irqchip/irq-mvebu-icu: Remove the double SATA ports interrupt hack
>   dt-bindings: ata: Update ahci bindings with possible per-port
>     interrupts
>   dt-bindings: ata: Update ahci_mvebu bindings
> 
> Sven Auhagen (4):
>   ata: libahci_platform: Do not try to get an IRQ when
>     AHCI_HFLAG_MULTI_MSI is set
>   ata: ahci: add ack callback to multi irq handler
>   ata: ahci: mvebu: Add support for A8k legacy DT bindings
>   arm64: dts: marvell: armada-cp110: Switch to per-port SATA interrupts
> 
>  .../devicetree/bindings/ata/ahci-platform.txt |   7 +
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   6 +-
>  drivers/ata/ahci.h                            |   2 +
>  drivers/ata/ahci_mvebu.c                      | 143 ++++++++++++++++--
>  drivers/ata/libahci.c                         |   4 +
>  drivers/ata/libahci_platform.c                |  19 ++-
>  drivers/irqchip/irq-mvebu-icu.c               |  18 ---
>  include/linux/ahci_platform.h                 |   1 +
>  8 files changed, 160 insertions(+), 40 deletions(-)
> 
> -- 
> 2.20.1
> 
> 
