Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38187EE14D0
	for <linux-ide@archiver.kernel.org>; Wed,  6 Sep 2023 21:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbjIFVyb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Sep 2023 17:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjIFVyb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Sep 2023 17:54:31 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD62CFD
        for <linux-ide@vger.kernel.org>; Wed,  6 Sep 2023 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694037267; x=1725573267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2KUNA+woMbPrzLlPX5NLYpVIcy91GA2EJ+m+8gD4wSo=;
  b=Irx9wnd0/eL0kOhxEfTS0GEujcoQ/4gkZhyosg+PGIazA+NQHJvhjrSk
   9n49VZkQtLpg2j6goS1qOMOIuSYt/e49s+YLe3V6qcSOORPWdrBXFa6oO
   gh/n4GAhAux7MoKowPAUxm2y2AxiZfYNb9X1rlf1PeqJKyOrpyIdnhJ0L
   PQHNeSHFd4SnZqmeSSAOc4JyU6jP7vtYiVgz2VylpwRUrMKyvqfZnczXe
   NnKkEtnpYU79X5xy0o8ut7FAIZofRiabxWNsn5DHRIY2j+ke8RpFduFGd
   zmmImfXWdMIQGkCHLujWOP8r0OmqFiVSgNKZVcKrUryEcfIMKu37Qhzk0
   w==;
X-IronPort-AV: E=Sophos;i="6.02,233,1688400000"; 
   d="scan'208";a="348442230"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2023 05:54:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ylv3Ha8VfzryeDe4MLWw2p6o5cid/i5t1jy9A4gWaJwBE3/3jhqecmDzpWeXeUOV8pHtnGWTzuKJ23pF0J/UUKffFVb7Vg3WjMrMH17tMJ2/C2AgIRaP2jp4kvrLnW7dltpkEDC+hG7ZLfPJqMN2yhBdWGF/Uq4NEJCs4DBZFgz7bO41koEe4l5FW/l/I7bn7Rio5Rr7+gqX4Tyr+RjzLBlF73U9Ckst7UD8jfEYzOBYUymW5tIkFr9sbA+7EsLM+O8J/BhcqSLEx4ALWhvlyiohfWteqi6Q11qVH+rkrrINb3ssFikEI0hjT/hshOTVnocwIiaLHQ2MrJDod2954w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0KghvdZvR/xxRFZ95T3/GlkjNnYgvjtMV/+dUMp06Y=;
 b=njHzPHtxCh4Bqnb5oz7or5xj7y0pfsSVsgKTa2ADCpLDf73r9ZBYVs+TQKB89rhAXigC7YlTxdnmpwfJB/94PdYVDZDiVsHengWyujDGGCSUFAm/JY69ECkh1S3egpRQyP9sG5NxuNtVk0AACfV2DRwDH3VxrP3Xlak8QqDWuYqMvzIRA3h9Mw+XDhA6/CtZEEzKP6OZnNTamIOe0VvZjomtkD4Mx3eIiBmiGvtKiAQW/bAoPeBmoFfAAMR1XP6mDBoL1j1l7PL9+cJs/BTkXQTUUd6DB0ASeum4iwwCpNuz11WQKqxGLOYcjOZUJRe3E7J3JL8DFT6fYRR8Wt1QvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0KghvdZvR/xxRFZ95T3/GlkjNnYgvjtMV/+dUMp06Y=;
 b=GybvFSeCLfnYgcjcC5RhmYBnjcF17oK0ZfN7QCUXIFyS58pvxxJFuEvgBzlfW/bDs0xrb4+mt+OH8cKimZ4wcY0HHt/Aq3d7f2/BqUSTJuEKnwe4hHjuwzffC/BE+F3t+YAzJ1V0f7eViO6K6ygV0bxahWfG6+VDlEme+qUnXUI=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH0PR04MB8147.namprd04.prod.outlook.com (2603:10b6:610:fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.28; Wed, 6 Sep
 2023 21:54:23 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.024; Wed, 6 Sep 2023
 21:54:23 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     Niklas Cassel <nks@flawful.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH v2] ata: ahci: print the lpm policy on boot
Thread-Topic: [PATCH v2] ata: ahci: print the lpm policy on boot
Thread-Index: AQHZ4KPGClbA7n6pj0S5lBscMe+mmLAOTg8AgAAKC4A=
Date:   Wed, 6 Sep 2023 21:54:23 +0000
Message-ID: <ZPj1DbU5p+5Wzvds@x1-carbon>
References: <20230906092232.3396200-1-nks@flawful.org>
 <8413f930-6fac-d4ae-903b-570d9acc9dcf@kernel.org>
In-Reply-To: <8413f930-6fac-d4ae-903b-570d9acc9dcf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH0PR04MB8147:EE_
x-ms-office365-filtering-correlation-id: 6d916483-cbad-474c-f88a-08dbaf23d4e7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZiVdkmuIAd6XWOkx48F5pvcMUMTyjYtdmUQolugIl6IiKawaJKUSa8l2VZNPJSQbrQa/bbCE508NR2un1vT+XxKVqYOVOrKHuebmfi/K5Vnfsu+/m3tFHXJPlozNfmckMCl6lPb29FfOWkaNMPvpg1f0OLTVXjOoiw6EoWJ4Bqyo8CQKwwZ6rH/scXDla62kyJjOK5UTUHr9r+qKRFWaS/j65AyROPBUYaovct70CJ3zf1nhUbm3t9Hm3otQgf3cY7Dx7lKZXV7gUXWNI/4Mr7PxXztC+hXV7Ed4fKZ0+kAKXhwvT01QIgkYLshL3vgZb5jo+eHYAzzusO6ddtNMNUFM4HTslzbP4poImC1Z89/8RZdf7xb+Wi9yfKHLBeAbkIj1NjhSV2sl8DMu/iW7MGvADTGNBlw9I2eBitds/afj0aRzOQqqdkdZnatB0rNwlkcXcLJwY5WjzvOhc/AhFy/jR2etXuJLasaFLMzZZg/OwvG+V/z2LLSzOPA5sXq+beeTv/0birD3D64VhIsFBKBojXCI+qybeW5cdOuq75j/scAj/zV7yxovaP46m2dAVinNnhbC39OpiFcr9lwSHFSetgi0A5cL0XyjQzWZNf9RS/iXmnetdO3q8IjolSawoJ5PfJSR3L0XY3XD/RPIzaPTimkImYSvwDuSjK7SRrY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(396003)(376002)(136003)(39860400002)(1800799009)(186009)(451199024)(122000001)(82960400001)(38100700002)(6486002)(71200400001)(53546011)(6506007)(9686003)(86362001)(38070700005)(2906002)(26005)(6512007)(966005)(83380400001)(478600001)(76116006)(91956017)(41300700001)(8676002)(8936002)(4326008)(5660300002)(64756008)(316002)(6916009)(66476007)(66446008)(54906003)(66946007)(66556008)(33716001)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?78gqoaDDhS3WFVnWcwo8JXb0LyVJfj7WtTMPYLPFuXMWmdmueyAQQakgg3Cl?=
 =?us-ascii?Q?5Q2/7zkQ+JDz2i/So1qmkeFiSTLyhrlYY3EwWj2j6xhRthcVhRTLgV6ziGiZ?=
 =?us-ascii?Q?lcZ1F1YB50kWojXVTVhW1ezxgE7ZF84ib2vsfJr8HDgKrsqONRAmcI3A7kSn?=
 =?us-ascii?Q?2oB8h0S6Jz6Rbl84Gw8afqXI2pCMQ6NVZYZsJ8kpGI95fmvCFw9kr2UlZd9C?=
 =?us-ascii?Q?3qACAdUmNwmKvOAHAmA+Vqexv7vFWpvpPzEgwgg0JnA2lvYNYKdQuzhyHvB0?=
 =?us-ascii?Q?iDCw+Z6kYKfWaIFflkPy6CzFv+Nl9xOxujRx4Q6tACnR1jfQoL8LPjFASQHe?=
 =?us-ascii?Q?oeQclZTfGQ0fwFHZkuH/tU4wi+cefuUwDaBcwSuDmpHXcgnK8PEvxzvKjw7X?=
 =?us-ascii?Q?GS5ZktzR7Ut+NwFHibFsCp4AGs+tzonvuHy3kCFr1jbKLIf+RmN3WtmmAtCq?=
 =?us-ascii?Q?P/aUMG976utmb2Ya8NpLCXmy+abMVuuUVwf3ceAWMjpk1ppI4vO65a1RQxq+?=
 =?us-ascii?Q?MEVhWESYgmyucUOFhQgH5vz3uEdt66P8NECn2kXB6mZTROFydKdoiWM5phPt?=
 =?us-ascii?Q?hXwpozAo+veXhh3iL+wKDDK0OAjLGfSkFEoz9b1D46Kb36iq5CoK7+//g8us?=
 =?us-ascii?Q?ExMzF6oYJI68+yoRkJLzziyBM09WpiDxd+SeO/u142cpAWwGHaT43ZIPKovz?=
 =?us-ascii?Q?wNv1nwKuFmVOLJQx+02E//PRu3Lh5eDHnLP34D3MrJ1bJeXG/MUJOLe5u9jh?=
 =?us-ascii?Q?2Mhh5RaShzrZL4YntBEgDeP9gnUrIKiNk616RXciDgX2s8psk9nOSDKwSzab?=
 =?us-ascii?Q?z7FOYEYDcmTCcCkC+iiWZFvT3b3eg+UkW1ONpEdhdWri81mnd6nv8ixoSgxr?=
 =?us-ascii?Q?11uFsGx6iDkzRi9Rm3Iknescc7jd/riM07tdiwFBTQWpwofxiqEeFWfpeqG7?=
 =?us-ascii?Q?Cf4+hGEdLzl/6xJfeuMiwWwH8H2XrhjKlKWiSenIWwZEgCJqQxuQDirZ4uC1?=
 =?us-ascii?Q?SZAQ9EUznmm/tv4dyul0qa8TZ6+V/MRmqUE/Ud2hd5AGFh4IuIsPEgMPTwNC?=
 =?us-ascii?Q?OVWL2yXjAexft5+mLnW7ukEV6dUpCqIF9yMdJlORA53Nx1kKQ+Pb8ubsda0u?=
 =?us-ascii?Q?m37+JeSd/FYgGPiTuvMaPHgUmxosEMVD7qCDXj/5qHNL9JS2IiG1XF5rqxf3?=
 =?us-ascii?Q?x/v8hhE/e6v7lN71ymns1J6DE2RnM09mP3WzjN3WtrrHriI/zH7C8FbrxsG/?=
 =?us-ascii?Q?hPEhpY24aP2+lP7hrMda7tMyzFQ05wsiT5rEtngYJA6dQjUpyysv2DA4Yja8?=
 =?us-ascii?Q?euoeS6H+PnTzz8Wi581Y56oaoEq8n7M6NA7sjIswKaQ+FyOgdXXz5UTioHsq?=
 =?us-ascii?Q?HS911XwCZwfzP952t4hSzoXwZCIjP6DtqeK4BJ89YaDJKUGTA7DG+6sjGJE7?=
 =?us-ascii?Q?hm++I1I0gFrvILge3maZ4mKthERx9xXIO1YKovAYRMkOOuw/vixUcJe8flvL?=
 =?us-ascii?Q?iZXgWSkXqI10OPjys32b4HCR/3IZ3fViFyGSHz5KX4If6Qw4c97CpjdZdSoJ?=
 =?us-ascii?Q?EQ9bDcat24sB/4WNMHBWOdi36mcZSMmNpU+cGhV1FPuzFdqBq/zQ044AWd/R?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <381E5F104B51804E9B3DDB2F8E5C6D1A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PKWjGE0sTeZsuhhBrfIdn3LhjvQZjj0palIkXtjqgjEtv7HAOxrWpYOKsWomUpjFpV/zJ5oZ8iUJ9eVLzSEqVSUHWQTzhQo1+zFJ3gVP+LhBr0VIZ8DAfJpop4uXHIqjaS8tm4hjte8LAoXYD5gaXbRWgwy1m1DyCHZl3ViMlOH5AeX2h1Cmeym5M1jEaF9RF1ZmrEkKya8ctJySLI4qWk4D+7agZxRBcY/25VVmoiKFqLOlMhHl2PInDEA3IbK0954o7gWMT1mzBkHRQFo4vd2pwGhsUhGE7kQHqEtbGj2UKhwkHJpfjcKvcwrebzc0+xBKAg60vGf3M9Lyu2KWd6YAgUi29rCSVUh+cRs4xe4EbeLybkBKn8uDBDEgSdKMZ080j//93T5R1Whg0anV9Hhyz6+nf4Gsb0kBqDNC9uJ9zusp1SGQIFO0j9nKcqiK9afjffw81XUbxmgXWtzEA2H25YSparigYZ2tUjlmsIV0+hBjAgMJTeSu1IP2lTmI9Gg+AVvl/bbBXw3i7SFhmranhFNbXVc5psXAaOD/iupmULCYrXblfKn1ytc2swpLjZqMAH+IEne1hrv5I1Jk3QRsvgyOOpTJ4Fsjwdv+Zt82KsYahm+BMyFPtFim/3/Tmf3AwPvDP50Own5RFJiKb0QYIIU6p79HMwsLsWmExIS7nXCVrRxkB3lyhoo10prFTlXCK2bkM0zcmYLZDTAQjiXVLxvPQi/woov2LwFy5DfU//CFHOKnzNkYNrcGN/8RhApPi3btQjnlWzshaKbg2YmL0j54cTCKOhL2dk2TPnv4co+Yi2N6dBojeM/VizCNliXx5k6ascII/rFkt++trQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d916483-cbad-474c-f88a-08dbaf23d4e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 21:54:23.3199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oV4SF9BZXk5JoM5iNPoGKe7FVSN2uOyU6JB1UO3JKhkgAIkJz6sMN/GOFLho7myvb9J5CcNGo1ENJP/+42YDLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8147
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello Damien,

On Thu, Sep 07, 2023 at 06:18:24AM +0900, Damien Le Moal wrote:
> On 9/6/23 18:22, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > The target LPM policy can be set using either a Kconfig or a kernel mod=
ule
> > parameter.
> >=20
> > However, if the board type is set to anything but board_ahci_low_power,
> > then the LPM policy will overridden and set to ATA_LPM_UNKNOWN.
> >=20
> > Additionally, if the default suspend is suspend to idle, depending on t=
he
> > hardware capabilities of the HBA, ahci_update_initial_lpm_policy() migh=
t
> > override the LPM policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or
> > ATA_LPM_MIN_POWER.
> >=20
> > All this means that it is very hard to know which LPM policy a user wil=
l
> > actually be using on a given system.
> >=20
> > In order to make it easier to debug LPM related issues, print the LPM
> > policy on boot.
> >=20
> > One common LPM related issue is that the device fails to link up.
> > Because of that, we cannot add this print to ata_dev_configure(), as th=
at
> > function is only called after a successful link up. Instead, add the in=
fo
> > using ata_port_desc(), with the help of a new ata_port_desc_misc() help=
er.
> > The port description is printed once per port during boot.
> >=20
> > Before changes:
> > ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170
> > ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170
> >=20
> > After changes:
> > ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170=
 lpm-pol 4
> > ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170=
 lpm-pol 4
> >=20
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> I am confused... Why not simply:
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index cfb5e6bd03f7..194cf4fcb9bb 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5945,6 +5945,7 @@ int ata_host_register(struct ata_host *host, const =
struct
> scsi_host_template *sh
>                                               ap->udma_mask);
>=20
>                 if (!ata_port_is_dummy(ap)) {
> +                       ata_port_desc(ap, "lpm-pol %d", ap->target_lpm_po=
licy);
>                         ata_port_info(ap, "%cATA max %s %s\n",
>                                       (ap->flags & ATA_FLAG_SATA) ? 'S' :=
 'P',
>                                       ata_mode_string(xfer_mask),
>=20
> ?

If AHCI_HFLAG_MULTI_MSI is set, then ahci_host_activate_multi_irqs() will
be called, instead of ata_host_activate():
https://github.com/torvalds/linux/blob/v6.5/drivers/ata/libahci.c#L2755-L27=
58
so that is why ahci_host_activate_multi_irqs() is also updated.

ata_piix.c implements .set_lpm:
https://github.com/torvalds/linux/blob/v6.5/drivers/ata/ata_piix.c#L1108
and calls ata_pci_sff_activate_host() to activate the host:
https://github.com/torvalds/linux/blob/v6.5/drivers/ata/ata_piix.c#L1746
so that is why ata_pci_sff_activate_host() is also updated.

The only "unnecessary" update is to cs5520_init_one(), which is a pata
driver, and does thus not support any LPM modes. However, in order to be
consistent with all other prints (drivers), print it there as well.
(This specific driver will always print 0, which is technically not a lie.)


Kind regards,
Niklas=
