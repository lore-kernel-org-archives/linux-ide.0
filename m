Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D381EECAAD8
	for <linux-ide@archiver.kernel.org>; Wed, 21 Sep 2022 18:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIUScz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiIUScw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2022 14:32:52 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214D2A347C
        for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2022 11:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663785170; x=1695321170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VB4mwzAO0fmd2MyKO+eEXNRQSWa29nyRtb6Xg4B4rMU=;
  b=FJTFCaiAtdGBOAze4FJKM167dAl6l2ldSNjDLAzHkBxKApKsJ4klKS1f
   9z490TTcJFBuupQpLY1z8yJb91qCJ2+w4AMjlS8/0OxWYxHAHH3cynHWP
   Uh1sPKxp2He/1e8+RmkKZkJMYV/BWYVESs4g/EUV+7tcjz03TBptxsCNE
   cMaD6Oi+93uDW7E9A7cfF74/QLmRAlpEn6/0en1QyfHBRQSvs25xP5gmX
   bYjgG+rQbpGDEkqoJxoK7WxDyeR9vnCFtuCt6Lyux0nHQjT13P870O/Wz
   REmd/AwdAl6sx+xFurqZub2Y8Q2cNCVAvAMbSN8J659zOGkgWuYqedl30
   A==;
X-IronPort-AV: E=Sophos;i="5.93,333,1654531200"; 
   d="scan'208";a="316224104"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2022 02:32:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPbtKdu4rnWb2stBn1QCqxfiWxbJBJOi35ggOmU7UCoDwa3gHIqrqJQvLb3And8ei0EjzesCyOnjFkR6Y+oWBLftyU9ww8bZTax8Hjba7Z62IBXsrZaCC090/5TKUq8Xeo05g5GGK3awrYK8U6Cdp04wl2RctTZMDWpxpB86p/FcHKOJYEqTds36MZ1TQ1ptSSi5Gb3oPPeC+jYpF2HOQEnze7zfRBnnUbXNhwdV0a2J9lsVWHRZLK8oWQDenRzAzRHTq3/0ZdNiKOGd5Qe92ibrMxbYe/Qc6uz9MDg804AGGaO7YKWlmmqKqLS8dat34qDaSaM+eJKXZKRLTKVAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CS7qMypgzd5bQ/HELR3ZkKSp5TSXWkt8E+IKqDlBZE=;
 b=Y2E1mxL9Pf/MQc8th/JWNPm2oD1+Af+JSDgcRPYcXSZf6DVYV1XTEJGejEqeqDOrC/ubifdTKj+W0SzwbA5ie+VbZvw2mtWwlXQcTB0Jhsm4I1UKQ8WfZ18Hbbz8dRa6LZ8N7DrP8YQ7MI5Rq7hql65FV7gRcFADcpT9lSizWRHNdoP8UHSdB+wTp1jxF1ywHljpiFrNn83e/gWoFj4i7n0uzE4nx7uRvmre1cYciuQ9v0+27O4WyXdtXlRZ77twKuVZTRg1SNhq6R/KFqG0C5vAnvgq5/Vn5Mt4d12VvdgLCrEVbeF3Y7mvHFu/9DPsj5ic/CGBOn1NJZF9RqlD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CS7qMypgzd5bQ/HELR3ZkKSp5TSXWkt8E+IKqDlBZE=;
 b=zLApuQ8ZW9mGKp7+WpoWYsX3CsUx1TUaDryAF19f513SooNwlyYsvs7AfSNHy/9cVcSEDFtl746+MALfagsKfb5w7z640TqV9bdLJbT3GcQugWxbUuibMBLI1X55gZcjxEe5CSi0C7kgldz27xvop3987zOa1oogydDr3lMDT48=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SN4PR0401MB3568.namprd04.prod.outlook.com (2603:10b6:803:46::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Wed, 21 Sep
 2022 18:32:46 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa%5]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 18:32:46 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Multiple errors with DVD drive
Thread-Topic: Multiple errors with DVD drive
Thread-Index: AQHYzPHXLJ4Av5O6AkGhkxFRY031gw==
Date:   Wed, 21 Sep 2022 18:32:46 +0000
Message-ID: <YytYzTIsqcB9nElM@x1-carbon>
References: <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
 <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
 <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
 <Yym65wlizZydJ/Tn@x1-carbon>
 <9756ac37-6790-7b83-5840-abe04f8ab838@staalenberk.nl>
 <Yyor5zsqHAoNimF3@x1-carbon>
 <f3111c18-704b-1845-1d39-e220642eec34@staalenberk.nl>
 <Yyr8aV5CEOuChpre@x1-carbon>
 <e9893bab-f2af-bae0-18df-924f9ff4652f@staalenberk.nl>
In-Reply-To: <e9893bab-f2af-bae0-18df-924f9ff4652f@staalenberk.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SN4PR0401MB3568:EE_
x-ms-office365-filtering-correlation-id: 4cd773f1-8685-4946-4664-08da9bffae17
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FjvI8pZJNWS1I+rAse/xkGXvzbnPRR+IwtZQ9ADrOqG3qnwinMcDYJ8hztkKDTJEimuwVRWgWUImhhSh81dFzvbi/FY8Ru+lbbpJb2jbOmBjM1wMVlcNwpJAfIgr42UyDwk+mseZvLZQDjgRKK0TOyKHy/Otu9JysFz3xRq0BGYdIoUyMAAMB1FpWidxI8jv98o+EtD1FhnRB0jqkC4879lq+2jV9AeKQe3+oq1uS1BLUQpjGRvYZvZqsEbWCrtGdOOW00IX3bV+WyjW9OsQXAv+mnXuRkDZN/+33DZFYkfRxMAkxI7G7uUNKh0ObaerqztcHcZa/l2lJk4NLb7P66y6YF27IZXd+IzCc4rFZisPILAp8Cf3ijB/xAXeMZ5eE1G8ooxrBpEW0gJiPnIYcIw7kifMlFWwEN3Pl2u+TCtv7G6rO1d26FLmtof8fU92A/h75dEGtwfotW//bTS9dZG6scftWBcVlJlmPubYjHxHP2aq37HNJEHi08yk3Or1o4kMtERrcqAncBc4Q7kLGvd+OUrSig9zp5230wftde5zU4JOFTU6EpM4JyfXsCTk9QAlDv4+Lu6mCvyghHxW/ZVpPnDTtWhTWPJdNCWjaIegagl+UfGHSKaOkcAS/egW3bwDMQGcYR5lOPHLAd8pPNJFgggbKCPfWfVZzRk1zPuKF3s5pjqTB9azk2XRYdGZ7xcG3/Q24wGIgOaNSthwMOhRCR965uFg9qTDaH+ac/xQj40sEfN2ttQLFS4DbJVvoeAM8cQS27aFDBO8T9M7Rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(5660300002)(2906002)(41300700001)(8936002)(38070700005)(478600001)(33716001)(186003)(6486002)(82960400001)(6512007)(26005)(6506007)(122000001)(9686003)(86362001)(53546011)(83380400001)(38100700002)(316002)(66446008)(6916009)(66476007)(66556008)(8676002)(4326008)(71200400001)(66946007)(64756008)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8J3Oi2abrH9Udi8sGaNDKJl9Th5WJqfnWcxJWKDi/xrB8jsT4E/7uL3R6ADa?=
 =?us-ascii?Q?aaogTXLX62d3HIu7Fy69fQN1dveSYHPA6eha6vtcrmITyCWhNFTcrbgPQyRG?=
 =?us-ascii?Q?0RQHniJLchPCYKm4qBCI94vlxk25q/33SZ8MMf6FlUnMC6Sb66VKurj71S9U?=
 =?us-ascii?Q?B4n3sbHrfxJWUTja7x46g11NrQq5BTaZlkzjXalNT470965N0IyngoCvxxoT?=
 =?us-ascii?Q?L5/8NNH2kDX6CvCq/I+thOeGB+qc/C7wy1TUSfro+KV+MkpcA7g3xQDY7d5Y?=
 =?us-ascii?Q?whk43Sx4gZKJlMK0Tg8OWNxQg/vrcwPavDVsTPx9GkH5s4j84uYDwJycFXcv?=
 =?us-ascii?Q?Zx/EoMwzSUgN4VrHWGOVvshcl82DP0SKR4QJD7vi1/1g2xKz56JSsWQXDX8Z?=
 =?us-ascii?Q?/drTauqZJIsma2bG4PRnrwKCxGods1PY9Jr/od2F4wCWIWeXMMcxk/dLlEms?=
 =?us-ascii?Q?RO+sSJ5nZsD/XQ68E+OgKtmtcvXiEx4AVo2Q5kaL2TUAr6zlL7RlWVdxCxlY?=
 =?us-ascii?Q?PNcyAoFIOJB4ixDDXOaCax46DQmT5HMdVxmgu3Ul8Z+iU2jGe+9q1Fm7cc+B?=
 =?us-ascii?Q?ffjkOEVo1SCrCNsb+dya2JtMWUBqIJd04XM4j0dw9EvgL+T6vpmGQ20h5K0y?=
 =?us-ascii?Q?OPP9gxo5u1GBb13nNPzv4/IjpBOb1hOjtoxIJQPIpnUDzhSdrB6rvAaTY8Wd?=
 =?us-ascii?Q?sHGdoWkdSykQjDgBhpazPNHOfD789yXvLuG0EUg2PMv5lKg2jHRt9a5OHt0f?=
 =?us-ascii?Q?2rIf9+qbkHYB9uzmntolaOa0+1VihG1t8DU+wEI8jZ5DF8hFkhWEGDIxMo46?=
 =?us-ascii?Q?KmxMDCeR/kNLI9TnFK9F5YHI+vYF/TvI3d2y/QHgPhCxoNar6D7w/2d9O4Xh?=
 =?us-ascii?Q?2AtkuFsBncvW2G1/N90EP2DwcK46MYKGvRDst3CQOkUvXLDD6WW019f57SZV?=
 =?us-ascii?Q?Tf3xJ9ai/fR0zTcuU1IN0NDBa1CrEJqMpoz12SqYvfQZsGxjbWfCMwfgjwal?=
 =?us-ascii?Q?wrPcrVD8jBLFsxDONK5Hpy1q8RzJ0EXhD8m9DLFJ1Ww1fV4BY1jHWe8X0285?=
 =?us-ascii?Q?fjGaOLQqTXv0f5iJZFUJGKt6QWltp5GiXXsqZ1J6cTDlHJ4csTgXeSxbtuph?=
 =?us-ascii?Q?AWfbRAsWudIhMP5ZOGVEysMeoMP2/SUbTRdtpdjUICs4pMdI5IZxMfVe+T9p?=
 =?us-ascii?Q?lmIPWCw0hyclU3Z5yuTi/40T6obgwvJW2GgajNqDn6Ba4coC9SIsH0MdHJOt?=
 =?us-ascii?Q?DUdA9xdaVhVTCB8nHorZ3pKjWCxcHBSTrf/GIEvx1IpLBNcil2627+cjZYFl?=
 =?us-ascii?Q?xVQJDcf61P6l48hePMrigU3xX3UrHhXJ8QGgMRzjuZWneCUiun8ueKcq1gJL?=
 =?us-ascii?Q?tSA6/N9UKrp0rgYpJxKonGFNsdyZvK0Nt4x+7sw8I8csBG6/WGUhzYDKR0kd?=
 =?us-ascii?Q?rrKJdO4HMfvo702xw0yWho4tbqFTsXNArwTejwfhUadcEEuT6vh/MpWpEkxo?=
 =?us-ascii?Q?zNM5FVWQbkegaf2ikRQmvMSxsc5RW2r49hli7WMpKqKzDrUymtOuwV+Yoa75?=
 =?us-ascii?Q?NFzyezK2uXOpGkCbK7FBmZyXuGkfCsrRs5uhTkulteWulTOucEEuPZV19w20?=
 =?us-ascii?Q?vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1364B46670E3EB4C9BAE34ABEB8FBA52@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd773f1-8685-4946-4664-08da9bffae17
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 18:32:46.5760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pc0N/h0YxMh5to7oeTx6fe7VaGlXLAxrUKsCFmVAGNDDKvFCiMUlmz/kBmn3fFprleZZ/1v9zCLEvWR+fACBbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3568
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Sep 21, 2022 at 02:38:51PM +0200, J.J. Berkhout wrote:
> On 21-09-2022 13:58, Niklas Cassel wrote:
> > Another way do disable lpm is to do:
> > $ sudo sh -c "echo max_performance > /sys/class/scsi_host/host13/link_p=
ower_management_policy"
>=20
> Yes, this worked and did the trick!  Reading without any errors.  I did
> not yet try to write, but will do so today.
> When booting with libata.force=3Dnolpm  the link_power_management_policy
> was still med_power_with_dipm and I got the dmesg:
>=20
> [    0.291452] ata: failed to parse force parameter "nolpm" (unknown valu=
e)
>=20
> so the ineffectiveness of this boot parameter seems to be explained.
> Might there be some other syntax for this parameter?

Apparently this was introduced quite recently, in
commit 2c33bbdac28c ("ata: libata-core: Allow forcing most horkage flags")
which was first included in kernel v5.19.

>=20
> Nevertheless, my problem now has a work-around and I am very happy.
>  Thanks, Niklas.

Great news!

Then I believe that
+       { "PIONEER BD-RW   BDR-207M",   NULL,   ATA_HORKAGE_NOLPM },
should be the proper quirk for your device.

If you could test it when you have time (again, no rush),
then we could send out a proper fix for this.


Kind regards,
Niklas=
