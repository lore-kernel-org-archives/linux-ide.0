Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F7CC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 00:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbiCXA1a (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 20:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbiCXA13 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 20:27:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA0A7CB0E
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 17:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AibQX4rxdacdv+0EnSlbHuz7dqfe+4iAsLWIZP226TA3+mwWXteS+e9DjHPeqIWaT9so2TfXrv9IuDqqKMH9gQ3E9mCHeUquvFE+5u37kJo5yGD7NeVWwkjuQKGbrBf4emX3f9FHG9T71E4qRA42kOFc9V3QG01JD2fQ9LSUisIZgZ/oSRB6xjpdulOyWtr1Q3BV41cXyvN0YsoSXEPjalrKVH1wKzB8GVsF0FH4EP2UnCtOAy1TU+EaTrDD1ROxXEoTu2rhO3/oLs7y71vLFHDWjkyNTxMpRCgjTB1pAx9M9qRWc/3LzepLk7L7dW6dAR6cg3JhC78FFAkv6vRcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=097lSZekIFSWTEwIIpltqIn8I8wU/FWY9ssrbIoC2dc=;
 b=lpPa8J0scz9zpMFTw412g62deQKDiURRyHcUCd3kSVwK6a+cmssgWi2stoyLVRPawN5nd3lQoqQKm4kv3sQxyJpXixK38jccyBg8CmzmNfcm9kzuxCS1PDYYHdhNkFJ+VsP2FykXZMGswkebwa5e1PvbsgRn/CoAEv/tJ/H86uK/o4mmGA8JV3xlxCZxz3goCvZ9e7cXqEBMb2Hh7cyQr6W0cWMsixfb8qMBpNJ10A5J/Z88QqOP3rlSAiPhx39frxhKX9GrhPeepArgKCMIgEnegRVWKug6+aOCxFA/LCV9YiXjh6uCXgwx3AXHZ6Zvh3NJfF7T+CwgDjSt90obmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=097lSZekIFSWTEwIIpltqIn8I8wU/FWY9ssrbIoC2dc=;
 b=5jVVjoiPfj8XYaJmH2UCXPUnx46TvxTZl46PoTcy9UtHFaMzwNlVScnPsyt1Odr8FQVbem6ed9/vRKC8lhBvlsWA86jfKZ4E8Bcl8kldaMACXc2oQz4Wud+D7n/YM6sZbIw8aN3I8r9a8DqmZ6spygIC9PfyxMyPlAHaa31bBMk=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 00:25:54 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 00:25:54 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: RE: [GIT PULL] ata changes for 5.18-rc1
Thread-Topic: [GIT PULL] ata changes for 5.18-rc1
Thread-Index: AQHYPwLVdjWJGZbYOkCcbPPdLLNBP6zNlW0ggAAM1ACAAAayIA==
Date:   Thu, 24 Mar 2022 00:25:53 +0000
Message-ID: <BL1PR12MB5157C72DE3005CF0C6C6D9BEE2199@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wgCt46XN2xuQO3Zj2UoeP472EpyWbrjsDPVZvDHW+rA2g@mail.gmail.com>
 <BL1PR12MB51576EE0517167FDC471AE8EE2189@BL1PR12MB5157.namprd12.prod.outlook.com>
 <4459a2ff-0852-d8fb-a2e8-307d651f728c@opensource.wdc.com>
In-Reply-To: <4459a2ff-0852-d8fb-a2e8-307d651f728c@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-24T00:09:59Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=51dfac2d-e0cd-4b2f-89f7-53b16a1ae04f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-24T00:25:47Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a4c47def-fb86-4047-884d-73abb543863a
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e676905-52f8-43f9-f530-08da0d2cdba3
x-ms-traffictypediagnostic: BY5PR12MB5016:EE_
x-microsoft-antispam-prvs: <BY5PR12MB50166775DF5DBE3B6F37BEFEE2199@BY5PR12MB5016.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x8g55mZGR5D2LpYYqkTlgqUA1HZQZUSFr28YRtIojTHx4JtpwtTVPChAPH/11ADo+gS7FH7SmivWs77lwy4GoX43NOZcU9rxzYHDCKH/nr5NdlQuatqsAMbZU7iYAU+9rDSiGzh9Rw/AIGG2iMIC6HNmktPhcToFR0ixuM3e+PVx9ye8AJo8fJ7uBkWi4+mzTcnr/TkYAJUpsjOFRcJSJLsbZZr0BRGUA1paeoHl8u/p4SGsS+q+RRpCUlFyPapo1zkQWYg0fvg1UgcmmUNADRpyC09j59vy5YDQq5iEOoUNvnR81m9cKsw0YE4VMOsBfbeRQC/ALMsDgMI54VrpIzwgO5l/fthwiqQY4r7WG7+5G4VapqXpr7nWXZO9k4aPl1RR6Rr9lq1UODFowy/XyleRapCPvgS9R0LoWdzqKsxubnkexhY04sVKMeWneKESvWcG5mMIH6OostIeWhN+f7bMFvbNSv7v7Iii0jA+G2A2iYV5CAvE3XUeyCt/VFuGwKKNxKhznOVXrUORR8ytnxVwECtMrMFe/s0tTCcd9saASoQtBlNGeoZZHf5ojoaK87F9QakcyO6OIBWMCQ0cXA01vqwE+jubNMW/t1dakNwrzlJ0SuC3AWLo5sDD+WwLXPfbV8r/S/x0MJK4jC+hq3hxqXyZbvuqEUqF9ULl5pWuQmGBGBZH683AZfn6qW+bWeSJRv3kkFnmlbrrTT7CrwOKBpyiHRSoGmkNYHMRWXHRV6q4dEeyF0N6qYlGar0FpLX6ethfDVteSuXp71O63UHjI0EeW/p0m0dHY3M16L1/DrhteyrbcyOxi8KNgXeIfhQQwZI7KSuw9SsYTGjnIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(52536014)(38100700002)(83380400001)(508600001)(55016003)(8936002)(38070700005)(5660300002)(76116006)(966005)(122000001)(186003)(4326008)(316002)(66556008)(110136005)(66476007)(66946007)(66446008)(64756008)(71200400001)(9686003)(53546011)(6506007)(7696005)(33656002)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y01RU1lpK1VnWStLbDU1MEpkdmZTa0NVTFF5TldHVjZWcy80a1pKdWllYXlE?=
 =?utf-8?B?RHhIWkdEa0xuQVJGR2RQWFlYNmNMamhYSDd3OEw1V0tnTkZvTzAyRzlmYk9V?=
 =?utf-8?B?VnQwZlR4MHNuNHJSUVJXMmV6cDJxY214aVFWUmZWdUVvZGNSQVROU3JZeUUx?=
 =?utf-8?B?bmZ6dDllQTU5aHJHdTZ3YkpRV0pJcndKR2dRcE05Ly9lU1RDbFNPKzY4ZHI0?=
 =?utf-8?B?TUV6dkUvcSs0ODJycEc3NE1lTWdIS1NZd2RzZ3VtWE5OT00xT0hUUjZab2RE?=
 =?utf-8?B?Rjh1dmJQaFNTT1NKdlJtUzhCQjBPOERxRVJjNjRiakFzTjhTWVJ4NFlSMmI4?=
 =?utf-8?B?c29vZ0xsS09oeWc1bGtRTGw0TWRUSElvYXZoTmlzeXdvVnowTFhnVXZDYXdp?=
 =?utf-8?B?VUVNTUxjdUd3c0Fsa1hXN0xYaVVvQndSUWdrbVIvSzdROEFBWnQyQXpKUXV5?=
 =?utf-8?B?dnBVZlZmeHF4eVNkYXRGeDhJOVhJVkdLUnFWK1B0N0xCWGhOSEh1amxRSTJ1?=
 =?utf-8?B?b0ZLODhHeVQ0OFpXZXFTYVZTWW16R0RMWThIQW9WMHlQaGdMOS9RV3hnQmJm?=
 =?utf-8?B?TGVrK3MrdkZudmNLRitMVzFtQ3pyb2JiR0FuVzB0Y0Y3SnhCSWVxZTRMSE9E?=
 =?utf-8?B?WEhCaG1zSlVtWDlVaUIyNGtqNEFITkxkMGZYRlZRL3YzamZRbGM2T3dsRFZ2?=
 =?utf-8?B?ck5DZWRTU3U5ZzVHUmZURkRCN3NpQ0NhTGtNK3RYcTVUNFBCNkd5ZTRTT1hz?=
 =?utf-8?B?YkJrK0pMcDZVbTgzZllhOXdPZzBuSG1qd2NqV3A3T3FQL2NlQ1YzYnFGRWZS?=
 =?utf-8?B?V21ONUpsV0VXMFpuN0xvdzlONHMzUVZKWHVKYUFzRCtGK1c3QkU1QUhIWkxr?=
 =?utf-8?B?ZFBXbTlaZFdlVEQzdmdQOXpSUmx0bXpweU1OQXNxcGdNRjFSbW1jZEloQXpR?=
 =?utf-8?B?MDBFQ2JaM0krVDB4SnFvNXBBMzFWbTV6SnpFKzBtY0d3ZlprY0RtN3czR0xQ?=
 =?utf-8?B?TU5XOGdzaHVuQzhLbGlOY3ZoeVlYT251SitWZ3JrNGdhRlQ1Y2lZaXdHZ056?=
 =?utf-8?B?WHZTM1lmaHBBZ1JhME9YeHFqMFE0ZzYwS2lKQll1ZmlhNEJhdVVQVWQ5bkpP?=
 =?utf-8?B?eS94aGZ6RXZEL3NWdVVVQnh1dHE3cTNON0ZPcUFUWUVoYnFXa2tlOTdOc0th?=
 =?utf-8?B?VHArOEg2aEFzNFhqTmlhaXI0RWIxcFFneVFpMW16KzRlZ3NmMTZrbjdiYndS?=
 =?utf-8?B?dzJtOG1tYVRUZFFGYTFiazdsR3ljeHBlNGsxaUVQZkJvRnVIRzNhNldhMHpt?=
 =?utf-8?B?U1NSN2xnYzlSazJ3MDdJeUJSRVI1OGVic09GeitaQndtSVFhdVdxMGVPYTFj?=
 =?utf-8?B?UDN5N1BwQytITTlkeGVpZGhoeTU4QWFvd3Z1bnpndFRBNmhuTzAwT0NnTEwr?=
 =?utf-8?B?NlN6YXVNQUVTZjg2eTJ6bHRIb21ZeUg2NjNlWUpyRDVoS2NtNnVNSEp5bHlw?=
 =?utf-8?B?MURpQ3hmVHZsdGpyaTJTYVUxU1VQVFNGY3BLVVcyMzlhTlVUWGNGKzM4UWFk?=
 =?utf-8?B?bHB2dlFrV2FOaXBoYmdHc1Y4T0VZY3lTSHlrQ1Brdi9oc2tCdUY1TGtPTitN?=
 =?utf-8?B?VGQyUXAzeUlGMEtNMk1OTmNLVExKZUhTZFE4cnhDcWgxNWM2THdaNGVLUUZS?=
 =?utf-8?B?NHJ1NlZQQXZic1E1TlpBWlJrWDQ4YzdMaFdHSk5WQTZaOWNmTmdxdTMxV3N4?=
 =?utf-8?B?b2xxcm9YTEU5Z1NoNm9oL1htci9uTmdLTXM1WisyWFViMkpTMHpUWjcyVnFl?=
 =?utf-8?B?ZHBWT1h3eUcrQWRkRlVDdGwvM2NMK09wc21yakJxZVUrQTU2OG51MHpsOXRo?=
 =?utf-8?B?eUFjVTU5WjFKbmlSZHhYQ2hxZTdKQjArbjI2T1dLVlZtRzZOWlZOREN0dGJV?=
 =?utf-8?B?RU94S0YyUkIvakF0bk91Z2lVZEpoeGdmKzc5b2l4VkQ5dG9mMSszOUxFVzVq?=
 =?utf-8?B?amN3aU5rZG9IUW84NHNQRWNNV282LzVyRkdTNGJ4MGZXdk56ZjNTZU55QjJD?=
 =?utf-8?Q?vxGxnj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e676905-52f8-43f9-f530-08da0d2cdba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 00:25:53.9462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pwlTIDi+XSXl4K8L4HPMdw9kljC0lwwK1b42ye1bRD6FsIAwh2/YAot8J8kVLokAwzjk81fOyJdKCv/1Bfowg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

W1B1YmxpY10NCg0KPiBPbiAzLzI0LzIyIDA4OjA0LCBMaW1vbmNpZWxsbywgTWFyaW8gd3JvdGU6
DQo+ID4gW1B1YmxpY10NCj4gPg0KPiA+PiBPbiBNb24sIE1hciAyMSwgMjAyMiBhdCAxMTo1NyBQ
TSBEYW1pZW4gTGUgTW9hbA0KPiA+PiA8ZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5jb20+
IHdyb3RlOg0KPiA+Pj4NCj4gPj4+ICogUmVuYW1lIGFoY2lfYm9hcmRfbW9iaWxlIHRvIGJvYXJk
X2FoY2lfbG93X3Bvd2VyIHRvIGJlIG1vcmUNCj4gPj4gZGVzY3JpcHRpdmUNCj4gPj4+ICAgb2Yg
dGhlIGZlYXR1cmUgYXMgdGhhdCBpcyBhbHNvIHVzZWQgb24gUEMgYW5kIHNlcnZlciBBSENJIGFk
YXB0ZXJzLA0KPiA+Pj4gICBmcm9tIE1hcmlvLg0KPiA+Pj4NCj4gPj4+IE1hcmlvIExpbW9uY2ll
bGxvICgzKToNCj4gPj4+ICAgICAgIGF0YTogYWhjaTogUmVuYW1lIGJvYXJkX2FoY2lfbW9iaWxl
DQo+ID4+PiAgICAgICBhdGE6IGFoY2k6IFJlbmFtZSBgQUhDSV9IRkxBR19JU19NT0JJTEVgDQo+
ID4+PiAgICAgICBhdGE6IGFoY2k6IFJlbmFtZSBDT05GSUdfU0FUQV9MUE1fTU9CSUxFX1BPTElD
WSBjb25maWd1cmF0aW9uDQo+IGl0ZW0NCj4gPj4NCj4gPj4gU28gSSd2ZSBwdWxsZWQgdGhpcywg
YnV0IGl0J3Mgd29ydGggbm90aW5nIHRoYXQgcGFydGljdWxhcmx5IHJlbmFtaW5nDQo+ID4+IHRo
YXQgQ09ORklHIG9wdGlvbiB3YXMgcHJvYmFibHkgbm90IGEgZ29vZCBpZGVhLg0KPiA+Pg0KPiA+
PiBXaHk/DQo+ID4+DQo+ID4+IEJlY2F1c2UgaXQgbWVhbnMgdGhhdCBwZW9wbGUgc2lsZW50bHkg
bG9zZSB0aGVpciBvbGQgdmFsdWVzLiBBbmQgaXQgaGFzIHRoYXQNCj4gPj4NCj4gPj4gICAgICAg
ICByYW5nZSAwIDQNCj4gPj4gICAgICAgICBkZWZhdWx0IDANCj4gPj4NCj4gPj4gd2l0aCA0IGJl
aW5nIGV4cGxpY2l0bHkgbWFya2VkIGFzIHZlcnkgZGFuZ2Vyb3VzIC0gYnV0IGF0IGxlYXN0IEZl
ZG9yYQ0KPiA+PiBzZWVtcyB0byBhY3R1YWxseSBoYXZlIGEgZGVmYXVsdCBvZiAzIGluIHRoZWly
IGtlcm5lbHM6DQo+ID4+DQo+ID4+ICAgL2Jvb3QvY29uZmlnLTUuMTYuMTMtMjAwLmZjMzUueDg2
XzY0Og0KPiA+PiAgICAgICAgIENPTkZJR19TQVRBX01PQklMRV9MUE1fUE9MSUNZPTMNCj4gPj4N
Cj4gPj4gc28gdGhhdCAiZGVmYXVsdCAwIiBtYXkgYWN0dWFsbHkgbm90IGJlIHRoZSByaWdodCBv
bmUuDQo+ID4+DQo+ID4+IE5vdywgd2UncmUgYXQgdGhlIHBvaW50IHdoZXJlIGZldyBlbm91Z2gg
cGVvcGxlIGxpa2VseSBjYXJlIGFib3V0IEFUQSwNCj4gPj4gYnV0IHRoZSBjb3JvbGxhcnkgdG8g
dGhhdCBpcyBhbHNvIHRoYXQgdGhlc2Uga2luZHMgb2YgY2hhbmdlcyBjYW4NCj4gPj4gY2F1c2Ug
dXNlciBwYWluIHRoYXQgdGhlbiBkZXZlbG9wZXJzIGhhdmUgKm5vKiBpZGVhIGFib3V0Lg0KPiA+
PiBQYXJ0aWN1bGFybHkgd2hlbiB0aGUgcGFpbiBlbmRzIHVwIGJlaW5nIGNhdXNlZCBieSBzb21l
IHN1YnRsZSBkZWZhdWx0DQo+ID4+IGNvbmZpZyBvcHRpb24gc2lsZW50bHkgY2hhbmdpbmcgdGhh
dCBub2JvZHkgZXZlbiB0aG91Z2h0IGFib3V0Lg0KPiA+Pg0KPiA+PiBOb3csIHRoYXQgImRlZmF1
bHQgMCIgaXMgcHJvYmFibHkgdGhlIG9ubHkgc2FmZSBkZWZhdWx0IC0gYW5kIEkgZG9uJ3QNCj4g
Pj4gZGlzcHV0ZSB0aGF0IHBhcnQuIEJ1dCBJIGFsc28gc3VzcGVjdCB0aGF0IEZlZG9yYSBjaG9z
ZSB0aGF0IHZhbHVlICczJw0KPiA+PiBiZWNhdXNlIGl0IHByb2JhYmx5IG1ha2VzIGEgbm90aWNl
YWJsZSBwb3dlciB1c2UgZGlmZmVyZW5jZSBvbiBhdA0KPiA+PiBsZWFzdCBzb21lIHBsYXRmb3Jt
cy4NCj4gPj4NCj4gPj4gSSBkb24ndCBrbm93LiBCdXQgSSBkb3VidCByZWFsbHkgKmFueWJvZHkq
IGtub3dzLCBzbyByZW5hbWluZyB0aGVtIGFuZA0KPiA+PiBzaWxlbnRseSBsaWtlbHkgY2hhbmdp
bmcgY29uZmlnIG9wdGlvbnMgZm9yIHNvbWUgbGVzcy10aGFuLWNyaXRpY2FsDQo+ID4+IHJlYXNv
biBpcyBqdXN0IG5vdCBhIGdyZWF0IGlkZWEuDQo+ID4+DQo+ID4+ICAgICAgICAgICAgICAgICBM
aW51cw0KPiA+DQo+ID4gVGhhbmtzIGZvciBwb2ludGluZyBvdXQgdGhlIHN1YnRsZXR5IG9mIHJl
bmFtaW5nIGEgY29uZmlndXJhdGlvbiBvcHRpb24gaGlkZXMNCj4gPiBwcm9ibGVtcyBiZWNhdXNl
IHBlb3BsZSBkb24ndCBzZWUgdGhlIG5ldyBjb25maWcgb3B0aW9uIGFuZCBwaWNrIHRoZSBkZWZh
dWx0Lg0KPiA+IEkgd291bGRuJ3QgY2FsbCB0aGlzIGNvbmZpZ3VyYXRpb24gb3B0aW9uIHJlbmFt
ZSBjcml0aWNhbCwgc28gaWYgeW91IGNob3NlIHRvDQo+IHJldmVydA0KPiA+IGl0IEkgd291bGQg
dW5kZXJzdGFuZC4NCj4gPg0KPiA+IEhvd2V2ZXIgSSB0aGluayB5b3UgcmFpc2UgYSBnb29kIHBv
aW50IHRoYXQgaWYgZGlzdHJvcyBhcmUgcGlja2luZyBkaWZmZXJlbnQNCj4gImRlZmF1bHQiDQo+
ID4gdmFsdWVzIGFuZCBrZWVwaW5nIHRoZW0gdGhlcmUgYSBsb25nIHRpbWUgdGhhdCB0aGUgdmFs
dWUgaW4gdGhlIHVwc3RyZWFtDQo+IGtlcm5lbA0KPiA+IGlzIHByb2JhYmx5IG5vdCByaWdodCBh
bnltb3JlLiAgQSB3aGlsZSBiYWNrIHRoYXQgZGVmYXVsdCBtYWRlIHNlbnNlIGJlY2F1c2UNCj4g
YWxsIHRoZQ0KPiA+IHBvd2VyIHNhdmluZyBzdHVmZiB3YXMgcmlza3kgYXQgdGhlIHRpbWUuICBJ
dCdzIHByZXR0eSB3ZWxsIGJha2VkIG5vdy4NCj4gPg0KPiA+IFNvIG1heWJlIGEgbG9naWNhbCB0
aGluZyBpcyB0byBrZWVwIHRoaXMgY2hhbmdlIGFuZCBzZW5kIGEgZm9sbG93IHVwIHRoYXQgYWxz
bw0KPiBjaGFuZ2VzDQo+ID4gdGhlIGRlZmF1bHQgdG8gMz8gIElmIHlvdSdyZSBzdXBwb3J0aXZl
IG9mIHRoYXQgSSdsbCBzZW5kIHNvbWV0aGluZyB0byBEYW1pZW4gdG8NCj4gZG8gdGhhdC4NCj4g
DQo+IE1hcmlvLCBsZXQncyBjaGVjayB3aGF0IG90aGVyIGRpc3Ryb3MgZG8gZmlyc3QgYmVmb3Jl
IGRlY2lkaW5nLiBGZWRvcmEgZm9yDQo+IHN1cmUgaGFzIGEgZGVmYXVsdCBvZiAzIGFuZCBJIGhh
dmUgbmV2ZXIgc2VlbiBhbnkgaXNzdWUgd2l0aCBpdCAoYW5kIEkNCj4gaGF2ZSBiZWVuIHVzaW5n
IEZlZG9yYSBmb3IgYSBsb25nIHRpbWUgd2l0aCBtYW55IGRpZmZlcmVudCBkcml2ZXMpLg0KPiAN
Cj4gTm90IHN1cmUgd2hhdCBkaXN0cm8geW91IGFyZSB1c2luZywgYnV0IGlmIGl0IGlzIG5vdCBG
ZWRvcmEsIHBsZWFzZSBjaGVjay4NCj4gV2Ugc2hvdWxkIGNoZWNrIGF0IGxlYXN0IERlYmlhbiwg
VWJ1bnR1LCBTVVNFLCBSSEVMIGFuZCBDZW50T1MuIEkgY2FuDQo+IGNoZWNrIHNvbWUgb3RoZXIg
bWlub3Igb25lcyB0b28gYXMgSSBrbm93IHVzZXJzLg0KPiANCg0KSSB1c2UgVWJ1bnR1IG1vc3Rs
eSwgYW5kIGhhdmUgYSB2YXJpZXR5IG9mIGRpc3RybyBrZXJuZWxzIGluc3RhbGxlZDoNCg0KY29u
ZmlnLTUuMTMuMC0yNS1nZW5lcmljOkNPTkZJR19TQVRBX01PQklMRV9MUE1fUE9MSUNZPTMNCmNv
bmZpZy01LjE0LjAtMTAyOS1vZW06Q09ORklHX1NBVEFfTU9CSUxFX0xQTV9QT0xJQ1k9Mw0KY29u
ZmlnLTUuNC4wLTYwLWdlbmVyaWM6Q09ORklHX1NBVEFfTU9CSUxFX0xQTV9QT0xJQ1k9Mw0KDQpG
cm9tIGEgYm94IHdpdGggYSByYW5kb20gUkhFTDgga2VybmVsIEkgc2VlOg0KDQpjb25maWctNC4x
OC4wLTM3Mi4yLjEuZWw4Lng4Nl82NDpDT05GSUdfU0FUQV9NT0JJTEVfTFBNX1BPTElDWT0wDQoN
Ckhvd2V2ZXIgSSBiZWxpZXZlIHRoYXQgaXMgYmVjYXVzZSBSSCB1c2VzIHR1bmVkIHRvIHNldCBw
b2xpY2llcyBsaWtlIHRoaXMuIA0KVGhleSBoYXZlIHVzZSBjYXNlcyBmcm9tIGVtYmVkZGVkIHVw
IHRocm91Z2ggZGF0YWNlbnRlci4NCkZvciBleGFtcGxlIHlvdSBjYW4gc2VlIHRoZWlyICJkZXNr
dG9wIiBwcm9maWxlIG92ZXJyaWRlcyBpdCB0bw0KdG8gbWVkaXVtX3Bvd2VyOg0KDQpodHRwczov
L2dpdGh1Yi5jb20vcmVkaGF0LXBlcmZvcm1hbmNlL3R1bmVkL2NvbW1pdC9hZGZmYmIwY2ExNTM3
Mjc3ZDUzNDQ2NjFlMDVhNzA1YWYyNTIwYzg5DQoNCkRvd25sb2FkZWQgYSByYW5kb20gRGViaWFu
IDUuMTAga2VybmVsIHBhY2thZ2UgYW5kIGV4dHJhY3RlZCBpdDoNCiQgZ3JlcCBMUE0gY29uZmln
LTUuMTAuMC0xMC1hbWQ2NA0KQ09ORklHX1NBVEFfTU9CSUxFX0xQTV9QT0xJQ1k9Mw0KDQpDaGVj
a2VkIGFyY2ggZnJvbSB0aGVpciBzb3VyY2UgdHJlZSBhbmQgdGhleSBhbHNvIHNldCAzOg0KaHR0
cHM6Ly9naXRodWIuY29tL2FyY2hsaW51eC9zdm50b2dpdC1wYWNrYWdlcy9ibG9iL3BhY2thZ2Vz
L2xpbnV4L3RydW5rL2NvbmZpZyNMMjc5OA0KDQpOb3Qgc3VyZSB3aGVyZSB0byBjaGVjayBTVVNF
Lg0K
