From: Damon Lynch <damonlynch@gmail.com>
Subject: ExpressCard compact flash card very slow
Date: Tue, 22 Feb 2011 19:01:13 -0600
Message-ID: <4D645C59.8090406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44500 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab1BWBBQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Feb 2011 20:01:16 -0500
Received: by wyg36 with SMTP id 36so381171wyg.19
        for <linux-ide@vger.kernel.org>; Tue, 22 Feb 2011 17:01:15 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

When using a Lexar ExpressCard CompactFlash (CF) reader in an 
ExpressCard slot, the speed of this high speed device is very slow 
(relatively speaking, of course).It performs at ~28MB/s instead of 
~80MB/s it should be with a fast CompactFlash card.

This is the product: 
http://www.lexar.com/products/lexar-professional-expresscard-compactflash-cf-reader?category=213

The CF card can run at UDMA/133, but is set to run at UDMA/33.

$dmesg

[ 1.687119] scsi0 : pata_jmicron
[ 1.692480] scsi1 : pata_jmicron
[ 1.692523] ata1: PATA max UDMA/100 cmd 0x4020 ctl 0x4014 bmdma 0x4000 
irq 19
[ 1.692525] ata2: PATA max UDMA/100 cmd 0x4018 ctl 0x4010 bmdma 0x4008 
irq 19
[ 1.870088] usb 1-6: new high speed USB device using ehci_hcd and address 3
[ 1.890676] ata1.00: CFA: TRANSCEND, 20091215, max UDMA/133
[ 1.890678] ata1.00: 125059072 sectors, multi 0: LBA
[ 1.890681] ata1.00: limited to UDMA/33 due to 40-wire cable
[ 1.930831] ata1.00: configured for UDMA/33
[ 1.930984] scsi 0:0:0:0: Direct-Access ATA TRANSCEND 2009 PQ: 0 ANSI: 5
[ 1.931132] sd 0:0:0:0: [sda] 125059072 512-byte logical blocks: (64.0 
GB/59.6 GiB)
[ 1.931144] sd 0:0:0:0: Attached scsi generic sg0 type 0
[ 1.931181] sd 0:0:0:0: [sda] Write Protect is off
[ 1.931184] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[ 1.931371] sd 0:0:0:0: [sda] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[ 1.932525] sda: sda1
[ 1.932904] sd 0:0:0:0: [sda] Attached SCSI disk

$sudo lspci -vvv -xxx

05:00.0 IDE interface: JMicron Technology Corp. JMB368 IDE controller 
(prog-if 85 [Master SecO PriO])
     Subsystem: JMicron Technology Corp. JMB368 IDE controller
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 19
     Region 0: I/O ports at 4020 [size=8]
     Region 1: I/O ports at 4014 [size=4]
     Region 2: I/O ports at 4018 [size=8]
     Region 3: I/O ports at 4010 [size=4]
     Region 4: I/O ports at 4000 [size=16]
     [virtual] Expansion ROM at f2900000 [disabled] [size=64K]
     Capabilities: [68] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [50] Express (v1) Legacy Endpoint, MSI 01
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s, Latency 
L0 <1us, L1 <16us
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
     Capabilities: [70] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Kernel driver in use: pata_jmicron
     Kernel modules: pata_jmicron
00: 7b 19 68 23 07 01 10 00 00 85 01 01 10 00 00 00
10: 21 40 00 00 15 40 00 00 19 40 00 00 11 40 00 00
20: 01 40 00 00 00 00 00 00 00 00 00 00 7b 19 68 23
30: 00 00 00 00 68 00 00 00 00 00 00 00 0b 01 00 00
40: bd 00 c0 81 a8 08 80 e0 00 00 00 00 00 00 00 00
50: 10 70 11 02 00 00 00 00 00 20 08 00 11 44 02 01
60: 40 00 11 10 00 00 00 00 01 50 02 00 00 00 00 00
70: 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 a0 01 00 00 0f 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 31 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00
c0: c3 8b 38 70 03 45 02 00 00 00 00 00 00 00 00 00
d0: 18 00 00 80 00 00 00 10 02 40 eb 00 00 00 00 01
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


$ sudo hdparm -I /dev/sda

/dev/sda:

CompactFlash ATA device
     Model Number:       TRANSCEND
     Serial Number:      20100521    000008F4
     Firmware Revision:  20091215
Standards:
     Likely used: 6
Configuration:
     Logical        max    current
     cylinders    16383    65535
     heads        15    15
     sectors/track    63    63
     --
     CHS current addressable sectors:   61930575
     LBA    user addressable sectors:  125059072
     Logical/Physical Sector size:           512 bytes
     device size with M = 1024*1024:       61064 MBytes
     device size with M = 1000*1000:       64030 MBytes (64 GB)
     cache/buffer size  = 1 KBytes (type=DualPort)
Capabilities:
     LBA, IORDY(can be disabled)
     bytes avail on r/w long: 4
     Standby timer values: spec'd by Vendor
     R/W multiple sector transfer: Max = 1    Current = 0
     Advanced power management level: disabled
     DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6
          Cycle time: min=120ns recommended=120ns
     PIO: pio0 pio1 pio2 pio3 pio4
          Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
     Enabled    Supported:
        *    SMART feature set
             Security Mode feature set
             Power Management feature set
             Write cache
             WRITE_BUFFER command
             READ_BUFFER command
             NOP cmd
             CFA feature set
             Advanced Power Management feature set
             Mandatory FLUSH_CACHE
        *    CFA advanced modes: pio5 *pio6 mdma3 mdma4
        *    CFA Power Level 1  (max 500mA)
Security:
     Master password revision code = 65534
         supported
     not    enabled
     not    locked
     not    frozen
     not    expired: security count
     not    supported: enhanced erase
     6min for SECURITY ERASE UNIT.
HW reset results:
     CBLID- above Vih
     Device num = 0
Integrity word not set (found 0x0000, expected 0x5da5)

$ sudo hdparm --Istdout /dev/sda

/dev/sda:
044a 3fff 0000 000f 0000 0240 003f 0774
4000 0000 3230 3130 3035 3231 2020 2020
3030 3030 3038 4634 0002 0002 0004 3230
3039 3132 3135 5452 414e 5343 454e 4420
2020 2020 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8001
0000 0f00 0000 0200 0000 0007 ffff 000f
003f fc4f 03b0 0100 4000 0774 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 702b 500c 4003 0001 0000 0003
047f 0003 0000 0000 fffe 604f 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
81f4 0000 0000 0092 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

Upstream kernel, on Ubuntu 11.04 alpha:

$ cat /proc/version
Linux version 2.6.38-020638rc6-generic (root@zinc) (gcc version 4.2.3 
(Ubuntu 4.2.3-2ubuntu7)) #201102220910 SMP Tue Feb 22 09:12:52 UTC 2011
