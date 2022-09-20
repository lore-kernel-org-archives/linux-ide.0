Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A52BC54EE9
	for <linux-ide@archiver.kernel.org>; Tue, 20 Sep 2022 13:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiITNGy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 20 Sep 2022 09:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiITNGw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Sep 2022 09:06:52 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1855AE08D
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663679211; x=1695215211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eXLUjXCRbV0F/JUXjIncP1aJi5VmGBIzRm6vJczy4D0=;
  b=jG1EwzvH03fcRejhLNB/16FvWtUUFxk7fqiFO6WYk0lRUNmmUjoomNID
   lM8ELXB/02+3ctZP7gxBa4HKG5o1UQasqmhHTSOOnZ3cveAGnqvHb0NuH
   vrwTevGO2aUSE8FrqtLbqkrlY6yy7ki20ZdWcWXKUB/ykvMpKNUf3vKHn
   74VINbUZKJ0YBXFqWoPK9qYAnHV9wr3yrItobu4hfXyotObUw0I3f+WSI
   K/2P1fry5k5Dni3sNbfXt+k35YZg54T5n2d5OEc4HyvfdMBNuvmdrNFRM
   U2r7B6wPHAwK9hZNsf6tQbYqX3tJcIFg/FPK6vjx4H3t/Vz2oz3abwWeY
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,330,1654531200"; 
   d="scan'208";a="323917567"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2022 21:06:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJ8LIbKDB0LX9EObmFrjEmjdUUbH7Ojfpiw3Hx2VmnfQfcVuY2ebqrsyv4xM4UwN8r2sZ7keNdNgPsJO2uVnnlIjLHM2NgaCpvIvWsK/aNCZJR6CnuVbOxAhpUxNYYWe6bcg0ergLKWjO2i8n3aVlgBqisfnDv/QFUkTYTpaUF4UXL06rXNFD+4Rx47DiefSo3d0XozeDhvd/YTJ3TNyjglAC5JdM7LwxY9/Wj9xGowDx8mG+UJ60gTEcABVjdD+SpilYDjILW+sf9wXD1Y+Lvfy9hqVn6/KUoXaF6YEiIjRDJoOIWJAhEmvHOMD8FiSwQm0xQI4JhRAngml24dDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNMSGCZbtx8ta2GOF5SKlSr8f53O4WaQYwXmIrDmTNw=;
 b=IQM39Qi6VKS1LCkW71tOTBuz+6ScD/V5UGPU1PFjmZDGcqgqeuBBbOHQGEAUypdn2pAzrKA/Y0fiZqbFajAExX9w0PKL/wXEs7py4CzK4lwGxTzLr0GXK0dCgt+BcIom3BnuGLViP//kpxLURg0MGAOypvitNPWNV1HDg79+i3ghEz43QzvxW4Bjv9iyNDkZ2LDXUqiHcnAGxdhmcdMEZvEQz2YfxDm3MhTQdtAu6aNnMfplm16C0RvfSP3CTQ2ebWihHnmLcJZbdPrFoxLSEoJPJQ4vKp6fbTOgHOf/Nu/o4kAl6tkkI/V5KGj5wSjE+8Qv0USWsMgK7Yk3gNYt3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNMSGCZbtx8ta2GOF5SKlSr8f53O4WaQYwXmIrDmTNw=;
 b=CdcE9AevwJf7jvhikQwxstwDd6kKz2nGNvmBRbgflxPLQyfdhvh6IXo0qafH2DOm7p9w+ejIZjgqMIHI3y4JkAfZcVjvXwO9+0tScNZ+e+BMVBsHkjPc5EfN4HQ3dkE4VSFTIO3W8AYZAPKdjtnWmUJuyN8WNmibJdLybPWRplU=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BYAPR04MB4917.namprd04.prod.outlook.com (2603:10b6:a03:44::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 13:06:48 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa%5]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 13:06:48 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Multiple errors with DVD drive
Thread-Topic: Multiple errors with DVD drive
Thread-Index: AQHYzPHXLJ4Av5O6AkGhkxFRY031gw==
Date:   Tue, 20 Sep 2022 13:06:48 +0000
Message-ID: <Yym65wlizZydJ/Tn@x1-carbon>
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
 <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
 <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
 <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
In-Reply-To: <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BYAPR04MB4917:EE_
x-ms-office365-filtering-correlation-id: f424ca7c-43fc-4980-0f43-08da9b08fa16
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PnJUFcre0MI2/t9N3spz6ITESN327p7syVrKAZdXEpulLJoeNt4qTzWfiyZPrvpTR+tSrcel7l83nlSMOTPGAkQPGf5dUr97mznjSntPFlPo/bCOT+Z5gB1JxXd8SYVWRG8r/FRgcUwcoUJNxZfvIRBd3WGrbpHafIih7RITQXBtEb5e6zGgOnBk+kMbhIEOfgZgCiUD4oi/KJ74tmzREo/HJXQwhXCUu+vCeIahCe5wgNO1fLNXD5vsY9nVAedKSicSinKxyybmZaNfJhzeMyMpj6wBiSl9165e2Z6uUnC+8q1TpeD1GI4bxnX5lVmF411h0KKzFo3YIlWi3p2Q3IZ7tpkoYZ9K+BWbcc9LhMom6pvN9OqLC/Rbjo5mEdFk08PIM5MLL5MWyp1IB2DyMeQHZlVd+bUUKBc+n4aC1jwkh9mDjP+9OFTJPTxU+ZIsdVhaz8XuP54Mjj8T8fJGmTiPLEcn9rKV5hq7baZm3DkXdnI0PtxWW84AW2CEBTbz14q6rD/DoFyGj5bTWUY238VzEcY5mDIoSOLkm/lh+bKL+58teX34U3AQd7cm+MCiQnNJ8oUHPcXj0QvUleaAlluL32mfMUllJIUj9T+tKpBv/2fG+/DGeJzQnTuSxxgcoVxE0E8f0n+oEIZN8/C1qq7hpXCq/r8lUa8ThqEtXWBBmalj7hHqRciJOfVu8O0q7LeVk6qIe1uRPVXoy40SX/1+orNtIAFNj/5Y/34HUbA8HXW3tPFxtoLewZmPSKy5MyrZlJL1jISB4UUIuaZ2F4UiiMTdJgvnhVeXNOdrz9U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199015)(966005)(478600001)(6916009)(6486002)(316002)(38070700005)(5660300002)(82960400001)(41300700001)(122000001)(186003)(83380400001)(86362001)(38100700002)(26005)(71200400001)(53546011)(6506007)(8676002)(6512007)(9686003)(76116006)(66946007)(91956017)(64756008)(66446008)(4744005)(8936002)(33716001)(66476007)(2906002)(4326008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EocQsCssTc8zz+xs0Uifm+JhbLozZ7I5tyT566SmmM0IdtzjQOwIN0LTVNUG?=
 =?us-ascii?Q?q44a5dp3j470rMWTPg5/M2H6aQwlnLvfz2CdItdX249b0urcFToCu/wfo63o?=
 =?us-ascii?Q?8gKTvnikOaQwag9CfnnbzVG3uVgfVasOXoqrKZzy+CCgxnK0GGzwiDGPy3bU?=
 =?us-ascii?Q?/aSAJZ9aBkiQFtBhTtACG+Y/FUKC4PMpSDmH1sApUHcDbiRFPG+vycjDz2kS?=
 =?us-ascii?Q?0fZOSQlcUZxvcoEWL7rGDosSs5SjsBzw4ZIVZYGdBDvi5p0oU7jBuI7t6nHX?=
 =?us-ascii?Q?G4oMdBzuHXj+QN8bWwE9b5MVNJSGGQV6m/lFGiJoZjjUcbli0dC2f1E8xgae?=
 =?us-ascii?Q?dhj1bxLr5uPwFkx1f9kl/OHXqSEhBGYTvCTd2UBVIXV17oiacvrJcxe2z/6i?=
 =?us-ascii?Q?63/j5S/UCVed/rNdfVpxyLf5vrOXAyU/Rgbc9OPObMHJYhXXwNv4AAuGtEt6?=
 =?us-ascii?Q?Qj/38rQi8WSXkQrJj5CZeaqVFdbWbbgkmki3/6FPtG5fC64cXb45Tdm+Yy5V?=
 =?us-ascii?Q?FRK0Si+iq/5d4QDA6VCfbERTfnKbrwpiFJlACjAsEdTba3mYgdBSDvrLfkJp?=
 =?us-ascii?Q?vM8ARUgdDMaLbaU3SU4qHjrcx2M5WTvwIGCF2L9VaV4ciEzhwDB1UkPX7tfi?=
 =?us-ascii?Q?P9dzDzajzxI72PR2TAATHuZVnu54H6SqYStO0fVjCiVgwU7Q76VxdT74XoWo?=
 =?us-ascii?Q?ZTgIgLFeMchCUzMj2sOuwcKX5vnL+cN4Fgvj1k4hMov1Q8Gv8+033UUe7xpp?=
 =?us-ascii?Q?oAz566t4Q5LcM90SExbE4wU+KSrnBCIjn2GP+vRCs1yfs7r1LIXGD8/uqF3a?=
 =?us-ascii?Q?o/AzZJbFVe2P5YRtbPnk1+cQAfNJTiOlPMNFVIrsE8GUAtbEi4XVVU9cRQDZ?=
 =?us-ascii?Q?HnvwIKIEgeFdAyr6iUCa83KcYji2nTfm+Yyt24tfmZ8khQQLxAxdq6g4tB8g?=
 =?us-ascii?Q?T/TIREF8v/b8r8iNRn8GfOBdroa+qSq5BctOHMCGpph2P8xsJaczgrq2Vmr+?=
 =?us-ascii?Q?VzEnb1UCWPf70lMYAT6sJhze96Il0g8yFnBboo1lOvRWoQMgDuZfu79wbFwA?=
 =?us-ascii?Q?mGqEVcsmBEefFsbMe41XXCWzsz8stLYKa6i/W5kJZWoFLGtcsF6vSLsclScZ?=
 =?us-ascii?Q?4vJxvnJeJmT3qRNeyMVJi+ufSIi6ZLMe7bNZddX2cdFEMqiFR/vzVwoQA/e7?=
 =?us-ascii?Q?Ip7Z+hDyH56ucYkqqhtR+I0l5lsrLmQa4ghaGGhQtfahb6k4ZSVfoOHeec3e?=
 =?us-ascii?Q?6m3RH+qj4A4KVXdoRB2G7cUgKNWggJpaI3P9smENg6xzz7fIrxYurqw2Rtws?=
 =?us-ascii?Q?d7wELLU0afGD9eIBhddVdN/KflRXo7SnwcM6CgfLQeGAQUPon/EkfyBMpw1M?=
 =?us-ascii?Q?yA9p8XpLmI6esKdX0R1Rcgsy9DHo69r9g77qpboSLtB3DNeM2N376tGNr7/1?=
 =?us-ascii?Q?CRPyIuRP4RKBa+wojd4atcYCt4gT2EwUIgE4DcJj45GTa2QJbUumFpmbjjJI?=
 =?us-ascii?Q?Ue3K2/tHCwt2cNFqQMz7Cz6HR8FvHNWdnk3KvsUyjHFPxDJWmaGL0ebwKPa0?=
 =?us-ascii?Q?vbs4tw5lylyyz7cpZ3zzE11NiFvCi7qxWJxsnAKEpR9X9J9PlJhZXF2bmzxy?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CE2041DCA0998845A3411C7E331D9771@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f424ca7c-43fc-4980-0f43-08da9b08fa16
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 13:06:48.3983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2XarSTIRPKiYZa+sDSCwaDOC/wnHUpm6/ftQ86/p+P7TLsFvDJ/Tvea6subov28sIdQuJhF2yH655jkiFENZaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4917
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Sep 20, 2022 at 12:05:57PM +0200, J.J. Berkhout wrote:
>=20
>=20
> On 05-08-2022 11:17, J.J. Berkhout wrote:
>=20
> Hello,
>=20
> This morning I updated my motherboard (ASRock model X570 Taichi) from
> UEFI v. 3.60 to UEFI 4.80. Update went perfectly, but did not solve the
> problem with my optical drive.  I am at a loss how to proceed next.
> Any suggestions?
>=20
> With kind regards,
>=20
> Jaap Berkhout

Hello Jaap,

Looking at the changelog in the -100 ubuntu kernel:
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/focal/co=
mmit/?h=3DUbuntu-5.4.0-100.113&id=3D529e771269e0d4b5f323c3f8ece3ac9ea6037a6=
2

There are two clear main suspects:
libata: add horkage for ASMedia 1092
and
ata: ahci: Add Green Sardine vendor ID as board_ahci_mobile

When you boot the working kernel (-99)
what is the output of
$ lsscsi

do you see "ASMT109x-" there?


Kind regards,
Niklas=
