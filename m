Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55168C04A95
	for <linux-ide@archiver.kernel.org>; Tue, 25 Oct 2022 09:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiJYJBd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Oct 2022 05:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJYJBX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Oct 2022 05:01:23 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC971157881
        for <linux-ide@vger.kernel.org>; Tue, 25 Oct 2022 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666688478; x=1698224478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AW/Mqv9gPiftHimWXDieV4MGaMwhr8gxi0jTr9/fFYQ=;
  b=RdPIBRe1EpaH/4jedFlqvJhiTMVX4y0E6bEahkJuwemPRrTmI5v8y3AC
   bfvlg85hj0YbsD9lCDp+eY+9IsfxyIbXTcv1w2583ZCN3yrAf+q/95kYW
   4RixtuHC9ZcLlYUKgTVblNJE1OJWW3HTFiDxVUrpv8xRAvVPxGUB0iQ+b
   FbxAlcD1OBOrWeG0oK/WOcXpnlTwGAiYKkPbAvF8PZY3TrCYDJYLbbJLv
   ZTf1Ffz+pTh4ahIDlgp5mV4nUP7mFZbswagcqFnYubmbVViQxT+JbG4NQ
   /aAn6FYEhxF7rVMO4+vguF9/fB1mX7r03sNCk4/DE8qcsRxBaR6lU8VOW
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661788800"; 
   d="scan'208";a="326779892"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2022 17:01:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSYpSkm29xdX340+ZCaqQK6GgbN6ewmKTDLJa/T4gDqClVvfU0HbOhRvPkxaHiVwQhsCz7MNU8tt2Mgzz2lvgc7DR/icK1qAfF7RIQSpmnsPqVrpA5VJvu2aUKbdODvhTEFsdWrIs0NYyTOJwo06O2UZpeLWh3+zFmT3Xao4taVXC3sCBsm/2842HfN/GPkZ2WdlPVqubeAhgx+qMaPKbpFdRslKfoU1klZZ5XHC85lxdeaqnaFA+Mskih2YdAena8Meg3JYOLZA1axtiCN2tetG0PIkQPiycm+M4DApvGXF1ltaBm4ShXsi6y5dMZiJAR6NJl58YftnLQ3kHtyOnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZarFbpOQSq+c9QM3Q/zO99Sa3aJQx0RDel03jDi3RPQ=;
 b=UjSyJFm3Tx/TpOsHTJ55bcCGaFmroD/bOYkryrR136lrHtWDfvH64N8aO5WXYQt6JI2maTd5UxUnYMLQKbCwYoKugPFwE9U1IRUpvgk5BtMSSvxDWtqAh+5IcaOgXQqeEJghxEd5/DeqhNav0Yzuzw9bNxSk69fvE2ipiG59y4lOf0ZtPjStP9ccUYqLNjD9mQi913LAQkaqvrOMzSaQyzEHVQnGkO38AtlUB2LYxr0pMxfNE8eCCDyFgOUXUloZ+VBsboTLa0mrFni7HxJWRGBrw+Owk9drj7qlc6JI/kOwLKkfL2kV8HaVGrdfWh1aqrdhMoK7mHsRSK1jaeUJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZarFbpOQSq+c9QM3Q/zO99Sa3aJQx0RDel03jDi3RPQ=;
 b=ShWLmNb2z0ckVGyxv+6T33hg3EfmrsshTLGB2Ub41DHBdIJxSpXBhEaepESVJoP2/ewiFMIgn1Oom7LzOoZDD1VvCIOf1ZHvjjsZ9cmtSCtZG+M5/amKs3Vv4P9+wLaxqLwW87uc6Yhtp+hYG1Ksz7JbSbv5LM54mbwIdSeU/BI=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BL0PR04MB6577.namprd04.prod.outlook.com (2603:10b6:208:1c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 09:01:13 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8%7]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 09:01:13 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v2 0/3] Improve libata support for FUA
Thread-Topic: [PATCH v2 0/3] Improve libata support for FUA
Thread-Index: AQHY6FBV1COvvQjZq0qgbQYUPoYJEw==
Date:   Tue, 25 Oct 2022 09:01:13 +0000
Message-ID: <Y1el2NyL0lRFMTqA@x1-carbon>
References: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
 <f1456224-f644-dce5-15ea-fecc965788e1@maciej.szmigiero.name>
 <1401aa25-38de-c5e0-f9de-7aeb7ce0af9d@opensource.wdc.com>
 <a44337f7-3e8f-abcc-5695-f2e571087e8d@opensource.wdc.com>
 <709fb497-df73-0ee7-06db-1fb4c2e50cf6@suse.de>
In-Reply-To: <709fb497-df73-0ee7-06db-1fb4c2e50cf6@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BL0PR04MB6577:EE_
x-ms-office365-filtering-correlation-id: e7a6ade8-3fe9-43aa-e53d-08dab6677794
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JHaQkRzdxKktbVMiBWUIp+kRUZCgAFqUY2zGByin0DAMGZV+EBCJQjfIof8Lhd39fdw1Ngbxw/RF5AYMDSuW2A7zOXWcjuE/gW4sm8wmrZGouFiHCIBPRXZtmif0jI71ezdgbuG4gldjMRObhA+Z2CjBEHcN0CP1rxwRUtKWqXiNojKnr67wBwY2hl8oxF7cku0Qa8O0m85d451e5YZlnbQC33qvQ3yT6NfloSFQQ76iFMuqgH+/CJxQhwbDGIrO9cF5IRSwyS8OjVpJsyASzgewmd0DUmWBeMHKqm254YyG4yrUIDgc8sfhNZizbaNy0K95fXdmf44EdcIZ5KJCg2LDTh+666303qkHnAHI2kEuEWqB+0USCqcs2pJjiV4NNHNy/WIDVLhvHC0SjSyiMWFrekCjF8Tt//8qmaI3YNCmI+ACI1yA1mzobKLcrz0ngIagWNvxIhetnmPOO0JPihEtke9WyEsW/bCvwVQInlGMoYkz3ZR0IhMvf7YxMfLF7Vd38mF++QaG1YukQZdVeDktBEse4TSk+Vci9a8Ap5AdsejfuTb8UdZ0XJEg493JbonpENc0beyLpkidrd7JYXrTyrHpr1op0nFcip020qYpJW4JXpQ5h8doA+bKriJSeien50WLSdQGMdgDmRUjIQS3wQrYsbX4PtAN3OV6+WydR+e8dWWDRRLWtTdX7kaRXyzYiU1WYG3w0yUawWHI2TIQN6W+UDbPJ8ML5FduIg3ZOrA8x/5XeoSXKyK5SRGDNdMcHujU3BebTyG1jGGxfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(41300700001)(8936002)(9686003)(26005)(5660300002)(6916009)(66476007)(64756008)(54906003)(66946007)(66446008)(53546011)(6506007)(4326008)(8676002)(6512007)(91956017)(66556008)(76116006)(316002)(38070700005)(82960400001)(33716001)(122000001)(38100700002)(186003)(2906002)(83380400001)(86362001)(6486002)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n1GAzOkweAyqR9GA9KiM96IjoS8O8xDIAFUHRTUr95EaRjCLyhJeKBgQiTmf?=
 =?us-ascii?Q?LnjWofDkjRFPoU6Z6JJVxwimxEx/R3Y6YKf4WdkVrU+9lDmMv4owRHwp5vIl?=
 =?us-ascii?Q?oHt6RSAK3gGmoZHiXEa9eQ9T7rehiELTytEUCg3RiLIh+NOigzlvixRhuMkJ?=
 =?us-ascii?Q?nt5M9uxjU5wM/mXCZVLu6nu1055qMUwY5V28BDGx3V9D2N8qseb8qbyI2SgQ?=
 =?us-ascii?Q?GCvD1gdkxdiKpunaHlEQu++oOe21CQL/LN2dgPQHo5HoQFtld+zVE8bRv6DD?=
 =?us-ascii?Q?ZxqEkWarYHiRkbljnL8QpZrw7EtGLPsv6IUAGtxV9HFcO1Wu1gMat5ZbbZAg?=
 =?us-ascii?Q?sgwGJTceogrDwFzj1OGcUHlkDuFtuFG/r46mRQ4nBhdl/6mrbx0B1YUv+/LD?=
 =?us-ascii?Q?UD4yoUauuzvcI6mnVx2symrqNcRm0sXZtUnU7GFv9uzugmLocZIByj95zQnV?=
 =?us-ascii?Q?va1P+rdc0LVZ1KwXx/STvI0jcE5x5/mZuiOqWuRbaBTo/uncrej+8mH/3dMi?=
 =?us-ascii?Q?fmQN2jdU41TOi/2/PzAVFqq+/szCBr/fSqonIgrTPVuMsKmRpmE7XfxJuVCu?=
 =?us-ascii?Q?W1evZwl8/pE+6meO9oKtB+E0BZzie68IVaBp4gEBaKNI1kB3M8cwBC2paAg3?=
 =?us-ascii?Q?qGhkzcM5hI+jXKcMlemmAy6G24e7KdPUnsBqkvQcWI/exCxdGT2+uwrEdKmG?=
 =?us-ascii?Q?Sj31uN4FO247UyX0TypOGtIlBLRcNd2wFabLuaOf3TdHFFSF97OoJD0W9NAD?=
 =?us-ascii?Q?SAucRsNE4SbvTqUXBf9jIPESYm61boQYIQLaChbyJAMebvSXogcZtxheF3S7?=
 =?us-ascii?Q?X9IInaBdN9v3nPkrmNtE1A7WYmdwk6RgU56spZNFdQLWENCuwGCebL5Zx4XR?=
 =?us-ascii?Q?iBkryDi61OKeLXncWBfEiVlC4UkwNsrDnNs3nwFMZqcrkz/q801I1DQOdEMs?=
 =?us-ascii?Q?UNZUyFhueGZ4uXi8g070Hvk6VPaCZjwuMJNEWPSVprjSAWwyi6dJmJ2vDJ40?=
 =?us-ascii?Q?C+ePKgtxmZTE8O/isDsTY/4dYFVk2/eQb+u5K5/NW/1XAA+qjaNZCg2KYR6B?=
 =?us-ascii?Q?Ag5BrqmGN+OFINj6dvnxeqiBiSubJ3WS7cL+P/JqRhfBOsIMAxL8O4Ug5jSG?=
 =?us-ascii?Q?tMYntfqc/6AuBL68qr62tFiIsZZIuhO8arqWXBEmvpPMCUY/EqeHzU9lLtA6?=
 =?us-ascii?Q?QW9U+s879ouHIe2/ijOCTiOTcMDk3ttzQMWRitVj7/NdUvA3bTU+PUiQSU8W?=
 =?us-ascii?Q?zY9evJKO6cZ6LqyZ5KeDUqK+VUc4u0GDP4T6GyIFUpJrFyex9Slqvk8oEWY2?=
 =?us-ascii?Q?euQ8KePZTigWMu+XFwrBJAQTWG7grMSagCnrI04v9K8nZ/wlGrn2N1kQ0FFk?=
 =?us-ascii?Q?7lWDyvxmxUIMyyYcET5Dey8qVSgnLOMaCFUmi1D+Ggodz0eKH2PEkURwUjw+?=
 =?us-ascii?Q?DnS+0uZd4Csk/W36qnD1MArWAOiENL/O37aGtNfgiv1ohmot3AnMofmt56Ja?=
 =?us-ascii?Q?+4CqaesVmmu2o//5tPVUOPK9YQbxYqR/hSNtxEmkbMmCIEiwM9Dp5Nk7xm95?=
 =?us-ascii?Q?ng8XVnYV9VwDiv5QE6maJbF4ZZ8RXMRwViAR8jhiD2hwEWIkCw3O7IIKAxcX?=
 =?us-ascii?Q?kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B2D06CE076D400409BC45263DF6ACDAB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a6ade8-3fe9-43aa-e53d-08dab6677794
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 09:01:13.0167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntZ9FPGiZVoclHRkFz+vppiZ73Cm1DLHjVquk/hr7mZVYgqGoDDwAbFpeRuB/FD8nwRVUMXQ4WNAJbHlavyJtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6577
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Oct 25, 2022 at 09:05:02AM +0200, Hannes Reinecke wrote:
> On 10/25/22 01:26, Damien Le Moal wrote:
> > On 10/25/22 07:09, Damien Le Moal wrote:
> > > On 10/25/22 03:48, Maciej S. Szmigiero wrote:
> > > > On 24.10.2022 09:26, Damien Le Moal wrote:
> > > > > These patches cleanup and improve libata support for the FUA devi=
ce
> > > > > feature. Patch 3 enables FUA support by default for any drive tha=
t
> > > > > reports supporting the feature.
> > > > >=20
> > > > > Changes from v1:
> > > > >    - Removed Maciej's patch 2. Instead, blacklist drives which ar=
e known
> > > > >      to have a buggy FUA support.
> > > > >=20
> > > > > Damien Le Moal (3):
> > > > >     ata: libata: cleanup fua handling
> > > > >     ata: libata: blacklist FUA support for known buggy drives
> > > > >     ata: libata: Enable fua support by default
> > > > >=20
> > > >=20
> > > > Thanks for the updated series.
> > > >=20
> > > > In general (besides the small commit message thing that Sergey had
> > > > already mentioned) it looks good to me, so:
> > > > Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > >=20
> > > Thanks. I need to do some more testing using some very old drives I f=
ound.
> > > So far, no issues: detection works, some drives have FUA, other not. =
For
> > > the ones that have FUA, I am running fstests (ext4 and xfs) to check =
for
> > > weird behavior with REQ_FUA writes. Once I complete all tests I will =
queue
> > > this.
> >=20
> > Actually, I need to take this back. Checking again the code, I found an
> > issue with this entire FUA support: for a drive that does not support N=
CQ,
> > or one that has NCQ but has its queue depth set to one, then for a REQ_=
FUA
> > write request, ATA_CMD_WRITE_MULTI_FUA_EXT or ATA_CMD_WRITE_FUA_EXT wil=
l
> > be used. All good, BUT ! sd.c may also send read requests with the FUA =
bit
> > set if the read request has REQ_FUA set. For read commands, the regular=
,
> > non FUA commands ATA_CMD_READ_MULTI, ATA_CMD_READ_MULTI_EXT, ATA_CMD_RE=
AD
> > or ATA_CMD_READ_EXT will be used since ATA does not define a FUA versio=
n
> > of these. This means that the REQ_FUA flag will be ignored: this entire
> > code is broken as it is assuming that the read command processing on th=
e
> > drive is consistent with executions of ATA_CMD_WRITE_MULTI_FUA_EXT or
> > ATA_CMD_WRITE_FUA_EXT. I do not want to bet on that, especially with ol=
d
> > drives.
> >=20
> Now you got me confused.
> What exactly would be the semantics of a READ request with the FUA bit se=
t?
> Ignore the cache and read from disk?

The opposite:
"If the device holds a modified copy of the requested data as a result of
having volatile cached writes, the modified data shall be written to the
non-volatile media before being retrieved from the non-volatile media as
part of this operation."


Kind regards,
Niklas=
