From: Brett Russ <russb@emc.com>
Subject: Re: libata AHCI support for Intel ICH6RW and ICH6R
Date: Fri, 03 Sep 2004 06:51:38 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <ch9iaa$cf8$1@sea.gmane.org>
References: <1094184596.16175.3.camel@unicorn.rpratap.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:15000 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269589AbUICKu5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Sep 2004 06:50:57 -0400
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1C3Bei-0000QH-00
	for <linux-ide@vger.kernel.org>; Fri, 03 Sep 2004 12:50:56 +0200
Received: from pseudo-nat-129.isus.emc.com ([128.221.197.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 03 Sep 2004 12:50:56 +0200
Received: from russb by pseudo-nat-129.isus.emc.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 03 Sep 2004 12:50:56 +0200
In-Reply-To: <1094184596.16175.3.camel@unicorn.rpratap.homelinux.org>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Ravi Pratap M wrote:
> My Dell Dimension 8400 machine has the latest Intel ICH6RW controller
> and I am running kernel 2.6.8.1. I was under the impression that
> libata's ata_piix driver now supports AHCI mode but when I set the BIOS
> to that setting, the kernel doesn't see anything.

I was going to send mail about this today :-)  Unfortunately not a mail 
about a solution but rather the same problem, likely because our 
controllers are just about identical.

Here are the details from my end:

kernel:

libata-2.6 bk pull from yesterday (20040902) (rev 2.6.9-rc1)

dmesg:

libata version 1.02 loaded.
ata_piix version 1.02
ACPI: PCI interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ata: 0x1f0 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xE088 irq 15
ATA: abnormal status 0x7F on port 0x177
ata1: disabling port
scsi0 : ata_piix

lspci -vv -xxx -d8086:2652:

0000:00:1f.2 Class 0106: Intel Corp. I/O Controller Hub SATA cc=raid 
(rev 03) (p
rog-if 01)
         Subsystem: Intel Corp.: Unknown device 344a
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 19
         Region 0: I/O ports at e880 [size=8]
         Region 1: I/O ports at e800 [size=4]
         Region 2: I/O ports at e480 [size=8]
         Region 3: I/O ports at e400 [size=4]
         Region 4: I/O ports at e080 [size=16]
         Region 5: Memory at feb3fc00 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [70] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 52 26 07 00 b0 02 03 01 06 01 00 00 00 00
10: 81 e8 00 00 01 e8 00 00 81 e4 00 00 01 e4 00 00
20: 81 e0 00 00 00 fc b3 fe 00 00 00 00 86 80 4a 34
30: 00 00 00 00 70 00 00 00 00 00 00 00 0b 02 00 00
40: 77 e3 77 e3 bb 00 00 00 0f 00 11 11 00 00 00 00
50: 00 00 00 00 f0 f0 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 02 40 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 70 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 80 00 ff 00 82 01 80 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 0f 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 03 00 00 00 00 00



This is with the BIOS in Enhanced-AHCI mode.  This kernel sees all (4) 
drives when running in Enhanced-non-AHCI mode.  I haven't tried 
compatibility mode with it.

I can also help debug and test,
BR

PS...I'm still wondering what magic is needed to turn on write cache on 
a SATA drive hooked up under libata in enhanced non-AHCI mode...see my 
previous post on this list.

