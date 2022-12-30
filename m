Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F71C4332F
	for <linux-ide@archiver.kernel.org>; Fri, 30 Dec 2022 07:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiL3HAX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiL3HAV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Dec 2022 02:00:21 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F86A13F05
        for <linux-ide@vger.kernel.org>; Thu, 29 Dec 2022 23:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672383621; x=1703919621;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NOOsVysho0kG3dMNuyJ8iandQjF0M1o7ud7Hjs5ee6c=;
  b=g1UzeDUtso4v8+zzHpnPzltgF3sg3uFJXfTSDXf+m3PUKxw0tNTSL6l0
   Y7upvHBXUZCJbO1u+eceGoj5Nyu4NgKNxBRLa15GYZoLeQH5DCsmrqiO6
   xAW7x2Yf0cBTMpl3/1agYblDMA3XiUJpDIz5mZknClXAOoVnQpTasSTPA
   2uyKDDQCA0JNQhaudnXY7f5QDJkEKWHNZH99I74EKy4LFfu2Ps6j6kkIQ
   mcpnmLmwyzO8xeN7ntQF2fkatlCEDzJN/O56NoudP01v0NEgFSZY63oKJ
   Q42GsAiva5cw3rUB82ccAJTsHm2Q/Uq0LUM10DoT57s6aq7o52DTuU5Ws
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,286,1665417600"; 
   d="scan'208";a="324022016"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 15:00:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Asth+K6cu/2RK50Ld8Q5JpiPWylrt2VcM/LfaPdF6FwOJ1xjRtCKsszl5SiUN+fTdvaDegVNwYzSnkyzNge1EiREVZ8m62YjOcv5xZ/SJ2KvZP+k7ulvExjy7AAgYZVIcWHItLUNKA8TYxft+soARXu1ohChFiB0iCnfVZbHhqgmijOBXmEU1TLeF3T2M8J7SjMdyqPbyyKLLBKeo1WcuWYUZPZM2k/6Y1eTuznFMQnuaflvS6b6fPsItQU5kzjlgaiZg16e+KYTfwYA4doP5MRdGATQ5n5c5qI/qeyqmd6kr3tYBwgaaqxnpU1omEDHh+M5XJIEMAlXfyTwi2HeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOOsVysho0kG3dMNuyJ8iandQjF0M1o7ud7Hjs5ee6c=;
 b=QNMsH+S+ros08woamxKeaDrpDfh6qFkgj7P+NUtFQHpZV/Xtkk8tQnxOf1K7bKlVTR3I6FMoWiiBHR94Ac4apjm7hFJe9wifMoP76uMm7TkclTgCsKBh9qzT5iCo+EVjgVFTA9KIjQGLjNiIcVRJyDxpKbHDU9RAzt+W6jKIOc5ze2WQ3NKZg7XiDS7jjuzfWMios758fZZDRrFVRGvEnwLzVqjnXDG7yFG/adFfqyYMQ+kkEgDDtkyS6UUl1MBVb4MCvMh7kIFKBuhUu/Gd+JgX13L+B4HT80v0J/lppMX+jJFuNo8IYch7On/oIZiQ5wsqJTNyLJpDWKsO8izl/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOOsVysho0kG3dMNuyJ8iandQjF0M1o7ud7Hjs5ee6c=;
 b=GC57q7++NsTB6t2SUfQ0eCmZ8fxTMiDJ92kFoC3v5pJy8DV1vXFa1G/HFVCihP59oetMHWybtLrTqIYHH7nsnvd5k07HmDcR6mD9Ch3VbpWArveLZIrkkZ0UES6ZhZH64vOwic7SbXYiAzOSmNBTqCDWxqYnPVaTHC7Ljubn6cU=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by PH0PR04MB7704.namprd04.prod.outlook.com (2603:10b6:510:4c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 07:00:17 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 07:00:17 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] ata: octeon: Drop empty platform remove function
Thread-Topic: [PATCH] ata: octeon: Drop empty platform remove function
Thread-Index: AQHZHBxeyVPDQlY9xEKFkxi1Y728Vg==
Date:   Fri, 30 Dec 2022 07:00:17 +0000
Message-ID: <Y66MgAnHgvyv1N8b@x1-carbon>
References: <20221212214112.3775327-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20221212214112.3775327-1-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|PH0PR04MB7704:EE_
x-ms-office365-filtering-correlation-id: 1fe10fe4-0d9e-44cf-5d24-08daea338248
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oKtnqMC/t7fo5gLH1aSDoLWqdLXnlszZrve4fCGUoiLT2f67H9Hwf2M/6wM9J+DePRzWKCjINknN0RUETEbEjHibd5CXInDQJE9Bjk2FDZt/g1H3iC8Rpe3enNonfp1G5rfD1O8opf2CN2OZMmPnnh3rfRC1sH6bEzwPYEkrS0m4uGPDMYtxLTTAtveKKKS/HcNg/gp0trv8ZGiceMoKGzauTXV+iC6WGWduuwhQruK3aD86fygRJw0QyXmxlPgr6HiI0jD303VYfNxXfE711WekpNOEl4T7PP9ubHF25aMtpUsHhtoESBqg3gyMT8M1svUyJ+s3n5TPJuHE1b14lNk/oGR/TqwLPhW8Y/2bsY77nkZn947TbRg4QfrCBFB6X8pEyMIYMaRMBDkHtEVg7ZjvIGfmP3nDJpYxl6e0ixeg78uU7T7KpvxtaHqM9YYVfxUv9U5H7pU3lPyFnR1q91QZLQxIdJmQiqwH4SZLxVI+Ft1s15bq6o9wguyoKDUrqTceZHv1cE6zUHcI0tMHPxkbyV3/5dMA4EXmsVp7R0lQG9lEsQTdSE7fKf4nv+zbAoIJ+TfZ8k+/g61vjVKbcLoviZ8CzSeGwtZCa6U2x7D+Nm4iHHwNAlLu7tRs0Q0SNjFjIt7f9fzhr3/5HOzMR7AZkyNBnzRg0agKoXREaPRsIYNw8G4r3U7XyPoSTNYHjIylH3ZncgBdSsTOcdW+nqn4iJa5aIgvtmcPg17qwcYa+BuyZMzVEtDS0lopyjtA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(66476007)(5660300002)(41300700001)(8936002)(64756008)(76116006)(66446008)(4326008)(66556008)(8676002)(66946007)(91956017)(316002)(33716001)(478600001)(6486002)(54906003)(6916009)(2906002)(186003)(6506007)(26005)(86362001)(9686003)(71200400001)(38100700002)(6512007)(122000001)(82960400001)(83380400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFpwL1NXU3M0R0FXR2txcytZZDdSck9TaTROYVlQaEZwYVZFYklnZnJIbzd2?=
 =?utf-8?B?d3RLSUU5amIvMXBMZGxoUHlkTDFkbEl4aklCMEVpSWV3VjNoYkRCVUk5dnRm?=
 =?utf-8?B?bWpUajBSZ1QxaUtueUlYZXBXSnFhMzY3NkUrSitleDJsUU1wR0U5R0wrSHN0?=
 =?utf-8?B?YXRtejMxaHpLeC9MU0w1U2hSbDI0bjBaZ0FBYmgzdWQ4U3BrdTU0NSs1N1Jv?=
 =?utf-8?B?YzVaTHpjZWhWVFJCZHFtUEdVUDlVQXEzcGFSNEdXWG5hSUtJVUJGOFFBQ2tR?=
 =?utf-8?B?L0MwN2tXNlpwR1ZZNk5mdDkyTkZkMTlCZVNHRUw2Q0F6eFVRNE90dGhnQTQx?=
 =?utf-8?B?cTNVY0tUQzVKYXhSckFDYldzTEpDaDlkR09tM1R1UmxrdlBEeFZTVXRKaTBE?=
 =?utf-8?B?WWtTRkVtMExTNlFldnNUcWF5Rmw3b244UGFHLzlNQWlzd3pyNXEzK1hKTnVq?=
 =?utf-8?B?SEdVbGRYelFlR2pxeDhiNnhMUGtzMXZsdHh4NmNxcktRT2w3U2p4aU4xV29M?=
 =?utf-8?B?d2NlVVpLQS9mRjVWU0daSEpWTDhwd3NLRS9qYy9neGhRaTlXc0FuZGlIVGNR?=
 =?utf-8?B?YmNMeFpFMER1WWJGczVobDJIWVZYeWxGL2xRRWtNV1NMR0Vnc3k0UW5tcUh6?=
 =?utf-8?B?TkgvREZyUGJLb2NiajU1cWEzc3ppdzc2aGlra2FKVVQ3MUdQcS9ueWdTT0Qy?=
 =?utf-8?B?NmhiVUFVVHlyNUYwMGs3SmZVUS83VVdzSXNFZDY3cVF5Z08zT2VNeHBTamJK?=
 =?utf-8?B?bStWSStHaWxBTFQzZm1OTUxVbjhKaCtuS25qOTd4OEdwRElUOHh0cmEzeFE4?=
 =?utf-8?B?L283eGFldVR1MmswTmF2R1ZOWjl2WllsUWw3d2gzaG1YeGVPM3d5TDlMUTNL?=
 =?utf-8?B?K0treDJZVjhtU2tNSW41eE5ETmZIRDRoT2tXaXVPZXplU2w2RzJPaUpaQk1y?=
 =?utf-8?B?VHBLUEJoRitIdzFUSkNLWWhwZFdORTM0VFo0VVlyWjBlSUZIbUsybDR4ajRK?=
 =?utf-8?B?dmVTeTlPUUhWUUZ2cVFCVWNDQW1ieDBLTnFhNFNqYUIwOWFSbk82NlRyY1Bl?=
 =?utf-8?B?dHovVHNVZlBNY3diaGVMRE0yOWJhTjBLZ2dENHJZcmtHcWhtVllLall4THR3?=
 =?utf-8?B?NTF3dHY2Z3djR0oweW1UemtoL25jVEhGbVVKV2Z1enVzUEU0SGNRZENKcitD?=
 =?utf-8?B?U1lJUzVHVFg2djlBeG0ySW5ZbGdJWmd1cUtoejJDRk9UbkFUWExIVGF1THhz?=
 =?utf-8?B?U3BudEdqRkdHYXBVMGV4M21qanE5WGlHeEN6S0MrMDFQSlU2cEJseVMvTk45?=
 =?utf-8?B?cUVJODJReXpncG1NQzJTT0tvWDdHTjFaR1FkNDEwZUZOQVlERFhSREpmRXRP?=
 =?utf-8?B?SmxrMS9QSFN0YWxXbnk3RlFvQWtRaXJENXdHNmhzRi9hdXREL1BlRGV2bXhZ?=
 =?utf-8?B?Z0JNMVpsVjJ3MHdVVTkweldscGJDbmNiUXZQT3Q0V245cXJFV24yWDFmdTBZ?=
 =?utf-8?B?OURVeGdHb1ZDZlRwSlIwNzVrb2pLV01MNGZVWVVMb050ZTUvK3dYRk1mUzJy?=
 =?utf-8?B?VFpPczQyMW5yWnlXWGM0L0ViMm55b0JhZFU2U1c3YlNyMSs3ZnF3ZVNDMjNv?=
 =?utf-8?B?NDdzUk41UTBFQ01GMUR6c1BRcUxzUDNFOGpvZ1ZOdHhkU2VpbU1ieFRyenhH?=
 =?utf-8?B?R3pVM3FiMkxSSGxUSHRLY1RER3U0dXViTkdsU2REeHYvc28vRzN5MlpSdkR6?=
 =?utf-8?B?Nm1NbWlVeHRRWklBbzVGQ1FvZjQ0THRFQVdRQ05kenlCL1FjMjFOSk44czVD?=
 =?utf-8?B?OUJOUVIvTjVBZmNDaVluZU9sUkYrTEhLWkg3VTJMeDV2Q0Y3a2hlQ1Y0T0cw?=
 =?utf-8?B?blkyR0M2TnlsSm0zVGFva2hpZ0lUYnRwWHJxc0dacG0xT2NNNHRDNDJRR01B?=
 =?utf-8?B?WEZ2c0FJYzJab2hJdWtxalB0SFRHVHhnaC9PK2wrTFkrUkEwZzJOTEc3cVdY?=
 =?utf-8?B?dm95SWhWT2lEU0hWSjNNL0VOYXZUMWZmRkgwajJrNkFtVk5NaE1mOHZKSHZY?=
 =?utf-8?B?YjEwR3BkSUI0dDliVCszai9GMXkzYlVFZ2dNeE56dmM2RDVXbE9jb0NJU3hR?=
 =?utf-8?B?WmNYSjMwMW9LSHZxbHZ1U25MaUsxcHNDbHpOREIvUWgyalNJMFp1a1MvcFc3?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49B5D94A66B569479C24CB756249F594@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe10fe4-0d9e-44cf-5d24-08daea338248
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 07:00:17.6202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dVW55C9K+I4P2nb2FkvzOrEOy7zFKGaqz0YMsxyAErCGs8AIbE3syySo2iNdiZ/N5ul5PXcN6JieiYPWWB4ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7704
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

T24gTW9uLCBEZWMgMTIsIDIwMjIgYXQgMTA6NDE6MTJQTSArMDEwMCwgVXdlIEtsZWluZS1Lw7Zu
aWcgd3JvdGU6DQo+IEEgcmVtb3ZlIGNhbGxiYWNrIGp1c3QgcmV0dXJuaW5nIDAgaXMgZXF1aXZh
bGVudCB0byBubyByZW1vdmUgY2FsbGJhY2sNCj4gYXQgYWxsLiBTbyBkcm9wIHRoZSB1c2VsZXNz
IGZ1bmN0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xl
aW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL2F0YS9haGNpX29j
dGVvbi5jIHwgNiAtLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2FoY2lfb2N0ZW9uLmMgYi9kcml2ZXJzL2F0YS9h
aGNpX29jdGVvbi5jDQo+IGluZGV4IGI5NDYwYjkxMjg4Zi4uNTAyMWFiM2VkZTQ5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2F0YS9haGNpX29jdGVvbi5jDQo+ICsrKyBiL2RyaXZlcnMvYXRhL2Fo
Y2lfb2N0ZW9uLmMNCj4gQEAgLTczLDExICs3Myw2IEBAIHN0YXRpYyBpbnQgYWhjaV9vY3Rlb25f
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlyZXR1cm4gMDsNCj4gIH0N
Cj4gIA0KPiAtc3RhdGljIGludCBhaGNpX29jdGVvbl9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gLXsNCj4gLQlyZXR1cm4gMDsNCj4gLX0NCj4gLQ0KPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgb2N0ZW9uX2FoY2lfbWF0Y2hbXSA9IHsNCj4gIAl7IC5j
b21wYXRpYmxlID0gImNhdml1bSxvY3Rlb24tNzEzMC1zYXRhLXVjdGwiLCB9LA0KPiAgCXsgLyog
c2VudGluZWwgKi8gfQ0KPiBAQCAtODYsNyArODEsNiBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKG9m
LCBvY3Rlb25fYWhjaV9tYXRjaCk7DQo+ICANCj4gIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJp
dmVyIGFoY2lfb2N0ZW9uX2RyaXZlciA9IHsNCj4gIAkucHJvYmUgICAgICAgICAgPSBhaGNpX29j
dGVvbl9wcm9iZSwNCj4gLQkucmVtb3ZlICAgICAgICAgPSBhaGNpX29jdGVvbl9yZW1vdmUsDQo+
ICAJLmRyaXZlciAgICAgICAgID0gew0KPiAgCQkubmFtZSAgID0gIm9jdGVvbi1haGNpIiwNCj4g
IAkJLm9mX21hdGNoX3RhYmxlID0gb2N0ZW9uX2FoY2lfbWF0Y2gsDQo+IA0KPiBiYXNlLWNvbW1p
dDogODMwYjNjNjhjMWZiMWU5MTc2MDI4ZDAyZWY4NmYzY2Y3NmFhMjQ3Ng0KPiAtLSANCj4gMi4z
OC4xDQo+IA0KDQpSZXZpZXdlZC1ieTogTmlrbGFzIENhc3NlbCA8bmlrbGFzLmNhc3NlbEB3ZGMu
Y29tPg==
