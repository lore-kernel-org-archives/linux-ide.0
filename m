From: Marc Singer <elf@buici.com>
Subject: Re: VIA SATA not recognizing drives
Date: Wed, 19 May 2004 19:21:21 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040520022121.GA20800@buici.com>
References: <20040508193100.GA31122@buici.com> <409D5126.2060205@pobox.com> <20040509073914.GA4881@buici.com> <40A078A3.50102@pobox.com> <20040511161237.GB25243@buici.com> <40AC148E.9090404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:3969 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264851AbUETCVZ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2004 22:21:25 -0400
Content-Disposition: inline
In-Reply-To: <40AC148E.9090404@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Wed, May 19, 2004 at 10:14:38PM -0400, Jeff Garzik wrote:
> >  2) Libata does have an MMIO mode, nice.  My platform is ARM.  While
> >     these calls will work, I have a further requirement that all
> >     register IO must be followed by the hokey-pokey to work around
> >     some oddities in the hardware.  Yes, I've suggested that they fix
> >     the problem in hardware.  So, how can be make this configurable?
> >     For me, it is OK that all IDE io would require the hack.  In
> >     other words, even if there were another IDE controller that
> >     worked properly it would be OK for both to need the hack.
> 
> Everything is done via custom hooks you provide, in struct 
> ata_port_operations.

Nice.

> >  4) Is ata_piix.c the model? 
> 
> I don't know your hardware at all, so I cannot say.
> 
> All of drivers/scsi/ata_*.c drivers/scsi/sata_*.c are the model :)

OK.  That's helpful.

> >It doesn't really look that tough.  The only thing I'm unclear about
> >is how to handle read/write with the requisite hokey-pokey.
> 
> libata needs a hook for PIO data xfer, since it is currently hardcoded 
> to use outsl() and insl().  Other than that, existing 
> ata_port_operations hooks can do that "hokey-pokey".

Excellent.  Thanks.
