Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD56FC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 10:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhLHLA7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 06:00:59 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62114 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhLHLA6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 06:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638961047; x=1670497047;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2CenCcKkNsW76bOUpvT9oBTK5nSfNtU2EJG4TY6ocG0=;
  b=f3DKF9YRZlHLLhBk4b8Ey7oEhejKmcibrDMtVgleVLMOYvBxbpHs74+4
   gmCKFbu5jPHN8WygTJz/v4E9LWGHy5FOqdU7PWj3KBIECwObw0Ggqdc5O
   KgWGpeQUDKF9QK8F3G+sjIGj/F4RQRcNEso+RqURGfrnD0+tyXzJuBCQX
   fRxIDiKUs70BvheJBhhE7+ULLPwB0iUqi3PyTzAghQKmTfJwdv9A4Hgyj
   l4qjZ9Kug0rpR8VwEjdK8ajQOFunOQfE1q18LRVjFJ0cOxL2rmIyEHZOE
   psYTal5w1jp00y8FN+Rapx03jNj9xn9QIrPqz5oCVVRgEYMNWsFQAYZGF
   w==;
X-IronPort-AV: E=Sophos;i="5.87,297,1631548800"; 
   d="scan'208";a="186717896"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2021 18:57:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoHCPr6Di21+CWjiSobMQBWf4y+h1UOxCZNasHM9VAfYo8dE4zos05nzGkutRoYbLv0Rx5Aesa7s9q7wCPtioTA/21nyN0/wRSIakra7BZe/P91bmcKOwjDcvjn+vbxlHoc5YZSm6LjWEYVx8Ry/2OEY2vj418Cev3p4IRWHettK9rZd5ndNWD2kSi3X8YURr5n7RDeDSiry68JIJm2/TJ1Hcx34J1gFf13TuXtvuuPpIO4pM9hrQA/icsSzOWri0W0licerOohGlp9Y3Nk0ebo3biVNNVoj72CV3iTYdn4ftaL6a28ELgRqFkccUh9uMWolpPevkpDkN1N0iPlh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAi4k6+8+65E5Od1Yy5NPOqaooDy4IZBjseGxU+4rMg=;
 b=ALAnTRwei1vGvFWUOvvnZDiWLf7X0BoKGa7EwOFZCtlhj/GddltygQQXYU4hXe537JSoslFqijdGmNRJRxU79FoQntdKArTxPCA4FhVi6Q4boTvNO9QXb4L1Y9Orbh49nKUBmLs//k4Kh3xFRZ4pu5Fa3aTsJgOESByajOz1QMi3c8qLm77RkVzxCs5awsZ06xJdZQ9DAgJ4Xh91mASf0pzpUoiwwH+X7/1zcQX48rvv3fJj5LLyAziculg+1ZF0okLm1OtAnWT0LuvO1TSW3ovXoRV1EZ8O3iW9jdmQFrISxshYO1v5CsoqP2EoM3+5/iikjRMhRCMiSazZqiCWzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAi4k6+8+65E5Od1Yy5NPOqaooDy4IZBjseGxU+4rMg=;
 b=BShy/5u9LSwneH30C3gJUmeSsa5+p59yNTIqUa0SVL6hiL/KJd1M5MjsuQFyVFS1wkrsi8+YkjwORy83hrT3abZNT6pbe9kLMVhVUIVAlUuF6wuAXc4k7/YGwpV8zStwnVDTQV/PY5vA5FBgUvtE9PrGlFN94P5ZwuRAcJUW5as=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB1181.namprd04.prod.outlook.com (2603:10b6:3:9d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Wed, 8 Dec 2021 10:57:24 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::fdf1:de8f:9073:8487]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::fdf1:de8f:9073:8487%6]) with mapi id 15.20.4778.012; Wed, 8 Dec 2021
 10:57:24 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] libata: add horkage for ASMedia 1092
Thread-Topic: [PATCH] libata: add horkage for ASMedia 1092
Thread-Index: AQHX7AEWg2LuZbiAwkOfAleA3Ax//Q==
Date:   Wed, 8 Dec 2021 10:57:24 +0000
Message-ID: <DM6PR04MB7081F06F8B94345297B0267FE76F9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20211208065853.5270-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e1f4bf8-adb4-4d55-0563-08d9ba39847a
x-ms-traffictypediagnostic: DM5PR04MB1181:EE_
x-microsoft-antispam-prvs: <DM5PR04MB1181F0F011D98A5860C822EAE76F9@DM5PR04MB1181.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Cq4YUGLJkaQapKghE6on+JkNlpRpUvn0MneYo+3kUWcS+uMc0sIDeeii/VjqoG/0+05ccJfW+pIE28GMlbddI4nkoujylKejGItzM7bq3BPYY7KGpAv3vNr7miqvP2S885BZATXpP+Kgok3rNKTw/fc9PTvo5dOqs2dzWiSqalYoJwFknTmEwhkJ7/4jcepfK2dH/Ot5zB2zgaAw22M60seG28/ulqyeBJZZzoJAc51GYXBON1G7CDpTczqGfpwwYBCYhGm7iiciEeNr2a7f8g1r2IfMSINsBqj7fvBviDVzykrCN4KO3ojwQDU9+yA+nrrrW/PEVOv5ksXqbx2SyKOQg1ALf+B47DkV25FqDntrd8Q2eeqvuvNWlsbLhuypZiZNKUxHPmDNftZ2xxwcwmrI+GN9XjMOgPKqu46dpAY0fuWJs+34DmjkdmX3OeOQQmZPLfIsqVWH3pzPmanbSeCHO06rfClyhKQ/Tc9R0kM42znKjLxra9CrVGVi3X0ZuvtaSrzGdbwF2aug28Yrux67E484ismCS+BTvddjGImwQMZz9lWQW+t8W9LsMD59lYli090o27nL6qAnTwnlceMdiEjOFc6OHOD8YTdtRQWR5zqro/5sI2H4GRZWMnonImrkKAta7lN8Xs66ODd9rTSCGODQTDngX8mm/1jDOfmLzOhg8+YPcYiWGgcTPT8pnSc8j5n50ZKgqytmIAaQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(52536014)(9686003)(66446008)(6506007)(8676002)(64756008)(66556008)(91956017)(76116006)(53546011)(66476007)(38070700005)(66946007)(33656002)(5660300002)(316002)(6916009)(82960400001)(2906002)(8936002)(508600001)(7696005)(71200400001)(4326008)(38100700002)(86362001)(186003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?glQ/M9DdTCRsw2M8AXLxZ+Q5IUdYD7vwrMNaKZ+r8lgV3HMjGtf6nBP3fQZs?=
 =?us-ascii?Q?rdcA/v6mnW4DQlaL1DzE3oVI1ijGu0SBNWkOU/hCno94doXgr2EhenoebiXL?=
 =?us-ascii?Q?MJXVPvguMPwelmDO6vF43vkMiSzBuXujBekzv2np6+5uuZzYi8wHXMhuWR+y?=
 =?us-ascii?Q?RbsGX3gnlltjTX0irvavFqgpv38sPvc7uzDJ7P8LWi5UV6PFmHwBnJGmTNuU?=
 =?us-ascii?Q?5eX71IhnLwTPwsY3YjcEP/UVK1xjQSfegaoDGqZsMpNW0e9qHCsHGkBQWh02?=
 =?us-ascii?Q?PilrwAkv7f6qTLoQEE85dCnliHtwRajZJVoMoSYokMw961mJiA1XCUPayHoG?=
 =?us-ascii?Q?iQVjmaVBxJJnca99OpL8F7rhKkhCdmdCv5hXm3t1bYVxdu7vMNDwiGON140e?=
 =?us-ascii?Q?6KVaa+PRwqlvE9+Dg8aqr32nOhv0lgXjLN5xgHb4GiGxHXSe0X3xC3N+EU+2?=
 =?us-ascii?Q?UvpI3hi9yTbaqKJdjTIW3cL7H8UMpUE2omOebvvfYOih4Y4F4hZnEPMpowTS?=
 =?us-ascii?Q?EcU+BktK4aQT6apubPkD/5UFVLySi3FLhTavvXi1gY29s6rEY7VNlbiKXPCs?=
 =?us-ascii?Q?vWXpE3kEeT59RyG8e0n1C0IhVd0YIZoofiP33Iz2r/X8Ya8AxlnZQOw2vG4E?=
 =?us-ascii?Q?l1baQsHZV/tx6TBdbqsj5scpWQtcUqOLp3XMsmlwGBDLif3L8M58uqsNKOz1?=
 =?us-ascii?Q?lzpcRSPMUdcQVjikJeR8vrjaoYc4L34WptCeoAjCRAvQerka/CHK4/54qmn7?=
 =?us-ascii?Q?VJOjLLsoxIM8xPNp5xXX0TfNUUGZ/gVss43/Dc/bUM1CxjOXMFa/bk8IxxhA?=
 =?us-ascii?Q?bv1oMAjGWwH19NeuKUzf4qen798WZtzJBrHqdIX8RfeeYyiOyVWFi+PNvDoL?=
 =?us-ascii?Q?yIZAmhdBI+2BEbE9y8vZgJI/QpBhepwA/6Jfmhv6CU/MRc/TF1ITuwvEoVGs?=
 =?us-ascii?Q?fljVFJfECidqeIfjOCfQBKc3R+fZ/w00gb9Wwznp+wAPXC+GDQ+HqmJPLTqL?=
 =?us-ascii?Q?FQXTPczLqxEqLZ7Up4zrkkysXq1Ah7OyJS+vFRVCFlwaAulqapt5JrRbKtLZ?=
 =?us-ascii?Q?lVOOuP4gJjAqm0vhS6/flfnShg0Y/0IW9e0LY813DHadTjFTu024F/MMRV2K?=
 =?us-ascii?Q?CvVEHN5L0+KbuqsLCjNJGzFlwo8WyZsYCNV+9/cQNtJeQPUnkVuLbVI2SBmD?=
 =?us-ascii?Q?yeX+vsDBZJiAnR28/F5brD34KY7INm6Hwpa4UqdJblBwNd26sMnnt9pcAqX8?=
 =?us-ascii?Q?MmREbJRSoCLyw0Te92h0vBLPraagzeyBa0uN21Td/RFZYfCdZRCvevdnwEoW?=
 =?us-ascii?Q?m+/3KNH6LWmFdj2i5z0L/JaR3ZnIisD5jQDd2wQKRHCE+fv6xBaPz7hUXgVR?=
 =?us-ascii?Q?NkOqgZcla1my+XLQjZCD0hZDmoRE+wRtzgMTXe429SyRDzdGNZ9BQnBPpAT1?=
 =?us-ascii?Q?S7TXmAjV6jwHUiAJ4zLuQhWlm8Sc63GzhEuEeOvFkjZhRvak8kQ3GKT+XMR0?=
 =?us-ascii?Q?71T5eqJCnWPWepb2Og5GDbkXKHsXSvzETqSLNw5VhP3QqLVfzlF63kAH44Wu?=
 =?us-ascii?Q?/oDoZhsyWsABYdo2lRc3henJTQkm1H6zivmPUbsXz9Qs9fNrwPgcoFZ1K07j?=
 =?us-ascii?Q?6drFINjC+tHUV1IaX41UrGv3KV1I0FYsR4wQkNxW3fPN0yO6TP30qOXMXtDi?=
 =?us-ascii?Q?/vouEIEgvmnB27L1xHvlTc6pn10wy8QfD04MITlc8zFFx1Cr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1f4bf8-adb4-4d55-0563-08d9ba39847a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 10:57:24.6185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sdsi4rD4mo6OZvq8MqIFlEy5trJPtgzXBR50E0TNdGl+o//5UJJiQYbs5PjKA6O0/4Jjtq7xBYXCuz2vvhMoiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1181
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/08 15:59, Hannes Reinecke wrote:=0A=
> The ASMedia 1092 has a configuration mode which will present a=0A=
> dummy device; sadly the implementation falsely claims to provide=0A=
> a device with 100M which doesn't actually exist.=0A=
> So disable this device to avoid errors during boot.=0A=
> =0A=
> Signed-off-by: Hannes Reinecke <hare@suse.de>=0A=
> ---=0A=
>  drivers/ata/libata-core.c | 2 ++=0A=
>  1 file changed, 2 insertions(+)=0A=
> =0A=
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c=0A=
> index 9c05177e09c2..f1a2f0a4ce05 100644=0A=
> --- a/drivers/ata/libata-core.c=0A=
> +++ b/drivers/ata/libata-core.c=0A=
> @@ -4416,6 +4416,8 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {=0A=
>  	{ "VRFDFC22048UCHC-TE*", NULL,		ATA_HORKAGE_NODMA },=0A=
>  	/* Odd clown on sil3726/4726 PMPs */=0A=
>  	{ "Config  Disk",	NULL,		ATA_HORKAGE_DISABLE },=0A=
> +	/* Similar story with ASMedia 1092 */=0A=
> +	{ "ASMT109x- Config",	NULL,		ATA_HORKAGE_DISABLE },=0A=
>  =0A=
>  	/* Weird ATAPI devices */=0A=
>  	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_128 },=0A=
> =0A=
=0A=
Doesn't this need a Cc stable ? I can add it.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
