From: Marc Singer <elf@buici.com>
Subject: Re: VIA SATA not recognizing drives
Date: Sun, 9 May 2004 00:39:14 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040509073914.GA4881@buici.com>
References: <20040508193100.GA31122@buici.com> <409D5126.2060205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:30342 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264297AbUEIHjQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 May 2004 03:39:16 -0400
Content-Disposition: inline
In-Reply-To: <409D5126.2060205@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Sat, May 08, 2004 at 05:29:10PM -0400, Jeff Garzik wrote:
> Marc Singer wrote:
> >  libata version 1.02 loaded.
> >  sata_via version 0.20
> >  sata_via(0000:00:0f.0): routed to hard irq line 10
> >  ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 10
> >  ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 10
> >  ata1: no device found (phy stat 00000000)
> >  ata1: thread exiting
> >  scsi0 : sata_via
> >  ata2: no device found (phy stat 00000000)
> >  ata2: thread exiting
> >  scsi1 : sata_via
> 
> 
> Those "phy stat 00000000" are the hardware saying there is no SATA 
> device attached.
> 
> Are you sure you plugged them into the VIA SATA ports?  Maybe you have a 
> Promise chip on-board too, or something like that?  Or SATA is disabled 
> in BIOS?

I'm embarassed to say, though not too proud to admit, that the power
cables weren't properly seated.  It's working just fine.

I have another question, though.  I've patched the ide driver to
permit an IDE interface to operate without an IRQ.  It needs a little
bit of tweaking before it will be accepted by that IDE maintainer.
Are you planning to subsume all of the IDE functionality into libata
that is handled by the other IDE driver?  If so, have you considered
adding polling mode?

Cheers.
