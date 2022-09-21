Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CECEC6FA8B
	for <linux-ide@archiver.kernel.org>; Wed, 21 Sep 2022 19:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiIUTTF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 21 Sep 2022 15:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiIUTTE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2022 15:19:04 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820999F1A8
        for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2022 12:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663787942; x=1695323942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GPpbd+O0eeqyHZAgfHbSyyKuLiNQ3t64BtjcXXgLQ5U=;
  b=pJroQ8JCcUEzc8DMb39f6ND7gglrhubPm4Y287KobXt5QUmYHmVsRyvh
   cUYI4zRog7Qz4QmAlIYiLeJvs30mfjPNfT5aKY+0b0vo+BBdtxuzNVpqs
   xEGb8nNjteEgdlLeqavs2ine1OiQd7X0XdPIuRGg6liQN7rfuxO0A2wCr
   Mq+a5lXYlhZbBAdUYS2MxRF34NxcAzvylDB5znMoBRWA57AO3xLYJz4fa
   53+AcUwh+wo8+Mlm8mTEfvPA7WSPh2nfvFYK9Ek4biUY0gN/JXdeuBc9L
   BpCZ50RN8nC0zxwFHSuQNwOTb6bh5y13n3FcR7vW69mc0iMWDrzzLs/XO
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,334,1654531200"; 
   d="scan'208";a="324048795"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2022 03:19:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMcOeX38s9YSjkgVe9DKxHrrOkTSyAbGWilF7uoVMIqupRe5f5/FJBsLAfN40NWtYKxBHl4owgvXqsbIqI7JxNo/NlQpJj5Vy+kshrNnFC3lCrwBNujwCAd1NmR9OaOFKpMPY7ALZ1KvE3k6PlTzvqQUVclq/kVch+ZasMjM+HHGvDwxL1idYBFzf60vniZdQpQza+bbXp7qrB6fgHhDYksyL1pUnVI/stndKXz+KqSz2ar5z639yvdhhzKiMXxaSMsfcctuGak6+S9bAeYOBK+aRkqlPpvgYFPjXF6PfRNmmOM7FKC08xYiBhwVXl8Vmg8Gkf8j4l0jB9XUjyKo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7VMcqItZYygQ934jOIPot5htwXEFjgDxbSLM9XRJX4=;
 b=GH5wsduCM1z96HgOYhmN28EmmmFYkWmyIqAm60XxSGBcm0WlF7BWAvSAV6//wtJulM51shenb+PLhOgsws4MZhYKSPXkECbq746nkdyoMyc5B97a5tBwLzSt3PNzwwL2tZeDe5uA5i7S/CN2hOmr3GwIJulHPu7Ko4KXWWYZuO83O0cIS66MX8kNPBaeswQaPgiBzGVGalMQ1sQZMWbOBVZCVibC0zhBn7xK3lEP3R2nx1E1cuhJig0nQRYvcJQojzANMX1YwpfNYPHwfFpN1OoI6veVv9EZeE4BHpz3lM6SL5B04q3+19PSHJUjV/57xp8MyOQKpb+rKhDAnDszhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7VMcqItZYygQ934jOIPot5htwXEFjgDxbSLM9XRJX4=;
 b=RK1E++ML+SI3ZoDlP9+P0q1PGWfu96aoa3pcNGvToyYhf2Zrr+rsc72jApG9/8IzlnnVelWxmYj5UtuDRyw7rrvlvIC7ssPdqCB173c6woWMIO/Vw3XFJKGPNE5S8NhoFkO/sgV0kqvL/4BMQn5z+itzoc4xJOeRHv90ZfX7gXs=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by PH0PR04MB8322.namprd04.prod.outlook.com (2603:10b6:510:d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 21 Sep
 2022 19:18:59 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa%5]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 19:18:58 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300
 Series Chipset SATA Controller
Thread-Topic: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300
 Series Chipset SATA Controller
Thread-Index: AQHYzXc9m97OoENq5EybQzu17xjjda3qQw+A
Date:   Wed, 21 Sep 2022 19:18:58 +0000
Message-ID: <YytjoUsiXAH9cMPf@x1-carbon>
References: <22f69d9a-7d0d-a408-70b3-11295f14b82d@opensource.wdc.com>
 <67950993-2eb9-c180-7c80-98c9954c9b22@molgen.mpg.de>
 <85f8c8cb-b4b9-b3ed-e79f-a1a161c9b672@opensource.wdc.com>
 <65012735-0a92-1071-e8e0-9d101c247a64@molgen.mpg.de>
 <3135eed0-b7e3-42fa-5b6c-80360f34e428@opensource.wdc.com>
 <893fe832-d522-112e-53ec-0f030c15af0d@molgen.mpg.de>
 <318b0452-9814-6276-95a5-10478e5a1b7d@opensource.wdc.com>
 <178704d0-b5fd-f750-b77e-fece6c6d81dd@molgen.mpg.de>
 <MN0PR12MB6101E77F03E5A21AEC8A5D6DE2479@MN0PR12MB6101.namprd12.prod.outlook.com>
 <cf2d8276-ee36-9923-1444-1dd7d489b172@opensource.wdc.com>
In-Reply-To: <cf2d8276-ee36-9923-1444-1dd7d489b172@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|PH0PR04MB8322:EE_
x-ms-office365-filtering-correlation-id: f8ede450-f0d2-4f90-1ead-08da9c062274
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ynn0g2k+TKbebipGlOhswDj+2qoLT4cMxiQX6/lKF2B9BgXmRwMdyxxyQPNXYMM6FmOtE0P8VIgX7g2icqM45B+cxC798MYmBelo1A9FC29J3o7e4Fa2yHB+EDsdqey4mcz7GS6H44ASqKquXLb6y2pfHFLltIqATP2F14q7aXLTaURJR12qPn3bLahgV55O/otRTBU0OhIYb32oTZd3zAmnE5tEWp0PZVgugbllNXITa1GGFbnJo5nAUl/SsxIH5liZdjYxq85xYb5MAIX7FMgSaN+gIvkigTA4TGqKiCcVhkwOmBJYtc4iC3X6Tfn2+IbsVkPQJbb59PypQ+p7LsJh2Nd2mXA5WHbHx09gNsPME2FKLQNr+kLjkcrsvBf6zzVbU1rik5q7nXtjixv7YScqQn2pq1w6zfdL+Gx9WT4upwn511zkKp4NPtl/HLhzfxdb8mSTHxh+RvHiRdl0uoRKcIq4LnPL/hjFpcNwct9OZOHf+72LNL6lTBKpgNxwaOXDODPzCjMHd0KuTbop0wJh8GnuqGJyk0C0Ejl11GfwQpteMLJOUjNvgub87rgaHJWRVG1tIXkIRFOKPLvQdr103rEJ54rKqaSM/JuWg6DUEySlNz3xU1DqdaAw5OYjOvw3DJsCTzf12Th89f/J2Bok8FFPoKqb6j4om2fpep9VrztClgNkjeMQ7XxEjATamwAWThI0QaxgnGmVKKXbYN8zQK2iO6T1/Gb1HWIhTNWwRRDW2WQFwhcs66nxeslPpPP8sS2OUWoY8LgiTSvfR/4IV3+0pu5KhlPXetToZJk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(8936002)(64756008)(66556008)(66476007)(6862004)(66446008)(6486002)(8676002)(86362001)(122000001)(38070700005)(71200400001)(54906003)(6506007)(478600001)(9686003)(41300700001)(76116006)(966005)(66946007)(2906002)(316002)(4326008)(6512007)(53546011)(186003)(91956017)(26005)(4744005)(33716001)(5660300002)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VA3lZXprFA09i9If0EGEk1ioq1bqV7qD7LrAyBoaNnfohwOOhhTtlnVxuTGC?=
 =?us-ascii?Q?beGSuGkiYygbL4mo0/IxTdujodgxm66484kn/8NySQbeBeozWOIwGcSJWHLK?=
 =?us-ascii?Q?1E2Z4tmJcQpQDvimzCjo2iI9Os82AZbaaXVa4pvx1MjgdigP1LOLx8QYxVgr?=
 =?us-ascii?Q?GdDk6uoo1rGWmjUutzaulzuIM8Ziha0A9CIVhV2dkAKGEWTGlyCqF/4PlM2D?=
 =?us-ascii?Q?G7KxOCgzyEsr00GAkgz95cieUnviGTwZBBpWQb2zcIA2hOuRwME9JkVCeel0?=
 =?us-ascii?Q?CHTKyn9Ne7/5qLntHwWSDU1U8BZu/rfAWvF7E2Q8uQwrJwVRRuH8qDnOyXiF?=
 =?us-ascii?Q?zaNiRw+JrgGHZvbe2C9nF77UIkwef6CPfKd7Ev5WXuf7V/qTTmKcx2He/aZS?=
 =?us-ascii?Q?8V/y593tpyvVlhcNtUiCcVEylomlYkSLaEbxz8Dxk+0j7uKBRoy/H30X/zLF?=
 =?us-ascii?Q?Z4ftBI9TcVjnVMV/UCzcM4Q0qkdCrAAM3HT6ccBQwV6D/hXJs4F4im7an1sV?=
 =?us-ascii?Q?V+MEfYGJbEjm+qXaW45O7Vb658ATqmd8QD77KrOisUdmtK4itNfRKhsB0rJC?=
 =?us-ascii?Q?g1Khi/9agSUQwfuoPAvmET6gYpBKyj1Pmf6Ba38NSGNA+AiZ2lkwwWcil2P9?=
 =?us-ascii?Q?8Me8A+s66MTE9JMEyJMSMTsiwKW9vTu59OWeSCM9PZz8XQmhHRGkca9G0vlp?=
 =?us-ascii?Q?jSSehERDVRaqYJI458waL38/DQ2QMGYFUKaX/jyoozn9BQY8l/IIZR0BVSsg?=
 =?us-ascii?Q?oVypJednEj1vQ/Afc3ImZPwt3dnBrxY1AZyNqYJuKXMRsw5hhnQiUP3/gb0Y?=
 =?us-ascii?Q?HlCOdH+zgwuAlYklT+aEPtdFaXWVSHeOh5ST2nhM6svtTSu8uTLEqyNKJZ12?=
 =?us-ascii?Q?8X8kQ38vLfNoQFRNqk5B+C1538VMDL2wXdlQf7tIUzOgS+nMrdHbzQwx/xnY?=
 =?us-ascii?Q?MwYNKg6l0DeyHzZGjoHez3GtNmKlN+H/A5kX2U7blcMKWTDjvk5ESXGeXncu?=
 =?us-ascii?Q?F57dSfjFa+uMU6eJNtEI8wTdcEOu5c+hVwoGcIuI8VKZTvFNUW+Sikz0ss3A?=
 =?us-ascii?Q?GCx2gZbKqq4xNu/Q/ympXW0+naXkW6aDKhgpylwJSfxRMJV7FQoOy4wZIP5u?=
 =?us-ascii?Q?+7k3rzAHKeGH8rl2WQRyJW7Ux+idvoKU+M22lifnj9aGTesfqMRESTWKIAhg?=
 =?us-ascii?Q?AbtNWNCGJlZP1wBkDA+ajmCiCZ1VXbRTBVEYYFzK67k4hmU4Yqq/cANQL7VY?=
 =?us-ascii?Q?3uFDxMiNIZT+uDCVqnAI0Crley3uIyV2eOhHJgy8UxwWdDH5P/YZTbOSbmzs?=
 =?us-ascii?Q?puRTdL4aM2LZPJtmzFB6B7yJIrltcEWFMKT1oJn8xJ54gXaJiRCeIqQi1164?=
 =?us-ascii?Q?glm9er6CuEMRgo6O+I1s7d64jCy7MGp2fa0tGYRYGIDcpp52emo7Cp7ZjkP0?=
 =?us-ascii?Q?X8LBd/xo4J9KemXJB1ZjBTzSyLKuLpxpVMlWCkWTYRUhQI5N5a4IeRw/DQf0?=
 =?us-ascii?Q?3MzpajANlEqoY3RLlAmY6n82Gw57OTF6ZgPXeOfl8fAvfWHicv7ROSxkq73K?=
 =?us-ascii?Q?uBM8Msm6q1/t0f1Pyg+RoN4Ppk+BIPP++dLE2xxft4usNzCiMHUwvJN9YlR2?=
 =?us-ascii?Q?Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <97B248F771304F4CB57172528CD9CFBD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ede450-f0d2-4f90-1ead-08da9c062274
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 19:18:58.7493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7GrbNf3cKEdsRniM1w0AtRMxPD4t/4Xk/cksuM0u+t7kGQlmBtHA3NhCO0VoyKmB0I3JK1XV82w1IstiaDcVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8322
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Sep 21, 2022 at 02:01:24PM +0900, Damien Le Moal wrote:
> On 9/14/22 00:28, Limonciello, Mario wrote:
> >=20
> > I think what happened here is there was related patches from another pa=
rty
> > that got tangled up with this.
>=20
> Niklas and I are investigating this again now because Niklas discovered t=
hat
> one AMD AHCI adapter leads to drive resets when the drive goes to low pow=
er
> mode. The adapter is:
>=20
>  SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA
> Controller [AHCI mode] [1022:7901] (rev 51)
>=20
> If we switch to performance mode (no LPM), the reset disapears. But if LP=
M
> is enabled, any command sent after the disk goes to low power mode (devic=
e
> initiated), there is a link reset...

FTR, I sent out a patch for this issue:
https://lore.kernel.org/linux-ide/20220921155753.231770-1-niklas.cassel@wdc=
.com/T/#u


Kind regards,
Niklas=
