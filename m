Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50455CA0FF3
	for <linux-ide@archiver.kernel.org>; Tue,  5 Sep 2023 16:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245719AbjIEQUu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353874AbjIEI1E (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Sep 2023 04:27:04 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00A0CCB
        for <linux-ide@vger.kernel.org>; Tue,  5 Sep 2023 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693902418; x=1725438418;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IfDnh1xhqmh0M+yn0aRXM1sHbvvEJXUPD0timO5ejZU=;
  b=ENRIYVi1Y+VzhToI4NqIncIjpguMh8ylspf5C2l4BvLnjthjaZ2w3f/Q
   hLiNLG/fEjt8C+A1CUFH6mhxWs/w7/Dmc6lEQlA6gcXB8p3o7oR+YVQXL
   I4YUMNXEdtb+lyM00Qrf7LIoWmfcEzm9V+sDicrufkpa6BZ1RML3w9ePR
   yrQnE0/AAHAWZdWnbvKLtucIvsq4lOlSZuaJqpCBQyS6v7x4f3tuBEMX2
   SC1+swp/S6cxdJES32zb3R6HfEXwgtKADca4YcAHOaITs4Zag6oLicf+C
   mGKVhHQqnbz0jorgd3tAlL7LVd01aB9Woqizdg0KQAh6KUm5s78LVSP8N
   A==;
X-IronPort-AV: E=Sophos;i="6.02,228,1688400000"; 
   d="scan'208";a="247578551"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2023 16:26:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwG21f5R3lSQ1rq38jdIKk52OspOWjxA6BCr3w1EFqgmKshcD/PEObBc/byXMwJ/El3oWoH0Prf+y+dYNyYk0FUeBjSMDkyiQ98WsI8VLxDfHJQOSYvJbQ3fxFscx4nMveKDhnqKmnmTrnLM0nuOKMoWUrOMz7y1HPi3MEPojLy9HkzEqnCsZ3PvZEmo9OWN6DfoCQNfmBapkdSo7OziCSxAxOMLxWvTCRuChkB8d05MgXMNFpxvSE6a9vo9MMDRF2VaA8elSwpWuH4GVkyXxc13f5i/OYtvBkCQ/sB+2C4Ole43BOrK/TLgwgcsIHfy0pF3mHe21+nZcLqkvwBuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfDnh1xhqmh0M+yn0aRXM1sHbvvEJXUPD0timO5ejZU=;
 b=UNFtmjSS9vbHUUV0CcLhWrvHhBR7WAM9H6hAj4wmema3UJ0JmZ8NNWxK/pLv4chJrxKRIRUxQgjnKhJ2AdqsgppTwwRRGg29j1VTwPKEaPZmv+ppPHN1hQjG+eH9zkYf0UMBRtRqnuGZQCHf2odGYYlM8flAErxmIRIHovN8ZnK1lgPalUielJl5OjuoY75KubIBiiyjpKaOm7Qa6NDKbjWDlNkWlrg0JMRItIKoD9J5ZX5pNqBt57ndjT9TdBAGh9TW++sIYZuY6Us5yYNtisg+qobZ6+6FqYYVoZtj8q7rWn3+ChknWMOSITh89bvzKnZMXfNC5DULRioNegMd1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfDnh1xhqmh0M+yn0aRXM1sHbvvEJXUPD0timO5ejZU=;
 b=Km8KgtcYNxwTIaJMByWE5vS9bFexL69fkqhuXn0e49ECncgXT2d8ONo4i2/3uPOO6mEAOslSXF9F27rzChmSR+Y4ACzkQCK4QdpxGk/d52d3h62yNICk9tzLfFZqVm8N48UNKwlfC0upDZzDIr/IyHKAIGEWXcbSYycX6gIfPCc=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6963.namprd04.prod.outlook.com (2603:10b6:a03:228::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.24; Tue, 5 Sep
 2023 08:26:48 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.024; Tue, 5 Sep 2023
 08:26:47 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     Niklas Cassel <nks@flawful.org>,
        Runa Guo-oc <RunaGuo-oc@zhaoxin.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ata: libata: disallow dev-initiated LPM transitions to
 unsupported states
Thread-Topic: [PATCH] ata: libata: disallow dev-initiated LPM transitions to
 unsupported states
Thread-Index: AQHZ33CFIB3CU8NiFkuRhRo1dcaHlrALgqOAgABj4QA=
Date:   Tue, 5 Sep 2023 08:26:46 +0000
Message-ID: <ZPbmQiQR8yU6L5Nx@x1-carbon>
References: <20230904204257.3296685-1-nks@flawful.org>
 <f83f8d45-b506-118f-d038-507bc87eeeef@kernel.org>
In-Reply-To: <f83f8d45-b506-118f-d038-507bc87eeeef@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6963:EE_
x-ms-office365-filtering-correlation-id: 668fabf4-7a08-4b13-c093-08dbade9d837
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: spPTYqLCke+NVjGuU/qIIFYD482ZbU+t3U6yyJHcL/d6Kg78spOP/zAZ5RNDSe65LRy6RYBuKifKRNd9y4nHaN2QtlEpAJaeZjN+3Tt01pkWEeGD/xptx5px+WYMrLQkyQB/NZuS5N9fHBZeY27HtSByPlOWni1BLm72kppKCIj9dpR0qnc5xRRmUkQ4efFVD0a2ESYx0yETdMQh5PxYAnKpjLInuBWz/xF7ykpCLfomdbsQCeg2M7l2NwDZzmIfkmLQugACkXRw+fSM0lFKRMhUxq0h9l8fB8rYH7+zyfSR6LUK8mdzUgeLsp011ERWGBiPUZNynLFeRX1Xa7YvtvieJdAqyLObhlnauGtQ8fqCo8SLs+UI228Urv5wTRo1MM5Xt/OsuYfllo9m1wWQMFUcSboxSjhBMkIFEXIb0hDH0nUDRe2NqGTn+ymZJstFkre+/VF4jA5378fmB35q22xPLJHGNhRiXP9ZJ0uYP8WqpLtDe+lKAq7dIwEw/LnscWXk23TN4a6XcbpncFrmcCBBhVfSNgZGnD/+NX/FsGcmDfzY2SsoiQ4KJnTAfrHVY3bWjREdDKYvAK48hdFkKd4gJ90TfiySkOsx266pJ3pwuvEMr9s84S0vqHLTesun
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(376002)(39860400002)(366004)(186009)(1800799009)(451199024)(41300700001)(478600001)(122000001)(38070700005)(71200400001)(33716001)(82960400001)(86362001)(38100700002)(83380400001)(26005)(9686003)(53546011)(6486002)(6506007)(6512007)(66946007)(76116006)(54906003)(66446008)(6916009)(2906002)(91956017)(316002)(66476007)(66556008)(64756008)(5660300002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VERmTDE5UFdGdzFaYW1nL29uNTlGbEkxMlQvcDEycDZQTWlCOGJ6TVhjRW5Q?=
 =?utf-8?B?UWNaREhjcUk0dlRpU2VIa05CUnhheklxMGRGa1pOVVhhem9qMkRUdjV3V2l1?=
 =?utf-8?B?TTl2bVI3Yk55VG9HQXFGSHVwdGpxRVYxcWp1SmJBdFdGVjBLNzhvcm1MVWdw?=
 =?utf-8?B?RThObnVvYnNSNmU1N1loVkNGTTV0WXN3SkpaZ016S1Nmd3JXSitBNGdoVWRY?=
 =?utf-8?B?Z043cHpkWjN4VVQvTzdEZytLdmxXUHBtRHVWZ0xLaVBCcDVWRmlrVUFxQnBv?=
 =?utf-8?B?OHgrZEZ0a0NUanowMUlHUFhZaVNXd1RhTk1RankwM2ViUXZLNzIvQWhZUW1x?=
 =?utf-8?B?MFlvS1hZSzJIeTlHN0lsMmZ1NnQ5b2Z3dE5CcHNOWDV6V0tFQ0pxM210YWQ1?=
 =?utf-8?B?TUhvVUtFeFhXdGNTY0pzZ1NvYjExNzcwZDYwc2hXZlZTZ21PUG9nOGxPaW0z?=
 =?utf-8?B?aG9qa1BCR2VsdE52VEs5d3lkYThSeVZYV3NRWXlYbTkxYlZjenZDNFRYVHhm?=
 =?utf-8?B?dElrdUdwdXhnSkhYa0xwbHA0S2dQOVg1YWJ1c2hSWTNUQUFEeXYzVyttSExq?=
 =?utf-8?B?VW84V09lZU9RWDJYbHdMSmgwOXFodHpyejNlT1hNaE9ZLzFpci9ZSjJhN1h4?=
 =?utf-8?B?S1IydzgvL2tWdGR3S2VEOVFwc25RU0U2cDdaZ09maUQ5cnFtKzdoSzRPS3ds?=
 =?utf-8?B?VFVwNkNVUFJzNGF6SHRVTWJubi8wRGJPTkMvTGE2QlRMQ0R4S3UzOHNEYlJx?=
 =?utf-8?B?Ym5KaHlCSkQvUmt5SWhIeFhVdUVMbndRYThXWnM2NDNWSGlib2JYaEtiTU9j?=
 =?utf-8?B?TThuLzlObjNrcFZkSVV5Q1NDUzZ2SWM2V3JLZzVGS0FSL0tXMkxBV2ZYT2g3?=
 =?utf-8?B?dTBuYXlLMFhPYytpT1UvS3M2Mm5aWk43TWFpQkNscTRQdEhScm9pTTgwd1o1?=
 =?utf-8?B?YWFGd0I1NHl0NXRySHRYRjNSZzlqVXdSbzJEKzRBU0Fna1dlQzQrQ0Zod1RX?=
 =?utf-8?B?YkFyd3BmQlAzaXM3bzhxUDBqTERick0vV0tCR0Q4OUoybWs4TlVteld5b0FI?=
 =?utf-8?B?STIrRHRnWnVJZDNmcXhVeHB3OTZ3SVk2TTZWSDg5QTlKdGNOOXlYclRyM0pi?=
 =?utf-8?B?R2FzZ2pYNGNUOS9Gc2ZOcVMxcDNraHNTU2RmckFlQXV0UVorTUl4TDhXQ0cx?=
 =?utf-8?B?czhZR21uSWcxWXo2QUwrMzZNaTdaMnNtUHE0NkNFNmFVVE03ZVRQSnBTRStr?=
 =?utf-8?B?eXBFWTYzdUFJN0d6VUJielZ3UGwxcCtRd05mVGM3UFBOTkQzVm91NEtzRm5q?=
 =?utf-8?B?aTRDT1d0Vm40MHpKS0FoM0YrY1lCbjRwVDBWdERPN1plL2JhRzU3QnFZRHBa?=
 =?utf-8?B?aFV2NFF1ak1zZ0NUbktXK1paTEJBYUl1cFZPK0hhVnNwWmR5Mmt2cmhna0hR?=
 =?utf-8?B?WWkxZlBnRnFLckZJdnRRTWtjMHV2RGIrU0hNYmsrLzBXY2t5Y292MkJCMlh1?=
 =?utf-8?B?YkJRb2lnRW5RK1pUWlpiNkhIYnFmSEJpNDc3eUpGNEx3SHQrTmNIZFduenRk?=
 =?utf-8?B?T0cxc0ZhNVNLUkFMSFlxcUR3b2JlVFk4WW5wbEo0KzZ6MXpEaDZEZlhwRnJE?=
 =?utf-8?B?QnZXTEorZlB3d1Q1bmJOaG8xakF0QXBtbFl1VkpIU2VyYkp6cmlmYUZNejdN?=
 =?utf-8?B?aVN0ek96MVFwQ2dtVUJhdThnZjNHZDBFMmNhNXptZnNSV3l2WUZBK1JDOFRI?=
 =?utf-8?B?S3V2YzJjY3lSVURlbGxXRzlUcmF4a2V6dXNiMlZQVjYzM0oyV0tKNmxVd2xx?=
 =?utf-8?B?L2FIT1VWV1BuNW1Zb0RKT1Vjd1JiQi90bkpOSzJJV0JaYWl2aUowZ2dRaUlY?=
 =?utf-8?B?d1dDOWwrZm56eldLRGoxVnVYamVBSWZxY2FvV1RpWVlYMTZkRUkyNzZTRG1F?=
 =?utf-8?B?c0dUVXpjRXVOczNFczNRcFBCSFhtcmNOOXJUU3lUbWtpSXpZcUdzYWVjM2RP?=
 =?utf-8?B?V2c1V1JqZ0VGc0xBK2pDYjdoOC9GV0V2a3Rha01YWVVpRStQdVExaGpFQm5v?=
 =?utf-8?B?bSs0UzVpRjRVeTNRZjdEUUc4WWgvN3ZvWnJ1UU5ySU1GR1ZLQm5IQzhSYUFJ?=
 =?utf-8?B?YUIyZHlmMlZPWmdZd0pYNlhQTjg2RzRob2dPTVU1NnUzZTFubE9LcENMb0NT?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35A912D132BCD44196F577BF93F75590@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 58ezp0JpGmAwaTYZKa+esYLABVMG1UuVm2ye5sn78cp6GgfeZAqinqKsJxaAAWS7/D3SAXXkG4zQdz5mWA8yOy3we38VZ05ajJNxKeaG8RigJ6qUc09Su8JOTjA88dnrJGMi0P4stnrKleOHd+CNV7+oIABxAoUFHbtrvdZWVz8OCDntJ7HpR7+Hf4rngMw22UzXlBdXU3trGNLSBBWId9Ts8dcHhEr2pAQN9PhHlJvEw73O8Qm4ITFz3ux2Rdo4P9ECnuV/mYaTFSyBHRCz/o9IUmiT6jnA14wcwnvqPR2+JvoVYJk5iPbb5+AynPTlENYEbG2BDMM9u9VlZL7s8hmGQBvWizZSi22TIwGTXkpMcvNLT9Rm/lnohhPqf+wzMf+ne3DWTOqZTLrm6DI/umcqhvhNXYuNSsIrAHyVxRyJ4H2qI8JSLkYVqrrk1HjgptjpohRbR0b8n97Ra2P0Air4YY6UUlNkmGF+oLlZppxQYMtN08Ny/crVDu1RoQ5zfsks1zMhMZyog344f2uLOHlfwiefreBMuSZ9SotZi7PmJnz6F0UrcdkbBM6n8RLE9++TIrUoZafFFnFI8vwCj+62fWQq8098yEcr2p7P5ns0ZFzplst0968dHVDqUogiXRanE28a8UfpfLOXk+GGOTihR+iKbXXAQnrOXNdpRxUSy2EPw6c5CHcBsedJrGFEVhvFXD2zSdOuhZDcihiyTV6ys3bjHADJBiF1N4MqFNZZD9lTc5cDrh08knZow9LSh49OuKOizfWTXOnT4svjz1TErPmjTSQzj2IMYwrsWphzWW/RzDMipaHlDiHUWpM9GpuqJmi32+AA9eNuoJm3fsoiPQCiWmt04MAfukdcccoMae7QOs5f7wsayqB62NvR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668fabf4-7a08-4b13-c093-08dbade9d837
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 08:26:46.9510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2FJmG9EB3MXF36We/jWl4kl7uJ2KLHo1VxZ7V3l6d1IvTr3OaLsquTJDq06TiGRO+ITlf7+iEyBIH0JPox0N0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6963
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

T24gVHVlLCBTZXAgMDUsIDIwMjMgYXQgMTE6Mjk6MTNBTSArMDkwMCwgRGFtaWVuIExlIE1vYWwg
d3JvdGU6DQo+IE9uIDkvNS8yMyAwNTo0MiwgTmlrbGFzIENhc3NlbCB3cm90ZToNCj4gPiBGcm9t
OiBOaWtsYXMgQ2Fzc2VsIDxuaWtsYXMuY2Fzc2VsQHdkYy5jb20+DQo+ID4gDQo+ID4gSW4gQUhD
SSAxLjMuMSwgdGhlIHJlZ2lzdGVyIGRlc2NyaXB0aW9uIGZvciBDQVAuU1NDOg0KPiA+ICJXaGVu
IGNsZWFyZWQgdG8g4oCYMOKAmSwgc29mdHdhcmUgbXVzdCBub3QgYWxsb3cgdGhlIEhCQSB0byBp
bml0aWF0ZQ0KPiA+IHRyYW5zaXRpb25zIHRvIHRoZSBTbHVtYmVyIHN0YXRlIHZpYSBhZ3Jlc3Np
dmUgbGluayBwb3dlciBtYW5hZ2VtZW50IG5vcg0KPiA+IHRoZSBQeENNRC5JQ0MgZmllbGQgaW4g
ZWFjaCBwb3J0LCBhbmQgdGhlIFB4U0NUTC5JUE0gZmllbGQgaW4gZWFjaCBwb3J0DQo+ID4gbXVz
dCBiZSBwcm9ncmFtbWVkIHRvIGRpc2FsbG93IGRldmljZSBpbml0aWF0ZWQgU2x1bWJlciByZXF1
ZXN0cy4iDQo+ID4gDQo+ID4gSW4gQUhDSSAxLjMuMSwgdGhlIHJlZ2lzdGVyIGRlc2NyaXB0aW9u
IGZvciBDQVAuUFNDOg0KPiA+ICJXaGVuIGNsZWFyZWQgdG8g4oCYMOKAmSwgc29mdHdhcmUgbXVz
dCBub3QgYWxsb3cgdGhlIEhCQSB0byBpbml0aWF0ZQ0KPiA+IHRyYW5zaXRpb25zIHRvIHRoZSBQ
YXJ0aWFsIHN0YXRlIHZpYSBhZ3Jlc3NpdmUgbGluayBwb3dlciBtYW5hZ2VtZW50IG5vcg0KPiA+
IHRoZSBQeENNRC5JQ0MgZmllbGQgaW4gZWFjaCBwb3J0LCBhbmQgdGhlIFB4U0NUTC5JUE0gZmll
bGQgaW4gZWFjaCBwb3J0DQo+ID4gbXVzdCBiZSBwcm9ncmFtbWVkIHRvIGRpc2FsbG93IGRldmlj
ZSBpbml0aWF0ZWQgUGFydGlhbCByZXF1ZXN0cy4iDQo+ID4gDQo+ID4gRW5zdXJlIHRoYXQgd2Ug
YWx3YXlzIHNldCB0aGUgY29ycmVzcG9uZGluZyBiaXRzIGluIFB4U0NUTC5JUE0sIHN1Y2ggdGhh
dA0KPiA+IGEgZGV2aWNlIGlzIG5vdCBhbGxvd2VkIHRvIGluaXRpYXRlIHRyYW5zaXRpb25zIHRv
IHBvd2VyIHN0YXRlcyB3aGljaCBhcmUNCj4gPiB1bnN1cHBvcnRlZCBieSB0aGUgSEJBLg0KPiA+
IA0KPiA+IERldlNsZWVwIGlzIGFsd2F5cyBpbml0aWF0ZWQgYnkgdGhlIEhCQSwgaG93ZXZlciwg
Zm9yIGNvbXBsZXRlbmVzcywgc2V0IHRoZQ0KPiA+IGNvcnJlc3BvbmRpbmcgYml0IGluIFB4U0NU
TC5JUE0gc3VjaCB0aGF0IGFncmVzc2l2ZSBsaW5rIHBvd2VyIG1hbmFnZW1lbnQNCj4gPiBjYW5u
b3QgdHJhbnNpdGlvbiB0byBEZXZTbGVlcCBpZiBEZXZTbGVlcCBpcyBub3Qgc3VwcG9ydGVkLg0K
PiA+IA0KPiA+IHNhdGFfbGlua19zY3JfbHBtKCkgaXMgdXNlZCBieSBsaWJhaGNpLCBhdGFfcGlp
eCBhbmQgbGliYXRhLXBtcC4NCj4gPiBIb3dldmVyLCBvbmx5IGxpYmFoY2kgaGFzIHRoZSBhYmls
aXR5IHRvIHJlYWQgdGhlIENBUC9DQVAyIHJlZ2lzdGVyIHRvIHNlZQ0KPiA+IGlmIHRoZXNlIGZl
YXR1cmVzIGFyZSBzdXBwb3J0ZWQuIFRoZXJlZm9yZSwgaW4gb3JkZXIgdG8gbm90IGludHJvZHVj
ZSBhbnkNCj4gPiByZWdyZXNzaW9ucyBvbiBhdGFfcGlpeCBvciBsaWJhdGEtcG1wLCBjcmVhdGUg
ZmxhZ3MgdGhhdCBpbmRpY2F0ZSB0aGF0IHRoZQ0KPiA+IHJlc3BlY3RpdmUgZmVhdHVyZSBpcyBO
T1Qgc3VwcG9ydGVkLiBUaGlzIHdheSwgdGhlIGJlaGF2aW9yIGZvciBhdGFfcGlpeA0KPiA+IGFu
ZCBsaWJhdGEtcG1wIHNob3VsZCByZW1haW4gdW5jaGFuZ2VkLg0KPiA+IA0KPiA+IFRoaXMgY2hh
bmdlIGlzIGJhc2VkIG9uIGEgcGF0Y2ggb3JpZ2luYWxseSBzdWJtaXR0ZWQgYnkgUnVuYSBHdW8t
b2MuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmlrbGFzIENhc3NlbCA8bmlrbGFzLmNhc3Nl
bEB3ZGMuY29tPg0KPiANCj4gTG9va3MgZ29vZCwgYnV0IGRvbid0IHdlIG5lZWQgYSBGaXhlcyB0
YWcgZm9yIHRoaXMgPw0KDQpTdXJlDQoNCkZpeGVzOiAxMTUyYjI2MTdhNmUgKCJsaWJhdGE6IGlt
cGxlbWVudCBzYXRhX2xpbmtfc2NyX2xwbSgpIGFuZCBtYWtlIGF0YV9kZXZfc2V0X2ZlYXR1cmUo
KSBnbG9iYWwiKQ0KDQpDYW4geW91IGFkZCB3aGVuIGFwcGx5aW5nLCBvciBkbyB5b3Ugd2FudCBt
ZSB0byByZXNlbmQ/DQoNCg0KS2luZCByZWdhcmRzLA0KTmlrbGFz
