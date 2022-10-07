Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC9BC433FE
	for <linux-ide@archiver.kernel.org>; Fri,  7 Oct 2022 23:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJGXup (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Oct 2022 19:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGXuo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2022 19:50:44 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3913662C5
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 16:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665186643; x=1696722643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qNvR8bPivwObbso0sCyN4Pvuoy7JmirnctLdVKT/3wA=;
  b=GBfGLJ/Y3I4AMWs442OyuqAlp8Bqz8yc54kZguzTv2qMgjnFRw+guYyz
   IaAYVKaqmvCU1HPvl/6cz4pSVJlfZSIVfjC5I2JOFBSJ5sp6vp6xwbnL6
   WOGBcmtBf63rHktB+Kxm2v9aR4PF7c5KTCuGBSdLC+rCY5uuMK9+9xDAq
   mOzLXMfQkD6jEpvq5IPKRk4+H2xdh4t1oyLGqpNGQM178W8YQSuu7El2i
   EA5OjvvBWMGWxAeFiJMsJgCKIPwDxFdlbdYUq9zs2s7VLNhQgyvCyhYIV
   5MBZS4SGNpDgTrnQwKjGTE66cUeV3hdRaAav32iQzK/eqsPooJhaqznTn
   A==;
X-IronPort-AV: E=Sophos;i="5.95,168,1661788800"; 
   d="scan'208";a="211612759"
Received: from mail-bn8nam04lp2048.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.48])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2022 07:50:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zn4oRVNK8mw6qSk69e957IpwmcSVJpawNjSCnb21t2PniB4dTgPHtvlTIGIw2Wb3FcxQc6K2d1s/4OjYNh3y5REJMypY5D2Y6RbEEWYKo5tABIXHlLA9vRfneZU6ZuuxmX9sN3zKqGEkQmvZepDtRoN2XXj28+Fi+3yjAdtj60Rr3mjk/EQ7LOyCYKVL1xyTRGTdMN84tGikaZx5xm+Eb/36RNZkFYZoE1R2kbNmZH3aary0Zm28Q/dXoMmHDUKcf7ePWuKgUubaf6axokrW6VMF/dh8Jj2gC3Bb2pIPnSTtAlC5kdrfnCBYls9tdImb1hYHC6Mo0gTyxfGDB26/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNvR8bPivwObbso0sCyN4Pvuoy7JmirnctLdVKT/3wA=;
 b=W2HkS3RX/E54XKwAXquU870BnFy5fKUiz126b/znQrDPb37dGmMFMGqZ8Y62eylvn+wz9kSZpu0fWwRu3KiOy86YDrTqXfaOUVIEbnASKw0rljdsImKl1cnBn5PSw6GcWmo27ZNwXotPZmt+sMa+QOagmLOMk4ekgSxLk/a0NmmRg9p0RK7MKIOxrlxqpbI9zPugsODZTY7rU9JVrVr7x4N71rlDpyj/31wRMdwammjfZb1Ok/Epw+gDwSr17vhvrsPmGezbxj/X7PWjxXTBxC+3U9GT9dPJtxHoFyC40VVmK85jvPH8UELoEeQwyaUwUtj75veEsQHPXYZ6Neglyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNvR8bPivwObbso0sCyN4Pvuoy7JmirnctLdVKT/3wA=;
 b=wEASs29kyNbTJgJrWE2Xd9QbBhfETvG62GdR33LCKZ50+lyYPnOtD0jV0SNU9Wpqr1ARkti1aUvWMS8HSdQ2fKWw0LF+zG0wd0V84SzKBCy3Lx+zxfZQLoHJGf/tfAOeizuoTcHv8XwpBdr8oZAqMeasJZteyBvzz4oBT2m3rFA=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BN8PR04MB6305.namprd04.prod.outlook.com (2603:10b6:408:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 23:50:38 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425%6]) with mapi id 15.20.5676.028; Fri, 7 Oct 2022
 23:50:38 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Mikael Pettersson <mikpelinux@gmail.com>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 2/4] ata: make use of ata_port_is_frozen() helper
Thread-Topic: [PATCH 2/4] ata: make use of ata_port_is_frozen() helper
Thread-Index: AQHY2lAPg5DskBJedkShQtJc+cw0+K4DhFMAgAAWP4A=
Date:   Fri, 7 Oct 2022 23:50:38 +0000
Message-ID: <Y0C7TcSfZezZxMcX@x1-carbon>
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
 <20221007132342.1590367-3-niklas.cassel@wdc.com>
 <dac5c025-1f77-9972-977d-cb3d22023db4@opensource.wdc.com>
In-Reply-To: <dac5c025-1f77-9972-977d-cb3d22023db4@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BN8PR04MB6305:EE_
x-ms-office365-filtering-correlation-id: 08fad92d-4b1d-43c5-e201-08daa8bebc81
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gm6Pi/UYnOTYYgXRwRt0sV3BLwu5KQ8cuiLewNiTPbi0jS3Yxyl2yBhh9mJ9E7A40KT98DCiiD1YcpUdMJ+mbWIvqbJC+rL1Mr0ACM4R8JrYZkM8mucKLqnT2Gf0HgdeD04QHokNopqHoI1HmKpwvuLZ3nXwj5tjz6lzpW6PUhmGQLKRg7J4ka1uUMefa+ts6NcP4Ea05ejDLe1ZJezc+/5kV2TZdyxQHuw9A13I5YBxA4+uNiaGZnTTImjLwQft+cVR/vAOaaa5i/jiq/c73gfQwBctpSTM6ONQjBSa6+81Oe9FKHHllM3gZADgq7bAvqRPiThzSAZFthvAE806S+OfS0hYXo9SCc9j7gSUkamj7Dii/whEFaZwyJ7T8Ip6/w4ZVI+QChGyxgkZs+5EVy9YbTwml5iMu2sBd683D9KII2QG8ZqA0LftMragY97G0cVxpJFVROD+IqcEwSOr4wFa8yxGmHlNF4N0XPzCediEZqEOLq+Xr8E1m4+ArkQxtaJTKafIyh5/s3uWrZ+rmoSt1a0kZAncrJviLBm7KXfVLYrzBD6dfdVFGi0hldxnVFjcH667c0mIEWiStEV8TSlCab4q9ry/tESP0SieVh8Bh8+A2VLe1u+ygR/EV5AobOAnvNeL1/GWWSPcctftc5hFu9DTUVC2roHAjOjTulENokl4dVJBwP1JXsGLYAsGZhwg18L8b38NjMXdzMdo2RAHdxHzV3SQY/MTSVGqi4wjeiYdqQz1rX/dofZrLNpG4lBjdqkAOnWv/r7sjgr1WQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199015)(38100700002)(33716001)(54906003)(122000001)(86362001)(26005)(82960400001)(9686003)(6512007)(53546011)(6506007)(71200400001)(186003)(478600001)(316002)(38070700005)(6486002)(5660300002)(66476007)(41300700001)(6862004)(4744005)(91956017)(66446008)(8936002)(64756008)(8676002)(4326008)(66556008)(66946007)(76116006)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TCEvzkKvxZtUONMuL1KIZ4ioMeaAgl3OOMyVW7ZYUwjqTX0Xgn/JUxOc0174?=
 =?us-ascii?Q?uuT7PZ5xcC4fgBmjMezNxMhQoXYzHjOCUh1Qp/RNYJxkcP94Z1ng6GS9EynJ?=
 =?us-ascii?Q?YJQaZN4qaJNeqrBBzx+2tp1S4mn3ns8FmBv53obyfIUWj4mLX9X/LzvId21Y?=
 =?us-ascii?Q?0/vxrphN9aqStIlpdZVLGjsBVKEsqke6wkOUmBu/w4N+maGPXM7Cf9h7CP+g?=
 =?us-ascii?Q?gUcggHtycz/+jxC5GJj5wUid/wrscIbH5D5Wdj1yl7CBZ1GU+sWL+kxZKIv0?=
 =?us-ascii?Q?QepFJNPr9033ItTgj8at1Ezl9io4csLt+qWjypY7c0lXvYGjERJaK1St30dZ?=
 =?us-ascii?Q?n8za7rTl2ivYektywdWgxFDNhgSsbU70ARt48s5jD7xj5RyKBIspQAOdaSt7?=
 =?us-ascii?Q?bOjIUcXhMPDslb+6Tt7CIJcqGz+FXW8jmo3XZF0pZj6oUQfHJXp1tbCHv4eE?=
 =?us-ascii?Q?lTYs+KtnWTwnlYiRksQAKS9MTW2ZORVMqwXRKF2A/IhubMTlWNzYi9ixR+oO?=
 =?us-ascii?Q?Z+ispm8HSqUcU7yATDnzUmhSTgssf4CA0I7U2KU1remucCsWp/OXQN6KlsF7?=
 =?us-ascii?Q?V2sbwLKKNBj0ZDh2ssIgNHibSO9/4IlUTJjmTL+Z0moBLt5cQ35G6kEXaNHw?=
 =?us-ascii?Q?eP1V6nk2c6/hDGYKdCoiS3wmrlCuKpr+QAISbgm1M8cLrIgRTWo98yPxzTxP?=
 =?us-ascii?Q?6kgOP+ZGuQxSXDopHACRo9rmRLEKA1entWCbwznYY2xUv5x++21YFrUjTWpA?=
 =?us-ascii?Q?oV9Sqgz15PPajuIHskKfHQOz+afGwHLDQyAyDCUjbOIq+66+9SjiFWWVcVXE?=
 =?us-ascii?Q?p97F5witJlTV3qXRECr+0w/SAlt8cRVhR4Gn2MKv04SXQQgxbrNXQGdYVYTJ?=
 =?us-ascii?Q?TWZRhlWt4XNcP9gxYHFlQVRrSV/63KwziRMBJVYLH6gd7PR8eLUk2iiqs/u4?=
 =?us-ascii?Q?0+nNC/nBFMjQ2yaJZh5QFXVz8c5ORYhUmABQFkKT15i2w3R0hrWoVNaDnAb+?=
 =?us-ascii?Q?J4WivN5fCNAswqwCEzwhTW0SAl2JzTyQPxsK3KCK3VdsGNZT/piSBara9gNM?=
 =?us-ascii?Q?+0sxFrbZ364HU5WosWL0UO6fY2Zy71y8LkvVPUJauQLD90gx9ZNMzGHPq4tj?=
 =?us-ascii?Q?tmtoFM9aTtmoXMNjHAaGVaZyDDCzcjPe5ssS20BSJ+Bwf1KtEje4RxObTLMM?=
 =?us-ascii?Q?8Mt3fLDBa4Kj92DdnXS6GvTsiHCSRrTqNyRk7+rsY0YjqH6Ks8bAmpx2nJx2?=
 =?us-ascii?Q?6VIpYXZsNgsx4cQegtms4dfNr4uyOFtSXA91CRTB9InmFuuEm42hUAqOPkKB?=
 =?us-ascii?Q?rXlyJjS5zN2CfYhOdznfdEtmpo6fL/MELOqNbsNYc4zeYjvy0RJkn/ucl0iV?=
 =?us-ascii?Q?0wiJhyiSRWIqqs4/cNh7g1m8chzowQ1jx9DpHn5FAfgrcVVO0uD0rTnh3GsK?=
 =?us-ascii?Q?WcGLt1S9P9He446l7hIR18Msve2APVAlWkwQk5e3h4N3qvTZ2T373nis492G?=
 =?us-ascii?Q?XWagg/QaAvbztNNappJkEk5o/ptIe9gUMMsV6rmrV1KUSnWfbIab/RA+KIXI?=
 =?us-ascii?Q?R++P8pUldQISXep9xHldEGAWQGkGyWoQ9OlR+naVkBOOU4exv0SiEl6lh/AL?=
 =?us-ascii?Q?rA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F5C6771A8B56E4FA13256167368C38F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fad92d-4b1d-43c5-e201-08daa8bebc81
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 23:50:38.5915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfMcWZg2hB8d/3QEpaqH/vvhYeRHMm1ZRA4wPpCPrucOn3OG3M2VEhSwksP7SYrzYnFKPB0d1xWS+spxPSOihQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6305
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, Oct 08, 2022 at 07:31:00AM +0900, Damien Le Moal wrote:
> On 10/7/22 22:23, Niklas Cassel wrote:
> > Clean up the code by making use of the newly introduced
> > ata_port_is_frozen() helper function.
>=20
> Looks good, but I think this should be squashed with patch 1.

I could, but by that same logic, shouldn't patch 3/4 also be squashed into
patch 1?


Kind regards,
Niklas=
