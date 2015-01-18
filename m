From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Re: Queued TRIM without NCQ support
Date: Sun, 18 Jan 2015 21:10:19 +0100
Message-ID: <54BC132B.3020602@pr.hu>
References: <54AE6A90.7030704@pr.hu>	<54BB4FD1.5000506@gmail.com>	<54BB6BCD.6050409@pr.hu> <CADLC3L0kXCpTmh0WUhPiDffsAVMiqWOngtmrfONLa_D1mwtzOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail9.pr.hu ([87.242.0.9]:56827 "EHLO mail9.pr.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbbARUKh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Jan 2015 15:10:37 -0500
In-Reply-To: <CADLC3L0kXCpTmh0WUhPiDffsAVMiqWOngtmrfONLa_D1mwtzOA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Steve Tilden <stilden@sicom.com>

2015-01-18 20:47 keltez=C3=A9ssel, Robert Hancock =C3=ADrta:
> On Sun, Jan 18, 2015 at 2:16 AM, Boszormenyi Zoltan <zboszor@pr.hu> w=
rote:
>> 2015-01-18 07:16 keltez=C3=A9ssel, Robert Hancock =C3=ADrta:
>>> On 08/01/15 05:31 AM, Boszormenyi Zoltan wrote:
>>>> Hi,
>>>>
>>>> I came across an SSD (Transcend SSD370) that I cannot
>>>> successfully e2fsck/fstrim when connected to an SATA2 interface.
>>>>
>>>> The problem is:
>>>>
>>>> [80839.972834] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 acti=
on 0x6 frozen
>>>> [80839.972845] ata9.00: failed command: DATA SET MANAGEMENT
>>>> [80839.972855] ata9.00: cmd 06/01:01:00:00:00/00:00:00:00:00/a0 ta=
g 8 dma 512 out
>>>>           res 40/00:ff:16:62:86/00:00:00:00:00/40 Emask 0x4 (timeo=
ut)
>>>> [80839.972861] ata9.00: status: { DRDY }
>>>> [80839.972868] ata9: hard resetting link
>>>> [80841.349941] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
00)
>>>> [80841.382029] ata9.00: configured for UDMA/133
>>>> [80841.382046] ata9: EH complete
>>>>
>>>> However, when connected to an SATA3 interface, both e2fsck and fst=
rim succeeds.
>>>>
>>>> The difference is below.
>>>>
>>>> Over SATA2:
>>>>
>>>> [80591.741191] ata9.00: ATA-9: TS64GSSD370, N0815B, max UDMA/133
>>>> [80591.741199] ata9.00: 125045424 sectors, multi 1: LBA48
>>>>
>>>> Over SATA3:
>>>>
>>>> [83087.473254] ata5.00: ATA-9: TS64GSSD370, N0815B, max UDMA/133
>>>> [83087.473267] ata5.00: 125045424 sectors, multi 1: LBA48 NCQ (dep=
th 31/32), AA
>>>> [83087.473550] ata5.00: configured for UDMA/133
>>>>
>>>> So, the disk doesn't announce NCQ support over SATA2, only over SA=
TA3.
>>>> But e2fsck still wanted to use TRIM by default and the kernel thin=
ks
>>>> it's a good idea to send TRIM over NCQ when NCQ support is missing=
=2E
>>> I don't think this is the issue, because if it was trying to use qu=
eued trim it would be
>>> sending SEND FPDMA QUEUED, not the DATA SET MANAGEMENT command. Wha=
t kind of SATA2
>>> interface are you using in this case, exactly?
>> This is a Sharkoon SATA QUICKPORT DUO II eSATA bay attached to
>> the eSATA interface to my ASUS M5A99X EVO mainboard, which
>> is on a JMicron JMB362 controller.
>>
>> FYI, a Samsung 840 EVO works on the same eSATA with TRIM, both
>> mke2fs and fstrim.
>>
>> The support at Transcend confirmed the problem over SATA2 in the mea=
ntime.
> If we could find more details about what the problem was, we could
> likely add a quirk to disable trim support. However, it's not clear i=
f
> it's actually SATA2 (i.e. 3Gbps) specific, or maybe it's something to
> do with the JMicron controller or something.

All I found in dmesg was the failed DATA SET MANAGEMENT command,
both during mke2fs and fstrim.

This is my motherboard: http://www.asus.com/Motherboards/M5A99X_EVO/spe=
cifications/

Currently that disk is not attached to my desktop machine.

Some more details:

# lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI t=
o PCI bridge
(external gfx0 port B) (rev 02)
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O Memory =
Management Unit (IOMMU)
00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to=
 PCI bridge (PCI
express gpp port B)
00:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to=
 PCI bridge (PCI
express gpp port D)
00:05.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to=
 PCI bridge (PCI
express gpp port E)
00:06.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to=
 PCI bridge (PCI
express gpp port F)
00:07.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to=
 PCI bridge (PCI
express gpp port G)
00:0a.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to=
 PCI bridge
(external gfx1 port A)
00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/S=
B8x0/SB9x0 SATA
Controller [AHCI mode] (rev 40)
00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB=
8x0/SB9x0 USB OHCI0
Controller
00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB=
8x0/SB9x0 USB EHCI
Controller
00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB=
8x0/SB9x0 USB OHCI0
Controller
00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB=
8x0/SB9x0 USB EHCI
Controller
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Contr=
oller (rev 42)
00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 Azal=
ia (Intel HDA) (rev 40)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/=
SB9x0 LPC host
controller (rev 40)
00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI to=
 PCI Bridge (rev 40)
00:14.5 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB=
8x0/SB9x0 USB OHCI2
Controller
00:16.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB=
8x0/SB9x0 USB OHCI0
Controller
00:16.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB=
8x0/SB9x0 USB EHCI
Controller
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Proc=
essor Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Proc=
essor Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Proc=
essor Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Proc=
essor Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Proc=
essor Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Proc=
essor Function 5
01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/AT=
I] Curacao XT
[Radeon R9 270X]
01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde=
/Pitcairn HDMI
Audio [Radeon HD 7700/7800 Series]
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/81=
68/8411 PCI Express
Gigabit Ethernet Controller (rev 06)
03:00.0 USB controller: ASMedia Technology Inc. ASM1042 SuperSpeed USB =
Host Controller
04:00.0 SATA controller: JMicron Technology Corp. JMB362 SATA Controlle=
r (rev 10)
05:00.0 USB controller: ASMedia Technology Inc. ASM1042 SuperSpeed USB =
Host Controller
06:00.0 SATA controller: JMicron Technology Corp. JMB362 SATA Controlle=
r (rev 10)
07:05.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 165=
50 UART) (rev 01)
07:06.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6306/7/8 [Fire I=
I(M)] IEEE 1394
OHCI Controller (rev c0)

# lspci -s 04:00.0 -vvvvxxx
04:00.0 SATA controller: JMicron Technology Corp. JMB362 SATA Controlle=
r (rev 10) (prog-if
01 [AHCI 1.0])
    Subsystem: ASUSTeK Computer Inc. P8P67 Deluxe Motherboard
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR-
=46astB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort-
>SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 29
    Region 0: I/O ports at c040 [size=3D8]
    Region 1: I/O ports at c030 [size=3D4]
    Region 2: I/O ports at c020 [size=3D8]
    Region 3: I/O ports at c010 [size=3D4]
    Region 4: I/O ports at c000 [size=3D16]
    Region 5: Memory at fe810000 (32-bit, non-prefetchable) [size=3D512=
]
    [virtual] Expansion ROM at fe800000 [disabled] [size=3D64K]
    Capabilities: [8c] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3=
hot+,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [50] Express (v1) Legacy Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns=
, L1 <1us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupp=
orted-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- Tra=
nsPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit =
Latency L0s <1us,
L1 <16us
            ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLAc=
tive- BWMgmt- ABWMgmt-
    Kernel driver in use: ahci
00: 7b 19 62 23 07 00 10 00 10 01 06 01 10 00 00 00
10: 41 c0 00 00 31 c0 00 00 21 c0 00 00 11 c0 00 00
20: 01 c0 00 00 00 00 81 fe 00 00 00 00 43 10 60 84
30: 00 00 00 00 8c 00 00 00 00 00 00 00 03 01 00 00
40: b1 a1 02 80 08 08 ff e4 20 00 f0 05 00 00 00 00
50: 10 00 11 00 00 80 00 00 00 20 0a 00 11 4c 02 00
60: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 10 00 00 00 00 00 00 00 00 01 50 03 40
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 18 00 00 80 1c 00 00 10 00 00 eb 00 00 00 00 01
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 34 40 50 00 00 00 00 00 00 00 00 00 00 00 10 00


# lspci -s 06:00.0 -vvvvxxx
06:00.0 SATA controller: JMicron Technology Corp. JMB362 SATA Controlle=
r (rev 10) (prog-if
01 [AHCI 1.0])
    Subsystem: ASUSTeK Computer Inc. P8P67 Deluxe Motherboard
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR-
=46astB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort-
>SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 30
    Region 0: I/O ports at b040 [size=3D8]
    Region 1: I/O ports at b030 [size=3D4]
    Region 2: I/O ports at b020 [size=3D8]
    Region 3: I/O ports at b010 [size=3D4]
    Region 4: I/O ports at b000 [size=3D16]
    Region 5: Memory at fe610000 (32-bit, non-prefetchable) [size=3D512=
]
    [virtual] Expansion ROM at fe600000 [disabled] [size=3D64K]
    Capabilities: [8c] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3=
hot+,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [50] Express (v1) Legacy Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns=
, L1 <1us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupp=
orted-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- Tra=
nsPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit =
Latency L0s <1us,
L1 <16us
            ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLAc=
tive- BWMgmt- ABWMgmt-
    Kernel driver in use: ahci
00: 7b 19 62 23 07 00 10 00 10 01 06 01 10 00 00 00
10: 41 b0 00 00 31 b0 00 00 21 b0 00 00 11 b0 00 00
20: 01 b0 00 00 00 00 61 fe 00 00 00 00 43 10 60 84
30: 00 00 00 00 8c 00 00 00 00 00 00 00 0b 01 00 00
40: b1 a1 02 80 08 08 ff e4 20 00 f0 05 00 00 00 00
50: 10 00 11 00 00 80 00 00 00 20 0a 00 11 4c 02 00
60: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 10 00 00 00 00 00 00 00 00 01 50 03 40
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 18 00 00 80 1c 00 00 10 00 00 eb 00 00 00 00 01
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 34 40 50 00 00 00 00 00 00 00 00 00 00 00 10 00

Every SATA controller is AHCI:

[    1.406335] ahci 0000:00:11.0: version 3.0
[    1.406489] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 6 Gbp=
s 0x3f impl SATA mode
[    1.406493] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo=
 pmp pio slum part
[    1.407440] scsi host0: ahci
[    1.407613] scsi host1: ahci
[    1.407735] scsi host2: ahci
[    1.407858] scsi host3: ahci
[    1.408005] scsi host4: ahci
[    1.408126] scsi host5: ahci
[    1.408176] ata1: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb=
0b100 irq 19
[    1.408179] ata2: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb=
0b180 irq 19
[    1.408181] ata3: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb=
0b200 irq 19
[    1.408183] ata4: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb=
0b280 irq 19
[    1.408185] ata5: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb=
0b300 irq 19
[    1.408187] ata6: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb=
0b380 irq 19
[    1.408323] ahci 0000:04:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbp=
s 0x3 impl SATA mode
[    1.408326] ahci 0000:04:00.0: flags: 64bit ncq pm led clo pmp pio s=
lum part
[    1.408706] scsi host6: ahci
[    1.408827] scsi host7: ahci
[    1.408881] ata7: SATA max UDMA/133 abar m512@0xfe810000 port 0xfe81=
0100 irq 29
[    1.408884] ata8: SATA max UDMA/133 abar m512@0xfe810000 port 0xfe81=
0180 irq 29
[    1.409003] ahci 0000:06:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbp=
s 0x3 impl SATA mode
[    1.409006] ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio s=
lum part
[    1.409362] scsi host8: ahci
[    1.409488] scsi host9: ahci
[    1.409539] ata9: SATA max UDMA/133 abar m512@0xfe610000 port 0xfe61=
0100 irq 30
[    1.409542] ata10: SATA max UDMA/133 abar m512@0xfe610000 port 0xfe6=
10180 irq 30

If you need anything else, just tell.

Best regards,
Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi

