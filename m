From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Thu, 11 Aug 2005 17:56:21 -0400
Message-ID: <42FBC985.4030602@pobox.com>
References: <200508111424.43150.bjorn.helgaas@hp.com> <200508111445.41428.bjorn.helgaas@hp.com> <42FBBB6F.1030306@pobox.com> <200508111542.07851.bjorn.helgaas@hp.com> <20050811214807.GA9775@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20050811214807.GA9775@havoc.gtf.org>
Sender: linux-ia64-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> 00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller 
> (rev 02) (prog-if 8a [Master SecP PriP])
>         Subsystem: Hewlett-Packard Company d530 CMT (DG746A)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
> ping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
> - <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 169
>         Region 0: I/O ports at <ignored>
>         Region 1: I/O ports at <ignored>
>         Region 2: I/O ports at <ignored>
>         Region 3: I/O ports at <ignored>
>         Region 4: I/O ports at 14c0 [size=16]
>         Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]
> 
> 
> 
> Trust me, IDE on PCI is still quite weird.

The above configuration also indicates that the IRQs for the PCI device 
are 14 and 15, _not_ 169.

	Jeff


