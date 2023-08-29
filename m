Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616C9C71153
	for <linux-ide@archiver.kernel.org>; Tue, 29 Aug 2023 13:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjH2NE7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 29 Aug 2023 09:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjH2NEv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2023 09:04:51 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678BE1B6
        for <linux-ide@vger.kernel.org>; Tue, 29 Aug 2023 06:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693314288; x=1724850288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bpd66uCWDjKHxZ78qZdtOHEJjp8czOLDM9oRWoP0QIc=;
  b=Xad1lNYvyU8an3UACyXr/UbBpAMS7x9RGccQ53VwXIpxehWhJo5cQeqi
   /XUE8FlQkAewgzIEb5O48Rfw9JTmb7M4rvxX0g5cFmUX2F19qbXWO0IC1
   kfThYVpWQsbJwSNaEdsn9ZrCvnIXcdGf1Wq/WArWjanlN4bUtBG5357qS
   Nk1RjWgFn7ZYz8BQHnBQRUUuIzeSQSIVr+GiGZhXXM/kpCdx5dx43K1Pr
   GNK+v1exjcJnz7dzvj3YCjmsP+IPE/rYLNfgUNZZSs8TGTdssq3GKkJn+
   hs/7SmDuLuNy0KYF3ymocf3oobgQoxsdztftIqn7WJ7ygE27ORDnQkKqp
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,210,1688400000"; 
   d="scan'208";a="242362581"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 29 Aug 2023 21:04:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcdHIxGHchw85crNNFNChOKPwi14ULYzxW85obGbXFAYioJ1KjLrrSbrRj0RjzjILETAeslZWABcBLX5klK4G2tI6eTiM+2dDSmC1DpAJH0BrEa6UJd34Osw2qtwmvdGHTC1kAlOSuxxkYlFf7+omzVijHybqkdhq95YSe8i+zU1oJSeRhSRgQzZ7LRPxrJQHCLrkLB0IsppnFhud0z5jUW8vPmLzIgzXYb9u9aE4QdObuE3TbiNakCBR418TcEfslCRNpQt9cD15+iWN4svK6Fd3fcb79g4UdY2sCL0qqpa7qsVSF5QigQG9CCeKtEbeGtKPtXsfUjGIhoaxqPLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpd66uCWDjKHxZ78qZdtOHEJjp8czOLDM9oRWoP0QIc=;
 b=ZFFJcPATmh0/E/9KMJzoJpF/KYicyZb8uykEjJx48ijzCp6dZqdGRXPLOx1d1OpECNS6J/RVH1P9dXVgBMy4bDLLepJsEPdbMhM5RKHg2bBKxfcVJvQRGHN8xVCLaCvPV7fNtrT2T39vZvX1/FdFYdpPuPdA42c949V7bpZ9R/rJWIR1zOe3QSSPlB7ec17Y8zvKM61FDy0uWa+01eu9Exvc8gWnKpSLr2TuBQdg5ZVoGQPPK4pJN0BgPtmWdHfOyGfLu4YBao3bO1yIym7ZQ1Ghc/xzF/q4BcUhIMfqT60o4l9HFS8W2+XIMw1Us5plttysGsgvUzhzSOuW+ywcWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpd66uCWDjKHxZ78qZdtOHEJjp8czOLDM9oRWoP0QIc=;
 b=eLlEtGu2HKxPywVU1hJX3P5xkWsgUFLQcVV6ECYs3GYz6Szhbjvb8z7ogcMAouIr55lYCwFk5Tdo2XG+LcGGAwdmnKCZXR2sol2Am4UGw91tODkwqT8hFSWX3Wt6fuUTvJUZKEGPNK74DwpudZzR7zCXaFwAFwb9DQi0JJPoCY4=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DS0PR04MB8666.namprd04.prod.outlook.com (2603:10b6:8:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17; Tue, 29 Aug
 2023 13:04:45 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 13:04:45 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Werner Fischer <devlists@wefi.net>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ata: Add Elkhart Lake AHCI controller
Thread-Topic: [PATCH] ata: Add Elkhart Lake AHCI controller
Thread-Index: AQHZ2nlhE2jpEAGiDE2yyZzbCkJvyw==
Date:   Tue, 29 Aug 2023 13:04:45 +0000
Message-ID: <ZO3s6Sx8mCJwXWnX@x1-carbon>
References: <7728fa4b6027269d468f6a0665017c187471a9cd.camel@wefi.net>
 <a74207b7-64e9-c01c-ee9a-5269c6be41af@kernel.org>
 <f4f02b8d2aa8afd83c305589f576539a20e11c13.camel@wefi.net>
In-Reply-To: <f4f02b8d2aa8afd83c305589f576539a20e11c13.camel@wefi.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DS0PR04MB8666:EE_
x-ms-office365-filtering-correlation-id: 778bd1ca-ffc9-41ad-d6e0-08dba890846e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H+L/RKWNbAKQPCDr3rGSHtb1ze4IMh2R3cJKgFDruYj8G9BZhTpaSrpE0qw/x4JmY9JNFLug4q9EkAfSORVmpgpLX5OWUUYu75KahMWd4ugJhS2zK/nzPWbF+qerh6LEwIT8+xnlZjGWCYOsT+F79NeNinfDYn3SA3cihFRNVzc+EWMiJOiLiPG4dAo0/V397I2b8tFGjl6BG7AhNBeFgR2SKy6+AsEqCZ5v3AonuK6y8yfTNwawQKL+S0h/9uV+rhvB+J5Qwp+mWbdj81rZfpq4P2afd1LGJXsSVmDbQkUgLCo9glAMXBCNuePlA8uQHYKbNz3DyJ4T5ktRBYCCfWnx/O3J0C6lSM1wB5kM1u21nP5gQWvZpPDPZAcMgnsBbuIn1FoXwDDkDWyAj3zWbgqvkP0joZb6jFCDWECGatGFKsf4NMDv7kfEkO3omaNW/nHXL2aWkCWUmRjhrylSewJKMtO9/elRg5boTuugZCTGaKnjZCxCTDtR4UMyjFVlt5UyGLtRXrOYwMrv8fuGdA0C6eBsLrG14l4JEYWrzdz/4Kq4DBs2QL6evOBpmtxPlfVWA+D5sB+VWFVsKsBgKRH0yQN9R5sYrXuq06OF3Po=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(346002)(136003)(396003)(186009)(451199024)(1800799009)(6512007)(6506007)(9686003)(71200400001)(6486002)(478600001)(966005)(83380400001)(2906002)(76116006)(26005)(91956017)(33716001)(54906003)(64756008)(66446008)(6916009)(316002)(8936002)(66476007)(66946007)(41300700001)(66556008)(5660300002)(8676002)(4326008)(86362001)(122000001)(82960400001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rSL9gdmeCGIZa8FHEJ66HYcwDNlIR9QZmZE3Is74ikIk67vofPu+1xq/YI02?=
 =?us-ascii?Q?34/WVHCBbqaaJyXT2z1Zsz0iIyjozm+cT8gfavFhqdyOBy/ru7REh52C+Cav?=
 =?us-ascii?Q?kHHqhb0eXen/HUZJJLjLY7TPpjx6KxMqg5fsj8LQGXet739nNvp4wmTKV/bw?=
 =?us-ascii?Q?A2yoNRsGFfWy/HxiJ7p11UDnFw+FokmLp2wXlf2ANmXEWtAPwP8+k7TbFRFo?=
 =?us-ascii?Q?QwIXR8gelmP5MTLcQKRP9qskUdd3rxKAPsFY63YgeQm4EZaTPllPo5aZpMw5?=
 =?us-ascii?Q?mxdRB0a/bYADoxQEPyfofHRrvB/wZ3wy2bmkn+o3IrhWGbpgrbDGC+Sty3U3?=
 =?us-ascii?Q?lvD3ab22Tr0ZPo/6lfRwJgJXJPfFdMW/kB6Qb9pQ3OZI+nlsHSHTLW3u5OhS?=
 =?us-ascii?Q?S4ZZBuYeiDv0HYXg7bxJ7rotara5Q5mCJEc4q7UJHXz3DZmrnAOgXKkl07hD?=
 =?us-ascii?Q?0X8XXg4SmM2ajuqGxybtQvlcB4HUgwBCoiJszYZ5ryMW/azDNwQKV8MsF1i/?=
 =?us-ascii?Q?6PpyQVpRhnGgO3HUQmG5eXt5rXiz0VMdNfhkL3Ggk78wT4hLcVFyRTUgeebI?=
 =?us-ascii?Q?+164BjU1Ro0LVvRoZ9JS+piqG/ilSZu75vJj5JdBpmv7C51ylsfYax7e2gLt?=
 =?us-ascii?Q?BB5msZFO59tpanj1IbnwQEC5iFfe9VIOwO9ka6rvhKgRjd4lhXkCNQAJSIsE?=
 =?us-ascii?Q?nh0wCQ5UV6PaTxstmC2hox3Rcmapf/p/JnJEuxAMpEnnI+MUsxoLuBZs9C3n?=
 =?us-ascii?Q?WEuViY1QRS/QOILUXP5FMZXivK6hxTlWah5C4RP66+53+1xi/5RJCblu2MP1?=
 =?us-ascii?Q?j+uDSYnq9rNusOmgejDeY6zDfblilhHvJYYWvZS5hGRPJXbrjdX44rh+eeYf?=
 =?us-ascii?Q?BwbsYa+Mi2v/x6ncAVwN8/N+ufbVT904BDD+/jr/QFYAbokzUr7dMkUk3G47?=
 =?us-ascii?Q?UI3oL+VLwD70FG9UC09chjsT+MT+1yeHvwOqYJYJMgi/WhgzTMuYR/bYThNM?=
 =?us-ascii?Q?XSn/MGaSdNX2SxW3X/biqRefA4HpwpiBTwijVH2ZBhckb1z2zd5zA2IL0nDN?=
 =?us-ascii?Q?dcuQ0H8fLZhGx9fpWrUjn3ZW9c4KNUMeDFg6S6sdD3ul0vzGct3l2juWLRY/?=
 =?us-ascii?Q?zdd6mS3m1bSz5zF7umz8reH6uSQlCVqdha88suArTm13651iUEZMEqBLNfIP?=
 =?us-ascii?Q?1P5cf6OvDqVmMJatOSWEA4GJAwnjAsG4jcKnh6e1sCh9Aq3uf0qJihgJkkub?=
 =?us-ascii?Q?zgzjsQWbDwlav2IAAoj7ucDAbMntmYiszan9Tscx+s7oaNdKcjMuAFaQrKMx?=
 =?us-ascii?Q?hJn2NFCNXsR/1IzK+9W2Autr77GtqHz+qsYqbgUwCtu6lVnFOiADjcJBFo4K?=
 =?us-ascii?Q?0Qu5SUWRIWmLj+LxGeFRmaWFVTi/n50VegwrDmMyNo6LzZUcAs6rImjf1ixX?=
 =?us-ascii?Q?K315rIVqExCdQTkWLMIzJOFEAdv+Yx3mY27820uLeDgXB8X9dTFCgI6uLK55?=
 =?us-ascii?Q?ltqOFi0TZyOZUk4AGsWr8rIOTmeNZG/XfS+VDU8+klor96DEPjTXE0f6YjoP?=
 =?us-ascii?Q?T3xe6pExpkRZS4mGExXG26vJdLNPhtMJNxWrygjF7dweUIAhXgMGlewgngJ0?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C550ECF4FAB8E745BDD6F752B84FED43@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EN24fJKmYkZrNm5CE4DSjwr/ag+89vX4dBFIlSbDO4oPEx818OZPyiMTTm+6ploJL/H95wxzdh6tJs3lC9yzJ5TZt5HpyhkHEjdGD0Dgd/2R0AfQD4Ea4b3hKbi6uJDqv/MHittZs4/lXVfsOIG17v6E+ZT1KTTK4gQ+WuvqhGPeYZQRsY7+Q3+ljzNedHAsbM7Z/mUDrWpR3P2cjbE5mhxn3D7wtH9ipdzVwYKokEJAtiTiK0Ld2q3ynHjqDxJlqYLKYmg1fsmI15ff2f3X83hESMSaNXOqM8hbXwm5yUbUILO90I2f9XWSwJuRcdkuq6rXErl9yA1RtJafIjpU2bW43rCrmR52vJY+CkcUc3YPvmMP+Q61ifUIfaifjaStmGNicm1Sqv9vRjbtDbXORPR/RtrrMWpeDfmHXhs6Fkye+9VpRUG4ZE0/Ij/0VHghMZgY+/GpM586qpuQYo4uzGAGTCNYLm6AD0pFm+hEtHLRforFKBRxTL69qladD4U1Rm17UbivZOcG6giBfcBLw38o+20WcFzVqx/o8nRtZJIIwjmaywpjs6YBmq+NJWB37YlHDUS61wiuvu9ulzzp+yqmnS7YtmPXYxkDgLotgpLao4xGte3ngMwO8XlOOHDEeQub4wKi3xu8T5gvEibelh9aexWTVzCgrtj/3v942k8/IEuBt/Up0A0IyJKfgnXSJ5TUi1aMia5PHTZ8d+cbDaz17/JZRU9AHAl5J3VfHU2JcLpUENsbXbO0aIo2sKMcej2MfFD1kNileF45rmcSho0+GtytQg6+2p/wtehAR+gg6e03VXUvwwJKpOZUjmv++XfI36I92yurKLK4RcQFkA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778bd1ca-ffc9-41ad-d6e0-08dba890846e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 13:04:45.3627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFMQDicivIkmfXMKwhKukQHJmIGDSBOkBOFBI8+O0oJyeIFfXT6dCA50iS94OGpid9tDlzPrIerx2QR3hWdLlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8666
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Aug 29, 2023 at 11:35:54AM +0200, Werner Fischer wrote:
> On Tue, 2023-08-29 at 15:09 +0900, Damien Le Moal wrote:
> > > Intel lists a total of 3 SATA controller IDs (4B60, 4B62, 4B63) in
> > > [1] for those mobile PCHs.
> > > This commit just adds 0x4b63 as I do not have test systems with
> > > 0x4b60 and 0x4b62 SATA controllers.
> >=20
> > Adding a mention about the other 2 IDs in a comment would be nice.
>=20
> Thank you for your time reviewing the patch.
> I will send a v2 with an added comment about the other 2 IDs.

Considering the big mess that was introduced the last time we tried to
enable LPM in an Intel AHCI controller, see:
104ff59af73a ("ata: ahci: Add Tiger Lake UP{3,4} AHCI controller")
and
6210038aeaf4 ("ata: ahci: Revert "ata: ahci: Add Tiger Lake UP{3,4} AHCI co=
ntroller"")

This patch makes me feel quite uncomfortable.


Yes, an AHCI controller should be able to have LPM enabled, but in reality
there are so many SATA devices with broken LPM support, that we would need
to add hundreds of quirks for all the broken devices.

The simple fact that LPM is commonly broken in the wild, makes me think tha=
t
systems should need to opt-in explicitly to enable it.

Yes, our default LPM policy is 0:
0 =3D> Keep firmware settings

But in reality most distros use:
3 =3D> Medium power with Device Initiated PM enabled


And in the end, we end up breaking users systems:
https://bugzilla.kernel.org/show_bug.cgi?id=3D217114

And if their root partition is on the SATA drive... they won't be able to b=
oot.


Yes, one problem is that you need to use the board_ahci_low_power in order =
for
the LPM polcies to apply. But it feels to me that accepting such a change i=
s
too intrusive (because of the distros default of LPM policy 3).

If we somehow had a way where regular users are less affected...
E.g. if there was a way to try to link up with LPM enabled in the AHCI
controller by default, but if it fails X amount of times, then we disable
LPM in the controller (or maybe try to set policy to ATA_LPM_MAX_POWER).
Kind of like how we do for link speed, where we try a lower link speed on
the final attempt to establish a link:
https://github.com/torvalds/linux/blob/v6.5/drivers/ata/libata-eh.c#L3599


Another option might be to do the opposite.. Establish a link with LPM disa=
bled
(or maybe with policy set to ATA_LPM_MAX_POWER), if we can establish a link=
,
make a record of it, and then enable LPM and reset the drive.
If we can't establish a link with LPM enabled, and we have a record that
the link was established without LPM, disable LPM again and reset the drive=
.

Not sure which is most feasible to implement.


Kind regards,
Niklas=
