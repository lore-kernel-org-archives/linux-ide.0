From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata/pata_it821x: Improve handling of poorly
 compatible emulations
Date: Thu, 25 Oct 2007 23:34:15 +0100
Message-ID: <20071025233415.15e677bf@the-village.bc.nu>
References: <20071025142116.7e38ee86@the-village.bc.nu>
	<20071025131105.ca992a64.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58009 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754304AbXJYWbk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 18:31:40 -0400
In-Reply-To: <20071025131105.ca992a64.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Thu, 25 Oct 2007 13:11:05 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 25 Oct 2007 14:21:16 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > +                if (print_info) {
> > +			ata_dev_printk(dev, KERN_WARNING,
> > +"Drive reports diagnostics failure. This may indicate a drive\n");
> > +			ata_dev_printk(dev, KERN_WARNING,
> > +"fault or invalid emulation. Contact drive vendor for information.\n");
> > +		}
> 
> eww, my eyes.
> 
> It would be better to remove the first \n and use KERN_CONT in the second
> printk.  Maybe.  Even better would be to do it all in one printk so that
> it is atomic in the printk buffer.

One printk goes all wonky as ata_dev_printk does lots of lead in which
does look best on both lines (having tried it both ways when first doing
this)

ALan
