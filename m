Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D70C433FE
	for <linux-ide@archiver.kernel.org>; Mon, 14 Nov 2022 17:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiKNRTS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Nov 2022 12:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbiKNRTH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Nov 2022 12:19:07 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C0FE60
        for <linux-ide@vger.kernel.org>; Mon, 14 Nov 2022 09:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668446346; x=1699982346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FkvJsUtvBfQ8N+UB0jqNbWLRPDazPP+bdCcfjIcez94=;
  b=OdYaSS4Qhii4CBNCoTNkOUz686Metas4PIuP0imHj6Dmj8VtatCB4RbX
   l2z8+JPtAlzLeD3Ge9PE/n1KCYkNOGZiD+NvluW3fIF9xJIX8CGi0GEIN
   Sm8APqwV8Udemia+V/FQyCmL61Opf+9JI37k1QIro6AeUmvhN/o8yxQok
   /lOZmFXwIu+f3ISuyVXiWevz3Yy8/KpR+tuXVdt8WWPYLDwPCaj4x3lha
   F8xWP0MaVoUJthi9pnxpnG00kOXENLZjyTWKNfmNRY1uQ6OOEghZfiKTj
   bqXbpUdcrJk8RTPtL+XTHfkVbAB1YrWvbeZTbKgYy0w3yoqi8S69iMSoJ
   g==;
X-IronPort-AV: E=Sophos;i="5.96,164,1665417600"; 
   d="scan'208";a="328339844"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2022 01:19:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWPBKdmAp71Fk9nZGadsRllO5/qNvCcPHfQkZpXmKvUg6elwamKZnmV4h1Dmkv1kQERPNaX03HR2sC/xOWKGEKI75SKUAxDNE5P9sORzk8pNYz7IkZgggkJBb5AW45HWAyhx+94rHnH0HOJ+ttdSUyefRtMRdLsKhdHFBVnhIs/JV+QhaxDMnYzh9jMoXi5rbedJzJG9YSedlsSxtMFAPgJKZAxhe2i2S+fhqrAc5SE8equBpZ1TM7EXgUyHn0oBT7d168899QkVzNIjjmYeBsf1mMA4dkBO+MUbgKVw/KVNRMzlP1+vII6gRztir/yIeU0DTytFbtnV04D6VY3yjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wP9/Z4bxxna9XnytZ3wBFSBl1eBOIjiRryELs+9wDo=;
 b=QQujvfa37SUGs6sxV8JD5HNc9EnldF0CCnNFYqC4LcYXa/HZnlZn1aHzp8ZjjSrvskvj4aSxkeQITZ7aCELWC8oiivIrL+1MFtri885VtGr0QXhuzet/fYQcRXjd0DOnTwRzk5mFraVUDkknySG6FYyhdL5S5/HCsPEAVpjy5EwiMXbRyHrf65B+JOZLyJ8+bKkJhVgI5ilC9PKt66lsmNhvp4ZSMH8D0JfuZVfQGx229G7HgAx7zt+kgLhyAXYXvHp1dSqo6WGXf4RJkOshLZJJB36caxkuSf3a4tkbBph6syy9s32y/F6qiJZUjbWm9F62hl5V1mNBG6vDF6Fc1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wP9/Z4bxxna9XnytZ3wBFSBl1eBOIjiRryELs+9wDo=;
 b=Y7uv0g42keYcuChsa51mEM4fApG0rpQYA+npyhByWyx9q2m6EpsmFcYkS9t7isPMxrxLP2lM5U6S3jxYW3AbXHo4DCreI2YtQ6KNj+XPt2OwrieZyb8npi4PhAuQXEheylyUQAcN7fAMnFbJTii7AftzGwxWRKJhuoHx/7HcqDQ=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB7017.namprd04.prod.outlook.com (2603:10b6:5:24e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 17:19:02 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8%7]) with mapi id 15.20.5813.016; Mon, 14 Nov 2022
 17:19:02 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 1/2] ata: libata: only mark a single command as error
 during a NCQ error
Thread-Topic: [PATCH 1/2] ata: libata: only mark a single command as error
 during a NCQ error
Thread-Index: AQHY9b4S6lcdnroLWk2AZdz4y7jecK49sVAAgAD9kgA=
Date:   Mon, 14 Nov 2022 17:19:01 +0000
Message-ID: <Y3J4hLWA3SR+bDvW@x1-carbon>
References: <20221111110921.1273193-1-niklas.cassel@wdc.com>
 <20221111110921.1273193-2-niklas.cassel@wdc.com>
 <d9f8025b-2058-5ca3-0353-5c8bf67ff3c0@opensource.wdc.com>
In-Reply-To: <d9f8025b-2058-5ca3-0353-5c8bf67ff3c0@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB7017:EE_
x-ms-office365-filtering-correlation-id: 29f0bc52-ea3b-4906-660b-08dac664531f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PjzMJufxboPVuu7XU0M4Pdp/fYiWRRbkLXjRXFa7uqSPnAobL3UZBnuIqCAwjpJodQrd8mUIBTmLK2W+PMrFRrOytJjjl+Wf550sz04dHDG+dT2eu+ToDTZbNMjD/khI6rr2BGs8c5qeAem0Z/vbpgdsw+wcfmnL0WVZT7sOtNNW3QLmIVyYSP4mPuPqehw3F6TosJZ3srwPHYhOrnD4Z2G5pE2Ye3bawv7jN33+1oPnGtYsFpONTSErgXVvSLh0BgGspvdtLowWffASyxt3wSPDU/4wOQsdaJpifdLJyPY0YaE4mTDZdkCdbqeUTuOxY4Sfjv509Lmo1Y6j0+TGby5ZPl3A59rzbxnT7KM58smGTO/JLzSpucElyy/kdLJpUFN+1dHdvtFGzeN0xoJFwgaJg0m3XuK1rbO3M+v+bCBa+9kSJPfw+MU8AC759RbadXMRt8Nz9tiwGqRaqUqM7zarhW99qg3+XDf+haFyIk267DtIo0FcrQij1YxAwbV9Tbl+bm/6lklVC+YxnwBQKCSfk9CTdbK/mzts77Gcf7cwM3ddPiWGTB9MC9jOALv4rtWMzGNEmBbPSK0o13F0+dm+srq53Er4LZtRUFdOhoyuRlHsZVHsyuTF3hEq6iBhIUpfILJLzM/3N1Hzp1/nQY4HpX20JLkiW/n4fUi2nhcnf/rxtq32j+p9WM/np7APWBEtikfNHaMiDQ3DEzA08Zy1RlCOu37lfmqqsvXG48yr4Ay7lZCArUbyclv9IhGTsaGe+ANPkuusK89y1gNqeuWCZPeQrbkteQ2/usYz3BQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(2906002)(8676002)(33716001)(66556008)(66946007)(91956017)(86362001)(76116006)(66446008)(316002)(83380400001)(38070700005)(478600001)(6486002)(6862004)(5660300002)(41300700001)(64756008)(8936002)(71200400001)(38100700002)(6512007)(53546011)(186003)(9686003)(6506007)(26005)(82960400001)(4326008)(122000001)(66476007)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nhPd95XCOH6jyCLy+l3Nd+ATScVhjqzKWGMAqjv3Mf5MI/tVoRvc/vFC4cnj?=
 =?us-ascii?Q?owYHDSJZRDp21/RKX//bPeoQX3UXqx3X4arALRWAg7VIK+uMKztWwVJMYnPE?=
 =?us-ascii?Q?hqz/yifsvlE7cN8lgwvUNgLitBtfT9eknz1le2of5Y/xnopzlp0lA3ehAP73?=
 =?us-ascii?Q?A+zjhUBGQE5yHsmZik62eDYKY+l9Gpk+NsQ/Y3hKQ5rs64gSkLCacdPwl04S?=
 =?us-ascii?Q?iKqQPdGZZXF6W+aEke7uhpUyIQyh7nx94n21dkbN5LLTOIbarhi4toCkXAeF?=
 =?us-ascii?Q?fvLQpqKfL5eIx56tLODygzekzugXvHAJG9e+QufOCIyJGGMiEIYgLVQtXaer?=
 =?us-ascii?Q?ZuAvqaUNTFVFi/ohipE3NwCdYdPX4vc0/lGsdGcfu6ODiDQLmIk2CsmW8kyV?=
 =?us-ascii?Q?iuhSBgJdYYRdoK3f3CTcPpQMxKJMykKYDHnwR5V3UP0f/1I7ALfQXeRhOXdQ?=
 =?us-ascii?Q?3f4xtZVy5CSzKeJzamnrMw+mQQAOLJL3nGXt3lkX8pqcwIMz6bXCqrIRa3cv?=
 =?us-ascii?Q?wuXjF33AX7Wk8eIfUFt10pl6vIHkdYjVCzYzJhuZJczapI4VM8yv29ZoIzgT?=
 =?us-ascii?Q?TcVnZBoMlgQgIQ8tjyw2RHVAp8MauwT3SG61NNGwmrxr/u/dLdD7FVBDv/qB?=
 =?us-ascii?Q?G2ClJJEw1f9rw9gPizJYo4Tpx3EUB/vI9dV6TrKOMUwIMsGVfITLfq1ZZXiW?=
 =?us-ascii?Q?He47SxRSZSbK2Lt1hK8InnzJcaC688GM/COJw1jW1EFo5eJxOrpDAoakokb7?=
 =?us-ascii?Q?zC5seD3qwl1jRMuUk+oZUnGwMT8p2mqNQTO+jRocUxXG/Jqm+VeCEiu9jKcj?=
 =?us-ascii?Q?9sJhnIbPm4n4fup0T5iGrSNprCxCHs6kObWF4fmxdLxIzJIc+grtedKJU9jp?=
 =?us-ascii?Q?yUuX4GEcmutsnGwu1fvYu25d/OC6wFpNyL6bpBufi1W9jqtNDldYeVRYLeWI?=
 =?us-ascii?Q?OFielB/bnPDo5SgKS5S4Jy/KMZxGh9n4qJZsJufG7y11WjDsMOYcQ7YPWhqh?=
 =?us-ascii?Q?sI6ajhkaBkzN/WmKUmjhNtZ802vXMvOnhYZGg8Q04qM8/JphoEden5d/sxCf?=
 =?us-ascii?Q?k3/g8cCrFrYt6rK7N8aAJ1GC+Y+7dbrj8/eTHB10lzjXPA4N32owSY+j9Kad?=
 =?us-ascii?Q?FNzz58O0ukSkGY8g4uA3bmuciTkbtPOrWkGKX8llKNaQZutxOVhXD1SC366F?=
 =?us-ascii?Q?KVgvY4TOX5vKN+VvMzcn/1G7kRRRpJOHQ7Ofh6r5mm30AguhcUZ9MvNDh4HL?=
 =?us-ascii?Q?mYvfobUIeaW+y8IDAp3MGmKzmAFKvVzoKI/s+rkuyJyug57wkv55fEltBYnX?=
 =?us-ascii?Q?4VsEnQIU+nUy0cteWNIwX0ZQolHiOFxUE4O5l5+rkAsPVq5H2VjaAvedHnzx?=
 =?us-ascii?Q?ELSZXNgfyvkiDmiXDiZRGoI2c6b+T9vQb+TNAUR+V7nDHBSq5H6LlAvWMlZO?=
 =?us-ascii?Q?ce6TBTxMCvlB79WhpinhVPXK73qHxoS3Vh6uw7rnu40VBkvXUnm16n+e+TNC?=
 =?us-ascii?Q?RTbxe3XyumGPaZS1nTmIhv5LZZsn+Kl4w1nhJzfhO8e7B0twXlCF0LL87js7?=
 =?us-ascii?Q?AGlDrjctcYqvwcK6nkLJjjzfLcvrhmh4sCA7QdYQSY5Q0T7W2xZHOtIokiA2?=
 =?us-ascii?Q?Iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F08188D203F9CA47B5FC54D00EDBEFF5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LTe17UhLqF5KKlMsFKsPw96Wj0MR5z266/xDSc6aXApA6QZzlZEzOJ+YFRwR3XUx4UTbCKkNtt3fZFgmlhimiSC2l/FhnBtr+k2pLoGQ6/Eb1low5MeLRl4wTMWYuvsigtTfNkLZniTfjgWUop6Fgjw6CsZlntd1vtDPCWAGyKsKk5/2XC0yPwGfvSj8vAUEh91RPcG+dRlDGc1Pem3OuSReHbTqMNbhOmtVWLbR0rtlFD0fLwzgTxXpeQONNqFWBJc72vxokK+oC9Dp/z2P7wyNF2+it63J4dxcRnDABQcwML/IMSXMzr4rJGacu0iwR78629m1IJ90End8fpDFIUyFqXBp4znHHOap1PV0iYBWtPu+GWTzrUszyzCEF8vNBjBQtcmLhuorSFDJ9rAyBnhdeYo/eZsEKweeuvC56suiStpX5cTvyntch8bQ5UFbMWsjim5jWaU2em+VVHxIyNwCZ2IehyDXNTV4vF5nVrxV/BD+mIhnpSC079YJYmj0fwj/aFD/keZF6OGWDn4KiU7SMdla7BY0bqrkftiFBeg5LUDjsjPFaxpwl0vrMs8ciAt3pv/+pdEc3vRWzoGUG8rGFvWsAcWZtC9rUnOh0GJqa+mhGUNmOcp2bakOqHyCTHELtduToHoMoWKnVx9N6m73rfQWyMUxbEjyH1zR1m9PfMf3m4IeyHytBk+9LXXCAOp99Wag3obQec6pll316ikzNItbcUQlQ3Iw5QNYeR8TuuTLaCOBiAcjknGjjSTR4NffkySP9pv13R2SiSgZj5oMIHYWtm6V8UINjvtxpbw=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f0bc52-ea3b-4906-660b-08dac664531f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 17:19:01.9629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3fJTvpPYhfOtmrbiPDbEWgWobs0EJg9EdVRgtbuswROnOyA8K+X+FdQdBLm1kwBHzy+uhnwyVCdnLb9/6b959g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7017
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Nov 14, 2022 at 11:11:26AM +0900, Damien Le Moal wrote:
> On 11/11/22 20:09, Niklas Cassel wrote:
> > A NCQ error means that the device has aborted a single NCQ command and
> > halted further processing of queued commands.
>
> Nit: To be strict with wording, this should say something like "an NCQ
> command failure results in the device aborting the execution of all activ=
e
> commands."
>
> > To get the single NCQ command that caused the NCQ error, host software =
has
> > to read the NCQ error log, which also takes the device out of error sta=
te.
> >
> > When the device encounters a NCQ error, we receive an error interrupt f=
rom
> > the HBA, and call ata_do_link_abort() to mark all outstanding commands =
on
> > the link as ATA_QCFLAG_FAILED (which means that these commands are owne=
d
> > by libata EH), and then call ata_qc_complete() on them.
> >
> > ata_qc_complete() will call fill_result_tf() for all commands marked as
> > ATA_QCFLAG_FAILED.
> >
> > The taskfile is simply the latest status/error as seen from the device'=
s
> > perspective. The taskfile will have ATA_ERR set in the status field and
> > ATA_ABORTED set in the error field.
> >
> > When we fill the current taskfile values for all outstanding commands,
> > that means that qc->result_tf will have ATA_ERR set for all commands
> > owned by libata EH.
> >
> > When ata_eh_link_autopsy() later analyzes all commands owned by libata =
EH,
> > it will call ata_eh_analyze_tf(), which will check if qc->result_tf has
> > ATA_ERR set, if it does, it will set qc->err_mask (which marks the comm=
and
> > as an error).
> >
> > When ata_eh_finish() later calls __ata_qc_complete() on all commands ow=
ned
> > by libata EH, it will call qc->complete_fn() (ata_scsi_qc_complete()),
> > ata_scsi_qc_complete() will call ata_gen_ata_sense() to generate sense
> > data if qc->err_mask is set.
> >
> > This means that we will generate sense data for commands that really
> > should not have any sense data set. Having sense data set might cause S=
CSI
> > to finish these commands instead of retrying them.
> >
> > While this incorrect behavior has existed for a long time, this first
> > became a problem once we started reading the correct taskfile register =
in
> > commit 4ba09d202657 ("ata: libahci: read correct status and error field
> > for NCQ commands").
> >
> > Before this commit, NCQ commands would read the taskfile values receive=
d
> > from the last non-NCQ command completion, which most likely did not hav=
e
> > ATA_ERR set, since the last non-NCQ command was most likely not an erro=
r.
> >
> > Fix this by clearing ATA_ERR and any error bits for all commands except
> > the actual command that caused the NCQ error, since the error bits in t=
he
> > taskfile are not applicable to them.
> >
> > Fixes: 4ba09d202657 ("ata: libahci: read correct status and error field=
 for NCQ commands")
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> >  drivers/ata/libata-sata.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> > index 283ce1ab29cf..6b2dcf3eb2fb 100644
> > --- a/drivers/ata/libata-sata.c
> > +++ b/drivers/ata/libata-sata.c
> > @@ -1476,6 +1476,25 @@ void ata_eh_analyze_ncq_error(struct ata_link *l=
ink)
> >		}
> >	}
> >
> > +	ata_qc_for_each_raw(ap, qc, tag) {
> > +		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
> > +		    ata_dev_phys_link(qc->dev) !=3D link)
> > +			continue;
> > +
> > +		/* Skip the single QC which caused the NCQ error. */
> > +		if (qc->err_mask)
> > +			continue;
>
> Before the continue, should we check that this qc tag is the one we got
> from ata_eh_read_log_10h() ? We should at least warn if there is a mismat=
ch.

I really see no point of displaying a warning in case of mismatch here.

At this point, there will be exactly one command that has AC_ERR_NCQ set.
If ata_eh_read_log_10h() reported an invalid tag, we would have returned
in the check performed directly after ata_eh_read_log_10h() was called:

	if (!(link->sactive & (1 << tag))) {
		ata_link_err(link, "log page 10h reported inactive tag %d\n",
			     tag);
		return;
	}

Which means that we would never have reached this new code.

However, there could theoretically be another command that has e.g.
AC_ERR_TIMEOUT set, if there was a command that timed out just before
the NCQ error, so EH did not yet have a change to run before handling
both errors at the same time.

Therefore I wrote:
+           if (qc->err_mask)
+                   continue;

Instead of:
+           if (qc->err_mask & AC_ERR_NCQ)
+                   continue;


Kind regards,
Niklas=
