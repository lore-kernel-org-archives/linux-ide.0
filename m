Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401C8C2D0A3
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7CC2083B
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="Ass338dJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbgKIRZ6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:25:58 -0500
Received: from mail-eopbgr70115.outbound.protection.outlook.com ([40.107.7.115]:3407
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731754AbgKIRZ5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 9 Nov 2020 12:25:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF5uJvDAukgc+GU/6IKoXtua3TS3IRLZvEVxpLhOkaxnUHVMxhXTH4gsNxgWiCVrmCHC6BCg5/uIVNXV47MZ8XtMo4FiCh1FYXGPT2ftAGTMhDnndGToqmHAEonU0BF0fmbWGEWwiQUB9g/X6G3t74Tpz4ej8l2pWZ4hsAWKvBgdj8iHiNnrUJSzZtSWjSrPmSpMJqSLsYuHaYskg3PLI0Mbs0ie/TNx3V85opnIFMmKuFKSWV2i5nfbbIBA0luwpxe0weXrPaVLC271yZ4cMOxY/rfv08MOkSxrme1NFuxvU+DeUhD2v3X9JTkOBmZ5t5aSNooeNDm5lEvvsiQPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuZRyLvEJ2YA0fcwaxu02Q+kf+QkSqm3KgBTwEC76DQ=;
 b=BApRleLMj8uOeM4ncVkKFqtxl0AzOgMRWOt+9xgXn5RehJvXcUWfxz56GijrtrqdXJEgwjvg7LubOErVo+kkaO/a66Me4MpN3olpC17DcFCqVEMB/7/90jJ21WSKKDw3TGE4sTzFoI+Iig+4gUeZf4XAuQZp5y9LDDwHBZbIO1weEOHUz7SDdTc+ukpMkGdqz+1E4oMuJax20/ES8ZvsZHi3sm9LHsYzL4YDJqTJoQqO+IpHc7zytXfHkYJmfla4JMV5c7ywP934ByyCHUSY/PhKw158h+y7l10q7a//a5Uu9MDTHjMZWjBcF12PguiLQOzINtbpo0sCiD5zyezMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuZRyLvEJ2YA0fcwaxu02Q+kf+QkSqm3KgBTwEC76DQ=;
 b=Ass338dJM1xJNul8iH5ZMB6eA94t9hpQ0YFPMAONNdT8sLn2typdO0a0Y6k2ZAkwlSgJDiNNsU2J1QS/PpqWFnDfjOUxgxOiEsdqURJIq/+GqxmoxdKo0KTt01GFTl+IzlDUkN6mjM6EFP2GaMavv/bGWnfd2CrkV03j8Rvj2Go=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5363.eurprd05.prod.outlook.com (2603:10a6:208:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 9 Nov
 2020 17:25:51 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 17:25:51 +0000
Date:   Mon, 9 Nov 2020 18:25:49 +0100
From:   Sven Auhagen <sven.auhagen@voleatech.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     axboe@kernel.dk, robh+dt@kernel.org, tglx@linutronix.de,
        maz@kernel.org, gregory.clement@bootlin.com,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH v2 3/9] ata: ahci: custom irq init for host init
Message-ID: <20201109172549.fetoe2jbqlw5itab@svensmacbookair.sven.lan>
References: <20201104155237.77772-1-sven.auhagen@voleatech.de>
 <20201104155237.77772-4-sven.auhagen@voleatech.de>
 <db4c68b0-d5c3-c410-052a-99a9decef552@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db4c68b0-d5c3-c410-052a-99a9decef552@redhat.com>
X-Originating-IP: [109.193.235.168]
X-ClientProxiedBy: AM9P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::28) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from svensmacbookair.sven.lan (109.193.235.168) by AM9P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 17:25:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0edfe104-cb04-4ba4-7ba1-08d884d48165
X-MS-TrafficTypeDiagnostic: AM0PR05MB5363:
X-Microsoft-Antispam-PRVS: <AM0PR05MB53639F66CC989DB9340CFB5CEFEA0@AM0PR05MB5363.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUdXRCIUYhAV2n8ou8DWEZENjUl9HYLOiwImxCSqfp7FutyzV8itWDVh0U8Vg/w4eGJ/C9smNL4sAeC4ugjbJBenSC4qw1Ksjyv0eX5CLpQ8oi0GgGugoKtUNhi62F65RogqXadOklFiDmsXBvkjZCvnoEZg1C2cs4/SphbqTr9FXRtibHWlOW2op+6Mc56gfjQ/pQovVJbShBrK3KQ9TWrV9QK5JfxJYOTfUu2TqY5U62jeittwgH3S1xLW40hKy9ZfIX3LQ9P69rxBkaOv41zOcAI0ureS/FZVX+X93DsdPj+Tw5WW9TElRNOmzAED
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39830400003)(366004)(136003)(396003)(26005)(186003)(1076003)(478600001)(66946007)(956004)(66476007)(66556008)(16526019)(83380400001)(53546011)(6916009)(7696005)(52116002)(6506007)(86362001)(55016002)(9686003)(316002)(4326008)(8936002)(44832011)(2906002)(7416002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Itm4vgSbkH5X/sh0Ca9AO5U1wcrCiGxJJ9Ny3CRWFCBoqfBQq7IzWZGuIRlna2iAgNdxF61AlRWwWP58MuNW+ft0kjxLINrnQ0nBlZ6kuVBU0k6qTt9pukT3WxbHcqyochjrWdaeMLh08BfSyCRoLWZ7TO2l0j1Mo7sevKtH3QVFAqfanMuR4rLullvO0FnwrG73RKhBCj4sOsd1H+UnoUqxnTtT4t0y5+A2749jgxVGd33DXXuhOK+aOT2McRPht+0nnpAoWHCWdp6Wda6wI7ikYlRyGIVxDvXelufcMaqE+HSYrly5TB6uYWSh4e7D8q6k59IQNVEPw684IWIgYRUU6E8jC97E1FjdcYB/jjzEnKUyv2GkEcpXktePRh4qZslmh4nxsVZVM9xrArpysYw57dMzdTy4avaM8AU735xDsS4Czr2AYaPtlgXANnvzNlSqIVSCqCwvFslg5CxN2OTerV23OtQNXunVFFL8x5XzekHrHDHIHcs8z4Q1KMz6wLs7h1ggUkM8NlovIkA5icxkVE5NZiYi7mHX3b7h4SpkwZbrmmaQFm0PhdceT8prkaACOgk7xY9XHIpYjFrg6mfdmMt8smJ19/Xq8VTjseQyK2J17j3Ugh23g8u036RxZKUNWk1DR6jE8b0msN3cDQ==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edfe104-cb04-4ba4-7ba1-08d884d48165
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 17:25:51.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k28hEJtbrL/bz6CXapjhzn5OxAHWggP5xKxIa1hazuiemfag12eFxwL9csj1zAfNzbPK8312XLuoqqd4cUZDDgI1eH72JtYELIo5EhXX02Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5363
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Nov 09, 2020 at 03:00:58PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/4/20 4:52 PM, sven.auhagen@voleatech.de wrote:
> > From: Sven Auhagen <sven.auhagen@voleatech.de>
> > 
> > Disable the platform irq init in ahci init platform host
> > if it was initiated by a custom function.
> > To check for it I am using the AHCI_HFLAG_MULTI_MSI flag.
> > 
> > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> 
> The code is fine here. But I'm not entirely happy with
> the commit message how about:
> 
> """
> ata: libahci_platform: Do not try to get an IRQ when AHCI_HFLAG_MULTI_MSI is set
> 
> When the ahci-host AHCI_HFLAG_MULTI_MSI flag is set then the driver must provide
> a get_irq_vector callback and take care of getting the IRQs itself. So in this
> case ahci_platform_init_host() should not try to get an IRQ itself.
> """
> 
> With the commit message updated to the above (or something similar) you
> may add my:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> I've also just given you my Reviewed-by for patch 4 and 5, and the
> result already has a Reviewed-by.
> 
> So if you can sendout a v3 of this series with the commit message for
> this patch fixed, then it is ready for merging from my pov.

Thank you, I will change the commit message and send a v3.

Best
Sven

> 
> Regards,
> 
> Hans
> 
> 
> > ---
> >  drivers/ata/libahci_platform.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index de638dafce21..f6f2a111d226 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -581,14 +581,16 @@ int ahci_platform_init_host(struct platform_device *pdev,
> >  	struct ata_host *host;
> >  	int i, irq, n_ports, rc;
> >  
> > -	irq = platform_get_irq(pdev, 0);
> > -	if (irq <= 0) {
> > -		if (irq != -EPROBE_DEFER)
> > -			dev_err(dev, "no irq\n");
> > -		return irq;
> > -	}
> > +	if (!(hpriv->flags & AHCI_HFLAG_MULTI_MSI)) {
> > +		irq = platform_get_irq(pdev, 0);
> > +		if (irq <= 0) {
> > +			if (irq != -EPROBE_DEFER)
> > +				dev_err(dev, "no irq\n");
> > +			return irq;
> > +		}
> >  
> > -	hpriv->irq = irq;
> > +		hpriv->irq = irq;
> > +	}
> >  
> >  	/* prepare host */
> >  	pi.private_data = (void *)(unsigned long)hpriv->flags;
> > 
> 
