From: "eric" <eric@pozicom.net>
Subject: RE: multiple sata_mv boards with same DevID ?
Date: Mon, 28 Jul 2008 21:56:07 -0400
Message-ID: <20080729024256.5B95343783@mail.pozicom.net>
References: <488E7716.90703@rtr.ca>
Reply-To: <eric@pozicom.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx01.pozicom.net ([70.88.103.169]:43266 "EHLO mail.pozicom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbYG2BxA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jul 2008 21:53:00 -0400
In-Reply-To: <488E7716.90703@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Mark Lord' <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

lspci -xxx 
04:00.0 SCSI storage controller: HighPoint Technologies, Inc. RocketRAID
1740 (rev 02)
00: 03 11 40 17 17 01 b0 02 02 00 00 01 20 40 00 00
10: 04 00 90 df 00 00 00 00 01 dc 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ab 11 ab 11
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
40: 01 50 02 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 05 60 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 07 00 30 00 f8 ff 83 01 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

lspci -vvxxx
04:00.0 SCSI storage controller: HighPoint Technologies, Inc. RocketRAID
1740 (rev 02)
        Subsystem: Marvell Technology Group Ltd. Unknown device 11ab
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 128 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at df900000 (64-bit, non-prefetchable) [size=1M]
        Region 2: I/O ports at dc00 [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] PCI-X non-bridge device
                Command: DPERE- ERO- RBC=512 OST=4
                Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple
DMMRBC=512 DMOST=4 DMCRS=8 RSCEM- 266MHz- 533MHz-
        Kernel driver in use: sata_mv
00: 03 11 40 17 17 01 b0 02 02 00 00 01 20 40 00 00
10: 04 00 90 df 00 00 00 00 01 dc 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ab 11 ab 11
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
40: 01 50 02 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 05 60 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 07 00 30 00 f8 ff 83 01 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


~Eric




-----Original Message-----
From: Mark Lord [mailto:liml@rtr.ca] 
Sent: Monday, July 28, 2008 9:49 PM
To: eric@pozicom.net
Cc: linux-ide@vger.kernel.org
Subject: Re: multiple sata_mv boards with same DevID ?

eric wrote:
> To whom it may concern:
> 
> We have the HighPoint 1740 SATAII RAID card.  I had to modify the 
> sata_mv.c
> (attached) to get it to work with my card.  The interesting bits are 
> as
> follows:
> 
> /* RocketRAID 1740/174x have different identifiers */
> 
> /* { PCI_VDEVICE(TTI, 0x1740), chip_508x }, */
> 
> /* Pozicom: GenII 1740 cards use 88sx6042 chip */
> 
> { PCI_VDEVICE(TTI, 0x1740), chip_6042 },
> 
> { PCI_VDEVICE(TTI, 0x1742), chip_508x },
> 
>  
> It appears the same card has different chip set depending upon when 
> you purchased your card.  Looking through the code, the GenI vs. GenII vs.
> GenIIe is done after the call to mv_pci_init_one thus passing a table 
> of values that are incorrect.  It would appear to make sense to solve 
> this by creating two or more tables and make mv_pci_tbl a 
> pci_device_id global * and reference it accordingly after the Rev. level
was determined.
..

Hi,

We (I) really need to see the output of "lspci -xxx" from that system.

Thanks.

