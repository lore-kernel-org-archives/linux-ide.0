Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB5BC4338F
	for <linux-ide@archiver.kernel.org>; Wed, 18 Aug 2021 22:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7640361075
	for <linux-ide@archiver.kernel.org>; Wed, 18 Aug 2021 22:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhHRWuF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 18 Aug 2021 18:50:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15091 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhHRWuE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 18 Aug 2021 18:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629326969; x=1660862969;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Zi+y53PcNr5fEbWyvL3H6hxy73amQH5Tl+nYmc3e+uM=;
  b=Ptt+S4YEreqw/dRA0kkD+ylR3QVcFX+/W+oZ5ZAmmL+cFa1OjY8DWU3s
   CBs9mKI+8RoOyxqmQyGNC6Nbqqz+6sgnDxHgfmWwtwoI1T6lqBqRX7Yjm
   /PSgyejGWlk7q3+p9Ad7kdIZzm6b4xxsBEaxoXtZNK+u1iiInshujTwLI
   0BRPv/XuKukQS1ahgA/3pMa2ESj6G0o5yFvm6DrX+3RVH4/7hFtQVbtiG
   X8VaxJpD6i2Q/I/mQT9qzjeMLx3TGMDVAO6ThnqxAwfPtGFly1uVQ8Wwr
   b4a65ZGZ5YDUwWQQoSoqJuWzwtP5kwY4w+kiJ1IFhLPlaOJ3nRUsd7BUW
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,332,1620662400"; 
   d="scan'208";a="176857408"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 06:49:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUfbfU7eXUiXacTE/bFp3x+VLDyveUSaQymIvhrylUt/tHasy3Fs7uK59pQn7boL1eJTJjX13s+jbaGKu73X01TCl5VJ/GkHGFOrSx/KICKSTpPwkET+A2ZA427fwUNwzT4xsToluLlSE8dN0rawM6z7XOsuaHhPJG+R6md0xcBPiQlcley7zr+HfGEYSBqMjUKe5bd6kcOKJYhTSLYwhmkvmkxF3ap9vi+wUY2AKrV0KNWPaEpFIeDjk+Mz3Ek1JH1c9IIIrCDPWkFCh89g7VT7GuRlUOx5XwPo4OIqoYD6XP+KbzKBGXnpDXbE1T8HLrxDMa9NLUpLyywd0y8bRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFg0UutNWhttM4g0uR8FGzMz50Obs/xHYmH52ecqtF4=;
 b=LcbQ84Oc+iclYhxl94GbtHWibFseh9gCuMD7xHZMfArvXWpnBRTclpU6WsH/C6pQo116LKktqPY90jQCXVgGpE2dpzltFbjDF8nnhEgKFuMh2AjYiwAsmdUoMShZvzo1GhPcc2JnxkO2XxL3gEKnKByPHQ4V3FTJBmBgbRPV8Gu1yV8UvdgWIt3gxZzJvnV9h3XUXNKiDf2H7tCW2lD1PJgitaaAx6BS4yOihyso9f1jeWqchL2+pqjtCgMUcQku1xnk63TFEDsGvhIfBlrBrDmqn+CpWvbhpSp2403Yapa9wU/xFXIqY/qXljtpZeJOvjfWXApugmqQmW9wfe33Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFg0UutNWhttM4g0uR8FGzMz50Obs/xHYmH52ecqtF4=;
 b=yJ1alb3JJEMY+aiwZIe5RTo+Onn+FjHlRwWIG/h5VZroMMPngx7xtv1Gd0XYRJVgTsnBbVcAeij8DlRTh21b90zSzg5sy+Dj9ULhl0to+bZ8uIiqLgQrQ5qLTXFRInD+D8NPziTtA1VYy7sd5OnTVyR37p7YqulIANQIfwKklWE=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0668.namprd04.prod.outlook.com (2603:10b6:3:f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 22:49:27 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 22:49:27 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Reimar_D=F6ffinger?= <Reimar.Doeffinger@gmx.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] libata: Disable ATA_CMD_READ_LOG_DMA_EXT in problematic
 cases.
Thread-Topic: [PATCH] libata: Disable ATA_CMD_READ_LOG_DMA_EXT in problematic
 cases.
Thread-Index: AQHXkfJ9xwnsD4iI90C0rV5WFPhKfg==
Date:   Wed, 18 Aug 2021 22:49:27 +0000
Message-ID: <DM6PR04MB708177A70A91A19AD7F937F7E7FF9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <DM6PR04MB708117F3FD8537CB6875E2C4E7FD9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210816171543.11059-1-Reimar.Doeffinger@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb7c2bea-c2ef-4c4d-f4b8-08d9629a6f13
x-ms-traffictypediagnostic: DM5PR04MB0668:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <DM5PR04MB06684E48C8E5953F89DC1FD2E7FF9@DM5PR04MB0668.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VMbXkuVLVnICutLe8IEGLALENBXAUCAOcZf5Ueqrymmegmt7XOuDF1WJvMsYDHO2cE42t56/4PvjV76rjW/Xz8D+87vxQe30E50MRem+FQzYQ04VJTEV92ePE3ewE+bTvr+lNr71DDLnC80k4PXhddtfACA9jJ720eJ4zjrwlfw2cSTSzOYXN2aNbNxRAT5EyfsKli8EiWHmwzV8jJbDyHrabVOMIQLX7tlmOmhZLuFr3kEMwsUyRUqSTiacz2uEJwOmBwHyA7A+qTt4Y6v2OlG0tTxK6X1hbxNwJmekL6stu5UwhNEDbsicsRW1Wu5zf1y/uTlQWRJ7QNr4e1MlzPgcXQaT2zLfBs9err1EBqUCZ0jmmmujet39YWixUV47T8/c/F0a5ss4wbcoOLH54AVhGoKGb3C9vnt1HYaDd/gAGa079kdtWpK7erphKKEyb64TW3i/avTbFxSj7qwBfU7RWts5SFrLWiZO6Td1cI+D3M7M9pET4BL06gx0QKc2xpvk9wTAurLOTAjyNte2EzRtTM5bQ4k4YHkAraWE54PSXChZQVF8YOxcUY8jzRxo7BPNzyL0k2yBkt4N6fr2/4+uLU99+ocmIKBM9N+fVUfGJiv6Dwdv01+eEdkvNPy2nXZ3zHzdYUfH7umCgHJqzIViPrZQdMm93iXt6qXdX9eA9+AOb1tT/QGSoWOF/AXE7firIK/bewsZSczKpGBDIb6LMsZj1ZHExsSmgcITgbsWLx6hiDhe2bhEEmA0mS+b8Onim4NqMom3lCtxunZqQAY6sh9mOCCtKR6UpM2QXR4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(5660300002)(478600001)(64756008)(52536014)(110136005)(76116006)(66556008)(9686003)(66476007)(7696005)(316002)(53546011)(186003)(966005)(71200400001)(6506007)(55016002)(91956017)(33656002)(66946007)(66446008)(8936002)(86362001)(122000001)(2906002)(38070700005)(38100700002)(8676002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1NYJFUPQqwsXyk2Hz5YeMuWDo5pbQ2BrGfJsD1LcNj0jEK8fbDIoCYZvKK?=
 =?iso-8859-1?Q?tcUAhEc2er4Eu2CGX541KsOhqQ4BdnVjPLditWcfnoxlHYSlid9NmCM8eM?=
 =?iso-8859-1?Q?8f2xooBPP0tXWkj4zts87cju5dTxYJpEaM9YdkCDjZV5QpnsoEZdKF4NIq?=
 =?iso-8859-1?Q?o70k0fwvAQkF9kcadNO4c38g9CdKA7g99tIfVwRCLpvEzSyDUG/xR37aGd?=
 =?iso-8859-1?Q?2RYGzZe1/nzLOjb6BGvdEHXSuWg2fa+dyt4enQEqTsYeMDucJjn74v4nEa?=
 =?iso-8859-1?Q?GpaprpMvG1NtZocsOqZAyqUBf1YUqbrpp4ZjESbISQzdKFZfgMY9Hbtvxk?=
 =?iso-8859-1?Q?ONaC4r8YuSsfnR0P9X08eR75ZuDRdtcDEffqBqfecRaTIgPSSolZWja5Js?=
 =?iso-8859-1?Q?SPQKEME3FznxfM1/T7jbKHq4AkI8UoOqqA9ybpDWI1lwdxP76DzUXG9eDm?=
 =?iso-8859-1?Q?rfjXTzVo1LQURJSr8C7NrX2FyJGg13gG0nTvRnociA7RT2/INt3fp1Nr1W?=
 =?iso-8859-1?Q?KTt5PgsKtVelOgSvhb5Jf7oJcNkjI6RpqUfpHwuRsq39Z68xiK4sf8Wtgx?=
 =?iso-8859-1?Q?povgLUWmfhWqrR/5FRyLUUgBJfsICBrHy179gGQDrtJXoGQN8L53Ofl+0j?=
 =?iso-8859-1?Q?Xkiy6/s4GujCtr22Ylb08GWtx6K7yuPoGU3KrUL4roreIiadSZoxrriddz?=
 =?iso-8859-1?Q?WWaxAdcyizCBsa9sn8DC7DRdtQ8W8i9fLRYmwEubECunOqs0i4uewoWuwL?=
 =?iso-8859-1?Q?BRPt3MCpI4WkfhYXBY1RAl80ak1get3RI0eZsR0OhWgwKTU3mGujJPj0i4?=
 =?iso-8859-1?Q?Z0llv+KneA57Y2kI2bwkT7dUs1pyMDhDTZ5SgiYWMS+wp9+t4VA7dc1zWN?=
 =?iso-8859-1?Q?cJTf/jyOhjE53yebn5uMLAcPkmlNFJGKeqH8T7VWDll2epZOYNGSBO46CG?=
 =?iso-8859-1?Q?xscusztsMplp38+9roKoIWLs7i0jtmcoRqWz+ER2PV8Tyuxi3W0BdFwCPk?=
 =?iso-8859-1?Q?i6ZSpft7PRbWi1baDPr2ADyGLgq5993g7f2YuwlylXQEBFrwxkB3SmrUJA?=
 =?iso-8859-1?Q?UHXqF2RV7MpznQoYAkPrqUqqtx8cWklk6lzPTyJYnHYmuAIzoz8otXGNfw?=
 =?iso-8859-1?Q?s8k9rR8I1I5H5W0hdfyL5o1WA5+25J+aZcwn8rTq0BD+wFLKK4Boi+J267?=
 =?iso-8859-1?Q?1s3NFJPPVavQLnOM6QzSZMtIOL8PfUgQ4MzhrH5T57g3cIsi654lGEve0R?=
 =?iso-8859-1?Q?FxaJmHIKAt2lutxagUBp/ZpC7CLb5U11tFgqwaDDT3QreWPuCEBrAK7yN/?=
 =?iso-8859-1?Q?8W2NJObkD/beHxWSyiV/WG9YGpUbwF0ZXcqLO18XfQ0twsszNUqLpF8Psq?=
 =?iso-8859-1?Q?18KunAHSAeLhYJgCioKiVfD3ZrITqzml5xK+ze39yLA3+TJjFaqx0VGcZ7?=
 =?iso-8859-1?Q?k+0Ne+yFwwpH268WXhx79NdXU8/pao5vA2zKcg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7c2bea-c2ef-4c4d-f4b8-08d9629a6f13
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 22:49:27.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KbJ7an7NIPzYz7baDpoviG8dI6SyKEJiB4hxnhYSjZc99lru6qgy6et65dd4e0woznEYS9hvY3AvsCgyvsIDNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0668
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/08/17 2:15, Reimar D=F6ffinger wrote:=0A=
> The ATA_CMD_READ_LOG_DMA_EXT can cause controller/device to=0A=
> become unresponsive until the next power cycle.=0A=
> This seems to particularly affect IDE to SATA adapters,=0A=
> possibly in combination with certain SATA SSDs, though=0A=
> there might be more/different cases.=0A=
> Comment 5 of https://bugzilla.kernel.org/show_bug.cgi?id=3D195895=0A=
> is an example.=0A=
> Disable it by default on Crucial MX500 devices and all=0A=
> PATA controllers.=0A=
> Also add an option to set the workaround state, which might=0A=
> help with gathering more data on the exact devices/controllers=0A=
> affected, and speed up narrowing down the cause for users that=0A=
> are affect but not covered by the added quirks.=0A=
> Existing workarounds like forcing PIO mode do not work=0A=
> (in addition to the performance issues) because READ_LOG_DMA=0A=
> is issued even if PIO mode is forced.=0A=
=0A=
Please drop the dot at the end of the patch title. Also, it would be good t=
o be=0A=
more precise with this title. So may be something like:=0A=
=0A=
libata: Disable ATA_CMD_READ_LOG_DMA_EXT use with PATA adapters=0A=
=0A=
Also, please add a version number to the patch so that reviewers (and Jens)=
 can=0A=
keep track:=0A=
=0A=
[PATCH v2] libata: Disable ATA_CMD_READ_LOG_DMA_EXT use with PATA adapters=
=0A=
=0A=
> =0A=
> Signed-off-by: Reimar D=F6ffinger <Reimar.Doeffinger@gmx.de>=0A=
> ---=0A=
=0A=
And add the versions changelog here. Something like:=0A=
=0A=
Changes from v1:=0A=
* Change 1=0A=
* change 2=0A=
* ...=0A=
=0A=
>  Documentation/admin-guide/kernel-parameters.txt |  2 ++=0A=
>  drivers/ata/libata-core.c                       | 14 ++++++++++++++=0A=
>  2 files changed, 16 insertions(+)=0A=
> =0A=
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt=0A=
> index bdb22006f713..191502e8fa74 100644=0A=
> --- a/Documentation/admin-guide/kernel-parameters.txt=0A=
> +++ b/Documentation/admin-guide/kernel-parameters.txt=0A=
> @@ -2551,6 +2551,8 @@=0A=
>  =0A=
>  			* [no]ncqtrim: Turn off queued DSM TRIM.=0A=
>  =0A=
> +			* [no]dmalog: Turn off use of ATA_CMD_READ_LOG_DMA_EXT (0x47) command=
=0A=
> +=0A=
>  			* nohrst, nosrst, norst: suppress hard, soft=0A=
>  			  and both resets.=0A=
>  =0A=
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c=0A=
> index 61c762961ca8..9934f6c465f4 100644=0A=
> --- a/drivers/ata/libata-core.c=0A=
> +++ b/drivers/ata/libata-core.c=0A=
> @@ -2399,6 +2399,9 @@ int ata_dev_configure(struct ata_device *dev)=0A=
>  =0A=
>  	/* set horkage */=0A=
>  	dev->horkage |=3D ata_dev_blacklisted(dev);=0A=
> +	/* Disable READ_LOG_DMA with PATA-SATA adapters, they seem likely to ha=
ng */=0A=
=0A=
Remove "likely".=0A=
=0A=
> +	if (!(ap->flags & ATA_FLAG_SATA))=0A=
> +		dev->horkage |=3D ATA_HORKAGE_NO_DMA_LOG;=0A=
>  	ata_force_horkage(dev);=0A=
>  =0A=
>  	if (dev->horkage & ATA_HORKAGE_DISABLE) {=0A=
> @@ -4000,6 +4003,15 @@ static const struct ata_blacklist_entry ata_device=
_blacklist [] =3D {=0A=
>  	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },=0A=
>  	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },=0A=
>  =0A=
> +	/*=0A=
> +	 * Devices with observed READ_LOG_DMA issues - unclear if only=0A=
> +	 * specific firmware versions or only in combination with specific=0A=
> +	 * controllers.=0A=
> +	 * Specifically broken combinations reported=0A=
> +	 * CT1000MX500SSD4, M3CR020 with B350M-Mortar=0A=
> +	 * CT500MX500SSD4, M3CR023 with PATA-SATA adapter=0A=
> +	 */=0A=
> +	{ "Crucial_CT*MX500*",		NULL,	ATA_HORKAGE_NO_DMA_LOG },=0A=
>  	/* End Marker */=0A=
>  	{ }=0A=
>  };=0A=
> @@ -6104,6 +6116,8 @@ static int __init ata_parse_force_one(char **cur,=
=0A=
>  		{ "ncq",	.horkage_off	=3D ATA_HORKAGE_NONCQ },=0A=
>  		{ "noncqtrim",	.horkage_on	=3D ATA_HORKAGE_NO_NCQ_TRIM },=0A=
>  		{ "ncqtrim",	.horkage_off	=3D ATA_HORKAGE_NO_NCQ_TRIM },=0A=
> +		{ "nodmalog",	.horkage_on	=3D ATA_HORKAGE_NO_DMA_LOG },=0A=
> +		{ "dmalog",	.horkage_off	=3D ATA_HORKAGE_NO_DMA_LOG },=0A=
>  		{ "dump_id",	.horkage_on	=3D ATA_HORKAGE_DUMP_ID },=0A=
>  		{ "pio0",	.xfer_mask	=3D 1 << (ATA_SHIFT_PIO + 0) },=0A=
>  		{ "pio1",	.xfer_mask	=3D 1 << (ATA_SHIFT_PIO + 1) },=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
