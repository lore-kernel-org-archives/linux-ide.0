Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FEBCA0FE8
	for <linux-ide@archiver.kernel.org>; Fri,  1 Sep 2023 20:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350740AbjIAUn0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 1 Sep 2023 16:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245611AbjIAUnZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 1 Sep 2023 16:43:25 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CCA10DE
        for <linux-ide@vger.kernel.org>; Fri,  1 Sep 2023 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693601000; x=1725137000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iGusXnnmgbUvlJ/lkx9AwFR6BEZLMzS5VD9UPPlV2+I=;
  b=mDsWqF3WzHwHtg7fvdBE0y/KBqqwy0GpTgrMdOy1+ZmF14FI2PTD29Ul
   DhCYaPPy9Y7G1cIQ0GNQM9wvPgflCfmvYWy/j7Ykn7nWRUmRhAY0OJ0GK
   lt1oa+PRamz6Tz2D227wg1dP7aC8F0gpjpuUW8x4y6JD/eXQRq3OSgvUA
   3zXkyrogDkhFzceqPWkzkGSiPjHSXpTvYbjEvlvq8f6iIa4Uvokwp47j7
   db8Q+2P6f+q8Zm6Xi3HoW9hquykR6aKFdcNUpmX20WpvHlnQQZkYFj21P
   l+uR+XozqjKEQgYKfjjeNMj/NB3l5yaX1eutBmrVuPM/O8zl/CAalln8E
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,220,1688400000"; 
   d="scan'208";a="243080299"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2023 04:43:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS03DwuuJXY17darndv2qCbp9SQmwJj43iT4bzuY9SIQ/t06AJeiAziqe3AcAvkbCOeG6UIaI9vKMAKjbzCsk4fMoPYE/KZLq8F0Jp7B0g5WZMFk//wiGlKeKnNIXlRVLVxIrYAfUTZW2tw3ZQDbzW8A1RQLrTmee+5FakDyzMLEE4wI6yVOj4wF0r29x0jBWCNcKJOi+Q2uWgN7IGNGWrx14Si4g1WeIe9G6dAVhmHMYivb5pp/2cFOJib7g3m0tLrf+fFLm86xuAU0ZKi/Vok2iuQnbxj+M8luAgfW0pM38rGrEh66mYnzqm1usDbZCeTByPxCFulGSmRfP+51vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGusXnnmgbUvlJ/lkx9AwFR6BEZLMzS5VD9UPPlV2+I=;
 b=KOM4wpjmjU5lYvbKN/m0uFrICdUux6ZQPoGrYB0l5vWcjrTMyHMN73BHOPekXI/tQVglT5scRWP18omqzipb8h5YnmCvVLDVkHYhjdYDuhM3DZ05Ro7hG3zAJhgNfUXsNr5ynTfEsV1pKQoPqzpaK0TwnhHAoznO7JPV+BKhP0kqauhxN2fdhKAMzi8AC31wzmKnhjV7X6sqQHZaMxLeNn+dfxKLbZ64ChkTplzp9YejdQ4Ygdi0mk1o1m9b+ALGSuqik1ni2M07nKENi1r59mtfeROOZbCWK3GzU3HyNRc0RkvGtdudID8FQWwnAYtHN8tX593fOiKGkzTRuSZNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGusXnnmgbUvlJ/lkx9AwFR6BEZLMzS5VD9UPPlV2+I=;
 b=cZr8mwMQVA7eXi/hpubzG52UVqy7vgesfpEmnLjNaPF0vNusigfRDhA6Wwl4KNNc2SIblKlR6st/4FqPxA5lNY6HAtS0uRCO52Z5nnYuEhzo/EBO6dK/0SzBaRZMvQzRhuEdEVgrHQLBkpb4xI7vOQj9lY5Yg3U6O4ssLKpw0xU=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MN2PR04MB6334.namprd04.prod.outlook.com (2603:10b6:208:1a2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.17; Fri, 1 Sep
 2023 20:43:16 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.014; Fri, 1 Sep 2023
 20:43:16 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Werner Fischer <devlists@wefi.net>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH v2] ata: ahci: Add Elkhart Lake AHCI controller
Thread-Topic: [PATCH v2] ata: ahci: Add Elkhart Lake AHCI controller
Thread-Index: AQHZ3RTvs+jyRha4TUGbd0ShoDPuuw==
Date:   Fri, 1 Sep 2023 20:43:16 +0000
Message-ID: <ZPJM4zlH3VZv0vxf@x1-carbon>
References: <4cbde7d33f5b73b33f798b56b6e3cd3ce3764647.camel@wefi.net>
In-Reply-To: <4cbde7d33f5b73b33f798b56b6e3cd3ce3764647.camel@wefi.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MN2PR04MB6334:EE_
x-ms-office365-filtering-correlation-id: 036eb64c-b2ac-4663-fad6-08dbab2c11a0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dC2fedVNi6lUFScgIOM7aKDuouRh12Lb3y9qF3yUmlyYwZkcFC/frAoFtkXn2/k+f7PSCoQjIua8LUrL5CuMy2QhwLdOza+oXETniebvp9k1l4k4KGuWEooGrzJ7QClEy90BfNapcT45Gne0nOlb6ZOQAi1KOl/C6RNiHNBSC+hsVtdjPGTyTXGHsoxzvoKzX7Is/F659KCrvMcEhq/WbYeT32YQdqU24IjKB27EXNRjX6FrtpmeHwsBPrOOfGFv0CVWi6Uf3k97gGlmX8VmT+OA1N68tpLMrYr7ijvdnPEkZxHRYvE9dY3CYSJ2UpG4AGGymYpIxlQK60V8FJAazl4tgbXq/qy7rR1bpNlSDlSV+Uj3uiJ8z9/pivdYBfNSf8eFsh6eZtc9opDDI8wPYt30BL35qFrywKEzcvKCNHam8CaQvjOkS+l3mgO01ZKj2ViVZAYs4sk5dOsgzOpIf27KkMw8HTi0Cp/3+vZKFXoX/WOxT99GEn1anYz5iGMWI7IDvhU//ANlovbiOLFdkRybIvI/oAuCGj/yB0Ag4va6G83hE2xl5mqBALVfl/xyZzJoQ5Y8/NWoAv1GwxHb1nJHnRM6s0urlHK4ftZE/nE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199024)(186009)(1800799009)(71200400001)(6486002)(6506007)(6512007)(9686003)(966005)(478600001)(83380400001)(26005)(2906002)(33716001)(64756008)(6916009)(66556008)(66446008)(316002)(41300700001)(66476007)(66946007)(91956017)(5660300002)(4326008)(8676002)(8936002)(86362001)(82960400001)(38100700002)(122000001)(38070700005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mmo1NTFOWnYwQysvdldqSXdTbHpHSlJ2bERZQlVFZXdsTmlCaEJyTk5OMkZj?=
 =?utf-8?B?TWhZMzRYOGNjUDNKM2hxRE1Lbm8yWjRXMnJuYUVNQU5XL3YwNUc5M01zWXBG?=
 =?utf-8?B?emVMeldkQi9BUWVTMW1MOFMwSUhwV2pvMDZpSGZiL0YrQUdTbVhueVAvRE1i?=
 =?utf-8?B?OXp6MGlsajJlUVRoSFRZWkEzbkk5T2tIOE02dUV3TUFHUkkvQ3A1SkFRSWVJ?=
 =?utf-8?B?NFpUdUg5N3F5aERIVlRwMGlzZFZNSkU1UnIxWm8yYzhheW5FNDRMZ3FwWXMy?=
 =?utf-8?B?ZnltcU9UeXdFZTEvYkFKUGd3WHNJbmRQcjJ6eVpSNU1ycjRralVlY2dPb00x?=
 =?utf-8?B?M0dYL0pQODZrZnlqY3lLZkhpQmtXL0M3SFlMUXdSNG10SnJzb2xTZFBaczZV?=
 =?utf-8?B?bHpNWWFlWjNFTmtrZ2M1T25Udkl0L1FNQkpLck9IbXczVW02ZHlBeTh3U1Nu?=
 =?utf-8?B?NUJYZUpDWnJPa1pOT3JpRHZSTW8vVytuWVBNWTdOOTA1NStnK3Fxd3Z4R0Jk?=
 =?utf-8?B?VFRWajRqRTJxNUszY1d2MG5HRjVrUHBDRTVGNDVjYTJYSEswNE1sOFlrVHQ5?=
 =?utf-8?B?YmUzdlpqbzVlSmViQlRjRlJjY3lsUjloUmg4dWRabTVjMGJlNS9CTG9mRU5J?=
 =?utf-8?B?R1ZzVnpEMlFVVndzTzNoMnFZYkhUR3RHOVVEbUpiSzZxazhOS1gvbFRvQXF6?=
 =?utf-8?B?NUdNaURZQmNxNUs2VTMrbWhqSHBaRVllY09iZHNJZk1nWEN3bmIxWHRFSDNK?=
 =?utf-8?B?VUZubUFWU0M1d3UrOUsxR0l5eXpiOHVxcjhXdE90MVdFTDdWbmx2MkNJaUR0?=
 =?utf-8?B?U21YZnJVMkw4VktNNU9PZ0x6OTkxKy9MVlZYYUFGQjQzd3ZvSTZYOERQNmJN?=
 =?utf-8?B?REhKd0VVUFJVNDl0Y2JNQ1pTNHBlbStQQlowNHBUbkk3WFExaGQrYjQ0dnRN?=
 =?utf-8?B?Vk5SbWZ4ZTZDbmIzVGdyNzRhajlhVFU4Q1RJNUc0dnlzaDAvc1o3cVBVWlZa?=
 =?utf-8?B?WHFUZS81QlhwN1VDTlBHYWNmUGVDQm5qbkZWTTFRZTRlRVIzRE96YUoxdjBP?=
 =?utf-8?B?SHQ2Q215Ry9COEZBdmpOSzNtR3gwUFdlczEweWtlU1AzZHJ6em5nODZNbENv?=
 =?utf-8?B?eWJUNlRkakIvb3BVTWRJRWZ1SkhDMDdWcnpERCtLTCt5aXNNV3k5TjR1VkM2?=
 =?utf-8?B?ZnlyUTVZM3lRcGZENjZnY2pVS0IxM2tQbjhhak42dGtaeDVUa1NEdlV0Vzho?=
 =?utf-8?B?ZnBjK244dFVnRE1TNi9xNUs0S3U0M01yZDEydStHQjFEKy9zWERUbE9JQ0xR?=
 =?utf-8?B?TS95UDF0R2VyK2xpT0Y3ZWl4VitMazlodUcvaXAzc1VOODl1TElHSTc4bnVv?=
 =?utf-8?B?MTVCNTUyaFZvMFUvVkhEMEo0bldlYUxvYmtPN1hQY2doUXFXTmNnbkFEUHhX?=
 =?utf-8?B?Q2pEK2REZVhKK0haRnNXeXpLbjViMHR3MGtwWWNFSnl6VDUxNWVQL1F4cUwr?=
 =?utf-8?B?ZXlMVkVxK1VpeFUvRUlrQWwydnFjUHBnVURqcW1uTjJod3lwV3NVS21sUE1Y?=
 =?utf-8?B?RTE5QmtnMFc3ZDNlUU1aZUlNOUZTalk1MGV4N3NwMmprd2hlR0Rwb3Zyd2Y5?=
 =?utf-8?B?NkRKZlh5UmhSSWlpaEU5WmlaZXcvSDVaNnA3K0pTMXBVd1p1Z1h3OElMZFVn?=
 =?utf-8?B?N2RhOVpiWE9XQ0lEdjM0RHlUT01LMUV0Zzh3a09UL1JJbDJlOEJlNEZnWlZN?=
 =?utf-8?B?eTFpTkl3WThBdXJ0YlNiTE5ZQm51WDNBLyt5akllQVJyVWJobjR2cUpIUlhN?=
 =?utf-8?B?emlOLy9RZWlwalNienJ4bzBkaEhPdnBRUWtOSWJhbXhkRlI2KzB5d0RXbHBw?=
 =?utf-8?B?WFNPUS96VzUyZW51MUhINk54WTlMS1NQd3B4U0xNcjJPUDY3LzZscWs1MG1n?=
 =?utf-8?B?T3llTDdNbVpEUmN1T2N5K0xSU3Y5WlR5TkZwYWFJWjNjSVlaV0s3M0cxSFJZ?=
 =?utf-8?B?dEdFOUpYQnBrZGYxUHc4WG9YajEyMVl0WU5zWHFoMXMzNC8zd2hXSnZzOGxC?=
 =?utf-8?B?b2lvQmZsSDVtNUVGUWxscWd3OVlwTVpSRzJraU5kdkFTbWU0bjN3MXJoVXJs?=
 =?utf-8?B?MVY0MUVZamxvVHZRb1JtWkZYVnNPRUl3N2J3aDhjT2ppVjI0a0dxVEVBWmo3?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AAA7D212EB0494E890323935A8AE1C9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w46AbNFoKzETO4Cs97g0aj29XaJDag6Y76Z09uf7MDQAMhsj43p7AzqtSmG7LMrQ0pSH/YjkZvSQ3xRwMqVTemvOV1ZT8/AnwtSgqW0NG6z2ivAdbwBDS8DRHJPq4ZqmYHAeha9dwvdWgpToomvtGAVb1srbprWB71CB2nNp/6Ork5rYwt/ykDr5A2WKcwqzsNGuO+uiMtoVR277w64ZUz31T9IY9UmsUtsGidpz/N7vR7MDYAUhAycbFR/OzZdSk+//Mxm6Cy/BjZFls8Oy/1INy9nFPBZONTlV/sODelE5esNpA55MbPA4T0WlGV9OiybTTf3hBcs0y8OX5VafeaDHq7q1F8BwLzXt7gxIA3VkcNZHWr6d5Rfq8bNLzTrE0jCkDuxn7AA1sz2xZvfnZYndVhaLv3jJ3pkIFkkiRVFiIXFMI36SW8WZcWst3V/s8mWDEwzwgiVGobyyNYcoIXuEajT6brQ93eHimIbA2a3DTYeY7jd43FphB05PEOjBEJyfSCUSBS4MXGY+Ap9YoHL1Pryc/0eoko3bt/k2xlz2+3z+5GrSYc7SuarJ9vyy6hUE/zWcUP5UXJC8XLcHwsu//t19LkRRlweNm9EyEnCX3LViTqc7lv7SXtZXVbvMP0RKvjUW7MCRg1aPPkCvupIXLpEf2ZcJZ8cBBagqfKM+x38NouSMGyXotwjJaOtPowEaEbjVWPqa1tBsCmZ8fDFV9oEPdU8igHA2X/QWeJBsQDgTF6ZGkZRsVOc45zyJCi8nULDoxvEhEhpva7nECRNZ6tHqYVZBhwFb/Toi8BM=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036eb64c-b2ac-4663-fad6-08dbab2c11a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 20:43:16.5602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3XTcgkaOMeSx0cXeTw9P6GlGIws/aHpsyU+cHvGiD+QtLdkaz1UkI53Jpq1r1jOjcKfW6PQOTs/PJrZguycJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6334
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

T24gVHVlLCBBdWcgMjksIDIwMjMgYXQgMDE6MzM6NThQTSArMDIwMCwgV2VybmVyIEZpc2NoZXIg
d3JvdGU6DQo+IEVsa2hhcnQgTGFrZSBpcyB0aGUgc3VjY2Vzc29yIG9mIEFwb2xsbyBMYWtlIGFu
ZCBHZW1pbmkgTGFrZS4gVGhlc2UNCj4gQ1BVcyBhbmQgdGhlaXIgUENIcyBhcmUgdXNlZCBpbiBt
b2JpbGUgYW5kIGVtYmVkZGVkIGVudmlyb25tZW50cy4NCj4gDQo+IFdpdGggdGhpcyBwYXRjaCBJ
IHN1Z2dlc3QgdGhhdCBFbGtoYXJ0IExha2UgU0FUQSBjb250cm9sbGVycyBbMV0gc2hvdWxkDQo+
IHVzZSB0aGUgZGVmYXVsdCBMUE0gcG9saWN5IGZvciBtb2JpbGUgY2hpcHNldHMuDQo+IFRoZSBk
aXNhZHZhbnRhZ2Ugb2YgbWlzc2luZyBob3QtcGx1ZyBzdXBwb3J0IHdpdGggdGhpcyBzZXR0aW5n
IHNob3VsZA0KPiBub3QgYmUgYW4gaXNzdWUsIGFzIHRob3NlIENQVXMgYXJlIHVzZWQgaW4gZW1i
ZWRkZWQgZW52aXJvbm1lbnRzIGFuZA0KPiBub3QgaW4gc2VydmVycyB3aXRoIGhvdC1wbHVnIGJh
Y2twbGFuZXMuDQo+IA0KPiBXZSBkaXNjb3ZlcmVkIHRoYXQgdGhlIEVsa2hhcnQgTGFrZSBTQVRB
IGNvbnRyb2xsZXJzIGhhdmUgYmVlbiBtaXNzaW5nDQo+IGluIGFoY2kuYyBhZnRlciBhIGN1c3Rv
bWVyIHJlcG9ydGVkIHRoZSB0aHJvdHRsaW5nIG9mIGhpcyBTQVRBIFNTRA0KPiBhZnRlciBhIHNo
b3J0IHBlcmlvZCBvZiBoaWdoZXIgSS9PLiBXZSBkZXRlcm1pbmVkIHRoZSBoaWdoIHRlbXBlcmF0
dXJlDQo+IG9mIHRoZSBTU0QgY29udHJvbGxlciBpbiBpZGxlIG1vZGUgYXMgdGhlIHJvb3QgY2F1
c2UgZm9yIHRoYXQuDQo+IA0KPiBEZXBlbmRpbmcgb24gdGhlIHVzZWQgU1NELCB3ZSBoYXZlIHNl
ZW4gdXAgdG8gMS44IFdhdHQgbG93ZXIgc3lzdGVtDQo+IGlkbGUgcG93ZXIgdXNhZ2UgYW5kIHVw
IHRvIDMwwrBDIGxvd2VyIFNTRCBjb250cm9sbGVyIHRlbXBlcmF0dXJlcyBpbg0KPiBvdXIgdGVz
dHMsIHdoZW4gd2Ugc2V0IG1lZF9wb3dlcl93aXRoX2RpcG0gbWFudWFsbHkuIEkgaGF2ZSBwcm92
aWRlZCBhDQo+IHRhYmxlIHNob3dpbmcgc2V2ZW4gZGlmZmVyZW50IFNBVEEgU1NEcyBmcm9tIEFU
UCwgSW50ZWwvU29saWRpZ20gYW5kDQo+IFNhbXN1bmcgWzJdLg0KPiANCj4gSW50ZWwgbGlzdHMg
YSB0b3RhbCBvZiAzIFNBVEEgY29udHJvbGxlciBJRHMgKDRCNjAsIDRCNjIsIDRCNjMpIGluIFsx
XQ0KPiBmb3IgdGhvc2UgbW9iaWxlIFBDSHMuDQo+IFRoaXMgY29tbWl0IGp1c3QgYWRkcyAweDRi
NjMgYXMgSSBkbyBub3QgaGF2ZSB0ZXN0IHN5c3RlbXMgd2l0aCAweDRiNjANCj4gYW5kIDB4NGI2
MiBTQVRBIGNvbnRyb2xsZXJzLg0KPiBJIGhhdmUgdGVzdGVkIHRoaXMgcGF0Y2ggd2l0aCBhIHN5
c3RlbSB3aGljaCB1c2VzIDB4NGI2MyBhcyBTQVRBDQo+IGNvbnRyb2xsZXIuDQo+IA0KPiBbMV0g
aHR0cHM6Ly9zYXRhLWlvLm9yZy9wcm9kdWN0Lzg4MDMNCj4gWzJdIGh0dHBzOi8vd3d3LnRob21h
cy1rcmVubi5jb20vZW4vd2lraS9TQVRBX0xpbmtfUG93ZXJfTWFuYWdlbWVudCNFeGFtcGxlX0xF
U192NA0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2VybmVyIEZpc2NoZXIgPGRldmxpc3RzQHdlZmku
bmV0Pg0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gVjEgLT4gVjI6IEFk
ZGVkIGNvbW1lbnQgbWVudGlvbmluZyB0aGUgYWRkaXRpb25hbCBJRHMgNGI2MCBhbmQgNGI2Mg0K
PiAgICAgICAgICAgYWRkZWQgImFoY2k6IiBpbiBzdW1tYXJ5IHBocmFzZQ0KPiANCj4gLS0tIGEv
ZHJpdmVycy9hdGEvYWhjaS5jCTIwMjMtMDgtMjkgMDk6MTQ6MDkuNTM3NDUwODQyICswMjAwDQo+
ICsrKyBiL2RyaXZlcnMvYXRhL2FoY2kuYwkyMDIzLTA4LTI5IDExOjIyOjUwLjc3OTgzMDUyNiAr
MDIwMA0KPiBAQCAtNDIxLDYgKzQyMSw4IEBADQo+ICAJeyBQQ0lfVkRFVklDRShJTlRFTCwgMHgz
NGQzKSwgYm9hcmRfYWhjaV9sb3dfcG93ZXIgfSwgLyogSWNlIExha2UgTFAgQUhDSSAqLw0KPiAg
CXsgUENJX1ZERVZJQ0UoSU5URUwsIDB4MDJkMyksIGJvYXJkX2FoY2lfbG93X3Bvd2VyIH0sIC8q
IENvbWV0IExha2UgUENILVUgQUhDSSAqLw0KPiAgCXsgUENJX1ZERVZJQ0UoSU5URUwsIDB4MDJk
NyksIGJvYXJkX2FoY2lfbG93X3Bvd2VyIH0sIC8qIENvbWV0IExha2UgUENIIFJBSUQgKi8NCj4g
KwkvKiBFbGtoYXJ0IExha2UgSURzIDB4NGI2MCAmIDB4NGI2MiBodHRwczovL3NhdGEtaW8ub3Jn
L3Byb2R1Y3QvODgwMyBub3QgdGVzdGVkIHlldCAqLw0KPiArCXsgUENJX1ZERVZJQ0UoSU5URUws
IDB4NGI2MyksIGJvYXJkX2FoY2lfbG93X3Bvd2VyIH0sIC8qIEVsa2hhcnQgTGFrZSBBSENJICov
DQo+ICANCj4gIAkvKiBKTWljcm9uIDM2MC8xLzMvNS82LCBtYXRjaCBjbGFzcyB0byBhdm9pZCBJ
REUgZnVuY3Rpb24gKi8NCj4gIAl7IFBDSV9WRU5ET1JfSURfSk1JQ1JPTiwgUENJX0FOWV9JRCwg
UENJX0FOWV9JRCwgUENJX0FOWV9JRCwNCg0KRGFtaWVuLA0KDQpjb25zaWRlcmluZyB0aGF0IHdl
IGhhdmUgbWFueSBJbnRlbCBBSENJIGNvbnRyb2xsZXJzIHVzaW5nDQpib2FyZF9haGNpX2xvd19w
b3dlciBhbHJlYWR5LCBhbmQgd2UgaGF2ZW4ndCBoZWFyZCBhbnkgY29tcGxhaW50cw0Kb24gdGhv
c2Ugb3RoZXIgdGhhbiBmb3IgVGlnZXIgTGFrZS4uLg0KDQpJIGd1ZXNzIHdlIGNvdWxkIGFjY2Vw
dCB0aGlzIG9uZSBhcyB3ZWxsLCBhbmQgaG9wZSB0aGF0IGl0IGlzIGp1c3QNCkludGVsIFRpZ2Vy
IExha2UgdGhhdCBpcyBwcm9ibGVtYXRpYy4uIEkgZ3Vlc3MgdGhlIG9ubHkgcmVhbCB3YXkgdG8N
Cmtub3cgaWYgRWxraGFydCBMYWtlIGlzIHByb2JsZW1hdGljIGFzIHdlbGwgaXMgdG8gc2VlIGlm
IHdlIGhlYXINCnBlb3BsZSBjb21wbGFpbi4uLg0KDQoNCihZZXMsIG9uZSBwcm9ibGVtIHdpdGgg
YWxsIEFIQ0kgY29udHJvbGxlcnMgdXNpbmcgYm9hcmRfYWhjaV9sb3dfcG93ZXIsDQppcyB0aGF0
IGhvdHBsdWcgaXMgbm90IHdvcmtpbmcgaWYgeW91IHVzZSB3aGF0IG1hbnkgZGlzdHJvcyBhcmUg
dXNpbmcsDQpDT05GSUdfU0FUQV9NT0JJTEVfTFBNX1BPTElDWT0zIG9yIGhpZ2hlci4uLiBidXQg
dGhhdCBpcyBleHBlY3RlZCBhcw0KQUhDSSAxLjMuMSBzZWN0aW9uIDcuMy4xLjEgY2xlYXJseSBz
dGF0ZXMgdGhhdCB5b3UgbmVlZCB0byBkaXNhYmxlIGJvdGgNCnBhcnRpYWwgYW5kIHNsdW1iZXIg
c3RhdGVzIHRvIGhhdmUgcmVsaWFibGUgaG90IHBsdWcgZGV0ZWN0aW9uLikNCg0KDQpLaW5kIHJl
Z2FyZHMsDQpOaWtsYXM=
