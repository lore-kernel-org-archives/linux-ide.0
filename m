Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A40C433FE
	for <linux-ide@archiver.kernel.org>; Sat,  8 Oct 2022 00:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJHAJz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Oct 2022 20:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJHAJy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2022 20:09:54 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DA01789B
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 17:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665187793; x=1696723793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=89BvAI4UHUKUolG5xvOvdUokzCxpJbu9YOY1S3j+2bE=;
  b=Jm8AXN10lEXNiFznwwbzVv1mlNupqFJQOTggH3fU/oKj5A9ol5qsswTm
   qEX1JJS51G31jA+x+nzHYzf+QqAfZPC2rgKdyaTcxB7hgs5BRPrUVIT0r
   6xubRhA61TuBXeof6eVZVVrbB3dQwf9vvF/hiU3lKydsZlFazdTCh0HgF
   BwodaL48SjNzY5FtBwknIEZpvFK6oDcSDL8C5cLzVRTnP948apPxolv4X
   xOGVMnFJP6HfdYfAbQC2QzcGdBCPaIlnbt/qKpB5b/u3kPOgSPGHKyZZe
   xCNiOzxU+LGUdzyihgGassjkzgTYviN/GxAfIbLA5iDJIYbn68eILu017
   g==;
X-IronPort-AV: E=Sophos;i="5.95,168,1661788800"; 
   d="scan'208";a="325380454"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2022 08:09:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA8PnwUuA7/LFYNShT8dkkX9cd1rNLzQS5VOp7s266XTLUQ+HzT85sTMs/5GsdP+8KuO/NPJ9EFh4PWXWDjKpOwjOOa1bbZM8v2vzNULGMOHjhyFWs6RZCgJ6AGVnUX9vTCzbRljORzObiefL94hpxyb/jCLPjPsz7uxCTkmkT84pwmoU/k5Onb1Yq6codSXl8fNAIJ/ex/JrpJE6irKi36QWsDpCdYdfnXBc0/Jy2FXYMPfoQfJJ+QtY7Jq9tkhdvplgyqLK08GQ1x8JHlt0VJRzY8NyNnuS7tv5oNO9JGk1Z0w+E0zHs26EQqaJq+5EzRmvQaVrZLYaeTm64iO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89BvAI4UHUKUolG5xvOvdUokzCxpJbu9YOY1S3j+2bE=;
 b=RpFZXBLujVtsFTcXg6cuvtAsiMfHnSFByll6IfDtaxacJfpM9Lz9LvsT8XFeZszQA5r+kkLuelWCryK8zMJ1MyQU7YfKocp28PvW5wEoF1H+K3v5spO7H0GrlCmmzKLaG/FVcnlARyzTBm15WNKu3htGMVBx7XrzJfS0Tx401620EEZdtRzXcy4RN1dOEHGpoRuTs779QN6n1wuMeEMNYn5JDIoOPvMWkyvGlKBg/LsnPkwNQqIXI9ogJ2WnCowmb5fSeUne6VSunHjdNhlwvAY1CIVfVC4yFPZvD7km8hGnC8Zl5fXTUJ36KwMIENoH0L3wlwBUt7eWOaoa/jcFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89BvAI4UHUKUolG5xvOvdUokzCxpJbu9YOY1S3j+2bE=;
 b=Xzu5obK9I0BAsCTsQMnLnjVJf2yBb/9q5G5wE7Z/ADShqPiBWkabP6+Pu2B1VFMM4HPzxnnyLHp7dwM3K7+Ulcg6UIqaFQu6ana5PJIkAwPKygaOjPlcThKTbj47bcm9A6+/00wbr5iCqBxwBPu6wSglyXA56jt+A6AffiiznPU=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB6411.namprd04.prod.outlook.com (2603:10b6:5:1e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Sat, 8 Oct
 2022 00:09:50 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425%6]) with mapi id 15.20.5676.028; Sat, 8 Oct 2022
 00:09:50 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     Mikael Pettersson <mikpelinux@gmail.com>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 2/4] ata: make use of ata_port_is_frozen() helper
Thread-Topic: [PATCH 2/4] ata: make use of ata_port_is_frozen() helper
Thread-Index: AQHY2lAPg5DskBJedkShQtJc+cw0+K4DhFMAgAAWP4CAAAGUAIAAA8mA
Date:   Sat, 8 Oct 2022 00:09:50 +0000
Message-ID: <Y0C/zcQJjcdgJhH/@x1-carbon>
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
 <20221007132342.1590367-3-niklas.cassel@wdc.com>
 <dac5c025-1f77-9972-977d-cb3d22023db4@opensource.wdc.com>
 <Y0C7TcSfZezZxMcX@x1-carbon>
 <850610de-423f-1ff3-077a-2243cd012005@opensource.wdc.com>
In-Reply-To: <850610de-423f-1ff3-077a-2243cd012005@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB6411:EE_
x-ms-office365-filtering-correlation-id: 1b981ebe-8f0d-4181-7979-08daa8c16b17
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Fip30o4swNRXwUcS9zll1hO57aW3BV1QfcH23PyLw2+sMqXu6WvCmwSbeV7YuKsgdJe/ChAbJ4xYqPc2TZRvHrJ9NX2F7BlK2/LA+m3RXqr9YOJ7rLm7G84PPBKiIs/BPHbJDw1eRHRcihsXxZGzILrV2WxzVGXj2ljq94HG907+lAoZZQklZyg4mO3j0IQ4oCQkqwJV3kGcgkOyDjYGjo9pYgHwex0137BKqM5qcvdh3b4PWidpb0+zU/SVqmga9zd72VqL7KQ88aNuFunZ1fhFDLtdgsUUzg4d/9qZyF4Efej4DixOPJDr+yhVCR3ltM1ut6bJlxOcSa1q54apHxvU6Xa8lJPAUn68Uhnq6aAmEE/r9Ks/UO3BFocUzCOo2tvmcguwjfdbLb48WtuYlPgxHS+mkiOFsgI7nquG0gb4KBIQ/FDZFMoA5Q5KhtGEIyVkWrcwBEDL+67QRdPRPFB75pcogXFFNkUCpjRJpg8zKHNHJPxM6ZGeRrd2UUcFUDOMIvXqYWnkj59itFFDoVcVE2ky/JYffzvPs13IRzJ7kbc6krhWexnU/XOqxSWawuuH8XmqZesBjnIuQPPYuYSK3VXwvtszaZHB4c0UnTYC2LH6J6nCw/ti+WmFliFLyajPcDnvVqNxgOK5o5+eC5RRdwf5pF6o/IBXivXckg3eVmiedMCiDM4AeiPN8Tcn7Yu/jX/WvIdlpJxczEJm6ZYgG0dL9ph6uaZdKkN5l0UbsMUFE2/k9OuPERjJVk/3MTAfCLOJxiO/RadNYUlAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(6512007)(110136005)(86362001)(38070700005)(122000001)(4744005)(38100700002)(83380400001)(186003)(82960400001)(26005)(6506007)(71200400001)(53546011)(6486002)(66946007)(316002)(5660300002)(66446008)(66476007)(54906003)(9686003)(91956017)(66556008)(8676002)(478600001)(4326008)(76116006)(33716001)(8936002)(2906002)(64756008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tQGodIlch0fH+L2+ja4IYn/Nh9WDO9Rhxh24+c5UmOupvdK8buImP8GGkWf5?=
 =?us-ascii?Q?wo4hXaqoieEH+YM9ZzU1oRehtygPtwS0n7astPFw4+6xvo47MWIh4DUdPwFn?=
 =?us-ascii?Q?jIKRYMW2YliFZo4bjzMJ/PJdqeIiZS4L2+vvQ2JE/CgS88UZaeYpXVLgnIdS?=
 =?us-ascii?Q?qs9pQlOOd3ttOMwQyH9/jo3HhXg+auadlS3fL5iGQBHUP7dnedYnBvNkS6pm?=
 =?us-ascii?Q?dkPLHTIg3zcxpMTAChrosJXSls2GZb1H0vnugl8kyo+aWCOq1hGyBvYprTcX?=
 =?us-ascii?Q?UwkKMpqqWj8CE1QPjdCST7oM7gcL5kPhIL66UE4FO+QcUHboA/t2CHhR71UJ?=
 =?us-ascii?Q?asZkny3DazfvggbhU8RmN4uNB4IiVwhT/6ebRGk/BOaU9SZwdPCHaJyjxOxk?=
 =?us-ascii?Q?i2JGNd/8/Ez/vDap126QNYBcWiGaNHm8zXUQwqMecnhbbT2xGLFrQvN8NXey?=
 =?us-ascii?Q?hxopSkTcTBtHCxyOntUzkQ8tXOczVW+tfE6v0z4JlnIKxVv0wbur5/mqsRO7?=
 =?us-ascii?Q?F+H+sHCC+GfpZpDr7bDwhfXqTo8u6jH1rXWyfUAIhmTBtvDe0GIP+edje9/D?=
 =?us-ascii?Q?awEB4oeKNpbeS1MGCWy8KuVc8AgFoSi0G7Fl3iS8dpbUHSpzjihmZQh7l0HW?=
 =?us-ascii?Q?WknQuG/9mYe0XsWukpW8pXbR4VoQW4NKpt3cpjmDV8xhC6VdF6I3HGmicyLu?=
 =?us-ascii?Q?r0k810+T7KIDJ9+hdvAmozuWxPQRfwJrf35Vn+VrIa6WvfdntlK3sYjxrVwk?=
 =?us-ascii?Q?okZ91R4cyt5G9dM2VPhlA89BD3b4GK1fkbX8w7ODtqHuHeeWbj2DSAcFzYnl?=
 =?us-ascii?Q?f7ofre4nwFKHnMtL5/2PAzpaD43KwjTD4+n5JNzpq9guy7KvEtSjuaTwbgiS?=
 =?us-ascii?Q?KBWQXYXWXWjG9JF+iUF8D6Hj8iQUCPRlDkDV/rHC7HtP8xt2yzBhI8golX0j?=
 =?us-ascii?Q?eVp9+SBLgW2S6MBFsIwVgHTTSB21iMaUNWWiWG6JGq4/aZs9c/4LhXwy7PyF?=
 =?us-ascii?Q?W904LQqZDiGxTh+FHrvz1IaIbnnk0FYMaQ2WCa7AljbOD1Wq179qcfUS8oJg?=
 =?us-ascii?Q?MTwT7zZGkBseDvjcWkFiu563lfYYbkah3hYlsA4iwSeoyc+hoq5h0B6Egvdy?=
 =?us-ascii?Q?M4FiTfJS6a70H39KHyv9vTbNgM7f8/15w74QAA/82j5T85rbDpfUunL7yq8S?=
 =?us-ascii?Q?oI4nQILbL+dzgV9UlxRh0ol2MQGYklWUHa7eBaGRXaBaLcFGjPu3BDupFmC+?=
 =?us-ascii?Q?4wU5xzw3SOtgbn/DCZyTYkIA2hHgod3gCosyhmNbIgUvgtOdMoMLAsdGZhTB?=
 =?us-ascii?Q?ljBnpYIa+yVwkUGiSb8WlAR+GpbyncfQBG1FuOdbDpONFjwaSEyf+uGkUDsr?=
 =?us-ascii?Q?ZgTy2WJfGTE04NFhT4oHl1nNeiWvv1uagLgPXRXSS/gps2HiKz10Sql+6hap?=
 =?us-ascii?Q?+0QeX2cpm8VH83Wah4zkdXPrgxqLqiDvFposUsW+NY17TZROGAIpy8uF55xT?=
 =?us-ascii?Q?0sAyGIGw1jtQ6Ufkr82Ge+b0cWBGp/CdkA4bCesajeSzKtY78p3CpDlLv/KB?=
 =?us-ascii?Q?0WTJv48FAaHUoNJo0w5AIAntMq02uWQvmo4vDifFQ8gVfkR6Mhcvk5T9JsvP?=
 =?us-ascii?Q?pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BCA9AA1B9D62F944AFEABE564AB6CA9B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b981ebe-8f0d-4181-7979-08daa8c16b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2022 00:09:50.5045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHbAs1QujbP7pW4xYOsemj2q3V8xdeuHtquJaG4BApVPKXky8emfzuNO+UKKG3REerZbzMwdRpR+Q9Kf+gYroA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6411
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, Oct 08, 2022 at 08:56:16AM +0900, Damien Le Moal wrote:
> On 10/8/22 08:50, Niklas Cassel wrote:
> > On Sat, Oct 08, 2022 at 07:31:00AM +0900, Damien Le Moal wrote:
> >> On 10/7/22 22:23, Niklas Cassel wrote:
> >>> Clean up the code by making use of the newly introduced
> >>> ata_port_is_frozen() helper function.
> >>
> >> Looks good, but I think this should be squashed with patch 1.
> >=20
> > I could, but by that same logic, shouldn't patch 3/4 also be squashed i=
nto
> > patch 1?
>=20
> Well, I didn't get patch 3 :)
>=20
> Looking at it now, since patch 3 are changes for libsas, better keep it a
> separate patch, and we can see with Martin which tree to use to queue it
> (it probably should go through the ata tree).

+Martin, so that he will see the message.


Kind regards,
Niklas=
