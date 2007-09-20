From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pata_acpi: Use ata_sff_port_start
Date: Thu, 20 Sep 2007 13:27:27 -0700
Message-ID: <20070920132727.db91be81.akpm@linux-foundation.org>
References: <20070920150415.542a3f49@the-village.bc.nu>
	<46F2CE39.6090403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33500 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750933AbXITU1k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 16:27:40 -0400
In-Reply-To: <46F2CE39.6090403@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Thu, 20 Sep 2007 15:47:05 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > Purely a stylistic issue currently but best done while I notice it.
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> > 
> > diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc6-mm1/drivers/ata/pata_acpi.c linux-2.6.23rc6-mm1/drivers/ata/pata_acpi.c
> > --- linux.vanilla-2.6.23rc6-mm1/drivers/ata/pata_acpi.c	2007-09-18 15:32:51.000000000 +0100
> > +++ linux-2.6.23rc6-mm1/drivers/ata/pata_acpi.c	2007-09-18 16:18:12.000000000 +0100
> > @@ -270,7 +270,7 @@
> >  	acpi->mask[0] = pacpi_discover_modes(ap, &ap->device[0]);
> >  	acpi->mask[1] = pacpi_discover_modes(ap, &ap->device[1]);
> >  
> > -	ret = ata_port_start(ap);
> > +	ret = ata_sff_port_start(ap);
> >  	if (ret < 0)
> 
> I request that somebody send me the pata_acpi driver against 
> netdev-2.6.git#upstream as an "add driver" patch, complete with all the 
> changes so far rolled into a single patch...
> 

umm, I guess that would be me.  Will try to get onto that today or tomorrow..
