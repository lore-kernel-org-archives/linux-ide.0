Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AF0C4332F
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 03:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiKGDFU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Nov 2022 22:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiKGDFT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Nov 2022 22:05:19 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470C160E6
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 19:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667790318; x=1699326318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dGTOE+3OKX+3cWiLj4fHrfn7D72ic+iMewc+qSqCB9E=;
  b=YHk4XaXEWA8biIXb+LGhQwQIqvD1QkA4FC6u1jzpXM6PujDwwdZ7Q0qZ
   VbCazQLbfdBqD+nhTT0GjElIrpHnqlhn+p+RhabNN+tKL06cUk+7gek1y
   0NmtFW3jbELryM+hExsMIHJPq4CWYxGMbdvA8d0PtSB99C9AXBBK2M8c8
   e1UXC8cc4t0vFHxorOpVi2Q0JsfGZiw9YIP1tT8vIT1SLe7FeHzFrzW9/
   yYsPEsW3PE0P5a6elYl90RWy2Kg19DRGN92zi8TYEV8XAD/HNQTbJPmOQ
   zcYgK40ur9rgcR/K6L5+I6X9fxVEESfTDi5dlkSqhDxaCNFnKP7n0ydmx
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665417600"; 
   d="scan'208";a="215966894"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 11:05:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTlLge9B74TFNM93/CdyDo+k9PJdiJrnAgrkaRIosADhRuy+UCBTYbVq25C83ltcV3/Iy4IgztbHmbsiE6pt2EDLrbtkZIuH+jJ5vndklW9sIQ8uwDwtqOqRp5ERzqmevIx0IWdkvczNHTpBLHu1Mgr2sx3g7Jx7DHhkH1jYEo9a24NL8O0dsnuYCHNdz40nnR8PDxFwGwvw7hSNkgBozh8piNgBMQjO8GlEw4EPf3MT9asIMF323R/HQZLEPb5w8SJmH13qwVm1mug1rBR9JodERQI+F9H5n5KEGP4Zb86a5xlb5blBf7hQu/iSvdOFFQHowXFlHpg0nzbaGMhffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6gaUXUcrXi3Ntxs2ucaosuR2IKRy3+/rC49T9AyyHQ=;
 b=GtJtHC07//7wRCUAJ1Ant6nDoM5joDcY9WxjgUA9LTbiugIo4TrSeNU3hXx0diQsYyDdRd/n1xSyjx3OFwXc7vZEbIOTiVhMYSLaLLp7LVGySX0wRA31JRrmm3SEERNRJUpqJjnOAsTZuyqPLEWEVwqk048zMT30qQkxtk7GN40T/hTnvc88/+ipNgH9oPJHG4gQFtTXaKgUetXJlk4HqEGLzMuVOzVUGv7HvO7LatEQcP2bP/v2YR3Abk+Xl1n+cWK48RqrakMHchmxnMoyF4oMZR2xR0fTZK/zXArQkJD+tQCZeMo29DQSvjFv6jLAnN2DG7WbhgdPaN4IAtXWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6gaUXUcrXi3Ntxs2ucaosuR2IKRy3+/rC49T9AyyHQ=;
 b=d0O/tdP9J869hQaqj/zLXfTFNowz1a2HES/7voG8sL0wbC7gxMF2KuicRrn8P9ZwS00ylJApAjDkfmTbj9OoLbLlXz2dNuO0SBzSyDoEwp/bXxOBX7t+GUHQY/I5SAW+PrIytv+4cXwrsIyFk7tLfu3uOjg9lfvwPpBubY7D7jI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN7PR04MB3811.namprd04.prod.outlook.com (2603:10b6:406:c6::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Mon, 7 Nov 2022 03:05:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 03:05:14 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH] ata: libata-scsi: fix SYNCHRONIZE CACHE (16) command
 failure
Thread-Topic: [PATCH] ata: libata-scsi: fix SYNCHRONIZE CACHE (16) command
 failure
Thread-Index: AQHY8kKPrO4JWzI7nU23P7JA+Pnm+K4yplyAgAAgoQA=
Date:   Mon, 7 Nov 2022 03:05:14 +0000
Message-ID: <20221107030514.bkhjzqiippyehjed@shindev>
References: <20221107004745.1540270-1-shinichiro.kawasaki@wdc.com>
 <501804d9-8dd8-29be-2ace-e3ff6220c8da@opensource.wdc.com>
In-Reply-To: <501804d9-8dd8-29be-2ace-e3ff6220c8da@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN7PR04MB3811:EE_
x-ms-office365-filtering-correlation-id: 2a15627e-872b-4a72-2594-08dac06ce47f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RyIsh/aqFwBYyWmVcbOx/MZ5kvk6XwaGIuCvSZ/4BH9fZQDAGA3amg/2hWBTt0A18pxo4Z278GXnWgBfjSfQAgHPdCnfhGoWCaKjMDtddj8z+0Y/OUXadvyGFvxexkqoXGOj0Euqo03cpcAp2XObSGRBD6bg322DhnIvrR4ib5HkSpktfEJUrL9bO2xFq3VN5ZQ4nOKwJwMf2mWdefFO+c85NGtBSYAgAtnwP124C0kuGgKqjNB78+fzRFCI49ighGbOoqMUX2I//1UlPcc01IJ8zTCOzCyc7LDoHj+0RaX/Hl6bctkX9WQK6bHtyTPoJMMA2Oc0KYGn25rtYPNU3bma6j7RsmZqvY4DpjtWuFeakZrav6UtbS9BVYA8n38PR1nYZDV7JYhbxAxieq40+v61FUvlRMTKkqNQYp+BA49fSp4cPpAJRwQJsSEaR+GK8KNBSOUgHgU8x7Hiip2GY0RDPwFN1d2h/Eq8ZzQ9pjQ4QCXRkD/n9khvB98cFirvPULvILS9YVhgW+op0Ot1m34tWg742nt7bQ8XfIEwwRzVMHpd0VPxXMQmnNQILiZqznLI9Mtmgd1euTQMuT399jElx7mfBPW9PEjhxR0OlVZOT9/9wInDrVgwjYj8tZHtfPaParfgLYQvNQRlphjt3alJ9OSwCGUgPPyNI17aojXLCQBHFR/t8353GxQLBaWpycLvzB5zjT6li421eJA//Ej64uHFstHB5u08w34CZMwVChIUFX23SwspUUnlA0nfJ+PVE2hqz0rWGIuEOCzIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(3716004)(186003)(2906002)(1076003)(71200400001)(6486002)(53546011)(478600001)(9686003)(316002)(54906003)(26005)(6512007)(38100700002)(82960400001)(6506007)(122000001)(38070700005)(86362001)(83380400001)(66446008)(66476007)(33716001)(66946007)(76116006)(66556008)(64756008)(91956017)(8676002)(4326008)(41300700001)(6862004)(8936002)(44832011)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?23r72okRQBJj1RlQVKoOb0XdZUog3kLmUbu9CHp1qGmTqxSWF3ehRWXduIFy?=
 =?us-ascii?Q?LNkbv9xHoER/+Fr9E38Z9eIRLgA4GDb6M8l9EruQ7je89qn+JkZ7RjMSzIfq?=
 =?us-ascii?Q?1Oy6Q18/8mJzS5YItjmsRYe1p77TYYwG14fFaF8EL4utpyiMAQNfQwRa9t4W?=
 =?us-ascii?Q?Ut3q8QPghLwXWihqck3FvfjEhSLPzroA5v9emNraSWOb8UNiSTVZaA3hjWYs?=
 =?us-ascii?Q?bXHgLZcSKJkKWpaT1xkw5x4Mwt5FK14Fu0eCFqiwA1S3+R5oLH4qGPqqNoV6?=
 =?us-ascii?Q?ayh9tLqtSVW6UKilpFqBi9yoiiei2avng8MT7wPVL/vQkmvzfe4uhZ7K/NPR?=
 =?us-ascii?Q?/ybPqw8LgUu15CZQl/GtwyWtolT/XH1gjdsh50iluaEcI3QHwiNXCGxQVm8e?=
 =?us-ascii?Q?9Ik7j7rXG7J8ZO8E7ISpbNdSa13sjGDjGegT2/TxpjWUUH+y6wsAyOU1xrYY?=
 =?us-ascii?Q?RvbFOM3UA4Jvt3c0KHz4o7eqeMj+wj5892fCuVDcbKsnqcWANJ8T4zH4Dvkw?=
 =?us-ascii?Q?FEz5/GDM/GI18pXNGmpYfrRPfVwj21OZ+kVz/exs7nhan17MTFOiGWeCJ5kX?=
 =?us-ascii?Q?1XNVqCKmJMXpdeOuObfBXEv771rodtXVlU4XoILaOFl6iZ6s9DgPMPc4Grqt?=
 =?us-ascii?Q?N6B2zlvh6O7bO0ypfkxi7oxIsbxX1uibr/ypfZx8YlqllGTFCEORLj4PWIil?=
 =?us-ascii?Q?piKy17gfFhIEE1269i/Db9DDCIFf8kdD583ZdCVA40q/IHxGVXvFfdjynS25?=
 =?us-ascii?Q?J1wsedn92+cLQ0HHM3nmB+VwptCTc668/1p8DZES1Z9N/U4WGhn7BknZhP4l?=
 =?us-ascii?Q?kai8Frw4l4OQcytHNTFOW5TcrO0A76bt9uv5TEalMLH9V+RF2xPt6tPXIHXK?=
 =?us-ascii?Q?qlihvtNSwEHr/33Dvow1qDwQaNsh/aCcT8jvHxguLaVzgIO9LpG2cC+ypJ2f?=
 =?us-ascii?Q?F8DOTMkIZgr4Jjuwtxz1vSn7KZL1tIzeLJwQcCqMQv0/Iqip7uf6i8KaDKlN?=
 =?us-ascii?Q?OB0KTTnEymhzYVn8ug8E9pSJyBduuciDCwPCcYXKr2B5DRIOEDZ/zcRqlmih?=
 =?us-ascii?Q?k2R+PspfBkhc5dIg1pG25k0pl1Prdq/VO1f34ktMNoVmFWRCRuRkjDr6rmsz?=
 =?us-ascii?Q?V28oC8tz4M5EAK+OYu3mPP4beMyNNHKueEPYzRaArdlZXKgghQH8TnAsYUcX?=
 =?us-ascii?Q?88XP/244nD4eNClmlwPXubbAd9QN19zHj8Ei82EYP0dqRECPE30VMvankFo7?=
 =?us-ascii?Q?j6+QyRGf6Eeg840p8lqD9ogUzJFs09sHLn7Cxl5h5FcLvZYFB8lTmtu3kuvw?=
 =?us-ascii?Q?4wZp5i00ajmtmTiFQd8XnFHPPTuV9ARgKCc7I3F8c1HbAvKxr5K/tPC6q0ee?=
 =?us-ascii?Q?MSteDj2T3J/aHqP3wh/DZr/y+Wvw5LgH7XmmtwK70/04o7ju3axkMf7v1GdL?=
 =?us-ascii?Q?daM2gW0Sa8YKve8Bkxl3Ru8BnuX0TtA1b0lqbfs1JiSJxn9SSgce++wyCi52?=
 =?us-ascii?Q?4C6bUTOj9RvU9PttPy7QzWqZkdWv7zU43/QjlIpxoSHStaezavVls4hExzXQ?=
 =?us-ascii?Q?hUwgGGmaRn/laTCLA7j6tLj/sMbCawe60A4TDyOMHGeLlx9TNqzsmx63uR2j?=
 =?us-ascii?Q?lQoOGscFTKXJh2DbfzvMfh8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0379488136A75499A463CD102C98584@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a15627e-872b-4a72-2594-08dac06ce47f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 03:05:14.8573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccw8ma859UButgiNRnxoPEVhYkUMzNs50zJE2DBV8/PWpMUMFUYelMhc1trsUBvvWQPPxz5VV/jEdEzL3l1kPTh7VJ981SqZUydNPl8QMOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3811
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Nov 07, 2022 / 10:08, Damien Le Moal wrote:
> On 11/7/22 09:47, Shin'ichiro Kawasaki wrote:
> > SAT SCSI/ATA Translation specification requires SCSI SYNCHRONIZE CACHE
> > (10) and (16) commands both shall be translated to ATA flush command.
> > However, libata translates only SYNCHRONIZE CACHE (10). This results in
> > SYNCHRONIZE CACHE (16) command failures. To avoid the failure, add
> > support for SYNCHRONIZE CACHE (16).
>=20
> Also mention that SYNCHRONIZE CACHE 16 is mandatory for ZBC drives (see
> below).
>=20
> >=20
> > This patch conflicts with kernels version 5.4 and older. Conflict
> > resolution will be required to back port to them.
>=20
> The above is not needed.
>=20
> >=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Cc: stable@vger.kernel.org # v5.10+
>=20
> Remove the version number.

Thanks. Will reflect these comments to v2.

>=20
> > ---
> >  drivers/ata/libata-scsi.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index e2ebb0b065e2..61cd4e90e4e7 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -3264,6 +3264,7 @@ static unsigned int ata_scsiop_maint_in(struct at=
a_scsi_args *args, u8 *rbuf)
> >  	case REPORT_LUNS:
> >  	case REQUEST_SENSE:
> >  	case SYNCHRONIZE_CACHE:
> > +	case SYNCHRONIZE_CACHE_16:
> >  	case REZERO_UNIT:
> >  	case SEEK_6:
> >  	case SEEK_10:
> > @@ -3922,6 +3923,7 @@ static inline ata_xlat_func_t ata_get_xlat_func(s=
truct ata_device *dev, u8 cmd)
> >  		return ata_scsi_write_same_xlat;
> > =20
> >  	case SYNCHRONIZE_CACHE:
> > +	case SYNCHRONIZE_CACHE_16:
> >  		if (ata_try_flush_cache(dev))
> >  			return ata_scsi_flush_xlat;
> >  		break;
> > @@ -4145,6 +4147,7 @@ void ata_scsi_simulate(struct ata_device *dev, st=
ruct scsi_cmnd *cmd)
> >  	 * turning this into a no-op.
> >  	 */
> >  	case SYNCHRONIZE_CACHE:
> > +	case SYNCHRONIZE_CACHE_16:
> >  		fallthrough;
> > =20
> >  	/* no-op's, complete with success */
>=20
> This also needs a patch for sd.c to always use SYNCHRONIZE CACHE 16 for
> ZBC drives.

I see. Will prepare another patch and post to linux-scsi.

--=20
Shin'ichiro Kawasaki=
