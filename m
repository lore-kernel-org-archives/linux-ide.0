Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FA8C4338F
	for <linux-ide@archiver.kernel.org>; Wed, 18 Aug 2021 23:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87A1610D2
	for <linux-ide@archiver.kernel.org>; Wed, 18 Aug 2021 23:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhHRXbZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 18 Aug 2021 19:31:25 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64570 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbhHRXbZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 18 Aug 2021 19:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629329449; x=1660865449;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RqK4RL1c0FGbrDE5+rIxhCeohKGW/QF3K7tVestZqwg=;
  b=CQndFXy2qakMFPzcLAeC0YXHo2uOI2WTbBpuGswnY7cyskBbxY6+K6f6
   XdilrxMFfbKmT67yaB8oUFUGGHZmIbeaO5D5uk02YwcG52hACuGwWZqMu
   7xfnG1EQT0/7R3k/gZ0oXWIXG+63tWceyXAuGDzxshzg7526xDzgmvdyp
   qGQkUVjEPjNMX4p60wYgpGSzaZWuZ2hLuvM2cqZJrpRlmmUCDd2r1EW63
   Lic/CYFTnezE8Ul53cUaJDHAKRQ43MMB7/4caSeIaUryzz/K0MhL6Q7+t
   hygMCGGdJv7/fyeO/GNSXG8ZUwkzFkCHizgroXKttYhuk/VfLHpcimrDm
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,333,1620662400"; 
   d="scan'208";a="289291740"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 07:30:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MA7zFCaerg+9yPV0EeCE/kwQpOMSpE7bepi2+qCAFlkG1kStiMcQ07FaNeK/jPyYffmxlIsjvtSXwMN/NMsFZURSZSTKFcCLVgkZtnC9mtIS149AbSoo7G3Zui75mWvBirYKfsRWnilYftD8k5f3VcE4IhjJYR64KnDuZAlwmllfdgvvTlrw4HTbvG1ZKkQEd66BqECUOvg3nN3s9u/ahHrFfO4knSbgf2hunepoYBVKRZjyM7VLboqRGDzbg2d/UYk0N3UQHo21wIsrcjD2JBpgiscB6wGbFLVQUALY7erHl93n93yp/DBCdSoYc93Xh/gQu5rJhkMirGvkEuWYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5T7SC4/agMGP5IRxac/6/XJOz4WG8M/8ByWLsqQSFLU=;
 b=admPwvy0szjyzDCxcp6JVauPteNuNq48DUaQhYRiaPiozfFDDLfk2YMt5fw/tisQl3CinC0XukP9Fl2fKobR2QigFEIERtexDnQG3kERevyLH5PRgA9IbCUtOX9l2HV7wXoJRyuTRKl+KMzryi3G/MJGH3Y8EGNNATsfeijX46o+cw1YeFO4Wh7UxFoQvOJ8npa450ZtRJumZ8mCjc/Wmkl1TXhuFHZ859783uVb3YiwXpy1nNDSe9PC+498WBow6pGLChz39AHYMF+Kmpzxjknribw5OSZmOPFudnEieNIZ+C5et9QPKCFA/FWl55m+y+2raYXQqMc7o/gTFVhllw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5T7SC4/agMGP5IRxac/6/XJOz4WG8M/8ByWLsqQSFLU=;
 b=rLgrPgQvubDuckRjSmYIk2c1XdLOi49Xsn7dDvTiIy5pXrA1XncpzcZY/d6DU68J/WQa1T8O6fgIYCGwNqL3g0+PPW3UjQuvxc1n5nC9zgZmOl7GXm2OKsyahuAzYMbGhH95zKLojSe0W+On0uFK3WCrRr5y6V7oSOKzZ+yNNgc=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5996.namprd04.prod.outlook.com (2603:10b6:5:122::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 18 Aug
 2021 23:30:48 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 23:30:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Reimar_D=F6ffinger?= <Reimar.Doeffinger@gmx.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] libata: fix setting and checking of DMA state.
Thread-Topic: [PATCH] libata: fix setting and checking of DMA state.
Thread-Index: AQHXk5qM+2uSnfpxi0Cce8f2xod5SA==
Date:   Wed, 18 Aug 2021 23:30:48 +0000
Message-ID: <DM6PR04MB7081AB7034F116CDFBA43890E7FF9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <YRv5cafgitLlfiCs@reimardoeffinger.de>
 <20210817190308.29065-1-Reimar.Doeffinger@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24007724-19e9-4a23-bc4e-08d962a03590
x-ms-traffictypediagnostic: DM6PR04MB5996:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <DM6PR04MB5996C2BF89C68DBA10A8F175E7FF9@DM6PR04MB5996.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zzvsO2ufLwfAxWgFkdhY1KtianNn7F1IDxqf32wfNjciYjjCwEMPcvRAcuMf2P0pwtW+UprCsCuUzh56QbWGeB0bTd+0tcjiLJZB11k0tILYtoItfLmUCrkZc08BoqKQReuBEw5iOAMVszq1Rv39Zh3dLN2cSizz3mDlxotn1yawfl64T37fEC9wApvyZM6sHVwfxp1EChIbFxfIo/IVgvkm7WyEkt4WK9KUFnysQmLEHkor82G+6u5kBeH4TFx3SaKw3vvcy85PmrxuswvjId32U14SQo+0TpYwcxyCQQ/+0UUgPY0OsgeR8qxg4RL0J+fx8d3AmTQitgA3Y0wk0MDOR0dVvAHNHV1bYrHweJc7nqAUiQTV0HA2jqVZl+ZTuRwqJmVDSFT2Cc9K4zhtsZmxTFALEzOUFt3BwoOUhCIBdq0pIW7CfGMxhuWWDRl3M44Z9drQB9I2CHpPPoWWXRdO/7voN5QZ7it7fl6VyGQxTdsYrqOpebN6hPZFQPz4RVpj8+ei5kG4egAEe8seNw5jJa8FaSlU4X9ox2Tc7h4Zpp710BVZ7bpxddBx5JqxAWGkOlKUnoaXLWuLApLNSg50cDYLn9wPbAe+FHGemTme1nmEzGAvtaHQSe0AGcweCUbXDiloR2B24y1PtEbdKQiXmJJJr8zFcf5Cw3FtfOzmodZ/NJiy50r+CnHIpIcVko+hUPZD/FvsEtxDg9bKfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(316002)(83380400001)(66574015)(86362001)(33656002)(38070700005)(38100700002)(55016002)(71200400001)(110136005)(122000001)(9686003)(478600001)(6506007)(91956017)(66946007)(186003)(66476007)(66556008)(76116006)(66446008)(52536014)(5660300002)(7696005)(8936002)(2906002)(8676002)(64756008)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bbWT2o+1DUDx42yxdkiSyVRxgL+zoO5FAQHsNMn3jK4Ut93brzavrrNcgD?=
 =?iso-8859-1?Q?OHv86PloNrvwyRbsfzeW+ikA8MfGgsImSlJtlLbDgRdhtfIQa30M6Hm9Lw?=
 =?iso-8859-1?Q?BzO9pD0axzmBwQ1DVwrlsCfh4vcXZmWmpYebQuM9gG6CXNJT1LgnvvXPxi?=
 =?iso-8859-1?Q?IpietdONibchfj8x1RR1ZFBAA5hrXHHrDzRqo1mjD+U9UQLS6mklHd1dAp?=
 =?iso-8859-1?Q?bex/zjbfr9biz0sDLBM5Xgbq+AxrjaJfq6yfNKyRPozALq6GYMYnQo00S7?=
 =?iso-8859-1?Q?hIqAaU2PQTr5DNKp4NocWiEYSKi9BOrP2ai7rfnRVRUgIFGcXs4CqTetkm?=
 =?iso-8859-1?Q?jOswzTh5ZGfMHMdeda7OySbd45OTur8AbbKJpfcbvpEMq5Dlcj7vc2OxJy?=
 =?iso-8859-1?Q?Lr2o6Q1OdmUUkmIOiz5PU2XKJmcIBZNynU7UED+C549BdWfA8W1GaZo2bX?=
 =?iso-8859-1?Q?vTCrGfQYpszXRmxi/1geK1RKhyr7RzxrL3GDANynKlH1PwaZoeQxFOrAQz?=
 =?iso-8859-1?Q?AhqVmSQAZjkXxl+K/K9srd8QKS+I3FFQWkpha4B3dZBF2sSyaHmNGn+YNl?=
 =?iso-8859-1?Q?xXfVtdvZ/GvNoo7faVLyNKbKngh0lHjdz4rjrtsq8N5ZP0oi5++V9ztzok?=
 =?iso-8859-1?Q?RBG9owpNth61myo/Yjn0A50w+bGvd/9EKgiJaNfu6xESu8pHmwmAxU6WX9?=
 =?iso-8859-1?Q?9yoUBXdSWNcQTyw28vGw+r3hRWf6i0dn03UY8Uy0LiTXUp3UuQnMA0lIDA?=
 =?iso-8859-1?Q?nEr8ZNAfkvFqkl+aY/MIg1u7/eWRjtcsGD2UTRLKaVoFyNqWgKmb7fpMrC?=
 =?iso-8859-1?Q?NLrxLFVaaAOKwTOS8/QoR8B6w1qgYri1fBuiJcFIUVyo6EnaKp1o9hLEHi?=
 =?iso-8859-1?Q?5vN1OyHv7ny0SgQh/kPL8p68A7Jq+taV2UAGCPo75P6AwIWvyUo6qQzMsV?=
 =?iso-8859-1?Q?ZSg6NKKBc5UkzhFfGvsl6zDidyifX4SP4P0Ey6pBzvRZHRul/bRnB+eUYv?=
 =?iso-8859-1?Q?XGQ585HjcS4AnIOnHcYyFh5+2UPQhpB4pJp0qbNE9wlzCL9MnZl6ecJJgm?=
 =?iso-8859-1?Q?yz2OoTn4U/eri36PzatkvLZjIbjXpW7kUp+9gryd7Sb+jp9aGJroq8a71G?=
 =?iso-8859-1?Q?0ws71O8FVeM8fOVU99ju7ueInj1ppGrlLmp7KLKdm9zf1aEXbocFmTlrCK?=
 =?iso-8859-1?Q?Twrxw/fds1f2TPztP3Sx8zrLSm8fd8P6siGxWCn0pL7xXkVI+rfWB+drK0?=
 =?iso-8859-1?Q?hv9NnwZIU3h+r1RGO7zmw3jEQer9rw/0aqJGgAmaUxrkF93S7gS957u+jx?=
 =?iso-8859-1?Q?LLVgxj0ZupFbn7zDJl7A6uYfVZRxYE1/FzrBN3SGgkSp93vztRr9CxtLms?=
 =?iso-8859-1?Q?JU0j6pz1brCP1vn6L8vPUd2DPFAqGmGnDzhihT9dMYv5/UjzvQmjqp5XTC?=
 =?iso-8859-1?Q?KndT8YsxENqf0i+GwdCo/WYPNQ/h3IcD4Jmd8w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24007724-19e9-4a23-bc4e-08d962a03590
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 23:30:48.1846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ciuB/ieII3XNdl3+3jRzv8kcBbnJZ6/JUHVra11QkGtudNHCeek8sQVdsvY2rXcGf+BIMDiFXSXXEG14xFyEIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5996
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/08/18 4:03, Reimar D=F6ffinger wrote:=0A=
> Checking if DMA is enabled should be done via the=0A=
> ata_dma_enabled helper function.=0A=
> Update dma_mode initialization so that SATA devices=0A=
> are reported as DMA enabled.=0A=
=0A=
Please drop the period at the end of the patch title=0A=
=0A=
> ---=0A=
>  drivers/ata/libata-core.c | 4 ++--=0A=
>  include/linux/ata.h       | 1 +=0A=
>  2 files changed, 3 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c=0A=
> index 9934f6c465f4..a5fe20bb22d6 100644=0A=
> --- a/drivers/ata/libata-core.c=0A=
> +++ b/drivers/ata/libata-core.c=0A=
> @@ -2004,7 +2004,7 @@ unsigned int ata_read_log_page(struct ata_device *d=
ev, u8 log,=0A=
>  =0A=
>  retry:=0A=
>  	ata_tf_init(dev, &tf);=0A=
> -	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id) &&=0A=
> +	if (ata_dma_enabled(dev) && ata_id_has_read_log_dma_ext(dev->id) &&=0A=
=0A=
This change is OK I think. Note that there are many other places where=0A=
dev->dma_mode is testing directly. It may be good to check those too.=0A=
=0A=
>  	    !(dev->horkage & ATA_HORKAGE_NO_DMA_LOG)) {=0A=
>  		tf.command =3D ATA_CMD_READ_LOG_DMA_EXT;=0A=
>  		tf.protocol =3D ATA_PROT_DMA;=0A=
> @@ -2824,7 +2824,7 @@ int ata_bus_probe(struct ata_port *ap)=0A=
>  		 * bus as we may be talking too fast.=0A=
>  		 */=0A=
>  		dev->pio_mode =3D XFER_PIO_0;=0A=
> -		dev->dma_mode =3D 0xff;=0A=
> +		dev->dma_mode =3D ap->flags & ATA_FLAG_SATA ? XFER_SATA : 0xff;=0A=
=0A=
This however is not OK I think. You are setting a transfer speed without go=
ing=0A=
through the link speed negotiation.=0A=
=0A=
>  =0A=
>  		/* If the controller has a pio mode setup function=0A=
>  		 * then use it to set the chipset to rights. Don't=0A=
> diff --git a/include/linux/ata.h b/include/linux/ata.h=0A=
> index 1b44f40c7700..7bb2c2acbc42 100644=0A=
> --- a/include/linux/ata.h=0A=
> +++ b/include/linux/ata.h=0A=
> @@ -374,6 +374,7 @@ enum {=0A=
>  =0A=
>  	/* SETFEATURES stuff */=0A=
>  	SETFEATURES_XFER	=3D 0x03,=0A=
> +	XFER_SATA               =3D 0x48,=0A=
=0A=
Where does this come from ?=0A=
=0A=
>  	XFER_UDMA_7		=3D 0x47,=0A=
>  	XFER_UDMA_6		=3D 0x46,=0A=
>  	XFER_UDMA_5		=3D 0x45,=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
