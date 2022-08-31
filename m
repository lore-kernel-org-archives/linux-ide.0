Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CEBECAAD4
	for <linux-ide@archiver.kernel.org>; Wed, 31 Aug 2022 11:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiHaLdd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 Aug 2022 07:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiHaLda (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2022 07:33:30 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E3B81CB
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 04:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661945605; x=1693481605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LN5tN79xd0JBp1L4vb8b1KKS92xAR3+OngnIpvMmB0c=;
  b=RGfSzAkTuim0p5dmgQhq2GICKmhYzfwcCmUUU/narQo0XbrANA0bWS6X
   8sqWIBZpKJZ83dyBkmalRl28OyXsIQeMZICPUYNOsemFm7zIDbai+XBNU
   HF2MCtu2P+C/iFCP3YGccC+ZhYGeJK2G4Fpbgz9WS0iwqLKSpZeUCRDx7
   4vZiJq3F5dpTpSsDWqcl/cIjVLr0t022hSxga1FbMyDs63mvkozjjgwox
   ey9UTUWwAGoecyIFrYWgo/irVXPRWCJ3n7Mx7l0qeaE/5ktf84Xn+DbcM
   dgQ7ojYMda84fHSDmSF/mzNLbFrSBVsmFQlslAacUyKed0rFYFBHZz8CV
   w==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654531200"; 
   d="scan'208";a="322230876"
Received: from mail-mw2nam04lp2172.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.172])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2022 19:33:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTXhYB+6JTOmHzw2BAuoupQ7f0LveCxxb6iDGSgq//sEFysIxswdz2vHWZhFtEUNso/LUP8lSW7RDT+Frmp02+c48+Cs/dibU0MKlr3oWnBkjDn5+QsVo64GtxQ+9goMaSMsXWwJaQoSRTUoxlLqqarMuTzFG/qsWOozXHcLlkBUtstgVmoa6DF9vrLzf7fcWBMKQGUanpW66ev3xvvW18pqqGauM40EtRIklWnUR7OyNzJy7hpDhsHgiFBR3xulr73z64/VIzNKOiAkxYSL/0YmeRcdALdZVbo4tkpHpDJP52kbLvGPBda3x+Ef/xZV0JANXBKvItzI5e63Nu7Uow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LN5tN79xd0JBp1L4vb8b1KKS92xAR3+OngnIpvMmB0c=;
 b=SrABKu3QSlDvcp8T2/InRfY2fSODpoRRxJMA/FDaeB4AfC52C3un39K5ELt+H/gqFVbOWLYCTHWSMnhe+YkwZgP+5VOduexuZwxswmlfSWW1s3d+5SMXU5pCrGLvvUzSPKCB2pLOjI8z/xVnrd+uLxBdXToq6O6xhNN8A6RSQT0Mnt+5hRH4bcZU+TQzu9DEEj9GN1C+W53yXTkBd3BBmr5+LqW01MXlXrR0N3vO9Shxgs2eEwqt9S6eEMmhIaLYhNc2qFtxLidYbuGERQ+DSnP61qU4lOwEUXntUF0mHTT/xPyi02adKWRTUy8+MICJZU/lT0JCOsH4nDs8CWBtpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN5tN79xd0JBp1L4vb8b1KKS92xAR3+OngnIpvMmB0c=;
 b=mycFxN45rOiNHtTcRVgg9Ym99p5M6gHGwNXVop4qQ8EFila7RXxWwhnU1Tl7Boo05w5Dp1A5YjioSHOcSNhGPaSB/hPPSz7365BuN++e6SXZmBPW8JK69rqYmKKgwxhqZ4uiJB65uaORoEJIb5+mJOV/FUUQXA+t0mvcA74F6yE=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by DM5PR04MB0573.namprd04.prod.outlook.com (2603:10b6:3:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 11:33:21 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c839:6239:54ad:fc30]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c839:6239:54ad:fc30%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 11:33:21 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] ata: libata-core: Simplify ata_build_rw_tf()
Thread-Topic: [PATCH] ata: libata-core: Simplify ata_build_rw_tf()
Thread-Index: AQHYvS14fsRFB6yJFU2u5yF+t2bH+g==
Date:   Wed, 31 Aug 2022 11:33:21 +0000
Message-ID: <Yw9HABQ398eis3Mk@x1-carbon>
References: <20220825223853.354968-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220825223853.354968-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a8e3209-bc69-4dc3-8035-08da8b449bf8
x-ms-traffictypediagnostic: DM5PR04MB0573:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OL73Cj+vL142o0cjWe1jBrnzfoVlFSSd3MoJvoRygZlRXEMWLbM8l62PaCBUSOC9RQQQ33PRDiOOlSESKvirH7d+HOKGkv5sb778kwho8nBC1P5dKXDdkWRgoqx30Sco3oTdNRcunfFm4N+hmNanplMxDIFhEviSoZKMc75s3mApjrPA+tKsvS2HqNivkn4RRK9NrEQIMckYlVVxNuqb9HR/VjzfwGqYvuXLOTPCYw47FN+jylYa4CGPM+WLD/CUxOwY9tJOEbIh5de4WSWURZc4hFd+3qo5rK++vl9LgaAGtfUkm0No8zBj1eGVdbVwZE5itqF6nHFBhEwznYgc4swXv7+rQJBuGTaOVu80hPHp+A/5CeV5fTxvBb8IClZEqtqm+dOEhAS8bpbTjMJS7fci8X5h9Zm8xe6z7oJ3rJEpOZP3hjNHbg5x/nVfOeO6QlwzyGyotNnmVvx0piuWPUlUAu2ocbUOZ6e80RTTcKyRQ6tJZ19KUK7wQn/hHDtWxxAGXoCDLHVEuUxXHAPRNe4v+jYQivm+NVHpAd/0swMjKW+t/H3YoZSAd1RYLu4MrX35uhqorgUE13f978xkAhgaNEAQiqhhxTl0Lw3M31KV8/YQtBTR9OlgK9jpD7XoREpyRg+2F1Pyu8th8/8/1alDF8MTXTCRSR+S3hAiUMCLg5DsDL2td0PsaSZVw/ozkZSW3VCQb5n/4BUSwKyjdwfn6y+YAMyaTikJNVqGB8K190M6gmN4ztqjdm/nRhhnCdfJWcWABZexrC4SxvE1TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(366004)(396003)(136003)(39860400002)(346002)(6512007)(26005)(9686003)(6506007)(122000001)(38100700002)(41300700001)(6862004)(4744005)(5660300002)(2906002)(8936002)(66446008)(76116006)(66946007)(66476007)(66556008)(33716001)(8676002)(91956017)(4326008)(86362001)(64756008)(6486002)(478600001)(38070700005)(82960400001)(71200400001)(54906003)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yXc34V+YcNZQ1A8GqA4zv5kdUjY3dbzP6B7stcFxcIFG80TD4FKkDqEXxxUC?=
 =?us-ascii?Q?j5ylgBYgKtE12a3F0o0xiOeF1GkAYWn9auRq5mnK35p+HocWU5SLDEJ/95BT?=
 =?us-ascii?Q?LPkpa7mWP/SgiEtiMrjX2ybPxV6TibRR9tWrsgl8UDINKJcGpmDzoF9cspvu?=
 =?us-ascii?Q?ZnfMXq2ZSH5HY9Eb4BPn6aLGK37ugKggKyKl72Y+o/W1LCgF1Cn3F/nLJb/R?=
 =?us-ascii?Q?7n821X0oD0zrrMxoofVlntktMZOycAjvI7ukhLaJyP88Xayj4bjYERKAiMLS?=
 =?us-ascii?Q?3s1X6xGYaU4foyrxnVy3m5I8Dc+eR/i4bjRe7TUvhyPUfS+vqD53NS9B5txS?=
 =?us-ascii?Q?7OTo6lcJx51ytcCpBvKM2tDXnGvL3e+Ph6/VhKXl8ovRQ5FYpUGcPyI8kTSH?=
 =?us-ascii?Q?W0/WtMJDEbI9Anm8DGpCzAkN2akLtAwNu/ZK9vtl9M8KWd8RlK8KstdZgQay?=
 =?us-ascii?Q?qeMG8RbSyXm20lhDSB1NDlspmOodLP69Ed8Y6SgGGUH7J7P4iYxsF4d6kyEO?=
 =?us-ascii?Q?6IKFU8wqt3LNLL3D12H/IbPuK0vg3FCwRRDt0YyzqPH2q+BcLRVX2giXRCSb?=
 =?us-ascii?Q?XN3XZK8pf/5M6Fl0cKEGHuF3vfx45KINkLeZqRJs769a2UWUgBMe9JK5JJpi?=
 =?us-ascii?Q?wyuT4CvnwAAn/d5GSRQCbMiV0l0lrck5Kov0Ta/HbH7BpSuZhzpaHtu9365z?=
 =?us-ascii?Q?+6QuMGuiMqziMK1YBrQXEvyBXWyosUFaSeWIQ/in0mUklEuyH67wdRGnWhrS?=
 =?us-ascii?Q?AnFR/veEJQRjkmESVOe5Vo9ldkYrSBO3gfiQ2PBv8UOC2JIC/Ek9w5/ZW/HD?=
 =?us-ascii?Q?+hSL2GsLOxiMXdshYxcZlpDP4cCElj1dEYMUuug6qjExLWAZOSES2kQyIbNv?=
 =?us-ascii?Q?VVVLoaKN7vhAgoMvuSab/Rc2Jpv/shKjsXDeRgy1oMrtNmeJK723Uhh/zz/5?=
 =?us-ascii?Q?DUF+Zk/OlHYSiPYJge8H9G7Yrt6kV7H3lIq5IJIZPGCL5g7f5x+mfee58ykk?=
 =?us-ascii?Q?CXfXD7+T0OHpEBYHQBQ/jb87MSP915xWFyJdmR0LF7cS+ql+aLc4tzIXjyVJ?=
 =?us-ascii?Q?J1qGcRuGRS72oiTp/HRcHos/icQARgjnyAZstT6P1GcQiF/5p17GPY0evusn?=
 =?us-ascii?Q?K1UdSfSHhA0CpFFT5Tnk5dWRmtrLJspQsCcjyZtMa+qdIcnlg8/dxoDcGIJG?=
 =?us-ascii?Q?I+1cbKrAyir+VbJLi+zOW14Dn3ECwJuIw3PUI4TXaIoP6s2aVXeTHczamp5l?=
 =?us-ascii?Q?a3SHnvVy8ip/Rn59HTMfLhWAn52JCOfNtsWK4RQb8bDvSWXoCHnxmNAPMNZN?=
 =?us-ascii?Q?HVwrvkstdS6iQ78OSWysc4UMSCTV1aupIq+t/rkR2pfaC3WtbqHNay/VpVtk?=
 =?us-ascii?Q?kALv81efiJ0FVKHfK6oWfMxxZxw1KUAzZct190QMSuj9sSqAmIFUGsBmSB+D?=
 =?us-ascii?Q?PdG99e5AzcwrXG8/Avs8s3w12Y0FDXyFnMYdh1S+o0l4qh6ukJWDa7vdQDJw?=
 =?us-ascii?Q?5FYQhPGC/5+DfDlW9op5+tLKXqSkUPWGAJCCX1xN6vZXjSyAkPkFNQHY177C?=
 =?us-ascii?Q?zZdfOknMMOkwdO3yB/ADPjvSX/XJ2WSPtalIyicg99AfRrn5RhhPxIHKjkL/?=
 =?us-ascii?Q?Hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0697B4A57E7F0428FD6E67B60076FC0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8e3209-bc69-4dc3-8035-08da8b449bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 11:33:21.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZotCtbRSKB0n8/9CvdSZDB5dLmV7R83CaUOdvEm+MbkRJbGDRbbwTr3AwFL9Z6q1bnzzryGiE9+af1ZTbpUBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0573
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Aug 26, 2022 at 07:38:53AM +0900, Damien Le Moal wrote:
> Since ata_build_rw_tf() is only called from ata_scsi_rw_xlat() with the
> tf, dev and tag arguments obtained from the queued command structure,
> we can simplify the interface of ata_build_rw_tf() by passing directly
> the qc structure as argument.
>=20
> Furthermore, since ata_scsi_rw_xlat() is never used for internal
> commands, we can also remove the internal tag check for the NCQ case.
>=20
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
