From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Thu, 11 Aug 2005 17:07:30 -0600
Message-ID: <200508111707.30861.bjorn.helgaas@hp.com>
References: <200508111424.43150.bjorn.helgaas@hp.com> <20050811214807.GA9775@havoc.gtf.org> <42FBC985.4030602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:25528 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932539AbVHKXIX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 19:08:23 -0400
In-Reply-To: <42FBC985.4030602@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>

On Thursday 11 August 2005 3:56 pm, Jeff Garzik wrote:
> Jeff Garzik wrote:
> > 00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller 
> > (rev 02) (prog-if 8a [Master SecP PriP])
> >         Subsystem: Hewlett-Packard Company d530 CMT (DG746A)
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
> > ping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
> > - <MAbort- >SERR- <PERR-
> >         Latency: 0
> >         Interrupt: pin A routed to IRQ 169
> >         Region 0: I/O ports at <ignored>
> >         Region 1: I/O ports at <ignored>
> >         Region 2: I/O ports at <ignored>
> >         Region 3: I/O ports at <ignored>
> >         Region 4: I/O ports at 14c0 [size=16]
> >         Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]
> > 
> > Trust me, IDE on PCI is still quite weird.
> 
> The above configuration also indicates that the IRQs for the PCI device 
> are 14 and 15, _not_ 169.

You deduce this by the absence of SecO and PriO?  I wonder if lspci
should be enhanced to notice this, too.  I assume that the IRQ 169
doesn't correspond to anything in /proc/interrupts.

So the scenario in question (correct me if I'm wrong) is that we
have a PCI IDE device that is handed off in compatibility mode (and
may only work in that mode).  In that case, the PCI *device* still
exists, so shouldn't the IDE PCI code claim that device, notice that
it's in compatibility mode, and use the legacy ports and IRQs if
necessary?

It seems like that all should work even if we don't have IDE_GENERIC.
