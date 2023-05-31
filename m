Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A818C77B7A
	for <linux-ide@archiver.kernel.org>; Wed, 31 May 2023 16:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjEaQJZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 May 2023 12:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEaQJY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 May 2023 12:09:24 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004FB3
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2023 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685549363; x=1717085363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VI3zAdTyBx2YPaleThvhJLxrT+CIlh2r719sag8iFvI=;
  b=T16pvljwx0FDGq1Ao5kvQG1q9bRwn+GAQUfSr12vLpsLkHrGxC6tOFjQ
   HkfesKkzffM8OdsRYUVDREtagerhaRv/1f5aDJlwlStclyAL5jjgYsQGS
   /Bx5NFTw+qtMlFbM6IUUqHzwznJX7XmUp0SMqLuYdQNL7hb6RXIpTlHos
   WdSZ92xLddfX1cCRzeUhcDjz/YTy3LN1/zZ4dI5klATVrFlk95/hTRiLM
   LRTA48rGrnlFP4Snwjautoj4xFl3PtDY0iYPBQZqGjpvtGLK79ewn20mp
   xlpamdBhzL/MJjGS4WP5uQfDHTgUlaiuQOrH84qJc9G/YhKbl0rZZkwj4
   g==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="232006128"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2023 00:09:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHlbsUaOyjE/vHAuzYUPfp97xV6aCCO0FIx4G4V2Q+EOQ1u9zRrkIdwg8Z6lpJp2eacfR/AAzjLx8jKJJVdbJepd7o1EmFy6061gvU1r8BMMClGj41vvGjwM+BZY3wZRGPjTIuy4CPI6H0gn0VGISKT8HyBXOcfexgmD2lcxWMrAxlAtEm/yFjZ4gtmU20NzAUS2LCevd6bZ1l8biLd+LPWGaghTYoPB9+WfcpIYHC9ZL2DnfJX9YuZJ4GcAkwC5PgEhNrzrOX9d3Uqo6rDP2goqCV6t/V/1r5KlnhLlpxZH5cRNxxF3WOT+5iVg5KJFjs7REH6sltLybYsC+2+rvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nK/xzrnCSOozdRYPrsK03GxqPKPjZVJAB/9PmTNr0js=;
 b=XvFTxAO63o03IujTaFXPLlCcg5VStqyWw3sPV0WEv9mOa2n0GhNo9dgBAK6ZUx8iU7Lfmjszi3pTnPCjijo+WSbUKIC1LONoj8NNmaZ0xO+xn+lDrlLVwiEberd4PbiWi9+AFeSnghog7M276CDK7U9DnM1SdhogEbk+KcLrAqN2LKJj8vxjfsZzScQYhN9wcfF0iZcUXnZEOMpEbqiEJcNqV7DXxv4EDjuHTNrF5rwprH/4NpuPBvD3a7xJcE2Nb0muRAC3Veqoc9Q68X4i3bZ4QYqYFIrbXnEYmBRYaqza04o0td/iIq0pDEJGzi/RFqsBH5Nik7Wt7zas7hNz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK/xzrnCSOozdRYPrsK03GxqPKPjZVJAB/9PmTNr0js=;
 b=F9rFevL3DyJSlOYmTuvEsx0PiPqjg2Etih/9hM8yHr7Hof4ghSwkrVLmxbS+vaaIewJIkfUYEcYq50+LCF1YAceSd0nYOlOlyIe6Wuw3t6S6gChmwl10BfpN1ioY7q8UTBY+eJbHV2WaYm/5dvASySYHHd71nvHusFcpoaU7Z3g=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BL3PR04MB8059.namprd04.prod.outlook.com (2603:10b6:208:34a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 16:09:20 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 16:09:19 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ata: libata-eh: Clarify ata_eh_qc_retry() behavior at
 call site
Thread-Topic: [PATCH] ata: libata-eh: Clarify ata_eh_qc_retry() behavior at
 call site
Thread-Index: AQHZij5gDaZKJqIQV0q988c1lm+Whq9leb0AgA8mRwA=
Date:   Wed, 31 May 2023 16:09:19 +0000
Message-ID: <ZHdxLmDUHKcF1O3k@x1-carbon>
References: <20230519104003.37843-1-nks@flawful.org>
 <9cec80a5-9846-d1a4-9a9a-27ed9b510445@kernel.org>
In-Reply-To: <9cec80a5-9846-d1a4-9a9a-27ed9b510445@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BL3PR04MB8059:EE_
x-ms-office365-filtering-correlation-id: 9e63fc5a-fa25-4fb2-a06b-08db61f16421
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bk1HFl0WxvaQ2RrDA9GC8iwzUro1fGQ/ZVotf/rT5yGMsVmalemtNs7Y3lT+WGLk0UAbBU4MH+lvFUGALSI3423cfo7jJYZE+g76I6oPgx1qfyBmztcvj4pKaHCsXU+xVFpF5+PtLwbyZJwybiKEGAwGkSbmbzdngAzJd2DwFbLHtHEtMLiVD/G6Cp/NigIliZn+NC2fXcFZ2glytaaYaUTMrQBfqUB3ySDST8InICrRH/nTijwYD0xDNaOGJo4yNvikd2yDhmoaktT2bDZOyw6WfO0CraI94JLZGx98X0c3Q0tJQn9Acl44QpvG1VTaM1Im0Ac/4N9415UI+0fO1QaOLeIBEBEMsK8lrGtDSssq6+RPqN8wvKkbLXiHjomZ4E93ATHqA02HpSvTAbYmZ6SGfeEargtN9XEQZEuarujvvy1bjt++2HibfgBqjI8jR+5IluqliINeitL6VxmwCyx5giGhpv7qm632Z1xQTTK4zyAbsgF/yEoIznkywbclWtfIwFU47qUZ2YT1bH66E+gwAyQSyH4puiEEq6a2bmaXE/htrS2ePLdw7bH9jblJt+ZMvxkxnMbWjnkNyIc5NCondy7EwkBnIEbK4rrG/eW/cG1ZCXuZRf29OEs/AUeJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(6486002)(71200400001)(38100700002)(38070700005)(86362001)(82960400001)(122000001)(33716001)(9686003)(53546011)(6506007)(6512007)(26005)(186003)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(6916009)(91956017)(2906002)(4326008)(8676002)(8936002)(316002)(5660300002)(41300700001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SWHERmoeRk8d/FjT0F3b4TgH2II+nPmMruOPRX0Sc/Zlm8d4fkC0zaHNLHLA?=
 =?us-ascii?Q?9CRMOxH/Bz3KenxCyZYFOceGNaUtMXNlGj7BYByAJA+OHuEMZLOyY9koH8+f?=
 =?us-ascii?Q?vG6v7D3kb88Ouri8cF8NXBPVxrZhlne3mlXu4gfBJYeNLz+3SQsJsOj45YxW?=
 =?us-ascii?Q?QVuh8fEVUtFA9PVe2KyCJA8m+fWJCyeOPtSTRIbtPK8x7IqEcUA1agw7DcAS?=
 =?us-ascii?Q?u40SWDJBNZIRzhSUd9aFwfYXbC1ooTXA9VMgYLEshmvWNYzyOcYkmXh0Akjo?=
 =?us-ascii?Q?Znh1rRbiJJshQeR2tY6LRf5UMGnU3CS5yMq8YfLcOiMCzftmmGv6OoaHeHIL?=
 =?us-ascii?Q?2VH9IYIUEz2dRMdsakZLxiWJfmCCscthiqBeEHyoP0oujYVJuCswM5BS88Tr?=
 =?us-ascii?Q?12HlH+E8AD9QZ/ViNcOgdoMKce1kfgSrwnmHVJ/BZQ+EQGzkwqxwL4DY4lQ9?=
 =?us-ascii?Q?Q0qZb3BRSzfIaEU+2OYuXGYdiEk99NBtMrFNtG6TNFg8kXH3l16lERj1gRPg?=
 =?us-ascii?Q?j4frODazDXlG0si8EoYbGK4U/083ny61dXGJmEboptrzyDrht6Xek7mgaVxR?=
 =?us-ascii?Q?iSXpdcegZ39juU1vnDv9ilvvCCmybdBpIz5r3nntiMrtkKzxtxrwgW0SnIYR?=
 =?us-ascii?Q?i6O5ZCYp85QyOO4jh9Sktt0cxmXuP0XiskNYBRsCoeZxmAhw4lXUdn25ah0k?=
 =?us-ascii?Q?hqKqKUTXWmz5UEThLLnG7YQYpztMp5eey3bbRJj5N56SzaOLV8r4sPH5QLZ6?=
 =?us-ascii?Q?X24h0/1qVcRYvf9LVKHx3N09Eenyd0vUJT/tEUreYlx+DaPaC9aIOqPW52t3?=
 =?us-ascii?Q?ZBRf+8MJdJSPnkWjw4l6DG1ZYrh0LDfY90DtKjbtHS6GXTHqGYEQck2zRkmf?=
 =?us-ascii?Q?0yEHDYEItJUizE155lwc+X6IT5NGLHcpBuvphQEcXSHY/e0qmgUYVSh0mCBY?=
 =?us-ascii?Q?417SpSG78rMUnVFJwGpEkj+7V6mxwxruWevPcyAZcYp4EaJiybxHRp0n78tY?=
 =?us-ascii?Q?klqbgRJwU+PSMuFp/V+JTV7240dI/xdsdxVC2TAEZjEbLKME/g/5niEW8d90?=
 =?us-ascii?Q?1m+6IoSgWfL3Zt8+zdgvUgZjJLwydwvW31KNn+eSiED5EuwHiqMZzOUa6mdF?=
 =?us-ascii?Q?iIdkmbgizswDoG+z8YvG3tyzxIF4ovmDcSkjST3cKBZo2Dt0Deak2XABh216?=
 =?us-ascii?Q?elx5RY7TlbbxqdWyWqRMoIpEdz9ImrrVzZrXuCjeXzN46nn831AQ4YSjKXq2?=
 =?us-ascii?Q?/VmrlSjzqbZVwbzC1TUvL3e4uCpG/Do64K96kvQShwRuC1YKCLwvU2Ou3LI9?=
 =?us-ascii?Q?/2hbGbO6IJjQW6OObAG5yEyRCSqmvHCTjpbIs/xBfRXG3iqsMhiWBFO36Ksq?=
 =?us-ascii?Q?11EEi2VR8+dPvpF1FLqHlUX/qPqJl89z66/mqYomBJqeY+AnLBYvyujfJaPB?=
 =?us-ascii?Q?KpAORLmV3LOFMhh8/O/8cB8SlU5SSDwj/fSQYDz6UmGzVc4wNQSsl4G1KLGa?=
 =?us-ascii?Q?f4JAGQ8LUZ4oFMxCtcZIJdttJ2blwl/iED2W1AawEo2yf1HWJVXXoxlFBgin?=
 =?us-ascii?Q?NNkwFnh+3xQGhcp98CHwqU25v66SFAztxzD5lROiP+CBZb1N0VOSFZ11W3bO?=
 =?us-ascii?Q?Cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C98558021576FC489229F33861A9E81D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xd0Q3A3ZyzWd9f6aM7wxL1lQVt/Awx23FQczsoYWgseVGY8Ygbp3b8tZmNxrPT8fJyn7xokaGsTjyu72yZu/QUsh/qtgDD4kIfeYaJScLKb4BP5YoOkbtCfFYD51MDkDjnNm6L6FZ5AoymW7DMB4d6s1h8kEJdXLfWM0tl1lGM0FT8aMReUclrX3NLgG9EGBnRTlElrTe1Kooe2/hJWfRuwh/TwqqwzZ5FuVGSjol13ROKnlr2KfRKBR8EXaN4A+lNXpYTT7fvWO/6PCfQrJz4hrFQ9GS1AVPeLSM8s2pwNEF4XxQmhIcEuK7XL/F58LyLYj/IkZbziE5fLwVSPfAJcAvGzLp6M2OpvVXZYEJC9pGcXQ5HxUH28j+nMOh97bWG62ZUOnIVYw8WqB6qeJeDJHQjfwKvSTZ7uc9o1Ve+npFiZL10sL+hsmPkoeG1Sr8iQ80D+wBtS/LMCHTtiChsEiZf4gsA2YhdPzO7htQ7lyu21XUMuc+LsmnWEQl9sXzog2oY4UIP1fpu2MUIJuH3veM6++YePCuEZEn3XvgNeRvw3o5VsJ00jB1kwB1D7Sil0t2YDmWlW9mcPO9pQfMzf6ErEvdTr0Gu8nvm+wG3kgxP/hnlEAnAN4EY4SrM9E2cnX8977HjZSEf5touiBX8qq5/r3x7dSUVJOtNWaJgeyEFt8CbMQJmuGdKUfCfeoLvBwQNLm37ES5roZjvyEBHAAh1/KMIfR188rASyUgJOab49y4WATlC7TJWp1I58KtkxRlOdmuC+giw0ChAB8GnHHyHJe1vhaC5svQKx/Urj6DBeEzl3ghjKnaBXE10m1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e63fc5a-fa25-4fb2-a06b-08db61f16421
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 16:09:19.7403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wedzKJEOkFZpYFV2Cc4oM23ApvJ25UcBppT9gMk2s8QXzyG9MuLgs1tZqrWortWHXieiCWqnk6wx4Qbyatcaog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8059
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, May 22, 2023 at 09:48:24AM +0900, Damien Le Moal wrote:
> On 5/19/23 19:40, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > While the function documentation for ata_eh_qc_retry() is clear,
> > from simply reading the single function that calls ata_eh_qc_retry(),
> > it is not clear that ata_eh_qc_retry() might not retry the command.
> >=20
> > Add a comment in the single function that calls ata_eh_qc_retry() to
> > clarify the behavior.
>=20
> Looks good. But may be resend this rebased on top of Hannes v2 of the err=
or
> handler cleanup once he sends it ?

Still no v2 from Hannes yet, and considering that Hannes' series does not
touch this function (ata_eh_finish()) at all, perhaps this can be queued?


Kind regards,
Niklas

>=20
> >=20
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> >  drivers/ata/libata-eh.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> > index a6c901811802..170326dc1073 100644
> > --- a/drivers/ata/libata-eh.c
> > +++ b/drivers/ata/libata-eh.c
> > @@ -3814,6 +3814,12 @@ void ata_eh_finish(struct ata_port *ap)
> >  			 * considering both err_mask and tf.
> >  			 */
> >  			if (qc->flags & ATA_QCFLAG_RETRY)
> > +				/*
> > +				 * Since qc->err_mask is set, ata_eh_qc_retry()
> > +				 * will not increment scmd->allowed, so upper
> > +				 * layer will only retry the command if it has
> > +				 * not already been retried too many times.
> > +				 */
> >  				ata_eh_qc_retry(qc);
> >  			else
> >  				ata_eh_qc_complete(qc);
> > @@ -3823,6 +3829,12 @@ void ata_eh_finish(struct ata_port *ap)
> >  			} else {
> >  				/* feed zero TF to sense generation */
> >  				memset(&qc->result_tf, 0, sizeof(qc->result_tf));
> > +				/*
> > +				 * Since qc->err_mask is not set,
> > +				 * ata_eh_qc_retry() will increment
> > +				 * scmd->allowed, so upper layer is guaranteed
> > +				 * to retry the command.
> > +				 */
> >  				ata_eh_qc_retry(qc);
> >  			}
> >  		}
>=20
> --=20
> Damien Le Moal
> Western Digital Research
> =
