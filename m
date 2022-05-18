Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8C1C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 18 May 2022 21:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbiERVbj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 18 May 2022 17:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243183AbiERVbi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 18 May 2022 17:31:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FD38A328
        for <linux-ide@vger.kernel.org>; Wed, 18 May 2022 14:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwNVKDKGHXKYhtlFuFnlS5xHDd4BeDRcHqOHtjovqhO2ZBXKvK6RpDyO8qwC6KPfbqR4w/Kd4DixNY1JbhSURhO8Or9DZrdGdtwTvpw8viaLpQpVyaH8O7scw9esROTwtMqZAaKkfgq4tW/Lfpi9M/fwCiohX9Kh7GpH8lKIKBteo2Hg60izsSVj1V0g35PTnf9gROnHKgDMb18DykBgrw0NzmHES3W+y599/xS5Y4ir7w6n7VKE3Fy9cXRR9fO+esnaEvsFUvIFCx7e5ECOMk2TOPE8JyTqwEyTVZ/2b9n4yVwtyMsasOP6jGc+CleqgP+j5of/qiJcwjap4+eynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCfLj7K8nSJtmZSCA0Nj+T2wKzxrvl79spIKiXC+gzM=;
 b=AEoDZjVD1JHpuhhcw3X0NoJMbnlWgYLEveFX/VX+740gdMlN0BDe8SrOwwleosUdOocoZz+c4eJx/b+V9lUtWcjTGGpvOVj0BKnWrjot1hxEzp1xkA7f442kCFTMVu3ro2llV5TF6m9yHJ6zFCQeiNmRcDT4G5BK/HxzN4Rzm32vPnP1PT44X9g6R1gD+A1CHkATnSH/eyNTbewEpmxi7d0b/ju6N/C2rE9qek2bTVRHUTOiOPsJeD/q12oOTqEY22/XA8vwlN5ka05xzr18lo2zMeWW7wOrdh9+U1fT4665VPenatcIgb4XLGcRhbc5s4Gfa0rO6hslcfRYPAsy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCfLj7K8nSJtmZSCA0Nj+T2wKzxrvl79spIKiXC+gzM=;
 b=TfyQ+m31Z5igWS62e9HGEbEM9SKbRd2hFefMY5zxi8WixqA4KyKcnKfr72i+dZsXOZQUPCOPXeJWV7tNhWpUuPNrDmVh46sk0yBy1VUtitC5UxiW2Y9DBb+X9vSUXcoVkYpiWXdywtGoep4jy/6YjOf5I3Aed4bCThXDztvdASc=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN6PR12MB1556.namprd12.prod.outlook.com (2603:10b6:405:4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 18 May
 2022 21:31:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d42b:7413:ba19:e8db]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d42b:7413:ba19:e8db%6]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 21:31:32 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Runa Guo-oc <RunaGuo-oc@zhaoxin.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Cobe Chen <CobeChen@zhaoxin.com>, Tim Guo <TimGuo@zhaoxin.com>,
        TonyW Wang <TonyWWang@zhaoxin.com>,
        Leo Liu <LeoLiu@zhaoxin.com>
Subject: RE: [PATCH 1/2] ahci: Add PhyRdy Change control on actual LPM
 capability
Thread-Topic: [PATCH 1/2] ahci: Add PhyRdy Change control on actual LPM
 capability
Thread-Index: AQHYVWwK1dB2Si1r/UiDFkOPPcfS06z7s92AgADUbgCABw1AgIAICh+AgAd/8YCABlPcgIAL3SnA
Date:   Wed, 18 May 2022 21:31:32 +0000
Message-ID: <MN0PR12MB6101E0E6E03333955C20AD2EE2D19@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <1650534217-14052-1-git-send-email-RunaGuo-oc@zhaoxin.com>
 <1650534217-14052-2-git-send-email-RunaGuo-oc@zhaoxin.com>
 <244f0c98-13f4-1ac4-9ebe-facdad4ae8b6@opensource.wdc.com>
 <af0571fe-a8f4-cb0a-323f-4dc0c4e7517d@zhaoxin.com>
 <ffc33fd4-a676-167d-ec2c-18e8211f2858@opensource.wdc.com>
 <349b0922-7efd-99e9-7bc8-b18ed98d94f8@zhaoxin.com>
 <e0213b8b-daea-7e75-793c-50f39956f932@opensource.wdc.com>
 <4824f9b5-92c1-a53b-2174-1d096e723e13@zhaoxin.com>
 <c5462af9-eddc-5b39-253f-680f57aacc09@opensource.wdc.com>
In-Reply-To: <c5462af9-eddc-5b39-253f-680f57aacc09@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-18T21:31:29Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0c2a1091-18af-4970-887c-1ac45e5739a2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-05-18T21:31:31Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3b6801c9-c406-447c-8837-7d85825a5122
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f582bf30-1b89-4d67-9672-08da3915c74d
x-ms-traffictypediagnostic: BN6PR12MB1556:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1556C969DC5D24DD4D4CA0E3E2D19@BN6PR12MB1556.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6mu5s9Nhw1IC3zlGmlAlJ31XcUuXg6fCcIgAAmbPe3Z1P6NEOkB2j67ehbTY5jlazIrUovl7ajfe5HK6894V37Rsz7MqZGPXGbRaSdBmvKVRRwBEkIbhG6552iERFMUMfAtstwyJtNzeOzJqIPJO38zlxEOz9NQvXvkod+F2USjShM4o6xYCkh+uLbHPYyexpcpXU6uk3yAP7CbWCSokPef7a8PlTTqLLDaMOc5Woso5u+D+/VFI12cSh1QSRmRdoPTRV4k05jdhTkudHS+w2/tl5WQKkRJcjmpUWDXr4DkS811d+4wOkd5UnGrZ6y7dBSdlwu82wChkxsIl5eiJsrR3VdvNV65ZkK3iF2eskKTNLfG64ko+HhcijbCQU7DSVGss704R+Y8uaXwTkpoUlFgf6IOC2N/dkS2FSB1SSQTn6pjLMg4wWnkTUDdTj9/xGcWDkvzdGw40VoCn4JpSVaGSJ1SJAgC4iEtboKRpSolHgzaD4D8lx/gR+2I/w8HmeukJK9DEQn8AFBWxpOh/VLRl8LfOlMZ2ET1PSH2oA43l2O3U4xsVMFynFKjm6JnMagE6Kk5DqFq/t3e33EugfUOzH6iZ/5uAXcnkPnSRlpWIpDom8rJP/Vn0g03NBTemL2aEtPF4zE5tTqt6K0bu1umYr7Yg3G7t7nqd+OePnx6Cd74QMk2NUHD0ac/TjHw6ZqLup5tWi2dYOxHZ6Tz3cGAASNcHCa7I/dWi/e1zwatxiVdQ/Yyxdqb4xzKq+N9eqy4JLKeogzsgUeE9YsSSj1GnR4II4IuzUmJAJuDJgpQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(8936002)(122000001)(508600001)(9686003)(5660300002)(316002)(966005)(38100700002)(38070700005)(86362001)(71200400001)(186003)(45080400002)(110136005)(33656002)(2906002)(8676002)(66946007)(66446008)(53546011)(6506007)(64756008)(76116006)(55016003)(66556008)(66476007)(83380400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vnSJ9uvJKcOYTTSVYJjWB4gwCzXv0QYB7DtwM31DRC/ePfIAfcLoiWfOX9?=
 =?iso-8859-1?Q?G9SS+1bPu/Jt5dktLvVkgFYqpYZK1f3DD4TbEaBmLNZFCvUnMyOXvk7rcH?=
 =?iso-8859-1?Q?16kIgDaDDXhm2XzB76JfS8LUav00MniAH97yfDPxFI9dKxqrCxHuYuDI3r?=
 =?iso-8859-1?Q?IWVAc/P8qLf4H5ammFQrHbjaWCal7OFrsp41eS2jrbI27bVRryQyy9Iv+l?=
 =?iso-8859-1?Q?6MOQ4zr89tsJhh5rhYDNB7nkX0/mSZgaxxTwjOYwMKbEEbxovLKYgtjThy?=
 =?iso-8859-1?Q?axOM4joYiK5TETQRISjFp1aZT7QZLCCh2KTN6qAicJpHyGlDwnAU8QmlGC?=
 =?iso-8859-1?Q?dx73RNIYmprdHo5ikb9/+rsEyS+8SgCGLQ+2CVPVAnoBDe0rTxwmqLqvvw?=
 =?iso-8859-1?Q?U914z04ng95G/qlsBdyLAjT5VMocAUy5f7WBh9nP2XFWO1wVX6W6SW7TnR?=
 =?iso-8859-1?Q?HxjfICSuRRITZsv/ehtG2j1uBVMnA/5djOivw8N0Rz+ECb3On6mgFhblSj?=
 =?iso-8859-1?Q?Xtjzvtt8jR5z51HV169vsnRtnzU1hzYcY7PorGzUhuCZ5D7kpKFOlD5gtv?=
 =?iso-8859-1?Q?/bfhyNR+Vwzd2RmocB1vDNb5R+G4azvhXDomYznbM1SkTK3sR5zr7DA24q?=
 =?iso-8859-1?Q?rAbTt1+vgh87nFmGwJUi1YPS3BfQ0pLrfwG6HgygSu9QTde91yToYOdwfq?=
 =?iso-8859-1?Q?6AZC1HAuZuzuiKVl8HEfMggfchrC2gcNpe3t5rgr/wJqHS6gNgnukgjEAQ?=
 =?iso-8859-1?Q?nxsuRh3tZe+ByrkU6Cs9gApyjeYMQ8aqN6XAvsy5Z4bdmUvnvmmqZ8pQD1?=
 =?iso-8859-1?Q?T1VORWypfIQf5jA3xxEYtUV5WbvQ7SJT5fGyhJS9jOv/vy+w6fOyDhNcBG?=
 =?iso-8859-1?Q?TNw5YsqRBAGNBRNA5Nowz8YeCrZIWEEqMZLGSilfwqyYVVu4BXPlu7qHkc?=
 =?iso-8859-1?Q?ve0wq4P5ISalGu568p/glECvj49Dl35H2E4pOO3pO8MdrKUizICH6iAUrs?=
 =?iso-8859-1?Q?gTtg3fVRUnIg4TuHKrzEEpALUUU2IZZL67SEyfh+FWc29UKf4ED9ZJtmlg?=
 =?iso-8859-1?Q?OgjQxnDJYEYx03S0mTOjVh32u6F1uJDfIPziyJy/Ye8V0MYMMGbUjCsNop?=
 =?iso-8859-1?Q?Obw2e1QzTJUKjI/s7GM8rF8U82MWBWiHh9HNqQ6rRQXHMKDmknA3TACNW8?=
 =?iso-8859-1?Q?NlU/qFAYZ6QzsSE0Qg/F+4wVeifwkaMWsGA+lUpIlusSf62ZXUYOICCfvg?=
 =?iso-8859-1?Q?Sf9iQMHzNmX09LPjCs5iObUqh0Wrlm7v1tGKtvxmUsTO+JzqtodxeyK6Ik?=
 =?iso-8859-1?Q?FaEUedK9kHYPzM743H4mkQ49yB4b50YWIY5Ufdd7oyM8AZFfTMU8KNzN5m?=
 =?iso-8859-1?Q?bmPI94u83zTwCq9yB+X8dMsDd9nOIRdGjr5EayqMf3lcvHEExvm3EpuQ9q?=
 =?iso-8859-1?Q?86XksmCpB9qY3o2Fw0RGGuFFXi5+/YI9tdBvccETlLMIi6tP4elxsSfWfW?=
 =?iso-8859-1?Q?pUprlghNhs+Jo5dSepKCxTUZ0rpzx6uYFPhwAyw6WLCZ2sI8zDSFNgwd83?=
 =?iso-8859-1?Q?ggxaYTTKleAHmofGdWXsVSk+3vI7IMDKHShC1VCk0f653tpI5iFKsGRBaO?=
 =?iso-8859-1?Q?DXoiaFGfqTEeUkSo8rSi/yhqq40WODxa+2SQYZwVz8+AqwShHJw2VJzyQl?=
 =?iso-8859-1?Q?0zdRyZjUr16TUlXLD/qCG+sx3J7kDjlxl163GEnjUWYj+n302lxQref1Px?=
 =?iso-8859-1?Q?SCTBMIeCV5Ww1r7hHV+Rb5qAVYKqRG7XKGgzs8bxpfUaK2WTxIu6OH6Fun?=
 =?iso-8859-1?Q?yxAkSh/ebOPnB/QgD8lkas+x9gdIstpropRQK3x+NzxuffXg/4yZIfEyoD?=
 =?iso-8859-1?Q?hw?=
x-ms-exchange-antispam-messagedata-1: 38jxnxySKV+83w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f582bf30-1b89-4d67-9672-08da3915c74d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 21:31:32.6725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhy8KpNipITC9se43PSI+zCfpIJM50qTa9BLaF0gJSXgycgjuX/KmTah+gjCqj+w8LSPXirXoa3EsP67rdLSPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1556
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

[Public]



> -----Original Message-----
> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Sent: Wednesday, May 11, 2022 03:15
> To: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>; linux-ide@vger.kernel.org;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Cobe Chen
> <CobeChen@zhaoxin.com>; Tim Guo <TimGuo@zhaoxin.com>; TonyW
> Wang <TonyWWang@zhaoxin.com>; Leo Liu <LeoLiu@zhaoxin.com>
> Subject: Re: [PATCH 1/2] ahci: Add PhyRdy Change control on actual LPM
> capability
>=20
> On 2022/05/07 9:36, Runa Guo-oc wrote:
> > On 2022/5/2 21:05, Damien Le Moal wrote:
> >> On 2022/04/27 19:18, Runa Guo-oc wrote:
> >>> On 2022/4/23 6:37, Damien Le Moal wrote:
> >>>> On 4/22/22 18:57, RunaGuo-oc wrote:
> >>>>> On 2022/4/21 18:39, Damien Le Moal wrote:
> >>>>>> On 4/21/22 18:43, Runa Guo-oc wrote:
> >>>>>>> On some platform, when OS enables LPM by default (eg,
> min_power),
> >>>>>>> then, PhyRdy Change cannot be detected if ahci supports no LPM.
> >>>>>> Do you mean "...if the ahci adapter does not support LPM." ?
> >>>>> Yes.
> >>>>>
> >>>>>> If that is what you mean, then min_power should not be set.
> >>>>> Yes, I agree with you. But, as we know, link_power_management
> >>>>> is a user policy which can be modified, if some users are not
> >>>>> familiar with ahci spec, then the above case may happen.
> >>>> Users should *never* need to be aware of the HW specs and what can
> or
> >>>> cannot be done with a particular adapter/drive. User actions trying =
to
> >>>> enable an unsupported feature should be failed, always.
> >>>>
> >>>> In your case though, quickly checking the AHCI specs, the scontrol
> >>>> register bits you change seem to be for preventing *device* initiate=
d
> >>>> power mode transitions, not user/host initiated operations. Your
> commit
> >>>> message should clearly mention that. But I still need to spend more
> time
> >>>> re-reading the specs to confirm. Will do that next week.
> >>>>
> >>>> Since you added the CAP flags, these flags should be used to detect
> low
> >>>> power policies that can be allowed for user actions.
> >>>>
> >>>> Mario,
> >>>>
> >>>> Please rebase and repost your patches ! I rebased the for-5.19 branc=
h
> on
> >>>> rc3 to have the LPM config name revert. We need to fix this LPM mess
> :)
> >>>>
> >>>>>>     Mario has patches to fix that.
> >>>>>
> >>>>> Hmm. How to patch this case ?
> >>>> Mario's patches modify the beginning of the sata_link_scr_lpm()
> function
> >>>> to prevent setting an LPM policy that the adapter/drive does not
> support.
> >>>> This together with the correct bits set/reset in the scr register wi=
ll
> >>>> only allow LPM transitions that are supported.
> >>>>
> >>>> It may also be good to revisit ata_scsi_lpm_store() to prevent the u=
ser
> >>>> from setting an unsupported policy. Currently, that uselessly trigge=
rs an
> >>>> EH sequence.
> >>> To avoid some confusion in this patch set, I want to explain it here.
> >>> The patch set involves two LPM related issues, one for the ahci adapt=
er
> >>> does not support LPM (no partial & slumber & devslp), the other for
> >>> ahci adapter supports part of LPM(eg, only partial, no slumber & devs=
lp).
> >>>
> >>> The former case is what I metioned in this mail thread. Namely, when
> LPM is
> >>> enabled, actions trying to enable this unsupported feature will be fa=
iled,
> >>> but will disable PORT_IRQ_PHYRDY bit at the beginning of the
> ahci_set_lpm()
> >>> function, which would make PhyRdy Changed cannot be detected. So I
> add flags
> >>> in the ata_eh_set_lpm() function which will not go to the disable
> operation.
> >>>
> >>> The latter case is what I metioned in "PATCH[2/2]". Namely, if the ah=
ci
> >>> adapter only supports partial (no slumber & devslp), then when LPM is
> enabled
> >>> (eg, min_power), *device* initiated power mode transitions will be
> enabled
> >>> with the scontrol register bits setting to indicate no restrictions o=
n LPM
> >>> transitions. After that, if SSD/HDD sends a DIPM slumber request, it
> cannot
> >>> be disallowed by ahci adpter for driver not setting scontrol register=
 bits
> >>> properly. So I add flags to control it.
> >>>
> >>> Therefore, Mario's patches in the sata_link_scr_lpm() function may fi=
x
> the
> >>> issue in "PATCH[2/2]".
> >>>
> >>> Revisit ata_scsi_lpm_store() to prevent the user from setting an
> unsupported
> >>> policy may be a way to fix the issue in "PATCH[1/2]", but there may b=
e
> another
> >>> case where some operating system manufacturers setting LPM default
> enable in
> >>> driver, like the following code in the ahci_init_one() function, also=
 need
> to
> >>> control.
> >>>
> >>> 	if (ap->flags & ATA_FLAG_EM)
> >>> 		ap->em_message_type =3D hpriv->em_msg_type;
> >>>
> >>> +=A0=A0=A0=A0=A0=A0=A0 ap->target_lpm_policy =3D ATA_LPM_MIN_POWER;
> >> This one looks wrong. This is set inside ahci_update_initial_lpm_polic=
y()
> >> according to the default kernel config
> (CONFIG_SATA_MOBILE_LPM_POLICY) and
> >> module param + what the drive can do according to ACPI. The problem
> though is
> >> that the adapter capabilities are not checked in that function, so the=
 initial
> >> target lpm policy may be wrong.
> >>
> >> Since your patch 1/2 adds the hpriv flags indicating the capabilities,=
 you
> need
> >> to use these in ahci_update_initial_lpm_policy() to validate whatever
> initial
> >> policy is asked for by the user.
> >
> > Yes, the above code is not rigorous, existing methods provided by kerne=
l as
> you
> > said should be used in this case.
> >
> > In order to use CAP flags to validate user policy, I review the latest =
kernel
> > LPM policies, here is my understanding:
> > ATA_LPM_UNKNOWN: default policy, no LPM
> > ATA_LPM_MAX_POWER: disable LPM (hipm & dipm)
> > ATA_LPM_MED_POWER: enable hipm partial
> > ATA_LPM_MED_POWER_WITH_DIPM: enable hipm partial &dipm partial
> &slumber
> > ATA_LPM_MIN_POWER_WITH_PARTIAL: enable hipm partial &dipm
> partial&slumber&devslp
> > ATA_LPM_MIN_POWER: enable hipm slumber &dipm partial &slumber
> &devslp
> > hipm: adpter initiated power mode transitions;
> > dipm:*device* initiated power mode transitions;
> >
> >  From my comprehension, user policy in [ATA_LPM_MED_POWER,
> ATA_LPM_MIN_POWER]
> > need to be validated on adapter's capabilities (partial(y/n), slumber(y=
/n),
> > devslp(y/n)), so, there exits the following cases:
>=20
> Note that devslp is a device side feature too. See ata_dev_config_devslp(=
) in
> libata-core.c. So even if the adapter supports devslp, if the drive does =
not,
> devslp should not be enabled on the port.
>=20
> > 1, (n, n, n), validate=A0 it to ATA_LPM_UNKNOWN;
> > 2, (n, n, y), validate=A0 it
> to=A0 ATA_LPM_MIN_POWER_WITH_PARTIAL/ATA_LPM_MIN_POWER?
> > 3, (n, y, n), validate=A0 it to ATA_LPM_MIN_POWER;
> > 4, (n, y, y), validate=A0 it to ATA_LPM_MIN_POWER;
> > 5, (y, n, n), validate=A0 it to ATA_LPM_MED_POWER;
> > 6, (y, n, y), validate=A0 it to ATA_LPM_MIN_POWER_WITH_PARTIAL;
> > 7, (y, y, n), default user policy;
> > 8, (y, y, y), default user policy;
> > ('y' for support, 'n' for not support)
> >
> > for case 2, I'm not quiet sure, for which may enable hipm partial/slumb=
er.
>=20
> For all above cases, the default should be to use the default configured =
policy
> defined by SATA_MOBILE_LPM_POLICY or the ahci module parameter but
> corrected to
> match what the adapter & device support, including the eventual NO LPM
> horkage
> flag. Mario's patch started addressing that, but that patch can be improv=
ed
> using yours.
>=20
> > The way I provided above is quiet complicated and may be incomplete.
> > It may not be realistic to take all into account, but I think case 1 sh=
ould
> > be taken seriously for which may cause the above PORT_IRQ_PHYRDY
> issue.
>=20
> yes.
>=20
> > Perhaps, I could refer to Mario's patches later (I have not found yet o=
n
> > kernel/git ^_^).
>=20
> Mario's patch is here:
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F20220404194510.9206-2-
> mario.limonciello%40amd.com%2F&amp;data=3D05%7C01%7Cmario.limonciell
> o%40amd.com%7C2ff34a9405444559699208da33264e52%7C3dd8961fe4884e
> 608e11a82d994e183d%7C0%7C0%7C637878536864920264%7CUnknown%7CT
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> JXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DizsUMCw%2BOzV7myxDH
> JBqmWnzInVJ2CJz3wfsdgVmDdY%3D&amp;reserved=3D0
>=20
> Can you add that patch into your series with eventual modifications to be=
tter
> check the adapter's CAP bits ?
>=20
> Mario ? Are you OK with that ?

I think that's fine.  I've obviously gotten side tracked and didn't get a c=
hance to rebase
and send them up.  but I do want to bring to your attention that I just fou=
nd
out there was a regression from the original patch that set the policy to m=
obile.

I was hoping to figure out whether it's just a stable artifact or if it's a=
 real problem
with mainline kernel before giving to much thought to setting ALL boards to=
 this
new policy.  It might be a single outlier, or it might be a crystal ball - =
TBD.

This regression happened because it got brought back to 5.4-stable, and as =
it
turns out the exact same FCH controller ID from the client silicon is used =
in
another product.  It's an ASUS server system with AMD Epyc processor.

The regression is specifically along hotplug, that hotplug no longer works =
with
the more aggressive policies.

The regression (including the bisect) is reported here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1971576

There is active open tests to figure out whether the issue happens in mainl=
ine
kernel as well or if it's just from 5.4 backport.

My suggestion is that you pull my patches into your series and lets keep it=
erating
Them, but let's hold off pulling into 5.19 until that's figured out, especi=
ally if we have
to revert 380cd49e207ba4 to solve that problem then we shouldn't push this =
policy
across all boards (unfortunately).

>=20
>=20
> --
> Damien Le Moal
> Western Digital Research
