From: Marc Singer <elf@buici.com>
Subject: Re: VIA SATA not recognizing drives
Date: Tue, 11 May 2004 09:12:37 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040511161237.GB25243@buici.com>
References: <20040508193100.GA31122@buici.com> <409D5126.2060205@pobox.com> <20040509073914.GA4881@buici.com> <40A078A3.50102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:57988 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264815AbUEKQMl
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 May 2004 12:12:41 -0400
Content-Disposition: inline
In-Reply-To: <40A078A3.50102@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Tue, May 11, 2004 at 02:54:27AM -0400, Jeff Garzik wrote:
> >I have another question, though.  I've patched the ide driver to
> >permit an IDE interface to operate without an IRQ.  It needs a little
> >bit of tweaking before it will be accepted by that IDE maintainer.
> >Are you planning to subsume all of the IDE functionality into libata
> >that is handled by the other IDE driver?  If so, have you considered
> >adding polling mode?
> 
> 
> PIO code in libata operates exclusively in polling mode.
> 
> I'm not too confident of polling DMA being a good idea.

In my case, there is no DMA.  The hardware I have on hand is
admittedly degenerate.  The only issue is that the existing IDE code
cannot work without interrupts.  While I made patches to the ide
driver to make this work, I'd rather hitch my pony to something less
hack-ish.

In a cursory overview of libata, here's what stands out in my
special-needs case.

  1) PIO stands for port-IO which I interpret as register-level IO
     which, I assume, contrasts with task-file or mailbox type IO.
  2) Libata does have an MMIO mode, nice.  My platform is ARM.  While
     these calls will work, I have a further requirement that all
     register IO must be followed by the hokey-pokey to work around
     some oddities in the hardware.  Yes, I've suggested that they fix
     the problem in hardware.  So, how can be make this configurable?
     For me, it is OK that all IDE io would require the hack.  In
     other words, even if there were another IDE controller that
     worked properly it would be OK for both to need the hack.
  3) If a device has no DMA, how do you plan to handle the data
     transfer?  Is this what ata_pio_sector() is doing?
  4) Is ata_piix.c the model? 

It doesn't really look that tough.  The only thing I'm unclear about
is how to handle read/write with the requisite hokey-pokey.
  

 
