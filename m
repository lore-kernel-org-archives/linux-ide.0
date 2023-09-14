Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264B0EDE99D
	for <linux-ide@archiver.kernel.org>; Thu, 14 Sep 2023 09:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbjINJG6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 14 Sep 2023 05:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbjINJGy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 14 Sep 2023 05:06:54 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B501FD7
        for <linux-ide@vger.kernel.org>; Thu, 14 Sep 2023 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694682409; x=1726218409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VpK3AlDA/ZaYB85eYXdxuYCAvfPMVkMco2nIirUubi8=;
  b=loOfQXkGJ1tZ9+GQIEbzoD5X/qfAGGKmE8NI4jpeI1Z1LZNTS028JE4g
   ii6pH3MN5yzeIJ7RyXYGtjma8wtC1/FeEivE9GG0jslXmD/wtM3jfAsqk
   HkFlcQWCn/O2w8NeBflQAIs8UGZslhnq6Uku4uEFlLuQaoPYnv/bcEpqT
   G4pmjGkzoUtQbnkqhwdUHM9dAib9hqQn5Xs9gaXQDbNJmLLu6T7jBZS6y
   elG7cUxuwROatH8HNJm3YYg57Q5zwt4s5no1iPIBDd0nMDo63QwncLaW6
   YSUDOZw5CyEC6jY9zjhBNS6VtKu1pL3CbEGmluJ/fQIiy/kvAhaMnKgju
   g==;
X-CSE-ConnectionGUID: yde+umNDTAGzDkjgBNzxAA==
X-CSE-MsgGUID: nGpqqSNoQRSdMQ72XyPWUA==
X-IronPort-AV: E=Sophos;i="6.02,145,1688400000"; 
   d="scan'208";a="356026420"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2023 17:06:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBfVlKt2WeTgK9R3fuke5/mGl7uliFh+7PvL+8dHhYjJuBvmfEZgeKdexSY60eidiIY8MDBIVUMHB+pcGMtwMtHiGMzft/2GuERaVgWu1JYW8QjWtpbTPxRpTd9tkLdW47QPt12IWvGqhZrY+WJFA03QO3MaeRHeTNkATUbj+1E3CJYqrUzPmkqr/W1KOS2bDTlrmL4SiMsUSumMuVaJMtwjBqKVa6nwVXG7uJxEqV2A8uJ1APB2r6llYqehNehEqiWoSAA5rhNuDhB2pv8tMejl1+Ac1rJfWuFG249jnRM4uccd+oHFuGEgLGheWJRjBBSSum7uPndNmPb3ZU1NMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpK3AlDA/ZaYB85eYXdxuYCAvfPMVkMco2nIirUubi8=;
 b=bLdCyD84oXOqsl+XoW+yQNMJWeuIy0E6H4ffquqTDfMLOR9jbCnW3nqpEYIIlMfKxtKGpJiH91FMTsjBkwGRUyP4x+0fcutpS9pqi8MCH4ZRJMp/KNpTIFoyzPkxXZ5fRADBuc6W6FFFH9FPIBDfVbOfQR6BcWX2Gh++yb82R15wuAYqH/HZpIj3HlN690m8PIph+UO9aeFOqZPS8Qic16GfBBALb/zjsEnRS+xkAXLvYt+GshLnxrk2nErmeX4LYO7zvxS/LzdPb2OTwm0ga3jthGxRVpi56O3yufPL0Nwiq+MnZZShpjNFqKVMlHAdasqZNdgwDNEKYxGKqucguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpK3AlDA/ZaYB85eYXdxuYCAvfPMVkMco2nIirUubi8=;
 b=bCQKZJ8Qr0KzSKM8ASzXKuSm+zMBL3RfUcGAcZoM/D/cBA2o8jcSIa+YhDcsihAz3wkRN8TyelzJY7Og4aH+rksGVJPnWHKs9T5fHjiDNj30Vpy3bM4rz1fz93WdjU4s5KzJgKlI3ZcvCS4XX3XYxBR+/Be5eQdkbDFmS/sCaiM=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MN2PR04MB6717.namprd04.prod.outlook.com (2603:10b6:208:1ee::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 09:06:47 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6813.007; Thu, 14 Sep 2023
 09:06:47 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     Niklas Cassel <nks@flawful.org>, Li Nan <linan122@huawei.com>,
        Li Nan <linan666@huaweicloud.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 2/2] ata: libata-eh: do not thaw the port twice in
 ata_eh_reset()
Thread-Topic: [PATCH 2/2] ata: libata-eh: do not thaw the port twice in
 ata_eh_reset()
Thread-Index: AQHZ5pCNEcjhzZrKnU+Mimna/ikZI7AZbTEAgACbP4A=
Date:   Thu, 14 Sep 2023 09:06:46 +0000
Message-ID: <ZQLNJf9qr5FjpgM2@x1-carbon>
References: <20230913221917.1217856-1-nks@flawful.org>
 <20230913221917.1217856-2-nks@flawful.org>
 <1da815e4-1335-83dd-f625-7fdcbec348eb@kernel.org>
In-Reply-To: <1da815e4-1335-83dd-f625-7fdcbec348eb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MN2PR04MB6717:EE_
x-ms-office365-filtering-correlation-id: b35a0a49-6f5f-47a7-6c46-08dbb501ec80
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0MOYxbYyWRIO3nQiHk5+DreO6Y4dF6P/G2HM5SwtGYPJYIEurbH6Miy5U3m/TfxOjdesMQ/AlAf2GZCe3WX86J9PZH6E60tXgSNhehOEYQ/n4fUtxSg5nrJPjJalNiOYXMZLbNd5J8PIFKS6anZwZUDBT8HWthBU2ZCltIOOlp/8SySWJYTq8ugRFVVe555U8Fgh34VRh0nKv8DRDWoejIt4LBcw4GO+wswWrAGv/W2l4eBd8/VUft7yXRUA7ib2Isz3coBFF6OpAMOtmVLxre8urIXwUhS/5L0mb7bd6VxXqGmI++G5rodWO94//nPAwtZXzop4KvR2gwjOdeW6Nc/L0sBzA2k8gVJJYxnXfJiP/3AfaiMHX+rnGUUaoNghKfLQ6f+A3frazD/MiJeG/6Pxz3ypK4fUzwDw6q+PMEuqqlmj8Svd8aTxo+FaelaG+DPgfIKFTQBOHrNFZg6WoYeBNBfZBxxPRkqVFp2GGqEDUrLsjwFSYTp4ByURidDYPm8g7vlEpvxxvdjFbFrBLzr5Pa+XIoLXtsolqu22UbE8G8cdGnr15CrPeStFw+ptZhn4QOH1in516UwVXQnIqHt8WWqN1/zUq86cEKTrp3epcudJMeOLTcbowXXblnZmyM8uZWM3CAtGQcMAYDVJYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(366004)(376002)(136003)(39860400002)(1800799009)(451199024)(186009)(2906002)(82960400001)(33716001)(86362001)(38100700002)(8676002)(4326008)(8936002)(5660300002)(26005)(9686003)(53546011)(66946007)(6506007)(66556008)(6512007)(91956017)(66446008)(64756008)(54906003)(316002)(76116006)(66476007)(6916009)(6486002)(966005)(41300700001)(71200400001)(38070700005)(478600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zz6XdtGUieDb04XHAA0naG//Tv9fHxbdl4sfGDTVlxPabtvgCIGjIgr6OJbl?=
 =?us-ascii?Q?6SFVUtBVu+7JV8+m9lnz02kg4w4szO8Uvst6iqM2J7b+nazVCABe9eqFw2zX?=
 =?us-ascii?Q?BR3XFAkvq20FEcU54aL/UXXR9eOgdHpse3Cwsh4oTZDNLZSk4Zg6TjYYO7H+?=
 =?us-ascii?Q?Tv0voX9Vk2NCtOKltbw3tSfQE6cxBdvr45BnCW8sW6pqfYcQqx3QUT8rsbNn?=
 =?us-ascii?Q?wiJPnypyFUhRCeF62supT8J9gddgJrn/fR4kIhIpU3/SaLQnJE4H1YzE5uRx?=
 =?us-ascii?Q?ryroWtaQIH7E+/Ou0pefyJqD2bj6+h4W2MEphnqeAG7ubnwi7MyyIGKeVlhV?=
 =?us-ascii?Q?pLuXDSAfB0CCRn0a5xjbymYu+gsJp68EhSLeWdPy9Ect463kgQFJpg6EAr+Y?=
 =?us-ascii?Q?xjvZaFPvqKAN7L5pWk4nBtFIRNzJN7IZLjI4WZ8Az4dLe1sd8HNHE6dWFLRL?=
 =?us-ascii?Q?IHgkWltcJBKHSodAyEInWYnVUB/wyq6LG2QyGGm9ASHYEpCZlCNVbqHIrc18?=
 =?us-ascii?Q?u/zVc2kqsyorVWCOfCJClJuNtI4xqPRG1KZX0Wjqcn9JoptVkcQ6m3LZAnD3?=
 =?us-ascii?Q?/d/SDQz+WQXw5lc5e41WP85Y4uUijJ8TTACp6R7JHeHEnJ0Vx5xmCmbEfTRW?=
 =?us-ascii?Q?3Cwp8Cd45eUtTGKobLb4UuMdIAblaq6kVxa2Cz74W25N1QFkIu1ZOpeH6oKh?=
 =?us-ascii?Q?uNqL6p4wESn1Cqmsg0P38DbBriBVOm+AOi3ksmz6yxaT8y57ItxgpZe6kmlc?=
 =?us-ascii?Q?q+5rPMjcEfTd/ydchdqxKt8ZROiijHjLTfuJo0aXKcIfpThtu2jNP/L0YySg?=
 =?us-ascii?Q?EmOz/VN9GJJtmtg4b3ijGmCn41e6dHjdbKZryDcbKo9lz/EU59U9uXvYbFa0?=
 =?us-ascii?Q?t5v2v/bzASx01utCJKsTWWiwTzg4XS3OgCSAXFfdCr3sQPnXNY8BQ4AwsSBX?=
 =?us-ascii?Q?8cIkPJGrQWLG4zioJHi4LhiubRfP0kgNmad8VMmvxcpKCrEHU53HzcbxdwZ8?=
 =?us-ascii?Q?7v8UvaVZb+ZWuHSIksrLONgHxUV4OwTc/r6m0ALbe3j6MtrWGKB4pMM11YQH?=
 =?us-ascii?Q?fXaT+TmWJKFVYzzmDelDUVocNy8kXjPnHqA60LH4aQ6cPPn0UjsyqhtBLmQM?=
 =?us-ascii?Q?SAaSixwA6yRRqFsmvhXBKJwzPnMl1a5jlYaF5PXePZbfLu9j7JbX/BrIlS6O?=
 =?us-ascii?Q?+RX1a609JLGnktxn2MyQ0G2T2x3K63RhmPyeeJE3WrQw/5v6bHiv+Ox2qSPi?=
 =?us-ascii?Q?k7afr1bE1vebeJqreWunEIC6p1jbqzNeiWvB/mlwvjxRohKqJIZMqDIau5JN?=
 =?us-ascii?Q?nWieCx5e4qQVNyS7Ct4wtA9Bf6YyVSdttJ5kobnAAbZtstMyhQkOZizzRDZb?=
 =?us-ascii?Q?y49KbKXBzOX5+g2vDNJwBnhiOuZjBzYCs4BP5R4xDyj7MYrexjmcuT8sfpEV?=
 =?us-ascii?Q?Mcu39k9HBRO5UzQx4nTTA0M7mQ7o32U3ZUs8oGhUGqTUV9VVzzaTMdiTnj+l?=
 =?us-ascii?Q?vigJ6dhQqcSVeWJSfWdAUGA6+d4Z4B+YQ37vs3XrQOwJugkYwnJ62GkoKMX+?=
 =?us-ascii?Q?u8VkVfN5D2ivs+m4olSbQdRSlBkd2PhzqfRzDBKg65d4QO/8IHKZ/ViKBUPF?=
 =?us-ascii?Q?Ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <943E06856827BD469E9ED3557C8BEFEE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jycIQSMA23R/EEdAdkx4JKA/liToNN7Wf6a7iH491S5Hklt10wThm+0f8YmC6rwXuK0BycsbX62l+3Oz1Eoj47bFbhEYSzpE0darK3hUeW6N6a9n73tQhpN9yvEcgLhl6a3lXROH0myuiodr4rJO275SMpR9quMXbPkRMp7jRhMD7xkmseORxOHnTfvoc0CL6jIlitfTI5OGhUQhkwd5iYns4OjuwtzWYRyqYiuttITc6hIpx6XR4iSXLYHJYBXMEefHOrgaODtNS+TeEEG0KHp0NrLqRxTU1FWadcAwDx2035cmk4KZZvNn6uw02qd9SBb+OUGLktCgUj4LqxbRiLqF8BxDHxSJhgmDnLqVKpIh9lAk9xca21UzPeLK4Og5tMMcGnQweRUpA4QRUJhV16GFuXzEp1XG7JD5haP4a5wg6NvkQtwqxzXUIt4rALqPOu2CBOm6hcvr8QF6Ko9eY+AYPKoiSI7EijhceXiPoAD7t7yBdruYVwgQVj09qKyZtmjBLtUZv6hjFVcR3SNPARMdK2ikA5o0shwJixFoWTS7pMlaMsGmoNGGIqyN52RF45s/M+Oe0kb4WaOqp3c3Ka8OGcz9+xFbnUFOmnNjvEERUQRAJoWBD2XC+uJxBLy/O0SBC7h5VFfOYZW8b0RdvKP1ak79xxxAG0Z9lVHd4em8LAO8sN47W4j/xmLYUaJa4uwN2OHfee7NY5IRhGdnWhcJ6Qu8a15lom6dLnRb+GhAxsY2D34wTa5Vj9NQFyKZLI3PMvYJv6Y/sP1yy0FUTF74zYimQ6ZhCKx8Eo6Crrev6vdh/UQ1f6wV36iCSPQu/KpN31unFgpVI/N8qdvnQtd/PahHS8YhkkzMU9uxlS4KP7icbNBj3xwljpyzaljT2aK+d/sOYGJ058eJwFgivmNemjYXcnKUrJR4XILlfBI=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35a0a49-6f5f-47a7-6c46-08dbb501ec80
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 09:06:47.0363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmFB8PMVQFq2nwLLQEj4HfRm9z1bhSK9wBg+dPYd8yiKZUISf/erlW7uCnTjKCKaQuVg7rNt8t3G+N13uT4lRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6717
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Sep 14, 2023 at 08:51:06AM +0900, Damien Le Moal wrote:
> On 9/14/23 07:19, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > commit 1e641060c4b5 ("libata: clear eh_info on reset completion") added
> > a workaround that broke the retry mechanism in ATA EH.
> >=20
> > Tejun himself suggested to remove this workaround when it was identifie=
d
> > to cause additional problems:
> > https://lore.kernel.org/linux-ide/20110426135027.GI878@htj.dyndns.org/
> >=20
> > He and even said:
> > "Hmm... it seems I wasn't thinking straight when I added that work arou=
nd."
> > https://lore.kernel.org/linux-ide/20110426155229.GM878@htj.dyndns.org/
> >=20
> > While removing the workaround solved the issue, however, the workaround=
 was
> > kept to avoid "spurious hotplug events during reset", and instead anoth=
er
> > workaround was added on top of the existing workaround in commit
> > 8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_reset(=
)").
> >=20
> > Because these IRQs happened when the port was frozen, we know that they
> > were actually a side effect of PxIS and IS.IPS(x) not being cleared bef=
ore
> > the COMRESET. This is now done in commit 94152042eaa9 ("ata: libahci: c=
lear
> > pending interrupt status"), so these workarounds can now be removed.
> >=20
> > Since commit 1e641060c4b5 ("libata: clear eh_info on reset completion")=
 has
> > now been reverted, the ATA EH retry mechanism is functional again, so t=
here
> > is once again no need to thaw the port more than once in ata_eh_reset()=
.
> >=20
> > This reverts "the workaround on top of the workaround" introduced in co=
mmit
> > 8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_reset(=
)").
> >=20
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> We need a fixes tag. Same for patch 1.

The workaround introduced in commit 1e641060c4b5 ("libata: clear eh_info on
reset completion") broke ATA EH retry logic, so the proper commit that we
fix is that commit.

However, if we put a Fixes tag with that commit, then this patch will get
backported to all possible stable kernels that has that commit, something
that we do _not_ want.

We can only remove this workaround for kernels that has commit 94152042eaa9
("ata: libahci: clear pending interrupt status").

Do we really need a Fixes tag?
The workaround (which broke ATA EH retry logic) has been in the kernel for
14 years, since then, we've only seen two complaints..
the one by Bruce Stenning 12 years ago (see commit log for this patch),
and the complaint from Huawei folks this year..

I guess we could set the Fixes tag to 94152042eaa9 ("ata: libahci: clear
pending interrupt status"), since we depend on that commit.
However, that is basically a lie, since we are not fixing that commit.


Kind regards,
Niklas=
