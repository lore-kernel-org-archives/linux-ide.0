Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E1EC38A2D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 08:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiJ0IV3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Oct 2022 04:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbiJ0IVS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2022 04:21:18 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C7154C89
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 01:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666858875; x=1698394875;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MHNpKYLIjAhsWj50Y2DXNQVykzlTufQNJKOt0rMcj48=;
  b=IBOCqphyjM12o9f4bz7eOAjBCjX1ghGalh6R5w4f8KogVulT6mvrPMzr
   kEdlSzkry1lMTwPyyoHjzcIFj9/pOSukE8oz2ts98czOk7UBB1XIx5kVH
   ZxUotfMvvZhYplr6l6QBxL5p2bbwmrYZJgt9YlUrcMBmf/BPNXg7D4Se6
   grS7liAgEU9F09yVZOcTc9YVu/7vIQctQAutIHTYL2UEbEttGwtP+7Wq4
   tCCzJ6Lb//KybLto4XD8lMkyAxoxwhQ1K5DoIxebPFr1+Q3Y+jlvaiiDd
   ry3Ta70DO/3nv/hcCh+0Zf1WlhRXHy/NaYpWsuXgpVd/Jt8CkENRiCdgT
   w==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="319183870"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 16:21:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0QR8nADhX6lhEoI1000t3Dp8x4GxtL77lFg63G4zIPioF8jSpEdG7zhqZNDNxbF7KPFEI0/yBgpn8+By4b7EbzhI3AfRQMCbnW+GvoNWsM5F9PCUwkTNU6AWp4oiMIJ+l0hdQeMfjy7VMG5gQ712mJhY0e8lM3RPfMYeW0i49K91BTe1zVoh2086idSdDB+FFUyp67vvDL9pl1/dc4MCm82chA2iJtkgIvij1FRYKodNG+FroHw2kpStKANvEKl+6eM7Y6VhItIEwI79XYrMWJ/H2EufNgqhz3UVZkVdd5Zo8CGv02JEOXI2frMdqmM1BlEzbeJ1fAAdnJh5SA3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQwPPCigFw4rIaqlXvictwqevwyTSuDD1MsuR86O+34=;
 b=P7TFMH772FPr0WEscV290cFTAJP1Ol7QBp/DQkAa0cFRO+Hiw5KP3rPfDthmFAjBpfvbCUSVA0BjVDC3MWS2EuQ6UCuGvcM6aJhLqtUs2h0jBHGaejxE7ZuU4Q9ddbAKdz/J/J1HJTB8RKElgurm5/glmcI4l4VYK8jT6Xn9aDUniwv+kcCY6SQngNzy5IZZ4fkl3eXha2e7QRu2ET81rSp1t6QJbFnE/JYUEgGrwaKEK9D2ciwCFQGlqmwZLHaB6Gosdi6CJAU/rA6wRd89cOImFoRE0mNoq/t78tbSQh2Ihqo7mBCoKUXr65hUyRUB+rLUdWYeoMmBV3sGO+3rEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQwPPCigFw4rIaqlXvictwqevwyTSuDD1MsuR86O+34=;
 b=KEHkrGEnLIMwz+WxTyEjy9cgKq8wr43bAz+SMJjvmuEJqp2IkwirlcEabAZ1Y+1FEbUKawuIXutAEqnrfC+QbFIXEalfvfo4MtEklGasy1I5KD8cjZdpRPyyVUqe5LbS8nZ4C3wEoNMKamT2VCu/8h8w8OdpD923VSq/INexkis=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BYAPR04MB5736.namprd04.prod.outlook.com (2603:10b6:a03:10c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 08:21:11 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 08:21:11 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 4/6] ata: libata: Fix FUA handling in ata_build_rw_tf()
Thread-Topic: [PATCH v3 4/6] ata: libata: Fix FUA handling in
 ata_build_rw_tf()
Thread-Index: AQHY6d0SBYsSMJSCrEqbE7lYkajwuA==
Date:   Thu, 27 Oct 2022 08:21:10 +0000
Message-ID: <Y1o/dtp+kOB4Qpeu@x1-carbon>
References: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
 <20221027075026.240017-5-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221027075026.240017-5-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BYAPR04MB5736:EE_
x-ms-office365-filtering-correlation-id: 337c0c71-45e9-4901-1f5d-08dab7f434ac
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hnAHWGjHPDvJ6y+gEUv8jyQQ9CZCf+7zyxCNVqYZuxn1QvjLyxY3VuGEsfgJVg3AH+i8M323KJKQOWjy3F6YvFSpODnUWtO+Mn8KZcv/iXzyu4rs/PxIJpUhVIA+qdwClTzOao6NZF0Xa8z1dzlcxW5XXvavmb+jHD+l5MwWpHijzYRM7eVSKuXqcdyAaSuC3VRii1O2EfcHlQbSnhLKgL7gwbpNI3+y29bhceAa6lP3Kd+bTWgRZGCOSbsFt6Oymrn9sKGnRDvgSFVqzDZ92C6rbnitMHhpH9j0y3SZGF3as5p3U/R7A0ryXqKvLKHIRO4LWNiaFnOJlmozjKSgWgUqlnKXlpbW1/GWNXcMoqv9TUHB7AJ4VCDNlrBocufukWQmWFL42dS9+9PqHJdG+JB/O/u4gzT5azUiFdai9MY4gk7cuoLgyEG63qoaKo2pSpKRSbiaNj4FgdCTbA1B/q6FGrLTbqw5Gy0aVeTRuM2APh+2dOA3ZKQ+mTSwI7en0f+k0REqBadUVt0uVMwSq/H8S28ygiS/+virH86T3oDYkTRSo3JWE9gNgJ2yYsODEH2IoBysvGTbB07x7QefBE97DQdTlztlE+y7o7kMYCI4VSPbQewRwovlQJytt07P4/ps7P0KG6xYjJ7tG74DzpYh8HEhv594PqWH+pyNupHla87l13LP2+u1Ro9YVvLq30g2YnR15D4LpJHko5bBHZPMXnLW/61uxtYBBH0TC0nqDePQi9KnUhvSgtf5Nz9NPTyWFAM/XcHNoMwyyBH3/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199015)(38070700005)(38100700002)(6862004)(4326008)(82960400001)(66946007)(122000001)(8676002)(316002)(86362001)(66556008)(66476007)(66446008)(64756008)(76116006)(91956017)(6506007)(6486002)(26005)(41300700001)(83380400001)(8936002)(5660300002)(33716001)(2906002)(71200400001)(186003)(6512007)(478600001)(54906003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?61AHyKcfLnxeCeLfjQtGZH1dsU89JjGtuCcZwNkCkcl+rl2E1ktHelzbk9md?=
 =?us-ascii?Q?LTzMZc7iXjhQ4+lUaPTLvx09tRDI3MR3+ZlMMwRyNfoqcdh3RVgCvErrh/jX?=
 =?us-ascii?Q?K84l06xLxWOIMmovc8tB4U6dEpF3Ag0bLTzpBYvKuyd0dI1kTiVwI5SJV8XV?=
 =?us-ascii?Q?qvTxoc1eTNYH96+C6QhicXMyAcUACY9YTmRcYJZuZOUj/1tOOVveb1Q+kmnC?=
 =?us-ascii?Q?Kwpn/X5kc4w/KMtWR2B4qz3lTy6ACtMNGmIJUqKwRIHIfZNSyz2DnT15xyjg?=
 =?us-ascii?Q?vxX6Sc9ccXcVWuN+XOArYDvHy5BKngDqjSdbhnXJMyuvC+8R7OZKiAs5oTe+?=
 =?us-ascii?Q?tgNUP2dLjYXEFwza/AOwxF94h6sGZl4UPMwp87cZLEb7Crt1QbHeNflRhiYL?=
 =?us-ascii?Q?VjT6h6pB4KxElY5wdW2rzulEFbiSeYphI90rkngjV8kY1ftss1sWMimzj7VP?=
 =?us-ascii?Q?y0ciWrQks7oZ7P0kLSmyEFYqiPpodReWST83GPzESoMhqShTxGz1Fo5QkhgI?=
 =?us-ascii?Q?AZAXuJYjoEFuWcc37QeIftkXKAZoRktUTVuhzFYNaKUNbbhMO8Awnel3Ctp8?=
 =?us-ascii?Q?YBq27N0/C/XzvmYhDqKU8kbM11h3iYerIXLt7pk8GYXhawqS5jnPb84tbZtv?=
 =?us-ascii?Q?h8b2ErEoOVD2nsEtBsdHpOGZnXPbdmzqUFQkbkM+GIOkuWlnrAXvasgzWQbk?=
 =?us-ascii?Q?KBtW6rknBdwzEYwsocsPaxvpnb427rnGlzUUa9aW+UAbsbl09mAeBTf2VVrs?=
 =?us-ascii?Q?Gki0kgbMeVxIjF+bIOCKPHRS9wy5QAjyfmK03Uwv9IYBBSNrw3li7iWHcwRo?=
 =?us-ascii?Q?uxd+DBzb8yRVTtFdSxZgmv/rs7HRus+RJob/+HgCAQXFYV2IeKRiyAkTLIa6?=
 =?us-ascii?Q?yBE57s10mlB7sTVeJFRW6rgR9/JyV+6J27yaoLWpDBb9Jh8JiQRIEyxpOst/?=
 =?us-ascii?Q?A2uXuhNoKgQXw34LmxHdeQ7ZH3xNJwgVFga4tXccF7BrtqiqSw7ZMwEx1SeN?=
 =?us-ascii?Q?tqn1U7ZiricEnuTdKbvekdq2bwop3UaiCryKT3qkLUZ+PiafYdcf2+8BVd7b?=
 =?us-ascii?Q?g4zhWiBsuZinARQ39s3o24NlHwL5ET851ybW68o1qMgcK9bI0/G9ZODU1nn4?=
 =?us-ascii?Q?lnvciHRbvfEyK5x1hlrFI4AVHv01dKVragptQ/qv4vtnekcWj8THCoQodCaN?=
 =?us-ascii?Q?AiLewMAcnlojdv7VBzf1O/Y7S7IMnw/pPIdfw1hCm6EJMHMxACKdvpXpKj5J?=
 =?us-ascii?Q?GTJ798CHMPJw7GtnIyxJ6gwlU2cpcSG9d6q32mm1LNNZiBAniTPaaNyEQ3lp?=
 =?us-ascii?Q?7ijOLCTVafPi+TzczrlxSujdJk8ncEV+YZp0RjnnnGSa9/5KXRrbCFiB7DaM?=
 =?us-ascii?Q?cwiMNuY49xzlbKfESPfqbAui7pHkPmpqdv1xYm/MyjDHPMAufqZwOILQ81Xa?=
 =?us-ascii?Q?ywBkeP9QfLNK6uIOw5xZDJg1oPskeqnLhwbhlWhlH+Ihv2UwSTmFl4VeU/qQ?=
 =?us-ascii?Q?WegrOCCW1k5C1nRR/BuzAy1NpyUyusZmcDkuVn3aRgoHZGdOWO/XHSKg4Edb?=
 =?us-ascii?Q?/gd5F952QFM7n2zfdAFY1FNDxZr/HfS2PvR0fje29XB2cWWGAsVW4bq7ullY?=
 =?us-ascii?Q?ZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3A9E6A77F07DA41ACEDBB8B3BC225AB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337c0c71-45e9-4901-1f5d-08dab7f434ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 08:21:10.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEhuAFwqTxRzMpN2JO9QaQLlXSb6Lnhhti4yq/WuCMLCpjEv9mxtS0tSoP1FCUDu4Rx0tJYsyh27LhPP9GUa8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5736
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Oct 27, 2022 at 04:50:24PM +0900, Damien Le Moal wrote:
> If a user issues a write command with the FUA bit set for a device with
> NCQ support disabled (that is, the device queue depth was set to 1), the
> LBA 48 command WRITE DMA FUA EXT must be used. However,
> ata_build_rw_tf() ignores this and first test if LBA 28 can be used.
> That is, for small FUA writes at low LBAs, ata_rwcmd_protocol() will
> cause the write to fail.
>=20
> Fix this by preventing the use of LBA 28 for any FUA write request.
> While at it, also early test if the request is a FUA read and fail these
> requests for the NCQ-disabled case instead of relying on
> ata_rwcmd_protocol() returning an error.
>=20
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/libata-core.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 81b20ffb1554..fea06f41f371 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -725,9 +725,21 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 b=
lock, u32 n_block,
>  		    class =3D=3D IOPRIO_CLASS_RT)
>  			tf->hob_nsect |=3D ATA_PRIO_HIGH << ATA_SHIFT_PRIO;
>  	} else if (dev->flags & ATA_DFLAG_LBA) {
> +		bool lba28_ok;
> +
> +		if (tf->flags & ATA_TFLAG_FUA) {
> +			/* FUA reads are not defined */
> +			if (!(tf->flags & ATA_TFLAG_WRITE))
> +				return -EINVAL;

Hello Damien,

I'm a bit confused.
Didn't you write in the other thread that you wanted to force the use of
NCQ commands, for a drive that supports NCQ, regardless of queue depth?
Did you change your mind?

Because as far as I understand, the code after this patch, for a drive
that has NCQ support, with QD set to > 1, will accept and send down a
read command with the FUA bit set to the drive.
But the same drive, with QD set to 1, will reject a read command with
the FUA bit set and propagate that error back to user-space.


Kind regards,
Niklas

> +			/* We need LBA48 / WRITE DMA FUA EXT for FUA writes */
> +			lba28_ok =3D false;
> +		} else {
> +			lba28_ok =3D lba_28_ok(block, n_block);
> +		}
> +
>  		tf->flags |=3D ATA_TFLAG_LBA;
> =20
> -		if (lba_28_ok(block, n_block)) {
> +		if (lba28_ok) {
>  			/* use LBA28 */
>  			tf->device |=3D (block >> 24) & 0xf;
>  		} else if (lba_48_ok(block, n_block)) {
> @@ -742,9 +754,10 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 b=
lock, u32 n_block,
>  			tf->hob_lbah =3D (block >> 40) & 0xff;
>  			tf->hob_lbam =3D (block >> 32) & 0xff;
>  			tf->hob_lbal =3D (block >> 24) & 0xff;
> -		} else
> +		} else {
>  			/* request too large even for LBA48 */
>  			return -ERANGE;
> +		}
> =20
>  		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
>  			return -EINVAL;
> --=20
> 2.37.3
> =
