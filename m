From: Ericisko <linux2@rogers.com>
Subject: Re: IDE kernel traces in 2.6.9 - Bad IRQ ?
Date: Mon, 1 Nov 2004 09:28:47 -0500 (EST)
Message-ID: <20041101142847.41837.qmail@web88005.mail.re2.yahoo.com>
References: <41853982.8090807@ipom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web88005.mail.re2.yahoo.com ([206.190.37.192]:4235 "HELO
	web88005.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S265149AbUKAO2u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Nov 2004 09:28:50 -0500
In-Reply-To: <41853982.8090807@ipom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Dibowitz <phil@ipom.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi,

I have similar problem. I have MSI Neo2-FIS2R board
with 865PE chipset. I have 1 PATA hard drive connected
to ICH5, IDE channel 1 and DVD and CD-RW connected to
IDE channel 2. I use IDE driver piix, not libata. When
IDE is in legacy mode (BIOS setup), everything works
fine - each channel has its own IRQ. When I change
mode to native, I get the message "Disabling IRQ" with
trace stack showing 2 ide_intr handlers for IRQ (1 for
each channel?) and both channels share the same IRQ.
It looks like interrupt is not handled and it's level
triggered so /proc/interrupts shows huge number of
interrupts and soon IRQ is disabled.
If ide-cd is compiled as module, everything works fine
unless I load ide-cd module. Than I get the same
errors.
As that particular interrupt was shared also by USB
and eth0, I built the minimal kernel so ide0 and ide1
were the only devices using the interrupt - the same
problem.
I'm not at my computer right now so I can't send any
additional info at the moment.

  Erik

 --- Phil Dibowitz <phil@ipom.com> wrote: 
> Jeff Garzik wrote:
> > Phil Dibowitz wrote:
> > 
> >> Phil Dibowitz wrote:
> >>
> >>> I just upgraded my computer, compiled a new
> kernel appropriately, and 
> >>> I'm getting a ton of kernel issues surrounding
> the IDE driver. I 
> >>> tried a generic debian kernel as well, but same
> issue. Here are the 
> >>> tracebacks I get during boot:
> >>>
> >>> Oct 30 15:56:19 rider kernel: ide0 at
> 0xefe0-0xefe7,0xefae on irq 5
> >>> Oct 30 15:56:19 rider kernel: hda: max request
> size: 128KiB
> >>
> >>
> >>
> >> So, it turns out if I change the IDE
> Configuration in my BIOS to be 
> >> "Compatible mode" instead of "Enhanced Mode",
> this is fixed 
> >> completely. All my drives work flawelessly.
> >>
> >> Any idea what, if any, features I'm missing, or
> how to make linux work 
> >> with "enhanced mode" ?
> > 
> > 
> > 
> > Sounds like you're not using CONFIG_SCSI_SATA for
> your SATA?
> 
> Erm. That's possible -- I have an SATA controller on
> the new board, but 
> I don't have any SATA drives, so I didn't compile
> the promise driver or 
> anything else for SATA...
> 
> Thanks, I'll look into that.
> 
> 
> -- 
> Phil Dibowitz                            
> phil@ipom.com
> Freeware and Technical Pages              Insanity
> Palace of Metallica
> http://www.phildev.net/                  
> http://www.ipom.com/
> 
> "They that can give up essential liberty to obtain a
> little temporary
> safety deserve neither liberty nor safety."
>   - Benjamin Franklin, 1759
> 
> 

> ATTACHMENT part 2 application/pgp-signature
name=signature.asc
 
