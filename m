From: Greg KH <greg@kroah.com>
Subject: Re: [RFC] add port information for ATA devices in sysfs
Date: Tue, 27 Apr 2010 22:50:13 -0700
Message-ID: <20100428055013.GA14913@kroah.com>
References: <201004261829.04687.nschichan@freebox.fr> <20100427034210.GB4759@kroah.com> <201004271518.13611.nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:56744 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399Ab0D1Ft3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Apr 2010 01:49:29 -0400
Content-Disposition: inline
In-Reply-To: <201004271518.13611.nschichan@freebox.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Maxime Bizon <mbizon@freebox.fr>

On Tue, Apr 27, 2010 at 03:18:13PM +0200, Nicolas Schichan wrote:
> On Tuesday 27 April 2010 05:42:10 am Greg KH wrote:
> > On Mon, Apr 26, 2010 at 06:29:04PM +0200, Nicolas Schichan wrote:
> 
> > > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > > index 91fed3c..179abad 100644
> > > --- a/drivers/ata/libata-core.c
> > > +++ b/drivers/ata/libata-core.c
> > > @@ -5660,6 +5660,10 @@ int sata_link_init_spd(struct ata_link *link)
> > >  	return 0;
> > >  }
> > >
> > > +static void ata_port_dev_release(struct device *dev)
> > > +{
> > > +}
> >
> > {sigh}
> >
> > By doing the above, you have guaranteed that I will make fun of this
> > code.  Consider this the ridicule it deserves.
> >
> > (hint, read the kobject documentation for why I get to make fun of
> > it...)
> >
> > Think about why you created an empty release function, to try to get the
> > kernel to stop spitting out a message to you. 
> 
> That's right, shame on me for not reading the documentation.
> 
> >  Didn't you think that the
> > message was there for a reason, and it was not to be worked around?
> 
> Well after reading  the kobject documentation, I understand  why it is
> bad thing to have this function empty.  Since someone may still hold a
> reference on the  device when I call device_unregister(),  I guess the
> only safe place  where to kfree the struct ata_port  is in the release
> callback of the device.
> 
> Please find an updated patch addressing your comments below:

Looks better, thanks.

As for the whole idea of the extra device (which it doesn't look like
you ever initialize anywhere), it's not good to have one sitting in the
middle of the device chain that isn't owned by a bus somehow.  That just
looks wierd and can cause problems with udev rules.

why is this really needed at all?  Can't you just export the port number
in the device as an attribute instead?

thanks,

greg k-h
