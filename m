Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248B0C77B73
	for <linux-ide@archiver.kernel.org>; Mon,  5 Jun 2023 15:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjFEPLR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 5 Jun 2023 11:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjFEPJy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jun 2023 11:09:54 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511C1197
        for <linux-ide@vger.kernel.org>; Mon,  5 Jun 2023 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685977793; x=1717513793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sVyljENdcGa1Ji2m/olVM8QZ7UnQ3pPfNfrm4RCfLAA=;
  b=GLHbmdd2G1rR/jJls2KDq+F9IjCGuAlxy6a/9WWdjoveX8SxdfmnMKsu
   3n4ESMAyr3jYRLXK8X56x5wFR1P24cH4fr2eOyw4jO+PpQhuA0i21aCLg
   dL65DznZHpprNMYgasdn1mMlZWvzZDillMsWs+M1ffJGJFXt03im/Ts2g
   GiVZBit/I0KI37Iz6kI4c93nxRuDp05jzrTepkrXBwUmZg7Xa9M/deC8w
   qzhRC614TWA6Zjvn+gZJIjuagqYQCsMrYaYDs0ZYrqOAOzNTM6bZegEWC
   SHI87tvZ9zp9EcwI8oNNFEGn+zkwx4hkCz8PQ9nxKqpFYnh20ozUtw5qi
   A==;
X-IronPort-AV: E=Sophos;i="6.00,217,1681142400"; 
   d="scan'208";a="232549706"
Received: from mail-mw2nam04lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2023 23:09:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfkBY2io4BXcPUyEbTdBzC7axPrPfG36uElS1xeNdG6xGdaEivYhIw8gc3gpFIRJPBfT7BFt6n6Eb5iMZDdZ+1Vtm8PS+DoUTLk0rsS47GXTvSB+Y3DGoUAdtVixOHPo98vnoe6t43i1D2ZO++BwBJBWxN7i04tQ2EHo4FMa+UqFwhYUFHLK3yiZrR7qmJSLBlyPcnVuuD9fhZW1nw0fspfje6EBgM3mOMaXLUc3INBftBpaSghr0yiDU/9R69FRXIAna9JJ7mviEEa2x+LVJLM4xxOQbceDShRe4oLLD1kVA+UlPIYLxlGohUnddKEXOCM5gw2p2B9Fzg7B5ji5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVyljENdcGa1Ji2m/olVM8QZ7UnQ3pPfNfrm4RCfLAA=;
 b=dwZfCX8Hz9DjmjgaLw/vEf4ugCZkUzPH8fehYLdpgDtEtnWFWsnTu9heEiPxrfwtfk8Lgs+qGjzQTDqoKvasXpOdyRh0+Hd1X4U4lx5M+QrY0HMHyKbYbhsUoWbwfA1uKjJoLCfGdnmqojr6Pekt+xpAAa7o7hyyqT3/hyFb69Mtucs8fRTI+ximEN0SnN1aVPmI6mX8RLPhNeSrsEyvzs/AeOyhgjP4Pfzv9ZQKWkXKz8UcjeZWJ4JUTMSmXCjY69tCSD1lIHN0V6vnWmDwSfRNHzmUchmkK5ogxN4B/0Aqh4vzT2kBitoYKw1JnGlVoR4dtaj9bxmRlB+wMG2eVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVyljENdcGa1Ji2m/olVM8QZ7UnQ3pPfNfrm4RCfLAA=;
 b=Q3Axmx0UA0SkctP6e48odAWxoWV9NzuUnNJpOWKH1B38Jx8lTwBJkB4ip27vYna4jDhM25J5AFvy27dY+HNwgYORb2XmvLmgM84dylVsBX6MQqtTokVt6hvikuLEXs/pt1RhhhX0X24+/WAk/KpJzrkOWJ/4gqDxB9LbmC2a34U=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH2PR04MB7111.namprd04.prod.outlook.com (2603:10b6:610:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 15:09:49 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 15:09:49 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 0/6] libata: remove references to 'old' error handler
Thread-Topic: [PATCH 0/6] libata: remove references to 'old' error handler
Thread-Index: AQHZl7wiJ9qX+Nzeh0+p316pt+Thga98UAcA
Date:   Mon, 5 Jun 2023 15:09:49 +0000
Message-ID: <ZH36tAPa94aCROSi@x1-carbon>
References: <20230510225211.111113-1-hare@suse.de>
 <a8083851-dc1e-25bd-9790-2c5f8a851c02@kernel.org>
 <9db022f9-8f5d-fd79-9970-8a515ed4c37b@suse.de> <ZH3uZZ/Gqi6HqEwU@x1-carbon>
In-Reply-To: <ZH3uZZ/Gqi6HqEwU@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH2PR04MB7111:EE_
x-ms-office365-filtering-correlation-id: 4b5f0555-4821-4f15-26f4-08db65d6e7f1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: em016ckX0x7Mgk05dniuLx3FxEAZzpEtt5x6f+AQlut8FgxwnWuzJaXxTF4HTgcquxbmqzdkn8gjMlMjYQLizuizuY4X+sVwEQ8GAlF8KJJFcJoLcQBWX7oS8X6Q0EK9wfCCR5jPt1cLWibz4AyFeWbxiwIqoDBDmEE8Ur2cOhykvV/EQciFhxLqeHqnYuaLHLFC9IaPShCSBUNl2EeCWb74nnHG40vqiuN8WIpzVoB1lbLUs3EKoNDB1/qjgxm0cekL2Hb936xtz2IvAgodkmqD9H7pS1yId5vxXN6+PqqI2ma79HrUlhH9YTZOCXIm8gg8kM9KjBN4KtTXmA0FgtHdUrv4ZCckwJfMK8el0EEV3KmYdiQZs/JMv8VLls9OEt2tru4q6SXz4lS24S5bdco142/ISrbgStd6Smv/4fVwCYcGgb9FAoig+CF3Lu941yA2xWnG9Hw+UT/92w1bcG4wDzYUx+CU/KHpSIr4ez7gdYiGp9oJ8722vUPIBocafXXrg+2s9GHSASUky7qVQxDagpuxhN4K1gS3O8652/riTmzA0Jzlhm4oZLBfVZkf66MkekVdAW2h+00kwe01V3wUbTHAMW5hn1ZNRm3Ugo0gy78QVhkWcB2CkHy/4LbW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(54906003)(71200400001)(478600001)(5660300002)(8936002)(8676002)(38070700005)(2906002)(4744005)(86362001)(33716001)(4326008)(6916009)(122000001)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(82960400001)(38100700002)(41300700001)(9686003)(6512007)(6506007)(26005)(186003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm5iUUhrQ3REMnJpQ3d3R0g2Q1R3SEx4QXpPQkpSQ3hnTE9TWE5KdGo0cm5T?=
 =?utf-8?B?L1FMWGNVeUhpK1VUV3FtLys5Z1hzQXk0S0ttSjBYTWtxS2N3dmpKQkVxSHFU?=
 =?utf-8?B?RWEvdDZscHBxK2Z0dnJpOWJjcFhrdndPWHFqSjAxeG5JQUlkS3pabFVRQ2Jl?=
 =?utf-8?B?Qk1tL0VnL2p6Sm5Yb0ZISUt0VUVxbkRrbnhKNWUzVjVodHh6RkNDQ04vYTRR?=
 =?utf-8?B?Q1E4djRJTHV6SDNSQWE5WkZwbHVGSThrTGpOalRwUmFyQzlBQ1Y2MkhnY1NH?=
 =?utf-8?B?NFhNWi8rdjBaS05uRFJMYTQvQmVSTVNVWVhFVHdyVXFPUUxIa0hvVlN3RlNH?=
 =?utf-8?B?SzY2WGRIRlBEV0NjMWttUzRaUk9GamF2bzBGSW1CUE1lM0lXcSs2cVZCdUhB?=
 =?utf-8?B?Y0haRjVtUk5RMlNnRklqdGdybHdZRzNWYUw4RHdYNG9iQUZtVVRhd2xaazlL?=
 =?utf-8?B?UXFGa21KbnkwYklVTURJRVRCbFVheWtYTTlud2ptQzhENU1LZ0FOM1RNYmM2?=
 =?utf-8?B?L2RjQStPSVdqYXp6alpjT1FERzRFVWhrQUdQWlpIZnlKSUpFVDZuNHE2NzFG?=
 =?utf-8?B?S2VKK25yUVppMjF1YVVoSkpzWitWazErSm1BdS85b0VYMTVSQTVRZkpsa3pw?=
 =?utf-8?B?aGxNVWV1RlA0MTZhS3ZyWnUyQkdOV2lDd1p1VmxDTUFDZmFGM2lBK01iNGdS?=
 =?utf-8?B?aGZoNkJCODE3cmV6WldWalRNNk5QMmlwYlFpajJCUnBzRGlPWjIzb09zMFJt?=
 =?utf-8?B?QWdBeHZ0NGE2Y0pCZ3FCYnZ3QTJ2OXNCSVpYNGtjTE5OOUkySmRrbmtVN3Ft?=
 =?utf-8?B?dVlRejZKYUJyMlJub0VQYnlaSU1mQUNMcFE3LzJ4YkdtM0Y5OThxckw1RENI?=
 =?utf-8?B?QXkyNW9sN1F6ZXZqdmcwdDZmOWxQN0Vkam5lcFJ3RjdCbDYwNWZZUklXcjds?=
 =?utf-8?B?UEM5MDY0OUY2a0RIQ1Q4RUpueDE5M2h4R2d6djM0cWRSUWFPSTMxUENlNGtx?=
 =?utf-8?B?R1NqSkR2Z3VGbTZRRjZTYVFKOHFkclZ3TDJKaTJzTlB5L2FCZGZteEhweUNr?=
 =?utf-8?B?RjR2V1VKNENmQkJVc1RyQnh6WFZjTTlBYVhURU5yall1YU4zKzFpUWVDdXJp?=
 =?utf-8?B?aFZJWE41K3RHUzBMRURkeHdPSVc4WDBVRFlVdVJhMkxmeVpEZ1BPN0krbnZ5?=
 =?utf-8?B?dzlOTTNqYnJQcEI0S20xaHhWZ3RUQ3BoTVVwdUthNkdJUVlQaGttd21nbGs1?=
 =?utf-8?B?bGFtbC9oV1pIdFZvSnhTeVp2aUxVdUwzSnRoWDlGeURpZC9rejZpTkg2UWRJ?=
 =?utf-8?B?NmlDYU9VbWpjcXY5ZGlET3I0aUdhWnpkQmlIakdsamI2Y1pBMCtFelU0cTMr?=
 =?utf-8?B?c3IreFlVT0x6TkQ1ZE8xY250bEVOcFJuTW9GU1Y3Kzd2cVFxckZ2TStWRnJw?=
 =?utf-8?B?ZFRKcGMxelF6bkhPTlpwNGN4S2ZTc2twc0VQajVRSzZrSW43QnFNUTJhQm1u?=
 =?utf-8?B?bkk0dVBkU1ZEMmhFUEtkNmc5UndYdGpPTExnQjNQTUJCWVJSWXpVM1h5UTIz?=
 =?utf-8?B?VmRQbUNrOG9lVCtyVFpjVXJXdFNsOHg2Y3MzS2xuZG9kYzRrSVZCa1puUFpt?=
 =?utf-8?B?ZlovTUt0UUowK2ZmbHBlL3haV0FvZTdBeW5wdXRnQThiSW9oS2JiaG5ZMTdT?=
 =?utf-8?B?b3dPdGxsUDZPT1BSSGpCemJuSHVIYzkrbEVGaTV1aEFvWW5iQXBwUUxrMVY3?=
 =?utf-8?B?MmRtaHprazVKM0dOQjRkWGRIYjdlNC93UzFVMVBWM0FnYmVKMC9RczMrVTd4?=
 =?utf-8?B?VjBvTjJIMUJOcGNhS0h3eHJIZTlhSk5zYmxUdlp5WmJiODQrVlRLd2xNVkRT?=
 =?utf-8?B?a0RtTkphS1A2cEcrTkU5bkNzQmUyQzB1d3ljRWlVeGNPWmRHblJPYjhZcVFG?=
 =?utf-8?B?YTFpZDVCM1UxSmVrRmlDZlJkVDBLN3F2WTFCVkVjeVFwalNwTTlJUUwwSFNz?=
 =?utf-8?B?eDJRMlJ1L1A2ak1PZVpEMDdXYTRmVkw5YnB3RmhZR1JSR2RYRmpLc3YrQmRa?=
 =?utf-8?B?NmJyK0NybmoyTzlIdzdWc0ZhdlhmVlZUM2poVktqZVVmRU1nbEorbDY2eHhh?=
 =?utf-8?B?dXQ1V2x6MUNpNVI0M3BhV0txUWgwTzgwMEw5NllKVHdqVlAzMk9MN2FTcmF2?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A0F261B4DC58846B3E6C38C22181378@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lkH5y4grLDoIbFkoEPXbDR6VQ7WU2kn1MEBGBideYUzVLUro8jW/hbtFMDY35tmO0RKhtC1r18CohALOig4+aUpxYA6/QdXXw0OFKoyytIuGmr5LLkHG3F2t+7Hq/z/UFBdPIRYE9XdRnaAmSskft9HBKdcw+ajMmQ08+VfoOPAsoKD3ylT6tC8Wphx9kDp8BYR132KrLM+0Ot8YImyhdYbP9DXfkCMkpsPzS7WhAYfdSGAiWKuqtPtObTxXW4EsIEZZ/SPcaF+vBy4kCUVQy9m+NfAxu3CVrk0SXMW/9eqC4D3aZgJUUdyRcU03vOzXSIGlswIQ56xyR4nw+zxBBvOdIoaUg1Ej5nq5iALZQZsq31GboM4dkD7FyhhNplpGcN63ac9Z1KejDr59yt1KxaFnd0H5/cWDKPc4+qgH3HKjSVpD/G5X1EDKjb8zfyjS5f0fhtO6WsfEVXANy1Sp9ZPtBaq7+15G5W894dK2qUrnLXVMAU4q80BUeJFMKYbJv6i0fmZFIThF1b2MmfAPij4HX3igGTs9w8Sl9vUFvhrADvxU8+ZnaACA6AewAC8sjXhxczZ3DQ/ESOpOh7qqce6JtkHeOp86QrV5FSAK+HzKua27W6kunmzFKz+qMih6f+PCSzLUNXdVsup6evI8sx9I0dDvzu69gu9og8rIx1ku/pIO8tcFjI2364vY4ewwFSTlcHsxpPJxBpZBX8G3yyt7OmBhbNYGkEsnSAOorNmyPGfo9xuaiMonbF6ngyzjevN4kwZUvEpMe+YAoD+WrTHZtprIcdzHDYL2iACqDu38Xp9OixpmU7Ys3AAv/7IbrIq3gxz+/9ww1bbqijD9Nw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5f0555-4821-4f15-26f4-08db65d6e7f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 15:09:49.1619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ncqHBZrsVV0E0vquz8GKEKOnObgYUFSncnRj8DOyQCfNmIy7+pXDHbpfN2rPE33CxWSjdErczfYY/Y4oiKkjDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7111
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

T24gTW9uLCBKdW4gMDUsIDIwMjMgYXQgMDI6NDM6NDZQTSArMDAwMCwgTmlrbGFzIENhc3NlbCB3
cm90ZToNCg0KKHNuaXApDQoNCj4gSSBhc3N1bWUgdGhhdCB0aGUgcmVncmVzc2lvbiByZXBvcnQg
aXMgcmVsYXRlZCB0byB0aGUgcmV2aWV3IGNvbW1lbnQNCj4gdGhhdCBJIGdhdmUsIGkuZS4gdGhh
dCBhdGFfZHVtcF9zdGF0dXMoKSBpcyBub3cgY2FsbGVkIHVuY29uZGl0aW9uYWxseToNCj4gDQo+
ICAgICAgICAgICVzdGRkZXYgICAgICVjaGFuZ2UgICAgICAgICAlc3RkZGV2DQo+IHBwLnZwcmlu
dGtfZW1pdC5fcHJpbnRrLmF0YV9kdW1wX3N0YXR1cy5hdGFfc2NzaV9xY19jb21wbGV0ZS5hdGFf
cWNfY29tcGxldGVfbXVsdGlwbGUNCj4gICAgICAgMC4wMCAgICAgICAgICAgKzIyLjQgICAgICAg
MjIuNDEgwrEgIDglICBwZXJmLXByb2ZpbGUuY2FsbHRyYWNlLmN5Y2xlcy0NCg0KUGVyaGFwcyB1
bmNvbmRpdGlvbmFsbHkgaXMgbm90IGV4YWN0bHkgdGhlIHJpZ2h0IHdvcmQgaGVyZSwNCmJ1dCBz
aW5jZSB0aGUgcmVndWxhciBjYXNlIGlzIHRoYXQgYSBRQyBkb2VzIG5vdCBoYXZlIGZsYWcNCkFU
QV9RQ0ZMQUdfUVVJRVQgc2V0LCB5b3UgcHJvYmFibHkgdW5kZXJzdG9vZCB3aGF0IEkgbWVhbnQg
OikNCg0KDQpLaW5kIHJlZ2FyZHMsDQpOaWtsYXM=
