Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89026C432BE
	for <linux-ide@archiver.kernel.org>; Mon, 30 Aug 2021 21:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6827860E90
	for <linux-ide@archiver.kernel.org>; Mon, 30 Aug 2021 21:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbhH3Vqq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:46:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29450 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbhH3Vqq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Aug 2021 17:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630359953; x=1661895953;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=T9aI4lMAJl2aC8sd3KjLSd+pk59hjK8uqIqTrMBdsc4=;
  b=eUg8CHHNUJTB8zDynOtfc4IHsozhVtvYreiioeWbkBIK/vXQplfaV/ZP
   YDOfVdAmIFt5sEPuNHkCi5SmzOYhQG4hEEgY8WsBCWBg5ns9PPbpgl2Zw
   o0foiXXnGkkOfdJnId1Cb+GYmmzT/1u3NLtGpf3MWHN5dhW50Na5DgTkF
   TnK0WP9N3kdmg43bp10aC8tPDcK/9rEhCKBbEx65ooUxmcb/UisGak0/Y
   r73egOHxcNyjUjzzd7vSW8hgvqvcJPX26eZ7m0P+vbBeVpH10XBdSDEgk
   U9olnozLknPyLbi63d8cUTOowb5CfO2jDm1+PZm+3U3bJybflE1mvLlqg
   w==;
X-IronPort-AV: E=Sophos;i="5.84,364,1620662400"; 
   d="scan'208";a="179348458"
Received: from mail-dm6nam08lp2047.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.47])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2021 05:45:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUHbifM6Nv+WCx6zL2Ls4XYnDqkZlawnE4Oz7oTohLdY/ZS8gygEVnoz7CiiX0S3A1CZAeLHvZ+/JQHulhfn53AH5dMYjUpeteZsG2g1ESLePaocIWSlqcOcIPiHWTSdTrtAdq1mITViKoOVejMQ/6cmcrQgyQBPh7CFC9y6vDBaezEEKolnMsWOZZRsgiVvq0+CMdvO79QS74AEepBlOcfGuHHFyhMSPlcAZxvepgnBpphfeqRyk0DO/JdQPr/U0SuOx2aghwhHdYMq+wmKDLT7D8st7LuY6QJopwgYAzD3TpmngMqXrXnjbW8FBxTOG9WkKXt5xVtd0JTAO+wTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfVslO6U95z1fUpGDu00/cl2X4I2eohqPtuBfnGFHWo=;
 b=DVLyS5BZFQwE412W84ShvaA6MZiFJKxAuTDwtmCWlQia93hj4E/mqbOKezpGEWSi0Th7qdIWMBfjbgmjQZgSxDpNBFvuk6mScEd9Q8/PIprkORb3npRCkEjnlQmojge0SVSn2pcivl5kpz+s22BYrBA8D8s+0fmozOd/XDtIWpvpwMo7WaD/SvrJ6p6AaTUd9g3FbLvaETgVYva/Ztpjw78XkWAZXNBTNfxsEFz7IELmxa3iQJtrDib+JDJe6hW+fQWY1v9w2+uuAqffXXoB9c7UD38J0Ry32hq2XvnTi8Hw+fkiZ+LnWLdP8ihMkO7XQyC+ei7d8QTePOikAmKHig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfVslO6U95z1fUpGDu00/cl2X4I2eohqPtuBfnGFHWo=;
 b=Ns/beyEMZr3rBC0G2mwdvR3NRuQ+K83WBhWz9I27boZnsKCwdg/4pkuqaguZ1ZjI77zXpwM9a7+Hk6PLvqphDV7JdDhFjBRtDnw8ZBx9w5hiVGuAvNtGfofEzGR8bJNCkzg8RY6AYC/lsxuX1nSlpgbkxCVXVX7+x4LfXvmTKKg=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0810.namprd04.prod.outlook.com (2603:10b6:3:f5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23; Mon, 30 Aug 2021 21:45:49 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 21:45:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Hans de Goede <hdegoede@redhat.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/1] libata: Add ATA_HORKAGE_NONCQ_ON_AMD for Samsung
 860 and 870 SSD.
Thread-Topic: [PATCH v3 0/1] libata: Add ATA_HORKAGE_NONCQ_ON_AMD for Samsung
 860 and 870 SSD.
Thread-Index: AQHXna1t7boOugOZ8kmPA9hpElRs0A==
Date:   Mon, 30 Aug 2021 21:45:48 +0000
Message-ID: <DM6PR04MB708147357F91D5AEB6128A2AE7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210830144253.289542-1-hpa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d6f58db-f709-4d44-8f1e-08d96bff87d7
x-ms-traffictypediagnostic: DM5PR04MB0810:
x-microsoft-antispam-prvs: <DM5PR04MB0810ADC6EAE9ED719C84E6B0E7CB9@DM5PR04MB0810.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BBag8W6reJ12B40W2uhDYciKA9lkIBvnMT+eRqbx7+QEBAoyFPi7k8Qr2iYMHmcahOLFmjgAbtyDCHn8yfDqspQf1OmO3b8gYykKtkImLl8xNRLw1t9tXRd26AY8hwkAi+AZsfJ7HACsv7n+FezGf1ZEfJ7ySjwcJgZCnwmvNFvuQecdY/s6/zTWApsunp/C8IpwmJ3Zm8e9l7b4cyfRzsJTFQA/Or/L0RFOY76qaMu3azdAqhcmUGnyb4uYZbRODvrEl3bqsuvvx1VUJwzJEj66iBIsTJSNuMT+KSNO+iZSxm6JrS2vdNUdSGUp1XHj4HSxkja0Hue2gU6JnmuTrK//M5udZ4ZlPptNzppzdSPJxLM212ySu/pwDiHrKUlTQfsiA+r4yt6/e/EBvym+54pelrRtMoJJlr+poXEd3GvLGweSAaarZ/Fzl8IkT7KYazc7OmjOaZEU/uYDibA+fy02b9urrpolBBXLaC1z9MSKIYMpvIx++aqRTU18U9UlSPqJejALdx1vFuk9goMUF+ML9itbHlIcfT3Bgv8X75xKK+hY0r9Pn4fakUCZJI28a8MbZ4bm+bL6Eh/6ZDFks/AL0+9w2lqp2mis/dGnF/TBgJ9NJiZVnUWn6GaWB3ZLbWoaAez4hLSmJovtQ2cX0C/gNY07Ny3JwHHPmTtla7J4o07uQpHNjDix1gUj+Llj7I3wBwBIcYXD28qCM5JgHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(33656002)(8936002)(66476007)(38070700005)(91956017)(38100700002)(4326008)(7696005)(316002)(2906002)(5660300002)(55016002)(122000001)(54906003)(110136005)(86362001)(9686003)(66946007)(66446008)(83380400001)(186003)(8676002)(52536014)(76116006)(478600001)(71200400001)(53546011)(6506007)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mDqSSxaNSmtMK8JmVYGrdbHxv+ofiovp7xeDH5kgu/ivu/DnmVTG8K2DsJ9k?=
 =?us-ascii?Q?qDq5q44XjiCR2DfxxIoDGKBN4o9ivLr4Pm/L7SUQETl3Pw37NeVcJipC45Ra?=
 =?us-ascii?Q?61aNrneIvxD88NW4Gdv75jmPmkl2960PQvr7Cohy7pcBGHOfid7+84raF7dG?=
 =?us-ascii?Q?G48HpVumHdpK3SNL5QE6uzn9Y2kMsprAWPgh7eZ7wVqxhNpzeHprUWkfpu+8?=
 =?us-ascii?Q?Pkw3HJ1B/vsnScxyBH2UOsGyIVu1FSjoFg6V8sEhQ2G6RDB53nSrIpXGBSgi?=
 =?us-ascii?Q?06qemEKcfxgb9CjlYypA5mqNSo0kJczmQiNH7He7o1XXInz91gblQ+GNJPHt?=
 =?us-ascii?Q?wj4/crrnVPTM8xdekwrP8kKI/pAwCN6TnhoEEBVAcVVy2NeVbKVUN1K7NeRt?=
 =?us-ascii?Q?3e1R1457z1Z2BJuve+vRPZYJzOqrNI2dhbvIp7ieKZMmVYUPc+YlknWkiM62?=
 =?us-ascii?Q?eiKkZf/tYEwWK5SdrBzVfUVkTAN0pPhJvrOeOF6TI37pFUPvCbQa5kU7vfxQ?=
 =?us-ascii?Q?TsURUhGvMyuoT3InfIcfQ4MyKi8u92Us9Vc/C04/zdG1o9XKxOV2AiON26zo?=
 =?us-ascii?Q?4lxxAmxjsIZUki2BNiB6sv4IF0tG11tGlX9LLRPAYxXd15x9/LL7sm3CxSq8?=
 =?us-ascii?Q?iBLOrlTYL9eT8+H1ispMVEP0OvFGUxxjLa4hkI+FmkrGah+VW81QEcIY44SA?=
 =?us-ascii?Q?NWyJvIA2EqI00RhmHnARubB0YEdegloNSumooI8liAdXEfH+dGwcwfluh/EK?=
 =?us-ascii?Q?VDSjTNJXnWJ+6JIbCur6HjEd/l6e/JVC2QlUcwnWcWJbwHJ1TotlqrvkENoB?=
 =?us-ascii?Q?/eYttavxLa+f2oLjLC/aIuqytHLckThPK0YAJYO+Rh6+37ENq48BYnO9e3bz?=
 =?us-ascii?Q?j1FRBQyMsJk6RXqIFwaiCOLsf6qDQPgbrvryCrU51oaunaBpYc+LRFYmnmVM?=
 =?us-ascii?Q?H68N2F3bPjBRu0LR7oLWk3gn7vqNxzVuttj46asOPk90re/QTr+JaVVdPhP3?=
 =?us-ascii?Q?h786JTmhZalYv3ughatszQ/D1nGMbQOSWzEZW9+zJsdToPBjfqCLS7nQh2fH?=
 =?us-ascii?Q?VQCUtEp3gg+2yXt3QJabkYKoj0toUGnpO4CMOOQ6nfjoqzd9aVZbnREbHcxj?=
 =?us-ascii?Q?fwshidNLKlg603L03zM+063egGvTjF4uzyxID6BKaOj+DbKGGx9Y6gQuUt0f?=
 =?us-ascii?Q?BtOSI8OROLbRg5BaQEPK9RNa9VV1pB5QRmPnSuyCjEzor4KILlFy1BRsQBSf?=
 =?us-ascii?Q?ng958x43mBDduJ6xXLhXj1YTH8T4vKv7mMxs5lzfKXWZx5t51Dppp/1bFtSy?=
 =?us-ascii?Q?zg4tZW1BoKdoy5IYiAmyXm1zhcAjF/Wy1S6jyvSfr3JaggFEgnAukPDhmHNO?=
 =?us-ascii?Q?VKMtEX9MGlj0AjujihPZVUoRh3PTf+qYHjnlebfOijnSeqBKsA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6f58db-f709-4d44-8f1e-08d96bff87d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 21:45:48.9240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3n0xVMcRDFYKby9C5fDRTQSURqYO9/Y3vTuxakoqtDwLtdT2syDFHRCfEimgrt85VqgaPc/cFm5LPoGR8rdGZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0810
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/08/30 23:43, Kate Hsuan wrote:=0A=
> Many users reported the issue when running the system with Samsung 860,=
=0A=
> 870 SSD, and AMD chipset. Therefore, completely disabling the NCQ can=0A=
> avoid this issue.=0A=
> =0A=
> Entire disabling NCQ for Samsung 860/870 SSD will cause I/O performance=
=0A=
> drop. In this case, a flag ATA_HORKAGE_NONCQ_ON_AMD is introduced to=0A=
> used to perform an additional check for these SSDs. If it finds its paren=
t=0A=
> ATA controller is AMD, the NCQ will be disabled. Otherwise, the NCQ is ke=
pt=0A=
> to enable.=0A=
=0A=
For a single patch, generally, a cover letter is not needed. Especially so =
in=0A=
this case since your cover letter message is the same as the patch commit m=
essage.=0A=
=0A=
> =0A=
> Changes since v3=0A=
> * Modified the flag from ATA_HORKAGE_NONCQ_ON_ASMEDIA_AMD_MARVELL to=0A=
>   ATA_HORKAGE_NONCQ_ON_AMD.=0A=
> * Modified and fixed the code to completely disable NCQ on AMD controller=
.=0A=
=0A=
Technically, this is a v2 right ? Also, by "completely", did you mean "alwa=
ys" ?=0A=
(see patch comments).=0A=
=0A=
> =0A=
> =0A=
> Kate Hsuan (1):=0A=
>   libata: Add ATA_HORKAGE_NONCQ_ON_AMD for Samsung 860 and 870 SSD.=0A=
> =0A=
>  drivers/ata/libata-core.c | 24 ++++++++++++++++++++++--=0A=
>  include/linux/libata.h    |  1 +=0A=
>  2 files changed, 23 insertions(+), 2 deletions(-)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
