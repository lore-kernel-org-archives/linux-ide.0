From: Brandon Philips <brandon@ifup.org>
Subject: Re: [PATCH resubmit] /drivers/ata ioremap returncode check
Date: Thu, 23 Aug 2007 10:53:40 -0700
Message-ID: <20070823175340.GA6848@ifup.org>
References: <20070823023328.19E6CDA82B@mailserver7.hushmail.com> <159327.52462.qm@web44910.mail.sp1.yahoo.com> <20070823053458.GA4418@ifup.org> <20070823174204.GB1818@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:16187 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760175AbXHWRxq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Aug 2007 13:53:46 -0400
Received: by nz-out-0506.google.com with SMTP id s18so367501nze
        for <linux-ide@vger.kernel.org>; Thu, 23 Aug 2007 10:53:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070823174204.GB1818@martell.zuzino.mipt.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: postfail@hushmail.com, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org

On 21:42 Thu 23 Aug 2007, Alexey Dobriyan wrote:
> On Wed, Aug 22, 2007 at 10:34:58PM -0700, Brandon Philips wrote:
> > On 19:47 Wed 22 Aug 2007, Scott Thompson wrote:
> > > Patchset against 2.6.23-rc3.  corrects missing ioremap return 
> > > checks, resending after making changes suggested....
> > > 
> > > Signed-off-by: Scott Thompson <postfail <at> hushmail.com>
> > > ------------------------------------------------------------
> > > diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
> > > index 4ca7fd6..8dc7c3b 100644
> > > --- a/drivers/ata/pata_ixp4xx_cf.c
> > > +++ b/drivers/ata/pata_ixp4xx_cf.c
> > > @@ -189,6 +189,10 @@ static __devinit int ixp4xx_pata_probe(struct platform_device *pdev)
> > >  	data->cs0 = devm_ioremap(&pdev->dev, cs0->start, 0x1000);
> > >  	data->cs1 = devm_ioremap(&pdev->dev, cs1->start, 0x1000);
> > >  
> > > +	if (!data->cs0 || !data->cs1) {
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > 
> > You aren't following the Kernel CodingStyle there.  
> > 
> > See Documentation/CodingStyle:
> > 
> > "Do not unnecessarily use braces where a single statement will do."
> > 
> > +	if (!data->cs0 || !data->cs1)
> > +		return -ENOMEM;
> 
> This and nice printk message absence. :)

Huh?  What do you mean?

Thanks,

	Brandon
