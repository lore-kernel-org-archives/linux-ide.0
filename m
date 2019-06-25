Return-Path: <SRS0=oJiQ=UY=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCDBC48BD4
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jun 2019 12:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55842214DA
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jun 2019 12:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PIZZzz4l";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="O7pzcdro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfFYMZR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:25:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:37030 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbfFYMZQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jun 2019 08:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561465604; x=1593001604;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vzefx/k1fEY/TqyXXAdmlSg63Z7yKxnq5bAFg2MOUv4=;
  b=PIZZzz4l2VtkE5HmdDjWG+EFR+YafeIn/0S7Wel8ZvDi+f9V6dm0nusq
   k93qRt6kgnnibEBBQBYjzMcg2XSaijsSTYO4CoF41olybwJPDqVzZHp5a
   EuyJfYI+l2wNN5lUBQyF2q7XxIhSpaWu1GcXaSpNFF2rbeSwGzbRtDhan
   1ypWRnPMU8LcN1DLOJ+XRP6K4+u6Z3AQUvjwd4AA3s+MfHMw3UF1yRMCk
   bh46j1kyq0yxzPCfa0wePVlTd4VFz/xbN+2muwzWwXk8hTA9Crt4xKW7o
   AKUwxCHkf7TOO8crz6FM5cHZk2Ej2t2sSPWZhgaxROmkprsHIwyyP/nUR
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,415,1557158400"; 
   d="scan'208";a="211276112"
Received: from mail-by2nam01lp2053.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.53])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 20:26:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rK5SVZSypFZx0mE8btxGWmm5+q3kwB+JQIUyUvMEHs=;
 b=O7pzcdroAFTkhBTTRgCOpeEAezSsz0muJHsc6hbBQXBJHtDpVRVV3jZJvzMuAKx2aQeLFb3DYACnMH04J2s/wfnEq8XNsRv9Gg5kGo/DGkfnwwMd07QBr1Hp2+BmKIVmV6W3/0WDNhi39Hjzozf838mPoTjCEfRnynxk1ZhTwkE=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4213.namprd04.prod.outlook.com (20.176.250.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Tue, 25 Jun 2019 12:25:14 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 12:25:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] libata: don't request sense data on !ZAC ATA devices
Thread-Topic: [PATCH] libata: don't request sense data on !ZAC ATA devices
Thread-Index: AQHVKqp91IV3vhAQjUSE/ba9q8wvMw==
Date:   Tue, 25 Jun 2019 12:25:14 +0000
Message-ID: <BYAPR04MB5816C4E303F86D724028B1CCE7E30@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190624163250.GP657710@devbig004.ftw2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13b628ad-9b81-4fab-8815-08d6f9682d0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4213;
x-ms-traffictypediagnostic: BYAPR04MB4213:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4213BD977160064C04E292E7E7E30@BYAPR04MB4213.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(366004)(346002)(396003)(189003)(199004)(52536014)(73956011)(76116006)(72206003)(91956017)(66946007)(2906002)(14444005)(6436002)(256004)(66476007)(33656002)(4326008)(486006)(446003)(6116002)(3846002)(66556008)(64756008)(229853002)(66066001)(66446008)(71190400001)(9686003)(86362001)(53936002)(55016002)(8936002)(316002)(81166006)(81156014)(478600001)(71200400001)(14454004)(99286004)(7696005)(6246003)(26005)(8676002)(74316002)(476003)(186003)(102836004)(7736002)(305945005)(68736007)(54906003)(76176011)(110136005)(5660300002)(6506007)(53546011)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4213;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z0SQ3h5RbCfm2n28Dzan4vRRrS44JjE8RcTily9jfzUiodzseDfTg75Kbby45DO9G5xJSi5Whb9TeSgsAki7NEcYgnPK7BonfLJbYM1FkBmZZlienHzCEsVorvcTygNGTj6iUlepYPDAfL/Ae1UgMUJ8//27nmU7YhQR7JlzM6wKiX1qfJzDSJys9I7ZIb2rJplsdZWyON7CJRH1f2lgwFLLlnsywUu+8z6YW+oU4m0cFB6C/a6164hzgJ72se3NejXolMnxSokSWqx/KW2fNLMldOFjdYGyxXc9Jwp7aHq0bFnaGVK6/9LzlZXjd5SuAc1w/TeArlaIqwWTYzC3AgJBryALCvWkYmNOB4SvcvxlAOycXkugMSoYGhAyNBBXM2byUKxo/h3O5gf+5KVM4yyXDfIkixhkZlqWZH5Faf4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b628ad-9b81-4fab-8815-08d6f9682d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 12:25:14.5265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4213
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2019/06/25 1:33, Tejun Heo wrote:=0A=
> ZAC support added sense data requesting on error for both ZAC and ATA=0A=
> devices. This seems to cause erratic error handling behaviors on some=0A=
> SSDs where the device reports sense data availability and then=0A=
> delivers the wrong content making EH take the wrong actions.  The=0A=
> failure mode was sporadic on a LITE-ON ssd and couldn't be reliably=0A=
> reproduced.=0A=
> =0A=
> There is no value in requesting sense data from non-ZAC ATA devices=0A=
> while there's a significant risk of introducing EH misbehaviors which=0A=
> are difficult to reproduce and fix.  Let's do the sense data dancing=0A=
> only for ZAC devices.=0A=
> =0A=
> Signed-off-by: Tejun Heo <tj@kernel.org>=0A=
> Cc: Hannes Reinecke <hare@kernel.org>=0A=
> ---=0A=
>  drivers/ata/libata-eh.c |    8 +++++---=0A=
>  1 file changed, 5 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c=0A=
> index 9d687e1d4325..3bfd9da58473 100644=0A=
> --- a/drivers/ata/libata-eh.c=0A=
> +++ b/drivers/ata/libata-eh.c=0A=
> @@ -1469,7 +1469,7 @@ static int ata_eh_read_log_10h(struct ata_device *d=
ev,=0A=
>  	tf->hob_lbah =3D buf[10];=0A=
>  	tf->nsect =3D buf[12];=0A=
>  	tf->hob_nsect =3D buf[13];=0A=
> -	if (ata_id_has_ncq_autosense(dev->id))=0A=
> +	if (dev->class =3D=3D ATA_DEV_ZAC && ata_id_has_ncq_autosense(dev->id))=
=0A=
>  		tf->auxiliary =3D buf[14] << 16 | buf[15] << 8 | buf[16];=0A=
>  =0A=
>  	return 0;=0A=
> @@ -1716,7 +1716,8 @@ void ata_eh_analyze_ncq_error(struct ata_link *link=
)=0A=
>  	memcpy(&qc->result_tf, &tf, sizeof(tf));=0A=
>  	qc->result_tf.flags =3D ATA_TFLAG_ISADDR | ATA_TFLAG_LBA | ATA_TFLAG_LB=
A48;=0A=
>  	qc->err_mask |=3D AC_ERR_DEV | AC_ERR_NCQ;=0A=
> -	if ((qc->result_tf.command & ATA_SENSE) || qc->result_tf.auxiliary) {=
=0A=
> +	if (dev->class =3D=3D ATA_DEV_ZAC &&=0A=
> +	    ((qc->result_tf.command & ATA_SENSE) || qc->result_tf.auxiliary)) {=
=0A=
>  		char sense_key, asc, ascq;=0A=
>  =0A=
>  		sense_key =3D (qc->result_tf.auxiliary >> 16) & 0xff;=0A=
> @@ -1770,10 +1771,11 @@ static unsigned int ata_eh_analyze_tf(struct ata_=
queued_cmd *qc,=0A=
>  	}=0A=
>  =0A=
>  	switch (qc->dev->class) {=0A=
> -	case ATA_DEV_ATA:=0A=
>  	case ATA_DEV_ZAC:=0A=
>  		if (stat & ATA_SENSE)=0A=
>  			ata_eh_request_sense(qc, qc->scsicmd);=0A=
> +		/* fall through */=0A=
> +	case ATA_DEV_ATA:=0A=
>  		if (err & ATA_ICRC)=0A=
>  			qc->err_mask |=3D AC_ERR_ATA_BUS;=0A=
>  		if (err & (ATA_UNC | ATA_AMNF))=0A=
> =0A=
=0A=
No problems with tests.=0A=
=0A=
Tested-by: Masato Suzuki <masato.suzuki@wdc.com>=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
