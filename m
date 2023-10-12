Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D2BCDB482
	for <linux-ide@archiver.kernel.org>; Thu, 12 Oct 2023 11:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbjJLLID (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 12 Oct 2023 07:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343760AbjJLLIC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 12 Oct 2023 07:08:02 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB0BC0
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2023 04:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697108880; x=1728644880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4jC/x8j6WL1iiG4WRUXtFBLV0KQj4t9h57BBjDkr7mA=;
  b=X5dLYt6XvdVDH+uzSghCo31ZHTMCtcBgesUWsAzEdRvlf4j7jhkccbCC
   msIoEBwFm0YC0PuNUslHGmvNjoECr0C2LGI5x8kF9RO8WzZvI5QmMmL8x
   /3m/jOHdph7BYu1vk1HEgDmMYPchBxeY1Rw1p6MMwp2nRw1Yes0tIF6Bo
   xi02o1n7+ZjNOX1437lmP/lZ32w3k0zLl/gwkWP2vvFW5roGQLyMHNrff
   7mtk/BjmIuK6YOj2uSYxxx7fQI/LjRWc+9JFjLxewGzcGjvv4g4BgcAUq
   TDk9DYJkfo9nTSfbHTzkBGE1ay1xr59F1hPSUGioqK/odHhylJEbRTaRa
   A==;
X-CSE-ConnectionGUID: uP4cjrpOTFuBxtOtiwBBQw==
X-CSE-MsgGUID: BgOE5BHdR7mhIRObkEGG1A==
X-IronPort-AV: E=Sophos;i="6.03,218,1694707200"; 
   d="scan'208";a="250831034"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2023 19:08:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj4tWnWBBwnuOJP8qdMXqvCKMoRnluPvixA3X14ZvKCJhRnq9btC8AC7Xo12wQ6EYZhgWY1fnK01CNBjc1JaeJ0nX8COg0hRt1YSTqMnuvK+dryf6ZTjY1Qn4abnPQ1FttmL2s3P30xl6TbDFzW7V2u0b/30Zzc1CL0lIA5rTsLnhwv0JWDyPKE3xiXZ1ev7GUmYeSxvRU28tNXDpyq8pFO3XUsczxYzBAWXrwiEPLvQZkakmkWITQtq3L7Pzv+W8/oROwXSVLz9ocGFYWLiidnKPmUzZLEWgf8e4nwUq3K3psra+eRbI2N+VaPrpxr0J47/m1UeE7kcZ2n40oUNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jC/x8j6WL1iiG4WRUXtFBLV0KQj4t9h57BBjDkr7mA=;
 b=XN2Mafnfmun+Zr2zedGA3Q/vV+/mArZ4awSYMqdxvQgSNkJvuVabGgHWro+aEPHwmhFNlAxayZmQN3IPFKUTIDXB1TBohH03iMnxtNjueZIZWH9MvFcPMtUz9EYhD62+5wBtEHSvviEAPzMh6oyOz8bHIKyfG5vPgiAcLQaXDSou+mO1RwsnZNSDvYm+9m0iVxVCabCHTXVBrMVKkMPHXBExzn4+F7kQGhTiZt4MH9C1Ug5hmRrNh/vf0MIY21AYpeYzFvoHRnkwcdGsyNwGVaACvsZVMwSYJ60a9pCr6OJNGrvmoIP3jkAKcLHSFDfTEBaQgyGUphXO5QLbsU41ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jC/x8j6WL1iiG4WRUXtFBLV0KQj4t9h57BBjDkr7mA=;
 b=J2Bqy1TbZXG4sEKtkcFxipAhJkni4y1qqTcT2LaLrPOknKJbL1cUqwALXEIGQ+EOyXuIvpeDO83XhYg64v02eUYhiKHvSH+HFKs3/yj0YSywWYie++kJCq82h2MY+eDd9s+Oo4ZLafcC9EJTBBjRPQ+Ffx0hA2j8RT+CnfT7ItE=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6770.namprd04.prod.outlook.com (2603:10b6:a03:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Thu, 12 Oct
 2023 11:07:57 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6886.028; Thu, 12 Oct 2023
 11:07:57 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Phillip Susi <phill@thesusis.net>
Subject: Re: [PATCH 2/2] ata: libata-core: Improve ata_dev_power_set_active()
Thread-Topic: [PATCH 2/2] ata: libata-core: Improve ata_dev_power_set_active()
Thread-Index: AQHZ/PxaMqyVrEl6cE6PkRoc44TCeQ==
Date:   Thu, 12 Oct 2023 11:07:57 +0000
Message-ID: <ZSfTjEBKb3t2HS7f@x1-carbon>
References: <20231012071800.468868-1-dlemoal@kernel.org>
 <20231012071800.468868-3-dlemoal@kernel.org>
In-Reply-To: <20231012071800.468868-3-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6770:EE_
x-ms-office365-filtering-correlation-id: 1e14fef6-5346-458c-17bb-08dbcb137d9d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aOAXbivZ/mwB1B04j6APfLQOEX5XEnpykw2xr0iEJBbE658b/HOJ8EHmPkQc8OvPmryOhQndLKNLcP+9+pk1TIk4HTOg34Q3+BictZAmhDHTHeMXCTTcHqphzPUT2wm2KneXwrtRns8m20ke2pQcy6JvGcybn/5zV3av1jHjRXGi0E8PLopG8OiqjtITNHSsNEgLGHHTSoiYGnouLZgoKyLseMHsBV3uwjLXaN5GjIQCQ+wcByuGtKcpcqEW7NgjI/fsA+kdq+78R1uhnn7kp6jzeV7hF7yyNOMlegbZR7EUWb16Ii8wqjLl1O4hF95sw/rR5LWZD0mgEAxTApP4nZBfKAUWwkeZU064hzxlNfstSDwy9oxOXrS4Iw2GwmH/4jO6ic1RkDahvHEnjx2udIpCxngitUBd80g4CB5fmIhxzNCJOFKu7kfSaQshBL0pHoedexx/6cCxQ4dzgxKeCfMnxcR0riG8aS6vxkPBHHRlTGrM7hlpsQpdH3NsnC2IeW4QLBpm9TKY45/QEAUiIaK5eB6DYpqIR2H8HvBwFDTpLP3HNkhz3LeipUgW41ms42BdDk64HIguA5V/DctbnGduavqPggYJDHavTwT+VdaUZW9oY9fx3otr8Axlxyfb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6506007)(5660300002)(86362001)(2906002)(83380400001)(41300700001)(8676002)(8936002)(122000001)(4326008)(91956017)(478600001)(54906003)(66476007)(6486002)(66556008)(64756008)(66946007)(66446008)(6916009)(6512007)(26005)(316002)(71200400001)(9686003)(33716001)(38070700005)(82960400001)(38100700002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTkwVmEwdWNsVGhWVWdCdGNQV1ZIWlNIV0ZNdUYzUmxYQkJkMU5Ya3lBeFhE?=
 =?utf-8?B?cllLRTJTTXNMRE04cUVmakVEa0pZK3ZicmFXcXlWczZnNGNyVnJGYXJGRU5H?=
 =?utf-8?B?WmsrcjZBLzF2NldFNFhVUkgxL0RUdllvZlYxWVkrVXFrclFKaHFIdC9Jbk83?=
 =?utf-8?B?bTJJcW84L1p6UTVLc05FM05kYkxnSVhWVmh1cUhQSnQ5Uk53MTdoMnlwQXBo?=
 =?utf-8?B?RW5HSGI2eGFPdlkvdzFCNlY4cGhiZ2RSbUEwTDZodVg2OHBqTDJxRDkxWTJu?=
 =?utf-8?B?Vm9kMmpmUUhRMWpLWGc4WWFiWXpzVW11blh6Ti9RYm5wbmFrcWFwQUVVeWZn?=
 =?utf-8?B?bmdrY0g4NlFuSVJJTEpONCtTelUvbkFYbjhjZlJ6OG1zWnV6KzBSK0dEVHFy?=
 =?utf-8?B?YXg4aG1hS0RDNTN2VDYxMzkvNnlOSWJOSVJPb3BtYWt6OGRYQ3dRaTdqM0t2?=
 =?utf-8?B?ZGMzN0g5M2IvcEFsREZKQUFTWmVTUDFabThZQjdNdXd2L2JKaWtUSlYxdXQ4?=
 =?utf-8?B?VDZvc09SaWdURXBCRDN5dzc1bDBvM1VmUi9KM09nRzA1OW1MMU1wb2dzcnZu?=
 =?utf-8?B?QldORStVVmVaUVliWVNORVZWNkE1UW1ZM3ZpYWl2cFczcWU1VEc2UzlqbTFR?=
 =?utf-8?B?aS9zenF1YXh4RGZZVHJvK1d3QU9tT09wUDh1eEdXSXZtUklMTm1xdjFNUThZ?=
 =?utf-8?B?ZEc2Q2R5aVRhQ2l4ZEtuaHFIN3VHbFpSWHBXakdRaU90YnUvbk9NYy9ZemV5?=
 =?utf-8?B?UE5jUUVMKzZmMU1kMHF4V3E5ZHczWHdEV21nanlmODNwV3o1SHZMTk5McTZN?=
 =?utf-8?B?anVmTHcrRUlhY3dwUFN6WEJrdmo1WTFwZmpsN0xObFFBY2czb09Oa1QxNjJG?=
 =?utf-8?B?OEk3SnRhbUk0cDRkaTJYZUExTUtKY1hIdUxZaXJIUldoemVPMmZLa2c0NFlt?=
 =?utf-8?B?N2tRT3ovWVJlRkdzR3NmSTEvNGo4ZlpKZ1NpazZmeGR1dS9LWnpJOWlINnor?=
 =?utf-8?B?ejBDQ0RXclRxcElrMk01NG1sYm5wc3d3WU4xTkErRzlnWm5MUCszc3F5MGtZ?=
 =?utf-8?B?aS8ra2xzbEZuQ3ZUT21OdFNZK1JxbXR3TktqOWd5MVUvTWhlM0xCN2x2YVlF?=
 =?utf-8?B?UmlmNnppck84NGFjMG11WGMxemY4QnlxczNiajRBbGkxdDZlbEFRL2V6S3JN?=
 =?utf-8?B?TFM5TDJnTW9IdzFwV3N1UDlzMEJzQnVmZ1NnZVpXSlZtTGJnaGJGeitPWGNk?=
 =?utf-8?B?dE5yWFZ6WlJ2NGg1ZitrbzN6N21SQW9xVDR4emlWUXA4MmF4cjBuRzNNRkNq?=
 =?utf-8?B?bUo3a0dReUJPNXo5R08rRGk1OGZuNzJIaktJTHJRN05TNUM1M1VzWUkydDJa?=
 =?utf-8?B?TEdEczhpY1doMVU4azZ6SW5rR3JrY3hMUFBCUUNWQnFQQTQ1V0FScy9vNENt?=
 =?utf-8?B?YlQxeVovTzE4aVlmMFp3NlppRUNETk13aE9RbVlnNjVHZHJXZ2RUTzJFTksr?=
 =?utf-8?B?M3NTUHdvYXk0UVZ6N3diTzdhNkg3MDUwSXZycFpDbTd3WEljY3dCVUhGdXJ2?=
 =?utf-8?B?L3hxTzE4Wm5vMWlua3UvcEppZmFaMC9qMjhSekJoUDBCVGJReTVySU5NNVJ5?=
 =?utf-8?B?dm0xc2hFemVvV24xVGNEMEh0eEhhay82ZGdUbTM2d3hENzB3M0hJSjQ0U3Jo?=
 =?utf-8?B?Tk15TGZJbUVlcVE3VWt2NGdJL0h2USt4R1JhV2hYNjZLdTNGZ1BMRHIzT3hF?=
 =?utf-8?B?WTUyakF2SE1Bb3BHUXdKZGV4b1p3L1VFdC9DN0tnS1JOYzFtYSs4ZExNY01T?=
 =?utf-8?B?VFVvQTBwRUVTRWRJMWFtTGJONzFlNEY5RW9uZ3ltUE1Gd3QvMlZtS1MvS25G?=
 =?utf-8?B?YUxTeTI3TUxGUk1uYjlEamE4NjNZY3V0UEIvNGxsQW12ZnczQk11bWo2eE5U?=
 =?utf-8?B?ZEtmTWRYOWlGeENnU0V4RUE0dUpoaE40VTBXVkNGdG9RSHBWMGk1VXJxc1p2?=
 =?utf-8?B?MDZsTXpmNFlkWGxuQ1ZDWGlOejRBOVYyODNlSUtzUG9hN1I5VlRCMnQyazVw?=
 =?utf-8?B?WkhsNDhad0lkbWJoWnhydUE3UHA0d01oMTdETFc1M09aeEtlVlk1YjFMRjhm?=
 =?utf-8?B?enhsRms2NWRaMDRvbUV1MzBIMHF1cUlPUlFuUkl4bVBPc3RCWUQxUTBYVDM0?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55EF280435D16A45ABAB0ABF07FBBFA4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wcXPM8uWlw3+XLJftR6iCqvhmkGemGg0QHeyGdz5OtG69FfCD83A123iHey0oJmLejEHmY8+xhcQR3Wrz2vdYBD5kIyB8eWVlyDeA+rUwoHa+hP2EXSC1UblOL3zVXYAwzohXFQf1hsDSETQj8iVgVHYaCjYRsmveLtHygpLlQTZ+XNBroKL/jOwJaHaDwXYHSrajfkq7xXY60briA8u6UudqUL6bY3IlZbbh21yvBwXhuyR6EnYVQgvj1BSjPwy8zu1k1rhW6G8kvKTHMAKCwXm5a8TeCm26Z8o4Sv0X+d6LoY1JjQF4HSkxP65VN78zVV7hmQlWwaOZuCwFsmncVlKmZUzuCGPH3vTUdKKvhbFCzn0yNuiMR8UkYvckH9iKUZK3LBSivVlWaDBd+h2oOWRMIrLLLSxzYDd0Yc52N/kUfYMThdcfkIOkIgae47duhWMuC/MPYX6620R4ERnx4Ku4cVha9V7KH1h/oi15gLzyXxDqj7440FJsZbySq47OaI8Rjux7cVoohK5oWScjFCN7r6WyGh6g/+4X/sjTMscHexl6Y1fR323JDY56X8WfAylH3NlLEOONKGcVi1LWbMnDaYhfsWSrNqoTD6NN3TkJ+6b7KHtNSHS88nXftCIzX5dR+DaGnNc/oSh7qbKZ5ortv7JWS/zfFfbONTEvtwCNDZKE8LuXKurb5r7UStDOw+qLokCKbQJUEL+Fz9HerHy0CR+qAVImEvWiAWVHTUeadxiZV3yMMNfYrQgfXhcNVaLOt9GgL0HDBAi6MeFazotvXHnmSr0aV6jO4WVzwMf0Arrj65caMUHoH4/ZhXzCBDeVykxqo3US76dHymS/E7JBIrucy6dsPJ4HpvJLvEB58euOJTMYxdXK11zMAzjXJ99WoH8Nt1n9j3H9McNpg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e14fef6-5346-458c-17bb-08dbcb137d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 11:07:57.4820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UA8KomLbPBI1pJcDU27G2L6ax7eCYtOysBilkciGJy/xYcqSTWBw3xuoF5IOXcaYUSR2iScEq+0652McTXTUGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6770
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

T24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgMDQ6MTg6MDBQTSArMDkwMCwgRGFtaWVuIExlIE1vYWwg
d3JvdGU6DQo+IEltcHJvdmUgdGhlIGZ1bmN0aW9uIGF0YV9kZXZfcG93ZXJfc2V0X2FjdGl2ZSgp
IGJ5IGhhdmluZyBpdCBkbyBub3RoaW5nDQo+IGZvciBhIGRpc2sgdGhhdCBpcyBhbHJlYWR5IGlu
IHRoZSBhY3RpdmUgcG93ZXIgc3RhdGUuIFRvIGRvIHRoYXQsDQo+IGludHJvZHVjZSB0aGUgZnVu
Y3Rpb24gYXRhX2Rldl9wb3dlcl9pc19hY3RpdmUoKSB0byB0ZXN0IHRoZSBjdXJyZW50DQo+IHBv
d2VyIHN0YXRlIG9mIHRoZSBkaXNrIGFuZCByZXR1cm4gdHJ1ZSBpZiB0aGUgZGlzayBpcyBpbiB0
aGUgUE0wOg0KPiBhY3RpdmUgb3IgUE0xOiBpZGxlIHN0YXRlICgweGZmIHZhbHVlIGZvciB0aGUg
Y291bnQgZmllbGQgb2YgdGhlIENIRUNLDQo+IFBPV0VSIE1PREUgY29tbWFuZCBvdXRwdXQpLg0K
PiANCj4gVG8gcHJlc2VydmUgdGhlIGV4aXN0aW5nIGJlaGF2aW9yLCBpZiB0aGUgQ0hFQ0sgUE9X
RVIgTU9ERSBjb21tYW5kDQo+IGlzc3VlZCBpbiBhdGFfZGV2X3Bvd2VyX2lzX2FjdGl2ZSgpIGZh
aWxzLCB0aGUgZHJpdmUgaXMgYXNzdW1lZCB0byBiZSBpbg0KPiBzdGFuZGJ5IG1vZGUgYW5kIGZh
bHNlIGlzIHJldHVybmVkLg0KPiANCj4gV2l0aCB0aGlzIGNoYW5nZSwgaXNzdWluZyB0aGUgVkVS
SUZZIGNvbW1hbmQgdG8gYWNjZXNzIHRoZSBkaXNrIG1lZGlhIHRvDQo+IHNwaW4gaXQgdXAgYmVj
b21lcyB1bm5lY2Vzc2FyeSBtb3N0IG9mIHRoZSB0aW1lIGR1cmluZyBzeXN0ZW0gcmVzdW1lIGFz
DQo+IHRoZSBwb3J0IHJlc2V0IGRvbmUgYnkgbGliYXRhLWVoIG9uIHJlc3VtZSBvZnRlbiByZXN1
bHQgaW4gdGhlIGRyaXZlIHRvDQo+IHNwaW4tdXAgKHRoaXMgYmVoYXZpb3IgaXMgbm90IGNsZWFy
bHkgZGVmaW5lZCBieSB0aGUgQUNTIHNwZWNpZmljYXRpb25zDQo+IGFuZCBtYXkgdGh1cyB2YXJ5
IGJldHdlZW4gZGlzayBtb2RlbHMpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFtaWVuIExlIE1v
YWwgPGRsZW1vYWxAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL2F0YS9saWJhdGEtY29y
ZS5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDM0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2F0YS9s
aWJhdGEtY29yZS5jIGIvZHJpdmVycy9hdGEvbGliYXRhLWNvcmUuYw0KPiBpbmRleCA4MzYxMzI4
MDkyOGIuLjZmYjRlOGRjOGMzYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9hdGEvbGliYXRhLWNv
cmUuYw0KPiArKysgYi9kcml2ZXJzL2F0YS9saWJhdGEtY29yZS5jDQo+IEBAIC0yMDQyLDYgKzIw
NDIsMzMgQEAgdm9pZCBhdGFfZGV2X3Bvd2VyX3NldF9zdGFuZGJ5KHN0cnVjdCBhdGFfZGV2aWNl
ICpkZXYpDQo+ICAJCQkgICAgZXJyX21hc2spOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgYm9vbCBh
dGFfZGV2X3Bvd2VyX2lzX2FjdGl2ZShzdHJ1Y3QgYXRhX2RldmljZSAqZGV2KQ0KPiArew0KPiAr
CXN0cnVjdCBhdGFfdGFza2ZpbGUgdGY7DQo+ICsJdW5zaWduZWQgaW50IGVycl9tYXNrOw0KPiAr
DQo+ICsJYXRhX3RmX2luaXQoZGV2LCAmdGYpOw0KPiArCXRmLmZsYWdzIHw9IEFUQV9URkxBR19E
RVZJQ0UgfCBBVEFfVEZMQUdfSVNBRERSOw0KPiArCXRmLnByb3RvY29sID0gQVRBX1BST1RfTk9E
QVRBOw0KPiArCXRmLmNvbW1hbmQgPSBBVEFfQ01EX0NIS19QT1dFUjsNCj4gKw0KPiArCWVycl9t
YXNrID0gYXRhX2V4ZWNfaW50ZXJuYWwoZGV2LCAmdGYsIE5VTEwsIERNQV9OT05FLCBOVUxMLCAw
LCAwKTsNCj4gKwlpZiAoZXJyX21hc2spIHsNCj4gKwkJYXRhX2Rldl9lcnIoZGV2LCAiQ2hlY2sg
cG93ZXIgbW9kZSBmYWlsZWQgKGVycl9tYXNrPTB4JXgpXG4iLA0KPiArCQkJICAgIGVycl9tYXNr
KTsNCj4gKwkJLyoNCj4gKwkJICogQXNzdW1lIHdlIGFyZSBpbiBzdGFuZGJ5IG1vZGUgc28gdGhh
dCB3ZSBhbHdheXMgZm9yY2UgYQ0KPiArCQkgKiBzcGludXAgaW4gYXRhX2Rldl9wb3dlcl9zZXRf
YWN0aXZlKCkuDQo+ICsJCSAqLw0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsJfQ0KPiArDQo+ICsJ
YXRhX2Rldl9kYmcoZGV2LCAiUG93ZXIgbW9kZTogMHglMDJ4XG4iLCB0Zi5uc2VjdCk7DQo+ICsN
Cj4gKwkvKiBBY3RpdmUgb3IgaWRsZSAqLw0KPiArCXJldHVybiB0Zi5uc2VjdCA9PSAweGZmOw0K
PiArfQ0KPiArDQo+ICAvKioNCj4gICAqCWF0YV9kZXZfcG93ZXJfc2V0X2FjdGl2ZSAtICBTZXQg
YSBkZXZpY2UgcG93ZXIgbW9kZSB0byBhY3RpdmUNCj4gICAqCUBkZXY6IHRhcmdldCBkZXZpY2UN
Cj4gQEAgLTIwNjUsNiArMjA5MiwxMyBAQCB2b2lkIGF0YV9kZXZfcG93ZXJfc2V0X2FjdGl2ZShz
dHJ1Y3QgYXRhX2RldmljZSAqZGV2KQ0KPiAgCWlmICghYXRhX2Rldl9wb3dlcl9pbml0X3RmKGRl
diwgJnRmLCB0cnVlKSkNCj4gIAkJcmV0dXJuOw0KPiAgDQo+ICsJLyoNCj4gKwkgKiBDaGVjayB0
aGUgZGV2aWNlIHBvd2VyIHN0YXRlICYgY29uZGl0aW9uIGFuZCBmb3JjZSBhIHNwaW51cCB3aXRo
DQo+ICsJICogVkVSSUZZIGNvbW1hbmQgb25seSBpZiB0aGUgZHJpdmUgaXMgbm90IGFscmVhZHkg
QUNUSVZFIG9yIElETEUuDQo+ICsJICovDQo+ICsJaWYgKGF0YV9kZXZfcG93ZXJfaXNfYWN0aXZl
KGRldikpDQo+ICsJCXJldHVybjsNCj4gKw0KPiAgCWF0YV9kZXZfbm90aWNlKGRldiwgIkVudGVy
aW5nIGFjdGl2ZSBwb3dlciBtb2RlXG4iKTsNCj4gIA0KPiAgCWVycl9tYXNrID0gYXRhX2V4ZWNf
aW50ZXJuYWwoZGV2LCAmdGYsIE5VTEwsIERNQV9OT05FLCBOVUxMLCAwLCAwKTsNCj4gLS0gDQo+
IDIuNDEuMA0KPiANCg0KSGVsbG8gRGFtaWVuLA0KDQpGb3IgYSBkaXNrIHRoYXQgaXMgYWxyZWFk
eSBzcHVuIHVwLCBpcyBhIFJFQUQgVkVSSUZZIFNFQ1RPUihTKSDigJMgNDBoIGNvbW1hbmQNCndp
dGggTEJBID09IDAsIE5TRUNUT1JTID09IDEsIHJlYWxseSB0aGF0IG11Y2ggc2xvd2VyIHRoYW4g
YSBBVEFfQ01EX0NIS19QT1dFUg0KY29tbWFuZD8NCg0KDQpLaW5kIHJlZ2FyZHMsDQpOaWtsYXM=
