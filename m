From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [BUG] ide dma_timer_expiry, then hard lockup
Date: Tue, 19 Jun 2007 10:05:02 -0500
Message-ID: <20070619150502.GO5836@austin.ibm.com>
References: <20070618175713.GD5836@austin.ibm.com> <DFEF91B22ED07447AB6AA4B237F913F9B18A05@ausx3mpc125.aus.amer.dell.com> <4677E30B.4020101@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758836AbXFSPF2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4677E30B.4020101@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Stuart_Hayes@Dell.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Sergei,

On Tue, Jun 19, 2007 at 06:07:07PM +0400, Sergei Shtylyov wrote:
> 
> Stuart_Hayes@Dell.com wrote:
> >I think reading the IDE status register clears the interrupt in the IDE
> >device, which might be causing the drive to think it's OK to generate
> >another interrupt.
> 
>    This is not how IDE drives are supposed to act -- they won't proceed any 
> further until "interrupt pending" condition is cleared, so these aren't 
> supposed to be "stacked". This behavior however is not strictly specified 
> by ATA standards IIRC, but I can't readily imagine such situaltion anyway 
> unless tagged command queueing  (which is not supported by IDE core) and/or 
> ATAPI command overlapping is in action...

The problem only manifests during high io load; perhaps a missing mutex
somewhere is blasting one thing too many out to the hard drive?

> > This could either cause it to get stuck trying to
> >service an interrupt that is never getting cleared as you suggested, or
> >possibly when the next IRQ comes in the IDE IRQ handler gets stuck
> >waiting for a spinlock that the code you're looking at already owns...?
> 
>    I could also imagine the HPT366 chip going mad and stalling the reads if 
> the taskfile regs forever because of the incomplete DMA or even the drive 
> going mad and not replying to I/O cycles with proper -IORDY handshake (i.e. 
> holding it low all the time)...

In my case, ctrl-alt-sysrq doesn't work, which makes it hard to debug.

I'm thinking that trying to debug libata is a better idea, rather than
investing time in ide, right?  Although at the moment, libata works even 
less; see other email.

--linas
