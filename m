Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5BDC432BE
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 08:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D635C6103A
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 08:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243012AbhIAIO4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Sep 2021 04:14:56 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:41740 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243028AbhIAIOy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2021 04:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630484039; x=1662020039;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=u5Lr7o0X5tlK+2+/dYobLehep4fXgRQQJyQZE3kONCY=;
  b=G5mMlC0a0hk/aujN5Fr01oBllMxFp1/nXY3fxZA6LFuGzUA1L0qH1kA2
   gDuZG9TRSIPaS11Fn3OfNwXxbJbX75WUJtP4udzVVIFpGNaRsp7t7duwL
   bklME+sM7Q33ocaCTfpkIKXdbK4QVz90XSyxet/6EHLsU0Hp+tvMUEWh1
   R78A3jF0HYcp+dN3bm5/geO7yyzXyIMTFo7zO3fnhHl5Qh5emlFj8m72c
   myKteh4/jz5b5GV4WVo5lWQF6ph+UMGPul8x+xiwsRw4bYEQvl8LU/J93
   smXtVTOerp1T3h8vI0ABfGGVgocAMPPk/plMjzh91v+rF+DEpCBNuNSMN
   g==;
X-IronPort-AV: E=Sophos;i="5.84,368,1620662400"; 
   d="scan'208";a="179476508"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2021 16:13:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW5iXKi2t/pCmiL5Wh4R4qdobF5jxSYxccNkMLog5nrziyR0YI6OEqMnVniEMeydweXcHRSHOlHGzHc5i56ulU4efNnErtwfsYexUBJg+k0wfz3MD0vXvlVqfy0p0FJNfUJ3+J+uizeUSIyzwY4F684PY43uLvoelK1p8D7qRmLPnqSFqKoyD4FidH+jrjsldswYAgXpOjXKj5JBIkYfhuTfmwMy++phclgT6FB3Zdv4j8w25AQ0MIpQlgBu9jmeqIu2M5/RP+BhCTGs88DjMtFh7In5VOG2wz80W3bLa2uolCH8tYnPaZz4PpxSMvctlbjE8wOcdYJFP7ZjMDpqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5Lr7o0X5tlK+2+/dYobLehep4fXgRQQJyQZE3kONCY=;
 b=SzrxIFfJFvoZ7/vAlubRZNETWN0q6tiT+fIQFJ0ZKgdcYhytggLm3UIPToswxiAE7RukilLabBgHGuYi4RE1LFZaWlNRJl6vfEAKlTaCw2Xprz7J12Zs4lkzI+aW9aNTji1XGxdZp10J8OhtKW6oiRX95BoDAyKOY3UsAAz52ovr8BjNxBmSQLl4QiCSSzJNEN5TKSdWPkWwRqUM8hqNvR9EAQzUo2IgNwTd5pSxJGQYw1iM03GTDZNDYTjBtgCH+vzwGOQGacCdNjEsKlCQVk1BkXc5EdjAOS5JM5ftmcJ+jIbAEW1vF/9KAAERY4PRSVyAS/R0/w8bgiw243qf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5Lr7o0X5tlK+2+/dYobLehep4fXgRQQJyQZE3kONCY=;
 b=BlCuCPAQDgQr6hdtJyX/yPt8mM3v7kYcD2y59NzJjMfD74DgrauAXP+HXIxusZfiyelzFAntl3peuLuBAvKXuyBmwlpq+dwEB8w4JYUb3gIBL0jT0yY5ZQXol1p5rbAuhyKxQ1qKL1zF79GofukdHt8tN86sLD+jTWn16zzieQY=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4828.namprd04.prod.outlook.com (2603:10b6:5:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Wed, 1 Sep
 2021 08:13:54 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 08:13:54 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "torvic9@mailbox.org" <torvic9@mailbox.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@redhat.com" <hpa@redhat.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: Re: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
Thread-Topic: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
Thread-Index: AQHXnwRKp842qzcMQUysR5ppI0c+xQ==
Date:   Wed, 1 Sep 2021 08:13:54 +0000
Message-ID: <DM6PR04MB708115B43C231444AFB22DC2E7CD9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <1876334901.51676.1630481868266@office.mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mailbox.org; dkim=none (message not signed)
 header.d=none;mailbox.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85002eca-8452-4756-f25c-08d96d20708f
x-ms-traffictypediagnostic: DM6PR04MB4828:
x-microsoft-antispam-prvs: <DM6PR04MB4828D3D0E2548847619FEF5EE7CD9@DM6PR04MB4828.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yUgKfyuiemdJHWPKBv6ftjt4Vz5gcTB9y4rrl/siogsPCRVqbIu/q5GO8x2yWJJGDH96xfexG10osfIADlLKx5sDUONQhJaDBL3BjhQ4AadtYK9m6SLFRdZogdv8lzkKhqM+RlZQXwo6jJ0ax1uB0s6oZsXill04z0PkTijySooCge2rAalHOWlzPidfWbJYO+IJELkbx70RsJ7wL/15Jg/mCOYNiP0+FbssUZU5GC4mSpF2FFek5s6PKcwJmCLwqMqDjw+wqhtwzGiSevVo7BMaXJzBw8t8BvNojGfJQIC847uqLtobTV/k6UcLD2qe6XiOb9nBCLmsOJjV6kUBxg9a0/MbglE11XY9sd/usbXDJSnbpY3ZuOjrjPuJmmua1aRAUOx0y6NKatZUnsG1JU8COJ7F5hVUE0b3qi8TPzQGFzTF4yv0cvv2MzuKlzfR9Y+gt3QNV5e/cbgRC3Th/FCRDVO/hz0jTXH8p9eCvNMVesM5isfzgBnpUnaEfl18XVRKjatEckA03x5LWzpKlfvpoz/vLnHFxHIlOk+monZswkHwI6LprTfXFhPew5wbhlZflIdqxVIs1sMT37587OKbhDiI2CrO8YKh1FPFYhWmDoP0vt/aDoKp642BftsVkQLRRFwt+rwLv28xI5a9J5kAydZzrrqWYw0r4j3jcd+AjRc+/LMs2fi48uVoAo1Z7dj0u+qqUzGXQODJcXOMOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(6506007)(52536014)(55016002)(38100700002)(5660300002)(508600001)(83380400001)(54906003)(53546011)(7696005)(4326008)(66556008)(86362001)(38070700005)(316002)(4744005)(110136005)(8676002)(64756008)(76116006)(8936002)(66946007)(66476007)(66446008)(186003)(91956017)(2906002)(33656002)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ViTzXDfZXioDnbCuE4Fkifl2CwlQXs+XlqkPrKeKE2AfMrTlCxCp18ylszqA?=
 =?us-ascii?Q?52yiuK5QuVVjdMGOMFQPW2RXOqt1Ky0VyMMG9zQAT2dmM9A2HL93XbOm81Pv?=
 =?us-ascii?Q?USXpXBURh41QqrTZJaax2UnGrlcXY1vztdMXVoJlhw1k4gQNsb+RVvcy9843?=
 =?us-ascii?Q?tuvGBAhRun7oa9sC6v75qRmXKWLI24+Y7rI077VPjkpRK94nRt19JPFOcBOW?=
 =?us-ascii?Q?f1zp/4MDbLKDYUJ1dFmqbLiK/UEBgfzQKyU4dXwOoKe2uq/mJetT/W8dW7+7?=
 =?us-ascii?Q?nihq7HoU6Gci43B4nkojEb/YUt9lVueGaAMNut/KBe6WhzADCl7mBIgaGsEG?=
 =?us-ascii?Q?LtvhS2pgbJeBQH4WtDWDOv/0s/s/hRlOxywCvXkHT880IIo3k6PAf1zS/YTE?=
 =?us-ascii?Q?P1YTXwgVs+O4QK16WWNIyle9IgUcLrzwuPluRo6Tn8FY89o+ukaW0RID5TLc?=
 =?us-ascii?Q?D3C6sso5KeFCQ4MavFc7I6+FRa+PTpvBId2gniJ8Qo5ivFSOowAxlffobuU3?=
 =?us-ascii?Q?/Lz/hQx2rqeJvCmy/mvlGMu8CDqBgpSh0IxRWaGFt9kDSwwYKTxPQh5+31+d?=
 =?us-ascii?Q?egkBCUM3+cDnGTg2xUqxdLQZrtqvVgBu2271zpRUmJ3iBRmntkigv6shnVj4?=
 =?us-ascii?Q?MCNv3ADFBjwQVToOzU7aOdIm2eqydjDM+VQxSIKRT4otSYfvaUe9obySCkkH?=
 =?us-ascii?Q?YG1FwFjE40VXZ0dk667VuKe7cNNieoIJ2HC4/0TbnW0J1hl2U9W5249IFrbC?=
 =?us-ascii?Q?FutuzizHpxUhT/OP/FCIMhw5LLZqXkTwUI2ia4HGzBoK3cQUWVTbfQmcrHfl?=
 =?us-ascii?Q?+tHQhzKzdcoQt4CKzI4iD3i04wZI5+xMdvxBLk0sXqlZqR+l5/sG0jx1/y56?=
 =?us-ascii?Q?jjWWOHI9xephTbEbhIK36xuq/TrfNiyVQq7UZU5thsLqy/8l8Cl+QrlwLoUK?=
 =?us-ascii?Q?MIn8nI1Y7juYMlQGDYmUZDMG+VEEBc6Nfjo+U3IcOT+S0o50Ui5TiUrCRvJP?=
 =?us-ascii?Q?hhn/PxbQ/ixzhKMPs+dwnuVAmCG27jQ+lf3o9AaApDtOD6erWu25LBs8JoFE?=
 =?us-ascii?Q?lkERYHjSzb7ikJCF2JJwlltk7id/JaTeIzx4g37A3SwYEnVHhLFN4N59AiSg?=
 =?us-ascii?Q?Kclor4qR3Hut1SEnTrP9DsDb3CtJA0EcB7Kaek3CSc5G0BNDgxoupxdi8mn3?=
 =?us-ascii?Q?l9JUGL4ELIS4DZw0rjjEjsCML3ONVV+mhQVOr8dRTSNQfO9CJNT311yR0KBu?=
 =?us-ascii?Q?AVKiaRNrTGAHXj8fmXSyYXCRUnnCAT6OGWGlNjEtZKKj0uS2hdkUEjkEOHFK?=
 =?us-ascii?Q?IF1uiJaaBRo7FwySD+TsmQxxLzNYMwHP+7Q5ULVr8CLPOmd6zzXTIzZvEADJ?=
 =?us-ascii?Q?olU9gArv+AgduRidto1W9MckNPPvVXUih0EXzwNHrx8hqXFH2A=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85002eca-8452-4756-f25c-08d96d20708f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 08:13:54.2965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: httnI6zUL0qDwDt5xa4ckleu1XI0dfpu1eYE36qY5OZ7+wl1uYGWeIajWzHuzGwrJjnLYC6q+LapZ+/NxnGG4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4828
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/09/01 16:38, torvic9@mailbox.org wrote:=0A=
> (Sorry for not doing a proper reply)=0A=
> =0A=
> Hello,=0A=
> Noob here.=0A=
> I have a Samsung 860 Pro connected to a AMD X570 chipset mainboard and=0A=
> it just works flawlessly on 5.13 and 5.14.=0A=
> Are you sure that *every* 860/870 is concerned by this problem on=0A=
> *every* AMD controller? Isn't this too restrictive?=0A=
> Or am I simply missing something?=0A=
=0A=
Is you drive being initialized with NCQ enabled ?=0A=
=0A=
cat /sys/block/sdX/device/queue_depth ?=0A=
=0A=
> =0A=
> Thanks,=0A=
> Tor=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
