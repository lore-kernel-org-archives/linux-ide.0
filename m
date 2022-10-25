Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEF4C04A95
	for <linux-ide@archiver.kernel.org>; Tue, 25 Oct 2022 09:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiJYJly (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Oct 2022 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiJYJlY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Oct 2022 05:41:24 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA3940561
        for <linux-ide@vger.kernel.org>; Tue, 25 Oct 2022 02:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666690880; x=1698226880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y0cA51t6J0ZWFY0Nxa3/LkE/SKxVAhLrLyTtkRRoGFc=;
  b=IrMRQIIVP5OSCjgQMGpSHA4pz0FCu6f5U1UIUZki9/9Wsb9jjfmgkdYZ
   qu6LLP4doyodThHu0OpVKux2SPPgoi7HhkvwJwyALMHF38z0rTrKMsxDX
   8XGIDTRs5MqsO61QE77g9lw8i2/8ZOLk45R/fwSZLRypIKv5rKXNkFZGy
   xOBjv9vz+NAidF13BXFMH88BZTrQ/tIVxn/6CQpu+CylW04W276JZyFxM
   OZqeFpkntbUCyEAoHD6vzvXnBtH/fm58zA8eVLmEUaeEuvD+KydL/ytv5
   OLLWcxaPX6J0R71RUjkiOOeX74nL3Mob1LDC2GJ9/Rn4jSgSbVKDI3+2O
   A==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661788800"; 
   d="scan'208";a="219834130"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2022 17:41:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDeSu6ltqgmZLLLvMiI28Jx5LNwSnUWn5YBlvMFHYhUlp/L7fHoINvIMFKmZ6PaqT2fAtSQ9PuZ7ErPws0pFoZNyuTiZkjaJa+LxStDSujcuOq6JU18xZIcnfWJmfupOLTFgOf3PcJkyu+ENjrZFXEt1m4OiJNAcCYDMrfu2ihuwLPfhZK4SrhVAmwAd9WoyhxByfcJmb+9DymXkY4TlLloLUocKQVMhUxTKKvNh7DrckpsVhyGPR3bVcj3jhETCI24/zvGl7dg24sznibaJ+qCU1oiUcPW3gxaPfJrIRLQOyc/2vCRKgPafoP91YC9t7k6nDUguUWhXKv9zu8NJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0cA51t6J0ZWFY0Nxa3/LkE/SKxVAhLrLyTtkRRoGFc=;
 b=AmnejvY10o8mQJov4OaqHcsV45IXL3+7ipeQsMYDKLY6LlHdPeTJ4TvM6m0jr4F8p+lT8Na/xzXH3HdKhDfIiBqOBY4nYi2OWtp9Z97GgDC57PsuX+CdVdv4IEaE3JFJsJ/c88K6LTYKrbTsyUeDah014dCfeonkt3FVQsIuP081vTu4kABXAMNi1MPdhjiqO/Zl/MTGo6MzXq65Jr19pcgHca0HlYq8jVsqXUzAo84p40L3NfixtUtdosj1LVA9ket8cF2HcQ7VbAoJdaCK5x95rrKhZd9v2DTtKSDOo/aQP92jRZtJgxGMEN8gOS7RqBs+oj6gFP7re47qW+CP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0cA51t6J0ZWFY0Nxa3/LkE/SKxVAhLrLyTtkRRoGFc=;
 b=lEMi3vdT7txR1sfONQMQFrANMbGh2nyKheP+Sl3R0OYjiUhjImlQmpl7ye8EVytOExK62O59Y7GYtujw/CmcJujcM+Eof3EgKuIfxsO76yARkXM9ZIop+jQ5VzJU8nr52pFI8Y0VYdLQvw2UNwAYD4de3MheaNuPQj2A/3A8Exc=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BYAPR04MB4839.namprd04.prod.outlook.com (2603:10b6:a03:14::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 09:41:16 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8%7]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 09:41:16 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Hannes Reinecke <hare@suse.de>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v2 0/3] Improve libata support for FUA
Thread-Topic: [PATCH v2 0/3] Improve libata support for FUA
Thread-Index: AQHY6FXs1COvvQjZq0qgbQYUPoYJEw==
Date:   Tue, 25 Oct 2022 09:41:16 +0000
Message-ID: <Y1evOwYFOIi/r1/y@x1-carbon>
References: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
 <f1456224-f644-dce5-15ea-fecc965788e1@maciej.szmigiero.name>
 <1401aa25-38de-c5e0-f9de-7aeb7ce0af9d@opensource.wdc.com>
 <a44337f7-3e8f-abcc-5695-f2e571087e8d@opensource.wdc.com>
 <709fb497-df73-0ee7-06db-1fb4c2e50cf6@suse.de>
 <26def87e-6e44-17ae-f928-030c837c9dbe@opensource.wdc.com>
In-Reply-To: <26def87e-6e44-17ae-f928-030c837c9dbe@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BYAPR04MB4839:EE_
x-ms-office365-filtering-correlation-id: 63add0c2-b82d-497d-b282-08dab66d0ff3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sU9ILW49mL0cYqdNgGh/+5kchRSx9gDC49Guv9u+sRj+fPaPtpzC2krYmriugGIWxHs32GsQXzWcfa17cWy4VnHEzQx8o5FcjGhPECUhpuEGaLlhDzFr3V97hMf+gjYtpIQLBgqOqS0ZC0OFekuZ+dQXiHUI+QYAt+fc26B+b8+6P8aQMhIWPjw69bMevQJcPZshihyx80wOwuPthz9GpGbxEHl3P5eN5ZFd3lJVbSvWsZ0zDVY2PApszd9UZOKFuaZknLhDdr0gnQQ3vnTplrTWGzBVFv7gcdwtnPlRcUIoFAz9L6u3cCQlZbOzeO5cjXJ/wbxjtXSnEeAJTmDY4vZ7NrpRYQyrs6/4lZb3US8BUg+GvlrpJRFEwbIrv+0muglpoMExKPXuSy+xbFXI6zm67YU9ziEwUeKTVg+jeItuTpf1gHHSrAuADCTS7xYh5G8af/BjQNA7IFeejdbXJ/ytMt/kI/S3wv+iRMNRpfgs6PFuUg1RxGG3/MYGz7YNfZ6vhG/3ijnqJaKAQBPWAlxQsPbDRwyc4L0hUETCsfc2MD8PHzwQ+KstD8BAkcZDjJ8VZsg/wFQ8MKvvpRTuzPHjWhlscw/erbSNHkY+FbCk3dnFmumFhrxBrY/6bAyAGxReEF8fQqWO90rKBu9Yz0h8nxHecSVFowjDmsJ1aT+ipp4++H6nwBqcxsvHsgwA8IFH6WQo7FMn0fm3nu+67nykVOb+TezqI1WKGMfXgShkdOaNuOe/LbH4HBSuoeK6re+dsp5/4qoBETP/Fb2Iig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199015)(316002)(122000001)(54906003)(4326008)(38100700002)(66946007)(64756008)(66446008)(66476007)(66556008)(8676002)(91956017)(82960400001)(86362001)(76116006)(38070700005)(8936002)(478600001)(6512007)(6506007)(9686003)(6486002)(26005)(5660300002)(6862004)(2906002)(83380400001)(41300700001)(186003)(71200400001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cpuraI9RyN6iaoEGoFRLt/mG2O+BD+zW7+snPGqcXC67jLTB/TMMCsMAmmvf?=
 =?us-ascii?Q?6TRBygYDjUlq0X4s2M1CABZQlkDdZ2yYAKKRxw1X5OpERI3mqnMV/nbJQq/f?=
 =?us-ascii?Q?2knzASy+K5dVbkx4sP9IilLPY83wka9Y3jtapQ+OMLVKSKF3bjqFG0E0pXrd?=
 =?us-ascii?Q?498+e+hANVjjgTZTHymoECAbOHmiz/xXi+Y8TbhqjmqeB4odlzMiMakqLDm/?=
 =?us-ascii?Q?ELzJctvBnVkyQxZzpN/2smYH7p68IFA+099AqlF9hzhQTQehykMVJiyOqm85?=
 =?us-ascii?Q?J7qKUlo5jxaPIcojBdAkVmT8h8t4PPIvJ4gXVSG2h3gcJ6CNOp8+Q2I0UdpY?=
 =?us-ascii?Q?Y+94uBN8KmuDjd6k7EolOn917powCBIUE3u0LGUdThOT1DZrnqV4JBDb9Zb4?=
 =?us-ascii?Q?hn3Ri9m2Dscb+flCg0qMhoYsgJQG7ymg2axiuIDzEgOsWTNPlxMsRXVZZZKi?=
 =?us-ascii?Q?npkVDO+AeWve8NQCLPsbnK6m7XalJ32G6Q32fz6aa22nTc6JUQzWIAZJRd6T?=
 =?us-ascii?Q?aq7SS+F1SO2UzDM/ywEZNPk2YGuOIu11WQmrqHwZ12gKW6rMFxtR28hFlQWP?=
 =?us-ascii?Q?t4rqjyT5epIOSsCEzRC1zL1MbuPYMfpEZxtMt2eXRgS/uoXY1egQXkL8AAPv?=
 =?us-ascii?Q?5Zpd+UysZyO3tJvgoM83ibW3Y47itP71d45ofpqPwhh12lCwd6MYbZfbLXb9?=
 =?us-ascii?Q?ibNItwwHpB/Kll7ItupceTBmySJDGzr9qXJN1af/vr5Px4TRNhUHYjX3wqvW?=
 =?us-ascii?Q?n145/pJQW372ayfilUTWOOI4s+wNQ2uglT2fEE9jUfAyZv/B+QwLDsrhbLYO?=
 =?us-ascii?Q?fgnaIUWH3Er5QqOLLlZ5nSeUa0gqPR9DExJR4L361rCJK1p7TcPm1tP3tPdW?=
 =?us-ascii?Q?qqu9KOhOCrIZ7xZfLBR6yqqAllJin0ecesdezYaKBdcuhxBSiTh7Ew7OkDRF?=
 =?us-ascii?Q?y1UiuPOTKcWynVVLSM9en6JU46RgYQzMazsytlbWEUXmemLAnYOZXbC6Hx4c?=
 =?us-ascii?Q?F467w+DhpdRdyzjHlkI0aeqpuUMy3YbKUASt670XdaY+g8VgirAnm7dwaozL?=
 =?us-ascii?Q?cLlEEctFGlU+FI5V4JOXrmRSZ+ms45TSdwjpQie/vmjZfXntcQF7ISNyONdB?=
 =?us-ascii?Q?UEfrd7eol/9mwn67Dx0cwIIFsPlqkJgIZR0GUll8LslQv5CRRdPC6Odq5THM?=
 =?us-ascii?Q?MWQbJNZGppad8bvZ6phZKCj0cyk1n9/ZuJDUbGY0VDyUWvYSAwFg8c2FdqWY?=
 =?us-ascii?Q?GDDj8bMYy7Y9YAjTElMgapohtOK0vTcS2FqN0OWu5qIcyhybX7loUtBZiles?=
 =?us-ascii?Q?riBjen32lUL2K3xk5OvJQO9vJX5MhzTXUPUYGpchf0soJthLUy9vIgQYetnM?=
 =?us-ascii?Q?511kkbO0YDvlQZxldoMDF1FU7VayI4eVb/KNSuYCdx6EeWHWIOYb3e0G5B0k?=
 =?us-ascii?Q?GLpT0e4zvWoMdAwStHuu8IHP1YEKtmpUwWl/JDeQXm508vUjGf2y3gghnZMf?=
 =?us-ascii?Q?oaUsuZEMfTr2+rL9ROwAZtnETW81XQF0JW9E8eOUBA+31fmourLbzMFl9NTO?=
 =?us-ascii?Q?HSg4r76s+7fZM0osNlOyuZkGeP0lJ8u/6ijK4FIrIfFfkytT925clCEJZl5z?=
 =?us-ascii?Q?ZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19F63464B17C9345B80C3432CEADBA56@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63add0c2-b82d-497d-b282-08dab66d0ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 09:41:16.1509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9a6xc8kmmJvizVGBNspr2Uj1rW0BKJYTMRR/eTvbWuXIeiOlZhHk469vgTtmkr9lIn8ZwiQKSCecxcvB5yHKOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4839
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Oct 25, 2022 at 05:59:07PM +0900, Damien Le Moal wrote:
> > Sure, that would be the way I would be going.
> > If the drive supports NCQ we should always be using the FPDMA variants,=
=20
> > irrespective of the queue depth.
> > Additionally we _might_ make FUA dependent on NCQ, and disallow FUA for=
=20
> > non-NCQ drives.
> > (Where it's questionable anyway; if you only have a single command=20
> > outstanding the pressure on any internal cache is far less as with NCQ.=
)
>=20
> Yes, that is my thinking too. Will try this and see how it looks.

When there are too many NCQ errors, flag ATA_DFLAG_NCQ_OFF will get set
(but queue depth will be left unchanged).

Currently, one way to re-enable NCQ is to change queue_depth to 1 in
sysfs, and then set it back to 32.

It would be nice if this method, or some other method to re-enable NCQ
after encountering too many NCQ errors, would still be available after
your suggested changes.



And if we change to always use NCQ commands regardless of queue depth
(for devices supporting it), because it provides us with additional
fields not available in the non-NCQ versions...
then I think that we should also consider always using WRITE DMA EXT
(on devices supporting 48-bit addresses), when NCQ is not supported
(or disabled because of too many errors), since it also has additional
fields not available in the regular WRITE DMA command (especially
considering that they should have the exact same performance).


Kind regards,
Niklas=
