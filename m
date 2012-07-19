From: Srikanth TS <ts.srikanth@samsung.com>
Subject: RE: Drive not detected upon resume from suspend-to-ram [sata_promise]
Date: Thu, 19 Jul 2012 09:38:18 +0900
Message-ID: <01a901cd6546$caec43d0$60c4cb70$%srikanth@samsung.com>
References: <CAHmELnVRCcLBdF5G1t=NPDu=5LiOgFVeKJ-Kw=Gqp8eJFz_t7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36157 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab2GSAiU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2012 20:38:20 -0400
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M7D00BKWTR52K60@mailout2.samsung.com> for
 linux-ide@vger.kernel.org; Thu, 19 Jul 2012 09:38:19 +0900 (KST)
Received: from DOTSSRIKANT01 ([12.23.118.165])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M7D006CYTRUGGB0@mmp2.samsung.com> for
 linux-ide@vger.kernel.org; Thu, 19 Jul 2012 09:38:19 +0900 (KST)
In-reply-to: <CAHmELnVRCcLBdF5G1t=NPDu=5LiOgFVeKJ-Kw=Gqp8eJFz_t7Q@mail.gmail.com>
Content-language: en-gb
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Kenneth Langga' <klangga@gmail.com>, linux-ide@vger.kernel.org

> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
> owner@vger.kernel.org] On Behalf Of Kenneth Langga
> Sent: Wednesday, July 18, 2012 5:11 PM
> To: linux-ide@vger.kernel.org
> Subject: Drive not detected upon resume from suspend-to-ram [sata_promise]
> 
> Hi! I'm having problems with resuming from suspend-to-ram.
> Specifically, the hard drive fails to be detected. Here is the card
> info from lspci:
> 
> 03:05.0 Mass storage controller: Promise Technology, Inc. PDC20375
> (SATA150 TX2plus) (rev 02)
>         Subsystem: Promise Technology, Inc. PDC20375 (SATA150 TX2plus)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 96 (1000ns min, 4500ns max), Cache Line Size: 576 bytes
>         Interrupt: pin A routed to IRQ 20
>         Region 0: I/O ports at e800 [size=64]
>         Region 1: I/O ports at e400 [size=16]
>         Region 2: I/O ports at e000 [size=128]
>         Region 3: Memory at febff000 (32-bit, non-prefetchable) [size=4K]
>         Region 4: Memory at febc0000 (32-bit, non-prefetchable) [size=128K]
>         Expansion ROM at febe0000 [disabled] [size=16K]
>         Capabilities: [60] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: sata_promise
> 
> 
> Here are the relevant messages from syslog:
> 
> <...pm-suspend...>
> sata_promise 0000:03:05.0: PCI INT A disabled
> <...resuming...>
> sata_promise 0000:03:05.0: restoring config space at offset 0xf (was
> 0x1204010e, writing 0x1204010a)
> sata_promise 0000:03:05.0: restoring config space at offset 0xc (was
> 0x80001, writing 0xfebe0000)
> sata_promise 0000:03:05.0: restoring config space at offset 0x8 (was
> 0x900000, writing 0xfebc0000)
> sata_promise 0000:03:05.0: restoring config space at offset 0x7 (was
> 0x800000, writing 0xfebff000)
> sata_promise 0000:03:05.0: restoring config space at offset 0x6 (was
> 0x8201, writing 0xe001)
> sata_promise 0000:03:05.0: restoring config space at offset 0x5 (was
> 0x8101, writing 0xe401)
> sata_promise 0000:03:05.0: restoring config space at offset 0x4 (was
> 0x8001, writing 0xe801)
> sata_promise 0000:03:05.0: restoring config space at offset 0x3 (was
> 0x0, writing 0x6090)
> sata_promise 0000:03:05.0: restoring config space at offset 0x1 (was
> 0x2300000, writing 0x2300113)
> sata_promise 0000:03:05.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
> <...>
> ata3.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x6
> ata3: SError: { UnrecovData }
> ata3.00: failed command: IDENTIFY DEVICE
> ata3.00: cmd ec/00:01:00:00:00/00:00:00:00:00/40 tag 0 pio 512 in
> ata3.00: status: { DRDY ERR }
> ata3.00: error: { ABRT }
> ata3: hard resetting link
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: both IDENTIFYs aborted, assuming NODEV
> ata3.00: revalidation failed (errno=-2)
> ata3: hard resetting link
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: both IDENTIFYs aborted, assuming NODEV
> ata3.00: revalidation failed (errno=-2)
> ata3: hard resetting link
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: both IDENTIFYs aborted, assuming NODEV
> ata3.00: revalidation failed (errno=-2)
> ata3.00: disabled
> ata3: EH complete
> 
I had similar issue, 
So I reset the host controller and reconfigure some of the required registers in resume function.

> 
> I am using pm-suspend to suspend-to-ram and my OS is Debian Wheezy.
> Any help would be greatly appreciated. Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

WBRs,
srikanth

