Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BE6C432BE
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 05:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ACEF61074
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 05:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbhIAFsu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Sep 2021 01:48:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11392 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhIAFsu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2021 01:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630475273; x=1662011273;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6NyEOhkLYrOgWW7LOM3I9xKGzLCNsBRgcIanfc1tPVs=;
  b=BvLM5CMB5tnLYsOn07iK4g6W4jYpg5SG5Xlz2KYnywh7ORAzUkVB5rfQ
   DPXfrTtLMrARb0XJ9nBa7i823LzlV1eFXK2vRu0zxImdxz9W0BisMdA74
   0Crc1Jj1NpFf9jN9hvrCIHbl/SGFtOHCOFg6XWdBArcQiJ+7YKW9maQJh
   ddTjThSWvZO8DAVWFmbfcLJo/R/JqsYEAJRd+uhJVu/EU+/MOLXsXbF7W
   mcrBDvxdkeHwsJnEaWKgJ/TU5fsb3bB+f+AoeIbSWtsFBq6AARRvf5ZnQ
   WKR9BqMcefyp1/4nZXos6G+ci7OjwjMmk0hqr2BZfnKYsmXDvSw8/mt0x
   w==;
X-IronPort-AV: E=Sophos;i="5.84,368,1620662400"; 
   d="scan'208";a="183704399"
Received: from mail-bn8nam08lp2042.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2021 13:47:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EALR370GerZ+PkYKIy9oTsV/iONNMGFKm18ch55GdI33/TQSCoKPNRLfLcKHQPIWXAs2ULLcbvywdDGzGqbz57LjwOWonprqZdWnwaDwmXXEex71JTQx3ywvkLAFTJB/w7EFmA0HKP6WVFNFn6tPewKpsrVYOZSAmTZPKY+acgUaOOr3TNH/0TCNfcpbC8iWnBp6FRzGz4sQ10sxFBZh4RQZ7fRZ6kQJDtQV+zeLERTRnafQQgW40+ryY7V+252rjS3h+dj/xykpEyx9cnKBj2lTIImg2YFhOe6Md3bS7FlwSTQnoEd4X8sJXHb4w2ajdG2W2JIyAIAegmB7n6FnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=belo2DsAfP8DvX2iWSuQyG1Gg4S+s0mmL5EsSO1tRYU=;
 b=DMNJw09zcokZYAI/G/OLMSLyjfB3a/PWKg9zRJS9uwEhz28oeFPSabQV9nmxwp73mGcFy7veMYtOQmm9upJK3DvXJWMzmZ83sRO4a94hXAdEXowMRllUuCbHIJHJ9oS/5Ki3bUpMVS8BTvJ94+ctn+qIQ6lQ6G+ZZFyyG2tr1VDKZitJDvBJbbEwGPLTryh2chD88rCiQPuV3UeUSvSMWFeq4GIOlGrb9VJuA0XRYXFaMtcFbkBkQXJqA4YpkZakrOY14Pszp1UKXmbTN/1XHN/xs1J/okm/5izBfVP1/m0tjtKVUBWXg2Rx2uBLwUgmrLmfYq6HGq6d2Vv+ZnTw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=belo2DsAfP8DvX2iWSuQyG1Gg4S+s0mmL5EsSO1tRYU=;
 b=W7RsR8eP52QaTJRRBnxjzjOGHlKxpZ3cDniyzBHB/eyG51uJ478CwlieE5wYPBCgJDYxCQEYpeWmiYnVs9oKNeZGOPqPLkULAUXofL3bP2wP0g3fdW+IY2KCtKjYU7+ea4Z5Zxf/K3NGV2BshOnvRSMBmzkDY36ye5fP8w1EnJY=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4538.namprd04.prod.outlook.com (2603:10b6:5:21::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 05:47:50 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 05:47:50 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Hans de Goede <hdegoede@redhat.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
Thread-Topic: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
Thread-Index: AQHXnu00nADPZw0PhEefv3ObNX3Apg==
Date:   Wed, 1 Sep 2021 05:47:50 +0000
Message-ID: <DM6PR04MB70816700CC55CD5C75A0DA33E7CD9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210901045220.27746-1-hpa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96b6ec03-38a2-41f7-234c-08d96d0c08d1
x-ms-traffictypediagnostic: DM6PR04MB4538:
x-microsoft-antispam-prvs: <DM6PR04MB4538B0F842FEF271210E76A1E7CD9@DM6PR04MB4538.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ok6BfEn8FVP3B4EYLMKpkksCSWX1RQwtvpYzcYoxMW4Y7Y2zBDkkD3huq4GeepnhCHTettP4P0/oMXBwlMrQE+rd117T0lSoZI3Ra1mo0LcNuJ+3D1lTWFpeahLsSD1f8YFaH3MxsE70XzYjn4Yqs3eUrmMKrHqFQv8UR8qS8Svz6R0ttmo7qEFJSAGZQinK5ZNwW7XLNrWPStNzy/2CCLCZQX3gYlE3w+fbQfT4jfIZUXsXZV2LCIQkqFf+ORIn+wGovt2H70TRYbRWWUsa9ygrfrsK8uHPMqkmBmFP+i94ROckhQ6kpsPViU9RK1Yf3y19l5a2o/YnaxYhpZdu1PedbnWdOm0LfoDgeYSOB4pPlodytDMLxhH+gXimPjFT3dLovJaHD2LogkYHGaayLwR3tWZ81QGTIXAQUmkpNqVu1D22z6khVFaa34sGdwbkYUHbGssgKuwuxw0MlNVCT59VnIvNa3a1py4hpnSZAhYMH6DJjg8XN/ggRoZcAlikIk8mhlHInGsROm7Ow9nW/FHf6AwMlyA+QqbOiI+jYr6F12ZBydjljYEw9+rzD0oQ/K9pvxPh72PHLpHM9cK5rlJudAEX+9UKmpMiS+KHahUhrCoySwjJxMveMKLSKywIJlPOThfpQMxX04uPi37A+qRbQHlcGE9ruEvsKjmxWNCrEUuh092U+uPlwN/hwmkZjuLkt/I7DmqAAAKR94GhMQe0YpDMSGJCV3NKmmsL0Wj1+2y+8y6XOTa2BoIROBZ7K/7DsYKwv4JqBFCnJB6gHcNuugMFpdEmQ0/Y8Zyu//w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(478600001)(7696005)(86362001)(6506007)(53546011)(2906002)(33656002)(83380400001)(71200400001)(186003)(966005)(76116006)(91956017)(66946007)(9686003)(55016002)(66446008)(64756008)(66556008)(66476007)(122000001)(38100700002)(8676002)(38070700005)(8936002)(5660300002)(52536014)(110136005)(54906003)(316002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eENj205iCSblvleBukg5uDD0ksyP8AdntkseClkIBeVJLRR/CG8p0N2tKSgz?=
 =?us-ascii?Q?AEGcAiSA3akw5rFHB+DxeBAEo93Q/CzbYvPubkZ73UJFrzi97ZlYyGfjYO9k?=
 =?us-ascii?Q?vrD9RryCl2sW+cJNH9/g7leU5j362NhWEc+cj18vpB/WX0wQpSNlz2bh0KXd?=
 =?us-ascii?Q?mSvak2ryhNiihy3ijLVNElvWVSeHqTSRldFQkZQp5x/K7dXxyHRtq7osd6g+?=
 =?us-ascii?Q?3yODSvYIOYGNG4ItXimh3bTZP+hNnwYPfwREL7IScTvK0/OMGN5TK8k3VuVG?=
 =?us-ascii?Q?3yJtIaPl9Vu3dCGeJ7Wv8ISNIiJ7rp4yoi+BP3RTlD4N4FgYA1AOyT2s5U5a?=
 =?us-ascii?Q?I25Uf5FMilmKKFJ+St7JWubCZMTKb3fzRaHILzger212IapsbqOwpvue5uyS?=
 =?us-ascii?Q?sWmA8O6KXTKO98KDd08uzOz+z8g7iTgyt1J1UeStXlCYpfJnREaJaQZKaKoc?=
 =?us-ascii?Q?mT/PL7KDZrBwH3iWyy2wVtH28LBnPUdac7BvGbmJg51c1lLubZAid2LAl08C?=
 =?us-ascii?Q?wfDiwZjoZ7uihkBK2saLnpGMFwalQSftdhQibvuOpIothqmfZ2GkJfWZSA2n?=
 =?us-ascii?Q?KDwjsoGxn9SmQsug22jSOqMZeuzAYtD+sZ5/0/niGEZI26fgV47UvfON+y4Q?=
 =?us-ascii?Q?zby/Dxwe0BjZbv6T7j1sUkTNBP/UqEQW6oyu1NMDVsWM99ZlWA8PwBRMr+cE?=
 =?us-ascii?Q?idAkWw80e4+23RQG5GNokZ6NK324Xvb7mxCGq3ARkVr8LWWUwZOYNRDNII9/?=
 =?us-ascii?Q?NaYfrr5ZJDCV6Tj4G4jBrnZtwQuPf/XX0isQ78dpuVzYS7W12FHasWUiF4Pf?=
 =?us-ascii?Q?971sWSplAu5J9kw+YkraXhZP6Wvnq/qDGEhddjrxVV0pjNpy5XmhMh5ysiPZ?=
 =?us-ascii?Q?O6W6XX+Ugbd0RLtSp+dwNEru+vDgQNpdBWluuDcDElGriKJU7Aer5lAaHJ1G?=
 =?us-ascii?Q?ua9VCb4/lTm6Pa2zDsExuKVYGLm8z8zbSl64+yPfmsPsFQpDxGi46SBwc71C?=
 =?us-ascii?Q?1Iiq7dMrBLS+I5bS03t7zN5sfu7ZxLeld5yB/Jc1z97VXOcVh3z4XbNDpeqf?=
 =?us-ascii?Q?Xvpir6be3ucJLWCZ7rwhmk9h2s4EIECIJ6MfiNqyUoRGFJsVr6nKR3DCPB1T?=
 =?us-ascii?Q?zTaZNCJYM52StN3Ms6DlJmcA1zrYwhKhfZyzRizzhY7TA6ZF6T7CiFRW94o/?=
 =?us-ascii?Q?vv0YBOcwgEQ9YzaIMowYWdxnM0Ob0o2+JluGhQ6uOxh2kIpKVzRr97ZvJvKH?=
 =?us-ascii?Q?CgEj6ENA7YJnf3eUhWhjKW16sM0W85a0Hpqly285SYvsXqOgivxy9y2x11/S?=
 =?us-ascii?Q?jIqJoLA2yCKEmz52WVHQc8kY8l8uCxl116YOuwpGhENp+axyt8SD9QTQl9KW?=
 =?us-ascii?Q?Lu+rPLJ4RB5B0iO+3rjBwcq+2iRJw2t5V1tDRKFgvJwhLAZJzA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b6ec03-38a2-41f7-234c-08d96d0c08d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 05:47:50.3320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rN7Rz4d1H8b0Pvfc13sWXAB1AmFGJilpmEVoERJaoHIzG8IWD/PGMnnOXTox8Aemp+L+cQYvFwxUkRXVffTqRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4538
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/09/01 13:52, Kate Hsuan wrote:=0A=
> Many users are reporting that the Samsung 860 and 870 SSD are having=0A=
> various issues when combined with AMD SATA controllers and only=0A=
> completely disabling NCQ helps to avoid these issues.=0A=
> =0A=
> Always disabling NCQ for Samsung 860/870 SSDs regardless of the host=0A=
> SATA adapter vendor will cause I/O performance degradation with well=0A=
> behaved adapters. To limit the performance impact to AMD adapters,=0A=
> introduce the ATA_HORKAGE_NO_NCQ_ON_AMD flag to force disable NCQ=0A=
> only for these adapters.=0A=
> =0A=
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D201693=0A=
> Signed-off-by: Kate Hsuan <hpa@redhat.com>=0A=
> ---=0A=
> Changes in v4:=0A=
> * A function ata_dev_check_adapter() is added to check the vendor ID of=
=0A=
>   the adapter.=0A=
> * ATA_HORKAGE_NONCQ_ON_AMD was modified to ATA_HORKAGE_NO_NCQ_ON_AMD to=
=0A=
>   align with the naming??convention.=0A=
> * Commit messages were improved according??to reviewer comments.=0A=
> =0A=
> Changes in v3:=0A=
> * ATA_HORKAGE_NONCQ_ON_ASMEDIA_AMD_MARVELL was modified to=0A=
>   ATA_HORKAGE_NONCQ_ON_AMD.=0A=
> * Codes were fixed to completely disable NCQ on AMD controller.=0A=
> =0A=
> ---=0A=
>  drivers/ata/libata-core.c | 32 ++++++++++++++++++++++++++++++--=0A=
>  include/linux/libata.h    |  1 +=0A=
>  2 files changed, 31 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c=0A=
> index c861c93d1e84..49049cd713e4 100644=0A=
> --- a/drivers/ata/libata-core.c=0A=
> +++ b/drivers/ata/libata-core.c=0A=
> @@ -2186,6 +2186,25 @@ static void ata_dev_config_ncq_prio(struct ata_dev=
ice *dev)=0A=
>  	dev->flags &=3D ~ATA_DFLAG_NCQ_PRIO;=0A=
>  }=0A=
> =0A=
> +static bool ata_dev_check_adapter(struct ata_device *dev,=0A=
> +				  unsigned short vendor_id)=0A=
> +{=0A=
> +	struct pci_dev *pcidev =3D NULL;=0A=
> +	struct device *parent_dev =3D NULL;=0A=
> +=0A=
> +	for (parent_dev =3D dev->tdev.parent; parent_dev !=3D NULL;=0A=
> +	     parent_dev =3D parent_dev->parent) {=0A=
> +		if (dev_is_pci(parent_dev)) {=0A=
> +			pcidev =3D to_pci_dev(parent_dev);=0A=
> +			if (pcidev->vendor =3D=3D vendor_id)=0A=
> +				return true;=0A=
> +			break;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	return false;=0A=
> +}=0A=
> +=0A=
>  static int ata_dev_config_ncq(struct ata_device *dev,=0A=
>  			       char *desc, size_t desc_sz)=0A=
>  {=0A=
> @@ -2204,6 +2223,13 @@ static int ata_dev_config_ncq(struct ata_device *d=
ev,=0A=
>  		snprintf(desc, desc_sz, "NCQ (not used)");=0A=
>  		return 0;=0A=
>  	}=0A=
> +=0A=
> +	if (dev->horkage & ATA_HORKAGE_NO_NCQ_ON_AMD &&=0A=
> +	    ata_dev_check_adapter(dev, PCI_VENDOR_ID_AMD)) {=0A=
> +		snprintf(desc, desc_sz, "NCQ (not used)");=0A=
> +		return 0;=0A=
> +	}=0A=
> +=0A=
>  	if (ap->flags & ATA_FLAG_NCQ) {=0A=
>  		hdepth =3D min(ap->scsi_host->can_queue, ATA_MAX_QUEUE);=0A=
>  		dev->flags |=3D ATA_DFLAG_NCQ;=0A=
> @@ -3971,9 +3997,11 @@ static const struct ata_blacklist_entry ata_device=
_blacklist [] =3D {=0A=
>  	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |=0A=
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },=0A=
>  	{ "Samsung SSD 860*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |=0A=
> -						ATA_HORKAGE_ZERO_AFTER_TRIM, },=0A=
> +						ATA_HORKAGE_ZERO_AFTER_TRIM |=0A=
> +						ATA_HORKAGE_NO_NCQ_ON_AMD, },=0A=
>  	{ "Samsung SSD 870*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |=0A=
> -						ATA_HORKAGE_ZERO_AFTER_TRIM, },=0A=
> +						ATA_HORKAGE_ZERO_AFTER_TRIM |=0A=
> +						ATA_HORKAGE_NO_NCQ_ON_AMD, },=0A=
>  	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |=0A=
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },=0A=
> =0A=
> diff --git a/include/linux/libata.h b/include/linux/libata.h=0A=
> index 860e63f5667b..cdc248a15763 100644=0A=
> --- a/include/linux/libata.h=0A=
> +++ b/include/linux/libata.h=0A=
> @@ -426,6 +426,7 @@ enum {=0A=
>  	ATA_HORKAGE_NOTRIM	=3D (1 << 24),	/* don't use TRIM */=0A=
>  	ATA_HORKAGE_MAX_SEC_1024 =3D (1 << 25),	/* Limit max sects to 1024 */=
=0A=
>  	ATA_HORKAGE_MAX_TRIM_128M =3D (1 << 26),	/* Limit max trim size to 128M=
 */=0A=
> +	ATA_HORKAGE_NO_NCQ_ON_AMD =3D (1 << 27),	/* Disable NCQ on AMD chipset =
*/=0A=
> =0A=
>  	 /* DMA mask for user DMA control: User visible values; DO NOT=0A=
>  	    renumber */=0A=
> --=0A=
> 2.31.1=0A=
> =0A=
> =0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
