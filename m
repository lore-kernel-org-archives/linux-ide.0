From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH resubmit] /drivers/ata ioremap returncode check
Date: Thu, 23 Aug 2007 21:42:04 +0400
Message-ID: <20070823174204.GB1818@martell.zuzino.mipt.ru>
References: <20070823023328.19E6CDA82B@mailserver7.hushmail.com> <159327.52462.qm@web44910.mail.sp1.yahoo.com> <20070823053458.GA4418@ifup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:16173 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762398AbXHWRmM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Aug 2007 13:42:12 -0400
Received: by nf-out-0910.google.com with SMTP id g13so427834nfb
        for <linux-ide@vger.kernel.org>; Thu, 23 Aug 2007 10:42:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070823053458.GA4418@ifup.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brandon Philips <brandon@ifup.org>
Cc: postfail@hushmail.com, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Aug 22, 2007 at 10:34:58PM -0700, Brandon Philips wrote:
> On 19:47 Wed 22 Aug 2007, Scott Thompson wrote:
> > Patchset against 2.6.23-rc3.  corrects missing ioremap return 
> > checks, resending after making changes suggested....
> > 
> > Signed-off-by: Scott Thompson <postfail <at> hushmail.com>
> > ------------------------------------------------------------
> > diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
> > index 4ca7fd6..8dc7c3b 100644
> > --- a/drivers/ata/pata_ixp4xx_cf.c
> > +++ b/drivers/ata/pata_ixp4xx_cf.c
> > @@ -189,6 +189,10 @@ static __devinit int ixp4xx_pata_probe(struct platform_device *pdev)
> >  	data->cs0 = devm_ioremap(&pdev->dev, cs0->start, 0x1000);
> >  	data->cs1 = devm_ioremap(&pdev->dev, cs1->start, 0x1000);
> >  
> > +	if (!data->cs0 || !data->cs1) {
> > +		return -ENOMEM;
> > +	}
> > +
> 
> You aren't following the Kernel CodingStyle there.  
> 
> See Documentation/CodingStyle:
> 
> "Do not unnecessarily use braces where a single statement will do."
> 
> +	if (!data->cs0 || !data->cs1)
> +		return -ENOMEM;

This and nice printk message absence. :)
