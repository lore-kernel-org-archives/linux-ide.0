Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AE8ECAAD4
	for <linux-ide@archiver.kernel.org>; Wed, 31 Aug 2022 14:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiHaO2S (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 Aug 2022 10:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiHaO2G (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2022 10:28:06 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD27A5D109
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661956083; x=1693492083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9KoS2pnLKtDlZFqhkrf+zkXhqcmPRu+Y5TW0pFEp6/g=;
  b=e86PKfo8WbNrRVUpkO93yVcP42gHOQlZ+FPj6HSY84iIdib5VE9Otrnf
   piuzOo5tSFv3g9SjnPYIpu9sAmOdvIOn3hkT69LPrlIURWledQ8FAe2Zm
   v3sjz0CdqbIbmHjQDSaoX8uqj+Z81Qbzi1bagc/zbA2Wd0FSWHtXr9ozD
   tnVkcyYqrXjQauPIZ5NyqBZMEFtyPOqtCcbK8Knrn9sGk2h3WHYdnRYDS
   4sonrwRGoPo17vr2iktQJSS261dYRUn8EsJv23iSeD7UftBl1HL7WkOQE
   tCG6lmsOCWcktqAPUKEAxTaZhKLdFTnwfpXzXGatvLdmNjGo9Irh7p7d6
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,278,1654531200"; 
   d="scan'208";a="314419662"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2022 22:28:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpSC318OrSW2Qx6pg+ynzTjv23shn9SMq+Z+wl3QFMGxKYVdtGMOtZ3xk24wbNwGNLPLjvQr9ucTe7KQjrJViWU/qe4Jq2y+bVZYyc2cQi3owGEVida+fI8i6IDmd4xy46paKMhBYpSehKvFPMMxuyDvjXADuW2TQfA0dB78DCw2HKNkEPUI0ZwfL/tZTc4tvLlsYPCKlVbFrvwk0qm19qX6tUKD76ujOyjwHmvILBSBY1qhVMbcpcbj7F18ilbxdERvjXj37eDQSbLq4ZKejrqYns2yiaRJiSYTgxu7yCAOgy9qSr2skOARr1avVEay5qs7+pYf9NNUUn0BxGlwUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6EmIkjmYPvkhe179PYfgN92fBTee1tq5Gj2lWvC1Ak=;
 b=nS77ZyF+zDS3BVs+Nd1Sg3K26StJ9LgviIrJeMx5qjEdeblbRRjIkU9Xdh0kqfJ6VAnoSkRn/VPIrFVMWQTsmNNoxCy45Duv4urBYxyPz1BguSmu0RZxo21bQEnfPZ1pw3Y6O19a076XhmRGWIGf0ODBQDaF03Dmqs15osZoWlfe7/4WECpOCyEPSt8726UWdMJDGq6Qd2wRGV19ioSrJqVTgNZvgGVoiKoy3JdJPi4AGWnm2Uunz0o3H4vPi+r0dEd70tn23Q7ftxNhiCZ/AFa2epCSjI4GEhfCSW6hSfFC89zvuBrWkaRRiQO0Atzac+7aeMY4Vi/n8IDtLLq1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6EmIkjmYPvkhe179PYfgN92fBTee1tq5Gj2lWvC1Ak=;
 b=iR/QF0BAO5eJJvxUKYljXObkru59dLVXboLNia8E8P4aFYUPPFnrXen96l9Qrx0FWD6Hp+C3asAyuZ6BxdtlsE3GbHJ3ZZWANMAPwh8t6ptlQ2RGJGSohnpXJBGxusJKCO2wJ6U3inZs9OyeTRjRg69glhvnRkyB3yuOfQmcJuw=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by BL0PR04MB5156.namprd04.prod.outlook.com (2603:10b6:208:5e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Wed, 31 Aug
 2022 14:27:59 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c839:6239:54ad:fc30]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c839:6239:54ad:fc30%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:27:59 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] ata: libata-scsi: Improve ata_scsiop_maint_in()
Thread-Topic: [PATCH] ata: libata-scsi: Improve ata_scsiop_maint_in()
Thread-Index: AQHYvUXerD4QfI7iZk+F4n0D6LT22w==
Date:   Wed, 31 Aug 2022 14:27:59 +0000
Message-ID: <Yw9v7gZwJwp7SjNN@x1-carbon>
References: <20220825223912.355011-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220825223912.355011-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b297d1f0-6718-4a32-f244-08da8b5d010f
x-ms-traffictypediagnostic: BL0PR04MB5156:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h0ivwDEUm9dnDxRbOPnajY+9EKBnv0ztg+2iyGUDJUrULh9pt1xdoVUyZyWDhUkdFX0jeIWcHKo+r5Xww/+6kbjFaWJ0oG2b5PtQjVhIMscvq4HTLuaREuiA5iZu3LDD+DWEhrT9i29xDVGyFy1KOSFVpCoZ5wC//rbQ924XUhqA9O3/czmMAUkagvbwuKsQxu2mUmpAbPb8p0viU25PgWe/LizUdXYvWEmsEcmwfjLORP98eW/ltsck4osZvtWZ7YSdi0Q781RAtYxRcDMGr9QgphrPD124XYLW4FzehdoBKqUyNrUcy/3A+LHzcGzsYZa0pz2hmDuHCR4NMhxZvkhi1a4HDO7j2neIdkL3tficwfztHSFoi4GGoJbIniCu0AExJSiwDHVfSH1Lk4ghKDUUv2bU7NJ6ubMdW8blCu6oC6ZMQXO8XDFzL1iSg6ghqsHoUo0y6GT+5M/YDJ1LqMkNpcxzLlAB7Ay39/BFndYRhHbrJBZ9nZYRkhQAnv8rjO0TZwFLmvowXhPxInl7S8rYptP+2Jn2kMB++WbIqDRnl4WRxnH+ne8JCvdEl3/G9wSeV6cWckDn6V7/CmrOt3uhLFyMchY9IUt4Myh7RfGzCx+VHt1eE5UPM0muKTkdCmMdZ1OjNNr9zFYylub/W69cpCMBFWIPR0VGO4477HXVAvIQygvpEZfb6R+2Tm30JHptVSPWVr5LoZy0X9stJ7ycmO8p1g9QJ/Bg3Z2fl/VOa74x/ciQiA+8ZCuM7w0Ppme/zzsoTuPco0XCGcY6Rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(396003)(136003)(39860400002)(376002)(346002)(4326008)(66556008)(66446008)(76116006)(5660300002)(66476007)(91956017)(64756008)(66946007)(316002)(8676002)(2906002)(86362001)(33716001)(6862004)(122000001)(83380400001)(8936002)(38070700005)(478600001)(38100700002)(41300700001)(6486002)(71200400001)(26005)(54906003)(186003)(6512007)(6506007)(82960400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jZuxrxbVs3Ry+hdF37bFnEID7R/Iu3Z7LQzxI1NOnDvKJF00xOYV/VHInnez?=
 =?us-ascii?Q?B/IlqM589iNmEo8hE3wTfxJob6UeXrAjW1VNVsw1b7hTkJYbj3c4f8a2bLVb?=
 =?us-ascii?Q?cEtBSzeCyUcbRbhY3SetwtQEukgmufuY5CfJnL++cAZsk6Ji+eAc5w3IfEYe?=
 =?us-ascii?Q?Fdq441H2iePB16MsWqKRI3T41u5Xlq5HVEX9eI0PXV++KlumwfS+MielNQ8C?=
 =?us-ascii?Q?F8qLjL/keTU2xqE68b3ItLWRUAJQRryBwKZ8nfDcaXaRgkn3Yt4ijtisge4G?=
 =?us-ascii?Q?m5lPWYaIm/Z7P/ylx9/FFUxDhUMAWfCZVVU2pFESGz9vGNnFpb7gmMg0GKuS?=
 =?us-ascii?Q?Q4QpjzGpwFDjmX/JkD2787nVE9OZInlfraywW3l6WpfCO3mxXgANvCp2BNqO?=
 =?us-ascii?Q?MMQ1Tbn3xMuOZZ+u3SOZUsdRPGZEnee4sDOrhZElpqLcFic21Hr/ZzcwGL9U?=
 =?us-ascii?Q?QF4Y2P1IKmKraJzkI0PqvGHdc7vJFhLF/ErVW2EF3vybHkOpB74Jhz90KoH+?=
 =?us-ascii?Q?j2xOwIlPE9qp7GG04FK7zAU1SRMSsm7QAR1c7Qeu5QEoQfsVEo3TmVeRhfeM?=
 =?us-ascii?Q?l7iZYXU7sB5Y2lDrsIOw7v2k0+A9MwrONf4AysaZ2f48EgAfAQ9LznskCxtU?=
 =?us-ascii?Q?qNYb5GnTZ+QyEBd/hwiXavHExhRoAJaIN05SKlwt+cGLRLvQ9lrxWfv0HP2C?=
 =?us-ascii?Q?O+dmpyiBt+I/WoWwtLzqMhr5Vw8vUpuYY0vg5fh6HZq1cMaGur3SpOTvRyPQ?=
 =?us-ascii?Q?+WFP86ggbh4msvjZd1r+E1JsNfDqb4ZFMWYUCQHZTHxgIB1a/A7N8T/T64kL?=
 =?us-ascii?Q?jBerq1TLM9o0In/gaxFC2nPeOA+bfw0a18MfHvKnmqFYKZYaF9eqYZ3OfMB6?=
 =?us-ascii?Q?BwhKjzN0y79ZYLJvcsfzbUXAp5HaSw2Bo3i/JSiZMPqMOwG5FHe3yH6QFjMx?=
 =?us-ascii?Q?Agli6l9jOd+7FOj7fG3+pljTLjFjbA26iRwFyjBI3AvAK7vVDRpc8Jy4zIeP?=
 =?us-ascii?Q?Jt36PpINd7ewWieFlisL8HyVeTnuR5uOWNQLQ3ksr62XWSpCKceLxo7XXqG/?=
 =?us-ascii?Q?xw+9slrgRSNqDcSfo4Exi8KGlkVKt+xymF1tqgdTogMrBUHdrB1JCumrheXC?=
 =?us-ascii?Q?1V6ZCiFzgl9Hv8Ml7mv6DxwxJO5RLaTMl1PJhTpeBq3sna37OmGUvKfdS5kP?=
 =?us-ascii?Q?7A3C9pOOIwPPDW/Bqvw1/+VYxTIu31ww+yOhZ+m1/XvAxMmlB+kg+VdfZVb/?=
 =?us-ascii?Q?jS77Gqv13gNwoAmYRqmg5EP3OQpDOxVwXLFl1ZvV31yu3hfewiwm6UyWwAaS?=
 =?us-ascii?Q?1eCrGOJP7Hq4PTd4W8mMpO9W8A1Xj9JCNtc1+yPjmQZI3oyD+qQHXQz3OZ9D?=
 =?us-ascii?Q?uv/ELxP+WFotwyISFcFqSVXGuWk76POiWIHChpSEEDBde8ZaOj++Hnx0pYFi?=
 =?us-ascii?Q?1AoI00xL2mhwrX46I3vAVaZzmsqy3N1HGgka1fI6cbtOnjoCf6xraVIToBMx?=
 =?us-ascii?Q?vrquyT8UrWUHmBdHe/IEsJqGSWIT3dWjbddKiq/BWV5ZO/o+b+JD4B3EmNox?=
 =?us-ascii?Q?h3VWzNWI0Xvq6mmgk/HwginK/o3LpfeE0O+06XXkHLS5qcdfVzsNtF5s1p7o?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C8A8ACCDB5E804CB9CAB580986885BB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b297d1f0-6718-4a32-f244-08da8b5d010f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 14:27:59.2074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PuKPBqYhSfhQzWSerXPKpUWpFSiJEaJOVHljOVq66xQZnY+fKaeMfvkum7o3Odz02rJwLU7BTpU3LgvrRt4dRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5156
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Aug 26, 2022 at 07:39:12AM +0900, Damien Le Moal wrote:
> Allow translation of REPORT_SUPPORTED_OPERATION_CODES commands using
> the command format 0x3, that is, checking support for commands that are
> identified using an opcode and a service action.

So, while the function ata_scsiop_maint_in() has the kdoc:
*      ata_scsiop_maint_in - Simulate a subset of MAINTENANCE_IN

It actually only handles a MAINTENANCE_IN service action (command).

The name is thus quite misleading.
Perhaps you could do a patch 1/2 that renames the function so that
it is more clear that it only handles a single service action.

(If we ever add translation support for more than one action,
we could reintroduce a ata_scsiop_maint_in() which calls the
correct function to translate the correct service action.



> Allow translation of REPORT_SUPPORTED_OPERATION_CODES commands using
> the command format 0x3, that is, checking support for commands that are
> identified using an opcode and a service action.

If you rename the function, the commit message will make more sense,
but could be further clarified to something like:

"""
The ata_scsi_report_supported_opcodes_xlat() currently only handles
currently only handles a command specifying "REPORTING OPTIONS" field
set to 0x1.
0x1 means:
return data in one_command format if:
-The opcode in REQUESTED OPERATION CODE is supported,
REQUESTED SERVICE ACTION field is ignored.
If opcode implements service actions, then terminate the command
with CHECK CONDITION and sense key set to ILLEGAL REQUEST and
additional sense code set to INVALID FIELD IN CDB.

Add support for translating a "REPORTING OPTIONS" field set to 0x3.
0x3 means:
return data in one_command format if:
-The opcode in REQUESTED OPERATION CODE does not have service actions
and the service action in REQUESTED SERVICE ACTION is set to 0x0; or
-The opcode in REQUESTED OPERATION CODE has service actions and the service=
 action in REQUESTED SERVICE ACTION is supported.
else:
the command support data shall indicate that the command is not supported,
i.e. the support field is set to 0x1 rather than 0x3 or 0x5.
"""

>=20
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/libata-scsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index f3c64e796423..99ebd7bf3a9c 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3252,11 +3252,12 @@ static unsigned int ata_scsiop_maint_in(struct at=
a_scsi_args *args, u8 *rbuf)
>  	u8 supported =3D 0;

A supported value of 0x0 means "Data about the requested SCSI command
is not currently available".

However, considering the differences between 0x3 and 0x1, if we want to
follow the spec strictly, we should initialize the variable "supported"
to 0x1 rather than 0x0, when the supplied REPORTING OPTIONS is 0x3.

REPORTING OPTIONS 0x3 mentions that "supported" should be 0x5, 0x3 or 0x1.
So (according to the spec) 0x0 does not appear to be a valid value when
REPORTING OPTIONS is 0x3.

>  	unsigned int err =3D 0;
> =20
> -	if (cdb[2] !=3D 1) {
> +	if (cdb[2] !=3D 1 && cdb[2] !=3D 3) {

Considering that this function never terminated a command with
sense key and additional sense code set before, none of the commands
support a service action.

Therefore, we could change this to only allow commands where:
cdb[2] =3D=3D 1; or
cdb[2] =3D=3D 3 && REQUESTED SERVICE ACTION (cdb[4] && cdb[5]) =3D=3D 0x0


Kind regards,
Niklas=
