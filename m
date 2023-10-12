Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41060CDB46E
	for <linux-ide@archiver.kernel.org>; Thu, 12 Oct 2023 11:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378101AbjJLLDY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 12 Oct 2023 07:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347168AbjJLLDV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 12 Oct 2023 07:03:21 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FB190
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2023 04:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697108600; x=1728644600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ERHFxxEMlI1j9EdRNlIimtnC1G20BhY+5F4U+MA6C+A=;
  b=e4Dmmyt4LFmIH3SSpzYmwW4mE+q/DdF5y9+mXTstrodJ6u6TPD5IQqgv
   S0ReBe/3Ew3FPJyhZ/EvA++as9K+qak3aYLB36oxwuFnDJ3M88RnyOSS5
   cT0egWnhFNCCQFy4XNZ6ue8s+kJdEsDBHy9v1yYbdpfEMG7H3Hil8IVzQ
   6zGIx7yFgWnyEd+eprPzDxG84DK2LuXaWLJaa1JY/G0UZhlUinVT7LfYI
   x4JyexA/wTrm5dgrqCCqxaeiOkWxNFYLwvhdqJYb2L5X91PMEJfUj8SKC
   fkSr2tmu58q9EcI6+4TPmEmn1paw+/dlGqC4Nu1hV3bFiMFFbAOW6LoWk
   g==;
X-CSE-ConnectionGUID: n1x/KykOTLyCqt1T3ppTZA==
X-CSE-MsgGUID: CoiJimrjTweJkw/Fd7tWQQ==
X-IronPort-AV: E=Sophos;i="6.03,218,1694707200"; 
   d="scan'208";a="246378657"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2023 19:03:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kw+lKevZ/L37qU2lKuLU5qxvDAsVJqYiO3E64Y8RDdQRtBs3OT/x+P6sH7p2fV0kOs6uIHxhx+Lj35tCmiW5/wU3vvu484w4K7RH3YqnAJnnvjkK1FwdR39RAB8NoGBcNloQpOMViTMz2qBlwmID1FU0MQ0lPS6UnbAjPJR57Amog2+IfXU2T5C4rAgVFeMOzLLnReXC0yoHt37eTHC/yvfR8JsHKfWXN6TLNR+z84IRJACqxpw55DbB1j3S9jlKVmM6mSEUnZ9v6jriTwNxoYwV1H+ynWWK2/bwv2FipLodbTX9PfdkbOOU2hGMRcRzxrKiz6a72/D5L7La3uoKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8LBUgHyz5bucmFFBpqrTqj9DDazLFflxzH4HtESw48=;
 b=F1uDITlL2skTh4NS1mpdPqZZuc+X6aGSj2VmZk46dcBBtn02PaWC1svmiGWLnCOJRpXVA/TvUGdxtzRJYTwRhZxFBeKVXOqeNqpVUZxKl/uWkYNp6Adt54fyk3s14jUDXzNHCeWGiB1PSgd3Ne/iEP6FII2nKiErWWNfeHUHzc6TMOB55QbgN0P/TLXG2YOuW9P/bWK4pz3PWOezYy8/C1lkgUJYk8HEEAoKnRwELIgd3tW1wdj+lRtHd/HcXjgZRHs018rJi3gacmE4eaTReLh31ZDdbIhWnOFJDHJ7sNCeMIIaG4SY1S3DkO5mYJ0hJQW5HXCfcRdLVSyZyBlu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8LBUgHyz5bucmFFBpqrTqj9DDazLFflxzH4HtESw48=;
 b=cXk5Bbr35bZrruX/8DY4nC7dTLjoyslv3BL9Uz4N+m6glM6N6K5282WQa+bxBTljf+59erGq7g5CWzvAXAepQxIrjG/WIr3jmsBqkcMlpaleO1U9iAZBhRwHwlcf5EW/HynlV6Rw8FBM3x4kOwXpmkKQWyLpBIM6YptCPs4dKP0=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MN2PR04MB6320.namprd04.prod.outlook.com (2603:10b6:208:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30; Thu, 12 Oct
 2023 11:03:17 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6886.028; Thu, 12 Oct 2023
 11:03:17 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Phillip Susi <phill@thesusis.net>
Subject: Re: [PATCH 1/2] ata: libata-eh: Spinup disk on resume after
 revalidation
Thread-Topic: [PATCH 1/2] ata: libata-eh: Spinup disk on resume after
 revalidation
Thread-Index: AQHZ/PuzNDFwXdxJK0Gj+qCL22cZHg==
Date:   Thu, 12 Oct 2023 11:03:17 +0000
Message-ID: <ZSfSdBBqMsg+kAvB@x1-carbon>
References: <20231012071800.468868-1-dlemoal@kernel.org>
 <20231012071800.468868-2-dlemoal@kernel.org>
In-Reply-To: <20231012071800.468868-2-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MN2PR04MB6320:EE_
x-ms-office365-filtering-correlation-id: f25d4a8f-0fa5-4c77-5dfd-08dbcb12d68d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kVouZWaDIXCMxVbRv3euG1QCixHPyp1Tk/UYB4lMS7IIB8JS4gJ2NHGyFzddOF456bdwRWdow+NBijALJcndFip4NVaB+n54fcevsFwXZ8YgrH+BkCrYYgbpI1EwO1zPwO83FI08agyt/xeE4mksGnhA/lmvJEos+oADATfsHswgNo3mvDuVsxBgkk6QIWbjUAZKgxNNNVNlUyUMepvqvYT671GZhss8G/m244/w+9cJmVvO61UgXpyqXehM2nWGavgS4/w+dhFDCUR/Tg3ugWMjNusyD6pFUuiB3aHVPe6vAlSTrQC5R9osVMzWGm18jAPbmooiga7h6vP3CZc71kszTG78jt1sRvGNTVZJ4DlfesIyxdwi15BvrpSoeZvzVEjz8tC08MIzvicGA5lT3qt0MpJBR0BUediGzFvXblTI4f6NNz5t9iB0d/S/bCBVLFhGClpdyRSfeh8oegHCFDk4E87CgL4MxVj1MWp0ND5SWYDD/uAI9b/M8rbQaEO4JaL66yp/pCDjnzDddzy2Y5gVNwgCJB/7cXnBYJUcOlS4s2Oo6QHkIwxzeqMmw0UfPdXgoGIYqH7is509zwL294H8vufs3xHd257HG3MczvtBh29N+VnS+gIF5d0ts6OnBS+NjcMCZQ/6JeK4yLEbEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38100700002)(6506007)(478600001)(83380400001)(26005)(122000001)(9686003)(6512007)(38070700005)(86362001)(33716001)(2906002)(66446008)(41300700001)(5660300002)(6486002)(8676002)(4326008)(8936002)(71200400001)(6916009)(316002)(66556008)(66946007)(91956017)(54906003)(76116006)(66476007)(64756008)(82960400001)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y4VIHv+dhOR70IbQ28BPJTYDWVXEgs0cp9ynDxkaL+OB52UGg3XxzEtGfOxy?=
 =?us-ascii?Q?/pC7GIVuP5AQUFJuuS04N43h1644JTU5PHInkeX7nQHyv2x2vKInUsAhci/6?=
 =?us-ascii?Q?uaDLhWZDjqWb2nl76yfK3HYKzS7MUd69tFMoHvRT14oBxhgcHduLcGzx1jAA?=
 =?us-ascii?Q?nhl7uUOCNtKovb76bOe6oy7eYtlMEUL6KLBs5M6VpIPXouRe/MuICk5uuDTw?=
 =?us-ascii?Q?+SkKgI9Rlam/09OBOms+6b+fAYE6TGdfWap0UtFOxja/V8Gn3iUbkaFEyjgT?=
 =?us-ascii?Q?V0VPBcf35X2GVotxItfwweC1+ZLdKJC845bmJkrnm+xotc8zgwsEK6BXEgBb?=
 =?us-ascii?Q?elxpmWxWkj7ws484jWJ2RDhHoh/J2HWDzWcuxpMp9a0JMqaR5N3OyKN7TBpz?=
 =?us-ascii?Q?VyUVhWVPnAPuI0QCVy8XdVUvkjUYg24l/ea4OEzTfDtD6eP/0S7aec2GELg9?=
 =?us-ascii?Q?Tgm+Q5ecFszDXG1mgvfws2SFZCcI/4wEeXCf0VPJWwONucpO3hJBulzTRR4s?=
 =?us-ascii?Q?1xED7USdCVbUSK0d7+RsBqgbYniQk0wiTO4Nh4/e3/O8YTCmuYnCkhdVpmXz?=
 =?us-ascii?Q?g+PacgSeTlr6rZ5iwQ8RvDhntk5oXvg4iOPHyZ6NUEylERFIZ49FPQvYRX5C?=
 =?us-ascii?Q?YSbOlD/kSXUyNoxamzUoYwu2LF70LiUyeK2Fr8jatTRQzVTxB0WKT92WFbEm?=
 =?us-ascii?Q?NM9exIhx4AgaQjVcDYSOCY3PXI1ogpJrM+XtTWfU9u+eP+hL05BmCwhDQlQk?=
 =?us-ascii?Q?t5aM06giLMav8q8y5iL9VRZiN3mbCHNJjuaKRhQLDjSPnjywx8rOXPlBo89l?=
 =?us-ascii?Q?2kxVDS3ZhGI3C8OiNUjnkh/x/Ut3sAjOHCOFLyLxbBCEg8Ru1+wJJNdI0Vf9?=
 =?us-ascii?Q?v7l2fQ1OUAj+40lhhvL2sdT+RA/djRbqGNVndPx2KdF0hEhP619SAY4mghbN?=
 =?us-ascii?Q?FqYMoUyqcPeTlVSRUwDMfiDHD4T7qf8cvYBi19vW0s5n3xRel0mcOyR4qj9Y?=
 =?us-ascii?Q?Y0KdwgocLf7WTtsLe4fUlB4KDC4kgKZAury35UfbkgTy3L4ZodeVQXUpdYdH?=
 =?us-ascii?Q?o/kebMLdDVjLRqDGi9DBZXFWVFuTXDeC6VjlqXftpdm6+3FPaypXdkrhffiY?=
 =?us-ascii?Q?MPTSHv+Vk+KvdAJgb808tUCTcwumdGKqVWY/NrU8053eAS3BVKzPUcChjaNy?=
 =?us-ascii?Q?MbRxup1mQIbutmUtT8attNUTtmFdggN8hsrm8JwFBiaxoh+iXdJ90ihB9C/Q?=
 =?us-ascii?Q?Nj8zlIfGusg+YC6DxBvtat+/ILvkR+rdJ39P6ylO89i7i83ITl+NbqARx38N?=
 =?us-ascii?Q?wKHWm6dn5PIimSP3XFJ2eDfDDYRee/ryI6md1PgDNcxLJWms9+E85UXR7oG7?=
 =?us-ascii?Q?ijEeF7aUZ4dp/1WhIc1+sqQn5dpozYS7hoNFZAKhyO3t/sQ79R9hCu1s2k29?=
 =?us-ascii?Q?4kR53yhu46JYyW42xptW8Oqbz2Spb/YyalOiI1Ct77PhzToOIAZiZco7ajgi?=
 =?us-ascii?Q?9H1m2E1Vdys/1awe12Od/wnmJogE7WK/gfrm7wpFahOBbGaudCaK/cagkktg?=
 =?us-ascii?Q?yn9/p6D2BhzJrSif6csqZ4yMIAsz0Sg4vQ8FQDh4qT9s+LwfNF+oJszQarCV?=
 =?us-ascii?Q?6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <717E187DA7C7044A98BE1124DF3A7787@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GDgQfjwtABvctkGebLjBloYOuJ5+wQnBKU9ijysShnl77tCO9cfKQ4iArZP2uZaYysKoWfolIVk/kGBVO+gYDVwSkmZsgGts0rfhlIiXnkNE8kn2trolNDoNlFozKUclurKRVniOoaSaWbhqfA00nVmlUT/e0dVYA/cGEMqxXcOrw1mQr8xw4v5JznnDdRGdek61u0DOXJvR43f9fFzasgJyLqif3jdOkkvaHmacjqwYeIz6+hai9mtarO6xwDnwnYFh8zw4cr64XnHIDpCc8B/L25hpb4XxMfBXJflTxWPJavUbrTos3e8bHlgpKw9D7Upm1L/5Yby/RWnU+G6AuM+WdX5cQfTkB0K4dE9J31+/zYaLGdSA/ijj3N3XcrXpsPPaWFtzy3ZeC0PyOIi1UQjMmQ1mi0gxD5Fg1MZFCUjtA1d0ZJZpDQqojuhxegyzOdXhl2u3AFguBybx/4sr4yRyRM6BXZit8iGFY+eaA4ev/tOP0HW8yD+vlZjmMAWtGFhTmXbqH4wUBJbIJDU9w069LKjUg8I5l3WVzRpHnUARECLWIx6PutyUVZx6nCAaLtDLGsQ7RSdQU611NadcdD6GXhD9yI3V5L4jO05gZFpDq7Hs/uGaOEk2GniNU3QtBAA0LwNUFxC4ov41/e3iC0nZXl+5CRqBMG4JVaV5D3NsYFcIUpj4QOv050idFd93lwC4RJG+yv3a0G0fNpoVbabF2ngDwfxPGwXkTXVDqP42qwmUte7pfmWxPYu3zyYkOSl+Txf2v8xGs36YsHjXJ5E1kT8/bIKz6qjz6KrjPsDGRoLMmUKMRi/IZQBIbl+ts2B14rtIGhimp/N8/mPPcLD3NXBv3N3kqqJmHRnG6HmVnfoQM3Vfh2lt8rYrcGBUCZTbZeIWzZOm7Z0ILZ7gxQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25d4a8f-0fa5-4c77-5dfd-08dbcb12d68d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 11:03:17.2296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvPnovnDYOqOQh/7ssNw4kUZaXZsBWiK16iHitiVHEvzpSt//6JU+yuq9kTlTqgZKen53jvn14Z76OAqmsFXBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6320
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Oct 12, 2023 at 04:17:59PM +0900, Damien Le Moal wrote:
> Move the call to ata_dev_power_set_active() to transition a disk in
> standby power mode to the active power mode from
> ata_eh_revalidate_and_attach() before doing revalidation to the end of
> ata_eh_recover(), after the link speed for the device is reconfigured
> (if that was necessary). This is safer as this ensure that the VERIFY
> command executed to spinup the disk is executed with the drive properly
> reconfigured first.
>=20
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-eh.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 945675f6b822..b0d6e69c4a5b 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -3051,15 +3051,6 @@ static int ata_eh_revalidate_and_attach(struct ata=
_link *link,
>  		if (ehc->i.flags & ATA_EHI_DID_RESET)
>  			readid_flags |=3D ATA_READID_POSTRESET;
> =20
> -		/*
> -		 * When resuming, before executing any command, make sure to
> -		 * transition the device to the active power mode.
> -		 */
> -		if ((action & ATA_EH_SET_ACTIVE) && ata_dev_enabled(dev)) {
> -			ata_dev_power_set_active(dev);
> -			ata_eh_done(link, dev, ATA_EH_SET_ACTIVE);
> -		}
> -
>  		if ((action & ATA_EH_REVALIDATE) && ata_dev_enabled(dev)) {
>  			WARN_ON(dev->class =3D=3D ATA_DEV_PMP);
> =20
> @@ -3856,6 +3847,17 @@ int ata_eh_recover(struct ata_port *ap, ata_preres=
et_fn_t prereset,
>  			}
>  		}
> =20
> +		/*
> +		 * Make sure to transition devices to the active power mode
> +		 * if needed (e.g. if we were scheduled on system resume).
> +		 */
> +		ata_for_each_dev(dev, link, ENABLED) {
> +			if (ehc->i.dev_action[dev->devno] & ATA_EH_SET_ACTIVE) {
> +				ata_dev_power_set_active(dev);
> +				ata_eh_done(link, dev, ATA_EH_SET_ACTIVE);
> +			}
> +		}
> +
>  		/* retry flush if necessary */
>  		ata_for_each_dev(dev, link, ALL) {
>  			if (dev->class !=3D ATA_DEV_ATA &&
> --=20
> 2.41.0
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
