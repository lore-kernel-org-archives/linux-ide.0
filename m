Return-Path: <SRS0=MoT+=UX=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8D5C43613
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 20:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEC520663
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 20:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dEP8eetD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="l8hfj9Iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfFXU1z (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:27:55 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30563 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfFXU1z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jun 2019 16:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561408074; x=1592944074;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5ywFRRjH3PlHxeRRwmth8e++u2GFVjReQzP5pX/vit4=;
  b=dEP8eetDBYLHs8wdg4DF7LtlpgqyCNgX/DpU4Z/qyx94d4+NBJtOkKB/
   W690svQ9WTSuz1xvSvE9p4yY1/81wOh7eLyl2gA1r9kXg3dZMxcPjSo6Y
   MbEl7EGxK56gYzjPw8Dog00G5XuQV9bG9kUnAJwPARm6XUO42a2MTyFVz
   qGCizWdRW6QaXc7nc1IMrNfuwJ1C8Ou4hzBBiFluE41rh9d2zSwQgzGJD
   Ix3wzQqDmNgsafm92HkZ8T83BhHtJXNGIsvSrhcKr5xvum+QTDfNVEaav
   nsaEK0/YubRxoMncADVTegGWRYjAKmCvF//tAYDkTD74BFhQblDsYzlS3
   w==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; 
   d="scan'208";a="116301876"
Received: from mail-by2nam01lp2052.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.52])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 04:27:05 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfFQe4MUo0nYKZ89xeV22lplFwfcqIemnbbrNFdWf0Q=;
 b=l8hfj9IwDOmaSW7tJAAL7OWnA/y6FAG+Q/gAp+hHisFtS8FqnxLgZPMyWxgkAdNLwpnh/j07wCtpcCVRLYL3vDhHmmnPRN7Sw2DFjuf6xxQ2eumtVYqDlezK66rl9QkYB4ZBSPtbYQLfrz1oWhYoSsAtmuLrFTN9+kCBJPcygqk=
Received: from BN8PR04MB5812.namprd04.prod.outlook.com (20.179.75.75) by
 BN8PR04MB5538.namprd04.prod.outlook.com (20.178.217.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 20:27:02 +0000
Received: from BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::8a2:c0fb:fa15:3f16]) by BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::8a2:c0fb:fa15:3f16%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 20:27:02 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] libata: don't request sense data on !ZAC ATA devices
Thread-Topic: [PATCH] libata: don't request sense data on !ZAC ATA devices
Thread-Index: AQHVKqp91IV3vhAQjUSE/ba9q8wvMw==
Date:   Mon, 24 Jun 2019 20:27:02 +0000
Message-ID: <BN8PR04MB5812F774A3C047B8899AD4A1E7E00@BN8PR04MB5812.namprd04.prod.outlook.com>
References: <20190624163250.GP657710@devbig004.ftw2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c085ea90-8a67-46f8-320d-08d6f8e25117
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BN8PR04MB5538;
x-ms-traffictypediagnostic: BN8PR04MB5538:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN8PR04MB5538E256CA62E59A3B5E28A6E7E00@BN8PR04MB5538.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(6116002)(74316002)(53936002)(186003)(72206003)(86362001)(76176011)(7736002)(55016002)(4326008)(9686003)(53546011)(6506007)(5660300002)(25786009)(26005)(71200400001)(71190400001)(76116006)(305945005)(91956017)(102836004)(33656002)(66446008)(66066001)(256004)(14444005)(66476007)(64756008)(3846002)(66556008)(6246003)(110136005)(68736007)(99286004)(316002)(7696005)(54906003)(2906002)(73956011)(66946007)(8936002)(478600001)(14454004)(486006)(81156014)(446003)(81166006)(8676002)(476003)(229853002)(6436002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR04MB5538;H:BN8PR04MB5812.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2PWiew7o0T7pPh3lCZvh3ymaeNruUdmTQyZjlpYYB97qUuE1bp8VncBky2KYTp4dR/mx4TZu7pYJ0CDBNVualjpoV/xWDcdXRXML2eN656UuxHwMi7kiFVIgmCk7j7tBFXUk5FjBOtFcdV7lFx7ILE/B2VvvrhfwXIXgRVjEEI1iyqSKPoegl+CbQgwjagmLxRL9Y6IrDO1O260xyOB3hHINhGvyW0mSde9UGwzelQ9IR5UJ3TEZnOnoNqDxXewwqy7INL4WK2xi0l1d7Ad/BOOf33zv7u9f0fTsldHW5XDvZ6ab8ol51vDkTtMwLkFqJcgVCfcJh6lG+D5LB/lqt82XAfFmfRX3Tlji2o9pOrNNlw5lf/PpdkxRNQzzdrEOJxpU9VUXue8J5VPWZFgiFffpLTC4qKpulBh07Xx+vJc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c085ea90-8a67-46f8-320d-08d6f8e25117
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 20:27:02.4287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5538
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
For NCQ commands, I believe it is mandatory to request sense data for the f=
ailed=0A=
command to get the device out of error mode. So isn't this approach breakin=
g=0A=
anything for well behaving drives ? Wouldn't it be better to blacklist the=
=0A=
misbehaving SSD you observed the problem with ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
