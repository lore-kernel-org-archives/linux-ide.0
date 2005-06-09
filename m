From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: does AHCI work on intel 915 ICH6 controllers? Is it supposed
 to?
Date: Wed, 08 Jun 2005 21:55:29 -0400
Message-ID: <42A7A191.7040700@pobox.com>
References: <d87q4j$d37$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:39379 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261203AbVFIBzc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2005 21:55:32 -0400
In-Reply-To: <d87q4j$d37$1@sea.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sean <seandarcy2@gmail.com>
Cc: linux-ide@vger.kernel.org

sean wrote:
> I'm running 2.6.12-rc5 on a gigabyte GA-8i915G Pro mobo. It has only one 
> drive -a Maxtor SATA.
> 
> lspci -vv -s 00:1f.2
> 00:1f.2 IDE interface: Intel Corp. 82801FB/FW (ICH6/ICH6W) SATA 
> Controller (rev 03) (prog-if 80 [Master])
>         Subsystem: Giga-byte Technology: Unknown device 2651
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 201
>         Region 0: I/O ports at <unassigned>
>         Region 1: I/O ports at <unassigned>
>         Region 2: I/O ports at <unassigned>
>         Region 3: I/O ports at <unassigned>
>         Region 4: I/O ports at f000 [size=16]

Plain vanilla ICH6 does not support AHCI, but other ICH6 variants such 
as ICH6-R do.  If your chip does support AHCI, then your BIOS is not 
enabling it.

AHCI support is clearly indicated by Region 5, a memory (MMIO) region:

>         Region 0: I/O ports at e880 [size=8]
>         Region 1: I/O ports at e800 [size=4]
>         Region 2: I/O ports at e480 [size=8]
>         Region 3: I/O ports at e400 [size=4]
>         Region 4: I/O ports at e080 [size=32]
>         Region 5: Memory at feb3fc00 (32-bit, non-prefetchable) [size=1K]

Regards,

	Jeff


