From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata and PATA devices
Date: Thu, 11 Aug 2005 12:26:05 +0200
Message-ID: <58cb370e050811032658a2b61e@mail.gmail.com>
References: <200508071949.03782.inform@tiker.net> <42F6B8CD.4050100@gmail.com>
	 <20050808030239.GA27502@havoc.gtf.org>
	 <1123495856.22328.62.camel@localhost.localdomain>
	 <42F8B41C.4040408@rtr.ca> <42FACCA8.6050408@pobox.com>
	 <1123753051.4226.22.camel@localhost.localdomain>
	 <58cb370e05081103031cb9ccdb@mail.gmail.com>
	 <1123755440.4226.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.196]:21309 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964881AbVHKK0I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Aug 2005 06:26:08 -0400
Received: by nproxy.gmail.com with SMTP id l37so73866nfc
        for <linux-ide@vger.kernel.org>; Thu, 11 Aug 2005 03:26:05 -0700 (PDT)
In-Reply-To: <1123755440.4226.28.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On 8/11/05, Erik Slagter <erik@slagter.name> wrote:
> On Thu, 2005-08-11 at 12:03 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > > Most current laptops ship with a PATA hard drive, and a PATA
> > > > > ATAPI drive.  The easiest way to make them usable under Linux-2.6
> >
> > New laptops rather ship with:
> >
> > SATA (or PATA + bridge) hard disk and PATA ATAPI drive
> 
> How do I find out?
> 
> As ICH6M features both PATA and SATA connections, I don't see why they'd
> use a PATA bridge... The DVD drives use PATA anyway, btw.

AFAIR ICH6M has only one PATA port and putting both HDD and DVD drive
on the same PATA port would sacrifice performance (because only one PATA
device can be used at a time).

> > > You are sort of contradicting yourself. My setup (Dell laptop with ICH6M
> > > and PATA harddisk) defaults to using libata for the PATA hardisk. Only
> 
> > Are you sure?
> 
> Yes I am sure. I can give you all the data to verify it yourself.
> 
> > I suspect that you have SATA-PATA converter inside the laptop
> 
> That would be a possibility, but I don't why.
> 
> > (or you are simply not using vanilla kernel).
> 
> You bet I always use vanilla kernels.
> 
> > > with a specific patch (which adds the PCI id to the IDE driver's id
> > > list, and which was not quite accepted here) the IDE driver will
> > > recognise the ICH6M and use it (and then it works fine).
> >
> > Yes, current situation with ICH6M support really sucks as many laptops
> > are set to use combined mode and don't have BIOS option to disable it
> 
> Yeah, grmbl.
> 
> > so users end up with unusable ATAPI device (== limited to PIO mode
> > only because DMA region is already reserved by libata and cannot be
> > used by IDE driver).
> 
> But with the patch (that adds the ID to the IDE driver), it all works.

Yes because in that case SATA controller is also driven by the IDE driver.

[ combined mode means that only PCI device for SATA controller is
  visible to the system and it controls both SATA and PATA devices ]

Bartlomiej

> > OTOH IDE driver should handle combined mode just fine and provide
> > working ATAPI DMA (+ SMART support for HDD).  I prefer to not go
> > this way but the libata development is *extremely* slow (I'm not blaming
> > anyone just stating the fact)...
> 
> I guess you have a quite bunch of users willing to test here ;-)
