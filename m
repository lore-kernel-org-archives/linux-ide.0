Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A840C19F34
	for <linux-ide@archiver.kernel.org>; Tue, 17 Aug 2021 07:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0591A60EBC
	for <linux-ide@archiver.kernel.org>; Tue, 17 Aug 2021 07:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhHQHql (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Aug 2021 03:46:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34575 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhHQHqk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2021 03:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629186367; x=1660722367;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PE6pjlJCRwoPSiFoUKsWrM1XDY8UeORDuBAnqTA/5gQ=;
  b=L7Qqvd9O5IVtDmvW+tPO1uyuoZ+nghyUXGhw+Cga82JMdirdVWU63kmS
   g4Ji3Y5D2hP3nJIZ067ycqrkb64Rka2duJHJrou95WNN/HuX7KqnQ8Bnf
   zZWplWNTOofejHaczbKYoRX0ogf3HSpnI0H6WTc7SsHH+nRPnhdy+etZN
   BJHn/32qZAT1kIL76SjsePAxVXRuRpVf8WeRG4hMBzQd5VTYYX3EuD+BH
   46i166q+AzeouIjgPlO/DPgpK2J9L7dA2jE0lwHybKLN+DKUT+n5uhG/c
   1z25n6Qg0C6o9/B/GVmZ/wId8f+AbJAgavfEu8KRaPA6xQ68vVZqCCazh
   g==;
X-IronPort-AV: E=Sophos;i="5.84,328,1620662400"; 
   d="scan'208";a="176662538"
Received: from mail-sn1anam02lp2045.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.45])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2021 15:46:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxgHIXx+E8i/znVPhHtKVoze9tdz+d1Las7acfhd367pkT8g2LaJ7cS9YagkI5l0MKHVLPU8ac4+cp7h1suf3S1/dsMegQmGMTBQxjnkVSBKO30MYAcROdADygiIvl+uZ7IbO77rxuB6Y+nzo9yqqn9+ndgkxU7XL+WZ3zNLrAcnIKSu3w4k/AEFtYGnYTIRmZf80/cb9OcPDID/lFRE1tU5TWXsRqk2WTTmO12uRQKWWkbU8VXJOjuESvzbS/77+gsM63wbyHaqWGexs/rtiBYURWrX5nQW01+8QbXJm96RPSziGpvNlCsmkxO5v47bWIIe6WTFVYy0ccUsJf++cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YVh00cFKpBEbkq9si71Y6Lkv7z+7m4Ot7MD2Ao3Jjg=;
 b=NywwX27uQgKaZqGcZq9htWLTJrt9N4CcgfqbGVTIwS0rA8pu9x1S8NPNkQY+gfbOwC/vMt0LtBbuTCSb40b+20AAcfKTPOdS4897OnY0JkTsUhJd7k7xiSCcZGTYa+Xu2ZVfSBoaYl64FaSgvHiYJzRefEs30/oZbmbzD13X+ARynwBWOK0U9Mp3sBxdZj7intIum2eJuSLl/nxw/8DaT2oO4lP/F6KT99X+Fqa9hbMSbaIZ5CBDRebCktqxQ9NaZ8tuYw/409Q0IY3i/bbFOjWyeBewWXZnXB3QS3/ZGaGUt7abun3h1kew/lCindHqT98A5rncZltBWQRujQ9ZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YVh00cFKpBEbkq9si71Y6Lkv7z+7m4Ot7MD2Ao3Jjg=;
 b=He9o3R9GNNM6KtZem1cnE1TVecQWcEOZ0ERKg6W0z0ZF95mxbfh+3Umi6xhoS2rtvRO33foX6Y0SrlcTP0ZOrDwAr/Qjx9BLb0Y011mMNehRfZU8zU1IOUssy/RVtUElzqzz9G7JEF5ckVHh/RVG952MtHXS/+B4iatEo6EpCPo=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6073.namprd04.prod.outlook.com (2603:10b6:5:12e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 07:45:58 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 07:45:58 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Reimar_D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] libata: Disable ATA_CMD_READ_LOG_DMA_EXT in problematic
 cases.
Thread-Topic: [PATCH] libata: Disable ATA_CMD_READ_LOG_DMA_EXT in problematic
 cases.
Thread-Index: AQHXkfJ9xwnsD4iI90C0rV5WFPhKfg==
Date:   Tue, 17 Aug 2021 07:45:58 +0000
Message-ID: <DM6PR04MB708170BD5DC19ABC03FDC4A3E7FE9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <YRjN4oULwmNKI/yi@infradead.org>
 <20210815162725.15124-1-Reimar.Doeffinger@gmx.de>
 <DM6PR04MB708117F3FD8537CB6875E2C4E7FD9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <YRqfxrWJsIeyjFed@reimardoeffinger.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87cbb0f6-a9ef-4603-9898-08d961530d94
x-ms-traffictypediagnostic: DM6PR04MB6073:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <DM6PR04MB607327BDB5AFC765D529C00CE7FE9@DM6PR04MB6073.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iu3K0FokoaXSTpiR3XVCJyWcJ3AsOio6fecoXP1OH7vRXCxkhkjCzE6yOrb6z7vbWwuxN3Gdb991beRgejcclAxhqY64rKgdQork2D7KXKwGdD7zFeS7tXDLts+5WmdtP0eS6u+xfl/aUocglmixMmY5Gbph80gDmINWQr6wqLLmVwMVca+IYxIf8SVjxdwv8ScmVnTSiHOPXqiGVryzpm418xIpW3WGXjC14eY4qUT4U2FdEk+rhXM5whmQngzM0o0Qg49uIm7Clq+VUiCL58u0l2VnkOobpGdWZ6uOsqXxOKrUkukH7N2GxRKPfix3sxafFG8fpBsi3nwAWeC/k3qxJ6WYp338ckdzXjaXNbet1QuP9EQ2iUYpcyVQ129tCDF9FbGQHED+ngR3KM35RlHLmKjdXAsw3ffY0X8qnNDHbIv+MNjrduzE/rAhdP9WuC9g0tjGMXVZIMS+kiZ86mRiYEltHTYIELVuhAER1EAnie2unkvodlkiS0AHba6hwFRGjqB0g3mkg3kI+BFa6HZxNWfK9dcLEd+Lrrd5i+MdUf6JKpsavYivYWQ6+82iu6d00xT51Tt9zxnTVqvAYea4GWqr7r6XjyRuBu6cMfneGhtM3E3zQY7AFt7S1/YVGPCgI+WwepOmXEWEeFkEmeLUmJt7VuapNwnvJp9rTNsdtg6MQAPRxSxuOZonTv8AqLUfaCC63QTdGi+R3fhwW1EpPuIoUAUEjWVxQn+dS0vbD+gp3xY31yXJ8RzRm6TngBQvpvn76qxuDBe/RqV7b9NsZEXf+Y0tbRiCxZaZrlg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(38100700002)(122000001)(478600001)(6916009)(38070700005)(8936002)(8676002)(2906002)(55016002)(9686003)(5660300002)(966005)(52536014)(316002)(53546011)(91956017)(33656002)(54906003)(66946007)(66476007)(76116006)(86362001)(7696005)(4326008)(83380400001)(66574015)(186003)(66446008)(64756008)(66556008)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nK3sODJVU3TwckSQ6ExIHbLLZSABbOoczWijlR7NAmPR5+sEw8rV0o7OaU?=
 =?iso-8859-1?Q?mnLf5r2DavBlSz3X7+b3watsfEM7HxNn2TUteAIcEPYmRY/ZaCHpddCpSG?=
 =?iso-8859-1?Q?pb5lyhK/Iwad0+69E3eaNNqJSfuRGmw3WJ/MJJD+iAI1fnnj5Y1aJyI7t/?=
 =?iso-8859-1?Q?Z6a4zpwNjoxLUDuGhJnPqYeZrF28m4Q5c+WBtafzX1CihLBQtKM9xszO7u?=
 =?iso-8859-1?Q?5YyiYiQJVHKLpJdAok3/ZAMYrxKe6SqVwFVbECM4r6CLY7UpYSRkxF1hw6?=
 =?iso-8859-1?Q?H9B85MO1Cmg7Qh0k0S0GQx5QI3nBMlu9rULkvwHbv44i6TJIZSwH1cXsYd?=
 =?iso-8859-1?Q?DUnH5AcvI48naM17tNuCDdEBsd4rwxh/RYqGcvv00V9iCt4ynrhrMtvSVg?=
 =?iso-8859-1?Q?gjvy7qn5+tPUh5MTe/S2EeUQGO4NveJJn3WRuiu/SLTj6A0gvXuM2ON67W?=
 =?iso-8859-1?Q?y/h6/hxEur6c/+JR+QpdUEEZJKpyfyYGxhNulsO8mkZTgHhv1WcANGLww/?=
 =?iso-8859-1?Q?/u0mo2vPGn+DbhZnsTD7rww5Ofx6sBvxSjdBDEE362KkB/GQGQYDn3O5Ie?=
 =?iso-8859-1?Q?odjGwr19gz+278fe0kUgG6DriTIlZ6L5G+C50EJ2LaVshUYuLJ7Q2Dkaum?=
 =?iso-8859-1?Q?cJ/q1+lYyScpVzWzp4j5Qxn3XjnunT/Tl8nrG9sG44OmynH+8Hsf+TqM57?=
 =?iso-8859-1?Q?LYBKorfzM5IuX6JBTbajIXswTdX4HPtei2nZtt/pyd5oAA45WIjGPeNHqY?=
 =?iso-8859-1?Q?aqlrnbAuwiu1/hy/LtvJG3YZcgmJRu7grhw5KQDgAqJdYKzefCZeQmz3XW?=
 =?iso-8859-1?Q?T7seuxQE31S/FUz8h+WaRazXfWYy4nxEGRZU3sNpBZmB9QbDy2R8mUP1D2?=
 =?iso-8859-1?Q?NaO7sxkck3EGTaO+W8FCLyYAqjyRyPOF2E4nkkgsNHtPMKF2/WVuSElOwn?=
 =?iso-8859-1?Q?o8pa+nbKxOuVPmKtQpVbE4niBjLBSadGEBUisgmKrtEF1sZ7K28UzLisHH?=
 =?iso-8859-1?Q?5RRcM+OeiYSWV83UXVB435ZxbUakCsJKt/jlHZQhca7EFeWIZXQQRLen0v?=
 =?iso-8859-1?Q?7E3sIRo1JcjclnTziYwXMqwB2qPqwxJ4VJ49ZOEM4cdSAWKtGz5UDvjgts?=
 =?iso-8859-1?Q?HJdOnHrzix76GIYWDu8KRT0QVYqFEYjSBl2Bohq2UgJYCM0S3GeRr5x6w7?=
 =?iso-8859-1?Q?4GFMcqrQYRk8tyCWCeHwFF3sfkMa6s3TNMrn2Y7Tk44sigkczI2aUqRSyr?=
 =?iso-8859-1?Q?EB2r8mBAfVvIgeNVBTMFMvviHYrdsFNpSy9B4Ja5ojYgZvuEjdyWwHWsDz?=
 =?iso-8859-1?Q?IOeGeur6dR77JQJDr5xjPCvbx2jeoV6ZBE9UoPjzvqL7WXRcR1NBRI/ZfF?=
 =?iso-8859-1?Q?s/dHKDQ0bpSezBYP/u2ZvfSyCQh0Wqe7U6KOl1FL/nsm8lIssfMp735Utd?=
 =?iso-8859-1?Q?NwzdtOsjl5yFD/67Jt12FzYKrs2w5TexAXXAow=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cbb0f6-a9ef-4603-9898-08d961530d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 07:45:58.7080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYXxoE6geE6PvQige0qvQg5cVDJI0dGFGavDnMUdrJ8TftfCOy7AxMdWISz24aefFkMWURSbrbRV5S5jSOKdfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6073
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/08/17 2:26, Reimar D=F6ffinger wrote:=0A=
> On Mon, Aug 16, 2021 at 12:10:28AM +0000, Damien Le Moal wrote:=0A=
>>> +	/* Do not even attempt DMA with PATA-SATA adapters, they seem likely =
to=0A=
>>> +	 * hang, see https://bugzilla.kernel.org/show_bug.cgi?id=3D195895=0A=
>>> +	 */=0A=
>>=0A=
>> This is not the standard kernel comment style. Multi-lines comment shoul=
d start=0A=
>> with a "/*" line:=0A=
> =0A=
> Fixed, somehow I thought I had followed the surrounding style, I was=0A=
> wrong.=0A=
> =0A=
>> Also, I would remove the bugzilla reference since it is in the commit me=
ssage.=0A=
> =0A=
> Done, though long-term the commit message might be harder to find than=0A=
> the comment...=0A=
=0A=
Yes, but long-term, web links tend to go stale too :)=0A=
=0A=
> =0A=
>>>  	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id) &&=0A=
>>> +	    (ap_flags & ATA_FLAG_SATA) &&=0A=
>>=0A=
>> Why is this necessary since you have the ATA_HORKAGE_NO_DMA_LOG flag ?=
=0A=
> =0A=
> Not sure I understand the question right.=0A=
=0A=
I was referring to the added condition "&& (ap_flags & ATA_FLAG_SATA)".=0A=
If the port has this flag, then setting the ATA_HORKAGE_NO_DMA_LOG for the=
=0A=
device before coming here would not require this additional condition.=0A=
=0A=
> The patch is a best-guess + "in doubt disable" attempt at=0A=
> auto-detecting.=0A=
> As I mentioned the data is rather light, so I wanted to only add the=0A=
> option at first.=0A=
> Now it does 2 things in addition:=0A=
> - disable it for Crucial MX500 because the issue was seen and confirmed=
=0A=
>   with and without PATA converter with that device=0A=
> - disable it for anything connected with a PATA converter because there=
=0A=
>   are lots of bug reports with different devices that have a PATA=0A=
>   converter in common. Unfortunately no confirmation from any of those.=
=0A=
>   However in quick testing I could verify the MX500 issue only with=0A=
>   PATA adapter myself, so it seems like an appropriate precaution,=0A=
>   especially as now with the new code it is possible to override both=0A=
>   ways.=0A=
=0A=
How can you detect the presence of a PATA converter ? Is it what "ap_flags =
&=0A=
ATA_FLAG_SATA" indicates ?=0A=
=0A=
> =0A=
> (should I put something more in the commit message? I didn't want to=0A=
> bloat it too much)=0A=
> =0A=
> Aside: I don't have the ATA spec, so I can't check, but I do find it=0A=
> a bit suspicious that the logs look like the code runs the=0A=
> READ_LOG_DMA command before SETXFERMODE is done, and thus while the=0A=
> device is still in PIO mode?=0A=
=0A=
ata_read_log_page() has a retry loop: it first tries ATA_CMD_READ_LOG_DMA_E=
XT=0A=
and if that fails, it goes with PIO ATA_CMD_READ_LOG_EXT. So there is no pr=
oblem=0A=
for non-buggy drives with this. Note that initially, dev->dma_mode may not =
be=0A=
set, so PIO is done directly. Once set, DMA version will be used unless the=
=0A=
horkage bit is set. So this all works as expected, and there will (normally=
) be=0A=
no failed command even when DMA is not yet set.=0A=
=0A=
> =0A=
>> If this is really necessary, ATA_HORKAGE_NO_DMA_LOG should be set for al=
l=0A=
>> devices that have ATA_FLAG_SATA when the device is initialized. With tha=
t, this=0A=
>> additional condition can go away.=0A=
> =0A=
> I missed the right place to do that before, I think I now found it, so=0A=
> moved.=0A=
> =0A=
> Thanks for the review,=0A=
> Reimar=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
