Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B684EC433FE
	for <linux-ide@archiver.kernel.org>; Tue, 16 Nov 2021 01:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964EA61265
	for <linux-ide@archiver.kernel.org>; Tue, 16 Nov 2021 01:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355762AbhKPBuy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 Nov 2021 20:50:54 -0500
Received: from mail-bn8nam08on2043.outbound.protection.outlook.com ([40.107.100.43]:45120
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1382138AbhKPBsq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 15 Nov 2021 20:48:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro58I9pd/ocpXfKGqWqMFpOGetLfVTn99rdDLMi7Xrwu0msc7ORsoM9MO/slyVgmPFM9F6ni7zt+55F/3hioa88MulK98kESs3Tc75t8Axv7h8+DlwHeVhChYBfZYQulwibNBRBc69fN7mhm7pL6s4US9SqFIKWJYpkxeDIDfTzK8UKcfDrbjOBKudX3JUqyciZV8ltGlJ4XYzhk5fYbiHFQPwN+qcb3QxcE2rwbi4DoujnIsEdR8XDo3ic+R+CX2XzNGhRw9GO5dYbrQCvuM3QxykgT75BAf3op1c0HtGZN5BkXJD7dSZRE8SLfDHK0hIF4CaxKVdi4SSECBJGslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTuVgNFZDHDdZGPAxS0XpS3KPK0MknQIxD1ZCfXUAWw=;
 b=YvStQYE1YxB6gFGLWf6fkScN0ogjS9TGQOitVFmZx8GVgSPiHW8IfbDryOd/TWj75Vn7Lpf0jYO3F78JibVJhT+/jsDVDedI+ranCRoNN9D31RoB3QtQyBnfgrSyP7cyGzwdBstgzkY7WMYkaD1ZN0XLLu9znEZIS6Mp+8f/qISmayDxQL4NBSmaFabS8toLlrboznSL80lXw3kSku+LsxYLiIXKs73XklMC8ZD5taQ0bsGSR2C1tlzrVh0CCnatSMG7SQbMC1SL8OiKSKzGyW3ljEjCOi51VcdWdkhtt/WDHj5bBhkxujbklFvefVY/4iPc4uIeYX0TDyYfLauynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTuVgNFZDHDdZGPAxS0XpS3KPK0MknQIxD1ZCfXUAWw=;
 b=dxsnY1hf6xeglb7jG525vAFHbvnDgIfK3dQe7nXcl92ycvVreyN62HzzzXSYKo2CXYvh+d760XwdhN22gfttcBHanoUFpI+JkzW4pIEQpaM6oOXUpXreyKwHe/h+baE4i2taFLHy7CdwGLnNfrU5qInTW2vnrRl/KLSInuKXF6I=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 01:45:47 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 01:45:47 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Subject: RE: [PATCH 2/2] ata: Adjust behavior when StorageD3Enable _DSD is set
Thread-Topic: [PATCH 2/2] ata: Adjust behavior when StorageD3Enable _DSD is
 set
Thread-Index: AQHX2AIZPPZCe4WsNEaSIHviFoGddKwFZfmAgAAA5sA=
Date:   Tue, 16 Nov 2021 01:45:47 +0000
Message-ID: <SA0PR12MB45102450CDE0A836D2749111E2999@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211112201539.17377-1-mario.limonciello@amd.com>
 <20211112201539.17377-2-mario.limonciello@amd.com>
 <3d514759-a7d4-533f-63ec-1aa682f50f5d@opensource.wdc.com>
In-Reply-To: <3d514759-a7d4-533f-63ec-1aa682f50f5d@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-16T01:44:10Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=68d606f3-7dfa-485a-bd71-cb1aa10d478f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-11-16T01:45:45Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 6da6e3a8-c549-4403-a46b-d980bd0482ed
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd81e383-7792-4680-58f7-08d9a8a2cfd9
x-ms-traffictypediagnostic: SN1PR12MB2416:
x-microsoft-antispam-prvs: <SN1PR12MB2416FCFE9BE75B6AE1A262CBE2999@SN1PR12MB2416.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tmqGL/OagQdgvzMEhm+jkYI6XO9D8hoTe5754CznmqZ1SF5lHVJt+8wmeXnOs+H9mAPqKWkGCzkvz6emxE/oVRR9fMdzW7lF2S02dzgIFyi4R6G14ZWHTe5+ncLt4wkocc0baCpulTMc/C6nkkJXEVi/hBfPL7Ifq7Gef7uN1EbwRTNOUONR0HdTmG/Xtfhaw4oxJIDz2IEuiq90j/FZEyKZ2NLzpy+jZ/Ygm6J0HQ+QGjSXJ2Tyi8951YensPrGsho20VPaVl9ikOcqGZ2yrQOTRLLOB42UMmKLHjOBFzZur94DmQg+dRTWYVw7S494kKGiXvsrg9VtxOiiEVCl0WXiEiC4MwmSgQKo1QFgPwRLl47YLXwTueGY8NhY51Ji/4wMQkxL3wBtRhe1hdTJ/YP0SeMqKXB6oO+CWoys7wPV/9olLJEPGzVa0+bs1rKtkRwJvia/YaQ5XoZGhAJBvQK2eFMHLoonjvpvOdVbhE8edJLzxkvLx1//Fj+0a165o1wCUcrAVpriAy7k7q57JWTnwnwK+cxEVRPb/usdNTWqj8m5cZ+ra+LwWVeIaX5BjsyWn/W/UKb6XMDhISNRRc2xrYlVfGDpgS8TMkre/0tfeGFhptNJ/t0Wh37q8RDPtGpvCS2I+AX2OSRa8m8pcizrnfxz6ziodJy+vbfulZu3HvgiRTbxx6jNtP6CYLZ6YuPOQKiAz3aXXD9m7nRBoMHE+WgXyrMbwjsa3feNI1Wxw91VYAUQacb2oigGHKY3+xuyJq9b6yj1ljxPwBCYhxTlBzufuPM97KWDxIhJcGc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(33656002)(76116006)(54906003)(53546011)(6506007)(2906002)(83380400001)(186003)(66476007)(66946007)(316002)(508600001)(4326008)(71200400001)(122000001)(8936002)(86362001)(66446008)(64756008)(66556008)(5660300002)(45080400002)(38100700002)(38070700005)(9686003)(52536014)(55016002)(8676002)(966005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a+5dN+jZ3NMnlSJ/nveajggTZdbNOpS3gcXZ+nL21JGXsfPDpLsKEXKiQt4X?=
 =?us-ascii?Q?OcCr9GuefTRPySzF0zvA8YLHee7/2wDFq2rV1v5Ji68GXJ5p/PmeZMko3AwC?=
 =?us-ascii?Q?LOaGXLK0IFMcdvVjDIfp9Niy+Wh0+I8HwhWaGOF6ajVv7ugWzjBL6CULZBaj?=
 =?us-ascii?Q?0aZziG6fpvuy3z4dAfguZ+40OhpsHqD1Ph+TNNTc4xK5vSO2U/YzrgWcreQx?=
 =?us-ascii?Q?odYtldGZR4sPAKIyPEgiWoBxshMudjAyXhCZIRXEMsGzG4RqAzcJ6YyJIh0G?=
 =?us-ascii?Q?VwTLLKSDTXKC5AyUd0mVbWB3KL1Fp6O6K3rXoS1Sd8AqUb2yf07QKFHkvvM9?=
 =?us-ascii?Q?Fh5YJkYyg66eAmhpSaMYr2AZI6CxZJq5HER8bh0MJwf9K75gFlC5GnhIDUCT?=
 =?us-ascii?Q?dKCuxuxtCH4B4qIDoa8KR8fCFj1uEUSE3RQt2FpKOTyKE2WF9+w/UOuOEHUK?=
 =?us-ascii?Q?AkAx6SAQ8IQDfLzrfAo+tjI0v5HD2sC8xFGV9dztKGMh6F0d3RpoEbEJk6nZ?=
 =?us-ascii?Q?jC0/vynPFKrf0h+Eo6E32iaFT1kxV2R8FUmcv3ax9+gVmo5wIlI67Ia2CQE5?=
 =?us-ascii?Q?B07qr7mCc4ZQZ/odqXYvHww+8lx4chkNQS8jCkrmLqemR6sfVhgacge8qUxA?=
 =?us-ascii?Q?348iN0WmFOjNH+rvGC7SMJcSstkibg51INXoxdMjMOZkwx4Myv9wPixVeK5n?=
 =?us-ascii?Q?bUDqVd33ssxCGch4kK0QbaE/J3xOfzwDIbBI40HHLRJJFYy8O79ukzFCvxq3?=
 =?us-ascii?Q?NzaFAQo3xyuWj4BwLfOqOQdrqiLlo85dmJuIsxEgGqL35+1RfAg86U4/20jv?=
 =?us-ascii?Q?lc8Ne89iiBECzBHVh0wBOF9an4cjW4Ae3+yGGjcFSu/d1wqTe9jxwyr9wlYN?=
 =?us-ascii?Q?YFTOQONdBnfL2YcMBp3GkOo3JVKoTmWrx6/+/KxidRy1/+eK99N8Ko+Ub1hn?=
 =?us-ascii?Q?u3OvNTIJufUBWlF7E2P4Sa17+xAOd21ieKfcY2/pVJVnG0yUM54RAbgQBIJO?=
 =?us-ascii?Q?Q2C0CtwakNKGiZZiKT4tr/b3xZggrVwfY+pWmTYRNPYfLVUesM290jZh9htm?=
 =?us-ascii?Q?iUCnnAvc/YZAqaMNUDpeSn5xvtgqM6NNFLWZvxvQXNULcsKJWl4DCJmSeu2A?=
 =?us-ascii?Q?aZX/aZVaJX7G2/0WV3lJT7TyyLlYLjdq03G7qXoGEjl4SFpX9FNXvnkj+/Mw?=
 =?us-ascii?Q?m3lCFHOXoTlFzboGZhZLmPx0GomaQBlE5QIJnQORUOZZPYmrgPzeCr0bxS4m?=
 =?us-ascii?Q?Rii3sIEAmaofKd0Yho44gNbX1b6NK8EPM2B8YmLAhfbfn0UBNIjJfzqZhKhk?=
 =?us-ascii?Q?WuEnqCwJ6gTDpgM31WL+9o1+BnxbJP4GupkafafB1kAKla/dy5zAVIihBOag?=
 =?us-ascii?Q?Png9deN2OO6tTRIOMXPmyajSKmIrSmOX3eTtn8CzKxr7V2Zdd+lOniKepF8v?=
 =?us-ascii?Q?LsZrXWlNnGLAAksmsdMQwaPRS0GmPV4qrixel2WN2Ydi6/VYssMHsw0S6fNP?=
 =?us-ascii?Q?aYo/xPnnByoLErumRlxDPavCSfeSCkSMWKIiv6ICg+w2xIdM23EQSVXjDH1o?=
 =?us-ascii?Q?sWDTkJKCLp/eoTS8St4RHhRc4Utnl3YUhA4iiQdcD7BD4TPocL0ZK3W8DCHF?=
 =?us-ascii?Q?acf2jvmRwoRkyHnz07LZYUeP3YT9UsGzeNcesvpUymd089y6SlI0dCP3mMUE?=
 =?us-ascii?Q?CK+vEPn7h483u5ZkQTiekgN/+Tw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd81e383-7792-4680-58f7-08d9a8a2cfd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 01:45:47.3239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/oDQA4eLalN0k6L9x8jzCvPSizKGdOSkdmkX/4m16qS/XQFsZ06Zo/oxVtgVGilPleGVxHctAJRkX6/n+VRVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

[Public]



> -----Original Message-----
> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Sent: Monday, November 15, 2021 19:41
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers) <linux-
> ide@vger.kernel.org>; Shah, Nehal-bakulchandra <Nehal-
> bakulchandra.Shah@amd.com>
> Subject: Re: [PATCH 2/2] ata: Adjust behavior when StorageD3Enable _DSD i=
s set
>=20
> On 2021/11/13 5:15, Mario Limonciello wrote:
> > The StorageD3Enable _DSD is used for the vendor to indicate that the di=
sk
> > should be opted into or out of a different behavior based upon the plat=
form
> > design.
> >
> > For AMD's Renoir and Green Sardine platforms it's important that any
> > attached SATA storage has transitioned into DevSlp when s2idle is used.
> >
> > If the disk is left in active/partial/slumber, then the system is not a=
ble
> > to resume properly.
> >
> > When the StorageD3Enable _DSD is detected, check the system is using s2=
idle
> > and DevSlp is enabled and if so explicitly wait long enough for the dis=
k to
> > enter DevSlp.
> >
> > Cc: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
> > BugLink:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugzi=
lla.
> kernel.org%2Fshow_bug.cgi%3Fid%3D214091&amp;data=3D04%7C01%7Cmario.li
> monciello%40amd.com%7Cb8d8f7b189a8471d2f0408d9a8a224ff%7C3dd8961f
> e4884e608e11a82d994e183d%7C0%7C0%7C637726236637477756%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DNPnRafAYSFrIRlDAlM2K6WDzk9Mr3
> Rnn65n5wREiUZA%3D&amp;reserved=3D0
> > Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs.=
mi
> crosoft.com%2Fen-us%2Fwindows-hardware%2Fdesign%2Fcomponent-
> guidelines%2Fpower-management-for-storage-hardware-devices-
> intro&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7Cb8d8f7b189a
> 8471d2f0408d9a8a224ff%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C637726236637487711%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata
> =3DqTZOAUQFzKnXn9i6r9noM17YPvfZ3kRtAztZjtrdxvU%3D&amp;reserved=3D0
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/ata/libahci.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> > index 28430c093a7f..15c293da30ca 100644
> > --- a/drivers/ata/libahci.c
> > +++ b/drivers/ata/libahci.c
> > @@ -2322,6 +2322,18 @@ int ahci_port_resume(struct ata_port *ap)
> >  }
> >  EXPORT_SYMBOL_GPL(ahci_port_resume);
> >
> > +static void ahci_handle_s2idle(struct ata_port *ap)
> > +{
> > +	void __iomem *port_mmio =3D ahci_port_base(ap);
> > +	u32 devslp;
> > +
> > +	if (pm_suspend_via_firmware())
> > +		return;
> > +	devslp =3D readl(port_mmio + PORT_DEVSLP);
> > +	if ((devslp & PORT_DEVSLP_ADSE))
> > +		ata_msleep(ap, devslp_idle_timeout);
> > +}
>=20
> This generates a warning at compilation if CONFIG_PM is not enabled. This
> function must be under the #ifdef CONFIG_PM below.
> I can fix this up, or you can resend a v2 if you prefer.

Thanks for checking the detail and the offer to fix on your end.
That's fine with me.

Thanks!

>=20
> > +
> >  #ifdef CONFIG_PM
> >  static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
> >  {
> > @@ -2336,6 +2348,9 @@ static int ahci_port_suspend(struct ata_port *ap,
> pm_message_t mesg)
> >  		ata_port_freeze(ap);
> >  	}
> >
> > +	if (acpi_storage_d3(ap->host->dev))
> > +		ahci_handle_s2idle(ap);
> > +
> >  	ahci_rpm_put_port(ap);
> >  	return rc;
> >  }
> >
>=20
>=20
> --
> Damien Le Moal
> Western Digital Research
