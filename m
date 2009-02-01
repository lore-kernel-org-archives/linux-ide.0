From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH v2] IDE: palm_bk3710: use ioremap instead of arch-specific IO_ADDRESS()
Date: Sun, 1 Feb 2009 17:03:42 +0100
Message-ID: <200902011703.44080.bzolnier@gmail.com>
References: <1233345567-643-1-git-send-email-khilman@deeprootsystems.com> <49835D23.5040604@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:38460 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbZBARYN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 12:24:13 -0500
Received: by fg-out-1718.google.com with SMTP id 16so408325fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 01 Feb 2009 09:24:11 -0800 (PST)
In-Reply-To: <49835D23.5040604@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-ide@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

On Friday 30 January 2009, Sergei Shtylyov wrote:
> Kevin Hilman wrote:
> 
> > Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied

[ yay, this driver builds on x86 again :) ]

> > diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
> > index f38aac7..6196f76 100644
> > --- a/drivers/ide/palm_bk3710.c
> > +++ b/drivers/ide/palm_bk3710.c
> > @@ -347,7 +347,7 @@ static int __init palm_bk3710_probe(struct platform_device *pdev)
> >  	struct clk *clk;
> >  	struct resource *mem, *irq;
> >  	void __iomem *base;
> > -	unsigned long rate;
> > +	unsigned long rate, mem_size;
> >  	int i, rc;
> >  	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
> >  
> > @@ -374,13 +374,19 @@ static int __init palm_bk3710_probe(struct platform_device *pdev)
> >  		return -ENODEV;
> >  	}
> >  
> > -	if (request_mem_region(mem->start, mem->end - mem->start + 1,
> > +	mem_size = mem->end - mem->start + 1;
> > +	if (request_mem_region(mem->start, mem_size,
> >  			       "palm_bk3710") == NULL) {
> 
>     No point in keeping *if* occupying 2 lines, I think...

I fixed it while merging the patch.
