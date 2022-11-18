Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697D0C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 18 Nov 2022 09:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbiKRJoc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241975AbiKRJoE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Nov 2022 04:44:04 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F70F1B1DF
        for <linux-ide@vger.kernel.org>; Fri, 18 Nov 2022 01:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668764524; x=1700300524;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hngFtyjfn9iPAscusi4r3IV7jWU1BK0oXKg2qx68AuI=;
  b=k+VwQKrLesw+he50y3J9xWqIo7tgdCKuoEATjOBSH9aVN5vvIlKrK7J5
   IBIQQEnkJt+y9HtFWv1NW8kvcHUJJXahmPmjtOjvvltUdMQns5pg+AdXh
   p6b7WDsRG/5O3PSxiL5YILpr1usJkZxYP3Zd6fZrZgIWP5Puh8j3AnmVi
   Eu0cqZHbnH8Wnw/7Dbs8Fi5nVCCusnKUN7Zt87NGu5fPJ4wCzUCS7ldtr
   EE8HNZCNC1mv7lT/RIbXNRJRkaszKhqwTVDX3oSI/w//ILhZ2Bt0YhlP7
   x8NMeWOOVzM9vwpDP79hDASR0MPaikwI4krH9viBtplgfWBKK2GcPfPM5
   g==;
X-IronPort-AV: E=Sophos;i="5.96,173,1665417600"; 
   d="scan'208";a="328701417"
Received: from mail-bn1nam02lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2022 17:42:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJKq/EhOfQW33dxZQgqPeBJst8DHERJ+avVqfWjkv4GvxgmOFHw851NPsYha+7SXrgFtc4SzoprtJyI/FuoEPv9f4ImIXY3tJUOHfDOZ4LzJDl2DNqYI4mUQjwtK3f2cQvA9gSOSMim7NSw7MSXtyK/OcyT1ddrP2R27qLrvCaABqWrCYcIA9lK20NGgUie2YzC/ZzppG4rVmCJbPhIfumqYjAbAqQABebaAERLOX/eUPAbbNBOV9dN8wYYbJClMruWSGTwU1tUsH+HnOu4ytqW43WCYL7vnPxfPP3jch/TN1+xhOUqzTkh12FtTnc1QfNqXmLqRXwDMTPwNncTIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hngFtyjfn9iPAscusi4r3IV7jWU1BK0oXKg2qx68AuI=;
 b=Fg+mqhKnqW4mgGhSYO2h9tqw02KkoJL8GmlYYgSqnU8KrO5TP+JgAITSTrBD4wI20ZwnU6c9GUoQhv7vpf+Y3ysyfPz7ESvNyAwMFxnc2y4j5MSBW5vnXZm6Vw89xf5zBe+XsnpIugD7193qT4Vr2JEjfAvHuEWlsXcHS6d6qRKAEPGYd2+tmGibr+gRzLRqkitwtBJ+rE3AdE6fkjypqoQPNzGtnMq0aaOOOANNS9FFb4LABSjNTdAlujB+pKJLx96itGl9BaWnJKKQ29/OfFaPvO92sph4pGYJyFRsxF4KXRGs9UyofM3pLtTA8MdOLXvwmFSCx27S2nQI/+siEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hngFtyjfn9iPAscusi4r3IV7jWU1BK0oXKg2qx68AuI=;
 b=n+OQl931r0ZxEtfR8clEBWIxJyUckFlwskvClFUn7FmwxkHIbstiv9Rzfnr+c1jI4LBYhqQzWAo7/IKIweY2rOSB4BaRQg2MH1qB3iv1FHsmzGMCml8YKQtq/FEorzoi06b0NQkTwNa1mnPSPoeDs4bHwq8uVezbKVgiWcQCtGI=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SA2PR04MB7625.namprd04.prod.outlook.com (2603:10b6:806:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 09:41:59 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8%7]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 09:41:58 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH v2] ata: libata: fix commands incorrectly not getting
 retried during NCQ error
Thread-Topic: [PATCH v2] ata: libata: fix commands incorrectly not getting
 retried during NCQ error
Thread-Index: AQHY+E2iGuvhvk6ib0iD1SnjwjrWTq5EHxuAgABUSgA=
Date:   Fri, 18 Nov 2022 09:41:58 +0000
Message-ID: <Y3dTZviXX8x/YJb9@x1-carbon>
References: <20221114172200.1475962-1-niklas.cassel@wdc.com>
 <3f2f4518-1cfa-8872-3f5c-049a2c92aa99@opensource.wdc.com>
In-Reply-To: <3f2f4518-1cfa-8872-3f5c-049a2c92aa99@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SA2PR04MB7625:EE_
x-ms-office365-filtering-correlation-id: 7e2ca1a2-1b9b-4842-4066-08dac9492361
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cQyr93XSaneaaOg3IHyW6aPpem1cmMQ/oEGQop5O0Q6tAMuMqZKGey5QOuZWGtAm5edQRJ4CctkNFEjWgixLlQMWFVfNBbIGZciJ3FhK+6I6/BM65ygwi8piUXNNGndZxxKFpzZQPvPzT3TtQ7clFaGsOJbtTXtozFiqPFpe2yZBlrq87iWowmh/g4bZ4bdMetO7W7WmZbVauVX4kbk0DMH8bPBcIfXnrBNvADzOktH8NHHp6cV6yt+ireHlA0h+41xE/E6JXnGgUZJFP/un7oXAUvIDHZTOdy7F84ZZyOamLyr/0MAQy13AMUMadQWGT16x445a66CD7DLpdsaatKWL8+QLu7gRrIPp0wfN1ZtS0X+ol3Pxch2jq92leyalJ0/kXTmHWYJFV0l3ABuMGpgc3Xt5Zp+d6IreEZwAQKWarkiovmhHBwRU5vG7we83rV0G6ZK9uzw9pSfLmIBjgsVuWeJ10qoFtuwzPBrRv5Vj2njI1T/QYTpuJZGF+bJ30zvUwXiKoQeDyedHpuaZVzYrzCaxwsQYYnGP+cXcx3EepTXXaZaemvgsM5JQgTusosZ6TLMOlCKUCfRFdjeemQg6iM6kbsVfoADUpLzJBGGax6oYf9eb9TXBrwplZDvUDbVLiJSUPUVgh8TOdL0C3xljvym7wH9S1DVUwxdzPNEPLshXLjBNXGARtECt3ZnFN1zcdoKLuu/JDVxSWaz/7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199015)(6486002)(478600001)(38100700002)(122000001)(82960400001)(41300700001)(33716001)(83380400001)(2906002)(71200400001)(38070700005)(186003)(53546011)(66446008)(6862004)(316002)(8936002)(86362001)(66476007)(26005)(76116006)(64756008)(66946007)(66556008)(91956017)(6506007)(5660300002)(6512007)(8676002)(4326008)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w04kMbmsUjDlfl0NmcxSvGDjQyChJ1vfZWCRM+dFz07Yk0cxOV6AUg7zaYuB?=
 =?us-ascii?Q?2MjtvRItjHAzE0rrffQLsPFVqJdK7G/hNS4mpcP3zb8Nv/sN0curgMVBzm6J?=
 =?us-ascii?Q?Gh0mAB6clG9Le3xnSP+KL2i6r/vJaeDXnk6husNjRXrPT1VV7NjtfOEyJ+Z0?=
 =?us-ascii?Q?k8eVn4U5Wgwd3ZdKkgT6t8H8nVH4AQvqygEgZ2jUHTo5KTsGsu85MP0YQFXR?=
 =?us-ascii?Q?L1gfLNJl5boYrf34r9AAct7SwJNJZ+T6jAC3F/aXlr4KneWm1tT8CWKy1bQY?=
 =?us-ascii?Q?U1sYMhZTB0jKbuQ0cbxWgxcPM4rQ/LbF1ZGGwVZnHW5MAaebvOyMiKq9R9gy?=
 =?us-ascii?Q?+la4T5TwFFsqO3A7ugg/LD1F6febmfV9pxcd0wGiuE18iHnzK+M1v4KfcJq6?=
 =?us-ascii?Q?G4WrG1hWMm2+yIi11orPQmEKXi/m1gfO7GXeJXIA5O3A96K9To43SbLtG1/u?=
 =?us-ascii?Q?8rBjlMYaxqnSChH1iMpP+rZGXmsYLPQ88RX2BuvSYPrN7c8pIbRacCwN4NiE?=
 =?us-ascii?Q?2ZerfiTYngy3rWgv3JO/yfZkydGVgozE9xOnZv2XEvmFWawka8aQp8+OLOvj?=
 =?us-ascii?Q?PQ9VMBxHfbFkGoBr3U8EDPPUtTC/vm2WclOHTeo9hN3AS5IrSprSEpH6jt7Z?=
 =?us-ascii?Q?Sz317RPr7v13wrL8UsDUnN4HIm4eZidvWOK/eZ9+5IKQJbKWD89PxnPkpezA?=
 =?us-ascii?Q?Q8GtCCvsCFMOs7cgqZ85T0MPkDwSg3Qlw1b9lat9Z79dnOR2C4oxUUJC/f0k?=
 =?us-ascii?Q?k4HY1bC14+0cZgCPRoC9tsEaHU95t+fmOlZ4kYPNWHi5Zim9aT3hM+8xoN2d?=
 =?us-ascii?Q?a89mfdVkCN6A05pUgGdZ8oe4G8BrnTMKWiaysDGsv3IeT9bc5bgafCcFVLKR?=
 =?us-ascii?Q?Ceah9lO3SyELolbjqv9hFZJFQtRWehLrCSfw6SW1/6Qcy73hXlABX+iul+Dj?=
 =?us-ascii?Q?Hgxlx5sQd5ZioCK2msrCz9kWzew8/sjIbqrBNbWhiPBRawjr8db6cf/Sysni?=
 =?us-ascii?Q?XeVfWLNG4y3jw9lEvCdrEtnSUSEbVFuANPpCkBm1imMcgfRIR2YuWQajnk1p?=
 =?us-ascii?Q?h3boz9wgcWd1z5jECq62Ql1OCRGCrvSARd4KZB/8UvL1yqS10ppN+UV3HzKO?=
 =?us-ascii?Q?edZK+khOB7s4U/B/wKkyb/UOXf2pojBl2VRTmTwzMjbz5R+TkBx765e/capK?=
 =?us-ascii?Q?BSPd9lEnJImaBeAkUe47Gv5WvCatlVLfP2kqpBGdyvpkuJOm3tgXrtV3C/6H?=
 =?us-ascii?Q?W+YyBrkwmeDIaT7ragQ5aeJZoQRzef9II3PiwhFPhFOLgpkkTLjjfpqaHJJo?=
 =?us-ascii?Q?s2FEO/aHrjVmoNJuWNDNz+ZB6nqo0DpKT47UCuAd0xkGxl/tfkKP2E0Y7VUP?=
 =?us-ascii?Q?wnGgwHAgKgLd8SguycnMcDL8lI2GJi5jOma5lv2zCbi7FZgLZZje53gRfI39?=
 =?us-ascii?Q?7VKAlrjrgc/hoT3ptDWTLh7NVktsEzx7e7/SIa6Vi/HBBFJFPxL32jvrIOop?=
 =?us-ascii?Q?oQUp2hn2IJW81baGQVpQhKCccN1c5msxg7brtN2rysNGmrydxiqig2KnO5j8?=
 =?us-ascii?Q?58n9dpXuUBPgBga/OfWv2kT8MJbXd7+AZoVaVlYJ?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EBBB44934CD7746B69D0F37E0CDB068@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NJdj3+uCj7ttL0qieQUyHaFJZsoBwnNnFWJwK0WFBdNPOqaY8RppWfo7bKUaYwu62UQqMLgcgzika8bp2IABR3H5Bmnx7VDKqc1HN4jKxump4poQRzBvap8QK+incIWRaW5issTEHf85D/Ju94sE0U2faN42eHFIZ1OuwKEVTdMISTs+a27lKzAH10SNgc15t8XXDDDePm7OzdlaSy+Y5jrmM1Db9EwjjKav7so1957gFgAn0KYwQ7IKMqF7TtNaDZyN/V9M1XZdFNSmQJtNMMNDLjeV33bnznDQ+gn18igSCMAQBheOfix8KvOJX+V/2z+oBPxKsOCpO25ECJilrai5ScrvhA8opRPcL4xSq8f+a1iEVSqYnSjwU3OIz47LgK6LK15IUO4qSA9UrXL7Luq8mJa4Xrsss22NNwphsJ8Fw5hCxVt2kRE50Vms9ya6jMPNFSykKLUwMxx/13kR0eoPn25D0yN92R8/iYEZ5cc4g+ElQWTlvbK2A8aYTKf7mONsyypEWCeIfnUz7ISu1Q7ZrV+15j53w/m5akMOqaTXifzWjqa/VomlrdHD0z17gFjMzLP4aXaeTHGA4CpAZ23fJPEKSCIiKEgOZSK5tzBEwifc92tV4Idn2zE7Q8RBooFjBcxHZgfbB2ElNOYVCXOkyh19A+Xgr1alrJjefyu6oVsyyfIGJAysHBWKiXdYbRX4pSF0YwOC0mjyTBepZ+VIgQnkUMWgqO/mDbOeGJOo3dkLmOz9CVNcxfkTfYNfmEyQQwbutMFcPhd7pYcQUij98M7ikUOj+/ExQz8i4z4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2ca1a2-1b9b-4842-4066-08dac9492361
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 09:41:58.9405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QybNQk8N4cIQYoYYYDfSf3tykVGBPcF9B2XudocifWCYCU6/jY57hPV3CZqapjH7y4zo+do7jJ35ravk7McLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7625
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Nov 18, 2022 at 01:40:17PM +0900, Damien Le Moal wrote:
> On 11/15/22 02:21, Niklas Cassel wrote:
> > A NCQ error means that the device has aborted processing of all active
> > commands.
> > To get the single NCQ command that caused the NCQ error, host software =
has
> > to read the NCQ error log, which also takes the device out of error sta=
te.
> >=20
> > When the device encounters a NCQ error, we receive an error interrupt f=
rom
> > the HBA, and call ata_do_link_abort() to mark all outstanding commands =
on
> > the link as ATA_QCFLAG_FAILED (which means that these commands are owne=
d
> > by libata EH), and then call ata_qc_complete() on them.
> >=20
> > ata_qc_complete() will call fill_result_tf() for all commands marked as
> > ATA_QCFLAG_FAILED.
> >=20
> > The taskfile is simply the latest status/error as seen from the device'=
s
> > perspective. The taskfile will have ATA_ERR set in the status field and
> > ATA_ABORTED set in the error field.
> >=20
> > When we fill the current taskfile values for all outstanding commands,
> > that means that qc->result_tf will have ATA_ERR set for all commands
> > owned by libata EH.
> >=20
> > When ata_eh_link_autopsy() later analyzes all commands owned by libata =
EH,
> > it will call ata_eh_analyze_tf(), which will check if qc->result_tf has
> > ATA_ERR set, if it does, it will set qc->err_mask (which marks the comm=
and
> > as an error).
> >=20
> > When ata_eh_finish() later calls __ata_qc_complete() on all commands ow=
ned
> > by libata EH, it will call qc->complete_fn() (ata_scsi_qc_complete()),
> > ata_scsi_qc_complete() will call ata_gen_ata_sense() to generate sense
> > data if qc->err_mask is set.
> >=20
> > This means that we will generate sense data for commands that should no=
t
> > have any sense data set. Having sense data set for the non-failed comma=
nds
> > will cause SCSI to finish these commands instead of retrying them.
> >=20
> > While this incorrect behavior has existed for a long time, this first
> > became a problem once we started reading the correct taskfile register =
in
> > commit 4ba09d202657 ("ata: libahci: read correct status and error field
> > for NCQ commands").
> >=20
> > Before this commit, NCQ commands would read the taskfile values receive=
d
> > from the last non-NCQ command completion, which most likely did not hav=
e
> > ATA_ERR set, since the last non-NCQ command was most likely not an erro=
r.
> >=20
> > Fix this by changing ata_eh_analyze_ncq_error() to mark all non-failed
> > commands as ATA_QCFLAG_RETRY, and change the loop in ata_eh_link_autops=
y()
> > to skip commands marked as ATA_QCFLAG_RETRY.
> >=20
> > While at it, make sure that we clear ATA_ERR and any error bits for all
> > commands except the actual command that caused the NCQ error, so that n=
o
> > other libata code will be able to misinterpret these commands as errors=
.
> >=20
> > Fixes: 4ba09d202657 ("ata: libahci: read correct status and error field=
 for NCQ commands")
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Applied to for-6.1-fixes. Thanks !

So, the Fixes-tag points to a commit that is only in your for-next branch.

If you this patch to 6.1-fixes, then the Fixes-tag points to a commit that
does not (yet) exist in the tree.

If you prefer to this patch to 6.1-fixes, then we should probably change
the Fixes-tag to point to:
e8ee84518c15 ("[PATCH] libata-ncq: update EH to handle NCQ")

While the problem could happen even on v6.1-rc5, it is highly unlikely,
as v6.1-rc5 is reading the wrong status register for NCQ commands,
which means that during an NCQ error, analyze_tf() will read the status
from the last non-NCQ command, which is most likely does not have ATA_ERR
set in status.

I think the only way it is a problem on v6.1-rc5 is if:
1) A non-NCQ command fails
2a) No D2H FIS (non-NCQ command) is received with ATA_ERR bit cleared,
before 3) happens
2b) The device is not reset, before 3) happens
3) A NCQ error occurs

Perhaps just queue this up for 6.2 instead?


Kind regards,
Niklas=
