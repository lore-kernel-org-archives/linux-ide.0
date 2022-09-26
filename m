Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42CFC07E9D
	for <linux-ide@archiver.kernel.org>; Mon, 26 Sep 2022 15:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiIZPwX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbiIZPvx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Sep 2022 11:51:53 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F2710E8
        for <linux-ide@vger.kernel.org>; Mon, 26 Sep 2022 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664203175; x=1695739175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EO5otKgAT9RpuFlxkPV37/4bk146LmDLRmtZgQ8alKs=;
  b=Vnb7htagp/D69Hi1RtMOnAYysr7p1PLATs+zzBPavtJ20FNjFs5txjZ+
   bEKxiNmb6q/IAPZeXUSsw/trUv5Rb3+mlvtBAihOIGCuCO1le3ZY4SRjA
   Ub2PUB160eikyUFGb7iKeMyTHeWWlvSHLHW4YHc0hWTNdaGF3yXw6Jwjg
   P7+1ZaRa5lZDMUNu8S3unjD09IgIzjDv/Lqy2m1I7MNFZB4uqHwFdw6RS
   4nFlzFGZxLgiwbYTYLdPaNBH6jr7e6gXTLfw4tBIG+CttTYYvz3iLcqYO
   Ulcp3M6EqCj8h7CEhZpw0C8tXwhF+QYt2pHx+GT4cMLa4BdrhPBYB0tQf
   g==;
X-IronPort-AV: E=Sophos;i="5.93,346,1654531200"; 
   d="scan'208";a="210659771"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2022 22:39:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjksoZwhrAKQOti8OkA/3SUYcU52c9ruvL4HlGmMNi7gMmnShf75XOZvRsR5wG3SogG3YQJAzyetbCHISAIghh3TdVCmY9hJYq1+Cutit/sIa+0op8muGNSvLQNHZ2hddgFnyZ1jCoh/JoncZ0j/D3Mn58D10tZ2m2BQmv+3Zm1hD+H8/HPRWHm3OcrMYDDPEOPqeuKmRimvjUDXEDl+v5EXRdSFv7vbPpz+uwKdCycri622ll7HDHB/cgEsTofyXFmA5NrPAyP5DA01cnXOfRLJ+4K4fpJYgz3O4G/ljbyXePqnnpw1w3IiE/9VgYxLbKh4JR2Z009RmPhQR14GNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pZWqANVwVZ1FtRRUZ60qvT4h8eEoMeZ55I3CjF1RRE=;
 b=DeZeCAdBrNGmLMSWjjPzezntshJyf6tYh20gkrrFU7U6Qdchz8ukUBHP/EmQkufYQaVK736/1kP0J5skb98eL5xntWZXnrq6h1HdD9YniDLGjviVTGuO8rgaTvkI5QtxkWMXRMFT87nDaY4zfP58rIKSvMlYiiElYuehUAi/R7VcmljS13Nk/QzklmcREL6r4d9B5hWAyhusvW0XG2QOEsTFpBstHhxeuno3Bzurng7n1CQFwdoFc11CkgRZPDFMNKHA5jqSD4FPa4cPHMs4vPeso7n6emfZsBlRcd4vKQ9sgYn0D9meHSPDG+A2FHx2gwh5t+jGWO4CoOlKzA3RJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pZWqANVwVZ1FtRRUZ60qvT4h8eEoMeZ55I3CjF1RRE=;
 b=DOcGCqfjOyWrB+oHBXU0BJTjOs1LDAuzEmWsO/l0F8Jj5pSJ8jzPFQ+8zoI6bmeVNbWGP97/qBkMU4WBu+NZ39qckcOHsrp4MN8JBQwurRlfdGvLxorX+pEgS+JLR9Pdv9Hfk/fGw83jS/4ncsGuPW6WjJoCOSNMKSMBvDQARVE=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BL3PR04MB8108.namprd04.prod.outlook.com (2603:10b6:208:34b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 14:39:32 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa%5]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 14:39:31 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Multiple errors with DVD drive
Thread-Topic: Multiple errors with DVD drive
Thread-Index: AQHYzPHXLJ4Av5O6AkGhkxFRY031g63xtbCAgAAb/gA=
Date:   Mon, 26 Sep 2022 14:39:31 +0000
Message-ID: <YzG5ol9ta2vmb2qn@x1-carbon>
References: <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
 <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
 <Yym65wlizZydJ/Tn@x1-carbon>
 <9756ac37-6790-7b83-5840-abe04f8ab838@staalenberk.nl>
 <Yyor5zsqHAoNimF3@x1-carbon>
 <f3111c18-704b-1845-1d39-e220642eec34@staalenberk.nl>
 <Yyr8aV5CEOuChpre@x1-carbon>
 <e9893bab-f2af-bae0-18df-924f9ff4652f@staalenberk.nl>
 <YytYzTIsqcB9nElM@x1-carbon>
 <43161bf3-5a92-ae25-fdc4-57ca2721b359@staalenberk.nl>
In-Reply-To: <43161bf3-5a92-ae25-fdc4-57ca2721b359@staalenberk.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BL3PR04MB8108:EE_
x-ms-office365-filtering-correlation-id: 1059342a-d7ed-4fed-7ea4-08da9fccec99
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QQu1FbR8aRMcml2qAcRJziPOtXswK4Gp0H+pphjzngLqg9RnFnRwM5VPggcNsnqAkARLjoZECVBKIrPKK4y0N/DNCFfUbULy70okP2apVEz7BuZYCZO/VpmNOGZdV/kigQRAn2O5FrRkEK86OU7EQA2lxqCO7B39ISqaKsnJQ7J0P6XfGGl34N+rwBNQXVXvM2MPIAN4F+bL4sMoPzLDzSGHQy84a37+76GJhK1DXmNjp0LXBgA8x5fQThidM0VueQOZIfzH+W22KlnM+7qaEEdjxzxh5p8gcnvmrtbTMfVfA7YT8/TpKmLvUORAKSv17E+2cqIZTQKoO7fo9LKKbZT6tFN6OQ/8ObpB23qhc3m/IEYi8JjLn7uwlKpuqJ4v5ah/zrTcUtcCkvjdZY4RqughNzeUIocXPTBk8/bQbV74fnCKCzVvcY8vdsMZoJW+CjWCdSeNIIb6oMl8i32sGBwtW3/YpP+wxb//2Mnhc+cV5mvhJnsvx96sUSkVqzQFFQ3ZXaSg7gAlZ2GMWtDAv6DXw2DL1AQEZQw2epHpaIrk78cEMjQsqUKnI/Zk4dfr3CB4VuFVDfqj4Kr6tir5msCuWcHZO4fj9IBSLrLV+nSMfjg9fSq8ubT8gN+Tf4B9Cn7VmEMI+d1fYcUpijUpvAubKk6QhgwSKyjcpimWpYDQ9HIWr1gMZjcUSDUVuaRRq9bQ+W32TBeLatOrxS78LeGQkyVsPR3lJckUmcEIyKpzWhMniPOe8cfXJNVTHSYGveRDtgm8T96CvjjgavjfOmLcOjeXV4ft9CU0xHGUgC4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(41300700001)(33716001)(38070700005)(66556008)(66476007)(6512007)(66446008)(64756008)(8676002)(4326008)(91956017)(76116006)(66946007)(26005)(9686003)(2906002)(86362001)(186003)(8936002)(5660300002)(478600001)(71200400001)(966005)(6486002)(82960400001)(316002)(6506007)(6916009)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dfwjFWO3nH9d9WM6oMtnvpQfLir5vShpFf2ETeDF5w0Ee4VDghqIFdE5+E9y?=
 =?us-ascii?Q?L1I4QZ32vh2mliYKDboJkZouLxGzuAwMeCicicvwcGyQLjepNn2WylYPyUfP?=
 =?us-ascii?Q?aRnieVeDMf/0tqYbF7LqOYHZntEXK+Eq5FJxijinr2MtpPfm3zfW+5VwGty3?=
 =?us-ascii?Q?wLIdlkQijEKcy0Km9OE427LTlUs5NAk/WZN2ssErXfmtcMtJ/Y0cQLScw/+g?=
 =?us-ascii?Q?dhKKmdcTsAu7YhgzdF2XohcyFg9FAg92AwpUZmJDBkmMehkTc8ChpL2NN3fi?=
 =?us-ascii?Q?U3Cc/PMohDvC8bCSJJUr2LMPSn9wW/6dFwLqBgDYKdrz81+AQnNXGtg/6LXK?=
 =?us-ascii?Q?uFgo6ZT5DehFqZ/Ehr+ta8P/oWryVGbzxcSGCR2fbesTcWr8pLtTD3ehfZ1F?=
 =?us-ascii?Q?WnbRtx2IphhWha6fV6nuujc7ZAOtoEIiNyiD5z2oc18eY0imrOnyYTUwm6Ko?=
 =?us-ascii?Q?b0yuGDuI40hUkzMNzF2e8TWYOUrMuu+4PvC8z0Hcpc9b6G33MnTo8sOKbd01?=
 =?us-ascii?Q?DwhNxU0vAIXbM/0iYW8vUPeaQshGqWoSxXbJ3aVqpC67RFrVDcWFCxuTPFug?=
 =?us-ascii?Q?2AoBN1SV0wNKBwRGBJjxFVXSGazTBcwNys8kYR0k5HzCJxVntjEnMGhQTu08?=
 =?us-ascii?Q?yY+KJsekh3lcAnVMKGSLLlJGcdCkpWLvPqHv8JxFoL85a2cc5hozC/rY52vn?=
 =?us-ascii?Q?qlOcuFKkQGzW3SLFD2MbP/Jdi9DkNC7PnNYpPgPkopIqj+7lejoteqbG4x8a?=
 =?us-ascii?Q?dpzQs207SQzLT7ofjn719FyCV4X2lO2PVJob3aYDQekKznc3Ww+d9eA1uXjQ?=
 =?us-ascii?Q?kfA/FOHYWKrN8YOQ6kAkA75YF2y5MbwujN180SRRU4QYmiCBDxS0TZYpPm+M?=
 =?us-ascii?Q?DSw9D/E3K2dD3oOGXpqNbd0j0gLZD1yz9cqzRqgw6Eu0eevXtpv+awibZQnK?=
 =?us-ascii?Q?/sH5o+AyzkNs86F734RW4+JakC7PrUPbnIF6OQeVeW8q43pLlvlYST36fYvf?=
 =?us-ascii?Q?6xEQ8mKecl74aqVTNO1zU5ptBWbulYgclg5UO6jWddUiV3qc5uGztjlDXxgw?=
 =?us-ascii?Q?yBNumG5ZMmwUmElphIyYl9tybsQD/4kq6XWmbo75afbUTIEXLsnAKXj2jV2q?=
 =?us-ascii?Q?RT0n/EOUXkI9FbZO32qWXFtC6Qf5dQErxkrnLllcPibl+P+2eZfA3mIH6kGh?=
 =?us-ascii?Q?5IET2o3f0BPRl6tqnXNFRZG3fZTRbXuDkLIb3m9M9G0SU+TkU9otiPJLfTMa?=
 =?us-ascii?Q?SLsM9Gj9YSXNtmms5vKVUZ8WKa/PTZPOzMx/LfJoFh/ClZTdiH3pGxg8Uxz1?=
 =?us-ascii?Q?jj2alSySfC9WqmeGZ1NM9tSXVo1Dc7S3VbGbD4CAkzZtOAPTCS9yKlQ600gT?=
 =?us-ascii?Q?HlYMoDrqW3uUPnfcjICaTtV4q9WerVMxXD6J/8yw/aFrGvInnv9PwBqo1zyv?=
 =?us-ascii?Q?fTzVT1Y4fnqCYYrCIee+a/yLHkyDRukHMlKJ1mgg2L+USnlnf0yqnG1jYyID?=
 =?us-ascii?Q?dqfI1fR/UlteNKsQCC+IT0wfYahc4t7x5llZpRxstuQ9OriS7SYo1CO/TCac?=
 =?us-ascii?Q?SQ5s50bEkY3roFgWemFLlUGuKmGRzGSC+7HWcRvaLWz1aW+GZTC9Xg4XRSRy?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B585A11E489A3E4CAFBBABFF61FBBDE6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1059342a-d7ed-4fed-7ea4-08da9fccec99
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 14:39:31.7817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZIcy/gY68HzTH5W8AQGsqH6F33D0PfXCwn2gbM2qGOUXziq4OWKOaMM0uRaHWYAXA2byEsqGjdFKGJD4gwT8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8108
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Sep 26, 2022 at 02:59:19PM +0200, J.J. Berkhout wrote:
>
> OK, I got around to testing the patch.
> I used kernel 5.19.11 (from https://cdn.kernel.org/pub).
> After solving the problem with errors with the compilation (I removed
> the NVIDIA driver and switched to the nouveau driver) and space problems
> on my /boot partition (solved by using sudo make INSTALL_MOD_STRIP=3D1
> modules_install) I got the following results:
>
> Try 1:
> patching libata-core.c with the lines
>	/* PIONEER BD-RW BDR-207M and PIONEER BD-RW BDR-205 have broken LPM
> support */
>	{ "PIONEER BD-RW   DVR-207M",	NULL,	ATA_HORKAGE_NOLPM },
>	{ "PIONEER BD-RW   DVR-205",	NULL,	ATA_HORKAGE_NOLPM },
>
> resulted in
> link_power_management_policy still "med_power_with_dipm"
> problem with pioneer DOES occur

Thanks for testing!

libata-core.c has this:
	if (dev->horkage & ATA_HORKAGE_NOLPM) {
		ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
		dev->link->ap->target_lpm_policy =3D ATA_LPM_MAX_POWER;
	}

and

libata-sata.c:ata_scsi_lpm_show() has this:
	return sysfs_emit(buf, "%s\n",
			ata_lpm_policy_names[ap->target_lpm_policy]);

so
/sys/class/scsi_host/hostXXX/link_power_management_policy
should definitely show "max_performance" when the quirk is applied.

My suggestion was to try:
+       { "PIONEER BD-RW   BDR-207M",   NULL,   ATA_HORKAGE_NOLPM },
However you tested:
+	{ "PIONEER BD-RW   DVR-207M",	NULL,	ATA_HORKAGE_NOLPM },
So I think that you simply did a typo in the name.

Looking at you dmesg again however:
[    1.043657] ata1.00: ATAPI: PIONEER BD-RW   BDR-207M, 1.60, max UDMA/100
[    1.057988] scsi 0:0:0:0: CD-ROM            PIONEER  BD-RW   BDR-207M 1.=
60 PQ: 0 ANSI: 5

It seems to print two different strings:
"PIONEER BD-RW   BDR-207M"
"PIONEER  BD-RW   BDR-207M"

So I'm actually not really sure which is correct...
I guess try both and see which one that works? :)


Kind regards,
Niklas=
