Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65098C433F5
	for <linux-ide@archiver.kernel.org>; Sat,  2 Apr 2022 00:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbiDBApd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 1 Apr 2022 20:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiDBApc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 1 Apr 2022 20:45:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1163914F
        for <linux-ide@vger.kernel.org>; Fri,  1 Apr 2022 17:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648860220; x=1680396220;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oS8dMt5OWh4rtUO0EBVQimtqs6LCNVkvUWWFv9qOdKk=;
  b=AivmbZpedzNOctjox9Hkm5FbtLCeL+XJJMBLFWKAZ65ENwaN9ZktSl0C
   scTz+F9hx1czczu4Zy1yWmVmMKEg2PqJgBtIRaU8O9ckjqBI0niG+CEZ+
   zn4EVj4UaNbuHLeQHhdmpDKzS6dHf24ttOAu+0n9aug2bLn4g5KCslYav
   CzGHistCiEkOKFbJOQvKAQSLtIAN4y4zEbTSLGJlorsiN3HSmF+Efvtq9
   8YcUpGoulZkHcvVEQWgCWjW0yXymJv/D2BalVOVfTL9filSNiP/1xZd+d
   ZwCICrfJ7BMO5SNX0G7A+w4Joa5lPTG0UhKIRsTi1FfjRto7NOIWIdCFp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="323433681"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="323433681"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 17:43:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="522968613"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2022 17:43:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Apr 2022 17:43:39 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Apr 2022 17:43:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Apr 2022 17:43:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Apr 2022 17:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/PhvbGnv3PnD+EYLcmWrH1N5u4kMTBtpVFZxEmETetScooXPP4u7Q+MmYqORENbZZIuJy7eJ8MqNAm41o9ZoKwtbjWLYr7SthC9MrPSQ+g0cUU9tUcfwpAyK4dOtkieE9qHc5h7NMVbNQE2OsipG1QkOFBfL6nUiJbp8H8icF4B4BftO2BmQ3maw4aIujYmvcGKUjd6cbIr38Mpq06KKSBR2qcs38K0GPwpzSaELT6riKegaDYwBsbrOEaSbNRSVGV/sIHD6pUkGNmRH7BG/VRhlaHEXTN1rY1MwFqk6F8Pd7RyBesbu2KPQ403abW83J4G37dQizy2AIfp36QOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS8dMt5OWh4rtUO0EBVQimtqs6LCNVkvUWWFv9qOdKk=;
 b=cBKNzHxS6k+RipoD8nOQyB8UtyxIjW/ycdcY/BaEERFbb5GWF+eVgO/a3aoBWgNBahAZdwxWw3WxzVcwxqq87qawkZHtn5oQBameQguseSv/VocO0n8+DwmXJ0Esp+CHKZKbxUiV/VKgAM8KoROnEDw9Y2/AJ6ETkGH94HZxV+QFiKGfw85fGkCf4TYjfGR8cuSWdGDqbqhNIppSn8tDE/6Pdz8lB8F3yOgUt++KLzQ0BhMwK8sqOpYuiZisi/6/2OZOw7jZ7vXSxbyGnTrUhivrHLMHrvNIWKj8lwhAe0jlb0bqr5nlhTTrkyYotOI+IiTR1pDAZRGh7lGv+OFrKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH2PR11MB4455.namprd11.prod.outlook.com
 (2603:10b6:610:46::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Sat, 2 Apr
 2022 00:43:36 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::645c:646:87b0:7be5]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::645c:646:87b0:7be5%6]) with mapi id 15.20.5123.023; Sat, 2 Apr 2022
 00:43:36 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ahci: Add Intel Emmitsburg PCH RAID PCI IDs
Thread-Topic: [PATCH] ahci: Add Intel Emmitsburg PCH RAID PCI IDs
Thread-Index: AQHYRiquGyO82RUHVEyXJxVDLQaA/Q==
Date:   Sat, 2 Apr 2022 00:43:36 +0000
Message-ID: <8e61fb0104422e8d70701e2ddc7b1ca53f009797.camel@intel.com>
References: <20201119104318.79297-1-mika.westerberg@linux.intel.com>
         <20201119165022.GA3582@infradead.org>
         <20201120105309.GR2495@lahna.fi.intel.com>
         <20201123100917.GA26718@infradead.org>
         <20201123112622.GB2495@lahna.fi.intel.com>
         <20201123113801.GA15759@infradead.org>
In-Reply-To: <20201123113801.GA15759@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-3.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d94c917a-a925-42cd-f85c-08da1441d27a
x-ms-traffictypediagnostic: CH2PR11MB4455:EE_
x-microsoft-antispam-prvs: <CH2PR11MB44556F39041381A1F8909885C6E39@CH2PR11MB4455.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MrNrRotsRS2qYkIgOfnZgjhtju/mUUAr11dLo3GXYTh12WGWycj1RLnYo//m5LPjwPp/cYeULsAlDTESHrBqeb0AvPyD1qF0Hth1TjeLBqXqNDpAc/Oo8+KrmrakuuN4ERPPCshl68QIsFGeNuGxWRRlx910xhs1bIxiuIBF4Ma4Vo4cJrlX6Ul1yi5qPcLI/LfuuoblG/2PK68RtyXqKVsOYPTby8WDZHWlYySx8jK2wG1XIVUo6cY3J5Z6rCRoLLse9gjioL8lVmRzIYcTRc1xcSkS1T8VZ8fbJlI3wFYBnjWAf7BTEuZ59htRBv5aoQjvAlrdqgJLjmu+6LXXKt94zCXMacYkWMcK5zgT8vKwxLGhucX4USOgxPqsA0rXDh2pPhrAKEEUrYMrShW1dteqBwFuBUBL8OYJPzRMss+kKxNoEyweu2tnPtDi8VxaUPW7p3Ql+euWDzWSk4x71L/TLYKrr9BWZ7zHiqDxok+6Ama8b0kINRQk06sdH7+vBVd03omJ2oXC9DTVoyODL9gNSE5QFEaFRpJYBM7xReP0o+/8J2zvssi7ki/Am/2GQjgSp0kbYDm2mUGVV+RPGRf94kYsR7XHcGAHTmJLIx69rlEuE1OtFyEU9MtusI7LqvBmz/aiLex+kZUvEPG/T8+Gk+p7QqQOloWOpOWL1pgzZNijSDtie/A70C1JRVfv1YAtVfqS1MlhYooyuY6TsseiZyPblRdzC6xHvIPU42o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(66476007)(54906003)(38070700005)(4001150100001)(2616005)(26005)(76116006)(66556008)(36756003)(66946007)(2906002)(83380400001)(64756008)(66446008)(71200400001)(4326008)(8676002)(6506007)(186003)(508600001)(6486002)(38100700002)(86362001)(316002)(5660300002)(8936002)(122000001)(6512007)(82960400001)(226253002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWk1ZDNCemZyNjdsYzNLeldFc3FRQjdtMWd1ZXB5RUpaSHo3MnRPc2t2YWxh?=
 =?utf-8?B?K3VxYmpPTjEwWHZzU1hoL3VlN21HZW5wemJkLzR5RHByb0FhSzZmcVhMbGhz?=
 =?utf-8?B?TVdlQTRoRWxRU1NBNDRFVisrY3BINjdSUXc4TkNWVlErdFFPSDZtY1FXQUJF?=
 =?utf-8?B?a1hqMlQrdjBnSk90WTJjZGMrWVFzRGZXalZab2MxTmpESnJHV0trc0Y5Wk1M?=
 =?utf-8?B?MVVZQ29tdzVxRTlqb0NYOTFodkQ4dGU1OG5MekkzYVZ5N21pMWY2dWpYVFBm?=
 =?utf-8?B?NlkrVnViSHZWQlFQYmxQMlBRR2Z0Y0lwTUtzY2NWU3p4emJMRzlSWDdqVkh4?=
 =?utf-8?B?Q3pXVXpJTFJCaDhZd2NWYkd3OVFnVDMvQ0NmNHlvUnkyb2ZtNTh0cjZJOVo2?=
 =?utf-8?B?VnV3Tng4bTV0ZkRtS25MQ2xFblZpQnNUdTFFTXFCcHdQRFdtakRSRlpSZlNt?=
 =?utf-8?B?NTFXbjFERkxwM0o1ajNqK09hSlVmbDJjaFRWTEFOUXQ3aXdQOGdMZzc0Rzhr?=
 =?utf-8?B?d0hOcDhrWFJHV3FWbmxRcUpSV1h1VndPTzBsaUYwQ29qMGNLRFJRR1Bxa2Nu?=
 =?utf-8?B?THV5bEZyeGlqYUN3SFkzc0JVRE91UFZzbEl3QlNDckhRb05oMDVHbHBEZk5I?=
 =?utf-8?B?bXVBc1EyMlI1U01zVU1ra2EzcjAxOVhsSXl6OVNnZlZmNFVab3I1WmtYbnJy?=
 =?utf-8?B?MFhISmFzYjFMT1g1OU5nZWQ2Q2cvQzF0MEYvZUtQRnRvUDZGcGRsanNsakhl?=
 =?utf-8?B?QTRMMWpvdlo5NWthZWhiLzIzY3BjSHQzbDNBZW16ZXRhNGRHcHNONlpPbm45?=
 =?utf-8?B?bG81UXBJRngzV3dtdFN0Q0xQYkxnVnYxTm8xTUVGeCtyQWxBUUhSMGtMTTlF?=
 =?utf-8?B?cTZDMTN6Z0RPVStFbkU3NHFqa1FXNHVjUE1aNExBNVhxMUtxd21BSlZDTmhE?=
 =?utf-8?B?RHlGcXdaT2daaGZFdU5DTkdUSVhQWk8ydGI5a2o1VTdqeksxT0xHMlArVXcx?=
 =?utf-8?B?WEhyM083UHhYYXZ0OFZKVTRBMGhwdFNBOE9KZytNOStvNHE2YUNFcVZCcXAz?=
 =?utf-8?B?ZmZwejFmekJoeG11UEpCV0VKYzcybWJBUzZ5MnhFTExMbjZ4UkJqVFJTejV1?=
 =?utf-8?B?SWQ2SzN3dXhJdk1pTC9nT3hRZXRQdmN4cWVEcHpVZDRVMlJqT3pyWlNvSDRp?=
 =?utf-8?B?MnBPUlhHWjJEZlZWL281ZWFBRUJJUUR1anZnbFVGdkZnRjMyMkFCV2gzdlF2?=
 =?utf-8?B?TXNFK0pMblM1dnMwZk5NVG5CSU9MQ2pXR1Z4WXhIK01BKzBlbDl4SnFTZ3g5?=
 =?utf-8?B?YVlQTkF0Z1Zwa0lpUUdzWENNeUc0MDBjUUczK2E2TnJEU0FkTTZrZjlsL2xm?=
 =?utf-8?B?amp6anRlN0xxSE5JUUFONFpZUmZlcS9JRUZVQXFkTTNIa0NWVVJnSUdvYjZu?=
 =?utf-8?B?aGdvL0dSVzNzWFp1MHBOdnppd0pZcWR6NWp3SzdRaGV2WUVjbVMyZHlJMVRX?=
 =?utf-8?B?THhYYnFtRmdTVmRIUEVFVEZNQUdubmlDaEU2R3lVUDA5MHdaVEpQeEx3TUlT?=
 =?utf-8?B?djJjRExmZ0tFZVIyUHVmSy9UajRYczdJRmVHd0NpOG5VTklQelpLNDZkcGt2?=
 =?utf-8?B?S0VTa082cTc2bWpkYUJhVW5TZityT1hoUnErdG95NitHakNUTEM1L2FvN0Q0?=
 =?utf-8?B?SXNlR3BpOE91L0p4R0h0RmlMYUlzMm9MOSs3U3M3bmlxU3lqUEhCSVdhZGVQ?=
 =?utf-8?B?S1JhbnNYcVdJRTM2WDIxVkxTendXUGhWOE9uTUd4T3lDN1JSRmlUNmNnV01S?=
 =?utf-8?B?R25SanhjQkd5WEZmeDIwRGQ3cG5Tb2JjQnBhVDdBRW42Q0FDT0JDUFZyaGIw?=
 =?utf-8?B?ZFBjRHYyZ2xvcHlpMm9uMGxZR3pndm1GUitEZlhiVTVBN2N5ZkxVNDJRVDhv?=
 =?utf-8?B?ZHluSkpHaThUNi9PZEY4VlYzRmIyVHh0UDZ5MnJ0ZzBmTDhJT3JVVUZQM0lz?=
 =?utf-8?B?dWNMcHdrampXZG1EMHRpTHYyV2Qwb0F5TlRIOVF4RVZHeGFEeDdiQ1Mvd2xh?=
 =?utf-8?B?aDc2bXAyMkNkQnBJSmoxMlhHNzR3UVVvQlR4cEtGOTZld29GVmp1TUJKVDlF?=
 =?utf-8?B?V0RUSVQ5b1FLbWFDb3Y4OEJDTlNSUlR5L0RFOEpXSGJBd0xyTlIwZURpaDhs?=
 =?utf-8?B?QWFQVElDZFVIdUt0SmVnajU2NFlBVmZQZ3M2M21rYU9QM1ZrNWo1eDJtU2Iz?=
 =?utf-8?B?YnJVZ2JVNUpGWWZWdGFBMEdzcVdYVWRiQkJBK0N2bEczbklScWRWRUQ4b1di?=
 =?utf-8?B?QWNjY1NpZWRiYVdCWWxUWHlNS1RHN1MrNHhoVDlmejlCS1V0bTlWVnZVL2p0?=
 =?utf-8?Q?YPcPtmpuNNDNU/zA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66EFB3FE1159D1418AD91BC498CBD2EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94c917a-a925-42cd-f85c-08da1441d27a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 00:43:36.1956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ojpDVaIKCdAWLZkJoD/pDB4QA0sXuXxREyeiGX2X/fTboDBgeVg3VcvXFH3Oy+6dFARruCQSvD6eftNcAt5M/IfIJxeSXsaQGd59JjoOa9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4455
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTIzIGF0IDExOjM4ICswMDAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gTW9uLCBOb3YgMjMsIDIwMjAgYXQgMDE6MjY6MjJQTSArMDIwMCwgTWlrYSBXZXN0
ZXJiZXJnIHdyb3RlOg0KPiA+IE9uIE1vbiwgTm92IDIzLCAyMDIwIGF0IDEwOjA5OjE3QU0gKzAw
MDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBOb3YgMjAsIDIwMjAg
YXQgMTI6NTM6MDlQTSArMDIwMCwgTWlrYSBXZXN0ZXJiZXJnIHdyb3RlOg0KPiA+ID4gPiBPbiBU
aHUsIE5vdiAxOSwgMjAyMCBhdCAwNDo1MDoyMlBNICswMDAwLCBDaHJpc3RvcGggSGVsbHdpZyB3
cm90ZToNCj4gPiA+ID4gPiBPbiBUaHUsIE5vdiAxOSwgMjAyMCBhdCAwMTo0MzoxOFBNICswMzAw
LCBNaWthIFdlc3RlcmJlcmcgd3JvdGU6DQo+ID4gPiA+ID4gPiBBZGQgSW50ZWwgRW1taXRzYnVy
ZyBQQ0ggUkFJRCBQQ0kgSURzIHRvIHRoZSBsaXN0IG9mIHN1cHBvcnRlZA0KPiA+ID4gPiA+ID4g
Y29udHJvbGxlcnMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU3R1cGlkIHF1ZXN0aW9uOiB3aGF0
IHdvdWxkIGl0IHRvIGdldCBJbnRlbCB0byBmaW5hbGx5IHJlcG9ydCB0aGUNCj4gPiA+ID4gPiBj
b3JyZWN0IGNsYXNzY29kZSBhZnRlciBhbGwgdGhlIHRpbWU/wqAgVGhlIGFtb3VudCBvZiBJRHMg
d2UgbmVlZCB0byBsaXN0DQo+ID4gPiA+ID4gaXMgZ2V0dGluZyByaWRpY3Vsb3VzLg0KDQpJdCB0
dXJucyBvdXQgdGhlIHByb2JsZW0gaXMgJE9USEVSX09TIHdhbnRzIHRvIGxvYWQgYW4gQUhDSSBk
cml2ZXINCmJhc2VkIG9uIGNsYXNzIGNvZGUgYW5kIGlmIFJBSUQgbW9kZSByZXVzZWQgdGhlIGNs
YXNzIGNvZGUgaXQgd291bGQNCmJyZWFrIGxlZ2FjeSB0aGVyZSwgYnV0IHNlZSBiZWxvdywgdGhl
cmUgaXMgYSBwYXRoIHRvIHN0ZW0gdGhlIHRpZGUgb2YNCm5ldyBpZHMgZmxvd2luZyBpbnRvIHRo
aXMgZmlsZS4uLg0KDQo+ID4gPiA+IA0KPiA+ID4gPiBXaGF0IGlzIHRoZSBjb3JyZWN0IGNsYXNz
IGNvZGUgaW4gdGhpcyBjYXNlIHRoYXQgaXQgd29ya3Mgd2l0aCB0aGUgQUhDSQ0KPiA+ID4gPiBk
cml2ZXI/DQo+ID4gPiA+IA0KPiA+ID4gPiBJIHRoaW5rIChub3QgMTAwJSBzdXJlKSBpdCByZXBv
cnRzIHN0YW5kYXJkIEFIQ0kgY2xhc3MgY29kZSB3aGVuIGl0IGlzDQo+ID4gPiA+IG5vdCBpbiBS
QUlEIG1vZGUgYnV0IHRoZXNlIFBDSSBJRHMgYXJlIGZvciB0aGUgUkFJRCBtb2RlLg0KPiA+ID4g
DQo+ID4gPiBUaGUgcmlnaHQgY2xhc3MgY29kZSBpcyB0aGUgQUhDSSBvbmUuwqAgVGhlIHNvIGNh
bGxlZCBSQUlEIG1vZGUgZG9lc24ndA0KPiA+ID4gY2hhbmdlIHRoZSBvcGVyYXRpb24gb2YgdGhl
IGRldmljZSBhdCBhbGwgKGV4Y2VwdCBmb3Igc29tZXRpbWVzIGhpZGluZw0KPiA+ID4gTlZNZSBk
ZXZpY2VzIHRoYXQgYXJlIGEgZGlmZmVyZW50IFBDSWUgZnVuY3Rpb24gdG8gc3RhcnQgd2l0aCku
DQo+ID4gDQo+ID4gVGhhbmtzLiBJIGxvb2tlZCBhdCB0aGUgQUhDSSBzcGVjICgxLjMuMSkgYW5k
IGl0IHNheXMgdGhpcyByZWdhcmRpbmcgdGhlDQo+ID4gY2xhc3MgY29kZSAoQ0MpIGZpZWxkOg0K
PiA+IA0KPiA+IMKgIEluZm9ybWF0aXZlIE5vdGU6IEZvciBIQkFzIHRoYXQgc3VwcG9ydCBSQUlE
LCB0aGUgU3ViIENsYXNzIENvZGUgcmVzZXQNCj4gPiDCoCB2YWx1ZSBzaG91bGQgYmUgMDRoIGFu
ZCB0aGUgUHJvZ3JhbW1pbmcgSW50ZXJmYWNlIHJlc2V0IHZhbHVlIHNob3VsZCBiZQ0KPiA+IMKg
IDAwaC4NCj4gPiANCj4gPiBJIHRoaW5rIHRoaXMgaXMgd2hhdCB0aGUgY29udHJvbGxlciBpcyBk
b2luZyB3aGVuIGluICJSQUlEIG1vZGUiLg0KDQpNaWthLCAiUkFJRCBtb2RlIiBpcyBhbiB1bmZv
cnR1bmF0ZSBtaXNub21lciBiZWNhdXNlIHRoZSBoYXJkd2FyZSBpcw0KanVzdCBzdGFuZGFyZCBB
SENJIHByb2dyYW1taW5nIG1vZGVsLCBhbHdheXMuDQoNCj4gVGhlIHBvaW50IGlzOiB0aGVzZSBB
SENJIGNvbnRyb2xsZXJzIGRvIG5vdCBzdXBwb3J0IFJBSUQgaW4gZm9ybQ0KPiBkZXNwaXRlIHRo
ZSBjb25mdXNpbmcgbmFtaW5nLg0KDQpJIGRpZCBzb21lIGRpZ2dpbmcgb24gdGhpcyB0byBib3Ro
IGdldCB0aGUgaGlzdG9yeSBhbmQgdG8gcHVzaCBmb3IgYQ0KY29uY2Vzc2lvbiB0aGF0IEludGVs
IHdpbGwgZml4IHRoZSBoYXJkd2FyZSBkZXZlbG9wbWVudCBwaXBlbGluZSB0bw0Kc3RvcCB0aGUg
cG9pbnRsZXNzIGNodXJuIG9mICJSQUlEIiBpZHMgZ29pbmcgZm9yd2FyZC4gVGhlIGhpc3Rvcnkg
aXMNCmVxdWFsIHBhcnRzIGVuY291cmFnaW5nIGFuZCB1bmZvcnR1bmF0ZS4gVGhlIGVuY291cmFn
aW5nIGZpbmRpbmcgaXMNCnRoYXQgdGhlICJSQUlEIiBkZXZpY2UtaWRzIG9uICJzZXJ2ZXIiIHBs
YXRmb3JtcyBoYXMgYmVlbiBzdGFibGUgZm9yDQpzZXZlcmFsIGdlbmVyYXRpb25zIGFuZCB3aWxs
IGNvbnRpbnVlIHRvIGJlIHN0YWJsZToNCg0KeyBQQ0lfVkRFVklDRShJTlRFTCwgMHgyODI2KSwg
Ym9hcmRfYWhjaSB9LCAvKiBQQkcvTGV3aXNidXJnIFJBSUQqLw0KLi4uDQp7IFBDSV9WREVWSUNF
KElOVEVMLCAweDI4MjcpLCBib2FyZF9haGNpIH0sIC8qIFdlbGxzYnVyZy9MZXdpc2J1cmcgUkFJ
RCAqLw0KDQpJLmUuIHRob3NlIFJBSUQtaWRzIGFsc28gd29yayBmb3IgRW1taXRzYnVyZy4gVGhl
IHVuZm9ydHVuYXRlIHBhcnQgb2YNCnRoZSBzdG9yeSBpcyB0aGF0IHRob3NlIGlkcyBvbmx5IGNv
cnJlc3BvbmQgdG8gIlNBVEEwIiBhbmQgIlNBVEExIg0KaW5zdGFuY2VzIG9mIEFIQ0kgY29udHJv
bGxlcnMgaW4gIlJBSUQiIG1vZGUgb24gdGhvc2UgcGxhdGZvcm1zLiBZZXMsDQp0aGUgZXhhY3Qg
c2FtZSBoYXJkd2FyZSBkdXBsaWNhdGVkIGF0IGRpZmZlcmVudCBQQ0kgREVWRk5zIGhhcyBhDQpk
aWZmZXJlbnQgUENJIGRldmljZS1pZC4gV2h5PyBBcHBhcmVudGx5LCAkT1RIRVJfT1Mgd2FudGVk
IHBlcg0KY29udHJvbGxlciBpbnN0YW5jZSBpZGVudGlmaWNhdGlvbi4gSSBjYW4gb25seSBndWVz
cyB0byBhcHBseSBwZXINCmNvbnRyb2xsZXIgaWQgcXVpcmtzLiBIb3dldmVyLCBhbmQgdGhpcyBp
cyBhIHN1YnRsZSBkZXRhaWwsIHRoYXQNCmxlZ2FjeS1yZXF1aXJlbWVudCBvbmx5IGFwcGxpZXMg
dG8gdGhlIG5hdGl2ZSAiQUhDSSIgbW9kZSBjYXNlLiBJLmUuIGluDQpBSENJIG1vZGUsICRPVEhF
Ul9PUyBleHBlY3RzIHBlci1jb250cm9sbGVyIGlkcyBpbiBhZGRpdGlvbiB0byB0aGUNCmNsYXNz
IGNvZGUuIEZvciBSQUlEIG1vZGUsIHRoYXQgcGVyLWNvbnRyb2xsZXIgaWQgcG9saWN5IHdhcyBj
YXJyaWVkDQpvdmVyIG9uIHNlcnZlciBwbGF0Zm9ybXMsIGJ1dCB0aGF0IGFwcGVhcnMgdG8gYmUg
ZHVlIG9ubHkgdG8gaW5lcnRpYSwNCm5vdCBhIHJlcXVpcmVtZW50IHRoYXQgbWF0dGVycyBpbiBw
cmFjdGljZS4NCg0KU28gd2hhdCB0aGlzIHBhdGNoIGlzIGFjdHVhbGx5IGFza2luZyBpcyB0byBh
ZGQgYW5vdGhlciBnZW5lcmljIHNlcnZlcg0KY29udHJvbGxlciBSQUlELWlkIGJ1dCBmb3IgYSB0
aGlyZCBpbnN0YW5jZSBvZiBhDQogY29udHJvbGxlciBpbiBSQUlEIG1vZGUuIEkuZS4gc29tZXRo
aW5nIGxpa2UgdGhpcyBkaWZmOg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvYWhjaS5jIGIv
ZHJpdmVycy9hdGEvYWhjaS5jDQppbmRleCBhYjU4MTFlZjVhNTMuLjAzOWYzMjExZWRkYyAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvYXRhL2FoY2kuYw0KKysrIGIvZHJpdmVycy9hdGEvYWhjaS5jDQpA
QCAtMzI0LDcgKzMyNCw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBhaGNp
X3BjaV90YmxbXSA9IHsNCiAgICAgICAgeyBQQ0lfVkRFVklDRShJTlRFTCwgMHgxZDAyKSwgYm9h
cmRfYWhjaSB9LCAvKiBQQkcgQUhDSSAqLw0KICAgICAgICB7IFBDSV9WREVWSUNFKElOVEVMLCAw
eDFkMDQpLCBib2FyZF9haGNpIH0sIC8qIFBCRyBSQUlEICovDQogICAgICAgIHsgUENJX1ZERVZJ
Q0UoSU5URUwsIDB4MWQwNiksIGJvYXJkX2FoY2kgfSwgLyogUEJHIFJBSUQgKi8NCi0gICAgICAg
eyBQQ0lfVkRFVklDRShJTlRFTCwgMHgyODI2KSwgYm9hcmRfYWhjaSB9LCAvKiBQQkcvTGV3aXNi
dXJnIFJBSUQqLw0KICAgICAgICB7IFBDSV9WREVWSUNFKElOVEVMLCAweDIzMjMpLCBib2FyZF9h
aGNpIH0sIC8qIERIODl4eENDIEFIQ0kgKi8NCiAgICAgICAgeyBQQ0lfVkRFVklDRShJTlRFTCwg
MHgxZTAyKSwgYm9hcmRfYWhjaSB9LCAvKiBQYW50aGVyIFBvaW50IEFIQ0kgKi8NCiAgICAgICAg
eyBQQ0lfVkRFVklDRShJTlRFTCwgMHgxZTAzKSwgYm9hcmRfYWhjaV9tb2JpbGUgfSwgLyogUGFu
dGhlciBNIEFIQ0kgKi8NCkBAIC0zNjcsNyArMzY2LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBw
Y2lfZGV2aWNlX2lkIGFoY2lfcGNpX3RibFtdID0gew0KICAgICAgICB7IFBDSV9WREVWSUNFKElO
VEVMLCAweDFmM2UpLCBib2FyZF9haGNpX2F2biB9LCAvKiBBdm90b24gUkFJRCAqLw0KICAgICAg
ICB7IFBDSV9WREVWSUNFKElOVEVMLCAweDFmM2YpLCBib2FyZF9haGNpX2F2biB9LCAvKiBBdm90
b24gUkFJRCAqLw0KICAgICAgICB7IFBDSV9WREVWSUNFKElOVEVMLCAweDI4MjMpLCBib2FyZF9h
aGNpIH0sIC8qIFdlbGxzYnVyZy9MZXdpc2J1cmcgQUhDSSovDQotICAgICAgIHsgUENJX1ZERVZJ
Q0UoSU5URUwsIDB4MjgyNyksIGJvYXJkX2FoY2kgfSwgLyogV2VsbHNidXJnL0xld2lzYnVyZyBS
QUlEKi8NCisgICAgICAgeyBQQ0lfVkRFVklDRShJTlRFTCwgMHgyODI2KSwgYm9hcmRfYWhjaSB9
LCAvKiBTZXJ2ZXIgU0FUQTAgIlJBSUQiICovDQorICAgICAgIHsgUENJX1ZERVZJQ0UoSU5URUws
IDB4MjgyNyksIGJvYXJkX2FoY2kgfSwgLyogU2VydmVyIFNBVEExICJSQUlEIiAqLw0KKyAgICAg
ICB7IFBDSV9WREVWSUNFKElOVEVMLCAweDI4MmYpLCBib2FyZF9haGNpIH0sIC8qIFNlcnZlciBT
QVRBMiAiUkFJRCIgKi8NCiAgICAgICAgeyBQQ0lfVkRFVklDRShJTlRFTCwgMHg0M2Q0KSwgYm9h
cmRfYWhjaSB9LCAvKiBSb2NrZXQgTGFrZSBQQ0gtSCBSQUlEICovDQogICAgICAgIHsgUENJX1ZE
RVZJQ0UoSU5URUwsIDB4NDNkNSksIGJvYXJkX2FoY2kgfSwgLyogUm9ja2V0IExha2UgUENILUgg
UkFJRCAqLw0KICAgICAgICB7IFBDSV9WREVWSUNFKElOVEVMLCAweDQzZDYpLCBib2FyZF9haGNp
IH0sIC8qIFJvY2tldCBMYWtlIFBDSC1IIFJBSUQgKi8NCg0KSS5lLiBpZHMgdGhhdCBhcmUgY29t
cGF0aWJsZSBmcm9tIG9uZSBnZW5lcmF0aW9uIHRvIHRoZSBuZXh0Lg0KDQpXaGlsZSBpdCBpcyB0
b28gbGF0ZSB0byBpbnRlcmNlcHQgaGFyZHdhcmUgc2hpcHBpbmcgd2l0aCB0aGlzIG5ldyBTQVRB
Mg0KZ2VuZXJpYy1pZCwgdGhlIHB1cmVseSB0aGVvcmV0aWNhbCBmdXR1cmUgU0FUQTMrIGluc3Rh
bmNlcyBhcmUgb24NCm5vdGljZSB0byBhdm9pZCB0aGUgbmVlZCB0byBjb21lIGJhY2sgYW5kIHRv
dWNoIHRoaXMgZmlsZS4gSS5lLiBhbnkNCmFkZGl0aW9uYWwgY29udHJvbGxlcihzKSBjYW4ganVz
dCBiZSAweDI4MmYgZnJvbSBoZXJlIG9uIG91dC4uLiBmb3INCnNlcnZlciwgZm9yIGNsaWVudCBw
bGF0Zm9ybXMgd2hlcmUgdGhlcmUgaGFzIG5vdCBiZWVuIGEgY29tbWl0bWVudCB0byBhDQpzdGFi
bGUgIlJBSUQiIGlkLCB0aGUgcmVjb21tZW5kYXRpb24gY29udGludWVzIHRvIGJlIHN3aXRjaCB0
byBBSENJDQptb2RlIGluIHRoZSBCSU9TLg0KDQpJIGhvcGUgdGhpcyBpcyBzdWZmaWNpZW50IHRv
IGNsYXJpZnkgdGhhdCB0aGlzIFNBVEEyIGlkIHNob3VsZCBiZSB0aGUNCmxhc3QgdGltZSBhIG5l
dyBSQUlEIGlkIG5lZWRzIHRvIGJlIGFkZGVkIHRvIHRoaXMgZmlsZSwgc2F2ZSBmb3IgY2FzZXMN
CndoZXJlIGEgcXVpcmsgc2V0IGJleW9uZCBib2FyZF9haGNpIG5lZWRzIHRvIGJlIGFwcGxpZWQg
KHVubGlrZWx5KS4NCg==
