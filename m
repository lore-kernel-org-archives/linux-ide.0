Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB5DECAAD8
	for <linux-ide@archiver.kernel.org>; Tue, 20 Sep 2022 13:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiITNfv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 20 Sep 2022 09:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiITNfh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Sep 2022 09:35:37 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7F65A8AF
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 06:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663680935; x=1695216935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QV6xHUaCr9qxRtVMobWb4jLyJ3DhNNIgOkJk/oTIjIY=;
  b=aKPdgkRJWuyGP9I0pwqYtPtyX+ZR2BXX2fJQknQeieN7Q3UpH88yMxMf
   esMbWa1Ual/Lc0oSUgQkC7gVoMhL3w7Avb/sZ2WQAn4vHt2g07jg9vOlk
   xR60s5am3hydqupp/U7qg00k9or+7afHVFdIuxStuwTUBsW4tnGSSCtDQ
   DRqI9t9JAe8yhJ1EC21rsw+PIcsX0u5m1L7rmgZ6QDHK9s3PhxI3GkE4K
   ue57WdTgCq5gqLl4BPyTNemYaBx51BNSQeZj6pPnV0/gNMAZm+a1dp25q
   M4Y64i1AWNvLpjbuE935m7e2k24UQDgofMc9AW0kDKDUIYJ9auAKAXNf+
   g==;
X-IronPort-AV: E=Sophos;i="5.93,330,1654531200"; 
   d="scan'208";a="212250881"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2022 21:35:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDUENIOZ0v//Vr5QC+CCcwLJJREDpeo5cb2w4/MGPF0YCMypecSriNzP44iQP6MX+jddYBkSVF9ZHuOJ5avDBf4VThAay4/r3oS7EJriELGB2HreW1s4WyLMhnh6Y12SUT5k5kw3D9HdugjYXXRAW9VDlYVlffLQ4g24xgTnG1sWFmC8Z1d7MBcuyUP764Nh70N0UR2VrCJbP1uqGDmUXnyzirIWf6Iteo4yeGLdMxtRJy3TfFVPZ8UwgLvrFuXPIpiyZRFt3N4SNW+vn5ycxW4wNLL94O+/LhMGw96epw5dFhn0u5KD06LLQpy1Dg26+ChWETiJaJ/HWH5mGW+YEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7Nv+R2yY23MN0oEak0qMmnfcsOHgoY7sLvyLzvc4A0=;
 b=ePlZ00wT1P675t5942g0FulAJwugL3R2hJVKRlBC9rlKoGHIP84kviWCaGYIJxrNiU5jnu3PNZGEd/QbtM/6RbgjeCIlMpDQ93WHUyWjF09P77lpUj1fb+nbv4jBVeElGJJVM4XnafaojEMz/c18TK1x04kbzG7fPvM3+rBPQOgwX3qlvxqJVSVqP59sHJ6dmSoKvOYgMLITWO7EaEKxuFYsDww75n679epaLGydxduBDRAZK4lzy+4qhtIyCy3WttCawvy+Vr4Agct3olG4yrTmdrXDPFZQWxLLOpH57R3cNEzwpoClFBwGs0h3GyvXeKXmfplZfaQkqU/utgT1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7Nv+R2yY23MN0oEak0qMmnfcsOHgoY7sLvyLzvc4A0=;
 b=eUzFPFetBhp7SDXi+fkZrk/bjBYvGH9KZApxoSp8scw7kBTf/TTvBMts3LrzUVZppIYhN22jcSz79GbmKVugkGOWf0BfjM5b5bCgInf7/nzAS51YJnQZYUwfeSeEehL3Tw1uNkvNtQCURIEsDj9mmUNB6+Wkx4p2EvyqFONHUh8=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 13:35:31 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa%5]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 13:35:31 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Multiple errors with DVD drive
Thread-Topic: Multiple errors with DVD drive
Thread-Index: AQHYzPXZLJ4Av5O6AkGhkxFRY031gw==
Date:   Tue, 20 Sep 2022 13:35:31 +0000
Message-ID: <YynBohKGFDRIPdRg@x1-carbon>
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
In-Reply-To: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BYAPR04MB4965:EE_
x-ms-office365-filtering-correlation-id: a0938a6c-1410-437e-5810-08da9b0cfd0c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D2caLfdlcjbFBQP80vH8VGmUv8uV2ly4FVXS+tlh2+nsfoDeMhlB7dA3E4gwPlUHQCo8O3dUoOgyFewih54YmqUgB6anjChaY71cSzJ03wCjhEZgP1xtI4Jwcc+9W6Kre8OlPfa5gpxHORKPnKL1KfExC3PBmWt9reeLLoI882mxK4fOi1XiqHOYsnl0YuUt7m0d6MsYlXtYmhMLmy5nlxJVqrfMlUlYAtQ9zKZWMXvDP9aG7jmgtvRMkzlj2+/kcAUd+hcErLO5N4w7y21qWRtVasL6MPco+P5mmSOYwzQQKgAhV4OaYkV4hfY8AumlXAhXZ7F8+ABBBAuhXUdNAjvbpUByDaCnLSD3lgAwkNJdkfWImIzZu8CuUHX1izecpqiSHZosmyO9PcpknRP4NRWv8WtfCo/uP1+2yDk6nMNWP+RRbq5Njt/DwABesp8Nkm5Ic2fUSagEyCQnOXta4K7Da1jiKxj80wztCSS2xyz76krmr58x9aOMySeS55er1nJvrt4a7xk/aD5mrs94oDoNQbHmUAlqF5C7cl8yprak0MbB7ufnjCXLnrgQdnzAzsv8OaOKggJ6aYVj0e1hKeTNVMPo8L2MQFSyErcehOTLqD5agbTTboQGsD+Nb0TzM8H5//rXUGK5qQTrmrDfjYsg9HzjwebfcoCE0m64LhJXjq+l4LdXJRD5J0dZMSCQaI90JrwjOtcJT9hXdQXBin5uBN9kKEZvsy5b2pfVSB47eTWU9ChKR1Oqn687htQZU20MPldjDC4A8Al+wiDhzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(41300700001)(71200400001)(478600001)(26005)(9686003)(6512007)(6506007)(2906002)(186003)(33716001)(6486002)(316002)(6916009)(91956017)(5660300002)(66476007)(66946007)(76116006)(64756008)(4326008)(8676002)(66556008)(66446008)(8936002)(38100700002)(82960400001)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fgYC+/8lBC+QZ61V1FSQYll9GjzuS3BUzt6Xqi1l/NCpIaL3AEK69sIbQGb4?=
 =?us-ascii?Q?0R8dpsTWLWDbiBGkl85ORTqbnZr2CmfyvIzjvuYAcM2ccJseuV6UeyDs/c+V?=
 =?us-ascii?Q?A2UVclCCAgHrVi8nN4INLpc+KK0pU7TtssfC/GikSrERGuyFRmwDtrQ8B+9C?=
 =?us-ascii?Q?9F+7grPV3rgpevAdxXDu1SWFii2MkthunV5491z4Yvq8vwTEQscft19rHPK3?=
 =?us-ascii?Q?SyOjuZEI8WxfjV0o92qMBrkJsBxhFL2XaFPG00ErpE7Vy2OAS8QV+NVCye7s?=
 =?us-ascii?Q?6AygNJohmkl8DLvAkm0Brf0YiC0yFkbKyhdFl10b3DP3gkYkGmwKtlRVa/E7?=
 =?us-ascii?Q?Z0ZVnNPNYwpcOxJnSC0uPnpRLE1SSSQxzrv21hbSQc7UzRPaeB8cNZhW5n0y?=
 =?us-ascii?Q?5cc+jhYzahhq03FA7BF2oResBNjz//ArgLnnNaWO+BnCMLoOoPHeR86lUF4C?=
 =?us-ascii?Q?PgTE495CZgxmO7SjyXkUc1+HZd6FvEUV0ID9jMDJ4fm1A5igit/uJehzx/je?=
 =?us-ascii?Q?2fpkeDQ5R4tFQhfpu+lIkDGcME87fEH1umdUWvSFptnYEXf3QCcxBQXPv4xL?=
 =?us-ascii?Q?TIAS4cV6HPARvLv63asvfaY21Vz+ItNA3eyLrmWnbuLEkj4wk5OGgqB3Xh2O?=
 =?us-ascii?Q?VEaHuB+S0rvTVxZpOkMqV+K7iZ6+MwKSvDzqs+GKmmZ1rDjlhl+46m6+mJEc?=
 =?us-ascii?Q?YdP5y3cTw4cc2MUpV6oovrpf0bi83oNyUcYToZqakwTt+UocvCGaiQj7ZKqq?=
 =?us-ascii?Q?MN2QxhnfV82r/qeZt1tSHroRgSjJ72BcISCW2+JYhcdOvRcMYEVUFEqvYH5U?=
 =?us-ascii?Q?f3aVwU/QoeYtObY3RhUIyKHhZKqa1JT96IVZf+7ZkyRIUuhQgdT9YXYmbyEa?=
 =?us-ascii?Q?rzqbOSN29XCgo/zzdvP/UGPCYo5qqZbw8izlt63WCAbIcLvJikRWku88gS+/?=
 =?us-ascii?Q?DG8UvfYvQGPDe+JIu1e4m2qFvLSEpE9/1T4pEjBVD+kxqR6+38rdwDny9jfM?=
 =?us-ascii?Q?R/U86BPLBXEYFsYwOGPXzwumZ+gJd9jwbD9nlr/YqpK5eijGsZHVddmfZHMz?=
 =?us-ascii?Q?R7XOQ2dED03/Gvn52Zxs+7UFUpK38WOleVUIZ83eUMNJzGvDbXdfGqvqzqqU?=
 =?us-ascii?Q?D+85HfPliDAhsageEhoGYW+T7sokGgnq8yfb9+YpiMoPES5EGyZhPXTVgbcA?=
 =?us-ascii?Q?C9gFsLJqXyjdU4VQn2nCsF+LoB9TgR4kYqRcm83pHI9+fEyrLk7rRrBJuZTP?=
 =?us-ascii?Q?hBvskDdbHo8sof50SA7YLpmSacMhfolds3l/zjjeCQSMo/GvCFuTxV2VPF9a?=
 =?us-ascii?Q?eOEPRuduYQk7y/S4irFbtebFgAuZHPF6Y/cCFuN+05qTfB2K3e05IUKkcYvu?=
 =?us-ascii?Q?Rt4succ3Ihu5Q2WN2E4oBtuH2Wxkm5KaGIi6wP2/EiUdUKyBv4syYm0RyA6t?=
 =?us-ascii?Q?ymX36HaQJb3piNnrdzGPge1CBSze50hFPXd1o3bLOekvg6ut9O6I0a83L/Km?=
 =?us-ascii?Q?cgMA/SNIZZuMEchLfz9RfxKLDnXpabMnW/WAaEarGxSTXyNHY3N6ZVNkagxf?=
 =?us-ascii?Q?/Ygx7WoOTC5cS/vA7c2m2ISrfpAkrIpIK4E/UXbaI3L9+7YnnllvEfhHPvUx?=
 =?us-ascii?Q?OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5B54B1A9D5EC074AA3F3B906EE5AE903@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0938a6c-1410-437e-5810-08da9b0cfd0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 13:35:31.3547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQdIsAtJcjc5YeJXF1YCbJm5uZISTkoCgvHBLdwZnEm7bGI4rhPxFeIc0T5RQum1qjibDoIeH9qQz6Iq8Dmo1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4965
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, May 26, 2022 at 02:38:53PM +0200, J.J. Berkhout wrote:
> Firstly, if this is not the right place for this message, I apologize.
> In this case, disregard.
>
> I have a problem which I suspect is a bug in libata, but of course I
> could be wrong.
>
> The problem is:
> After going from Linux Mint 19.3 Cinnamon kernel 5.4.0-97 to Linux Mint
> 20.3 Cinnamon kernel 5.4.0-107 I discovered that I could not (reliably)
> access my optical drive anymore.
> It produces errors like:
>	ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x40d0000 action 0xe frozen
>	ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
>	ata1.00: cmd a0/00:00:00:00:fc/00:00:00:00:00/a0 tag 0 pio 131072 in
>          Read(10) 28 00 00 00 05 61 00 00 40 00res
> 50/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x10 (ATA bus error)
>	blk_update_request: I/O error, dev sr0, sector 5508 op 0x0:(READ) flags
> 0x80700 phys_seg 19 prio class 0
>	ata1.00: failed to set xfermode (err_mask=3D0x1)
>

FWIW, there seems to be a bunch of quirks for Pioneer optical drives
related to set xfermode:

	/*
	 * Devices which choke on SETXFER.  Applies only if both the
	 * device and controller are SATA.
	 */
	{ "PIONEER DVD-RW  DVRTD08",    NULL,   ATA_HORKAGE_NOSETXFER },
	{ "PIONEER DVD-RW  DVRTD08A",   NULL,   ATA_HORKAGE_NOSETXFER },
	{ "PIONEER DVD-RW  DVR-215",    NULL,   ATA_HORKAGE_NOSETXFER },
	{ "PIONEER DVD-RW  DVR-212D",   NULL,   ATA_HORKAGE_NOSETXFER },
	{ "PIONEER DVD-RW  DVR-216D",   NULL,   ATA_HORKAGE_NOSETXFER },



Perhaps you could try the following patch:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 826d41f341e4..263f6a59b2cf 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3987,6 +3987,7 @@ static const struct ata_blacklist_entry ata_device_bl=
acklist [] =3D {
        { "PIONEER DVD-RW  DVR-215",    NULL,   ATA_HORKAGE_NOSETXFER },
        { "PIONEER DVD-RW  DVR-212D",   NULL,   ATA_HORKAGE_NOSETXFER },
        { "PIONEER DVD-RW  DVR-216D",   NULL,   ATA_HORKAGE_NOSETXFER },
+       { "PIONEER BD-RW   BDR-207M",   NULL,   ATA_HORKAGE_NOSETXFER },
=20
        /* Crucial BX100 SSD 500GB has broken LPM support */
        { "CT500BX100SSD1",             NULL,   ATA_HORKAGE_NOLPM },



Kind regards,
Niklas=
