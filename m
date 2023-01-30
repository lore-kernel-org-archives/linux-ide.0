Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26C0C54EED
	for <linux-ide@archiver.kernel.org>; Mon, 30 Jan 2023 11:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbjA3Lrt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Jan 2023 06:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjA3Lrr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2023 06:47:47 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3122B0BA
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 03:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675079266; x=1706615266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zTOK6F0azSbVfKwIRaqx3kpbOaQpImmNQBM75u4HaxY=;
  b=g4WPemMkEPTPS/ChZ3IJ2ILQzqmROZsHFroQriJY6sGyBJvMsdugsICB
   BN3hCWTchYLKtm2y7FJn0qtxyxXvU2NkaHshk9zS3+iUlQ5zV2Wm5lGk/
   T6U8HhNa6XCBd+WbCCmwCan5v5LFLe5vwv4qNeb9GIm/Dem6bbtXmOYj6
   2/n1rUV2dPkID57QuzXTMixoITBrnPSVuroxQ7RuNgj4eaKGNiLe/lu3U
   4iXwQShQDsZ/6tIQFYpjOBug9YVIHqf2/69UI2AKGANrgiKv53DkzceyZ
   6OeptZ0moHcWDTZph3ZHCB/vpoBgmnqofyGY7SXocs1SUJNENhW7fDt7E
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669046400"; 
   d="scan'208";a="220396017"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2023 19:47:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxTYlKgo+2XxcyIQfrA/DjwhMfdBXi2azCMzIOzJiY/2JGOyqbv5XhVwkDpbq8djxPjVylIftyfxE+vdRjSCFA+s2ZXvrD2iaadl/zttCjBwCDQQ/YV55puzxmVpc0LWl+vCwYQLzNoD38X4NeSZANWpvrxYPbrTEWdKq2vwWkiiMOt18KsX+sbsvtO0M05FgDkMs+ipAsHU6EYEnSjg1qH9wlID+5lWa4AvqApDO8kspoBA7Vc0d9yqZovw1aERVORftM3/sB6uNQetUzBspY9ovLIwlNQ2YBAvO8ouc3i3bKcf+7NhNRwHVQ22efKe/kYx/9w/nG7q3awJuGqCdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFMH3jf0jolnqcpC38Gcxv0j686kzwQ32OqV5YSsXk4=;
 b=jz3ehUIMkgIr8CiJeLaEkObbKZhbqBoE0rKQjHE1w4F+vAzeW1xwt05YnvxAEQlIObHzNhuOmE/a23g/SJCsoWZ+Da3oUMuwayHR6IzcbcG8GW6P0DU4NMO0zHzAMoKLWoNLEECRzbwHAVychau9zxGMdS5T6GfCtNIZne/q5UlC8Rk9VLVJ9fM4wu3rg0FI7NzD2lsAwbSU+wb11MZg+04KuC+kGd9VzzV4AEFV503JFSg1G2ijDed3HgTkz7H0qgamLTFY47IT7sVQmZ9FQjQ8rO5uHKjNCucJjKn4XHP+p+RZnBJwjTV131nifpXfImVFZLLnn24BTh3zwukh5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFMH3jf0jolnqcpC38Gcxv0j686kzwQ32OqV5YSsXk4=;
 b=tz+f67q5xLF7mZnrYU2Dmr5IU2HaMo1R4S4j7FyvVYE/JWlCvCfY6dARDug+zfM6XZcnkT64dzRuz64jvb2OxP0gw0uACuECthK8/ytM9g031rw0khGbPom5SbLZJ+gEg6Vt1JGLxGtfc32z2FynKCmyKrUu0e9epMgNWPPnmwM=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB4105.namprd04.prod.outlook.com (2603:10b6:5:b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 11:47:42 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a%7]) with mapi id 15.20.6043.023; Mon, 30 Jan 2023
 11:47:42 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Marius Dinu <marius@psihoexpert.ro>
Subject: Re: [PATCH] ata: libata: Fix sata_down_spd_limit() when no link speed
 is reported
Thread-Topic: [PATCH] ata: libata: Fix sata_down_spd_limit() when no link
 speed is reported
Thread-Index: AQHZNKCp15DTN5v8+U6V60ONrRy3ag==
Date:   Mon, 30 Jan 2023 11:47:42 +0000
Message-ID: <Y9euXc/Zdr062nJo@x1-carbon>
References: <20230130110721.111776-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230130110721.111776-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB4105:EE_
x-ms-office365-filtering-correlation-id: ac05772b-36e0-4c3c-4b04-08db02b7cba9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2eEJjo1g4eGGG3y03v1iOKmsYLX5EA9nDstuplnJmYg1+HSPT/TWwPbyKr33BD3Q6gdbRjoVnyaC8rVozC/SZkc8/ZtGnmfwW/6VbrV2jvANtkPlEYCCde2BaHAto5YFL4znTpeWo2AvUT2ujdXGdTH4MhFKiHWf0yG+1CP+Jv+xGJ+hm7oNRQo5RBYFnD0KtQlS6g6uGinnPafb/gcPEbMITLx6a5T8GtlovW0WK2w45rAAL+XXQiylRl1b8upqVp7xCegNBi/+fLqRaryxOXQf/uk6nPu4BdLbYZM9OrkzOGu/5T30JbYMkaezSBGPJetP77vvFQ5CBPvrJQSs63t6tH0RkK0cz/xJrsG5P3ZNrD/AqgQhh4Iy61gwA/Wl7xvUYKsPonYozf4q8dcMDOIzEKcIhAZwRX/p46NevxXF7OU2iNo+iPKWik+F9Rb/ud2MX4/SQsY1HXOm0HEGbQYFgTc6UZ1B4PA6NVhIK3Q5xisxOwr7z/qmOFvSCbySyEjk2MsibK3ABd0nRrP2eQGpvP78mJLHZq02+pdJuHgelDBkhcUsDBsDU7wKFWR3kjXJWZfQtZFI8VgZLXIAX5oT0evOh1xKSNXqYChBz41fcsNA34Qws+RzZABw4Z77CzLkDoxlS85k6B4lUHL30NPbZxn8Zt5Z+6qQgkKqeYDMpTJFmdVTaWy9pCgSQRMVZoz9St93w7LJ6AG78OQBLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199018)(66446008)(66556008)(66476007)(64756008)(66946007)(38100700002)(82960400001)(8676002)(4326008)(33716001)(76116006)(122000001)(83380400001)(38070700005)(41300700001)(8936002)(6862004)(86362001)(316002)(6512007)(5660300002)(54906003)(26005)(9686003)(186003)(91956017)(71200400001)(6486002)(478600001)(2906002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bREwqF/1HHAHXyiS2AOEwYA4vgfF66GI9I64PuiqBBQRMIMXh78wJsjPtVNz?=
 =?us-ascii?Q?s5nzaWPdFpvQavbLeKy3PEpgbpI7FdqZXd/F+ySOMSn2DI9K2Ao8nyB6TQI7?=
 =?us-ascii?Q?dXWTyReegVBLF97HZsEailhRdoQx6vuKEJc6XQQBHi4T+tF6bf1XHQJDaQkR?=
 =?us-ascii?Q?P5vFEj+9FAwHi5s/O/v9dfmvUr1r0BZF6QzKKqPE/HxdLsqSaygDmoPl+Puh?=
 =?us-ascii?Q?vxREq3JftBgTociCfnBxtV/GfgQ+3+cLoE3rnq9LzaaEo45toMnPxgbxyp4c?=
 =?us-ascii?Q?kiF7uSk1OMkqvD+RD1+LmH1H5m+yuber3PIFWFYCY59wZ5mgM6oljY1GaWa9?=
 =?us-ascii?Q?Geo3K0mqJxjp5unxVmMkunxDelUYLq5M+tzwUAFEYfyyf+apKdIVt7IdD9Go?=
 =?us-ascii?Q?3TEqsaLZrg2EPf2WJa86sDIKnkDoKsoUgC1hnJQBckobw1ulxcyq39W+pZ5w?=
 =?us-ascii?Q?5IpC1EedcvmDvEIOOT9zIQgjcpdUtDegJEFpfgLCcAk2+GYa7Ym8WxlduXUC?=
 =?us-ascii?Q?j2D06SnkNJ0EZAV0jEumq3wepWpZgJBxKR0tPLD9FGJMLvSN3VD7rHfO8u4l?=
 =?us-ascii?Q?qP04Bggr13sRjnbdhHqsB8KtmHvC3mgto0wyCVUKe05FsdIX0X+mMg/iBbMd?=
 =?us-ascii?Q?rHC6u+Rv9M5ncMt2O60CdSMHNHDJKdhz7S+VGoV+/+UiknsE4Pf8GdqKvBvK?=
 =?us-ascii?Q?qSNFeM8hqZRknH2I4wXIwAZK0zYG9r75r3oLN+sHoIiVs5HgHZwUoS2BisgZ?=
 =?us-ascii?Q?34txolNVL8cG8uRBaJWAeZKTRy6Pow7AtSetFKlusU1bMb8MdfxVFOWKUbOK?=
 =?us-ascii?Q?W+BbD7FFqczg+HngYNUgtcHKPq9PbxOkD/gCrZaJcEH0le126+Zy7p0HNlYD?=
 =?us-ascii?Q?MNPVq8q0Z29q/LAO3HfhQU6b56TvWgvK0xwD1ezItiEf9n6I2KF+wDYKiySc?=
 =?us-ascii?Q?+Mu11aJhIOXBDl53fL6aEU4CH/07WEFd1yNgP8VuN7BMm+u9BWq7RGMkUu3+?=
 =?us-ascii?Q?iCBXi7jg1xGRRh4qWzmLaR55Ki/Gc4aTcjdVeDbMF7pSyIGNZUSPqZdWM0cc?=
 =?us-ascii?Q?UoxJhmGX0z5cmpqWK/ByL6DVJRtxFhp0/VkFhmb/sHYcmT1zk2tcavIKNtDp?=
 =?us-ascii?Q?/mLn2pw8HhGyYjH/7wrkqU6JABL0Z0h9PevhafrrPdatsDn4b0nvjMJPVFZF?=
 =?us-ascii?Q?R4Uh+dk64khIgLyQSCHWnsdn4l901wE7+MNceoMQbN6xs539yDBxyyxp7Pkx?=
 =?us-ascii?Q?ff2XWsWXns5T+Fhu1uNUS44d/TRErV4dis3kZQf0G9TN8Dyd21YmeV17kzPZ?=
 =?us-ascii?Q?2E/W+3Hnq5TDZr3nUXshulLxHABYm0Kwd6IqA6IWMQGcZOiMlliLs4/Xb6N/?=
 =?us-ascii?Q?HkfPFG01cIeshq7iS7SbQmIcyNmKtajiFUgKrcryPdWsfXpsGwJ7J5xAllq5?=
 =?us-ascii?Q?uERqULR1SWlrpulRUPOJvwS7xJMHSBa9MHq/B0b6Q5MxbVTW8bz22HOFwXgd?=
 =?us-ascii?Q?nLVoVW+HYmA0o+cLRk7SHigvP1Bp9yV/P7DascWCDMziA6a5NPuLT8yHH4hT?=
 =?us-ascii?Q?yutV4fbbZIFb+l80985DosiuXQIJ3Eal7qe6zGmGnL6I2+bxES5vK3REoYgo?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <698D17122EC566418BD2CA7439E0F8BB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gsqZduH38ZqA/lRfew1f0K7sGTmfM7Xizc+3P4S3OWZNhptBqazEV1juNP6GCDAcvXLGeIgF57rmsPrl4+1+0zFJwmsPuxKqtkROS7U2VfKKA5FS0U63QTisZ2JbNuBi8b4mCziYgQAEEgGU2G+7lscuqmFOlIsZgV6D5SXxVYJ351CaUw1b50TX415yMrVEXHqDE+U2jSpLBdr0M7DfM9dzx/t8Uvb4quMNv4TMLuyufe3GssVuGQIBMA+B++F9mT2zyRmXj2iSlEycUpAdP8OlGLNOrdBii4YQ5AUR3vYartxV7uX5u1eVaDbaeFQRMIkra89qtA7XeJJnDhaHPB3jQ8BWmKhRwviv940FYVEYRkw69Qx3+zD6STHXRvaR+RaMqLaaU5eajRUtn3L01kYKxzAooCeUEZMVgYOljuCBuGrepZmzCcWJOmY1Ca7ZuEAqMl8U5geNtd8DzrOq6gRKgUHNxwF1+cxvgQ8ap2VIC+nSp7XkFSdxzW6tNEk3KQHIEd/62+g7WWOrqmUikyFCdOU2rb+jx8uzcOiQGl722sd26InuZQOBHcPY1Jur7m4xCs8mwpc93Y46rXjmsL2DPBUxWAp9Tbr1Q0G6+qXymA48dP3pPcrXrXD104pabmUeVjifurnOUKgqOT2bL0SA84xSskzSLOab6ETcd4CO5VFNLss6FAXHxNinOdL0YHZXoJA8+p/D4ZvFT7JKWSGG+EOI+ItM/ELbpk+8TCwfc+4xMbUv9ymjLc7VgCKAL3+bsyS5tgQ7UU+fhXUJqh1l4A5K/n+cc9rGNZtRX9GdTljsSTOs6yFgI406Ep82
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac05772b-36e0-4c3c-4b04-08db02b7cba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 11:47:42.1572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8p5lkI62ltlRXR5RNDmfW5rI23igMrKM/huSpKpIV1XUT8NG+q3pjG1GWvmM9r6qMIVUuN72YBZ6KfiahOl8OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4105
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Jan 30, 2023 at 08:07:21PM +0900, Damien Le Moal wrote:
> Commit 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if
> driver has not recorded sstatus speed") changed the behavior of
> sata_down_spd_limit() to return doing nothing if a drive does not report
> a current link speed, to avoid reducing the link speed to the lowest 1.5
> Gbps speed.
>=20
> However, the change assumed that a speed was recorded before probing
> (e.g. before a suspend/resume) and set in link->sata_spd. This causes
> problems with adapters/drives combination failing to establish a link
> speed during probe autonegotiation. One exampe reported of this problem

s/exampe/example/

> is an mvebu adapter with a 3Gbps port-multiplier box: autonegotiation
> fails, leaving no recorded link speed and no rep@orted current link

s/rep@orted/reported/

> speed. Probe retries also fail as no action is taken by sata_set_spd()
> after each retry.
>=20
> Fix this by returning early in sata_down_spd_limit() only if we do have
> a recorded link speed, that is, if link->sata_spd is not 0. With this
> fix, a failed probe not leading to a recorded link speed is retried at
> the lower 1.5 Gbps speed, with the link speed potentially increased
> later on the second revalidate of the device if the device reports
> that it supports higher link speeds.
>=20
> Reported-by: Marius Dinu <marius@psihoexpert.ro>
> Fixes: 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if driver=
 has not recorded sstatus speed")

IIRC, checkpatch.pl with the default options should put the author on the
commit being fixed on CC. CC:ing the original author is a good practice IMH=
O.

> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/libata-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 884ae73b11ea..2ea572628b1c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3109,7 +3109,7 @@ int sata_down_spd_limit(struct ata_link *link, u32 =
spd_limit)
>  	 */
>  	if (spd > 1)
>  		mask &=3D (1 << (spd - 1)) - 1;
> -	else
> +	else if (link->sata_spd)
>  		return -EINVAL;
> =20
>  	/* were we already at the bottom? */
> --=20
> 2.39.1
>=20

With typos fixed:
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
