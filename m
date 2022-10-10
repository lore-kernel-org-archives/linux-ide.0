Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5C8C4332F
	for <linux-ide@archiver.kernel.org>; Mon, 10 Oct 2022 17:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJJRKQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJJRKM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Oct 2022 13:10:12 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C9324F2D
        for <linux-ide@vger.kernel.org>; Mon, 10 Oct 2022 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665421809; x=1696957809;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JuhigA6TAqE3/IXYkeBeQZ5ufEaYvCQV2gOBSVxQUWw=;
  b=q6PiHHokQ9w2vIxO8DL0KEgGstkkIifBhL5FF3/o1+OPdaBHkwzgYPZ9
   oUEWF6NIt7mYQhbY+O+kMYJrGBYOBxT6224SRKpMDs2HiU7iaIYDAmM21
   jB9mtIJZsdnm/YDtZo6xoL425YDjICgyNGL4EpRmZtKqD9Wfuzus3kEbr
   PKqrpEtabLY21zJOWKfRqv//n0k5nmTTN8lxlQDuvtC4UYYN8AFqY4jYV
   QEpzbVFbps2MADwe4ZFSuXcl9hAo9nGcYtp3m8d7zCHgejlX7/HqRmkpY
   B1iN56dsLgNwwgomw62DWPHq7WkG3ml1kN6SbkvOUVsjcILtnKkhnuQel
   A==;
X-IronPort-AV: E=Sophos;i="5.95,173,1661788800"; 
   d="scan'208";a="213817844"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2022 01:10:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joVZ09twKgB3lKgLwLGOTmC8/yJWCFVgGrTLhXxx/OHg1zZb7jBFjuWzE24tyho9nRdZSqxANdqbPzdlJjgE3LmfoxZWJi7UMSqyRZGun70S3ce8EWKEYtvAeYgKKWIOT55P1P0LKE1pS/CREM834E1J4B11jsa6rBc/0e2TGKx2++EaialB9cwXUE0a2+Y279sQz1qsU+jIjPW6IYH6I163EH1RpzUshJXNbMNUF2yYVy1wYx7eiCGeIsJy5bMIYtLB+pdY5L6OTUn4VsoqyOt79Ct/UCa4dOZrQHN4RLcIDHmGmOYZvR88ItXQMz9ZC7cfokIG/rpyKX1qfrMopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuhigA6TAqE3/IXYkeBeQZ5ufEaYvCQV2gOBSVxQUWw=;
 b=ijl11tJTlpHKFlYFwDxAjLH1GaNk7rWJP3XY5hnfUbWy0FfkySd7ms64pjcnzfSu8iCxGt+KIOh9rCAGxh50vOFF4FwZjriopTDzpGF0ONKXJDV0TzjY1JSv7AAWYT+nqxrvagVsptJYTlLWL+B7Og4xuddu+IN3keWtPVVQPX3pp/o8I2NCMOkbGjEMY742UEjUo1uk7DTYFldOulzn2JxPOsEsFbvg7fbPXlTDBSjstcc60lbSpgQRebYnbB3ADwYFrQlpt7xWh0UXHy4SUB3cR0SJo+Hhsd0ab9jnbrGqUBuh3ig4/tqsMMaNwv4vB3l5cajWLRxrNaU7ZrKXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuhigA6TAqE3/IXYkeBeQZ5ufEaYvCQV2gOBSVxQUWw=;
 b=RsSkkmsA1zXQldQquUgtGyXgbygD8HD17M3y1WnyDA6Z/1IIc1GZW58UdJ5JyPkE5YeULMO/OTTSu/90QiDLB992it+GtYLJ4FR3VFlcY+KbcSc2sJBgdytt4XPKTQQLTlztplGK2T2jd4qOJpsBPl9wwxNY21F2vP2hSLgcJ2U=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BN7PR04MB4147.namprd04.prod.outlook.com (2603:10b6:406:f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 17:10:05 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425%6]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 17:10:05 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "john.garry@huawei.com" <john.garry@huawei.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 4/4] ata: libata-core: do not retry reading the log on
 timeout
Thread-Topic: [PATCH 4/4] ata: libata-core: do not retry reading the log on
 timeout
Thread-Index: AQHY2lASv+7iCIC+ykaulTTyFRIDO64DhSIAgAAUp4CABEfdAA==
Date:   Mon, 10 Oct 2022 17:10:05 +0000
Message-ID: <Y0RR7Ps9hDg6sCbz@x1-carbon>
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
 <20221007132342.1590367-5-niklas.cassel@wdc.com>
 <ac65e0db-05a8-65a1-4439-c1021e23d022@opensource.wdc.com>
 <Y0C6pUSjHqIZF0Hg@x1-carbon>
In-Reply-To: <Y0C6pUSjHqIZF0Hg@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BN7PR04MB4147:EE_
x-ms-office365-filtering-correlation-id: 1d0cb8d9-85e7-49d1-9e17-08daaae2470c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUAwLSTVmtLysEcv8FmyeZ/L9jGPMwF6jat/8OxdPFVpNcnB18j+4zChvOfcN7FG5eUxwWNJBrKgnySyA8/AXVgpOTH0lvAVxJoUdObAQMw4sJEcCNe9uyOk3fJ7/e+Aa5pzuV0h5LEZt2DlPav+3BTt0yd17Ecf1bHEXmNMj/zogF+oFzJ4bapaCUNuLDLt/+TUiCtF/6rdkJfcG6EFtBFko98osPAEeT0OV3abtQy9wFINAfujFNY22jVz0BON96jz4tfjtq31b9CL6sDm78K6zEwAv1XOlCs6iAhmEtf6OFvNrFztu0EaxZiXNx5xgbY+V6FsH0YdXjxfm6vt/OsP+Jm8MaJujYw8Ts+ReUVlfcNU2z1J6viNcTX9gBqaF5Tg0pFbRuaa3tLElNH9aY8eNF7hi2FzNtkcA7FDjo9h8fXpjIZ1GF6ztm1zvzeAANf5RMa3Ks3sjiUWjurjqEqA4mOjPE97N4Il9gy9mNtvL1are8m/Oe1vjO1dIgu1iTmQX9Gce2Gml1bxX3NfTFuBf/zlglROGBDfnZp/wHBcJExPRmhMH0Q3h/z7ju+DxX5em0HYjEWdn1ETZ92ME3KjMLz0RT0s2x1h1vEbII4UX03IOogKH9Cj1mbSgi0kLOWY4SIWQiqt6WdCxHVIX3HvRERiraQBBt0BIc4JSW74OLdOtbEoVjb/PNQqRZyRt8uss5eOrVww9dBW00RXV01eE1sdvueB72HJbgRpaziSZ/Ht2Y7EDN/Kyb7UgI58vuxpa7BwjQkuguNyZkJO5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199015)(2906002)(66556008)(5660300002)(66476007)(66946007)(8936002)(76116006)(41300700001)(64756008)(66446008)(8676002)(4326008)(91956017)(6862004)(6486002)(122000001)(86362001)(33716001)(26005)(38100700002)(82960400001)(478600001)(316002)(9686003)(54906003)(6512007)(6506007)(71200400001)(38070700005)(186003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oc+sQm1rumD4Ioc34YgzdYFu0zpHFO53Rt05erS3nqJ7skUXiu7MgLtdhTx+?=
 =?us-ascii?Q?wUhy+aJHWHt7HFhQmZ6alVjt7ykviNapHMYDpUibW0UjryqUmsZLztm6/NqV?=
 =?us-ascii?Q?SyWcSM+hDzq6kpBLCzkD5LM3sy+vf04/n+EoRHSb832Ag99k0LN2chHLbrbI?=
 =?us-ascii?Q?rcqnoyR2WHfdIwilBolzpnRZhPUDNvvshyRfhqWQheeGZs8Vazj/bs2n915D?=
 =?us-ascii?Q?KhfTtTy6Wdn3zt3T4NMmmaReopqY4bIjlSX+lvT8En+i+a5Yuc+Rh9IJ8LPt?=
 =?us-ascii?Q?W90NNhg6tkqYVccYXKUzcbsqlrXV4NLGOWMmgwY6C5LVYBEss5NwUZVaYqfX?=
 =?us-ascii?Q?XhDm1EbQ7JAC5y9G9YCvdxpmFmBOmwKqaE/tvafqBFbwvfDEXC7SKtwrnZ1s?=
 =?us-ascii?Q?x87JsCRpVk+5s5ZIGAOzmajC0AVTyiz7SJdOhIVlQ1AdmMpTouNTUGnL2Trs?=
 =?us-ascii?Q?kNpeUqa0FUMJLH/0eDRnPYOttD85IR5TtpKkXKFsOWLZRPGKafFycxmEyzyI?=
 =?us-ascii?Q?+03Wk7n0ERT7awMsthF7LnfsWuahdeWeiLqEunG+by90g15B/EuP4qBT01AA?=
 =?us-ascii?Q?KdcC+GCK+AOdEVY+SMQsxgyFuWCuDMuj9WlbWLGnGmQysM05P+RXcX9u5Kpq?=
 =?us-ascii?Q?5MPiQOfnKd7IWjWOllCeZ48lHgZGrRQe7mDEYm92+EYH6zWvUKVtfarBHHDM?=
 =?us-ascii?Q?yubB6pwyP7fhWlXT+wghTraiVSM3fW1HxI6takVVQL7d7VSaEovyf/T6+scc?=
 =?us-ascii?Q?zwrF4Dfm/6J1UnRmiUL/PWUJV31RX0iRMMwsD2Z+x6hDV5aMDGDlrlXZ1kLQ?=
 =?us-ascii?Q?HkdLgWJjTqz4HbX2wSIkRDBDatPXDv3KnbpGNw+RKPqvdnJuRrjpEO9Jq1uo?=
 =?us-ascii?Q?JDRGwbJXZ3JhRMPdUtSvn2XA29grgGx6vjGfED7yJJlwkv9Qo7RSrk1pJS5W?=
 =?us-ascii?Q?DPnIptMN9nNqmFBCbKWFaJtFwXohnR0l7EaWg/69r8V82bgGFDO0n5cv8UNe?=
 =?us-ascii?Q?02JKIkEfWGlbXDPROXedt/DKHZ9BsAVU6ehxwRcuL6eVvGMXLkWnNZWNVsXm?=
 =?us-ascii?Q?f8i3/zUky+2x0mgqYyWGHaMpWNKdxd11ox3FU6ozA8u6m+PsWgz8cA2ngT12?=
 =?us-ascii?Q?WzG2MZCMbi9+2qRq7IqZWPSfTpXW2LOaimR65F8wum4FYa44GC8J4B8eNJtx?=
 =?us-ascii?Q?DdEqXl515D9Co4GkvZ9xuGLxvuWDtaPoaWhf3u5KogQYrxXHE73KknzCr8/j?=
 =?us-ascii?Q?t5PJx5BXyq1tp1uQSwGfDFCH/BsHdCRIOqQWCgIv4RK5Ax2p8QzcWBbrfPBN?=
 =?us-ascii?Q?RGUY/Lzv23WbzYwdibZl1xGy2FRVi2XSahxm9CPksTQnm9RnHQXNT7NNz2v8?=
 =?us-ascii?Q?iX20jC6zWJ95C/8xIAEIAWoHh+KbLtsOrfeCxslvQ91hODiFIDYXbxrwkETd?=
 =?us-ascii?Q?uBV7m3gsp6oiRyjgIVWHJ2pS3UjQbQqovAYuXgywGn+cFweknjDmzU510FB/?=
 =?us-ascii?Q?oqEtJvltu2ibgOSOM4NnGWZ8Yeb04f1PU3BRqcWyvVvd7nGu8nDLL/a3UIDm?=
 =?us-ascii?Q?jCKtvGU9SYMVsa/V345xzXzs0oTWAE0tzcgRXwRxrv8UL+gJD2xpJKdeKWTN?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4F45F6C969CBE4B843B2E3C03C90474@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0cb8d9-85e7-49d1-9e17-08daaae2470c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 17:10:05.7217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfW13F8PIqDbK1yQmjuxhjhTf10fJi0QCmNr5VeiK0FQ5ORt8kJy17NxSXzRn2sjIEF0r9nZvHGkkG8laCYFwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4147
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, Oct 08, 2022 at 01:47:49AM +0200, Niklas Cassel wrote:
> On Sat, Oct 08, 2022 at 07:33:54AM +0900, Damien Le Moal wrote:
> > On 10/7/22 22:23, Niklas Cassel wrote:
> > > ata_read_log_page() first tries to read the log using READ LOG DMA EX=
T.
> > > If that fails it will instead try to read the log using READ LOG EXT.
> > >=20
> > > ata_exec_internal_sg() is synchronous, so it will wait for the comman=
d to
> > > finish. If we actually got an error back from the device, it is corre=
ct
> > > to retry. However, if the command timed out, ata_exec_internal_sg() w=
ill
> > > freeze the port.
> > >=20
> > > There is no point in retrying if the port is frozen, as
> > > ata_exec_internal_sg() will return AC_ERR_SYSTEM on a frozen port,
> > > without ever sending the command down to the drive.
> > >=20
> > > Therefore, avoid retrying if the first command froze the port, as tha=
t
> > > will result in a misleading AC_ERR_SYSTEM error print, instead of pri=
nting
> > > the error that actually caused the port to be frozen (AC_ERR_TIMEOUT)=
.
> >=20
> > Beside ata_read_log_page(), are there any other path that do a retry af=
ter
> > ata_exec_internal_sg() fails ?
>=20
> Let me check and get back to you.

Hello Damien,

I couldn't find any other caller of ata_exec_internal_sg() or
ata_exec_internal() where this should be needed.


Kind regards,
Niklas=
