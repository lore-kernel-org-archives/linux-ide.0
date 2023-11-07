Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41C2C4332F
	for <linux-ide@archiver.kernel.org>; Tue,  7 Nov 2023 10:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjKGKGt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Nov 2023 05:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKGKGs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Nov 2023 05:06:48 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BB3129
        for <linux-ide@vger.kernel.org>; Tue,  7 Nov 2023 02:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699351604; x=1730887604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O6ZGRG5qWylfYd3SRQB6Uv661g6XtSd0mH0GS4tOAQ4=;
  b=Y0HMzpDeXy3NkI+/y7B4yP25WbH96aVao0KpOFMN3ck4cqDbnpREEc40
   F2PPuZeKHkx3W7kxeMBZMYzS3SyTbHNZODcWotRYizUgAfwpcCgWsjvwp
   YwQi2PBmC/SHYBwWNtMUsQcqXVK+f+Eu8LT6MwitntUlgcHg9lJ8E5/Tg
   znROLb/ylgEfiaG8XRsG9OID8E+RJVLnkYy2+Ukdtiwpc9kDg2CkxO5qj
   3ogsbfBBRsByP3IK0xyXiRy+ICeif1MhSDkMQG459Y/FD0N6yQi7XkARr
   DJ4+/9DKVetpzgI96EafEhoDh53eghewfOO2htQR+h7CCaZxYxoFfYcjx
   A==;
X-CSE-ConnectionGUID: BB/+u6y+TMGNvWkTSCUnXg==
X-CSE-MsgGUID: OMgYaKm0ShevWhB6K5jCaw==
X-IronPort-AV: E=Sophos;i="6.03,283,1694707200"; 
   d="scan'208";a="1620546"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2023 18:06:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLSW3rc4/uJ4nQ97q2TUJn377hn0rgFbEx9cxBgT21X+voi05d/jqWc8+g7Ukk6dWmbXby3zyBP9AzgyVN6fb9oPCkNVPSWfb08x2g3D90803dnr3cKrvm5dW7S54QHwCT47cyRyzASQJe7dMp98JTywh2MrNn0jOGWHLIMZ1vwZ5keNvmenayo//8QL+SBwGlV8/7Tj87qYlz/C7RDgBayUluuA8PiOmw/9UGy1rUQL4U5fNcJA4/VFyAWnu43RpNtiL0ewgaAFJzli2QHJJGjiUMQJZyS0l3+z7dDCoeiHbJIAIVWUno8SOcPUMdWxnsOz4aZMSG2bftLM94ZB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBZ7EKU0Iui3E27budRgzsbxTymdpNzO+fAVaxntmpY=;
 b=cbOK3mvaaPW9mKAxnWgsWsLHq45FpeuQboqbro8UOUpgGLsEfwsGgKiCWFP02vnnDK8JCbCJmxRhrse70a78n4Ku17YB5UTTB+SF24XRrA4bLE0uc37kdVdvf6H4zCO4DE3afxcLmlrF7LXYlaj6mf+DB1NyFlyPr9GsY6d+zoppCCi7MMc5PBw+R+1JE3BlFObg7zr6fbabspFLXjOi45RfkH3O5oexQLf+WDjfMzXOay3jziu+kUhw0h6rrUvdVizSSJvvXtbk++y0R/R7FaObvj3OJaQFhOiWRYggUalxDw4KC/lJ5NV/4lbK7xU1RN3vjjelbIZzr8cICtZFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBZ7EKU0Iui3E27budRgzsbxTymdpNzO+fAVaxntmpY=;
 b=IiN0Dx4iHnhoxw3JQ1w1pfvVuniXyJKQDVj994Nphi6AxLN4vyLqhHRmBffMRjMwBcBmdUGoIJjV1J6mWKqnGkZ4fy3VpdEiuxcM0ICj6O8ZrVo4dIjknvFKmcSC9jfW8bMmmy25nW3rdJmE5ACeOaFNSJx7RPt8vEPw+/of+8Q=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB7066.namprd04.prod.outlook.com (2603:10b6:5:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 10:06:40 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 10:06:40 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ata: libata-core: Fix ata_pci_shutdown_one()
Thread-Topic: [PATCH] ata: libata-core: Fix ata_pci_shutdown_one()
Thread-Index: AQHaEWIZcIDRWrX760KBaITNNUW7Pg==
Date:   Tue, 7 Nov 2023 10:06:40 +0000
Message-ID: <ZUoMJ0eSxh7eXnzt@x1-carbon>
References: <20231106041658.85522-1-dlemoal@kernel.org>
 <07854fac-f626-785f-2af6-41d85ce53c39@omp.ru>
 <2350d653-24cb-4199-a000-ac3ce151cc3a@kernel.org>
In-Reply-To: <2350d653-24cb-4199-a000-ac3ce151cc3a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB7066:EE_
x-ms-office365-filtering-correlation-id: 3ba6f714-f727-4b3c-9c36-08dbdf793c8b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gum6Ko4UYlTcLdl+xVWQMa6+ImuLlLvNQ78mMXKC/ZcntQMNX/LBdQ2P5s9tyKTC9dKo9Pmy0to4UdDCQY8mbdFwJjy7Twk4l5yYH5x52q3h+0D1935f3xUOsUfsWaImbL5gfFTbFKjg8449T+XKVnWkZro9t+eXUq2125CsH1ty6M7s5/HP/u1l6ZRJMd+p3f+wd0Em990eIbKFqjN6LKm0D0cEFFTdes1eIfCCrDhp3ETYpVeqSq/cOyhYKXKUYfyIH3pgfc/2NHQ5cfZxi96Fs9g6YxoPsSnKJrRS9WeM92U69DJs5Hf/DpROthoqIYTSGR5NcHyXxgckpRrYK9lRPas/0/eKRJOS+B9Sj8l/OeW5VmF1CFDB746spMzujjjRM04ODkI+lm9mocQiMvrOEB9OGyMerOSJlCun0tYDV1oznuMFx6ixeGm/28i3h1tK1Oow/Hz+NK9gQDx3dW43so7RnPlOux53V0nG9Frsg4XBxwyDHMAP/UOydl7J4H122M6Tt8h4RHgPCfyBUluJydhSMXzuLTXPnB6xJfeyHpttG0rgZbRQR1xvk81FBMz9NMXtD6NimAUMx7KDt9pJSUMdRb1YPkg9BSbt6t8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(54906003)(41300700001)(66476007)(38070700009)(66556008)(4326008)(66946007)(76116006)(66446008)(8936002)(64756008)(91956017)(8676002)(966005)(6486002)(478600001)(5660300002)(6916009)(316002)(2906002)(6512007)(6506007)(71200400001)(26005)(53546011)(83380400001)(9686003)(122000001)(33716001)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n0qDx5Z0xuc5WcYSjPxAhqOfC3Yy8FoOL9x3Qm11kSVFcJ1zBEDYNLtkf36K?=
 =?us-ascii?Q?TtHPkIgF2nla3tzPp09hkE5OP29sq5a2QfN7LFtsZZ4o4SKqZjWawr7OUbWm?=
 =?us-ascii?Q?4xPvzmHYSYyC70eeiuQwnN23ScmmAI2USYGscoSmZxhn78gGRuU4Vyj3rF9E?=
 =?us-ascii?Q?cFxOX22qK3G7doGlPenP6MyCQXjhbg3zSJMceKzEDWDfGU3OM6FcjpXfXYUR?=
 =?us-ascii?Q?7PljOt519IN/+PcgKbqSKLuODWbFcgdaR4wAfydrTplVBlYEjw4UF0f1AkZx?=
 =?us-ascii?Q?750xirtV14lV8VMjVQsFkeA/u92SpLrYottSRLh2c5GK79PbggHfzjgzQ1bQ?=
 =?us-ascii?Q?bwLPSIHNq4QYhSBKMbsf1WdK7C3X4SpDv6LADDtDL4R9cUlDJEiWPfijVWV3?=
 =?us-ascii?Q?euEnhLQqrSfchSayAcJQdeeEuLx3UJ9uDd3//BEyUxItzhhkkxbx1Q/7ZsSp?=
 =?us-ascii?Q?OjLWk+xo4PGd9H16hy2RouJ77B9uO/yDnanVCN5ntgq9IE//c5Yiz79a3pmM?=
 =?us-ascii?Q?f2Brvii86Z+FYqaONqFmt9W/goiEoXOA4oBL26CAWqLtfbaEooiQslPFnrxj?=
 =?us-ascii?Q?mZl0U7h7ds+UhUR166RLyTCQjCcPhEOjxi9MckYrlyD6hVTVy2IJ0TFOZzXm?=
 =?us-ascii?Q?2AZbV0sAvXk3IEMN+WP1iaYq8e2zOIH3LGKAgQ5d0BL39G8VP/E02MKuqJHG?=
 =?us-ascii?Q?ysEuzAlyvqD/PIJ3zon2gmcDZRMKbV0mHtyYLLsq2i7FYDCoJ8WyMs1mq5QA?=
 =?us-ascii?Q?4UMuKyqXNhHF3O3rf8JOUps2sM9dr+T7Jgo8hHDO5z60nGIuUJnuxWB3pqxF?=
 =?us-ascii?Q?Go6dBB07/SwR64Kr7UdOYwQVMz/fD30SVlEjV5mE57XYfBtBkya9ylp06Gd/?=
 =?us-ascii?Q?Y4BJzlF6cGZIW1l1mTJl3D7dkGMDfZlQaiLKYB4O8TAptDpTKKlJylBkmpgD?=
 =?us-ascii?Q?FFeRt4fqBEN8JQ0r4Ijaiy3oN9tpT1QMuvy2SymuXZB4hLE7nTCUosyr+6SB?=
 =?us-ascii?Q?fiRtti85RYx+mDTBFPV1OikYrnQTltPoEjlWgoxpvxgjRZ5qJnVSNTMggfeJ?=
 =?us-ascii?Q?bouh2FpwPfrfSWkiaGy2AaVw4H9jffQiko/HsAzyPhUKaucmGwBikLpc+PVn?=
 =?us-ascii?Q?ItIYM0dpSm+iLsm/tmkFIo+yF/VKku3OmrFlVhNmsNX90rZuzk7L2wc7SVrO?=
 =?us-ascii?Q?/6bRIZzFBBjbzcuFWQqj5it0wEdq30UPgoMifK4n6CPgMIocic5lGXUbPfJw?=
 =?us-ascii?Q?Y+9tCMkI2sKpLpk18zlWU2qto0KVnbwBl/bKLUU/+zXLvlHE0Piy9GbHmHig?=
 =?us-ascii?Q?+J5y4D4YvsdNiyIxo01M5gLFlkUIARdowK4+YEtJNPKq5igJiwQN9ALDZlgb?=
 =?us-ascii?Q?P74Dm+DZM4kIsmnVw8sjEKuUMJnWbcyYjJJbP487r5tdraKzvBhYj9vNHY5/?=
 =?us-ascii?Q?rpoMCyf6CjRgGBtcQj+smL5PnkipZqRCQ/vpxnOCZcwJmp2l2cmL5cFz3AF4?=
 =?us-ascii?Q?agQXnli+LdbLJC+9qGSCPeptOg94GLe3z2kwaw85YfCjQjVBTLdEvCFhsp2s?=
 =?us-ascii?Q?sBq/tCpfKgblWMUATt6wuMpFgQML2DiSkoCk0key?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7CBA5E609DBF3E4DAC8ABECF09144848@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5apAaILg8iJV7QIyHrP7xOAnDpVguzOVQOfDShGVZW+yMNYFqddhxBTFna4iAUAS9X6JO+u7EZgBMyrATULSd+nTlSUrJ5IMB2pbGTo+d5DCC5Y+f37/5jrzwFQzq1zwS19Sx3hiSeBEVCWCtrsAen0mTBZlkHMibUmrgs1Ed5f10gQuwxVetTmYxWaGb4AewIvW1gUJlpBNsXWKNW+pxDIrDa2b6WY0CPAtv25gQxfMTKD6XcVkt8ClMFt+5R7imELOsya6zHrujWtYYnzLcpaKs9Hrhf2w+gYMXt0yo2GlbXmYSzmuxTGJb1+2Rb3oYswUZ0NFIrpSANMxmFcWjRQkoJAFgYkMnDgUSbxmz8ou+faSZnnI6w204b2aaOo5huUFiWBZ20lU+1sgPjTZscZeO9FXcEvqvb0j2laypWec0mbv6Ctpzz+6h2cvUhA7icGQjwPMfQjkYsbUZXNM1Xnh4/W5rGNSeNE2XWuHpNChsr2Tb/Eg6oxUnAvkwuohvDcHiVPIZ0YBJuoiOnJ9AmAL/XBwNR4E5TlxcDd8Rn311/V2w0JQA8WeOjanCd1RldHaPuCDAjYeUImPMZ2MvZmAM8aS9Tja7rsjSa6mgvaDHh+iDHM+m0OOdRG5n5O0U/L2D3ipTmN/MhHfkLWBoeCyVIscCGhRT3a21ZzueFlfT1DmrU6Sz9pGEhC3l2obxVe1sc6Ryb+7bduSafiSuQJPl6ngrJrTFwlzDbA0aB3SqxoHOblpOf4kaXgob8EGHFdgGAaKo4t+mGy3LYQ/7umfmbxgvUtOTqhzS/tWCHGznanDcQN9IT/ci8LvH/xGsaHv3e46XVZUGZ2Oz8JCFA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba6f714-f727-4b3c-9c36-08dbdf793c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 10:06:40.2481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1HN4j7+3M1EDLxEyWA/gFgQGQKLI4J9eYGyDEiCy/fKX9mHSU2Rw3cCvZeu9dyAobqRevMKgkuNJi44+m3bQUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7066
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Nov 06, 2023 at 06:02:04PM +0900, Damien Le Moal wrote:
> On 11/6/23 17:47, Sergey Shtylyov wrote:
> > Hello!
> >=20
> > On 11/6/23 7:16 AM, Damien Le Moal wrote:
> >=20
> >> Commit 5b6fba546da2 ("ata: libata-core: Detach a port devices on
> >> shutdown") modified the function ata_pci_shutdown_one() to stop
> >> (suspend) devices attached to the ports of a PCI AHCI adapter to ensur=
e
> >> that drives are spun down before shutting down a system. However, this
> >> is done only for PCI adapters and not for other types of adapters. Thi=
s
> >> limitation was addressed with commit 24eca2dce0f8 ("scsi: sd: Introduc=
e
> >> manage_shutdown device flag"). With this, all ATA disks are spun down =
on
> >> system shutdown.
> >>
> >> This reverts commit 5b6fba546da2 as the change introduced is now
> >> useless.
> >=20
> >    You didn't use 'git revert'?
>=20
> I did, but I wrote a proper commit message.

I think Sergey's question was because you didn't keep the automatically
generated one liner will the full SHA1 as the first line in your summary
(which is then followed by the reason for the revert), see e.g.:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dac2263b588dffd3a1efd7ed0b156ea6c5aea200d


You have the line as the as final line in the summary, and shortened it
to not have the full SHA1.

Personally, I think I prefer having the full SHA1 as the first line,
as you directly see that it is a revert (without needing the read to
the end).

But I think it is fine either way:
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
