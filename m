Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC0BECAAD1
	for <linux-ide@archiver.kernel.org>; Wed, 31 Aug 2022 10:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiHaKNg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 Aug 2022 06:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHaKNf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2022 06:13:35 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D213BC10E
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 03:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661940806; x=1693476806;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BkZFyyNtxw0X9TrSsizsmst3N3hKUsYCsr20pZg/pnY=;
  b=lZf07dgE7KtF6UD6zKxTLpP5AempIQSRMvE676zd4xTllX3/ZUaSWpP1
   kqFF2OXENNatjValhTjd4hG2kkcVgBRiiRoWQhgMuaC3QAMy52NfPc9Yp
   pZR0rIDAVfvJuEL3J5NdeAoVbYue6l3vO53DatWYxOTN+ZZZypqb5iJ7T
   QTb5F4U6wp3i+3sIlDaAuMpZZt/slVjavAhVGZ50KiIe3c1kBIJz45N9u
   zFijuCjXpKp/JBhlhlwZldTiU/MwCLwCTtp3UQx6Vktq0wLI9WJ8+Kj/j
   uj4Bo7dxqrF2FBfqT2P8HNNhbZTyzurgk2A/RKWKFWjdze16HVH4YFen3
   g==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654531200"; 
   d="scan'208";a="314402704"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2022 18:13:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSqluJZcLQMzNHpkGUMrkQNCikDZMcXMQeL3UwgCMR9iN0D2aVe2ItaD+gd8sr1UdUYdDbYy9W7cc9EU4ljswzNhqVmuHPFq2h7xwaXwzNeEQGChtcboWbbXs3hLCz26F8IdJuWepg24GmlDSczs3AT/xqJve15zj6MZpeVucVZDGaoYEu6b1a0uDmIFkXYt1FEnVwpEQL65/j0o0NFaUAhAn165OAa8wibbi5jV+SjD4SyoOMGIRZUS03YfAw9jSf4kXtfujfZhy+OktOqlAh40AbGXDKpLp0otqC/U8rhDi0Z7OO5E6P+5kTgafA12qWOBPlyWYLymim47srSnog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkZFyyNtxw0X9TrSsizsmst3N3hKUsYCsr20pZg/pnY=;
 b=QCRDRFs6VgToUdORaSK/RfUvr19QUqWvSLXyEFiEL1PnAPoqDeZekyS87JvAutFpMl40FdTFTPBXe4HIJdwnJgcw1RVRpQJCX17PdJJvz9/2C/HG/gzWgHIYjmhY0wrE61BL80DvtMXi0C5pRFRr4ki9IwbY8QJFyPxByQ2N6OQ+oVDAqU/IIEvCJ3K0vW/LS5PqTefTUQxQs5XZ/SkFD6yp86nGsBjb0zSabSRejkP3qtIAj3dr0gPDG37Ec6TZXcbohWRH+HcMiuNqaGIShNaqrlZFOSN8EzXbxjxzXtfIBKUn1/soeiFrfYiBf6bEhNYON3LFaNuWsX8uSHAxXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkZFyyNtxw0X9TrSsizsmst3N3hKUsYCsr20pZg/pnY=;
 b=mwMW2y/dYtyyrSFJOB9ucEpGa2dFKhl2D6LuFL8kiGnAKAl8stWHfeaLd9jYuslPx5vZVSvye2qLYhtjls/vBsvw2yyayKfGY1MP2qZ+/J9MJ4a5P9BSNUXUGtNNz6ISK1Z45f1DKm8rKK2o7wHit8hWSWPRm38cC/j/BABlIuI=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by SA0PR04MB7451.namprd04.prod.outlook.com (2603:10b6:806:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Wed, 31 Aug
 2022 10:13:23 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c839:6239:54ad:fc30]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c839:6239:54ad:fc30%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 10:13:23 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] ata: libata: Rename ATA_DFLAG_NCQ_PRIO_ENABLE
Thread-Topic: [PATCH] ata: libata: Rename ATA_DFLAG_NCQ_PRIO_ENABLE
Thread-Index: AQHYvSJNeQVHc2/V9UOKXh9m3up14Q==
Date:   Wed, 31 Aug 2022 10:13:23 +0000
Message-ID: <Yw80Qg4EgjoRHn2d@x1-carbon>
References: <20220825223903.354994-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220825223903.354994-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f883da11-72b6-4090-c8d2-08da8b396fcf
x-ms-traffictypediagnostic: SA0PR04MB7451:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uAZ4NnRoxER8j400AZQOzVpzt0YFHtcUYRyXOxQE6vPqL3jfT4vlotRG3NuIh/MtTPOv4yawONkBcp/k+BXV+UDS7OpH9fMBUi6PO8M6qYXjh8K42HHYRmGoGkw3Gqr9S96gQVl+wg+/EN2HSdEN/FvQr+boE0iN/WUSTxBp3lJMZvr6fdrX/SYBqikH8jrwamYu5yg4NvHM6LxxvhFTWwiK+mekQiWhDBGDJA0WTCeEbdN6T8lQ7/7TLnVMtWAK2QIXqfMhkDLVIwbVE153XMhcSaRQLeKGHzHU/ZpsuFWJhmxVbIf3vgeND0qCfdalHiTZ95oVUU7Ojf7YFDkBYKM79yT7DqHSLcqviSGpfI2on2uYh1zDEk/MfdO9MYIv/bfoI9yk72/V+JQFRGk6VUYZziTZq1iWSFXZvwyH8iQPRFdco22jseCWp11pDp7NZ+jTJOA+O7OmpISJThL6mtI79ueSe+FKbQ82ehyzXiqPFWEKXYeksYGFQ1od4/6xUVOdUZofp3Sqwym5kJUerxq2Hi3BCkvMWKzhhYBqjZjtyViHErlOxQqKea2adkefnJI3yXDmW74voZ2YxQ77FtIdHW2sW+iHrcvigk3bNUzDcR/99N9p8S7AvJg97qFL3huN/yeluHVTS3eXdNyPUoWlLd61aUBXLRfVCR10j5Hax1lN/lfWwz6TdW8CsdtlQHRmknksSyeCDkF6E2josXTkDg5IDdRLq6bfDEzQ1R0YVMQQyQUs0PTz198HqYXyg/8e2C56+VCVLkcbmAA7wA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(558084003)(76116006)(33716001)(6506007)(26005)(5660300002)(186003)(2906002)(66556008)(6512007)(9686003)(8676002)(4326008)(64756008)(86362001)(66446008)(66946007)(66476007)(71200400001)(6862004)(41300700001)(38070700005)(82960400001)(8936002)(91956017)(478600001)(316002)(6486002)(122000001)(54906003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MYz/2lnsLSfOo7JYDPxqLr+M6XqcaSX2lgDsN/S2fifKw5hNcWX1AQp7NBTs?=
 =?us-ascii?Q?YGCKkDIDcyPgwGP7WLUzGdi9ZX/BRU2kkvmPQQaupDiaLXy3NtI5/lfcDDYj?=
 =?us-ascii?Q?3o78tm5boIjBQXj0/sHmrW4+WKX8adJuwLBd9S27KsOHf1CrXQ35/Vf6ekEK?=
 =?us-ascii?Q?Tt/9rGlCDSJpJYNrtt14hwE1w4EhNuQzhyzmlKQHvXQSnWidzvqcN/WOOGvw?=
 =?us-ascii?Q?QiRn4QHykG/wWVDoD5vfWhbGbAGF6qf/YNzIu+UHNqMHDARaeatXQK0T8JGk?=
 =?us-ascii?Q?BX7xbN5da5bzUuiYhHtLfdQQ8+IXm1cz71mtJv8yWzO8ucKcCEDAjfxj95GQ?=
 =?us-ascii?Q?iYNiDqslTUJ9NNF8vbR7+JxF5w2Nq97hRln60ulPBHvr60boVOB7kt+bSkgU?=
 =?us-ascii?Q?lJ1YEQ9mphE1LJHy2AQr67XSnrdLY/nMhNEwTD2A2qY/cH0gay4aHIryDbyt?=
 =?us-ascii?Q?/+lZ3/9PDSEY4BTQKDwsUs4I8EkXQbdjDYtYRjLS9n8vhaQDmqwR7hEzTTaM?=
 =?us-ascii?Q?lCDK2Gx2r9T1UL4ShsAXrn4VYEmwgT9fAMfGh6m6mKTGgIE4q8n+gv6zSPyr?=
 =?us-ascii?Q?EHM2aa5vEq2O4Ax6UEcIpSl6s6VCOUIjJs8yRN3p+AZB6QqytnGVZWhUy1bO?=
 =?us-ascii?Q?Aej+cKz02QoIn6HJRAt8jrsFMq7Gqu0EdzlUr3YKk9M4qcUItF6uJcdFtXaf?=
 =?us-ascii?Q?RvETWGlkaOL0DEfK+29Ys/YTmPjvBhaa/fzW8vfx+vs/aaco7uagyWtC5d0c?=
 =?us-ascii?Q?s/96o3vHMviMIKlL65KxKOr7m4FF8tyTwoEZ9GLi2D1qlfUiqnhqJhK1mWof?=
 =?us-ascii?Q?beSKEXRdCnI0rE3Gn2FCdVyckfYDhhDllgENhneZ2iK4alT6srfVJkg75Qn1?=
 =?us-ascii?Q?/bpNLcqhKyOIZobZGZ0ra+oN/So1V6y6lpu+JuaIU1nFar8HRqUAtHHA2b28?=
 =?us-ascii?Q?c4NB03YnDob339wwX5LBriWmfaGYqCch2NxiE+IzW848gS0HTDRu4iqm1y0z?=
 =?us-ascii?Q?EWaVHjqW3MjUWAvSIRkNEnwONDvyex4rM/O64A1IOOWylMzB3ATmSTBcK/E0?=
 =?us-ascii?Q?eToYzfNDrCmNXG6gtosbJJd4L3LSyWDetJqh1ew3cqqx9tzkyVJBakXiBdax?=
 =?us-ascii?Q?1fO1Bo2QE5iIKB2fvIT6Z1YMr87U4N4x7vB6tCXhKKFuOtH5I+jdxd8JRNNW?=
 =?us-ascii?Q?Fc8jwSBEcNX/OoqrR+rDSxSnJBkYqg+5PvYsi4TrEGKa4bAEF5WO31fZEjQL?=
 =?us-ascii?Q?ybiJvr2h5oqeMAtvWueIrkW8Mvks/v9XQ0u17Eu5VRb6lrGtZDjrE66Lzoxb?=
 =?us-ascii?Q?AI1j+mXWA80p4bsiv33btrBqbAUvLQZNlDObhg/2zCfouTUGHPVWWT9p2MRh?=
 =?us-ascii?Q?pfgAzh76agzFlcjXE2JEi7q6juDM8CjD0sjafYaOS/iAMH+VaIkFYFxyrfYO?=
 =?us-ascii?Q?MqK5D6P5E4QESoNjfSBlDm1lxWiIxj2OosJg4RcXZ2T52h8E6WTVayGaUYEt?=
 =?us-ascii?Q?ys5xvBmTFXIZBoeMJPevVjQRr9YHB+1AfBJWRYkO/ndbUlWjeLjx7J230y/A?=
 =?us-ascii?Q?JLUdnrrla4CYDrDywJuMKsdJCRJlhfPc48ik+n5nRm+93T3TNsoVOx2EEspM?=
 =?us-ascii?Q?Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA56EDE60C26AB44A524E211CDD59A84@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f883da11-72b6-4090-c8d2-08da8b396fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 10:13:23.1319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7yIXrsnU+T2w/1LK5JDO5yY/0dDBhbrqViqlznemriCequVS02P3x36FaEVA8aOUBCLLUbcFgngBo14u9IneQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7451
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Aug 26, 2022 at 07:39:03AM +0900, Damien Le Moal wrote:
> Rename ATA_DFLAG_NCQ_PRIO_ENABLE to ATA_DFLAG_NCQ_PRIO_ENABLED to match
> the fact that this flags indicates if NCQ priority use is enabled by the
> user.
>=20
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
