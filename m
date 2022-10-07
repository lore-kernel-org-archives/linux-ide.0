Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED90C433FE
	for <linux-ide@archiver.kernel.org>; Fri,  7 Oct 2022 23:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJGXr4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Oct 2022 19:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJGXrz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2022 19:47:55 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3C3748D0
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 16:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665186474; x=1696722474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m2Pp0Oyk+KLHb/oK5jN9KoxstGgcClx7BLVCLDgnqIc=;
  b=XS4h6EAx2loitRQoTp0lk5InLMWuMDVVL/xEILYJiES6uXVsQ+TwFv7q
   QBlbICHx19BzLqi2gn+qcQlKQe/RDLH0v7jP0+kHKo0KmwaPFGZWvixo7
   jduMpZjFcaIPhtgRsqypENHSQJo0CVDIwrZ28uAfxe1B6B6hVN/gKFpmw
   ZHXF+nV6PptOxuqTxv5Fm5MhK0W5iu5bEfZpvQXKAxlyXR4TDWePx+WnH
   Owlb+jWl6c+8yjuiDwbUlirJYLrvnrz4r/0U36bW+yyWVpfzE+ia3BPr5
   a8ZtPdX5K4qj9KWAntBZLc37+65zm0KsOsCa2ty9cQI0HW/u6OWeOJph1
   g==;
X-IronPort-AV: E=Sophos;i="5.95,168,1661788800"; 
   d="scan'208";a="213671459"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2022 07:47:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heu/u9MseTfDld4D9tQbfZj7K6n0QMv1GmSx61VNZBmxSYtprwafydfOhajIEMRO8q9lXSSTznXiu5IQT+gRoOYH5/nOY5PeH9BydguWg7a+tLw8mgnBWi1fHjBnFIrI+Utr0WXHB19mQqrKmHOTIRIDqyHJOWFpbZb7tKGX1342UG3QAdZxw/VbJxarZ7bX45t7pkqvQfpS/EzamX0kO69PQXUJ8MfFY8Qb7b3P9MZE76MEpgOh1sPXUsNABvWhgVnJ0hcM9SJPMNDH3Ng+Zi9PTR6b3tCdyKY8sB8QQgh1a7oPbTsQscMChA7p8AzagH3v+cVCZmXHCh85k1VUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbsfqdZcmMMkdlmVHvx4Qfwd3MKatVpY/r68UT8mbT4=;
 b=BBdBcH0B5C0euE2ral0JQwSCNUvS2xgJJ3GXihibD1RBGs45Et17Vc2Dp8CrUGEBoKG8BLlvwFUUps8cVaEg5G2pkt64L8hrMaus03r6A/3Jf/mOQQfXMp76tPREzD9ddVjcVTCWijNUdXzs2vNg0MwZXNLL8JlON+oGh00Z/XKBsJGQi2Qjy69pIK7PjNSesX2gnao2aBzfrJpBmqNsqjKKPXmSx8xmIS7dU1TR/Y5+TRh/boP1moiFd6PwjggqsX55+kX4PjE8MXNb4R66Fu2E6amdNommoPM2VPPlFa/J9dWzzb+wBkv6ZT5dffnG/dfmPP5XcUpWdDt0Pip54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbsfqdZcmMMkdlmVHvx4Qfwd3MKatVpY/r68UT8mbT4=;
 b=eCqXvw2uVlBXpApG7TTSaAsItFr1rj2MV8vBaCPBJDVnbgGxiP8ILYVzMHsvE8lSidKi98ItadBt+fpsk2R+o37GqK5ObTx/85b2mKrzWauMF9nsF/qx3ju/SOMKVONXR2mJUBg1nrV/Q43Hzvcuexx1M3n57phI4jw6MhFpAqg=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BN8PR04MB6305.namprd04.prod.outlook.com (2603:10b6:408:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 23:47:50 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425%6]) with mapi id 15.20.5676.028; Fri, 7 Oct 2022
 23:47:50 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "john.garry@huawei.com" <john.garry@huawei.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 4/4] ata: libata-core: do not retry reading the log on
 timeout
Thread-Topic: [PATCH 4/4] ata: libata-core: do not retry reading the log on
 timeout
Thread-Index: AQHY2lASv+7iCIC+ykaulTTyFRIDO64DhSIAgAAUp4A=
Date:   Fri, 7 Oct 2022 23:47:50 +0000
Message-ID: <Y0C6pUSjHqIZF0Hg@x1-carbon>
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
 <20221007132342.1590367-5-niklas.cassel@wdc.com>
 <ac65e0db-05a8-65a1-4439-c1021e23d022@opensource.wdc.com>
In-Reply-To: <ac65e0db-05a8-65a1-4439-c1021e23d022@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BN8PR04MB6305:EE_
x-ms-office365-filtering-correlation-id: 86e7b34a-a267-43cd-2d29-08daa8be5876
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +HLOTQyr4jg2D20/W6JfE0VAe6dQK0R4zn9AHQ9VS6S/qNrxgZxdLVsX8z359QdJCkI2KpHWuzNLCkuBHQ9eMdMl17+N2AiA9EgR7KQRJYFt8o7ZpEmC1RSfAELG3i4cOz2apwFPQeiS9kcki3k5yMoJHoGHyR7RmWSzCbtK5ZE2q0AqypgapUFqENsxVkTq19f+CpAIEpAtDm9ZI1Pyr6HOC6zyuqSPkoNpCmJknVcpMj0E/0aaOy9SBO5wRZi572cU4WuFktYYO8iPIN2bLN60LeT3oo/jQohsxnyMeSJwWxAfAJYb3Ng4jrulD6HbqOgUa/aLJAeIHonmXW2ur8esMNV2saEUhcpcv4aWIMu83aV/FBn3ZTPjsYIecvVlyNtH8VM1aPIDOudz9+0C6ppc/BjhiCBLgaYnGkJPfH8deZkuFPnMtQQksC+fzJtho8I1AzS8n5YjoSF54Ta/FlgKSxACI/cWeg1Y3SxnUO0Dp0qidC2us5OPv/UgUURwtm6wydkfpAFo8SUhVmicjsEByBQF77qmm+csDh3BRS/F4672rQ2nTenMwYVu6LNI+/FeIO/aTuLJYEAvjDKBdjMNfBvODrOAxIEyWsJ2TaOEFjI2lpJsGrM5xBf4IfSNDU7U72zqWEVl7Y35POYHk9ygIDdV54Jcu0PXoC8yDv92G6q+dZgWF8B55y4YshJAIKyIH2z0p2svpzlpB4qPdoXvczuKMJ114YOMOtkj0NTwGhpLjkQP3/xwRQ0ctTvwtKqo9TZJq6xnsjPw522+ORGxHNiqcmMoXOolENA6cWA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199015)(38100700002)(33716001)(54906003)(122000001)(86362001)(83380400001)(26005)(82960400001)(9686003)(6512007)(53546011)(6506007)(71200400001)(186003)(478600001)(966005)(316002)(38070700005)(6486002)(5660300002)(66476007)(41300700001)(6862004)(91956017)(66446008)(8936002)(64756008)(8676002)(4326008)(66556008)(66946007)(76116006)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jFOHPsCnnEiCNcARzoA2UgmiGIVRqESB7r62NzoPeSM7yS9roDwU06gUNMDm?=
 =?us-ascii?Q?2FWKHsGnyJGdIH3yJir5QFTIFWhx+xxdgGocXMC6XsyA9vkBUidA50CNAc9A?=
 =?us-ascii?Q?vbVK6s9QZAUPsGSr2WL88t0TaszhBt4+k3s6CJhrtPnJhBC2SUS5e/WmTzh+?=
 =?us-ascii?Q?YTbDGf/4B2+LcNP0j0j+68iDfdGuSjY5bKG4AWGJQvs6wXPPPft36A2nC4pA?=
 =?us-ascii?Q?EKFlEcEPkbbqk84+SsYhFn/DLjutGgfPQ1oZ+j9xL5Av1OyrShwqH7h3qIqS?=
 =?us-ascii?Q?cM2Fwbhc39/9pTWTFrOSv8PqGOLN4iIeyIsKre8nZWtqQj0R5dZAws+rSoEx?=
 =?us-ascii?Q?O2U/7LmWPlPm3RXpEJlRMy3+8AoxEitpgE3rvEXfe6vKi8grs/3PFi3xOtkv?=
 =?us-ascii?Q?omGuAtkjgOj/ZpGEjEvF9+S9SWJhPLefyH5bcw/hxYhR3HOjXqalWt6Mtt7b?=
 =?us-ascii?Q?yWVT5el0jvkydzJEOEw8NU+0GRR3ceyNelHbm0CGa6V2szqWLTA46+M3bOvd?=
 =?us-ascii?Q?WfEthEWARfLqfPgtdAvECn3Jn7wHrVXQv+ziYrMR5GVnxmwItqLaJ+UKPKrF?=
 =?us-ascii?Q?G80XSS/0NWV+aLxFTDvIcsGVG47Gc1Zi3x3mcOEKlfWa5LuEy2b1vAmvYzw7?=
 =?us-ascii?Q?ScuoyUJ94smXtlCqmGRn7i4C3RZ7LgpsL2HM5cYqRzpwtsX6GJTw1OhLr0Pc?=
 =?us-ascii?Q?nSUQWJ1NuGXl20Hk5HDoXQQTM7hRSU6aFVKP8QXdjmG/cw0arVyI9NKcCA+Z?=
 =?us-ascii?Q?nXisdUL/D+YN2azTM5rRKLavUaAyyMajfXF2au2veJ78cgr0bVrMgKf9Fw88?=
 =?us-ascii?Q?o0O5M5+ZGVwifJVPW2FGc5qq+cknqCEL+YbsrapcBNdcm2M/VUVqVSGJl+6D?=
 =?us-ascii?Q?6vNry6o5HSFdCfNtxGqOrzXhLOBgOBN8NgHnupia2RfWnpfLU8qsJbCdEDKn?=
 =?us-ascii?Q?TiIDgPmllluLhkmQzHp6AJ6loelZ40P9XQJGSh/cmNUvC+Q6RBEF+1KSPt5E?=
 =?us-ascii?Q?zw4zNuTafcgAD/8bcPqJKHYlUGUmKlYkQnTBBrI6UvrOixrBvW1A0UPrelxv?=
 =?us-ascii?Q?MQEAWt5gxK2pzgiMR+lg8mCEsRxBHZsMURDFvIWhu9AmACZai5c6GFzV09UG?=
 =?us-ascii?Q?vWG8p7OzjKtCO5KSFjfSVfTPW3RAAzzM3f3k5rpqbasnbeMdCY39Axnco8yl?=
 =?us-ascii?Q?UM7F7k18FoQjfCMZxnYduXPwisALhnIdxyR4YZEWs8SKU76RJE86nwQoi8eG?=
 =?us-ascii?Q?1KddW7LXRyX2xrmcv2hutw8i8RGa3YojAFBEdHhPYLeRNcW+FAUgLyoJJSRf?=
 =?us-ascii?Q?7MX6EdZ6GgnBP4J6NDQHx4Z7Rmd9xMVUX1ho8MI+LhjmyAQDLH9nQWPg000H?=
 =?us-ascii?Q?6uSjB3zGqJdAC/ntfH7rWfj+SEvkb6mHqHKFiMprPvXJYX8RrOpzL48IZ5zL?=
 =?us-ascii?Q?lzxu45lgUUjSIG4o7Lb+/Chk/qRKVRkLrn0gI0wCvrg9UZJej66MIDXQaO7Y?=
 =?us-ascii?Q?EhxgEkoUR1dHCs3UaUqUcG+7c3/RmGfj1rPAB8Ze6VSPGVbVaMSFwkxmc5fW?=
 =?us-ascii?Q?m9Mw6O485OTUVOmp7ZszWAfUXbTZW0BKaHEE4GeA3lQnQ3f51PVb/EWYAuvV?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D66DE8B1E58B74E9152B4594D8CC090@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e7b34a-a267-43cd-2d29-08daa8be5876
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 23:47:50.7582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZvvCh9WGiC8P/aExz0inGtRMjkk0ePx5Wz8XnLGBLUByLLXpyd15nGmRELJICQvKwbeVrgVzBFiheZ9aL+fQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6305
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, Oct 08, 2022 at 07:33:54AM +0900, Damien Le Moal wrote:
> On 10/7/22 22:23, Niklas Cassel wrote:
> > ata_read_log_page() first tries to read the log using READ LOG DMA EXT.
> > If that fails it will instead try to read the log using READ LOG EXT.
> >=20
> > ata_exec_internal_sg() is synchronous, so it will wait for the command =
to
> > finish. If we actually got an error back from the device, it is correct
> > to retry. However, if the command timed out, ata_exec_internal_sg() wil=
l
> > freeze the port.
> >=20
> > There is no point in retrying if the port is frozen, as
> > ata_exec_internal_sg() will return AC_ERR_SYSTEM on a frozen port,
> > without ever sending the command down to the drive.
> >=20
> > Therefore, avoid retrying if the first command froze the port, as that
> > will result in a misleading AC_ERR_SYSTEM error print, instead of print=
ing
> > the error that actually caused the port to be frozen (AC_ERR_TIMEOUT).
>=20
> Beside ata_read_log_page(), are there any other path that do a retry afte=
r
> ata_exec_internal_sg() fails ?

Let me check and get back to you.

>=20
> Another note: this is patch 4/4 but I did not get any patch 3/4...

It is here:
https://lore.kernel.org/linux-scsi/20221007132342.1590367-1-niklas.cassel@w=
dc.com/T/#t

My scripts probably didn't add you since you are not a maintainer or
reviewer for drivers/scsi. I should probably have added you manually.

>=20
> >=20
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> >  drivers/ata/libata-core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index 1cf326dd7c41..6ae5787103e7 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -2000,7 +2000,8 @@ unsigned int ata_read_log_page(struct ata_device =
*dev, u8 log,
> >  	if (err_mask) {
> >  		if (dma) {
> >  			dev->horkage |=3D ATA_HORKAGE_NO_DMA_LOG;
> > -			goto retry;
> > +			if (!ata_port_is_frozen(dev->link->ap))
> > +				goto retry;
> >  		}
> >  		ata_dev_err(dev,
> >  			    "Read log 0x%02x page 0x%02x failed, Emask 0x%x\n",
>=20
> --=20
> Damien Le Moal
> Western Digital Research
> =
