From: Tomas Lund <tlund@nxs.se>
Subject: Re: sata_sil24 failed command: READ FPDMA QUEUED
Date: Thu, 15 Jul 2010 21:05:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.1007152103081.24693@envy.nxs.se>
References: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se> <4C3D134B.2090604@gmail.com>
 <Pine.LNX.4.61.1007140955080.24693@envy.nxs.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:51897 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934480Ab0GOTFK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Jul 2010 15:05:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by envy.nxs.se (Postfix) with ESMTP id B87A32BEBE
	for <linux-ide@vger.kernel.org>; Thu, 15 Jul 2010 21:05:03 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.1007140955080.24693@envy.nxs.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Wed, 14 Jul 2010, Tomas Lund wrote:

> On Tue, 13 Jul 2010, Robert Hancock wrote:
>
>> On 07/13/2010 03:09 PM, Tomas Lund wrote:
>> 
>>> ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
>>> ata9.00: irq_stat 0x00020002, device error via D2H FIS
>>> ata9.00: failed command: READ DMA
>>> ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
>>> res 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>>> ata9.00: status: { DRDY ERR }
>>> ata9.00: error: { ABRT }
>>> ata9.00: configured for UDMA/100
>>> ata9: EH complete
>> 
>> This seems strange, the drive apparently reported command aborted when 
>> trying to read the first sectors of the disk, but there's no indication 
>> of why (there's nothing set in Serror).
>> 
>> Can you test the controller in a different machine? It could be 
>> faulty..
>
> Remotly compiled 2.6.27.48 and rebooted, just to test, and the problem 
> persists.
>
> Will pick up another sil3132 based-controller (different vendor) at 
> lunch today and do more testing tonight.
>
> The motherboard in the server is a Gigabyte 965P-DS4 with a 2.13GHz 
> Core2Duo E6420

Got myself a "Sunix SATA2400" controller with the same chip on it:

02:00.0 RAID bus controller [0104]: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller [1095:3132] (rev 01)
         Subsystem: Silicon Image, Inc. Device [1095:7132]
         Flags: bus master, fast devsel, latency 0, IRQ 17
         Memory at f1004000 (64-bit, non-prefetchable) [size=128]
         Memory at f1000000 (64-bit, non-prefetchable) [size=16K]
         I/O ports at 8000 [size=128]
         [virtual] Expansion ROM at f8200000 [disabled] [size=512K]
         Capabilities: [54] Power Management version 2
         Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
         Capabilities: [70] Express Legacy Endpoint, MSI 00
         Capabilities: [100] Advanced Error Reporting <?>
         Kernel driver in use: sata_sil24

dmesg output from booting:

sata_sil24 0000:02:00.0: version 1.1
sata_sil24 0000:02:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
sata_sil24 0000:02:00.0: setting latency timer to 64
scsi8 : sata_sil24
scsi9 : sata_sil24
ata9: SATA max UDMA/100 host m128@0xf1004000 port 0xf1000000 irq 17
ata10: SATA max UDMA/100 host m128@0xf1004000 port 0xf1002000 irq 17
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata9.00: ATA-8: SAMSUNG HD103SJ, 1AJ10001, max UDMA/133
ata9.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata9.00: configured for UDMA/100
ata10: SATA link down (SStatus 0 SControl 0)
scsi 8:0:0:0: Direct-Access     ATA      SAMSUNG HD103SJ  1AJ1 PQ: 0 ANSI: 5
sd 8:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
sd 8:0:0:0: [sdb] Write Protect is off
sd 8:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 8:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 8:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
sd 8:0:0:0: [sdb] Write Protect is off
sd 8:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 8:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sdb:<3>ata9.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
ata9.00: irq_stat 0x00020002, device error via D2H FIS
ata9.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
          res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 0x401 (device error) <F>
ata9.00: status: { DRDY }
ata9.00: configured for UDMA/100
ata9: EH complete
ata9.00: NCQ disabled due to excessive errors
ata9.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
ata9.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata9.00: status: { DRDY }
ata9: hard resetting link
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata9.00: configured for UDMA/100
ata9: EH complete
ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata9.00: irq_stat 0x00020002, device error via D2H FIS
ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
          res 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
ata9.00: status: { DRDY ERR }
ata9.00: error: { ABRT }
ata9.00: configured for UDMA/100
ata9: EH complete
ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata9.00: irq_stat 0x00060002, device error via D2H FIS
ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
          res 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
ata9.00: status: { DRDY ERR }
ata9.00: error: { ABRT }
ata9.00: configured for UDMA/100
ata9: EH complete
ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata9.00: irq_stat 0x00060002, device error via D2H FIS
ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
          res 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
ata9.00: status: { DRDY ERR }
ata9.00: error: { ABRT }
ata9.00: configured for UDMA/100
ata9: EH complete
ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata9.00: irq_stat 0x00060002, device error via D2H FIS
ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
          res 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
ata9.00: status: { DRDY ERR }
ata9.00: error: { ABRT }
ata9.00: configured for UDMA/100
sd 8:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 8:0:0:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
         00 00 00 00 
sd 8:0:0:0: [sdb] Add. Sense: No additional sense information
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
ata9: EH complete
<..continues..>

I will go ahead and test this disk and sata-cable with both of the controlers on a different motherboard.

//tlund
