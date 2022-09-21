Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91680C32771
	for <linux-ide@archiver.kernel.org>; Wed, 21 Sep 2022 11:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiIUL6l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 21 Sep 2022 07:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiIUL6k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2022 07:58:40 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7065F89CE7
        for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2022 04:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663761519; x=1695297519;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wyrr2/PsmNjnxBtmKH0Hw8YfDZjZrXFsPZSX2+5fBYI=;
  b=mLzAB4D0zQH2NUdFfaxntR7VUlYWE5K5qtxMY7Tp1/fgauoWC3v27iRu
   Ns4sXx0mPvqgXPIrFKdD/Z5xQkGCqDoPTksgpTC6qS2oFmNirAVVAhTWI
   pfMvpioEoF0pvDGKYR9N4e2jocjVZRu/NmWYghYpBTC8f0ytKfg5ZaSgh
   JOY+J39dZFM2uhEz1C51lPwccO8yIyjepK9zlJ1e49+I8Ezdghwt4aUjn
   i+3MuWvSEiNemZlNGuNNHYKDuz8IL6INgEmZM9MJHAViD3oIwk+YOgGWo
   HAdVSjlqYGABeirxX7rmg7Yrbmx8WDJRAmeZesU8VivT62Z04u73h5LsH
   w==;
X-IronPort-AV: E=Sophos;i="5.93,333,1654531200"; 
   d="scan'208";a="210293418"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 19:58:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTCkf8MrAlrRLfefuMG7nEIdSSHDZA4okV8gRLGo1yglMB+aDg3UvrJigAOxu5o46zrwBnhmKI3e1Ovw3riWYIhVC4JWFExGEgLqAKdTszaBSb8awkzxAYMAlP9IDfxGKDkjuXiyqgZRF+rWkS2SFX6XDSU+et+rn0jkG+aYAKfchqoLoI4zTDRAihVeNtMX5PIlVSqa+/LDpoNuPu1wWIuHJ+zXWqggmqObpfNFXmwtUXQZex92cAwrSG99W1XevPHnikXvcgMvv9uPh/r7ug6AsnFcD526HpOAER2waqiBlf0OFuLD1oXgqBobManaHZG7G8W9gdRa+kxmix1rJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4S0ajQZmBIyutI+YE9yOR4mNjW/f/TsMcssgYDqzYU=;
 b=i7O4h/h4l8i3hIjKwuTCas9IsC3jdgWNDpakaiZBVjzsyyoc4yT0aF18nMZA3nShDZbI+fBpF/w/Wx/fDBFInBUoz9HCEUb5N6LsbPLnkN6piR+vN0TuW7WEJOCz69Ul9dhQvfqm3Kgo/3QGpHdB/Tk9eRToZImpiMWrqfOt9YIiH09BOxO3UXaInFQsoB/8z1t/uxe5zi2v+ChHJN1aESUCNVvaLMEd4W7ca4UFV1SK1jUO233qVzA1MD/fIYk9PwXZOasaSGinYjrAXTYRRJ1gCnuLRqPEWhXYVuTm4MXb4FE5XikM2igqDTsMWFhDsUNFebuAmxB7oRNryu+XKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4S0ajQZmBIyutI+YE9yOR4mNjW/f/TsMcssgYDqzYU=;
 b=LKYNkxi+mnmJRdYSUJR4hu3YQ68xdQIBe8CKGtDAKii/BtFXp5iKx8mvEHtmfQLFCkNHVOIRw4leMive2a3yZZYdjvol2y1wvOXEOBOs9I7Q0Ir9Un+2qNkodJVRK59k2pRnWsjQf+DbNouB3zy1cTehG5diQXuv/7rJlbxfytM=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BN8PR04MB6049.namprd04.prod.outlook.com (2603:10b6:408:53::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Wed, 21 Sep
 2022 11:58:34 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa%5]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 11:58:34 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Multiple errors with DVD drive
Thread-Topic: Multiple errors with DVD drive
Thread-Index: AQHYzPHXLJ4Av5O6AkGhkxFRY031gw==
Date:   Wed, 21 Sep 2022 11:58:34 +0000
Message-ID: <Yyr8aV5CEOuChpre@x1-carbon>
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
 <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
 <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
 <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
 <Yym65wlizZydJ/Tn@x1-carbon>
 <9756ac37-6790-7b83-5840-abe04f8ab838@staalenberk.nl>
 <Yyor5zsqHAoNimF3@x1-carbon>
 <f3111c18-704b-1845-1d39-e220642eec34@staalenberk.nl>
In-Reply-To: <f3111c18-704b-1845-1d39-e220642eec34@staalenberk.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BN8PR04MB6049:EE_
x-ms-office365-filtering-correlation-id: 9fb847d0-4d90-4994-06d8-08da9bc89c4c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TqsBvcCfGV8DH+Vcj18qEAUoaoLZvoo5alZhZVZLA/p4cSCr2u7HSwqrB44cBSQtdpSFGpi6NNHqajgnHDr1pDz/QW9bBJJP7yF0/RChE2OhEIDiFrieJQuuW4WPy56kcKBf1s+d9YVpa5llqrSVOlkTARhDHbqOt0Qo4DBjIk+8hCrDmuaK6YPhidgNT20QthMGLLW3idgAG7tQWz/avAreZEqYrCDgKDkqFy+g1yUS9om5wNWqv1WCUEd1kzedv2cLwMNDJsQpsOvL+decHgXljriVLtWDWH7iO9BaWRN/eknvkZ1cOhngMaqJGoaxpfArxXHowCusCnPHnMGaIMo9Dkro7zuSnTRNn42ngDNvCrOA7NIuCBJO3r39AWLcG5eIy0F/tK/TxzntWcRJTFBVCehrPm9nn0GwH+gTvr3ZSH0c4vq9mmVPMaQxlL/Umm3zgCY5DmUKKS0E/KOiUTrbBOz7D4QQpW4+VWyvUsq5vAYarwVTy5lzDfmpEl0YvQDRfp8H7WQgUwvMVr/2EarWRM8BWUz06WU7qeBw0UIneLrUI/2jSZqLhQA6StdB5K203LoxTkIUeC0i/uepXjtYQFxyVCLX5dEvqwCxKMegbKjH0k2qWp9O18wWbJftFj43CspoMf01J0KkkWbSqUMZpqqzZPBnDgx/oilSVi0l5kk/ptqewz57kiVAvbIN8G4vEr8lhrALElsfgLFlh/HrlHUBy2yFyS7++qJHq8satFP90Xpnwwk1HbrAR3DUZleoHoCQsTbTge2L+dADRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(9686003)(6512007)(53546011)(26005)(71200400001)(41300700001)(6506007)(8936002)(5660300002)(186003)(6916009)(33716001)(8676002)(4326008)(76116006)(86362001)(66946007)(91956017)(38070700005)(66556008)(66476007)(66446008)(64756008)(2906002)(316002)(83380400001)(6486002)(478600001)(122000001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OmUEuLAN5/joJVZqhs+8CZO+ryAjsLelW90nm+64M9POMoNm7v7VsMZhv0My?=
 =?us-ascii?Q?jO8k+GKws8H7JzzM1HkHGEcCpcRY/kOgJdRAhkX+ae1HDcvbKRNHrNEJY4Vy?=
 =?us-ascii?Q?yhcxZ0zBIhM8WHS8DXe2Fb5O0r2rsdrBznFjxp3vFzjcLakXnXtVyRCI1Fg1?=
 =?us-ascii?Q?aCOpw0b//efwklymzF/qeA/PkO99DzRTajoUHvMwmshFk4JGSPkh7S59FMbP?=
 =?us-ascii?Q?oeoTvWz6QdtTkPhip+qp1o3X3hVCj4UPFTrNFHLYlBQ+Fc8ugZG2MiWEKNJ+?=
 =?us-ascii?Q?pKX9SlF7zsUQFFlTIMUyW8nfknn4Jjl0ihncUCDTZyk9KeyeuEYoDj1vvrcq?=
 =?us-ascii?Q?SLS+92HEP59LgfIbb6EqOL3NxYVJrnjoFw/8tGNrtO4ewTQtHCczLZ9LPbNU?=
 =?us-ascii?Q?F/2V4dghXRD8zOIVg856kWHWUrN4dMQut2sSAem0gmG/IZuNvtmsaQgkZOew?=
 =?us-ascii?Q?mgzo5mlrHyoBPwt1CxXzc6751RAYuJO9vOeeM5oq3gXR2rWFrsx6iyUSlKTT?=
 =?us-ascii?Q?ro9wY22vPjO3n4xlP1qTZ41uKVhPLSoQ0RfUbHoFyaMtFf093s7jQZT5Pfnu?=
 =?us-ascii?Q?cudRqiJQdatuE5mbOtWKXfRwTPAKGd4o4F/hEqVK3UTa7vKr7kn0W7Vid4Md?=
 =?us-ascii?Q?jVaDQnpQSShg6JhAU3U4AGwDvVO3opSw6606M6UyOWlNAeanHUZBpXHjwjY2?=
 =?us-ascii?Q?6FGP0V5kjWgwTNlIAIQHZm2XNGrIJTdbMIy23fUr2yy9ONQQVhZxWNPKoOK0?=
 =?us-ascii?Q?Dw2tHWQJTisALnNaCmkzC0OJRhP5HNdb6V48TtNA6oSkUTLtEk7Ag3V5LldJ?=
 =?us-ascii?Q?z7tcdUx/ZQMPD+TKBwnXW4KdDowXWD/nUgNhgw50uNk6oAFoSBrfdwaGjOXU?=
 =?us-ascii?Q?ERbO1meWNlgHSt26v0z4hzIQSHUQzwpRCALWgNHvLnGuMe5ebvYe2N6xOYT7?=
 =?us-ascii?Q?OV1levMY5P5NagZIirAQd7rumv1uVeqa5B9PnXu97fDRPGIOdd54UCaoeSyi?=
 =?us-ascii?Q?3CgW9eEl6B4Ci2CdPPpObM8VMjNJEbCuwCU5Pzk/KEhV/t1ItH/mqvm/3k7r?=
 =?us-ascii?Q?NY1tKeDLCsyFdN0D6ba+htAUGkKxuL8Le5ojH4n8M5Nabe3p4oPYLro/Ss0p?=
 =?us-ascii?Q?RrqFfqPJ87OM6x003w7+bzrQX1VA5rhaV7sPKN2+1METPz+Hg9ODmZT5UMcm?=
 =?us-ascii?Q?a7sX25Tc9gZW2nLSQFpoMH/Agr8HjM/t8RNBq9I3XWBOu74Hp8uaux+VRQZ1?=
 =?us-ascii?Q?DAokymdZ67hghyHXUiUrYXJtmpPn/N0EvWtauktv3JJm79I7E4m0RyA5EDqG?=
 =?us-ascii?Q?ZeCwpGURtYnq8AENYYgPKYrbW3I4wHwXShjDH3NNtQbUPGx9nPOYBqvWxQTq?=
 =?us-ascii?Q?kgrg2a3P+L0wCerox1044laAGBfR8ypm8qb+JtLr/ZK4lFLNzu3aKWQUQB64?=
 =?us-ascii?Q?7nr8jyjnhNZHQwoVOCQ8x+jDX1g4t8EKeTKgIbtvGpyodUhOJSLqOT31a/X/?=
 =?us-ascii?Q?d2mBJC42MxZacrckWT5aWNUOhjv3z5iTyzqWbfacSpIswLpS6jdWpk5XBbW+?=
 =?us-ascii?Q?FwY61fIhZ314YGVtDE8oh+ShzAgwBA6J7zXz+YgXx4T5e3FFEkCJpg1JUJN7?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6403DD7D8EB2E43BF62640F000DFE0A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb847d0-4d90-4994-06d8-08da9bc89c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 11:58:34.4026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KR2kwINAweoRQnIfynMXL3gMjc1vqKrCjNgaOSdQYrV4rGkb2JbZk0e9b0+JyvV12IDrO6mrD/kZ1+QMiyqHCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6049
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Sep 21, 2022 at 12:28:34PM +0200, J.J. Berkhout wrote:
> On 20-09-2022 23:08, Niklas Cassel wrote:
> >
> > You should be able to test this theory by adding libata.force=3Dnolpm
> > on the kernel command line on a recent (non-working) kernel, low power
> > modes should then be disabled, and the drive should work again.
> > (You can press 'e' in grub to temporarily add something to the kernel
> > command line, and then ctrl+x to boot.)
> >
> > But the proper fix is probably to add a quirk for you device, either:
> > +       { "PIONEER BD-RW   BDR-207M",   NULL,   ATA_HORKAGE_NOSETXFER }=
,
> > or
> > +       { "PIONEER BD-RW   BDR-207M",   NULL,   ATA_HORKAGE_NOLPM },
>
> I just tested the libata.force=3Dnolpm kernel parameter on my system
> running kernel 5.15.0-48-generic x86_64 (linux mint 20.3, base Ubuntu
> 20.04 focal).  I am sorry to say, this parameter did not solve the proble=
m.

Another way do disable lpm is to do:

$ ls -al /sys/class/scsi_host/host*

Find your device in the list. My device is:
/sys/class/scsi_host/host13/

Print the current lpm policy for your device:
$ cat /sys/class/scsi_host/host13/link_power_management_policy
med_power_with_dipm

Anything other than "max_performance" means that you have (a varying degree=
)
of low power modes enabled.

$ sudo sh -c "echo max_performance > /sys/class/scsi_host/host13/link_power=
_management_policy"

$ cat /sys/class/scsi_host/host13/link_power_management_policy=20
max_performance

Try reading from the optical drive after ensuring that the policy is
"max_performance".

However, disabling all low power modes on the kernel command line
should basically be the same.


Perhaps you could verify that your policy is "max_performance" out of the b=
ox
when booting the non-working kernel with libata.force=3Dnolpm.

Booting the non-working without libata.force=3Dnolpm should result in
"med_power_with_dipm"
(as that is the ubuntu default).

Booting the old kernel should result in "max_performance", since lpm
wasn't available/allowed for your AHCI controller in your old kernel.


>
> As for your patch concerning NOSETXFER, I will try to test this shortly,
> but it could take one or two days (medical stuff for me and my wife).

There is absolutely no need to rush.


Kind regards,
Niklas=
