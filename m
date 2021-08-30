Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0045BC432BE
	for <linux-ide@archiver.kernel.org>; Mon, 30 Aug 2021 21:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D710060F42
	for <linux-ide@archiver.kernel.org>; Mon, 30 Aug 2021 21:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhH3V7B (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:59:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33177 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238413AbhH3V7A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Aug 2021 17:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630360687; x=1661896687;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pfb5E6FHo/hbNyD8xwl/Mb5tYjR5D7qCWW4kECa0ERk=;
  b=LVW0luht8MCqAhbD8BjW1e9Mq/lGFReRmXNVj1dK7oTsVi3PapiOpI+u
   s4pLZUECX/ZT6DrRkqqNP5M5inoHtX6DNaelbhcL97PtXKU9tW+RJHIn7
   /bvuiyZDjV5zz5fDDBYonnaROo2ecrPJRkuDq1FTXpQnwesGV1P6iPRk0
   pBOFSMHWrPtRfV1WJGqJgNRTk7s4SDrqOEGdS6UX8N/kOolTPh4kYuDne
   OEo0jG63iHmRAMZs/VHv8nObt5Xjuc+NBuKquBNR5HI7nLUIWt7LParEI
   f9SAAE4qMB/Ir2B3ORFZWeH2ztyVwVtZffX4+h3G26al6Wb4c8jtecaI7
   w==;
X-IronPort-AV: E=Sophos;i="5.84,364,1620662400"; 
   d="scan'208";a="179348811"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2021 05:58:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUUfPwk/bJemED7kPWeMSAyx5JwsTWFyLWaq80bvNmUdLpSc5Sn5600fVqq6Pu8WCyuDprdxHAiIoCITXq+fv1LJDP2dabstjNMOomXcVqDgGjk0wSM9QBDj/pMeii2lf+a5JoI9h0qBN8gGQXMtF/ImQvhuCbfVMLQ8wfcoAHsFMk7I4f9q2/rBTULm18/MnkzAmDEV+4yxlaTV1MdnPo3yrEpO/83rQvp6dfrzYAlY7YGDtvfVE0pbrN0W2cBzfstv01Hd8I0lOheihItEUqEq/Ki6Gz90uaK37dUnox+nzGhAeAhJflD8qX+lvwhy0+m+zbZANDHGXSqoBolcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS65n3WoRdbKjSEheBo5InvAfvUM7yAG6YdtSCxcRHM=;
 b=TDNUUDnSa0Es4IcT+fqM/SkgUx1a3wvtgkjqpFXPfDu1vCvfbJuh2P9jDWssLfvU87HBg3IlmcBoeJC6irnsLuAHykQ0Zg2gCnUGfcUQUAZMaoXguSeMkdqGuqBYnR1rqnNMeaZkUjX9LOnlvmEEddFYYKZP1dY25+U68PB2ie0t8MnSpYZ6B0iliF7SHckj/Sj5wSX4nRsXoEEKIJwqZ2+m3V56WCNCtzzyMqn7IBNsgVdlogtc6nmqGBJpxtExYLvRNSqXKR4wmnZaugmmOXnXwTBlZhCAfkXJAqLyWm7V4Pzxu9MsSgoYv5Do/hgjpxx2BrgaQNcDLDa28pQtnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS65n3WoRdbKjSEheBo5InvAfvUM7yAG6YdtSCxcRHM=;
 b=wDl82/0HufWW0NWphR+KFA92eBI1xBI3jThXNj8WuRplGCBHVRL1nHQLusegYl031wmqFQXPnbp1yvwMD48zeIX4dNkZyFlA62AAwYL1QvzmAUVib0p6HWmMINn2vur5elfgSIkyN6ID4POGMboBjx9WUUac77aM9oGq66y3UTs=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5370.namprd04.prod.outlook.com (2603:10b6:5:104::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Mon, 30 Aug
 2021 21:58:04 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 21:58:04 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Hans de Goede <hdegoede@redhat.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] libata: Add ATA_HORKAGE_NONCQ_ON_AMD for Samsung
 860 and 870 SSD.
Thread-Topic: [PATCH v3 1/1] libata: Add ATA_HORKAGE_NONCQ_ON_AMD for Samsung
 860 and 870 SSD.
Thread-Index: AQHXna11sYaFfjER/Uyhl8ugEqYihw==
Date:   Mon, 30 Aug 2021 21:58:04 +0000
Message-ID: <DM6PR04MB708110D5731E3A6BCEA8A2DEE7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210830144253.289542-1-hpa@redhat.com>
 <20210830144253.289542-2-hpa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76bf6306-8a47-4c2c-74ed-08d96c013e6a
x-ms-traffictypediagnostic: DM6PR04MB5370:
x-microsoft-antispam-prvs: <DM6PR04MB5370306D131F3A466EFCFA3CE7CB9@DM6PR04MB5370.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T9uzmUCJ1eaTaX8/1JH2dqLqWEvHOpb2OVmjzx9HAGhgF2HmHJ7DRz4O5o1GzTnI1xiQByH9cmenldpMHX5T8L+F73GfPjW+KbdrPcnGg78JIP98vUlJG3ak3mvOUnx72ssws96Dln8SuBNPDsA0HNBqa2wX21D8hXLI2YuHgR0QEqiMZYC3Zh2nOIFDoEw0nEecZIycBiAN73nxRQkD9yYx8PsLsWTLwIojhja21TobRj2iM9kUcFK4vQyelc04IWStWgaIlaXlTbJHfy1VHfXOJkGrHU0dHNNOUVRNHkhH1W1CCmvc1EGh4o2sZlSkiJnMVJhEAdGAUwNMWXa3pZdgkW+J2RRzBZERtQ6w2GYvnz/rQxPcoZa4arvU5Ld0P22+qZEaNQ3pCYS4FYnCevORVbITwFSHkhQu4qjgJeogKES7UGZLxsn7c06FJtKZwqif5v3leJoJVg02TgigNpe9PZuFX6l50BEcwkgIEuigLt/Pd8nJmmnkH4AAIdwxte1/cqCSEERh+iPjdmYJVhJq0n0vo1VbAZVHCTOMeAa6sarr5lcOYjW7pL2s5GAV+Lzxcz8jacI8dZHnBpcRjz07u/0kTY9WX5tNhjFwpvAPLGR2bUA2SFfGiDc6u7rmzjyGrgkRW4tS9d89TrzJGVMNSSWSU5FtXBZbhpGtD9L1EAfnh3b292lUsWPavlR+hSf+YZUjiypiPkyGI0KReZiLUGyCkeGh3oX0GK9SeBoXQ/YDdEAD+z4XqMAlS4NCOXGFZoCnWb0+8aawdTLO6Cm79gOe8qV76t55osgTdAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(86362001)(2906002)(53546011)(6506007)(316002)(33656002)(8936002)(966005)(9686003)(54906003)(110136005)(7696005)(478600001)(8676002)(66556008)(52536014)(186003)(38100700002)(71200400001)(38070700005)(55016002)(66476007)(76116006)(66446008)(64756008)(83380400001)(5660300002)(122000001)(4326008)(66946007)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Il0D+DDu63JTH66Y7tQQcDXlTI9ibS/P1cKeVUjH4fN0xz6Ae+J4TsKdDJPW?=
 =?us-ascii?Q?CC70/JX5ZKGGo+HsxrCrlnSw2C7krOQLB01ZvHEjzHLq6P7MAQ0EugtvQZ2l?=
 =?us-ascii?Q?R7arLUGpbzAgeAUXnsZxu+tmNpDG2AEZiz29DRrXhuhtIMSTSlouXAeutDBv?=
 =?us-ascii?Q?9/y2+pY+eCAjSisWNY+xy8aHRoq3lUMsiZ+vSD6PlSWzRYjWMWwaj2u6Q54D?=
 =?us-ascii?Q?I721gBgsOv8vRrfJdRB7RUWYhdaEfQ1vjZCsPtdMkFje4ANLllsXJ6gNGbjO?=
 =?us-ascii?Q?NH5xHiMwpGWl7p/ylDJTwkivMNwbASE1SPj2F0uzS4DkjOlSUg/xg2pfOBxy?=
 =?us-ascii?Q?i0CcOMaFpAqMDR5Y6IXMjyPVjPeaLaPne6M8Xw/nKy3eLaUv5bvCKPXmbXJ/?=
 =?us-ascii?Q?7RjPAKTv8BYaQ12pKy/J/ABXC74TmgHlSZqJPJrJfyG+MebKpzyxHbf9MBjV?=
 =?us-ascii?Q?+q6oijVx6VotNNglRb2Vhfn0tHiV2Iosig3rG8Cp1HXFoCBXzSS2vUFcnCFq?=
 =?us-ascii?Q?ercR+JDUNcsrG31vCA3dzJR8oeHnAqv7Rfua/OmE+GlXE29or2CuDSWpOjTP?=
 =?us-ascii?Q?nCsf/roxhevi3oMIvY0TDL+S9a8uu93vuMbVisSlWk1fM2wd34vT3/d3/T8z?=
 =?us-ascii?Q?Y9+Sh0wFvCYRtvsVewXE/gi7Z6Zt9bFY4BJAP8A5m037aahtTVd8i4TfOmVF?=
 =?us-ascii?Q?JO+iuPIWoFmaFHrh8wVJd3l68eeVnYsSrCJl4eHpMj9C9TQnlkzx/MNLubsW?=
 =?us-ascii?Q?tRhuubcgyBy7J2NRunoDQEvOBvyv+y+F8rrn1fVTRgwrUdF3xRzIDuJHSrxm?=
 =?us-ascii?Q?zy/ASQMOtztS5u6mEKmjU2sPFYEflHD+sd8gKLjj79N0Rzj2Tb3+FSuOhQTK?=
 =?us-ascii?Q?6p1NBU7SRNI6lPzeNnvhC1yxbcbP9Y/kv/yWTETZVZy4QwkGO6ZA4OJQO8qv?=
 =?us-ascii?Q?FCCzwiOIgAW+e1Q8TZ40HGKccRShKVBi7TeI24F/HasbBXsh5QJ8pz4hllC8?=
 =?us-ascii?Q?+CbIzdSaiRfpems3R+YYj1bCuCU9YuBteeHFPJrmhZv2DELk7cg9LdF2fxlD?=
 =?us-ascii?Q?gmpWGTikmnyKxJTYOgveoCJ8NV7Ag1+yBTp1RpOeM5R8dO64FdbHHDHziwkV?=
 =?us-ascii?Q?3DtYAXjfK/ICmxD2b+UCDnLtdJULZEVaHdXywagUZXYOX+GRF0Qskxaaxcmt?=
 =?us-ascii?Q?meSaByc540TP07lWe31FwJpVkHRTDHKDZEj2/jER0rL5lBG1uamAfUJ27CEa?=
 =?us-ascii?Q?0FHNkuDlQtWYXo85QTgonJFgrE7HSjAqqgpr/CFVW1JhkWzczbk0zpJ9lsy4?=
 =?us-ascii?Q?C74qO8O1vHApamSNb9RD6/UDi9trLY5/dxjLRUBNcirH07TkCNWfNBtBYFo5?=
 =?us-ascii?Q?ECgCQmLMmkNXpE96ckT2zfH3sVmgnZDyvwWLoaFJFmzh4Tj94A=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bf6306-8a47-4c2c-74ed-08d96c013e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 21:58:04.6402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kfhie4wUtqICpCkG55rJEeAsE8HYNdhI8bds3pT9SJbuhw0VSdS6lkezOndw6lf9C15sQP1iA9uo7RerkeIXog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5370
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/08/30 23:43, Kate Hsuan wrote:=0A=
> Many users are reporting that the Samsung 860 and 870 SSD are having=0A=
> various issues when combined with AMD SATA controllers and only=0A=
> completely disabling NCQ helps to avoid these issues.=0A=
> =0A=
> Entire disabling NCQ for Samsugn 860/870 SSD will cause I/O performance=
=0A=
> drop. In this case, a flag ATA_HORKAGE_NONCQ_ON_AMD is introduced to=0A=
=0A=
With "Entire disabling NCQ...", did you mean "Always disabling NCQ" ?=0A=
If I understand this issue correctly, the explanation should be something l=
ike:=0A=
=0A=
Always disabling NCQ for Samsung 860/870 SSDs regardless of the host SATA=
=0A=
adapter vendor will cause I/O performance degradation with well behaved=0A=
adapters. To limit the performance impact to AMD adapters, introduce the=0A=
ATA_HORKAGE_NO_NCQ_ON_AMD flag to force disable NCQ only for these adapters=
.=0A=
=0A=
> used to perform an additional check for these SSDs. If it finds it's=0A=
> parent ATA controller is AMD, the NCQ will be disabled. Otherwise, the=0A=
> NCQ is kept to enable.=0A=
> =0A=
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D201693=0A=
> Signed-off-by: Kate Hsuan <hpa@redhat.com>=0A=
> ---=0A=
>  drivers/ata/libata-core.c | 24 ++++++++++++++++++++++--=0A=
>  include/linux/libata.h    |  1 +=0A=
>  2 files changed, 23 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c=0A=
> index c861c93d1e84..36c62f758b73 100644=0A=
> --- a/drivers/ata/libata-core.c=0A=
> +++ b/drivers/ata/libata-core.c=0A=
> @@ -2190,6 +2190,8 @@ static int ata_dev_config_ncq(struct ata_device *de=
v,=0A=
>  			       char *desc, size_t desc_sz)=0A=
>  {=0A=
>  	struct ata_port *ap =3D dev->link->ap;=0A=
> +	struct pci_dev *pcidev =3D NULL;=0A=
> +	struct device *parent_dev =3D NULL;=0A=
>  	int hdepth =3D 0, ddepth =3D ata_id_queue_depth(dev->id);=0A=
>  	unsigned int err_mask;=0A=
>  	char *aa_desc =3D "";=0A=
> @@ -2204,6 +2206,22 @@ static int ata_dev_config_ncq(struct ata_device *d=
ev,=0A=
>  		snprintf(desc, desc_sz, "NCQ (not used)");=0A=
>  		return 0;=0A=
>  	}=0A=
> +=0A=
> +	if (dev->horkage & ATA_HORKAGE_NONCQ_ON_AMD) {=0A=
> +		for (parent_dev =3D dev->tdev.parent; parent_dev !=3D NULL;=0A=
> +		    parent_dev =3D parent_dev->parent) {=0A=
> +			if (dev_is_pci(parent_dev)) {=0A=
> +				pcidev =3D to_pci_dev(parent_dev);=0A=
> +				if (pcidev->vendor =3D=3D PCI_VENDOR_ID_AMD) {=0A=
> +					snprintf(desc, desc_sz,=0A=
> +						 "NCQ (not used)");=0A=
> +					return 0;=0A=
> +				}=0A=
> +			break;=0A=
> +			}=0A=
> +		}=0A=
=0A=
It would be really nice to move this hunk into a small helper, something li=
ke:=0A=
=0A=
static bool ata_dev_check_adapter(struct ata_device *dev,=0A=
				  unsigned short vendor_id)=0A=
=0A=
The "if" code block then becomes:=0A=
=0A=
	if ((dev->horkage & ATA_HORKAGE_NONCQ_ON_AMD) &&=0A=
	    ata_dev_check_adapter(dev, PCI_VENDOR_ID_AMD)) {=0A=
		snprintf(desc, desc_sz, "NCQ (not used)");=0A=
		return 0;=0A=
	}=0A=
=0A=
=0A=
> +	}=0A=
> +=0A=
>  	if (ap->flags & ATA_FLAG_NCQ) {=0A=
>  		hdepth =3D min(ap->scsi_host->can_queue, ATA_MAX_QUEUE);=0A=
>  		dev->flags |=3D ATA_DFLAG_NCQ;=0A=
> @@ -3971,9 +3989,11 @@ static const struct ata_blacklist_entry ata_device=
_blacklist [] =3D {=0A=
>  	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |=0A=
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },=0A=
>  	{ "Samsung SSD 860*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |=0A=
> -						ATA_HORKAGE_ZERO_AFTER_TRIM, },=0A=
> +						ATA_HORKAGE_ZERO_AFTER_TRIM |=0A=
> +						ATA_HORKAGE_NONCQ_ON_AMD, },=0A=
>  	{ "Samsung SSD 870*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |=0A=
> -						ATA_HORKAGE_ZERO_AFTER_TRIM, },=0A=
> +						ATA_HORKAGE_ZERO_AFTER_TRIM |=0A=
> +						ATA_HORKAGE_NONCQ_ON_AMD, },=0A=
>  	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |=0A=
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },=0A=
>  =0A=
> diff --git a/include/linux/libata.h b/include/linux/libata.h=0A=
> index 860e63f5667b..42e16114e91f 100644=0A=
> --- a/include/linux/libata.h=0A=
> +++ b/include/linux/libata.h=0A=
> @@ -426,6 +426,7 @@ enum {=0A=
>  	ATA_HORKAGE_NOTRIM	=3D (1 << 24),	/* don't use TRIM */=0A=
>  	ATA_HORKAGE_MAX_SEC_1024 =3D (1 << 25),	/* Limit max sects to 1024 */=
=0A=
>  	ATA_HORKAGE_MAX_TRIM_128M =3D (1 << 26),	/* Limit max trim size to 128M=
 */=0A=
> +	ATA_HORKAGE_NONCQ_ON_AMD =3D (1 << 27),	/* Disable NCQ on AMD chipset *=
/=0A=
=0A=
Please add a "_" after "NO", similarly to ATA_HORKAGE_NO_NCQ_TRIM:=0A=
=0A=
	ATA_HORKAGE_NO_NCQ_ON_AMD =3D (1 << 27),	/* Disable NCQ on AMD chipset */=
=0A=
=0A=
>  =0A=
>  	 /* DMA mask for user DMA control: User visible values; DO NOT=0A=
>  	    renumber */=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
