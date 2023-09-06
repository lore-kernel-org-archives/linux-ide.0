Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD80EB8FA5
	for <linux-ide@archiver.kernel.org>; Wed,  6 Sep 2023 07:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjIFHyy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Sep 2023 03:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjIFHyx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Sep 2023 03:54:53 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB792BC
        for <linux-ide@vger.kernel.org>; Wed,  6 Sep 2023 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693986889; x=1725522889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B9jiPhE7wEt4rsWnj+pME3PLcI/IsdDACiQzRa2uTvc=;
  b=pQCXdvKCjSXEt3d3bn3YQH9RbE8kgTE3RuIz0bCd9lQ8NzflZHGHQRJ4
   GfOzPjl4bMTLcbHbTppudI37xCgNl0R/G1vF+hMHtHyYGKBtnQ619rikC
   artfnZE0pJnC+FtNEfzzqSNc4nple50fgbY3t3DzKgVCNxm67fN9eU7V5
   NvkAxTGNgz7RdeXm4ClNPswZpRLK/NJTnbIa2GF3chy4UHhAWOG97K9px
   /OYp9VSF1BbgP4BEaQus4FWIuQFx62ivgXNB/NTrURW2Z8f8iWNao24d1
   b+T6AOThJCN1KVkNaYrYcBJXRZmxK/EDF9qC6qtHMiCh0X1keAb9Vxu8B
   w==;
X-IronPort-AV: E=Sophos;i="6.02,231,1688400000"; 
   d="scan'208";a="247677076"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2023 15:54:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffPcpG3w2ZkAwkQ7mEYglufL5fPOvaie8Z/VQ1GCaraAYC8Usss/Hf26aAlbsaceFr7ttESxeZXTcAv91RHNrLxbkjZ0QxPPA/Th97pUoK4/KY6DicQsRlTA/2AWdi4tLm9tVBzmTkaMeOvW4WIE78JjPWwhvBczmORq3qUElxhVuotvnerD3sg4cVxIMCjtLFfGCN5T3LJAbT7VmDr7Vbp4YogpAi08QzjGWTQWbTEP7jgBU4mOzDcbnh/Uo2V1EiZbb/k3Jd0yhir5IYePQXjiXR6bGeSFMhHbCBrXqwpSWKAL/9uJTM422REqPXhw8wSljkuwNGZxDDW+1V9uzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9jiPhE7wEt4rsWnj+pME3PLcI/IsdDACiQzRa2uTvc=;
 b=blU6hHS4fKSOdvbKqG8VyG6RuOhGeYe/P9jIFyyDmTiRp1whGM1Qy04O4NNaqcTzVSS6Mt3viWcl82cGk40ah8FnO2rKxN2AnvxOIjr34zCiWY7kFxY8Ok9qF/dAXkboddI5Fjdvn6q6sIitnNAuFQWxZ1ds92nr3uOKNEEigTpEyD1i9YnEpvLFCo61FhRsvABsa2gWJG32ijhkMYLhMLKfqKWe/FNqWLzyAwBvK4M/6QHv/P8c15ziG9uaLVK+Jv5xXY1xbBQ3QZ8AEb27OUuX2Sy+BPEQ3tag7LoXOcqUBYdm+XtG9pSLXdECELN4LGmACFMEamIRPSaC83ICyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9jiPhE7wEt4rsWnj+pME3PLcI/IsdDACiQzRa2uTvc=;
 b=L/rl3RTlVoBxoaigLsV+CcVn4xui+bhoTN+xmNQAIdeMJo+nSAvFXP6FUkAyiIalRXWYwoXlNKs2datMUb7+wAVxsMxU4QP6bMnYiWkDVrxNp2I7Cc7OhIdUxdzx0pCDyDbVlVUfB5D3Vh3vcitMiuyNmT+H6tY86wC/Jy7Qmbc=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM8PR04MB8165.namprd04.prod.outlook.com (2603:10b6:8:c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25; Wed, 6 Sep 2023 07:54:47 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.024; Wed, 6 Sep 2023
 07:54:47 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     Niklas Cassel <nks@flawful.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ata: ahci: print the lpm policy on boot
Thread-Topic: [PATCH] ata: ahci: print the lpm policy on boot
Thread-Index: AQHZ3/eIUXWDwAHvZkOqRwmEVhUUSbANXDoAgAASpQA=
Date:   Wed, 6 Sep 2023 07:54:47 +0000
Message-ID: <ZPgwRm6X7JhR4Jlc@x1-carbon>
References: <20230905124909.3334046-1-nks@flawful.org>
 <be820ba7-7aa8-6338-7bee-201443aae5c1@kernel.org>
In-Reply-To: <be820ba7-7aa8-6338-7bee-201443aae5c1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM8PR04MB8165:EE_
x-ms-office365-filtering-correlation-id: 1b9dcdf3-297d-4e63-42eb-08dbaeae8a84
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LuJ1ajSFV2CoIqpDXFfacDQkRBHBdNWdsMS7gJZm90/vv62KpEjko+ZbgD8d0CVU3GG3s6+/e5+scFbWSDsDbWwL0Sa61p13pDocYa1+4Z5c1LFDXiZNbo+fy75VEmUeshchUNMAuTh2kq60m8/J0jZihzd36Txu5m1cbWG2Jvosn7DxzgrjDogFPOCZgNdJ0ytFPxIG8MtCAF5rQp1aYb9J69uLTy/a6ad59cUV8dupCZo2fChnvp8QgclL5BQ3oNHL45FUfubu3AoqSJ83QCO+ixbjcUMcinQHIAejlR63EvnNKYcKbUVABcKIM6GDobrkVxXn5Oxd2iIlF1IPqlVKXhn7EFsmTye1XgPw4bRgFsA2n6a2BQ+bhU7H17dWGSgFWnG932xJoxkXtnr1/PzmVaHzekZp9p5wWj8PrHuRnqDOKJOV9ehVoZlrA4MnwdyTPDkptZcU/J3c7IcrV/HCbDEq8I/xfxpul4vONUl6454afSut4og1fXqGTvdPzMCEvSu485xQ51we1Ca78MYhmhvV5YLGraE6T4Lx620H/hJ9gdwIPsVQ0VLCfs5fDAIwR5Mrz7NG3vUf4mprLOxtqBadX+SitBepBmnw6X/3HncLr3XRqI6XIkNvGq+L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(136003)(39860400002)(346002)(186009)(1800799009)(451199024)(41300700001)(6486002)(71200400001)(33716001)(53546011)(122000001)(82960400001)(6506007)(478600001)(83380400001)(26005)(9686003)(6512007)(38100700002)(38070700005)(91956017)(64756008)(2906002)(66946007)(76116006)(54906003)(6916009)(66446008)(316002)(86362001)(66556008)(66476007)(8936002)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFhCVWtvMGVqR0pkNTkvbHQ0bXdHVVBwQ3RnSmQxSkNCVHREQ3ZSWnFPUTUr?=
 =?utf-8?B?cU0zRG8zdHA3ZFRRQjIybnBjK2F0VGgwcERPcjVDN0E2NmE4cEozOHRCRUpZ?=
 =?utf-8?B?dk9Ka0VNRUF4UEdxRjlmVjRmMHRmT3kyMHJ4dmpDUGN6ZVhkc205bGJxa01m?=
 =?utf-8?B?TGZma0tGMnVmM2RuditzYXgxZU9jS3JnRXdWVW13anJVNkY0SDlvSXQ2eEgv?=
 =?utf-8?B?SGF6alMxWXRRSlVwK2c3TUlTczc1d3Znc3oxV2dhSGtCa0x0OVYraVE0RVM5?=
 =?utf-8?B?K3ZwTjZZYkduMFAzemJ6T3MyU3FsWFZUYU44TTlTcm9Gdm9ub2o2YVFFb2sw?=
 =?utf-8?B?czhYRk1vclpzQlNTTmsrbXJ3cFJRbDh3Zk5zR2hYK2R4d3g3Y3owSnBDOTBi?=
 =?utf-8?B?dllaUWc2djBzM2xTaEF5ZWR4Rks1QmVrNnFtWUd3U2dyajhjZGZ2TDhjK05u?=
 =?utf-8?B?VXZOcXNoN3VSdG5FeXJlQjVZQUxzUDhyd3R3VXdlaDBTelZ6VG56MUV5YzdY?=
 =?utf-8?B?NGFVczM5NWo0NW1ZenFIOUpBN2NORGNFZUtEOUQxV0lucmRWRW0zbVBHNVlq?=
 =?utf-8?B?Y29WeHkvbSt3b3paQTJFK1prblltZE1VNVN5U24zYkFsRW9iaHo5ZVZjZVhj?=
 =?utf-8?B?aTE4NDZoTS84bTNyZ2U5eFhkU2syK243bXVzbVRIOXB1N1YrdEo1MTE1R0M5?=
 =?utf-8?B?T0dWNkFiYW9DSW4vT2M1VTYxSTNHQk5haENlUU9maEkyYmxtYWJZUmRsQXU5?=
 =?utf-8?B?dUtyVCtzeTkyUXljMGg0Zyt2MnBrUlJTMmVvNUExb0ZON2I3bUxMRmpoWC8r?=
 =?utf-8?B?cTVqNExrUWcrbjdFYXB2S252cExZOWRYVlBWWGJJN1dlQnVZQzFpOVBhSUk5?=
 =?utf-8?B?VVdUejU3N1RWbER3bCtaUG51R05JaUFmUVRHL0ZaVlhJTU50Y1JqUXpJT0V0?=
 =?utf-8?B?c1ltODE3cEl3SG9TbzFjbXNjRHIyZ2R1WHI3Nkg0RTQwYUJ2ckxLQ0IzSVRi?=
 =?utf-8?B?Rngva25qK0dqMGtqYk82bXdFOGc0QVBTY2tKSjlPdVVXeUZRTnhvVnlxTnd0?=
 =?utf-8?B?NmdJWDRuSmowZlJXbDc1c0tXemRVeHFBWlZnakxBRzlKb2FCR3BaY1dsRnVa?=
 =?utf-8?B?SS9uamwxYWQweHIra243c3phU2JrQ2E1QThtMmkzM0Q1eGQvZnlZclBuei9T?=
 =?utf-8?B?N01lNC96YmFHSVpTbUFNWVR0V1duTnNnUG1QNFdUOHZpSGZLNDZPazZPVW10?=
 =?utf-8?B?Tkh1MFBKcEx6aVhwaWloSGNBS1RaYmdvSTQ1bVl4RHY2am5hSS95T1o3Mjhu?=
 =?utf-8?B?aHpaRzZuYnVEQk1zSi8xQ3d6eFpsbnFEZGo0NUVGdXJxRDdHbFZsMHYvc2l2?=
 =?utf-8?B?dFFVMm1SNEtScVByS0wyNnQ3Zk1mZXVKaCtkbkJDY1AyN2I5UGVZeW1wbjVS?=
 =?utf-8?B?OFYvK2hScXo0NnFwWFdYZFFOQU0yVzVQbmdYQkRwSTAzUERYc2pTbjkvbXVm?=
 =?utf-8?B?dmQ5UHNvTU9pVzNjOXAweXBJbXRZaWJCeHkvdEtnRXJWT0pTMzFLYzI4KzVw?=
 =?utf-8?B?Rms4NWZVdnFCRG40SjluSTg5YjZWRnRNVDNpOVFsaWlrSEg0WmhVS0F1OWNx?=
 =?utf-8?B?YlZmbW53a1krNXcvZllyRFRhNDdnUVJoblBncndEYmpNRWJhUW4yWDBhcnBk?=
 =?utf-8?B?bU5Wa2Q5bkVzTklOR1Y3SGpiYk5IZ28zdkEvcDVLZ0I1WVJDbXZMTVpoaVF4?=
 =?utf-8?B?WkxmdGwwTUM1QlhUeCtteUdHNlh1RHlQektmaWNKUGRCa2ZHZWk4WmQzUzZT?=
 =?utf-8?B?anFwazM4Nld4VjFrdFQxZGN3cmRnTTlhT0hlVUZieVRVYUFnNGhxNXlhS1JW?=
 =?utf-8?B?R0RwYmpDY2dFTllqazVXU2JKSjF6dVRIREo1TTE2MHE5Y0xDOHVmK1gxeWl0?=
 =?utf-8?B?QVlSVzEvcUo5NDBFbE1uakJwNmp4WUc0WDNQckRUTzBUcWo5dGp4Z1ZPaVFZ?=
 =?utf-8?B?VUdZNXg1VUFqdGlWd1FCQkdISWxVWGg1Y3dFR2FWeWZiWmNESDJ2enEzWlg3?=
 =?utf-8?B?RXlld1J1WWNWbitnREJUSE8wWU90ZkJZSWtNZWh6bHNYSVFvRXdwRjNlelpB?=
 =?utf-8?B?QVdmU01vNThObFRoTUFRU2hLcTJuRGNQQWwvZkcvYjdvRFkrenNEVWFaUFZk?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <126466FE07BC8E4F9D4D842ACFF9FB9D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CX0u2vc/RqOfEUdBrR4gbLjNsrr846Ocod6nimzHdSQCt/57LX/4xdk/AuMzj2CAUROSG4eDef0AFuhL7an4D2hxCvB0IBWB0a1eccObUvD7Cqcw85CsDaeIWF80T74w9X0Ttyju0s4hxmUqBYjGMIF/tC+QBrsvLMzDCcNF5NKn/Urs3gmUN8XHIw7tma28HJPKCKyKxk8WLJb+hfAnXrUNeG9ElMyyDfXReZptdVc2x1UFC0LJDTTJ1gjZahzXF4kpP0YY5WTnDcsTx3k4jUpDLeej+YGDzBcJTwXd8pH269TYIn9VCejEwgb/9z5+IlugKt6YZKRytjTZHaBsaz7icCaJZ6zPhdPu+2GkSd9pnaZDwjQUfpePb/NvqTLFuQGO9c6xTfzymfGewZF0yFxNOQM/yF6fsBHCJB2b6ii5KKmoSv09cESMDAgdVW+LTbQlasATV+CoikwG9Cq4mEe5sCubpgAoxodlJYB1kiZtYX6wphamZyYed7bmD88z+F8R/rRJdsqKjUJ4awl+M0aDJ5gzhM746mxPtX0lgb1o7ljcuXJ1gR0U8CXR/5yhhVDvkrHT5d3nQB4saa+61+AZA4qXAY3DqAg639uOSKM6hAGvSvOgrZv4M1cJxER6k2+RdSXbRN3RUA/SMI5Q+yTSwCFajUyMEGV6lPlXuP62daTGvPJAK0ndXRdzvt7FrKM3/a6vsrdE7u6BPvcdMFaGcasKAMUnMKPT0H+s90CC8dGMlI4aqtQ1zfAkGWFQ/zmdZRW47ahyJ4AHu37n3FOYaubZvR0+63eepYT/GQUBszk1nM9nFsZD6NpiTi/hqII+DWGWy7n8Vyu8rrxx8g==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9dcdf3-297d-4e63-42eb-08dbaeae8a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 07:54:47.4127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: al63JdZCI/KYKsXtekPeQxnhE516r5WqDEtBNxbo620vDnZRKkulcQDgk859Kg0zTeIykMFI5cAwWdx3WfSj0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8165
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

SGVsbG8gRGFtaWVuLA0KDQpPbiBXZWQsIFNlcCAwNiwgMjAyMyBhdCAwMzo0ODowMlBNICswOTAw
LCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gT24gOS81LzIzIDIxOjQ5LCBOaWtsYXMgQ2Fzc2Vs
IHdyb3RlOg0KPiA+IEZyb206IE5pa2xhcyBDYXNzZWwgPG5pa2xhcy5jYXNzZWxAd2RjLmNvbT4N
Cj4gPiANCj4gPiBUaGUgdGFyZ2V0IExQTSBwb2xpY3kgY2FuIGJlIHNldCB1c2luZyBlaXRoZXIg
YSBLY29uZmlnIG9yIGEga2VybmVsIG1vZHVsZQ0KPiA+IHBhcmFtZXRlci4NCj4gPiANCj4gPiBI
b3dldmVyLCBpZiB0aGUgYm9hcmQgdHlwZSBpcyBzZXQgdG8gYW55dGhpbmcgYnV0IGJvYXJkX2Fo
Y2lfbG93X3Bvd2VyLA0KPiA+IHRoZW4gdGhlIExQTSBwb2xpY3kgd2lsbCBvdmVycmlkZGVuIGFu
ZCBzZXQgdG8gQVRBX0xQTV9VTktOT1dOLg0KPiA+IA0KPiA+IEFkZGl0aW9uYWxseSwgaWYgdGhl
IGRlZmF1bHQgc3VzcGVuZCBpcyBzdXNwZW5kIHRvIGlkbGUsIGRlcGVuZGluZyBvbiB0aGUNCj4g
PiBoYXJkd2FyZSBjYXBhYmlsaXRpZXMgb2YgdGhlIEhCQSwgYWhjaV91cGRhdGVfaW5pdGlhbF9s
cG1fcG9saWN5KCkgbWlnaHQNCj4gPiBvdmVycmlkZSB0aGUgTFBNIHBvbGljeSB0byBlaXRoZXIg
QVRBX0xQTV9NSU5fUE9XRVJfV0lUSF9QQVJUSUFMIG9yDQo+ID4gQVRBX0xQTV9NSU5fUE9XRVIu
DQo+ID4gDQo+ID4gQWxsIHRoaXMgbWVhbnMgdGhhdCBpdCBpcyB2ZXJ5IGhhcmQgdG8ga25vdyB3
aGljaCBMUE0gcG9saWN5IGEgdXNlciB3aWxsDQo+ID4gYWN0dWFsbHkgYmUgdXNpbmcgb24gYSBn
aXZlbiBzeXN0ZW0uDQo+ID4gDQo+ID4gSW4gb3JkZXIgdG8gbWFrZSBpdCBlYXNpZXIgdG8gZGVi
dWcgTFBNIHJlbGF0ZWQgaXNzdWVzLCBwcmludCB0aGUgTFBNDQo+ID4gcG9saWN5IG9uIGJvb3Qu
DQo+ID4gDQo+ID4gT25lIGNvbW1vbiBMUE0gcmVsYXRlZCBpc3N1ZSBpcyB0aGF0IHRoZSBkZXZp
Y2UgZmFpbHMgdG8gbGluayB1cC4NCj4gPiBCZWNhdXNlIG9mIHRoYXQsIHdlIGNhbm5vdCBhZGQg
dGhpcyBwcmludCB0byBhdGFfZGV2X2NvbmZpZ3VyZSgpLCBhcyB0aGF0DQo+ID4gZnVuY3Rpb24g
aXMgb25seSBjYWxsZWQgYWZ0ZXIgYSBzdWNjZXNzZnVsIGxpbmsgdXAuIEluc3RlYWQsIGFkZCB0
aGUgaW5mbw0KPiA+IHVzaW5nIGF0YV9wb3J0X2Rlc2MoKS4gVGhlIHBvcnQgZGVzY3JpcHRpb24g
aXMgcHJpbnRlZCBvbmNlIGR1cmluZyBib290Lg0KPiA+IA0KPiA+IEJlZm9yZSBjaGFuZ2VzOg0K
PiA+IGF0YTE6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTUyNDI4OEAweGE1NzgwMDAwIHBvcnQg
MHhhNTc4MDEwMCBpcnEgMTcwDQo+ID4gYXRhMjogU0FUQSBtYXggVURNQS8xMzMgYWJhciBtNTI0
Mjg4QDB4YTU3ODAwMDAgcG9ydCAweGE1NzgwMTgwIGlycSAxNzANCj4gPiANCj4gPiBBZnRlciBj
aGFuZ2VzOg0KPiA+IGF0YTE6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTUyNDI4OEAweGE1Nzgw
MDAwIHBvcnQgMHhhNTc4MDEwMCBscG0tcG9sIDQgaXJxIDE3MA0KPiA+IGF0YTI6IFNBVEEgbWF4
IFVETUEvMTMzIGFiYXIgbTUyNDI4OEAweGE1NzgwMDAwIHBvcnQgMHhhNTc4MDE4MCBscG0tcG9s
IDQgaXJxIDE3MA0KPiANCj4gTG9va3MgZ29vZCwgYnV0IG1heWJlIHByaW50IHRoZSBscG0tcG9s
IHZhbHVlIGF0IHRoZSBlbmQsIGFmdGVyIHRoZSBJUlEgbnVtYmVyLA0KPiB0byBwcmVzZXJ2ZSB0
aGUgYmVnaW5uaW5nIG9mIHRoZSBtZXNzYWdlIGFzIGl0IHdhcyBiZWZvcmUuDQo+IA0KPiBPciBl
dmVuIGJldHRlcjogd2h5IG5vdCBwcmludCB0aGUgTFBNIG1vZGVzIHN1cHBvcnRlZCBieSB0aGUg
cG9ydCBhbmQgdGhlIHRhcmdldA0KPiBscG0gcG9saWN5IChscG0tcG9sKSBhcyBhIG5ldyBhdGFf
cG9ydF9pbmZvKCkgbWVzc2FnZSByaWdodCBhZnRlciB0aGUgcG9ydCBkZXNjDQo+IG1lc3NhZ2Ug
Pw0KDQpUaGlzIHByaW50IGFscmVhZHkgZXhpc3RzOg0KWyAgICAxLjUxNTk2MF0gYWhjaSAxMDAw
MDplMDoxNy4wOiBBSENJIDAwMDEuMDMwMSAzMiBzbG90cyAxIHBvcnRzIDYgR2JwcyAweDEgaW1w
bCBTQVRBIG1vZGUNClsgICAgMS41MTU5NjNdIGFoY2kgMTAwMDA6ZTA6MTcuMDogZmxhZ3M6IDY0
Yml0IG5jcSBzbnRmIHBtIGNsbyBvbmx5IHBpbyBzbHVtIHBhcnQgZGVzbyBzYWRtIHNkcw0KDQpX
aGljaCBwcmludHMgdGhlIGNhcGFiaWxpdGllcyBvZiB0aGUgSEJBLg0KDQpUaGUgb25seSBMUE0g
Y2FwYWJpbGl0eSBwZXIgcG9ydCwgdGhhdCBzZWVtcyB0byBiZSBhYmxlIHRvIGRpZmZlciBmcm9t
IHRoZQ0KZ2xvYmFsIEhCQSBjYXBhYmlsaXR5LCBpcyBQeERFVlNMUC5EU1A6DQoNCiINCkRldmlj
ZSBTbGVlcCBQcmVzZW50IChEU1ApOiBJZiBzZXQgdG8g4oCYMeKAmSwgdGhlIHBsYXRmb3JtIHN1
cHBvcnRzIERldmljZSBTbGVlcA0Kb24gdGhpcyBwb3J0LiBJZiBjbGVhcmVkIHRvIOKAmDDigJks
IHRoZSBwbGF0Zm9ybSBkb2VzIG5vdCBzdXBwb3J0IERldmljZSBTbGVlcCBvbg0KdGhpcyBwb3J0
LiBUaGlzIGJpdCBtYXkgb25seSBiZSBzZXQgdG8g4oCYMeKAmSBpZiBDQVAyLlNEUyBpcyBzZXQg
dG8g4oCYMeKAmS4NCiINCg0KRS5nLiBvbiBteSBtYWNoaW5lLCB0aGUgSEJBIGhhcyBzdXBwb3J0
IGZvciBEZXZTbGVlcCAoc3VwcG9ydGVkIGZlYXR1cmVzIHByaW50DQppbmNsdWRlcyAic2RzIiks
IGJ1dCBub25lIG9mIHRoZSBwb3J0cyBzZWVtIHRvIGhhdmUgc3VwcG9ydCBmb3IgRGV2U2xlZXAu
DQoNCldvdWxkIHlvdSBsaWtlIFB4REVWU0xQLkRTUCBwcmludGVkPw0KDQoNCg0KDQpXaGF0IHdv
dWxkIGJlIGludGVyZXN0aW5nIGlzIHRvIGJlIGFibGUgdG8ga25vdyB3aGljaCBmZWF0dXJlcyB0
aGUgY29ubmVjdGVkDQpkZXZpY2Ugc3VwcG9ydHMsIGFzIGUuZy4gRGV2U2xlZXAgbmVlZHMgc3Vw
cG9ydCBib3RoIGluIEhCQSBhbmQgdGhlIGRldmljZSwNCmJ1dCBhcyB0aGUgcHJvYmxlbSBpcyB0
aGF0IHdlIHVzdWFsbHkgZG9uJ3QgZ2V0IGxpbmsgdXAsIHRoaXMgaXMgaW5mb3JtYXRpb24NCmlz
IHN0aWxsIHVua25vd24gYXQgdGhpcyB0aW1lLg0KDQoNCktpbmQgcmVnYXJkcywNCk5pa2xhcw0K
DQo+IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBDYXNzZWwgPG5pa2xhcy5jYXNz
ZWxAd2RjLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9hdGEvYWhjaS5jIHwgMSArDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2F0YS9haGNpLmMgYi9kcml2ZXJzL2F0YS9haGNpLmMNCj4gPiBpbmRleCBhYmI1OTEx
YzlkMDkuLjU0MWY2ZWM3ZjM5NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2F0YS9haGNpLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2F0YS9haGNpLmMNCj4gPiBAQCAtMTg5OCw2ICsxODk4LDcgQEAg
c3RhdGljIGludCBhaGNpX2luaXRfb25lKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1
Y3QgcGNpX2RldmljZV9pZCAqZW50KQ0KPiA+ICAJCQlhcC0+ZW1fbWVzc2FnZV90eXBlID0gaHBy
aXYtPmVtX21zZ190eXBlOw0KPiA+ICANCj4gPiAgCQlhaGNpX3VwZGF0ZV9pbml0aWFsX2xwbV9w
b2xpY3koYXAsIGhwcml2KTsNCj4gPiArCQlhdGFfcG9ydF9kZXNjKGFwLCAibHBtLXBvbCAlZCIs
IGFwLT50YXJnZXRfbHBtX3BvbGljeSk7DQo+ID4gIA0KPiA+ICAJCS8qIGRpc2FibGVkL25vdC1p
bXBsZW1lbnRlZCBwb3J0ICovDQo+ID4gIAkJaWYgKCEoaHByaXYtPnBvcnRfbWFwICYgKDEgPDwg
aSkpKQ0KPiANCj4gLS0gDQo+IERhbWllbiBMZSBNb2FsDQo+IFdlc3Rlcm4gRGlnaXRhbCBSZXNl
YXJjaA0KPiA=
