From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 resetting controller...
Date: Fri, 28 Apr 2006 08:52:45 +0900
Message-ID: <4451594D.5060705@gmail.com>
References: <20060427185813.GB6039@l4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:56213 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751727AbWD0XwY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Apr 2006 19:52:24 -0400
Received: by pproxy.gmail.com with SMTP id i49so2237711pye
        for <linux-ide@vger.kernel.org>; Thu, 27 Apr 2006 16:52:24 -0700 (PDT)
In-Reply-To: <20060427185813.GB6039@l4x.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jdi@l4x.org
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

jdi@l4x.org wrote:
> Hello,
> 
> I just received a DawiControl DC-4300 SATA-2 RAID card
> (sil3124 based) together with a Western Digital WD3200KS 
> hard drive which should support sata2 and ncq in its
> full glory. Basic read/write tests with dd went ok,
> so I started to reshape my raid5 array. Since the reshape
> started my kernel log gets swamped with the following messages:
> 
> [4297871.909000] sata_sil24 ata1: resetting controller...
> [4297871.909000] ata1: status=0x50 { DriveReady SeekComplete }
> [4297871.909000] sdc: Current: sense key=0x0
> [4297871.909000]     ASC=0x0 ASCQ=0x0
> [4297873.266000] ata1: error interrupt on port0
> [4297873.266000]   stat=0x80000001 irq=0xb60002 cmd_err=35 sstatus=0x123

cmd_err 35 is...

PORT_CERR_XFR_PCIPERR	= 35, /* PSD ecode 11 - PCI prity err during 
transfer */

> serror=0x0[4297873.266000] sata_sil24 ata1: resetting controller...
> [4297873.267000] ata1: status=0x50 { DriveReady SeekComplete }
> [4297873.267000] sdc: Current: sense key=0x0
> [4297873.267000]     ASC=0x0 ASCQ=0x0
> 
> The time between these events varies from .5s to up to 10s, resync speed is
> pretty bad (6mb/s) but appears(!) to be working.
> This is with vanilla 2.6.17-rc3, sata drivers built into the kernel.
> Find below /proc/interrupts and lspci output. Boot dmesg output was washed
> away by above messages, sorry.
> 
> What's the cause of the error, can I ignore it or will it destroy
> my raid eventually? I'm now about 5% through the resync process, with 
> an estimated finish in 1260 minutes.
> 
> Thanks,
> 
> Jan
> 
> 
> $ lspci -vv -s 03:04.0
> 0000:03:04.0 RAID bus controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 01)
> 	Subsystem: Silicon Image, Inc.: Unknown device 7124
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32
> 	Interrupt: pin A routed to IRQ 22
> 	Region 0: Memory at fa800000 (64-bit, non-prefetchable) [size=128]
> 	Region 2: Memory at fa000000 (64-bit, non-prefetchable) [size=32K]
> 	Region 4: I/O ports at 9400 [size=16]
> 	Expansion ROM at fe900000 [disabled] [size=512K]
> 	Capabilities: [64] Power Management version 2
> 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
> 	Capabilities: [40] PCI-X non-bridge device.
> 		Command: DPERE- ERO+ RBC=0 OST=5
> 		Status: Bus=3 Dev=4 Func=0 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=2, DMOST=5, DMCRS=4, RSCEM-

So, slow down the PCI-X bus.  It can usually be done from BIOS setup 
menu.  Does your machine has a riser board which extends or changes 
orientation of PCI-X bus?  Motherboard vendors describe the bus 
frequency limit when using riser boards in the manual but sometimes 
server vendors forget to set them.  Heck, some of them don't even know 
what that is.

-- 
tejun
