Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC7AC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 23:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbiCWXGM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbiCWXGM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 19:06:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27C8643A
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsKSGAS5YBY6bqb91mEx+pbZpEgQ1/jsIr3TW8dOhPO2AJzvDvaKJlyXr5wkC9cpvLVdSxxIdLGF2yHF8m489sCtmoZDDGY1v5KAE84lCYcRf4TjaQ8juwyVCRGqjualOY6KAlsb3JoSqm9JuWdU49MZhpBiwZSBjRPztuIrHtx3LWc5MJFVUhDdEMXDDYdrUwdKcsEZtzOBND4qnb2vqoo4dUEcJvczdCDzMiqNWHPyZKSus8JmkMOEFz1+YKkqOIKAGz+gcA6V9ORWMeAqGMg6YRfpZAhCUAJ75rySXfyfncsXnFyvNa/9e7ZgYzKJoz6azZIDuskToz3+dNQ7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ta2QK9+hfum2ZEu4GYk26VLb2do4QSDD7thq3U/ULUo=;
 b=DJysgZD2X6XB589eVeqpEtp0/OCvj2pQTDSleA1lkWCQfpow239BBIidC7yrfiwGLMrqTkrymLpleHEvQzSGOYOkTM1qMbAgtxBtfNB+DUKG9AemY13bXFY49jdmgWLSuo49RpQ7ikBI7+SDAP00gzE2RHllOWPYMbxnpllW6JdW+LEf3gNcZNeua2nk3qSgLkak1oUDs3IkRrzWr3CdG/VdShY8pJkGSqtZQ0Wb2yIBW2eDq64DvzqfwGuQqVvQxZWJUiHWOyXE6h3xSJkNOIXxKuT/xc/yCgPGKr40TGDsTh4NtroxV1k9qOs0zra8u7yGtsGHLzVX8R7Lx3gwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta2QK9+hfum2ZEu4GYk26VLb2do4QSDD7thq3U/ULUo=;
 b=OAxPdmK1oBVmkochRGKM+SBgB4SG9Gn0z6tCV2EePKG0qdMIl6EvKy9LhD5F4X+SFCWSnqUYkOtx1eZANp0uI7w+m0Dys67+LtPD0bYdR50XGg1hCfIGlW7yWz5fCs8CdSIgkEZXYYxAM6yhgLtyeN02vQrL+tDn+xOW4reEwSs=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB4784.namprd12.prod.outlook.com (2603:10b6:208:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 23:04:33 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 23:04:33 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: RE: [GIT PULL] ata changes for 5.18-rc1
Thread-Topic: [GIT PULL] ata changes for 5.18-rc1
Thread-Index: AQHYPwLVdjWJGZbYOkCcbPPdLLNBP6zNlW0g
Date:   Wed, 23 Mar 2022 23:04:33 +0000
Message-ID: <BL1PR12MB51576EE0517167FDC471AE8EE2189@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wgCt46XN2xuQO3Zj2UoeP472EpyWbrjsDPVZvDHW+rA2g@mail.gmail.com>
In-Reply-To: <CAHk-=wgCt46XN2xuQO3Zj2UoeP472EpyWbrjsDPVZvDHW+rA2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-23T23:00:12Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=bc70e147-3b76-46d4-8ac0-1612853c34a7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-23T23:04:30Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 12889ebf-d760-4be8-b2c2-c1d2626ef6f2
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a0e37b3-dca6-4c6b-7c1f-08da0d217e78
x-ms-traffictypediagnostic: MN2PR12MB4784:EE_
x-microsoft-antispam-prvs: <MN2PR12MB47841350D2B5C55F3AAB88D9E2189@MN2PR12MB4784.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xlFmyd/AAkzkNPMmMpJRpQT2yXAeQvpP4K2Z0xpgGCokudX0feIW2ZSKnaClSQy4/9Iu/dH95RXaw2PlH1Xm7NV0leKn9GHWCvM/Rm8/gqzZ2UmMnNhcFcSzNAftGjJSbvi16JIGgCFQMlGmTkEiMPeSvr9hUBr+Qt2LLuyKclVWl37f1G/vEKBCXH5oOfQAYbOnAzc1yxvv2OmIirdBS5ZINP1MNhKaP16lsJ5pJs7PEYh0xanE2JHQwsm5ZIt/UQHXhQHoVTuQVeF9scCIlPvzb6b3DJrZ5Lfe9r6AA9ItPHeqxBOh77sn2w9p3YNuIAL4CtxWOIA1SerxfG8MsPY/kDn98wEju8FCWDpuSy5WXUfpyyFK26qnUQGh2c1TpmXWoGgJGUgOR+IHOGTbmJO9PJZgq+OLlfkB+CvC2Yw0DalAFXDgG8KJcVAaVcgsNZUiGn31vj0Dx22L90cgnRR2TJ49GIps4tRYN+V+PrhaRI8BDaHpnooAnamsswYfTxrNo4xkaGD2dsyqqjLGLXg6k8qsAnMf30M7fkTAH0cpVcyHLsZZEFJo6Ue0GGRmEkr/R6s5+bCGUpdM8K+Og74Xz2HQ2PLljxTVNUHwG7ZiVfotObUq0QEJoKpm07dCcbf0ONZ3+7c5PDtrCHZ1TveDPomldhHxDfpiipdaClI5qOOODLWfN1JIcLymp7V1/rwrylRBARZ+P/3QwjwAUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(110136005)(38070700005)(53546011)(508600001)(316002)(186003)(83380400001)(55016003)(5660300002)(6506007)(71200400001)(8936002)(4326008)(122000001)(52536014)(76116006)(66946007)(66556008)(7696005)(66446008)(8676002)(33656002)(9686003)(66476007)(64756008)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elhDWm1qb09qdVBqUFZ6ZDdBT0YzQ1daYXhBdmM1QjViWHB5U0V4OGZTUUw0?=
 =?utf-8?B?QW1UVHRuQnBSaTdRaFhFODVNUGl0dWhFYjA2aDFGMjNuT24xMGlCeGtNY2Jz?=
 =?utf-8?B?OFpEVGtSRDByVUJjeC9VTVM5ZDN1UTk5VlR5YUl6Y3c0REE4S2lBNnU2bHdh?=
 =?utf-8?B?QWNtM0xkVUhxWFp5OW5OUmM2eStyWVEvcGp3VVRqYTAyMTNGUlZZeDh3WjNr?=
 =?utf-8?B?eWJSMm5VcC9TRTg2YTEyVzExb1BuMGw2RUxweVJQL1hBbFVVdWpPbldKMjZw?=
 =?utf-8?B?L2hOOWJWWEJWRnhTZ1hzRGVUY3dQa1VncEtNS2lYQzQwRm5lKytaaWlYZm9G?=
 =?utf-8?B?WWdlb1RoQ3RRNkhzdWRIRVdWSDdaY0pPbFpwTlNqRFFFV0c1QlcyeCs2d0s1?=
 =?utf-8?B?RzlKMU0reUQ5anFPN3lYbWc4OXk5SCtZQm9rZ3hLNzlEeUFtcUVJTVpGT3Qz?=
 =?utf-8?B?dDdmcFJGeVVaLzNTYmNXeXpSVjVVeHFsbmY1WVJLcVBEdmp3UUwwVmZvMlZN?=
 =?utf-8?B?U2pMazM0eFhnMloreWtsQlowWHFtamZ0WW4rT0hYNnZycE9IZW1qNWN6eDMv?=
 =?utf-8?B?dkxaMW41MjlSdndaZGhPQmxyMUxDM3Rhc1REODRNWlZEcU1PbmlJbCsyZkhj?=
 =?utf-8?B?cXA5c3REODQxVTBTbU55TzFHWEV0YWlxQnhFbVZCelVGY1prdEYvdzBkY0Ex?=
 =?utf-8?B?YjZhYUFJU3hFWExDUEpxMUFCWnRobEx3bXdad0pyV29UUmc3NnBoWXU3N3FE?=
 =?utf-8?B?b1hKSmo3djVma0poeFJ1VGcvVENUVG1OcWg0bVEvZ3RmdENCN1lRc0lsY01V?=
 =?utf-8?B?V1cvblcvRE5rMVhtRmQ1bGR4bS9CSStxTzRjRlljakF4aUZsbjlXOWdQUjZS?=
 =?utf-8?B?d3BQT2p3dnhCSzVQcmhFV0l6eUlGVm4yQkt0QmNndTBuZkR3SndxS1RRRExJ?=
 =?utf-8?B?VGF0cVdJalM3dUtac3czSDBTZmd4Sk42aHlZUlU5aG1CVVZCSGRzK0VtUS91?=
 =?utf-8?B?S3pMVHV4TndzSWo0MVBZbWc0ci80TmZmTHFTZWpBcUIrNnpYQ1ZQY3h3Nm1Q?=
 =?utf-8?B?Qi9CdkkwalluMXkvRWtoYXpBelNGem1wNktRbEdTQzdUTGh3Q2V6QzF3T3NF?=
 =?utf-8?B?Ky9HdlVaeE1IbUNEbDdONVh4TUFyZkhUeEtoOGFPMU8ybWFtYmZQTzdHNnRG?=
 =?utf-8?B?TDBZSUZRUmRTRjhHQk5PU2c1cnRXZ3l6YVJRM0tZdVBCVmVTOEc2WFMyZ01y?=
 =?utf-8?B?Q1hvQmo3ZXNJTzR4SzJEdmxkMVN0YjQ3SldyUGx2NEZGemlwSUUvZ0FPWi90?=
 =?utf-8?B?Uy84a0JsNitDNE9aRDV2S2VvYVIyQmQzWHpGcjJOZ0RnVmhjdzR3SmtEbWk1?=
 =?utf-8?B?RHNzQmtQSjU3eDdzQzdza2JFYmVJMFBTQ1IwVE81V3U3dUFKY3gwZkhxWURl?=
 =?utf-8?B?anYxTUw5S2JWMFU2K3hyNGJvaTQ2TGhTZXpUVHlPY1gzRXFaSVR6bFpYdVZ2?=
 =?utf-8?B?K1ptTGZBL3g4R3JrL0k0RHJuQjgzWnZMazZHemlkOE80VlpVQ1ZDZmk1SlVv?=
 =?utf-8?B?UU9JNnk4NTNuYjQvVVhTSzg0b2oxaVJ2bkRScGprNnpFL2JpWWMxYVhQam9u?=
 =?utf-8?B?SDVhSThINkZUcWdhbFo5VXQ1TzJDdXRFNVVoeUFsbVlSVGZUS2dibjJKNlRm?=
 =?utf-8?B?bGFsdER4bVAxdHl3SGxzVTNQdWZmdCtiZVZCRHdiN2FhdExqY0JZMnc1NFNS?=
 =?utf-8?B?cm8vNFN1UUtsRnhFaGRHQ2NGdUFENzZxWGlxd0RjY1ZNd3JuMUNXV3FhS0E2?=
 =?utf-8?B?Zm83dnh3ZnRsb3BrUG80TXR0UjlmRkhXSkhQZlE0QkhVTThWc011QzdIa3Ur?=
 =?utf-8?B?WlJkSDh0NkFXMGlNTmRQNHppdjF6bmRPMHY4S0t4QkI4eTdFd0c0dElpME9G?=
 =?utf-8?B?bEdtbWU1cUxEeVlEOVJHOVdrVHlpc2M5SDFhTTVXbzFkVFZpQ0JoNmFLZzA2?=
 =?utf-8?B?a2wyV2FJci9vYm5LKytmcWUxZmtMQWNrYUtGcVMyaDZkTFlEcWVPb3BkdXNt?=
 =?utf-8?Q?JtmHsS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0e37b3-dca6-4c6b-7c1f-08da0d217e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 23:04:33.1401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQJFh5SuTvKR0K2hoCzMvx6/378cWDcbibQgKIerGaEkwrd7tPNZK00REOOZ6wOa+TPduRzRkzHlY8jxO0t69w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4784
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

W1B1YmxpY10NCg0KPiBPbiBNb24sIE1hciAyMSwgMjAyMiBhdCAxMTo1NyBQTSBEYW1pZW4gTGUg
TW9hbA0KPiA8ZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5jb20+IHdyb3RlOg0KPiA+DQo+
ID4gKiBSZW5hbWUgYWhjaV9ib2FyZF9tb2JpbGUgdG8gYm9hcmRfYWhjaV9sb3dfcG93ZXIgdG8g
YmUgbW9yZQ0KPiBkZXNjcmlwdGl2ZQ0KPiA+ICAgb2YgdGhlIGZlYXR1cmUgYXMgdGhhdCBpcyBh
bHNvIHVzZWQgb24gUEMgYW5kIHNlcnZlciBBSENJIGFkYXB0ZXJzLA0KPiA+ICAgZnJvbSBNYXJp
by4NCj4gPg0KPiA+IE1hcmlvIExpbW9uY2llbGxvICgzKToNCj4gPiAgICAgICBhdGE6IGFoY2k6
IFJlbmFtZSBib2FyZF9haGNpX21vYmlsZQ0KPiA+ICAgICAgIGF0YTogYWhjaTogUmVuYW1lIGBB
SENJX0hGTEFHX0lTX01PQklMRWANCj4gPiAgICAgICBhdGE6IGFoY2k6IFJlbmFtZSBDT05GSUdf
U0FUQV9MUE1fTU9CSUxFX1BPTElDWSBjb25maWd1cmF0aW9uIGl0ZW0NCj4gDQo+IFNvIEkndmUg
cHVsbGVkIHRoaXMsIGJ1dCBpdCdzIHdvcnRoIG5vdGluZyB0aGF0IHBhcnRpY3VsYXJseSByZW5h
bWluZw0KPiB0aGF0IENPTkZJRyBvcHRpb24gd2FzIHByb2JhYmx5IG5vdCBhIGdvb2QgaWRlYS4N
Cj4gDQo+IFdoeT8NCj4gDQo+IEJlY2F1c2UgaXQgbWVhbnMgdGhhdCBwZW9wbGUgc2lsZW50bHkg
bG9zZSB0aGVpciBvbGQgdmFsdWVzLiBBbmQgaXQgaGFzIHRoYXQNCj4gDQo+ICAgICAgICAgcmFu
Z2UgMCA0DQo+ICAgICAgICAgZGVmYXVsdCAwDQo+IA0KPiB3aXRoIDQgYmVpbmcgZXhwbGljaXRs
eSBtYXJrZWQgYXMgdmVyeSBkYW5nZXJvdXMgLSBidXQgYXQgbGVhc3QgRmVkb3JhDQo+IHNlZW1z
IHRvIGFjdHVhbGx5IGhhdmUgYSBkZWZhdWx0IG9mIDMgaW4gdGhlaXIga2VybmVsczoNCj4gDQo+
ICAgL2Jvb3QvY29uZmlnLTUuMTYuMTMtMjAwLmZjMzUueDg2XzY0Og0KPiAgICAgICAgIENPTkZJ
R19TQVRBX01PQklMRV9MUE1fUE9MSUNZPTMNCj4gDQo+IHNvIHRoYXQgImRlZmF1bHQgMCIgbWF5
IGFjdHVhbGx5IG5vdCBiZSB0aGUgcmlnaHQgb25lLg0KPiANCj4gTm93LCB3ZSdyZSBhdCB0aGUg
cG9pbnQgd2hlcmUgZmV3IGVub3VnaCBwZW9wbGUgbGlrZWx5IGNhcmUgYWJvdXQgQVRBLA0KPiBi
dXQgdGhlIGNvcm9sbGFyeSB0byB0aGF0IGlzIGFsc28gdGhhdCB0aGVzZSBraW5kcyBvZiBjaGFu
Z2VzIGNhbg0KPiBjYXVzZSB1c2VyIHBhaW4gdGhhdCB0aGVuIGRldmVsb3BlcnMgaGF2ZSAqbm8q
IGlkZWEgYWJvdXQuDQo+IFBhcnRpY3VsYXJseSB3aGVuIHRoZSBwYWluIGVuZHMgdXAgYmVpbmcg
Y2F1c2VkIGJ5IHNvbWUgc3VidGxlIGRlZmF1bHQNCj4gY29uZmlnIG9wdGlvbiBzaWxlbnRseSBj
aGFuZ2luZyB0aGF0IG5vYm9keSBldmVuIHRob3VnaHQgYWJvdXQuDQo+IA0KPiBOb3csIHRoYXQg
ImRlZmF1bHQgMCIgaXMgcHJvYmFibHkgdGhlIG9ubHkgc2FmZSBkZWZhdWx0IC0gYW5kIEkgZG9u
J3QNCj4gZGlzcHV0ZSB0aGF0IHBhcnQuIEJ1dCBJIGFsc28gc3VzcGVjdCB0aGF0IEZlZG9yYSBj
aG9zZSB0aGF0IHZhbHVlICczJw0KPiBiZWNhdXNlIGl0IHByb2JhYmx5IG1ha2VzIGEgbm90aWNl
YWJsZSBwb3dlciB1c2UgZGlmZmVyZW5jZSBvbiBhdA0KPiBsZWFzdCBzb21lIHBsYXRmb3Jtcy4N
Cj4gDQo+IEkgZG9uJ3Qga25vdy4gQnV0IEkgZG91YnQgcmVhbGx5ICphbnlib2R5KiBrbm93cywg
c28gcmVuYW1pbmcgdGhlbSBhbmQNCj4gc2lsZW50bHkgbGlrZWx5IGNoYW5naW5nIGNvbmZpZyBv
cHRpb25zIGZvciBzb21lIGxlc3MtdGhhbi1jcml0aWNhbA0KPiByZWFzb24gaXMganVzdCBub3Qg
YSBncmVhdCBpZGVhLg0KPiANCj4gICAgICAgICAgICAgICAgIExpbnVzDQoNClRoYW5rcyBmb3Ig
cG9pbnRpbmcgb3V0IHRoZSBzdWJ0bGV0eSBvZiByZW5hbWluZyBhIGNvbmZpZ3VyYXRpb24gb3B0
aW9uIGhpZGVzDQpwcm9ibGVtcyBiZWNhdXNlIHBlb3BsZSBkb24ndCBzZWUgdGhlIG5ldyBjb25m
aWcgb3B0aW9uIGFuZCBwaWNrIHRoZSBkZWZhdWx0Lg0KSSB3b3VsZG4ndCBjYWxsIHRoaXMgY29u
ZmlndXJhdGlvbiBvcHRpb24gcmVuYW1lIGNyaXRpY2FsLCBzbyBpZiB5b3UgY2hvc2UgdG8gcmV2
ZXJ0DQppdCBJIHdvdWxkIHVuZGVyc3RhbmQuDQoNCkhvd2V2ZXIgSSB0aGluayB5b3UgcmFpc2Ug
YSBnb29kIHBvaW50IHRoYXQgaWYgZGlzdHJvcyBhcmUgcGlja2luZyBkaWZmZXJlbnQgImRlZmF1
bHQiDQp2YWx1ZXMgYW5kIGtlZXBpbmcgdGhlbSB0aGVyZSBhIGxvbmcgdGltZSB0aGF0IHRoZSB2
YWx1ZSBpbiB0aGUgdXBzdHJlYW0ga2VybmVsDQppcyBwcm9iYWJseSBub3QgcmlnaHQgYW55bW9y
ZS4gIEEgd2hpbGUgYmFjayB0aGF0IGRlZmF1bHQgbWFkZSBzZW5zZSBiZWNhdXNlIGFsbCB0aGUN
CnBvd2VyIHNhdmluZyBzdHVmZiB3YXMgcmlza3kgYXQgdGhlIHRpbWUuICBJdCdzIHByZXR0eSB3
ZWxsIGJha2VkIG5vdy4NCg0KU28gbWF5YmUgYSBsb2dpY2FsIHRoaW5nIGlzIHRvIGtlZXAgdGhp
cyBjaGFuZ2UgYW5kIHNlbmQgYSBmb2xsb3cgdXAgdGhhdCBhbHNvIGNoYW5nZXMNCnRoZSBkZWZh
dWx0IHRvIDM/ICBJZiB5b3UncmUgc3VwcG9ydGl2ZSBvZiB0aGF0IEknbGwgc2VuZCBzb21ldGhp
bmcgdG8gRGFtaWVuIHRvIGRvIHRoYXQuDQo=
