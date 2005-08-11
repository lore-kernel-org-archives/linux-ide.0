From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Thu, 11 Aug 2005 17:48:07 -0400
Message-ID: <20050811214807.GA9775@havoc.gtf.org>
References: <200508111424.43150.bjorn.helgaas@hp.com> <200508111445.41428.bjorn.helgaas@hp.com> <42FBBB6F.1030306@pobox.com> <200508111542.07851.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200508111542.07851.bjorn.helgaas@hp.com>
Sender: linux-ia64-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>
List-Id: linux-ide@vger.kernel.org

On Thu, Aug 11, 2005 at 03:42:07PM -0600, Bjorn Helgaas wrote:
> Tony, others, does this change give you any heartburn?  On
> the 460GX and 870 boxes I have, IDE is a PCI device.
> 
> (I have been told that the SGI ia64 simulator depends on
> IDE_GENERIC.  But it really should make the IDE device
> appear in PCI (or describe it via ACPI)).

I think I was misunderstood.

Have you reviewed the PCI IDE specification?

On modern chipsets, the IDE device appears in PCI -- but often, the first 
four I/O ports will be zeroed out, indicating that the I/O regions are
actually 0x1f0/0x170.

For example:

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller 
(rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Hewlett-Packard Company d530 CMT (DG746A)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 169
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 14c0 [size=16]
        Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]



Trust me, IDE on PCI is still quite weird.

	Jeff



