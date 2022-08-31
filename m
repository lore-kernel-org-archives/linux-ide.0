Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6601EECAAD1
	for <linux-ide@archiver.kernel.org>; Wed, 31 Aug 2022 10:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiHaKLL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 Aug 2022 06:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiHaKLK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2022 06:11:10 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B636B14F
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 03:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661940667; x=1693476667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3QBO2FFPi2rGqMk3tiDzPWam2F8QvML3XwNnv+lKmSw=;
  b=a4QT0JhQPz9bFMa3cZuRuYfq0V4es4fJioju8IueRDhTR3BLclBuIbA8
   E1dNt9J1AotqQllDpXIDyz8QBHebtplWuNS8JaYFZyFu8yIg9CZeg9dHT
   zy6K7BbGQxobUKc5TLgq/y6d8AzE1Ez/Lykv9VU9P+5hRfX6FB7PBSHIW
   oOTelY2cAQb+6QmOz6Vf06MmT/KdWbzw/s5J7ySIHQMvWqdzOKxGzCnPY
   yag7O1rfhiiBW/8P5SRKCTGidHKGubgOO1gvQdpEvYO3Z6aFVp4Skpi9n
   kSQFwi0UvwtZLOtZJ75ECisckJFsg1bwSGjlK+ta/khoGR5OTxfTkgUPm
   A==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654531200"; 
   d="scan'208";a="314402595"
Received: from mail-dm6nam04lp2045.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2022 18:11:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i51t/aeDnDKFmxZ2dbBOY/WS/mkWnCBPAYIk+OlLr+UyuJCGtLTmm9wTExegXSkg2elwhfi9lqh7QlkIWP+3BpAHnC1J9W4g5uras6XuO93K7eSBAzK3ocYKKPqolnXI5KTEcUzkQQwptlfnfnmF5DU6Dq/w06bGmYJlmzbhAljCBghDVE6FdUrdLD8Y71wmZpJloyOgwOn8pBx4vtN+cpt32mKIybj3NjYA/u1AVohI+9r9V7G/iDkk0D1XzjQFUzdEvvTlwfV9JODFymFSQuIP2cJE3aDEV6Gb7KDF3DQy9vW9fugqH2PqX4E6EdT7qFTcQBEZosjvhGBPjmRHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDNAOjNJR8kKQJmq+k0vYODKV/thCDDv6hX2L1ZyYzU=;
 b=Ncez1qIgoKYwc7YM0Y6gsFz9ZTR4G42kKw6dOhdt1Y201gxnG6f0YiwZ56PJZsSZ+L8XQYqWcOYnnQVmUrBmmgzgX4+9X0YUFGrF+tXuOZcnWYQJWWnLtqAGpknnPaW7c3hm7G/IMd7iX3ZeqKyYTHfhrV/X71UDleyyKVilVADCzy5tad1w7t+GowIkQIwGibW4Bq83QUot57oBrHitcbMb9/78ewbUkdSXcVjxCrrmUMrAGUW12lxo4oQB+eYV/AkQM3x+pDKh7D6Qp7d8uCIMV+tG4KbAOqUi60qvZvDdkiUKP2XLSuEmun+jweEOIeJ88fDDBSDftBFV55Vz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDNAOjNJR8kKQJmq+k0vYODKV/thCDDv6hX2L1ZyYzU=;
 b=tzyt0sQOtFFtD1Le5XjU59fNcIcvRz2nfoQbc7qie/LjY5R8wffbiUpSItG0WbNxM3HFzrweQ9rH/ztSVlJ1KdQX8tnqpBSCWUeq3w8vkn/4rqLOKrcNEkU38nEbCln0YnnN7OunndOn6PoRxHUbnqjUnszVb6VujxktRS+6fec=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by CY1PR04MB2267.namprd04.prod.outlook.com (2a01:111:e400:c618::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Wed, 31 Aug
 2022 10:11:05 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c839:6239:54ad:fc30]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c839:6239:54ad:fc30%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 10:11:05 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] ata: libata-core: Simplify ata_dev_set_xfermode()
Thread-Topic: [PATCH] ata: libata-core: Simplify ata_dev_set_xfermode()
Thread-Index: AQHYvSH64yBxXsiWOkeP9ABze34DHg==
Date:   Wed, 31 Aug 2022 10:11:05 +0000
Message-ID: <Yw8zuP45nxFavZrM@x1-carbon>
References: <20220825224519.369685-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220825224519.369685-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d0c43e2-607c-45a1-53f7-08da8b391da1
x-ms-traffictypediagnostic: CY1PR04MB2267:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iCEbx2sAT+cpNlkK54ajU0LECvZkWVSXqG+jPaZqFPgbwGHhogcdCPirnj2TYS7ChVo80RlXh4QT+shqjsPtHGw4yTnw+zpm5rQZ8L47hRpAthuQEctdThbMvF1Km89mn66Pzly4doNA9nd1a0RkUJATaS+prBj/He5D6wAGxJD60JmM7/HQedT48x1JrS3voT+F6gdbIRIWrpE/SJeSahSPktiysUH3adLTlcmw4jN+Novrk4lIcMNKEIdtx82JmJfiCVniGlsKWbEzgMKz0kMT6lgKGdr6j7oiLpF+YUOIkvOQIIn9b0xjGl/09m4uifDwIzWaNO8R+q6tx7V0KowexvJiabRpwqgwVPtwgprHIOpJMnzueZcAFuvmaNFvaBpn32EGA9Jr+LvWkTbb5JjVFbrL4ftWls1W6lgEEWOIDv67o2UoFDbP1tZ1go9YcK/4v1i9huVO3yAfESWilACG1Wm7TuLrgvdATJMNlUAozLqwj8+xbI1lZwQACPJ+TLPWU8osxSwzxPLzVaX/JlT9ZI0hNyD66vTBetx2YwfoWUGqcCWwG59pszJY1LHVet7zEvv55xHieRQbADcBBrHnq78mZfDDGRHp1tKuzrCsy1SiSGO/SVcvIU84ercsHHa6UVXKZ83OZFZX7ql6eQr27tYJJEtOpJ62niFT5qAKl55gkazoyrWZ4yfEQjRgjVwQ2lcT5skh09aC3htBDgTy1CDMLEKw6GFzhNwIxl11f2KauWmMnV3oPs02Ea8thuckw0LAiZESJB2tXaeN1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(136003)(376002)(396003)(366004)(346002)(76116006)(66446008)(64756008)(8676002)(316002)(54906003)(66946007)(33716001)(91956017)(2906002)(6862004)(5660300002)(4326008)(66556008)(38100700002)(66476007)(122000001)(8936002)(82960400001)(9686003)(478600001)(38070700005)(6506007)(26005)(71200400001)(41300700001)(6486002)(83380400001)(6512007)(186003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UJ874+Pcy3hU5lO6jsQRTkh1gPpZRRTsDd2fJuqdHRmbdtOJkwYP2SAahaeU?=
 =?us-ascii?Q?nKeaS/m6F48d8vKuMgoJ7BIwevqiwmFA1PLCYahRhyW9HvTfbbaTD2I4ZhYO?=
 =?us-ascii?Q?QRvvGfuivHYyW03RLtja+S4JwPitGlQeJHjPi2CipvMZUY9ZyOQtiH6T8Yj+?=
 =?us-ascii?Q?bEoougtt13CjtX96qEE5ASdDDyhfVm4svDAYZgSeOWMJb27sQK9/5wX6i26m?=
 =?us-ascii?Q?AYDMTGhnnP8zXc3yNb4qIMiKnAHgZ2cZModPcci4dUqq/1yP2+0l1rjFZo6G?=
 =?us-ascii?Q?B1Cj5H81AJQNxvzdJhYEXMF3328s2nKr1/XKJC/81q5D10m3WRaCXk3BqLF2?=
 =?us-ascii?Q?Z4QQdISg1lz0+pksCBcMylHTO7bFj8ttalnVFm4RcqrfwRDA5iBHkmZBJpT3?=
 =?us-ascii?Q?9j6OFhVMDFH3W1crgTtPogOMT8m1zOixNLA82N0F3rprlXrp91kmY2pURK0e?=
 =?us-ascii?Q?E7ZjYEi4cgXYaxBuzBDh7DZATgG+5ib9rhNgIPlQ6Q0WJQeGGwNcnTrQ3Xks?=
 =?us-ascii?Q?oXDSkmsAR2DgfvHWApesKMBgCFEVFNSu7OF+y9ocH+ZT2YfpTpX+g9j/8IC6?=
 =?us-ascii?Q?Ux+DyO7K31sKBTU++Fje22mwL0206XOzP3+LkrIP+fFnz61Fhv9yFpr6Uw0U?=
 =?us-ascii?Q?/hO1ik1nmQWkD5jTA6SbNdqckeSXde7BRqsRVtmI6p2UJ1kgw91GuhL3+FlS?=
 =?us-ascii?Q?l+yB08cyBoBr3yI3qTZLjm23KKI8tLZG6TPJ7K1vIRCMAciBuvIA4YxQ7gRW?=
 =?us-ascii?Q?uBx33agNVT7q/cOV7pzKOQEh9htylPRHkCGFWyfrbB/XtrLbeiAPDC61VQRJ?=
 =?us-ascii?Q?fxuG2ZNuqFNRCUK/tqnceCzxGHjNYXpINjqKDUjY0Bek+oeFZxc+gsmd+Ccd?=
 =?us-ascii?Q?2vi+sIj1hIL4D3WUCANfjUxWBV9ofhkRzZu6ZcUKBvVDAkvqYjdYyOqTjRoB?=
 =?us-ascii?Q?npiWY0fsAggvzYnHwM4fFdDLue07FOwLCWZ+zVrxND4hAZkaV7Sfi9CAEZdC?=
 =?us-ascii?Q?qp2YwlSjGhh5K+R6ahv+t+Nu16+/EqJcyQrRwrXl1JP5lu5ZngfU8/VGN3Sx?=
 =?us-ascii?Q?4vIrJ0dkSOZI41FALP/ioCjlDPMsBbHdos6VupuNW36P+mMAm8PH3qR9ZiHo?=
 =?us-ascii?Q?h7uENyksoErM6uii0si/4g1OshfSn/ZJpiJq6CDzYK/ltl72fS3ER2VKmzQz?=
 =?us-ascii?Q?N0eRekRDteKLak6+AtmS8qgk3pvDALwMiTqhaiKb4BAak+5eOobkv+Gn7Bss?=
 =?us-ascii?Q?dUzR4eq8iPI+y2ogCCca/99/I4BfrX6g5C8UaHOSkkPHRFb221fuAlUUgllm?=
 =?us-ascii?Q?O501lxr1KB8vs+fYHCZkAYsyvArQFCuVeR7rqwn6ofMqkpsnFq8qJswhyJE7?=
 =?us-ascii?Q?SHzwnuqzA7fYBxPCVG9R+U4be7bcvdR1hbvumY9ESbR83/gxV1QTHTq1O+Xv?=
 =?us-ascii?Q?AgmMEOeGgdWzCIgB+qBFwBKXVr8Ce6svSEPBriLw+C3VcDV4zVgTLF7BaWvu?=
 =?us-ascii?Q?mdYRWoIMOO6gJN2aSHUWCIKyPVvBAXqd+GWhtnglJDM0XBsrFkimrWLkPLOO?=
 =?us-ascii?Q?NNUfGR2dTV04wkvBG4OhoNeDRZ4siBtHicVVdLPa6LgI146KhMMm/ExGChhr?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <483F0BA0FE9414468D314A9BED886FC2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0c43e2-607c-45a1-53f7-08da8b391da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 10:11:05.2542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +siQ3gGU+egQd1h+OTvXX5h0XVejQF6BhtQQth5h78NuV0YQ87rymGTMXg9hIznVARodyV9cBjVeewBfoBrzsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2267
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Aug 26, 2022 at 07:45:19AM +0900, Damien Le Moal wrote:
> The err_mask variable is not useful. Remove it.
>=20
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/libata-core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 0b62fa14a74c..d0242c75aac5 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4295,7 +4295,6 @@ static void ata_dev_xfermask(struct ata_device *dev=
)
>  static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
>  {
>  	struct ata_taskfile tf;
> -	unsigned int err_mask;
> =20
>  	/* set up set-features taskfile */
>  	ata_dev_dbg(dev, "set features - xfer mode\n");
> @@ -4317,10 +4316,11 @@ static unsigned int ata_dev_set_xfermode(struct a=
ta_device *dev)
>  	else /* In the ancient relic department - skip all of this */
>  		return 0;
> =20
> -	/* On some disks, this command causes spin-up, so we need longer timeou=
t */
> -	err_mask =3D ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 15000=
);
> -
> -	return err_mask;
> +	/*
> +	 * On some disks, this command causes spin-up, so we need longer
> +	 * timeout.
> +	 */
> +	return ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 15000);
>  }
> =20
>  /**
> --=20
> 2.37.2
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
