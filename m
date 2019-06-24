Return-Path: <SRS0=MoT+=UX=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F55C4646B
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C7A20820
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="apsjnbLN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ryvNrKQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfFXV7i (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:59:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:55523 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbfFXV7h (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jun 2019 17:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561413577; x=1592949577;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=89qnUPe1Hm6Sg037lPrXbmtUq7w6kMxr9ibl0r7Ohuw=;
  b=apsjnbLNwwr/HKIFXSnOirlgENfNnP3y/9czIOm1cXtcSRLRiOqKRfnT
   DmLJ2WSMWhTi6iWDXJMsHWSQ8zp6wWuaR25vJ93gTL99b4Uca9z+D6Z0f
   nwZxdLXX1GYRsi6t2MhuJK6DZtfypcfcoqZmqdtgqAGh0/dImmBWMU9Ml
   iuU7DbWC8aoBPjWNg4tMySexXY2qKAfISXV3V9tP9IUCyecZ2jf0BzOUe
   YurLZoBr9Ql1WsqolY4ic5sJanCpxlWWVpHpjZwzeD0o0UkWpWqw6ofxw
   ZpZdHHjh28ZUbNV28UpKCySdfK8LbqsE4T9UO+CedYZMxAr/pv1ZFHLUl
   A==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; 
   d="scan'208";a="113056992"
Received: from mail-sn1nam02lp2058.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.58])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 05:59:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQkROcX1KEVTVmuIj/VaRVDPIDK3ZyZzRZ6nQiU/TKE=;
 b=ryvNrKQHjT1uZQKsT794MkNya0+K8PwieDxq6odgcMMyNetCN4skERAYGaa2f6RDW/xJ9/GbBHPeNGp0Tmu3Go55tY8vi5FSLVDFPKoU3SN11Nzp96dPVmhKOUxM0Z87/36/rgeXNB76K5b3TjVF8u8bGyXClu1YVcn5c5bmXl8=
Received: from BN8PR04MB5812.namprd04.prod.outlook.com (20.179.75.75) by
 BN8PR04MB5921.namprd04.prod.outlook.com (20.179.76.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 21:59:34 +0000
Received: from BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::8a2:c0fb:fa15:3f16]) by BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::8a2:c0fb:fa15:3f16%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 21:59:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] libata: don't request sense data on !ZAC ATA devices
Thread-Topic: [PATCH] libata: don't request sense data on !ZAC ATA devices
Thread-Index: AQHVKqp91IV3vhAQjUSE/ba9q8wvMw==
Date:   Mon, 24 Jun 2019 21:59:34 +0000
Message-ID: <BN8PR04MB581297B07BB104D3D3E85464E7E00@BN8PR04MB5812.namprd04.prod.outlook.com>
References: <20190624163250.GP657710@devbig004.ftw2.facebook.com>
 <BN8PR04MB5812F774A3C047B8899AD4A1E7E00@BN8PR04MB5812.namprd04.prod.outlook.com>
 <20190624205708.GS657710@devbig004.ftw2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7921626-af0a-4348-5a9f-08d6f8ef3e4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BN8PR04MB5921;
x-ms-traffictypediagnostic: BN8PR04MB5921:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN8PR04MB5921ED2D512F5F04D986DEF9E7E00@BN8PR04MB5921.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(366004)(346002)(199004)(189003)(4326008)(2906002)(5660300002)(33656002)(476003)(71200400001)(6916009)(14444005)(446003)(68736007)(3846002)(486006)(6116002)(53546011)(71190400001)(66066001)(186003)(102836004)(26005)(6506007)(76176011)(25786009)(14454004)(99286004)(7696005)(316002)(478600001)(8676002)(54906003)(72206003)(256004)(73956011)(76116006)(86362001)(66446008)(55016002)(7736002)(6436002)(229853002)(91956017)(64756008)(52536014)(305945005)(9686003)(74316002)(66556008)(6246003)(66946007)(66476007)(8936002)(53936002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR04MB5921;H:BN8PR04MB5812.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: okjZrzscXYXerWQgt8zi79W5AnbH229fMFnaid13WdcO63Y9279LbV1Nl5FR6/avqbwwRwOrnflYEk8YxF55cvX4paVZN/FXf06xSPjoP7/843SuwPITpt+zxNfwXf/naWXWRWJckbJkFJdw+GCvWjanFalOE1qi/wEdWvdRY2KcOFNZtwFdgN5JgAMyhUs0LHokGQCo0GfTzHCWf5Yt9+QWXWi85SArlZGBSQ6LDI+JQat87W12vm4pxQjJvPCd54hDtgg+R/eqHcE8IVAlnjma1OqPMbk2IYasEkVgUnek1LpSFqF9gcTnCcWLZUpEwo/17+CF6Txx3bzwVGA0baRUXKZhZWd9aGtcOAiu/3oX1NQXFiUgNPJkZc93HMaZPrHgkHeilqYibaqAr/+/NU7o/YZcwHM2myilDWQygsQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7921626-af0a-4348-5a9f-08d6f8ef3e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 21:59:34.4933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5921
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Tejun,=0A=
=0A=
On 2019/06/25 5:57, Tejun Heo wrote:=0A=
> Hello, Damien.=0A=
> =0A=
> On Mon, Jun 24, 2019 at 08:27:02PM +0000, Damien Le Moal wrote:=0A=
>> For NCQ commands, I believe it is mandatory to request sense data for th=
e failed=0A=
>> command to get the device out of error mode. So isn't this approach brea=
king=0A=
> =0A=
> Hah, that's a news to me.  We never had that code path before ZAC=0A=
> support was added, so I'm kinda skeptical that'd be the case.=0A=
=0A=
I checked again the ACS specs, and your are right, REQUEST SENSE DATA EXT i=
s=0A=
optional in general, dependent on support of the Sense Data Reporting featu=
re set.=0A=
=0A=
For NCQ command errors, from ACS:=0A=
=0A=
"If an error occurs while the device is processing an NCQ command, then the=
=0A=
device shall return command aborted for all NCQ commands that are in the qu=
eue=0A=
and shall return command aborted for any subsequent commands, except a comm=
and=0A=
from the GPL feature set (see 4.10) that reads the NCQ Command Error log (s=
ee=0A=
9.13), until the device completes that command without error."=0A=
=0A=
So as long as NCQ command error log page is read, the device queue will get=
 out=0A=
of error mode and new commands can be issued. There is no need for REQUEST =
SENSE=0A=
DATA EXT. I got confused with the fact that the Sense data reporting featur=
e is=0A=
mandatory with ZAC drives (that is defined in ZAC, not ACS).=0A=
=0A=
>> anything for well behaving drives ? Wouldn't it be better to blacklist t=
he=0A=
>> misbehaving SSD you observed the problem with ?=0A=
> =0A=
> Provided I'm not wrong with the assumption, there's virtually no=0A=
> benefit in doing this and that's gonna be a *really* difficult=0A=
> blacklist to develop.=0A=
=0A=
You are not wrong :)=0A=
Will test your patch on our test rig which generates (in purpose) a lot of=
=0A=
command failures on ZAC drives. We can also give it a run with generated er=
rors=0A=
on regular disks.=0A=
=0A=
Cheers.=0A=
=0A=
> =0A=
> Thanks.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
