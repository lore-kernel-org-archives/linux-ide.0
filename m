From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata and PATA devices
Date: Thu, 11 Aug 2005 12:03:09 +0200
Message-ID: <58cb370e05081103031cb9ccdb@mail.gmail.com>
References: <200508071949.03782.inform@tiker.net> <42F6B8CD.4050100@gmail.com>
	 <20050808030239.GA27502@havoc.gtf.org>
	 <1123495856.22328.62.camel@localhost.localdomain>
	 <42F8B41C.4040408@rtr.ca> <42FACCA8.6050408@pobox.com>
	 <1123753051.4226.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.198]:54242 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964846AbVHKKDK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Aug 2005 06:03:10 -0400
Received: by nproxy.gmail.com with SMTP id l37so72322nfc
        for <linux-ide@vger.kernel.org>; Thu, 11 Aug 2005 03:03:09 -0700 (PDT)
In-Reply-To: <1123753051.4226.22.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On 8/11/05, Erik Slagter <erik@slagter.name> wrote:
> On Wed, 2005-08-10 at 23:57 -0400, Jeff Garzik wrote:
> 
> > > Most current laptops ship with a PATA hard drive, and a PATA
> > > ATAPI drive.  The easiest way to make them usable under Linux-2.6

New laptops rather ship with:

SATA (or PATA + bridge) hard disk and PATA ATAPI drive

> > > is to patch libata and turn on ATAPI support, using ata_piix.
> >
> > No, the best thing to do is use the IDE driver for PATA.  That is the
> > most stable, most well-tested path to ATAPI support at present.
> >
> > > This REALLY ought to be on by default now, Jeff.
> > > Especially since the default is to NOT work at all..
> >
> > Correct, because currently no one should be using libata for PATA support.
> 
> You are sort of contradicting yourself. My setup (Dell laptop with ICH6M
> and PATA harddisk) defaults to using libata for the PATA hardisk. Only

Are you sure?

I suspect that you have SATA-PATA converter inside the laptop
(or you are simply not using vanilla kernel).

> with a specific patch (which adds the PCI id to the IDE driver's id
> list, and which was not quite accepted here) the IDE driver will
> recognise the ICH6M and use it (and then it works fine).

Yes, current situation with ICH6M support really sucks as many laptops
are set to use combined mode and don't have BIOS option to disable it
so users end up with unusable ATAPI device (== limited to PIO mode
only because DMA region is already reserved by libata and cannot be
used by IDE driver).

Jeff, what is the current status of libata ATAPI support?  IMO changes
(from you, Albert and Tejun) just need some polishing and merging,
or there is still some major work to do?

OTOH IDE driver should handle combined mode just fine and provide 
working ATAPI DMA (+ SMART support for HDD).  I prefer to not go
this way but the libata development is *extremely* slow (I'm not blaming
anyone just stating the fact)...

Bartlomiej

> > Turning on ATAPI and PATA support by default will break existing setups.
> 
> > > The libata code is taking forever to catch up to modern reality,
> > > mostly because so much of it lives eternally in Jeff's private
> > > git repository, where only a few people ever exercise the code.
> >
> > Exaggeration.  We're talking about a single #define here, to enable ATAPI.
> 
> How about a simple configure option...
