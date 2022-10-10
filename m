Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA63C433FE
	for <linux-ide@archiver.kernel.org>; Mon, 10 Oct 2022 10:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiJJKSu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Oct 2022 06:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiJJKSU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Oct 2022 06:18:20 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA356AE84
        for <linux-ide@vger.kernel.org>; Mon, 10 Oct 2022 03:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665397077; x=1696933077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bSM7q2eacYvvnvLhZug0uI1pLgW+evq8qzB2+euj9Ic=;
  b=mZmH2uN3Py3AGbBhZwudTek12NMuqs4wR5F6cCF1BILi4VtBLEcFZVhn
   p62yVeK+sXGFyvn55AFXBCDfyhNYnPmjk8PBzHrBSyTYZmriUMQz9IkwP
   rtp3OroOdodlIVBo8zqt1p2wjnEJHoJqR5zNLNKrWrkFCfYvNlBt+aOM9
   +jdQz+E+Pf2DlKQ7aYOIj6hV46i9jIq729NLcrnvuS6l+SeNkl0U6G7Ya
   2XGwoeXnNWPD29Zql2KXM9zd1UguFTLy7Q/ad4GZUPH1KzrOB5gPb3JcR
   /1Xnz7x3Rw0SRzXRG3jJFCDqGIdPp+iXgk0eEICKYgwqhYzujk/IOmJHj
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,173,1661788800"; 
   d="scan'208";a="218573453"
Received: from mail-bn8nam04lp2049.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.49])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2022 18:17:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu6QlMlD4vWlavrvkq9PYSEmFrJYD5f/NKG75pAHtSlCmZamStKupp41YqvaYwQZYopC5PqfVmkNK2xzlY1blt4lW2WqmH2N0NTG5iwvdDFSLpUA1TESN/4ayaPm/0m3uWrWlsfJx5eJjucFIL79MMFz+ihkVt+TTnpnrJPAVBDR0GVhJZi82B+J5JloEfX8mXVXZUYSuhgLBmfzUzh5LG8Fql++WnG/ew+WZ3Wq7vhyruYYmewQilkOpfMISkDD4DMxUr1bYREmYEKFTZDaZOVVGfxQdVS3cr3HDL16fJzB5gUDIeGxifo5s8u5GnOnurSOoR7XAsz05MdWs3330A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1h0/WWWvXqLFU8gHBZiPW5QD5GjVkScdx32Z6ufEjc=;
 b=hKfqP+OKOpWRxAgh7v7TcZLzUBY3HUoBHy3zwygYfc/3GlaD44f8qeGaI1XXVGkQX1fBQs2Ilj0VhzU11TcoHpOa79Z5z4yU9yxr7oZyWYrZhyU+jvIUnvp7PyoNsAhbFACXI15cSDWEnE4ie8qWjG7f9EuUL0uAniXAG0JZyrDLYR/snHBCj8axl00NLq5VGcUtLWDo7JS4b16V1oKDqJd5g8TSEuf/imukL7maMFkFsB+SYmYqNmUHv60I7rO7VjKT9qSty/bzI9G94ZlkUNZmxOfLE863IYkvsoOunDoxz8PM6FRpiiLDQ2K6TNgD9VGhPDZQcs/Rw3P1JcWKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1h0/WWWvXqLFU8gHBZiPW5QD5GjVkScdx32Z6ufEjc=;
 b=mLMs8fVmJhQpx1m55+QH8c8NpBAwcSDgnx0Wh0mq/XudV43Xz5OKjRtPR2fkNebBp1fryo/CSrKRXhjmQxquG0GIo+uTroHP/4NkwPO8j1a/5E6k+5ItwX5CLq3X031WHpy+nmMxj4mntK9wxQ0r+sPK+MdSMsvyWzn66iIJUaA=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BL3PR04MB8058.namprd04.prod.outlook.com (2603:10b6:208:349::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Mon, 10 Oct
 2022 10:17:49 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425%6]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 10:17:48 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     John Garry <john.garry@huawei.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 1/4] ata: add ata_port_is_frozen() helper
Thread-Topic: [PATCH 1/4] ata: add ata_port_is_frozen() helper
Thread-Index: AQHY2lAN7TOJWKmibkaCkDNcMNOo5K4HNz6AgAA3OIA=
Date:   Mon, 10 Oct 2022 10:17:48 +0000
Message-ID: <Y0PxS6OGiipR3OqO@x1-carbon>
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
 <20221007132342.1590367-2-niklas.cassel@wdc.com>
 <2d3253f5-c14a-67b2-0ce3-68ba1e332664@huawei.com>
In-Reply-To: <2d3253f5-c14a-67b2-0ce3-68ba1e332664@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BL3PR04MB8058:EE_
x-ms-office365-filtering-correlation-id: fd8d81d2-22c3-45f7-25c8-08daaaa8ae93
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vZH1Iskk5/6e7PiFUmeep+2jDNLta5mI7BHO39SSdKX3pHTsDoNxo3m8uVPeStJZ8J19MFAiyiiKhk1Sy3oquYK1H2xAFaaaTnovyzWoSui58VK1K+NfZiPl5akyaHlg+ddRp4Q2zpQ/9XrlKLe0CsMHcFiYYWXIcg1zL8i1qI1R2aFdHMJM2cwXOHGamn3VL7vXEp88LiSrVjz9FbTTeZXDvLZ0oTlDgYl6u5teUbjApIQarLXe8oZA8o7o894zdEgCLkxlmzJPKhUUw6KNglYI6/0mg9DZNqkKpLHpD1Vy9itcoRRJasUgMikFpKRcI7vIlJ8ib5rEv25rgNpi6bPXhDZctN43wxtUjSXdyOU5f3JphlCprhevPoNHdqHGsEEcaQC4wz7iUmgxtBKMnBXKlqznhzySJxuA7k8sNQafqQoc/50+SoAKx3kPxuS3gSs36u6rWM7VuTbmXeTW1lcMU18ei2r5ikMykiVoRtqUfeg8ZMbnLnoNXjuK8hGMNUhstQFG9GAJUror2R++C5k99zq7v5OARI5G3YVmSID7cWE8NvzPe+iqvq8hmhEyOIGkdJo8/KR7cdUW/WZxIbbVzQb37J443wTobToYfcOLrmJj6zycRHzRQ8UY8q71l3y/NMjX0eAdGnMW8qgCeAEvtTSEqL+FzkRFT+LDqo4gH0HAbE1Ow26Owpr9nAphVmmKpG907Ng6uMK0DMx78CFrreqlBna/wcrtGf4YjPnniMv0nXO+CnncBRwB7T6JaMukNYNHlbNuS2aKuhtIf+yBjfafRaI6Wc35mDjUBqw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(86362001)(5660300002)(2906002)(478600001)(71200400001)(6506007)(966005)(6486002)(122000001)(8936002)(53546011)(38070700005)(54906003)(6916009)(316002)(66946007)(91956017)(33716001)(82960400001)(38100700002)(41300700001)(66556008)(66476007)(66446008)(8676002)(4326008)(64756008)(76116006)(83380400001)(26005)(186003)(9686003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4HU4vNIiRtVdAfMQSZKuD5kJexkbeEM9EwRBCUYtjyBH75W5vcro9RU4GRhM?=
 =?us-ascii?Q?Ynju+4l8+lgvgBQeqlqRV/2kCTaU1GEhc6nzcgo3kPJaUKojTkd8+N+cq+R5?=
 =?us-ascii?Q?6qNFrTD6xS1lGDspGX9pseBfFTN1fJSuvcRqEHK0bOo/317RPXqTAAqzbr/W?=
 =?us-ascii?Q?hKgiTsKo3G9xTJr1neLFaCZpyPjJ13cps71C4Zb5gkyuydWG2VR5Wlbr4TJ2?=
 =?us-ascii?Q?5q/Hv2iMGAwUflLnFXI0niDFgDtF6PSrFKKQNlBa8J7rR9PYV9FRcvoEpNfA?=
 =?us-ascii?Q?A5m1pwN7I019FrqQSVth8z0pgoTQIZGgzbxzVP7jWCXEPoydctDHHWATw5Ko?=
 =?us-ascii?Q?FTrR1YA/aXkjnyxD0GO4/qdIptnoijUnMAxdIn6OszZjT6BmoPwLvl0phLzZ?=
 =?us-ascii?Q?yiXEr/YNC8K+rJScG2FN4cos1/dRZKypZQNdQySVhXM8iXg9aLtwYOEtRukU?=
 =?us-ascii?Q?9sNbxyMmfamCLEqIHYpDEUjKFt20RasiFxLpfkqjppCLD0KlhIEgBIPh6kKG?=
 =?us-ascii?Q?Md+TIhldQG/vSAmE8eDqRfzbto6cqCuAbpdQhFpQixAJI03R0YP/mExZK+JX?=
 =?us-ascii?Q?po22Axv/Lhf6AurQbWTAa0hHPJ1vnBTOTeoGizFwrJ8i2eEO+T6A2BMDXoUV?=
 =?us-ascii?Q?u/UEXxJ4lNm2NClpZEPu2jOD2nbtYBHjCYPW0j4Ubjiy4naosMc97IL/aa6B?=
 =?us-ascii?Q?oKb0Ur1AXwyntXLwEO58oVENzKHonPjJCEw8J2xSShc23B6zqqbLr41zXPlo?=
 =?us-ascii?Q?TFSpvmi5IaRDi6Zhhm0EN7TeOTgRctyC4mAEgIX8/UoZsgm25CWGH22H/D5F?=
 =?us-ascii?Q?z6Etwb0Soq2kXKR2zt1PxFYhjOV2L68ymlkHgY7yY1R+ORTICs7j/edOkDHv?=
 =?us-ascii?Q?CFpvzPymtfzDcQHLDXUdkrEQauFItn33AwvMqmGyIqEYWN1R7aP0gm5I/Pr7?=
 =?us-ascii?Q?JmpwOzY3kxzm2ER2xOR8N0Ns6eCmjsILQpiUwtgYgu2xKsc4DkVNWBOb0EsJ?=
 =?us-ascii?Q?qYJ5RoLKElaY19KN6iXW7iarlih3dfaRHCxqF3niNij+3BbGlhY9h0C6KVjA?=
 =?us-ascii?Q?YqCwpDr+F1ekxQxgvY09XzBGyvNZV6wEuLSCrvJkoOPagu/7EtUxHxlihExd?=
 =?us-ascii?Q?Ylv2XxuggEYZWqRhCGNuwHOZliKif2DuAQH7IfYrC2aaTkb0DAZeH3siunS3?=
 =?us-ascii?Q?KEZfbyxXIRNq14KhBfPElfGEUdgl6f+tBsySve//44BAJyqpo7ArjqZs5QD4?=
 =?us-ascii?Q?F1b8TuJsOdMGIqEyR/yyfqQ5oijpvP0dCKPQjBW8W3W1XB9aA6eWAns+ajLu?=
 =?us-ascii?Q?4M1sUsm96sYhm5euyRqyXinSdvQeeUhZ4K2hXqNKijwouDeUQG0H8oH9YOEu?=
 =?us-ascii?Q?sZHXdzCNg36stZOg5RLjBwa07V6OFzGoCrVmkGH9jBMoBnJIVcsLOASQ7H3W?=
 =?us-ascii?Q?zOPsekNNHd8b8C806nwAch0whN5ESUwWGVjDDfpCDctfxZzvmhnfLxH5igJK?=
 =?us-ascii?Q?u+V3R6o9c5N22yHWGbKDNktvYF1irdiUuPOdeyS2YbBhpbEGCg3gXX8Z6xL0?=
 =?us-ascii?Q?EssGcQPXQWmTtj21rWroxY2PErjhfmwx5WVnkKVJ53NGdpA9EZV55bfxiZXV?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FA69CFED18212D4F9983B1A14E729C4C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8d81d2-22c3-45f7-25c8-08daaaa8ae93
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 10:17:48.5984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+E6ev0+oGeqmR51DjVTgwshCcZP+s1nrZ+Eel1Nxwt4fChJBSYO6r1CkQRwzDFAU4ba983lyjLG+xXj5m+daA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8058
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Oct 10, 2022 at 08:00:09AM +0100, John Garry wrote:
> On 07/10/2022 14:23, Niklas Cassel wrote:
> > At the request of the libata maintainer, introduce a ata_port_is_frozen=
()
> > helper function.
> >=20
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> >   include/linux/libata.h | 5 +++++
> >   1 file changed, 5 insertions(+)
> >=20
> > diff --git a/include/linux/libata.h b/include/linux/libata.h
> > index a505cfb92ab3..d5ac52654b42 100644
> > --- a/include/linux/libata.h
> > +++ b/include/linux/libata.h
> > @@ -1043,6 +1043,11 @@ static inline int ata_port_is_dummy(struct ata_p=
ort *ap)
> >   	return ap->ops =3D=3D &ata_dummy_port_ops;
> >   }
>=20
> Hi Niklas,

Hello John,

>=20
> >
> > +static inline bool ata_port_is_frozen(const struct ata_port *ap)
>=20
> The majority of libata APIs don't use const in this way, so I think that
> consistency is better.

Well, right now there is no consistency :)

$ git grep "static inline" include/linux/libata.h | grep "(const struct"
include/linux/libata.h:static inline bool ata_port_is_frozen(const struct a=
ta_port *ap)
include/linux/libata.h:static inline int ata_acpi_stm(const struct ata_port=
 *ap,
include/linux/libata.h:static inline int ata_acpi_gtm(const struct ata_port=
 *ap,
include/linux/libata.h:static inline bool ata_is_host_link(const struct ata=
_link *link)
include/linux/libata.h:static inline bool ata_is_host_link(const struct ata=
_link *link)
include/linux/libata.h:static inline unsigned int ata_dev_enabled(const str=
uct ata_device *dev)
include/linux/libata.h:static inline unsigned int ata_dev_disabled(const st=
ruct ata_device *dev)
include/linux/libata.h:static inline unsigned int ata_dev_absent(const stru=
ct ata_device *dev)
include/linux/libata.h:static inline int ata_link_max_devices(const struct =
ata_link *link)
include/linux/libata.h:static inline int ata_try_flush_cache(const struct a=
ta_device *dev)

There are 10 uses (9 without my addition) that uses a const struct pointer.

So since both are used in libata, I chose the one that seemed most correct.

>=20
> Indeed, this is not const data which you're pointing at, so maybe it's
> better to be honest with the compiler. And since this is inlined, could t=
he
> compiler optimise out multiple reads on ap->flags in a caller function si=
nce
> we tell it it's const?

"This is not const data which you're pointing at"

Well, according to 6.7.6.1 Pointer declarators in
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3054.pdf

A "const struct *ptr" means that the contents of any object pointed to
cannot be modified through that pointer.


"And since this is inlined, could the compiler optimise out multiple reads
on ap->flags in a caller function since we tell it it's const?"

I'm far from a compiler expert, but because an optimising compiler is free
to inline whatever function it wants, not just functions marked inline,
I would assume that the compiler would "do the right thing" regardless if
a function is marked as inline or not.

Doing a:
git grep "static inline" include/ | grep "(const struct" | wc -l
2055

Makes me quite confident that this should be fine.
Sure, the data it points to might never change.

But seeing e.g.:
$ git grep "static inline" include/ | grep "empty(const struct"

Especially used in tcp and qdisc makes me even more confident that this
will work fine.

Looking at e.g. __dev_xmit_skb():
https://elixir.bootlin.com/linux/v6.0/source/net/core/dev.c#L3803
we can see that it uses nolock_qdisc_is_empty() multiple times within
the same function. So now I'm very confident that this will be fine :)


Kind regards,
Niklas=
