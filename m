From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [kekcsibe@gmail.com: PROBLEM: Pioneer DVD-RW DVR-112D does not
 work since linux 2.6.29]
Date: Fri, 29 Jan 2010 05:48:34 +0100
Message-ID: <20100129044834.GB25869@liondog.tnic>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:49048 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253Ab0A2Esl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2010 23:48:41 -0500
Received: by ewy19 with SMTP id 19so1559510ewy.21
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2010 20:48:39 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Skrabák,

I'm forwarding your mail to linux-ide where all those issues should be
reported. Also, it would be helpful if you sent the whole dmesg output
of the failing kernel.

Reattaching your files too.

Thanks.

----- Forwarded message from Skrabak Csaba <kekcsibe@gmail.com> -----

From: Skrabak Csaba <kekcsibe@gmail.com>
To: Borislav Petkov <petkovbb@gmail.com>
Date: Fri, 29 Jan 2010 04:27:08 +0100
Subject: PROBLEM: Pioneer DVD-RW DVR-112D does not work since linux 2.6.29
Message-ID: <b7a1ac7c1001281927g13323d38tcd71271aee0137ca@mail.gmail.com>

Dear Maintainer,

I have found your e-mail address in the MAINTAINERS file of the linux
kernel 2.6.32.6 source.

I have a problem getting my DVD recorder working. I have been using
2.6.22 with no problem at all. Later I have tried 2.6.29, which
produced funny issues: booting up netinstaller CD worked just fine,
but when coming to loading the drivers, DVD stopped working, so it
could not install the packages. I also tried a Windows XP install CD,
which also booted fine, but after installing, Windows could not use
the drive. I kept on using the old 2.6.22 linux. But the newest
versions of udev and other packages found in Debian unstable
repositories don't seem to be compatible any longer with my old but
working kernel. So I decided to try if the problem has been fixed in
2.6.32.6 and my DVD drive could work again like it does with 2.6.22.
Now I experience the same problems, which in detail are:

Mount outputs attached dvd.txt and does not mount. Gnome also does not
mount CD-ROM Device (shows error message).

Other info from /proc:

tchibo@kazimir:~$ cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 12
model name	: AMD Athlon(tm) 64 Processor 2800+
stepping	: 0
cpu MHz		: 1808.418
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext
3dnow
bogomips	: 3616.83
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

tchibo@kazimir:~$ cat /proc/modules
udf 61319 0 - Live 0xf807a000
crc_itu_t 953 1 udf, Live 0xf803a000
snd_intel8x0 18955 2 - Live 0xf808c000
snd_ac97_codec 77820 1 snd_intel8x0, Live 0xf8065000
pcspkr 1127 0 - Live 0xf8040000
ac97_bus 658 1 snd_ac97_codec, Live 0xf8037000
tchibo@kazimir:~$ cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-0060 : keyboard
0064-0064 : keyboard
0070-0073 : rtc0
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:08.0
  0170-0177 : pata_amd
01f0-01f7 : 0000:00:08.0
  01f0-01f7 : pata_amd
0290-0297 : pnp 00:03
0376-0376 : 0000:00:08.0
  0376-0376 : pata_amd
03c0-03df : vga+
03f6-03f6 : 0000:00:08.0
  03f6-03f6 : pata_amd
04d0-04d1 : pnp 00:03
0a78-0a7b : pnp 00:03
0b78-0b7b : pnp 00:03
0bbc-0bbf : pnp 00:03
0cf8-0cff : PCI conf1
0e78-0e7b : pnp 00:03
0f78-0f7b : pnp 00:03
0fbc-0fbf : pnp 00:03
4000-407f : pnp 00:00
  4000-4003 : ACPI PM1a_EVT_BLK
  4004-4005 : ACPI PM1a_CNT_BLK
  4008-400b : ACPI PM_TMR
  4020-4027 : ACPI GPE0_BLK
4080-40ff : pnp 00:00
4400-447f : pnp 00:00
4480-44ff : pnp 00:00
  44a0-44af : ACPI GPE1_BLK
4800-487f : pnp 00:00
4880-48ff : pnp 00:00
4c00-4c3f : 0000:00:01.1
4c40-4c7f : 0000:00:01.1
9000-9fff : PCI Bus 0000:01
  9000-90ff : 0000:01:00.0
a000-afff : PCI Bus 0000:02
  a000-a0ff : 0000:02:07.0
    a000-a0ff : 8139too
b400-b407 : 0000:00:05.0
  b400-b407 : forcedeth
b800-b8ff : 0000:00:06.0
  b800-b8ff : NVidia CK8S
bc00-bc7f : 0000:00:06.0
  bc00-bc7f : NVidia CK8S
c800-c81f : 0000:00:01.1
f000-f00f : 0000:00:08.0
  f000-f00f : pata_amd
tchibo@kazimir:~$ cat /proc/iomem
00000000-0000ffff : reserved
00010000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ccfff : Video ROM
000d4000-000d57ff : Adapter ROM
000d5800-000d7fff : pnp 00:01
000f0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-7ffeffff : System RAM
  01000000-013d0869 : Kernel code
  013d086a-015c626b : Kernel data
  01617000-016866b3 : Kernel bss
7fff0000-7fff2fff : ACPI Non-volatile Storage
7fff3000-7fffffff : ACPI Tables
80000000-800fffff : PCI Bus 0000:02
  80000000-8000ffff : 0000:02:07.0
d0000000-dfffffff : PCI Bus 0000:01
  d0000000-d7ffffff : 0000:01:00.0
  d8000000-dfffffff : 0000:01:00.1
e0000000-e7ffffff : 0000:00:00.0
  e0000000-e7ffffff : aperture
e8000000-e9ffffff : PCI Bus 0000:01
  e8000000-e801ffff : 0000:01:00.0
  e9000000-e900ffff : 0000:01:00.1
  e9010000-e901ffff : 0000:01:00.0
ea000000-ebffffff : PCI Bus 0000:02
  eb000000-eb0000ff : 0000:02:07.0
    eb000000-eb0000ff : 8139too
ec000000-ec000fff : 0000:00:05.0
  ec000000-ec000fff : forcedeth
ec001000-ec001fff : 0000:00:06.0
  ec001000-ec001fff : NVidia CK8S
ec003000-ec003fff : 0000:00:02.0
  ec003000-ec003fff : ohci_hcd
ec004000-ec004fff : 0000:00:02.1
  ec004000-ec004fff : ohci_hcd
ec005000-ec0050ff : 0000:00:02.2
  ec005000-ec0050ff : ehci_hcd
fec00000-fec00fff : reserved
  fec00000-fec00fff : pnp 00:01
fee00000-feefffff : reserved
  fee00000-feefffff : pnp 00:01
fefffc00-feffffff : reserved
fff80000-fff80fff : pnp 00:01
fff90000-fffbffff : pnp 00:01
fffed000-fffeffff : pnp 00:01
ffff0000-ffffffff : reserved
  ffff0000-ffffffff : pnp 00:01
tchibo@kazimir:~$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG SP0802N  Rev: TK10
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: PIONEER  Model: DVD-RW  DVR-112D Rev: 1.21
  Type:   CD-ROM                           ANSI  SCSI revision: 05

The attached lspci.txt is the output of lspci -vvv, while .config.bak
is the kernel config file I used when compiling. /etc/fstab also in
attachment.

Can it be that my DVD drive has in fact a minor defect, but the old
2.6.22 kernel driver just overlooked that? Were there any changes in
the driver since then that could make the driver pickier? Can I do
something to overcome it (maybe a config parameter, fstab corrections,
udev reconfiguration) or must I wait until a new kernel version comes?

Using web search I found plenty of questions dealing with the same
error message but all they could answer was that the DVD was dead. But
it is definitely not.

Please tell me if you know something that or somebody who could help
me solving my problem.

Thank you for your support.

-- 
Skrabák!

kazimir:~# mount /cdrom
sr 1:0:0:0: [sr0] Result: hostbyte=0x00 driverbyte=0x08
sr 1:0:0:0: [sr0] Sense Key : 0x5 [current]
sr 1:0:0:0: [sr0] <<vendor>> ASC=0xa8 ASCQ=0x1ASC=0xa8 ASCQ=0x1
sr 1:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 10 00 00 02 00
end_request: I/O error, dev sr0, sector 64
Buffer I/O error on device sr0, logical block 8
sr 1:0:0:0: [sr0] Result: hostbyte=0x00 driverbyte=0x08
sr 1:0:0:0: [sr0] Sense Key : 0x5 [current]
sr 1:0:0:0: [sr0] <<vendor>> ASC=0xa8 ASCQ=0x1ASC=0xa8 ASCQ=0x1
sr 1:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 10 00 00 02 00
end_request: I/O error, dev sr0, sector 64
Buffer I/O error on device sr0, logical block 8
sr 1:0:0:0: [sr0] Result: hostbyte=0x00 driverbyte=0x08
sr 1:0:0:0: [sr0] Sense Key : 0x5 [current]
sr 1:0:0:0: [sr0] <<vendor>> ASC=0xa8 ASCQ=0x1ASC=0xa8 ASCQ=0x1
sr 1:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 10 00
end_request: I/O error, dev sr0, sector 0
Buffer I/O error on device sr0, logical block 0
Buffer I/O error on device sr0, logical block 1
Buffer I/O error on device sr0, logical block 2
Buffer I/O error on device sr0, logical block 3
Buffer I/O error on device sr0, logical block 4
Buffer I/O error on device sr0, logical block 5
Buffer I/O error on device sr0, logical block 6
Buffer I/O error on device sr0, logical block 7
sr 1:0:0:0: [sr0] Result: hostbyte=0x00 driverbyte=0x08
sr 1:0:0:0: [sr0] Sense Key : 0x5 [current]
sr 1:0:0:0: [sr0] <<vendor>> ASC=0xa8 ASCQ=0x1ASC=0xa8 ASCQ=0x1
sr 1:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 12 00 00 2e 00
end_request: I/O error, dev sr0, sector 72
Buffer I/O error on device sr0, logical block 9
Buffer I/O error on device sr0, logical block 10
sr 1:0:0:0: [sr0] Result: hostbyte=0x00 driverbyte=0x08
sr 1:0:0:0: [sr0] Sense Key : 0x5 [current]
sr 1:0:0:0: [sr0] <<vendor>> ASC=0xa8 ASCQ=0x1ASC=0xa8 ASCQ=0x1
sr 1:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 01 00
end_request: I/O error, dev sr0, sector 0
FAT: unable to read boot sector
mount: nem lehet olvasni a(z) /dev/sr0 szuperblokkját
kazimir:~# sr 1:0:0:0: [sr0] Result: hostbyte=0x00 driverbyte=0x08
sr 1:0:0:0: [sr0] Sense Key : 0x5 [current]
sr 1:0:0:0: [sr0] <<vendor>> ASC=0xa8 ASCQ=0x1ASC=0xa8 ASCQ=0x1
sr 1:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
end_request: I/O error, dev sr0, sector 0
Buffer I/O error on device sr0, logical block 0
Buffer I/O error on device sr0, logical block 1

tchibo@kazimir:/usr/src/linux-2.6.32.6$ lspci -vvv
00:00.0 Host bridge: nVidia Corporation nForce3 250Gb Host Bridge (rev a1)
	Subsystem: Micro-Star International Co., Ltd. Device 0300
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: <access denied>
	Kernel driver in use: agpgart-amd64

00:01.0 ISA bridge: nVidia Corporation nForce3 250Gb LPC Bridge (rev a2)
	Subsystem: Micro-Star International Co., Ltd. Device 0300
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management (rev a1)
	Subsystem: Micro-Star International Co., Ltd. Device 0300
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at c800 [size=32]
	Region 4: I/O ports at 4c00 [size=64]
	Region 5: I/O ports at 4c40 [size=64]
	Capabilities: <access denied>

00:02.0 USB Controller: nVidia Corporation CK8S USB Controller (rev a1) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd. Device 0300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at ec003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: ohci_hcd

00:02.1 USB Controller: nVidia Corporation CK8S USB Controller (rev a1) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd. Device 0300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 3
	Region 0: Memory at ec004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: ohci_hcd

00:02.2 USB Controller: nVidia Corporation nForce3 EHCI USB 2.0 Controller (rev a2) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd. Device 0300
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 3
	Region 0: Memory at ec005000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <access denied>
	Kernel driver in use: ehci_hcd

00:05.0 Bridge: nVidia Corporation CK8S Ethernet Controller (rev a2)
	Subsystem: Micro-Star International Co., Ltd. Device 0300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at b400 [size=8]
	Capabilities: <access denied>
	Kernel driver in use: forcedeth

00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb AC'97 Audio Controller (rev a1)
	Subsystem: Micro-Star International Co., Ltd. Device 7585
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 7
	Region 0: I/O ports at b800 [size=256]
	Region 1: I/O ports at bc00 [size=128]
	Region 2: Memory at ec001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: Intel ICH

00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA Controller (v2.5) (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd. Device 0300
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [size=1]
	Region 4: I/O ports at f000 [size=16]
	Capabilities: <access denied>
	Kernel driver in use: pata_amd

00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI Bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 16
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=10
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: d0000000-dfffffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI Bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=128
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: ea000000-ebffffff
	Prefetchable memory behind bridge: 80000000-800fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr+ DiscTmrStat- DiscTmrSERREn-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: <access denied>

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: k8temp

01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (rev 01) (prog-if 00 [VGA controller])
	Subsystem: PC Partner Limited Device 0260
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (2000ns min), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at e9010000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at e8000000 [disabled] [size=128K]
	Capabilities: <access denied>

01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (Secondary) (rev 01)
	Subsystem: PC Partner Limited Device 0261
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at d8000000 (32-bit, prefetchable) [disabled] [size=128M]
	Region 1: Memory at e9000000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: <access denied>

02:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a000 [size=256]
	Region 1: Memory at eb000000 (32-bit, non-prefetchable) [size=256]
	[virtual] Expansion ROM at 80000000 [disabled] [size=64K]
	Capabilities: <access denied>
	Kernel driver in use: 8139too




----- End forwarded message -----

-- 
Regards/Gruss,
    Boris.

--ZGiS0Q5IWpPtfppv
Content-Type: application/x-trash
Content-Disposition: attachment; filename="config.bak"
Content-Transfer-Encoding: quoted-printable

#=0A# Automatically generated make config: don't edit=0A# Linux kernel vers=
ion: 2.6.32.6=0A# Fri Jan 29 00:47:05 2010=0A#=0A# CONFIG_64BIT is not set=
=0ACONFIG_X86_32=3Dy=0A# CONFIG_X86_64 is not set=0ACONFIG_X86=3Dy=0ACONFIG=
_OUTPUT_FORMAT=3D"elf32-i386"=0ACONFIG_ARCH_DEFCONFIG=3D"arch/x86/configs/i=
386_defconfig"=0ACONFIG_GENERIC_TIME=3Dy=0ACONFIG_GENERIC_CMOS_UPDATE=3Dy=
=0ACONFIG_CLOCKSOURCE_WATCHDOG=3Dy=0ACONFIG_GENERIC_CLOCKEVENTS=3Dy=0ACONFI=
G_LOCKDEP_SUPPORT=3Dy=0ACONFIG_STACKTRACE_SUPPORT=3Dy=0ACONFIG_HAVE_LATENCY=
TOP_SUPPORT=3Dy=0ACONFIG_MMU=3Dy=0ACONFIG_ZONE_DMA=3Dy=0ACONFIG_GENERIC_ISA=
_DMA=3Dy=0ACONFIG_GENERIC_IOMAP=3Dy=0ACONFIG_GENERIC_BUG=3Dy=0ACONFIG_GENER=
IC_HWEIGHT=3Dy=0ACONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy=0A# CONFIG_RWSEM_GENERIC_S=
PINLOCK is not set=0ACONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0ACONFIG_ARCH_HAS_C=
PU_IDLE_WAIT=3Dy=0ACONFIG_GENERIC_CALIBRATE_DELAY=3Dy=0A# CONFIG_GENERIC_TI=
ME_VSYSCALL is not set=0ACONFIG_ARCH_HAS_CPU_RELAX=3Dy=0ACONFIG_ARCH_HAS_DE=
FAULT_IDLE=3Dy=0ACONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy=0ACONFIG_HAVE_SETUP_PE=
R_CPU_AREA=3Dy=0ACONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy=0ACONFIG_NEED_PE=
R_CPU_PAGE_FIRST_CHUNK=3Dy=0A# CONFIG_HAVE_CPUMASK_OF_CPU_MAP is not set=0A=
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy=0ACONFIG_ARCH_SUSPEND_POSSIBLE=3Dy=0A#=
 CONFIG_ZONE_DMA32 is not set=0ACONFIG_ARCH_POPULATES_NODE_MAP=3Dy=0A# CONF=
IG_AUDIT_ARCH is not set=0ACONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=3Dy=0ACO=
NFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy=0ACONFIG_GENERIC_HARDIRQS=3Dy=0ACONF=
IG_GENERIC_HARDIRQS_NO__DO_IRQ=3Dy=0ACONFIG_GENERIC_IRQ_PROBE=3Dy=0ACONFIG_=
X86_32_LAZY_GS=3Dy=0ACONFIG_KTIME_SCALAR=3Dy=0ACONFIG_DEFCONFIG_LIST=3D"/li=
b/modules/$UNAME_RELEASE/.config"=0ACONFIG_CONSTRUCTORS=3Dy=0A=0A#=0A# Gene=
ral setup=0A#=0ACONFIG_EXPERIMENTAL=3Dy=0ACONFIG_BROKEN_ON_SMP=3Dy=0ACONFIG=
_INIT_ENV_ARG_LIMIT=3D32=0ACONFIG_LOCALVERSION=3D""=0A# CONFIG_LOCALVERSION=
_AUTO is not set=0ACONFIG_HAVE_KERNEL_GZIP=3Dy=0ACONFIG_HAVE_KERNEL_BZIP2=
=3Dy=0ACONFIG_HAVE_KERNEL_LZMA=3Dy=0ACONFIG_KERNEL_GZIP=3Dy=0A# CONFIG_KERN=
EL_BZIP2 is not set=0A# CONFIG_KERNEL_LZMA is not set=0ACONFIG_SWAP=3Dy=0AC=
ONFIG_SYSVIPC=3Dy=0ACONFIG_SYSVIPC_SYSCTL=3Dy=0ACONFIG_POSIX_MQUEUE=3Dy=0AC=
ONFIG_POSIX_MQUEUE_SYSCTL=3Dy=0ACONFIG_BSD_PROCESS_ACCT=3Dy=0A# CONFIG_BSD_=
PROCESS_ACCT_V3 is not set=0A# CONFIG_TASKSTATS is not set=0A# CONFIG_AUDIT=
 is not set=0A=0A#=0A# RCU Subsystem=0A#=0ACONFIG_TREE_RCU=3Dy=0A# CONFIG_T=
REE_PREEMPT_RCU is not set=0A# CONFIG_RCU_TRACE is not set=0ACONFIG_RCU_FAN=
OUT=3D32=0A# CONFIG_RCU_FANOUT_EXACT is not set=0A# CONFIG_TREE_RCU_TRACE i=
s not set=0A# CONFIG_IKCONFIG is not set=0ACONFIG_LOG_BUF_SHIFT=3D18=0ACONF=
IG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy=0ACONFIG_GROUP_SCHED=3Dy=0ACONFIG_FAIR_GRO=
UP_SCHED=3Dy=0A# CONFIG_RT_GROUP_SCHED is not set=0ACONFIG_USER_SCHED=3Dy=
=0A# CONFIG_CGROUP_SCHED is not set=0A# CONFIG_CGROUPS is not set=0A# CONFI=
G_SYSFS_DEPRECATED_V2 is not set=0ACONFIG_RELAY=3Dy=0ACONFIG_NAMESPACES=3Dy=
=0ACONFIG_UTS_NS=3Dy=0ACONFIG_IPC_NS=3Dy=0ACONFIG_USER_NS=3Dy=0ACONFIG_PID_=
NS=3Dy=0ACONFIG_NET_NS=3Dy=0ACONFIG_BLK_DEV_INITRD=3Dy=0ACONFIG_INITRAMFS_S=
OURCE=3D""=0ACONFIG_RD_GZIP=3Dy=0ACONFIG_RD_BZIP2=3Dy=0ACONFIG_RD_LZMA=3Dy=
=0ACONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy=0ACONFIG_SYSCTL=3Dy=0ACONFIG_ANON_INODES=
=3Dy=0A# CONFIG_EMBEDDED is not set=0ACONFIG_UID16=3Dy=0ACONFIG_SYSCTL_SYSC=
ALL=3Dy=0ACONFIG_KALLSYMS=3Dy=0ACONFIG_KALLSYMS_EXTRA_PASS=3Dy=0ACONFIG_HOT=
PLUG=3Dy=0ACONFIG_PRINTK=3Dy=0ACONFIG_BUG=3Dy=0ACONFIG_ELF_CORE=3Dy=0ACONFI=
G_PCSPKR_PLATFORM=3Dy=0ACONFIG_BASE_FULL=3Dy=0ACONFIG_FUTEX=3Dy=0ACONFIG_EP=
OLL=3Dy=0ACONFIG_SIGNALFD=3Dy=0ACONFIG_TIMERFD=3Dy=0ACONFIG_EVENTFD=3Dy=0AC=
ONFIG_SHMEM=3Dy=0ACONFIG_AIO=3Dy=0ACONFIG_HAVE_PERF_EVENTS=3Dy=0A=0A#=0A# K=
ernel Performance Events And Counters=0A#=0ACONFIG_PERF_EVENTS=3Dy=0A# CONF=
IG_PERF_COUNTERS is not set=0ACONFIG_VM_EVENT_COUNTERS=3Dy=0ACONFIG_PCI_QUI=
RKS=3Dy=0ACONFIG_SLUB_DEBUG=3Dy=0A# CONFIG_COMPAT_BRK is not set=0A# CONFIG=
_SLAB is not set=0ACONFIG_SLUB=3Dy=0A# CONFIG_SLOB is not set=0ACONFIG_PROF=
ILING=3Dy=0A# CONFIG_OPROFILE is not set=0ACONFIG_HAVE_OPROFILE=3Dy=0A# CON=
FIG_KPROBES is not set=0ACONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy=0ACONFI=
G_HAVE_IOREMAP_PROT=3Dy=0ACONFIG_HAVE_KPROBES=3Dy=0ACONFIG_HAVE_KRETPROBES=
=3Dy=0ACONFIG_HAVE_ARCH_TRACEHOOK=3Dy=0ACONFIG_HAVE_DMA_ATTRS=3Dy=0ACONFIG_=
HAVE_DMA_API_DEBUG=3Dy=0A=0A#=0A# GCOV-based kernel profiling=0A#=0ACONFIG_=
SLOW_WORK=3Dy=0ACONFIG_HAVE_GENERIC_DMA_COHERENT=3Dy=0ACONFIG_SLABINFO=3Dy=
=0ACONFIG_RT_MUTEXES=3Dy=0ACONFIG_BASE_SMALL=3D0=0ACONFIG_MODULES=3Dy=0A# C=
ONFIG_MODULE_FORCE_LOAD is not set=0ACONFIG_MODULE_UNLOAD=3Dy=0ACONFIG_MODU=
LE_FORCE_UNLOAD=3Dy=0A# CONFIG_MODVERSIONS is not set=0A# CONFIG_MODULE_SRC=
VERSION_ALL is not set=0ACONFIG_BLOCK=3Dy=0ACONFIG_LBDAF=3Dy=0ACONFIG_BLK_D=
EV_BSG=3Dy=0A# CONFIG_BLK_DEV_INTEGRITY is not set=0A=0A#=0A# IO Schedulers=
=0A#=0ACONFIG_IOSCHED_NOOP=3Dy=0ACONFIG_IOSCHED_AS=3Dy=0ACONFIG_IOSCHED_DEA=
DLINE=3Dy=0ACONFIG_IOSCHED_CFQ=3Dy=0A# CONFIG_DEFAULT_AS is not set=0A# CON=
FIG_DEFAULT_DEADLINE is not set=0ACONFIG_DEFAULT_CFQ=3Dy=0A# CONFIG_DEFAULT=
_NOOP is not set=0ACONFIG_DEFAULT_IOSCHED=3D"cfq"=0ACONFIG_FREEZER=3Dy=0A=
=0A#=0A# Processor type and features=0A#=0ACONFIG_TICK_ONESHOT=3Dy=0ACONFIG=
_NO_HZ=3Dy=0ACONFIG_HIGH_RES_TIMERS=3Dy=0ACONFIG_GENERIC_CLOCKEVENTS_BUILD=
=3Dy=0A# CONFIG_SMP is not set=0A# CONFIG_X86_EXTENDED_PLATFORM is not set=
=0ACONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy=0ACONFIG_SCHED_OMIT_FRAME_POINTER=
=3Dy=0A# CONFIG_PARAVIRT_GUEST is not set=0A# CONFIG_MEMTEST is not set=0A#=
 CONFIG_M386 is not set=0A# CONFIG_M486 is not set=0A# CONFIG_M586 is not s=
et=0A# CONFIG_M586TSC is not set=0A# CONFIG_M586MMX is not set=0A# CONFIG_M=
686 is not set=0A# CONFIG_MPENTIUMII is not set=0A# CONFIG_MPENTIUMIII is n=
ot set=0A# CONFIG_MPENTIUMM is not set=0A# CONFIG_MPENTIUM4 is not set=0A# =
CONFIG_MK6 is not set=0A# CONFIG_MK7 is not set=0ACONFIG_MK8=3Dy=0A# CONFIG=
_MCRUSOE is not set=0A# CONFIG_MEFFICEON is not set=0A# CONFIG_MWINCHIPC6 i=
s not set=0A# CONFIG_MWINCHIP3D is not set=0A# CONFIG_MGEODEGX1 is not set=
=0A# CONFIG_MGEODE_LX is not set=0A# CONFIG_MCYRIXIII is not set=0A# CONFIG=
_MVIAC3_2 is not set=0A# CONFIG_MVIAC7 is not set=0A# CONFIG_MPSC is not se=
t=0A# CONFIG_MCORE2 is not set=0A# CONFIG_MATOM is not set=0A# CONFIG_GENER=
IC_CPU is not set=0A# CONFIG_X86_GENERIC is not set=0ACONFIG_X86_CPU=3Dy=0A=
CONFIG_X86_L1_CACHE_BYTES=3D64=0ACONFIG_X86_INTERNODE_CACHE_BYTES=3D64=0ACO=
NFIG_X86_CMPXCHG=3Dy=0ACONFIG_X86_L1_CACHE_SHIFT=3D6=0ACONFIG_X86_XADD=3Dy=
=0ACONFIG_X86_WP_WORKS_OK=3Dy=0ACONFIG_X86_INVLPG=3Dy=0ACONFIG_X86_BSWAP=3D=
y=0ACONFIG_X86_POPAD_OK=3Dy=0ACONFIG_X86_INTEL_USERCOPY=3Dy=0ACONFIG_X86_US=
E_PPRO_CHECKSUM=3Dy=0ACONFIG_X86_TSC=3Dy=0ACONFIG_X86_CMOV=3Dy=0ACONFIG_X86=
_MINIMUM_CPU_FAMILY=3D4=0ACONFIG_X86_DEBUGCTLMSR=3Dy=0ACONFIG_CPU_SUP_INTEL=
=3Dy=0ACONFIG_CPU_SUP_CYRIX_32=3Dy=0ACONFIG_CPU_SUP_AMD=3Dy=0ACONFIG_CPU_SU=
P_CENTAUR=3Dy=0ACONFIG_CPU_SUP_TRANSMETA_32=3Dy=0ACONFIG_CPU_SUP_UMC_32=3Dy=
=0A# CONFIG_X86_DS is not set=0ACONFIG_HPET_TIMER=3Dy=0ACONFIG_HPET_EMULATE=
_RTC=3Dy=0ACONFIG_DMI=3Dy=0A# CONFIG_IOMMU_HELPER is not set=0A# CONFIG_IOM=
MU_API is not set=0ACONFIG_NR_CPUS=3D1=0A# CONFIG_PREEMPT_NONE is not set=
=0ACONFIG_PREEMPT_VOLUNTARY=3Dy=0A# CONFIG_PREEMPT is not set=0A# CONFIG_X8=
6_UP_APIC is not set=0ACONFIG_X86_MCE=3Dy=0A# CONFIG_X86_ANCIENT_MCE is not=
 set=0A# CONFIG_X86_MCE_INJECT is not set=0ACONFIG_VM86=3Dy=0A# CONFIG_TOSH=
IBA is not set=0A# CONFIG_I8K is not set=0ACONFIG_X86_REBOOTFIXUPS=3Dy=0ACO=
NFIG_MICROCODE=3Dy=0A# CONFIG_MICROCODE_INTEL is not set=0ACONFIG_MICROCODE=
_AMD=3Dy=0ACONFIG_MICROCODE_OLD_INTERFACE=3Dy=0ACONFIG_X86_MSR=3Dy=0ACONFIG=
_X86_CPUID=3Dy=0A# CONFIG_X86_CPU_DEBUG is not set=0A# CONFIG_NOHIGHMEM is =
not set=0ACONFIG_HIGHMEM4G=3Dy=0A# CONFIG_HIGHMEM64G is not set=0ACONFIG_PA=
GE_OFFSET=3D0xC0000000=0ACONFIG_HIGHMEM=3Dy=0A# CONFIG_ARCH_PHYS_ADDR_T_64B=
IT is not set=0ACONFIG_ARCH_FLATMEM_ENABLE=3Dy=0ACONFIG_ARCH_SPARSEMEM_ENAB=
LE=3Dy=0ACONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy=0ACONFIG_SELECT_MEMORY_MODEL=
=3Dy=0ACONFIG_FLATMEM_MANUAL=3Dy=0A# CONFIG_DISCONTIGMEM_MANUAL is not set=
=0A# CONFIG_SPARSEMEM_MANUAL is not set=0ACONFIG_FLATMEM=3Dy=0ACONFIG_FLAT_=
NODE_MEM_MAP=3Dy=0ACONFIG_SPARSEMEM_STATIC=3Dy=0ACONFIG_PAGEFLAGS_EXTENDED=
=3Dy=0ACONFIG_SPLIT_PTLOCK_CPUS=3D4=0A# CONFIG_PHYS_ADDR_T_64BIT is not set=
=0ACONFIG_ZONE_DMA_FLAG=3D1=0ACONFIG_BOUNCE=3Dy=0ACONFIG_VIRT_TO_BUS=3Dy=0A=
CONFIG_HAVE_MLOCK=3Dy=0ACONFIG_HAVE_MLOCKED_PAGE_BIT=3Dy=0A# CONFIG_KSM is =
not set=0ACONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096=0ACONFIG_ARCH_SUPPORTS_MEMORY=
_FAILURE=3Dy=0A# CONFIG_MEMORY_FAILURE is not set=0ACONFIG_HIGHPTE=3Dy=0ACO=
NFIG_X86_CHECK_BIOS_CORRUPTION=3Dy=0ACONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION=
_CHECK=3Dy=0ACONFIG_X86_RESERVE_LOW_64K=3Dy=0A# CONFIG_MATH_EMULATION is no=
t set=0ACONFIG_MTRR=3Dy=0A# CONFIG_MTRR_SANITIZER is not set=0ACONFIG_X86_P=
AT=3Dy=0ACONFIG_ARCH_USES_PG_UNCACHED=3Dy=0ACONFIG_EFI=3Dy=0ACONFIG_SECCOMP=
=3Dy=0A# CONFIG_CC_STACKPROTECTOR is not set=0A# CONFIG_HZ_100 is not set=
=0A# CONFIG_HZ_250 is not set=0A# CONFIG_HZ_300 is not set=0ACONFIG_HZ_1000=
=3Dy=0ACONFIG_HZ=3D1000=0ACONFIG_SCHED_HRTICK=3Dy=0ACONFIG_KEXEC=3Dy=0ACONF=
IG_CRASH_DUMP=3Dy=0A# CONFIG_KEXEC_JUMP is not set=0ACONFIG_PHYSICAL_START=
=3D0x1000000=0ACONFIG_RELOCATABLE=3Dy=0ACONFIG_X86_NEED_RELOCS=3Dy=0ACONFIG=
_PHYSICAL_ALIGN=3D0x1000000=0A# CONFIG_COMPAT_VDSO is not set=0A# CONFIG_CM=
DLINE_BOOL is not set=0ACONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy=0A=0A#=0A# Po=
wer management and ACPI options=0A#=0ACONFIG_PM=3Dy=0A# CONFIG_PM_DEBUG is =
not set=0ACONFIG_PM_SLEEP=3Dy=0ACONFIG_SUSPEND=3Dy=0ACONFIG_SUSPEND_FREEZER=
=3Dy=0ACONFIG_HIBERNATION_NVS=3Dy=0ACONFIG_HIBERNATION=3Dy=0ACONFIG_PM_STD_=
PARTITION=3D""=0A# CONFIG_PM_RUNTIME is not set=0ACONFIG_ACPI=3Dy=0ACONFIG_=
ACPI_SLEEP=3Dy=0ACONFIG_ACPI_PROCFS=3Dy=0ACONFIG_ACPI_PROCFS_POWER=3Dy=0A# =
CONFIG_ACPI_POWER_METER is not set=0ACONFIG_ACPI_SYSFS_POWER=3Dy=0ACONFIG_A=
CPI_PROC_EVENT=3Dy=0ACONFIG_ACPI_AC=3Dy=0ACONFIG_ACPI_BATTERY=3Dy=0ACONFIG_=
ACPI_BUTTON=3Dy=0ACONFIG_ACPI_VIDEO=3Dy=0ACONFIG_ACPI_FAN=3Dy=0ACONFIG_ACPI=
_DOCK=3Dy=0ACONFIG_ACPI_PROCESSOR=3Dy=0A# CONFIG_ACPI_PROCESSOR_AGGREGATOR =
is not set=0ACONFIG_ACPI_THERMAL=3Dy=0A# CONFIG_ACPI_CUSTOM_DSDT is not set=
=0ACONFIG_ACPI_BLACKLIST_YEAR=3D0=0A# CONFIG_ACPI_DEBUG is not set=0A# CONF=
IG_ACPI_PCI_SLOT is not set=0ACONFIG_X86_PM_TIMER=3Dy=0ACONFIG_ACPI_CONTAIN=
ER=3Dy=0A# CONFIG_ACPI_SBS is not set=0A# CONFIG_SFI is not set=0A# CONFIG_=
APM is not set=0A=0A#=0A# CPU Frequency scaling=0A#=0ACONFIG_CPU_FREQ=3Dy=
=0ACONFIG_CPU_FREQ_TABLE=3Dy=0ACONFIG_CPU_FREQ_DEBUG=3Dy=0A# CONFIG_CPU_FRE=
Q_STAT is not set=0A# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set=0A=
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set=0ACONFIG_CPU_FREQ_DEFAUL=
T_GOV_USERSPACE=3Dy=0A# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set=0A#=
 CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set=0ACONFIG_CPU_FREQ_GOV_=
PERFORMANCE=3Dy=0A# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set=0ACONFIG_CPU_F=
REQ_GOV_USERSPACE=3Dy=0ACONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy=0A# CONFIG_CPU_FRE=
Q_GOV_CONSERVATIVE is not set=0A=0A#=0A# CPUFreq processor drivers=0A#=0ACO=
NFIG_X86_ACPI_CPUFREQ=3Dy=0A# CONFIG_X86_POWERNOW_K6 is not set=0A# CONFIG_=
X86_POWERNOW_K7 is not set=0ACONFIG_X86_POWERNOW_K8=3Dy=0A# CONFIG_X86_GX_S=
USPMOD is not set=0A# CONFIG_X86_SPEEDSTEP_CENTRINO is not set=0A# CONFIG_X=
86_SPEEDSTEP_ICH is not set=0A# CONFIG_X86_SPEEDSTEP_SMI is not set=0A# CON=
FIG_X86_P4_CLOCKMOD is not set=0ACONFIG_X86_CPUFREQ_NFORCE2=3Dy=0A# CONFIG_=
X86_LONGRUN is not set=0A# CONFIG_X86_LONGHAUL is not set=0A# CONFIG_X86_E_=
POWERSAVER is not set=0A=0A#=0A# shared options=0A#=0A# CONFIG_X86_SPEEDSTE=
P_LIB is not set=0ACONFIG_CPU_IDLE=3Dy=0ACONFIG_CPU_IDLE_GOV_LADDER=3Dy=0AC=
ONFIG_CPU_IDLE_GOV_MENU=3Dy=0A=0A#=0A# Bus options (PCI etc.)=0A#=0ACONFIG_=
PCI=3Dy=0A# CONFIG_PCI_GOBIOS is not set=0A# CONFIG_PCI_GOMMCONFIG is not s=
et=0A# CONFIG_PCI_GODIRECT is not set=0A# CONFIG_PCI_GOOLPC is not set=0ACO=
NFIG_PCI_GOANY=3Dy=0ACONFIG_PCI_BIOS=3Dy=0ACONFIG_PCI_DIRECT=3Dy=0ACONFIG_P=
CI_MMCONFIG=3Dy=0ACONFIG_PCI_DOMAINS=3Dy=0ACONFIG_PCIEPORTBUS=3Dy=0ACONFIG_=
PCIEAER=3Dy=0A# CONFIG_PCIE_ECRC is not set=0A# CONFIG_PCIEAER_INJECT is no=
t set=0A# CONFIG_PCIEASPM is not set=0A# CONFIG_ARCH_SUPPORTS_MSI is not se=
t=0A# CONFIG_PCI_LEGACY is not set=0A# CONFIG_PCI_STUB is not set=0A# CONFI=
G_PCI_IOV is not set=0ACONFIG_ISA_DMA_API=3Dy=0A# CONFIG_ISA is not set=0A#=
 CONFIG_MCA is not set=0A# CONFIG_SCx200 is not set=0A# CONFIG_OLPC is not =
set=0ACONFIG_K8_NB=3Dy=0A# CONFIG_PCCARD is not set=0A# CONFIG_HOTPLUG_PCI =
is not set=0A=0A#=0A# Executable file formats / Emulations=0A#=0ACONFIG_BIN=
FMT_ELF=3Dy=0ACONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy=0ACONFIG_HAVE_AOUT=
=3Dy=0A# CONFIG_BINFMT_AOUT is not set=0ACONFIG_BINFMT_MISC=3Dy=0ACONFIG_HA=
VE_ATOMIC_IOMAP=3Dy=0ACONFIG_NET=3Dy=0A=0A#=0A# Networking options=0A#=0ACO=
NFIG_PACKET=3Dy=0ACONFIG_PACKET_MMAP=3Dy=0ACONFIG_UNIX=3Dy=0ACONFIG_XFRM=3D=
y=0ACONFIG_XFRM_USER=3Dy=0A# CONFIG_XFRM_SUB_POLICY is not set=0A# CONFIG_X=
FRM_MIGRATE is not set=0A# CONFIG_XFRM_STATISTICS is not set=0A# CONFIG_NET=
_KEY is not set=0ACONFIG_INET=3Dy=0ACONFIG_IP_MULTICAST=3Dy=0ACONFIG_IP_ADV=
ANCED_ROUTER=3Dy=0ACONFIG_ASK_IP_FIB_HASH=3Dy=0A# CONFIG_IP_FIB_TRIE is not=
 set=0ACONFIG_IP_FIB_HASH=3Dy=0ACONFIG_IP_MULTIPLE_TABLES=3Dy=0ACONFIG_IP_R=
OUTE_MULTIPATH=3Dy=0ACONFIG_IP_ROUTE_VERBOSE=3Dy=0ACONFIG_IP_PNP=3Dy=0ACONF=
IG_IP_PNP_DHCP=3Dy=0ACONFIG_IP_PNP_BOOTP=3Dy=0ACONFIG_IP_PNP_RARP=3Dy=0A# C=
ONFIG_NET_IPIP is not set=0A# CONFIG_NET_IPGRE is not set=0ACONFIG_IP_MROUT=
E=3Dy=0ACONFIG_IP_PIMSM_V1=3Dy=0ACONFIG_IP_PIMSM_V2=3Dy=0A# CONFIG_ARPD is =
not set=0ACONFIG_SYN_COOKIES=3Dy=0A# CONFIG_INET_AH is not set=0A# CONFIG_I=
NET_ESP is not set=0A# CONFIG_INET_IPCOMP is not set=0A# CONFIG_INET_XFRM_T=
UNNEL is not set=0ACONFIG_INET_TUNNEL=3Dy=0A# CONFIG_INET_XFRM_MODE_TRANSPO=
RT is not set=0A# CONFIG_INET_XFRM_MODE_TUNNEL is not set=0A# CONFIG_INET_X=
FRM_MODE_BEET is not set=0ACONFIG_INET_LRO=3Dy=0A# CONFIG_INET_DIAG is not =
set=0ACONFIG_TCP_CONG_ADVANCED=3Dy=0A# CONFIG_TCP_CONG_BIC is not set=0ACON=
FIG_TCP_CONG_CUBIC=3Dy=0A# CONFIG_TCP_CONG_WESTWOOD is not set=0A# CONFIG_T=
CP_CONG_HTCP is not set=0A# CONFIG_TCP_CONG_HSTCP is not set=0A# CONFIG_TCP=
_CONG_HYBLA is not set=0A# CONFIG_TCP_CONG_VEGAS is not set=0A# CONFIG_TCP_=
CONG_SCALABLE is not set=0A# CONFIG_TCP_CONG_LP is not set=0A# CONFIG_TCP_C=
ONG_VENO is not set=0A# CONFIG_TCP_CONG_YEAH is not set=0A# CONFIG_TCP_CONG=
_ILLINOIS is not set=0A# CONFIG_DEFAULT_BIC is not set=0ACONFIG_DEFAULT_CUB=
IC=3Dy=0A# CONFIG_DEFAULT_HTCP is not set=0A# CONFIG_DEFAULT_VEGAS is not s=
et=0A# CONFIG_DEFAULT_WESTWOOD is not set=0A# CONFIG_DEFAULT_RENO is not se=
t=0ACONFIG_DEFAULT_TCP_CONG=3D"cubic"=0ACONFIG_TCP_MD5SIG=3Dy=0ACONFIG_IPV6=
=3Dy=0A# CONFIG_IPV6_PRIVACY is not set=0A# CONFIG_IPV6_ROUTER_PREF is not =
set=0A# CONFIG_IPV6_OPTIMISTIC_DAD is not set=0ACONFIG_INET6_AH=3Dy=0ACONFI=
G_INET6_ESP=3Dy=0A# CONFIG_INET6_IPCOMP is not set=0A# CONFIG_IPV6_MIP6 is =
not set=0A# CONFIG_INET6_XFRM_TUNNEL is not set=0A# CONFIG_INET6_TUNNEL is =
not set=0ACONFIG_INET6_XFRM_MODE_TRANSPORT=3Dy=0ACONFIG_INET6_XFRM_MODE_TUN=
NEL=3Dy=0ACONFIG_INET6_XFRM_MODE_BEET=3Dy=0A# CONFIG_INET6_XFRM_MODE_ROUTEO=
PTIMIZATION is not set=0ACONFIG_IPV6_SIT=3Dy=0ACONFIG_IPV6_NDISC_NODETYPE=
=3Dy=0A# CONFIG_IPV6_TUNNEL is not set=0A# CONFIG_IPV6_MULTIPLE_TABLES is n=
ot set=0A# CONFIG_IPV6_MROUTE is not set=0ACONFIG_NETLABEL=3Dy=0ACONFIG_NET=
WORK_SECMARK=3Dy=0ACONFIG_NETFILTER=3Dy=0A# CONFIG_NETFILTER_DEBUG is not s=
et=0A# CONFIG_NETFILTER_ADVANCED is not set=0A=0A#=0A# Core Netfilter Confi=
guration=0A#=0ACONFIG_NETFILTER_NETLINK=3Dy=0ACONFIG_NETFILTER_NETLINK_LOG=
=3Dy=0ACONFIG_NF_CONNTRACK=3Dy=0ACONFIG_NF_CONNTRACK_SECMARK=3Dy=0ACONFIG_N=
F_CONNTRACK_FTP=3Dy=0ACONFIG_NF_CONNTRACK_IRC=3Dy=0ACONFIG_NF_CONNTRACK_SIP=
=3Dy=0ACONFIG_NF_CT_NETLINK=3Dy=0ACONFIG_NETFILTER_XTABLES=3Dy=0ACONFIG_NET=
FILTER_XT_TARGET_CONNSECMARK=3Dy=0ACONFIG_NETFILTER_XT_TARGET_MARK=3Dy=0ACO=
NFIG_NETFILTER_XT_TARGET_NFLOG=3Dy=0ACONFIG_NETFILTER_XT_TARGET_SECMARK=3Dy=
=0ACONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dy=0ACONFIG_NETFILTER_XT_MATCH_CONNTR=
ACK=3Dy=0ACONFIG_NETFILTER_XT_MATCH_MARK=3Dy=0ACONFIG_NETFILTER_XT_MATCH_PO=
LICY=3Dy=0ACONFIG_NETFILTER_XT_MATCH_STATE=3Dy=0A# CONFIG_IP_VS is not set=
=0A=0A#=0A# IP: Netfilter Configuration=0A#=0ACONFIG_NF_DEFRAG_IPV4=3Dy=0AC=
ONFIG_NF_CONNTRACK_IPV4=3Dy=0ACONFIG_NF_CONNTRACK_PROC_COMPAT=3Dy=0ACONFIG_=
IP_NF_IPTABLES=3Dy=0ACONFIG_IP_NF_FILTER=3Dy=0ACONFIG_IP_NF_TARGET_REJECT=
=3Dy=0ACONFIG_IP_NF_TARGET_LOG=3Dy=0ACONFIG_IP_NF_TARGET_ULOG=3Dy=0ACONFIG_=
NF_NAT=3Dy=0ACONFIG_NF_NAT_NEEDED=3Dy=0ACONFIG_IP_NF_TARGET_MASQUERADE=3Dy=
=0ACONFIG_NF_NAT_FTP=3Dy=0ACONFIG_NF_NAT_IRC=3Dy=0A# CONFIG_NF_NAT_TFTP is =
not set=0A# CONFIG_NF_NAT_AMANDA is not set=0A# CONFIG_NF_NAT_PPTP is not s=
et=0A# CONFIG_NF_NAT_H323 is not set=0ACONFIG_NF_NAT_SIP=3Dy=0ACONFIG_IP_NF=
_MANGLE=3Dy=0A=0A#=0A# IPv6: Netfilter Configuration=0A#=0ACONFIG_NF_CONNTR=
ACK_IPV6=3Dy=0ACONFIG_IP6_NF_IPTABLES=3Dy=0ACONFIG_IP6_NF_MATCH_IPV6HEADER=
=3Dy=0ACONFIG_IP6_NF_TARGET_LOG=3Dy=0ACONFIG_IP6_NF_FILTER=3Dy=0ACONFIG_IP6=
_NF_TARGET_REJECT=3Dy=0ACONFIG_IP6_NF_MANGLE=3Dy=0A# CONFIG_IP_DCCP is not =
set=0A# CONFIG_IP_SCTP is not set=0A# CONFIG_RDS is not set=0A# CONFIG_TIPC=
 is not set=0A# CONFIG_ATM is not set=0A# CONFIG_BRIDGE is not set=0A# CONF=
IG_NET_DSA is not set=0A# CONFIG_VLAN_8021Q is not set=0A# CONFIG_DECNET is=
 not set=0A# CONFIG_LLC2 is not set=0A# CONFIG_IPX is not set=0A# CONFIG_AT=
ALK is not set=0A# CONFIG_X25 is not set=0A# CONFIG_LAPB is not set=0A# CON=
FIG_ECONET is not set=0A# CONFIG_WAN_ROUTER is not set=0A# CONFIG_PHONET is=
 not set=0A# CONFIG_IEEE802154 is not set=0ACONFIG_NET_SCHED=3Dy=0A=0A#=0A#=
 Queueing/Scheduling=0A#=0A# CONFIG_NET_SCH_CBQ is not set=0A# CONFIG_NET_S=
CH_HTB is not set=0A# CONFIG_NET_SCH_HFSC is not set=0A# CONFIG_NET_SCH_PRI=
O is not set=0A# CONFIG_NET_SCH_MULTIQ is not set=0A# CONFIG_NET_SCH_RED is=
 not set=0A# CONFIG_NET_SCH_SFQ is not set=0A# CONFIG_NET_SCH_TEQL is not s=
et=0A# CONFIG_NET_SCH_TBF is not set=0A# CONFIG_NET_SCH_GRED is not set=0A#=
 CONFIG_NET_SCH_DSMARK is not set=0A# CONFIG_NET_SCH_NETEM is not set=0A# C=
ONFIG_NET_SCH_DRR is not set=0A# CONFIG_NET_SCH_INGRESS is not set=0A=0A#=
=0A# Classification=0A#=0ACONFIG_NET_CLS=3Dy=0A# CONFIG_NET_CLS_BASIC is no=
t set=0A# CONFIG_NET_CLS_TCINDEX is not set=0A# CONFIG_NET_CLS_ROUTE4 is no=
t set=0A# CONFIG_NET_CLS_FW is not set=0A# CONFIG_NET_CLS_U32 is not set=0A=
# CONFIG_NET_CLS_RSVP is not set=0A# CONFIG_NET_CLS_RSVP6 is not set=0A# CO=
NFIG_NET_CLS_FLOW is not set=0ACONFIG_NET_EMATCH=3Dy=0ACONFIG_NET_EMATCH_ST=
ACK=3D32=0A# CONFIG_NET_EMATCH_CMP is not set=0A# CONFIG_NET_EMATCH_NBYTE i=
s not set=0A# CONFIG_NET_EMATCH_U32 is not set=0A# CONFIG_NET_EMATCH_META i=
s not set=0A# CONFIG_NET_EMATCH_TEXT is not set=0ACONFIG_NET_CLS_ACT=3Dy=0A=
# CONFIG_NET_ACT_POLICE is not set=0A# CONFIG_NET_ACT_GACT is not set=0A# C=
ONFIG_NET_ACT_MIRRED is not set=0A# CONFIG_NET_ACT_IPT is not set=0A# CONFI=
G_NET_ACT_NAT is not set=0A# CONFIG_NET_ACT_PEDIT is not set=0A# CONFIG_NET=
_ACT_SIMP is not set=0A# CONFIG_NET_ACT_SKBEDIT is not set=0ACONFIG_NET_SCH=
_FIFO=3Dy=0A# CONFIG_DCB is not set=0A=0A#=0A# Network testing=0A#=0A# CONF=
IG_NET_PKTGEN is not set=0A# CONFIG_HAMRADIO is not set=0A# CONFIG_CAN is n=
ot set=0A# CONFIG_IRDA is not set=0A# CONFIG_BT is not set=0A# CONFIG_AF_RX=
RPC is not set=0ACONFIG_FIB_RULES=3Dy=0ACONFIG_WIRELESS=3Dy=0ACONFIG_CFG802=
11=3Dy=0A# CONFIG_NL80211_TESTMODE is not set=0A# CONFIG_CFG80211_DEVELOPER=
_WARNINGS is not set=0A# CONFIG_CFG80211_REG_DEBUG is not set=0ACONFIG_CFG8=
0211_DEFAULT_PS=3Dy=0ACONFIG_CFG80211_DEFAULT_PS_VALUE=3D1=0ACONFIG_WIRELES=
S_OLD_REGULATORY=3Dy=0ACONFIG_WIRELESS_EXT=3Dy=0ACONFIG_WIRELESS_EXT_SYSFS=
=3Dy=0A# CONFIG_LIB80211 is not set=0ACONFIG_MAC80211=3Dy=0ACONFIG_MAC80211=
_RC_MINSTREL=3Dy=0A# CONFIG_MAC80211_RC_DEFAULT_PID is not set=0ACONFIG_MAC=
80211_RC_DEFAULT_MINSTREL=3Dy=0ACONFIG_MAC80211_RC_DEFAULT=3D"minstrel"=0A#=
 CONFIG_MAC80211_MESH is not set=0ACONFIG_MAC80211_LEDS=3Dy=0A# CONFIG_MAC8=
0211_DEBUG_MENU is not set=0A# CONFIG_WIMAX is not set=0ACONFIG_RFKILL=3Dy=
=0ACONFIG_RFKILL_LEDS=3Dy=0ACONFIG_RFKILL_INPUT=3Dy=0A# CONFIG_NET_9P is no=
t set=0A=0A#=0A# Device Drivers=0A#=0A=0A#=0A# Generic Driver Options=0A#=
=0ACONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"=0A# CONFIG_DEVTMPFS is not s=
et=0ACONFIG_STANDALONE=3Dy=0ACONFIG_PREVENT_FIRMWARE_BUILD=3Dy=0ACONFIG_FW_=
LOADER=3Dy=0ACONFIG_FIRMWARE_IN_KERNEL=3Dy=0ACONFIG_EXTRA_FIRMWARE=3D""=0A#=
 CONFIG_SYS_HYPERVISOR is not set=0ACONFIG_CONNECTOR=3Dy=0ACONFIG_PROC_EVEN=
TS=3Dy=0A# CONFIG_MTD is not set=0A# CONFIG_PARPORT is not set=0ACONFIG_PNP=
=3Dy=0ACONFIG_PNP_DEBUG_MESSAGES=3Dy=0A=0A#=0A# Protocols=0A#=0ACONFIG_PNPA=
CPI=3Dy=0ACONFIG_BLK_DEV=3Dy=0A# CONFIG_BLK_DEV_FD is not set=0A# CONFIG_BL=
K_CPQ_DA is not set=0A# CONFIG_BLK_CPQ_CISS_DA is not set=0A# CONFIG_BLK_DE=
V_DAC960 is not set=0A# CONFIG_BLK_DEV_UMEM is not set=0A# CONFIG_BLK_DEV_C=
OW_COMMON is not set=0ACONFIG_BLK_DEV_LOOP=3Dy=0A# CONFIG_BLK_DEV_CRYPTOLOO=
P is not set=0A# CONFIG_BLK_DEV_NBD is not set=0A# CONFIG_BLK_DEV_SX8 is no=
t set=0A# CONFIG_BLK_DEV_UB is not set=0ACONFIG_BLK_DEV_RAM=3Dy=0ACONFIG_BL=
K_DEV_RAM_COUNT=3D16=0ACONFIG_BLK_DEV_RAM_SIZE=3D16384=0A# CONFIG_BLK_DEV_X=
IP is not set=0ACONFIG_CDROM_PKTCDVD=3Dy=0ACONFIG_CDROM_PKTCDVD_BUFFERS=3D8=
=0ACONFIG_CDROM_PKTCDVD_WCACHE=3Dy=0A# CONFIG_ATA_OVER_ETH is not set=0A# C=
ONFIG_BLK_DEV_HD is not set=0ACONFIG_MISC_DEVICES=3Dy=0A# CONFIG_IBM_ASM is=
 not set=0A# CONFIG_PHANTOM is not set=0A# CONFIG_SGI_IOC4 is not set=0A# C=
ONFIG_TIFM_CORE is not set=0A# CONFIG_ICS932S401 is not set=0A# CONFIG_ENCL=
OSURE_SERVICES is not set=0A# CONFIG_HP_ILO is not set=0A# CONFIG_ISL29003 =
is not set=0A# CONFIG_C2PORT is not set=0A=0A#=0A# EEPROM support=0A#=0A# C=
ONFIG_EEPROM_AT24 is not set=0A# CONFIG_EEPROM_LEGACY is not set=0A# CONFIG=
_EEPROM_MAX6875 is not set=0A# CONFIG_EEPROM_93CX6 is not set=0A# CONFIG_CB=
710_CORE is not set=0ACONFIG_HAVE_IDE=3Dy=0ACONFIG_IDE=3Dy=0A=0A#=0A# Pleas=
e see Documentation/ide/ide.txt for help/info on IDE drives=0A#=0ACONFIG_ID=
E_XFER_MODE=3Dy=0ACONFIG_IDE_TIMINGS=3Dy=0ACONFIG_IDE_ATAPI=3Dy=0A# CONFIG_=
BLK_DEV_IDE_SATA is not set=0ACONFIG_IDE_GD=3Dy=0ACONFIG_IDE_GD_ATA=3Dy=0A#=
 CONFIG_IDE_GD_ATAPI is not set=0ACONFIG_BLK_DEV_IDECD=3Dy=0ACONFIG_BLK_DEV=
_IDECD_VERBOSE_ERRORS=3Dy=0A# CONFIG_BLK_DEV_IDETAPE is not set=0A# CONFIG_=
BLK_DEV_IDEACPI is not set=0A# CONFIG_IDE_TASK_IOCTL is not set=0ACONFIG_ID=
E_PROC_FS=3Dy=0A=0A#=0A# IDE chipset support/bugfixes=0A#=0A# CONFIG_IDE_GE=
NERIC is not set=0A# CONFIG_BLK_DEV_PLATFORM is not set=0ACONFIG_BLK_DEV_CM=
D640=3Dm=0A# CONFIG_BLK_DEV_CMD640_ENHANCED is not set=0A# CONFIG_BLK_DEV_I=
DEPNP is not set=0ACONFIG_BLK_DEV_IDEDMA_SFF=3Dy=0A=0A#=0A# PCI IDE chipset=
s support=0A#=0ACONFIG_BLK_DEV_IDEPCI=3Dy=0ACONFIG_IDEPCI_PCIBUS_ORDER=3Dy=
=0A# CONFIG_BLK_DEV_OFFBOARD is not set=0ACONFIG_BLK_DEV_GENERIC=3Dm=0A# CO=
NFIG_BLK_DEV_OPTI621 is not set=0A# CONFIG_BLK_DEV_RZ1000 is not set=0ACONF=
IG_BLK_DEV_IDEDMA_PCI=3Dy=0A# CONFIG_BLK_DEV_AEC62XX is not set=0A# CONFIG_=
BLK_DEV_ALI15X3 is not set=0ACONFIG_BLK_DEV_AMD74XX=3Dm=0A# CONFIG_BLK_DEV_=
ATIIXP is not set=0ACONFIG_BLK_DEV_CMD64X=3Dm=0A# CONFIG_BLK_DEV_TRIFLEX is=
 not set=0A# CONFIG_BLK_DEV_CS5520 is not set=0A# CONFIG_BLK_DEV_CS5530 is =
not set=0A# CONFIG_BLK_DEV_CS5535 is not set=0A# CONFIG_BLK_DEV_CS5536 is n=
ot set=0A# CONFIG_BLK_DEV_HPT366 is not set=0A# CONFIG_BLK_DEV_JMICRON is n=
ot set=0A# CONFIG_BLK_DEV_SC1200 is not set=0A# CONFIG_BLK_DEV_PIIX is not =
set=0A# CONFIG_BLK_DEV_IT8172 is not set=0A# CONFIG_BLK_DEV_IT8213 is not s=
et=0A# CONFIG_BLK_DEV_IT821X is not set=0A# CONFIG_BLK_DEV_NS87415 is not s=
et=0A# CONFIG_BLK_DEV_PDC202XX_OLD is not set=0A# CONFIG_BLK_DEV_PDC202XX_N=
EW is not set=0A# CONFIG_BLK_DEV_SVWKS is not set=0A# CONFIG_BLK_DEV_SIIMAG=
E is not set=0A# CONFIG_BLK_DEV_SIS5513 is not set=0A# CONFIG_BLK_DEV_SLC90=
E66 is not set=0A# CONFIG_BLK_DEV_TRM290 is not set=0A# CONFIG_BLK_DEV_VIA8=
2CXXX is not set=0A# CONFIG_BLK_DEV_TC86C001 is not set=0ACONFIG_BLK_DEV_ID=
EDMA=3Dy=0A=0A#=0A# SCSI device support=0A#=0A# CONFIG_RAID_ATTRS is not se=
t=0ACONFIG_SCSI=3Dy=0ACONFIG_SCSI_DMA=3Dy=0A# CONFIG_SCSI_TGT is not set=0A=
# CONFIG_SCSI_NETLINK is not set=0ACONFIG_SCSI_PROC_FS=3Dy=0A=0A#=0A# SCSI =
support type (disk, tape, CD-ROM)=0A#=0ACONFIG_BLK_DEV_SD=3Dy=0A# CONFIG_CH=
R_DEV_ST is not set=0A# CONFIG_CHR_DEV_OSST is not set=0ACONFIG_BLK_DEV_SR=
=3Dy=0ACONFIG_BLK_DEV_SR_VENDOR=3Dy=0ACONFIG_CHR_DEV_SG=3Dy=0A# CONFIG_CHR_=
DEV_SCH is not set=0A# CONFIG_SCSI_MULTI_LUN is not set=0A# CONFIG_SCSI_CON=
STANTS is not set=0A# CONFIG_SCSI_LOGGING is not set=0A# CONFIG_SCSI_SCAN_A=
SYNC is not set=0ACONFIG_SCSI_WAIT_SCAN=3Dm=0A=0A#=0A# SCSI Transports=0A#=
=0ACONFIG_SCSI_SPI_ATTRS=3Dy=0A# CONFIG_SCSI_FC_ATTRS is not set=0A# CONFIG=
_SCSI_ISCSI_ATTRS is not set=0A# CONFIG_SCSI_SAS_ATTRS is not set=0A# CONFI=
G_SCSI_SAS_LIBSAS is not set=0A# CONFIG_SCSI_SRP_ATTRS is not set=0A# CONFI=
G_SCSI_LOWLEVEL is not set=0A# CONFIG_SCSI_DH is not set=0A# CONFIG_SCSI_OS=
D_INITIATOR is not set=0ACONFIG_ATA=3Dy=0A# CONFIG_ATA_NONSTANDARD is not s=
et=0ACONFIG_ATA_VERBOSE_ERROR=3Dy=0ACONFIG_ATA_ACPI=3Dy=0ACONFIG_SATA_PMP=
=3Dy=0ACONFIG_SATA_AHCI=3Dy=0A# CONFIG_SATA_SIL24 is not set=0ACONFIG_ATA_S=
FF=3Dy=0A# CONFIG_SATA_SVW is not set=0ACONFIG_ATA_PIIX=3Dy=0A# CONFIG_SATA=
_MV is not set=0ACONFIG_SATA_NV=3Dm=0A# CONFIG_PDC_ADMA is not set=0A# CONF=
IG_SATA_QSTOR is not set=0A# CONFIG_SATA_PROMISE is not set=0A# CONFIG_SATA=
_SX4 is not set=0A# CONFIG_SATA_SIL is not set=0A# CONFIG_SATA_SIS is not s=
et=0A# CONFIG_SATA_ULI is not set=0A# CONFIG_SATA_VIA is not set=0A# CONFIG=
_SATA_VITESSE is not set=0A# CONFIG_SATA_INIC162X is not set=0A# CONFIG_PAT=
A_ACPI is not set=0A# CONFIG_PATA_ALI is not set=0ACONFIG_PATA_AMD=3Dy=0A# =
CONFIG_PATA_ARTOP is not set=0A# CONFIG_PATA_ATP867X is not set=0A# CONFIG_=
PATA_ATIIXP is not set=0A# CONFIG_PATA_CMD640_PCI is not set=0A# CONFIG_PAT=
A_CMD64X is not set=0A# CONFIG_PATA_CS5520 is not set=0A# CONFIG_PATA_CS553=
0 is not set=0A# CONFIG_PATA_CS5535 is not set=0A# CONFIG_PATA_CS5536 is no=
t set=0A# CONFIG_PATA_CYPRESS is not set=0A# CONFIG_PATA_EFAR is not set=0A=
CONFIG_ATA_GENERIC=3Dy=0A# CONFIG_PATA_HPT366 is not set=0A# CONFIG_PATA_HP=
T37X is not set=0A# CONFIG_PATA_HPT3X2N is not set=0A# CONFIG_PATA_HPT3X3 i=
s not set=0A# CONFIG_PATA_IT821X is not set=0A# CONFIG_PATA_IT8213 is not s=
et=0A# CONFIG_PATA_JMICRON is not set=0A# CONFIG_PATA_TRIFLEX is not set=0A=
# CONFIG_PATA_MARVELL is not set=0ACONFIG_PATA_MPIIX=3Dy=0ACONFIG_PATA_OLDP=
IIX=3Dy=0A# CONFIG_PATA_NETCELL is not set=0A# CONFIG_PATA_NINJA32 is not s=
et=0A# CONFIG_PATA_NS87410 is not set=0A# CONFIG_PATA_NS87415 is not set=0A=
# CONFIG_PATA_OPTI is not set=0A# CONFIG_PATA_OPTIDMA is not set=0A# CONFIG=
_PATA_PDC_OLD is not set=0A# CONFIG_PATA_RADISYS is not set=0A# CONFIG_PATA=
_RDC is not set=0A# CONFIG_PATA_RZ1000 is not set=0A# CONFIG_PATA_SC1200 is=
 not set=0A# CONFIG_PATA_SERVERWORKS is not set=0A# CONFIG_PATA_PDC2027X is=
 not set=0A# CONFIG_PATA_SIL680 is not set=0A# CONFIG_PATA_SIS is not set=
=0A# CONFIG_PATA_VIA is not set=0A# CONFIG_PATA_WINBOND is not set=0ACONFIG=
_PATA_SCH=3Dy=0A# CONFIG_MD is not set=0A# CONFIG_FUSION is not set=0A=0A#=
=0A# IEEE 1394 (FireWire) support=0A#=0A=0A#=0A# You can enable one or both=
 FireWire driver stacks.=0A#=0A=0A#=0A# See the help texts for more informa=
tion.=0A#=0A# CONFIG_FIREWIRE is not set=0A# CONFIG_IEEE1394 is not set=0A#=
 CONFIG_I2O is not set=0A# CONFIG_MACINTOSH_DRIVERS is not set=0ACONFIG_NET=
DEVICES=3Dy=0A# CONFIG_IFB is not set=0A# CONFIG_DUMMY is not set=0A# CONFI=
G_BONDING is not set=0A# CONFIG_MACVLAN is not set=0A# CONFIG_EQUALIZER is =
not set=0A# CONFIG_TUN is not set=0A# CONFIG_VETH is not set=0A# CONFIG_NET=
_SB1000 is not set=0A# CONFIG_ARCNET is not set=0ACONFIG_PHYLIB=3Dy=0A=0A#=
=0A# MII PHY device drivers=0A#=0A# CONFIG_MARVELL_PHY is not set=0A# CONFI=
G_DAVICOM_PHY is not set=0A# CONFIG_QSEMI_PHY is not set=0A# CONFIG_LXT_PHY=
 is not set=0A# CONFIG_CICADA_PHY is not set=0A# CONFIG_VITESSE_PHY is not =
set=0A# CONFIG_SMSC_PHY is not set=0A# CONFIG_BROADCOM_PHY is not set=0A# C=
ONFIG_ICPLUS_PHY is not set=0A# CONFIG_REALTEK_PHY is not set=0A# CONFIG_NA=
TIONAL_PHY is not set=0A# CONFIG_STE10XP is not set=0A# CONFIG_LSI_ET1011C_=
PHY is not set=0A# CONFIG_FIXED_PHY is not set=0A# CONFIG_MDIO_BITBANG is n=
ot set=0ACONFIG_NET_ETHERNET=3Dy=0ACONFIG_MII=3Dy=0A# CONFIG_HAPPYMEAL is n=
ot set=0A# CONFIG_SUNGEM is not set=0A# CONFIG_CASSINI is not set=0ACONFIG_=
NET_VENDOR_3COM=3Dy=0A# CONFIG_VORTEX is not set=0A# CONFIG_TYPHOON is not =
set=0A# CONFIG_ETHOC is not set=0A# CONFIG_DNET is not set=0ACONFIG_NET_TUL=
IP=3Dy=0A# CONFIG_DE2104X is not set=0A# CONFIG_TULIP is not set=0A# CONFIG=
_DE4X5 is not set=0A# CONFIG_WINBOND_840 is not set=0A# CONFIG_DM9102 is no=
t set=0A# CONFIG_ULI526X is not set=0A# CONFIG_HP100 is not set=0A# CONFIG_=
IBM_NEW_EMAC_ZMII is not set=0A# CONFIG_IBM_NEW_EMAC_RGMII is not set=0A# C=
ONFIG_IBM_NEW_EMAC_TAH is not set=0A# CONFIG_IBM_NEW_EMAC_EMAC4 is not set=
=0A# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set=0A# CONFIG_IBM_NEW_EMAC_MA=
L_CLR_ICINTSTAT is not set=0A# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not se=
t=0ACONFIG_NET_PCI=3Dy=0A# CONFIG_PCNET32 is not set=0A# CONFIG_AMD8111_ETH=
 is not set=0A# CONFIG_ADAPTEC_STARFIRE is not set=0A# CONFIG_B44 is not se=
t=0ACONFIG_FORCEDETH=3Dy=0A# CONFIG_FORCEDETH_NAPI is not set=0ACONFIG_E100=
=3Dy=0A# CONFIG_FEALNX is not set=0A# CONFIG_NATSEMI is not set=0ACONFIG_NE=
2K_PCI=3Dy=0A# CONFIG_8139CP is not set=0ACONFIG_8139TOO=3Dy=0A# CONFIG_813=
9TOO_PIO is not set=0A# CONFIG_8139TOO_TUNE_TWISTER is not set=0A# CONFIG_8=
139TOO_8129 is not set=0A# CONFIG_8139_OLD_RX_RESET is not set=0A# CONFIG_R=
6040 is not set=0A# CONFIG_SIS900 is not set=0A# CONFIG_EPIC100 is not set=
=0A# CONFIG_SMSC9420 is not set=0A# CONFIG_SUNDANCE is not set=0A# CONFIG_T=
LAN is not set=0A# CONFIG_KS8842 is not set=0A# CONFIG_KS8851_MLL is not se=
t=0A# CONFIG_VIA_RHINE is not set=0A# CONFIG_SC92031 is not set=0A# CONFIG_=
ATL2 is not set=0ACONFIG_NETDEV_1000=3Dy=0A# CONFIG_ACENIC is not set=0A# C=
ONFIG_DL2K is not set=0ACONFIG_E1000=3Dy=0ACONFIG_E1000E=3Dy=0A# CONFIG_IP1=
000 is not set=0A# CONFIG_IGB is not set=0A# CONFIG_IGBVF is not set=0A# CO=
NFIG_NS83820 is not set=0A# CONFIG_HAMACHI is not set=0A# CONFIG_YELLOWFIN =
is not set=0ACONFIG_R8169=3Dy=0A# CONFIG_SIS190 is not set=0A# CONFIG_SKGE =
is not set=0ACONFIG_SKY2=3Dy=0A# CONFIG_VIA_VELOCITY is not set=0ACONFIG_TI=
GON3=3Dy=0ACONFIG_BNX2=3Dy=0A# CONFIG_CNIC is not set=0A# CONFIG_QLA3XXX is=
 not set=0A# CONFIG_ATL1 is not set=0A# CONFIG_ATL1E is not set=0A# CONFIG_=
ATL1C is not set=0A# CONFIG_JME is not set=0ACONFIG_NETDEV_10000=3Dy=0A# CO=
NFIG_CHELSIO_T1 is not set=0ACONFIG_CHELSIO_T3_DEPENDS=3Dy=0A# CONFIG_CHELS=
IO_T3 is not set=0A# CONFIG_ENIC is not set=0A# CONFIG_IXGBE is not set=0A#=
 CONFIG_IXGB is not set=0A# CONFIG_S2IO is not set=0A# CONFIG_VXGE is not s=
et=0A# CONFIG_MYRI10GE is not set=0A# CONFIG_NETXEN_NIC is not set=0A# CONF=
IG_NIU is not set=0A# CONFIG_MLX4_EN is not set=0A# CONFIG_MLX4_CORE is not=
 set=0A# CONFIG_TEHUTI is not set=0A# CONFIG_BNX2X is not set=0A# CONFIG_QL=
GE is not set=0A# CONFIG_SFC is not set=0A# CONFIG_BE2NET is not set=0A# CO=
NFIG_TR is not set=0ACONFIG_WLAN=3Dy=0A# CONFIG_WLAN_PRE80211 is not set=0A=
CONFIG_WLAN_80211=3Dy=0A# CONFIG_LIBERTAS is not set=0A# CONFIG_LIBERTAS_TH=
INFIRM is not set=0A# CONFIG_AIRO is not set=0A# CONFIG_ATMEL is not set=0A=
# CONFIG_AT76C50X_USB is not set=0A# CONFIG_PRISM54 is not set=0A# CONFIG_U=
SB_ZD1201 is not set=0A# CONFIG_USB_NET_RNDIS_WLAN is not set=0A# CONFIG_RT=
L8180 is not set=0A# CONFIG_RTL8187 is not set=0A# CONFIG_ADM8211 is not se=
t=0A# CONFIG_MAC80211_HWSIM is not set=0A# CONFIG_MWL8K is not set=0A# CONF=
IG_P54_COMMON is not set=0A# CONFIG_ATH_COMMON is not set=0A# CONFIG_IPW210=
0 is not set=0A# CONFIG_IPW2200 is not set=0A# CONFIG_IWLWIFI is not set=0A=
# CONFIG_HOSTAP is not set=0A# CONFIG_B43 is not set=0A# CONFIG_B43LEGACY i=
s not set=0A# CONFIG_ZD1211RW is not set=0A# CONFIG_RT2X00 is not set=0A# C=
ONFIG_HERMES is not set=0A# CONFIG_WL12XX is not set=0A# CONFIG_IWM is not =
set=0A=0A#=0A# Enable WiMAX (Networking options) to see the WiMAX drivers=
=0A#=0A=0A#=0A# USB Network Adapters=0A#=0A# CONFIG_USB_CATC is not set=0A#=
 CONFIG_USB_KAWETH is not set=0A# CONFIG_USB_PEGASUS is not set=0A# CONFIG_=
USB_RTL8150 is not set=0A# CONFIG_USB_USBNET is not set=0A# CONFIG_USB_HSO =
is not set=0A# CONFIG_WAN is not set=0A# CONFIG_FDDI is not set=0A# CONFIG_=
HIPPI is not set=0ACONFIG_PPP=3Dy=0A# CONFIG_PPP_MULTILINK is not set=0A# C=
ONFIG_PPP_FILTER is not set=0A# CONFIG_PPP_ASYNC is not set=0A# CONFIG_PPP_=
SYNC_TTY is not set=0ACONFIG_PPP_DEFLATE=3Dm=0ACONFIG_PPP_BSDCOMP=3Dm=0ACON=
FIG_PPP_MPPE=3Dm=0ACONFIG_PPPOE=3Dm=0A# CONFIG_PPPOL2TP is not set=0A# CONF=
IG_SLIP is not set=0ACONFIG_SLHC=3Dy=0A# CONFIG_NET_FC is not set=0ACONFIG_=
NETCONSOLE=3Dy=0A# CONFIG_NETCONSOLE_DYNAMIC is not set=0ACONFIG_NETPOLL=3D=
y=0A# CONFIG_NETPOLL_TRAP is not set=0ACONFIG_NET_POLL_CONTROLLER=3Dy=0A# C=
ONFIG_VMXNET3 is not set=0A# CONFIG_ISDN is not set=0A# CONFIG_PHONE is not=
 set=0A=0A#=0A# Input device support=0A#=0ACONFIG_INPUT=3Dy=0ACONFIG_INPUT_=
FF_MEMLESS=3Dy=0ACONFIG_INPUT_POLLDEV=3Dy=0A=0A#=0A# Userland interfaces=0A=
#=0ACONFIG_INPUT_MOUSEDEV=3Dy=0ACONFIG_INPUT_MOUSEDEV_PSAUX=3Dy=0ACONFIG_IN=
PUT_MOUSEDEV_SCREEN_X=3D1280=0ACONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D1024=0A# CO=
NFIG_INPUT_JOYDEV is not set=0ACONFIG_INPUT_EVDEV=3Dy=0A# CONFIG_INPUT_EVBU=
G is not set=0A=0A#=0A# Input Device Drivers=0A#=0ACONFIG_INPUT_KEYBOARD=3D=
y=0A# CONFIG_KEYBOARD_ADP5588 is not set=0ACONFIG_KEYBOARD_ATKBD=3Dy=0A# CO=
NFIG_QT2160 is not set=0A# CONFIG_KEYBOARD_LKKBD is not set=0A# CONFIG_KEYB=
OARD_LM8323 is not set=0A# CONFIG_KEYBOARD_MAX7359 is not set=0A# CONFIG_KE=
YBOARD_NEWTON is not set=0A# CONFIG_KEYBOARD_OPENCORES is not set=0A# CONFI=
G_KEYBOARD_STOWAWAY is not set=0A# CONFIG_KEYBOARD_SUNKBD is not set=0A# CO=
NFIG_KEYBOARD_XTKBD is not set=0ACONFIG_INPUT_MOUSE=3Dy=0ACONFIG_MOUSE_PS2=
=3Dy=0ACONFIG_MOUSE_PS2_ALPS=3Dy=0ACONFIG_MOUSE_PS2_LOGIPS2PP=3Dy=0ACONFIG_=
MOUSE_PS2_SYNAPTICS=3Dy=0ACONFIG_MOUSE_PS2_LIFEBOOK=3Dy=0ACONFIG_MOUSE_PS2_=
TRACKPOINT=3Dy=0A# CONFIG_MOUSE_PS2_ELANTECH is not set=0A# CONFIG_MOUSE_PS=
2_SENTELIC is not set=0A# CONFIG_MOUSE_PS2_TOUCHKIT is not set=0A# CONFIG_M=
OUSE_SERIAL is not set=0A# CONFIG_MOUSE_APPLETOUCH is not set=0A# CONFIG_MO=
USE_BCM5974 is not set=0A# CONFIG_MOUSE_VSXXXAA is not set=0A# CONFIG_MOUSE=
_SYNAPTICS_I2C is not set=0A# CONFIG_INPUT_JOYSTICK is not set=0ACONFIG_INP=
UT_TABLET=3Dy=0A# CONFIG_TABLET_USB_ACECAD is not set=0ACONFIG_TABLET_USB_A=
IPTEK=3Dm=0A# CONFIG_TABLET_USB_GTCO is not set=0A# CONFIG_TABLET_USB_KBTAB=
 is not set=0ACONFIG_TABLET_USB_WACOM=3Dm=0A# CONFIG_INPUT_TOUCHSCREEN is n=
ot set=0ACONFIG_INPUT_MISC=3Dy=0ACONFIG_INPUT_PCSPKR=3Dm=0A# CONFIG_INPUT_A=
PANEL is not set=0A# CONFIG_INPUT_WISTRON_BTNS is not set=0A# CONFIG_INPUT_=
ATLAS_BTNS is not set=0A# CONFIG_INPUT_ATI_REMOTE is not set=0A# CONFIG_INP=
UT_ATI_REMOTE2 is not set=0A# CONFIG_INPUT_KEYSPAN_REMOTE is not set=0A# CO=
NFIG_INPUT_POWERMATE is not set=0A# CONFIG_INPUT_YEALINK is not set=0A# CON=
FIG_INPUT_CM109 is not set=0ACONFIG_INPUT_UINPUT=3Dm=0A# CONFIG_INPUT_WINBO=
ND_CIR is not set=0A=0A#=0A# Hardware I/O ports=0A#=0ACONFIG_SERIO=3Dy=0ACO=
NFIG_SERIO_I8042=3Dy=0ACONFIG_SERIO_SERPORT=3Dy=0A# CONFIG_SERIO_CT82C710 i=
s not set=0A# CONFIG_SERIO_PCIPS2 is not set=0ACONFIG_SERIO_LIBPS2=3Dy=0A# =
CONFIG_SERIO_RAW is not set=0A# CONFIG_GAMEPORT is not set=0A=0A#=0A# Chara=
cter devices=0A#=0ACONFIG_VT=3Dy=0ACONFIG_CONSOLE_TRANSLATIONS=3Dy=0ACONFIG=
_VT_CONSOLE=3Dy=0ACONFIG_HW_CONSOLE=3Dy=0ACONFIG_VT_HW_CONSOLE_BINDING=3Dy=
=0ACONFIG_DEVKMEM=3Dy=0ACONFIG_SERIAL_NONSTANDARD=3Dy=0A# CONFIG_COMPUTONE =
is not set=0A# CONFIG_ROCKETPORT is not set=0A# CONFIG_CYCLADES is not set=
=0A# CONFIG_DIGIEPCA is not set=0A# CONFIG_MOXA_INTELLIO is not set=0A# CON=
FIG_MOXA_SMARTIO is not set=0A# CONFIG_ISI is not set=0A# CONFIG_SYNCLINK i=
s not set=0A# CONFIG_SYNCLINKMP is not set=0A# CONFIG_SYNCLINK_GT is not se=
t=0A# CONFIG_N_HDLC is not set=0A# CONFIG_RISCOM8 is not set=0A# CONFIG_SPE=
CIALIX is not set=0A# CONFIG_STALDRV is not set=0A# CONFIG_NOZOMI is not se=
t=0A=0A#=0A# Serial drivers=0A#=0ACONFIG_SERIAL_8250=3Dy=0ACONFIG_SERIAL_82=
50_CONSOLE=3Dy=0ACONFIG_FIX_EARLYCON_MEM=3Dy=0ACONFIG_SERIAL_8250_PCI=3Dy=
=0ACONFIG_SERIAL_8250_PNP=3Dy=0ACONFIG_SERIAL_8250_NR_UARTS=3D32=0ACONFIG_S=
ERIAL_8250_RUNTIME_UARTS=3D4=0ACONFIG_SERIAL_8250_EXTENDED=3Dy=0ACONFIG_SER=
IAL_8250_MANY_PORTS=3Dy=0ACONFIG_SERIAL_8250_SHARE_IRQ=3Dy=0ACONFIG_SERIAL_=
8250_DETECT_IRQ=3Dy=0ACONFIG_SERIAL_8250_RSA=3Dy=0A=0A#=0A# Non-8250 serial=
 port support=0A#=0ACONFIG_SERIAL_CORE=3Dy=0ACONFIG_SERIAL_CORE_CONSOLE=3Dy=
=0A# CONFIG_SERIAL_JSM is not set=0ACONFIG_UNIX98_PTYS=3Dy=0A# CONFIG_DEVPT=
S_MULTIPLE_INSTANCES is not set=0A# CONFIG_LEGACY_PTYS is not set=0A# CONFI=
G_IPMI_HANDLER is not set=0ACONFIG_HW_RANDOM=3Dy=0A# CONFIG_HW_RANDOM_TIMER=
IOMEM is not set=0ACONFIG_HW_RANDOM_INTEL=3Dy=0ACONFIG_HW_RANDOM_AMD=3Dy=0A=
CONFIG_HW_RANDOM_GEODE=3Dy=0ACONFIG_HW_RANDOM_VIA=3Dy=0ACONFIG_NVRAM=3Dy=0A=
# CONFIG_R3964 is not set=0A# CONFIG_APPLICOM is not set=0A# CONFIG_SONYPI =
is not set=0A# CONFIG_MWAVE is not set=0A# CONFIG_PC8736x_GPIO is not set=
=0A# CONFIG_NSC_GPIO is not set=0A# CONFIG_CS5535_GPIO is not set=0A# CONFI=
G_RAW_DRIVER is not set=0ACONFIG_HPET=3Dy=0A# CONFIG_HPET_MMAP is not set=
=0A# CONFIG_HANGCHECK_TIMER is not set=0A# CONFIG_TCG_TPM is not set=0A# CO=
NFIG_TELCLOCK is not set=0ACONFIG_DEVPORT=3Dy=0ACONFIG_I2C=3Dy=0ACONFIG_I2C=
_BOARDINFO=3Dy=0ACONFIG_I2C_COMPAT=3Dy=0A# CONFIG_I2C_CHARDEV is not set=0A=
CONFIG_I2C_HELPER_AUTO=3Dy=0ACONFIG_I2C_ALGOBIT=3Dy=0A=0A#=0A# I2C Hardware=
 Bus support=0A#=0A=0A#=0A# PC SMBus host controller drivers=0A#=0A# CONFIG=
_I2C_ALI1535 is not set=0A# CONFIG_I2C_ALI1563 is not set=0A# CONFIG_I2C_AL=
I15X3 is not set=0A# CONFIG_I2C_AMD756 is not set=0A# CONFIG_I2C_AMD8111 is=
 not set=0ACONFIG_I2C_I801=3Dy=0A# CONFIG_I2C_ISCH is not set=0A# CONFIG_I2=
C_PIIX4 is not set=0A# CONFIG_I2C_NFORCE2 is not set=0A# CONFIG_I2C_SIS5595=
 is not set=0A# CONFIG_I2C_SIS630 is not set=0A# CONFIG_I2C_SIS96X is not s=
et=0A# CONFIG_I2C_VIA is not set=0A# CONFIG_I2C_VIAPRO is not set=0A=0A#=0A=
# ACPI drivers=0A#=0A# CONFIG_I2C_SCMI is not set=0A=0A#=0A# I2C system bus=
 drivers (mostly embedded / system-on-chip)=0A#=0A# CONFIG_I2C_OCORES is no=
t set=0A# CONFIG_I2C_SIMTEC is not set=0A=0A#=0A# External I2C/SMBus adapte=
r drivers=0A#=0A# CONFIG_I2C_PARPORT_LIGHT is not set=0A# CONFIG_I2C_TAOS_E=
VM is not set=0A# CONFIG_I2C_TINY_USB is not set=0A=0A#=0A# Graphics adapte=
r I2C/DDC channel drivers=0A#=0A# CONFIG_I2C_VOODOO3 is not set=0A=0A#=0A# =
Other I2C/SMBus bus drivers=0A#=0A# CONFIG_I2C_PCA_PLATFORM is not set=0A# =
CONFIG_I2C_STUB is not set=0A# CONFIG_SCx200_ACB is not set=0A=0A#=0A# Misc=
ellaneous I2C Chip support=0A#=0A# CONFIG_DS1682 is not set=0A# CONFIG_SENS=
ORS_TSL2550 is not set=0A# CONFIG_I2C_DEBUG_CORE is not set=0A# CONFIG_I2C_=
DEBUG_ALGO is not set=0A# CONFIG_I2C_DEBUG_BUS is not set=0A# CONFIG_I2C_DE=
BUG_CHIP is not set=0A# CONFIG_SPI is not set=0A=0A#=0A# PPS support=0A#=0A=
# CONFIG_PPS is not set=0ACONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy=0A# CONFIG_=
GPIOLIB is not set=0A# CONFIG_W1 is not set=0ACONFIG_POWER_SUPPLY=3Dy=0A# C=
ONFIG_POWER_SUPPLY_DEBUG is not set=0A# CONFIG_PDA_POWER is not set=0A# CON=
FIG_BATTERY_DS2760 is not set=0A# CONFIG_BATTERY_DS2782 is not set=0A# CONF=
IG_BATTERY_BQ27x00 is not set=0A# CONFIG_BATTERY_MAX17040 is not set=0ACONF=
IG_HWMON=3Dy=0ACONFIG_HWMON_VID=3Dm=0A# CONFIG_HWMON_DEBUG_CHIP is not set=
=0A=0A#=0A# Native drivers=0A#=0A# CONFIG_SENSORS_ABITUGURU is not set=0A# =
CONFIG_SENSORS_ABITUGURU3 is not set=0ACONFIG_SENSORS_AD7414=3Dm=0ACONFIG_S=
ENSORS_AD7418=3Dm=0ACONFIG_SENSORS_ADM1021=3Dm=0ACONFIG_SENSORS_ADM1025=3Dm=
=0ACONFIG_SENSORS_ADM1026=3Dm=0ACONFIG_SENSORS_ADM1029=3Dm=0ACONFIG_SENSORS=
_ADM1031=3Dm=0ACONFIG_SENSORS_ADM9240=3Dm=0ACONFIG_SENSORS_ADT7462=3Dm=0ACO=
NFIG_SENSORS_ADT7470=3Dm=0ACONFIG_SENSORS_ADT7473=3Dm=0ACONFIG_SENSORS_ADT7=
475=3Dm=0ACONFIG_SENSORS_K8TEMP=3Dy=0ACONFIG_SENSORS_ASB100=3Dm=0ACONFIG_SE=
NSORS_ATXP1=3Dm=0ACONFIG_SENSORS_DS1621=3Dm=0ACONFIG_SENSORS_I5K_AMB=3Dm=0A=
CONFIG_SENSORS_F71805F=3Dm=0ACONFIG_SENSORS_F71882FG=3Dm=0ACONFIG_SENSORS_F=
75375S=3Dm=0ACONFIG_SENSORS_FSCHMD=3Dm=0ACONFIG_SENSORS_G760A=3Dm=0ACONFIG_=
SENSORS_GL518SM=3Dm=0ACONFIG_SENSORS_GL520SM=3Dm=0A# CONFIG_SENSORS_CORETEM=
P is not set=0ACONFIG_SENSORS_IT87=3Dm=0ACONFIG_SENSORS_LM63=3Dm=0ACONFIG_S=
ENSORS_LM75=3Dm=0ACONFIG_SENSORS_LM77=3Dm=0ACONFIG_SENSORS_LM78=3Dm=0ACONFI=
G_SENSORS_LM80=3Dm=0ACONFIG_SENSORS_LM83=3Dm=0ACONFIG_SENSORS_LM85=3Dm=0ACO=
NFIG_SENSORS_LM87=3Dm=0ACONFIG_SENSORS_LM90=3Dm=0ACONFIG_SENSORS_LM92=3Dm=
=0ACONFIG_SENSORS_LM93=3Dm=0ACONFIG_SENSORS_LTC4215=3Dm=0ACONFIG_SENSORS_LT=
C4245=3Dm=0ACONFIG_SENSORS_LM95241=3Dm=0ACONFIG_SENSORS_MAX1619=3Dm=0ACONFI=
G_SENSORS_MAX6650=3Dm=0ACONFIG_SENSORS_PC87360=3Dm=0ACONFIG_SENSORS_PC87427=
=3Dm=0ACONFIG_SENSORS_PCF8591=3Dm=0ACONFIG_SENSORS_SIS5595=3Dm=0ACONFIG_SEN=
SORS_DME1737=3Dm=0ACONFIG_SENSORS_SMSC47M1=3Dm=0ACONFIG_SENSORS_SMSC47M192=
=3Dm=0ACONFIG_SENSORS_SMSC47B397=3Dm=0ACONFIG_SENSORS_ADS7828=3Dm=0ACONFIG_=
SENSORS_THMC50=3Dm=0ACONFIG_SENSORS_TMP401=3Dm=0ACONFIG_SENSORS_TMP421=3Dm=
=0ACONFIG_SENSORS_VIA686A=3Dm=0ACONFIG_SENSORS_VT1211=3Dm=0ACONFIG_SENSORS_=
VT8231=3Dm=0ACONFIG_SENSORS_W83781D=3Dm=0ACONFIG_SENSORS_W83791D=3Dm=0ACONF=
IG_SENSORS_W83792D=3Dm=0ACONFIG_SENSORS_W83793=3Dm=0ACONFIG_SENSORS_W83L785=
TS=3Dm=0ACONFIG_SENSORS_W83L786NG=3Dm=0ACONFIG_SENSORS_W83627HF=3Dm=0ACONFI=
G_SENSORS_W83627EHF=3Dm=0ACONFIG_SENSORS_HDAPS=3Dm=0ACONFIG_SENSORS_APPLESM=
C=3Dm=0A=0A#=0A# ACPI drivers=0A#=0ACONFIG_SENSORS_ATK0110=3Dm=0ACONFIG_SEN=
SORS_LIS3LV02D=3Dm=0ACONFIG_THERMAL=3Dy=0ACONFIG_THERMAL_HWMON=3Dy=0A# CONF=
IG_WATCHDOG is not set=0ACONFIG_SSB_POSSIBLE=3Dy=0A=0A#=0A# Sonics Silicon =
Backplane=0A#=0A# CONFIG_SSB is not set=0A=0A#=0A# Multifunction device dri=
vers=0A#=0A# CONFIG_MFD_CORE is not set=0A# CONFIG_MFD_SM501 is not set=0A#=
 CONFIG_HTC_PASIC3 is not set=0A# CONFIG_TWL4030_CORE is not set=0A# CONFIG=
_MFD_TMIO is not set=0A# CONFIG_PMIC_DA903X is not set=0A# CONFIG_MFD_WM840=
0 is not set=0A# CONFIG_MFD_WM831X is not set=0A# CONFIG_MFD_WM8350_I2C is =
not set=0A# CONFIG_MFD_PCF50633 is not set=0A# CONFIG_AB3100_CORE is not se=
t=0A# CONFIG_REGULATOR is not set=0ACONFIG_MEDIA_SUPPORT=3Dy=0A=0A#=0A# Mul=
timedia core support=0A#=0ACONFIG_VIDEO_DEV=3Dy=0ACONFIG_VIDEO_V4L2_COMMON=
=3Dy=0ACONFIG_VIDEO_ALLOW_V4L1=3Dy=0ACONFIG_VIDEO_V4L1_COMPAT=3Dy=0A# CONFI=
G_DVB_CORE is not set=0ACONFIG_VIDEO_MEDIA=3Dy=0A=0A#=0A# Multimedia driver=
s=0A#=0A# CONFIG_MEDIA_ATTACH is not set=0ACONFIG_MEDIA_TUNER=3Dy=0A# CONFI=
G_MEDIA_TUNER_CUSTOMISE is not set=0ACONFIG_MEDIA_TUNER_SIMPLE=3Dy=0ACONFIG=
_MEDIA_TUNER_TDA8290=3Dy=0ACONFIG_MEDIA_TUNER_TDA9887=3Dy=0ACONFIG_MEDIA_TU=
NER_TEA5761=3Dy=0ACONFIG_MEDIA_TUNER_TEA5767=3Dy=0ACONFIG_MEDIA_TUNER_MT20X=
X=3Dy=0ACONFIG_MEDIA_TUNER_XC2028=3Dy=0ACONFIG_MEDIA_TUNER_XC5000=3Dy=0ACON=
FIG_MEDIA_TUNER_MC44S803=3Dy=0ACONFIG_VIDEO_V4L2=3Dy=0ACONFIG_VIDEO_V4L1=3D=
y=0ACONFIG_VIDEO_CAPTURE_DRIVERS=3Dy=0A# CONFIG_VIDEO_ADV_DEBUG is not set=
=0A# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set=0ACONFIG_VIDEO_HELPER_CHIPS=
_AUTO=3Dy=0A# CONFIG_VIDEO_VIVI is not set=0A# CONFIG_VIDEO_BT848 is not se=
t=0A# CONFIG_VIDEO_CPIA is not set=0A# CONFIG_VIDEO_CPIA2 is not set=0A# CO=
NFIG_VIDEO_SAA5246A is not set=0A# CONFIG_VIDEO_SAA5249 is not set=0A# CONF=
IG_VIDEO_STRADIS is not set=0A# CONFIG_VIDEO_ZORAN is not set=0A# CONFIG_VI=
DEO_SAA7134 is not set=0A# CONFIG_VIDEO_MXB is not set=0A# CONFIG_VIDEO_HEX=
IUM_ORION is not set=0A# CONFIG_VIDEO_HEXIUM_GEMINI is not set=0A# CONFIG_V=
IDEO_CX88 is not set=0A# CONFIG_VIDEO_IVTV is not set=0A# CONFIG_VIDEO_CAFE=
_CCIC is not set=0A# CONFIG_SOC_CAMERA is not set=0ACONFIG_V4L_USB_DRIVERS=
=3Dy=0A# CONFIG_USB_VIDEO_CLASS is not set=0ACONFIG_USB_VIDEO_CLASS_INPUT_E=
VDEV=3Dy=0ACONFIG_USB_GSPCA=3Dm=0ACONFIG_USB_M5602=3Dm=0ACONFIG_USB_STV06XX=
=3Dm=0ACONFIG_USB_GL860=3Dm=0ACONFIG_USB_GSPCA_CONEX=3Dm=0ACONFIG_USB_GSPCA=
_ETOMS=3Dm=0ACONFIG_USB_GSPCA_FINEPIX=3Dm=0ACONFIG_USB_GSPCA_JEILINJ=3Dm=0A=
CONFIG_USB_GSPCA_MARS=3Dm=0ACONFIG_USB_GSPCA_MR97310A=3Dm=0ACONFIG_USB_GSPC=
A_OV519=3Dm=0ACONFIG_USB_GSPCA_OV534=3Dm=0ACONFIG_USB_GSPCA_PAC207=3Dm=0ACO=
NFIG_USB_GSPCA_PAC7311=3Dm=0ACONFIG_USB_GSPCA_SN9C20X=3Dm=0A# CONFIG_USB_GS=
PCA_SN9C20X_EVDEV is not set=0ACONFIG_USB_GSPCA_SONIXB=3Dm=0ACONFIG_USB_GSP=
CA_SONIXJ=3Dm=0ACONFIG_USB_GSPCA_SPCA500=3Dm=0ACONFIG_USB_GSPCA_SPCA501=3Dm=
=0ACONFIG_USB_GSPCA_SPCA505=3Dm=0ACONFIG_USB_GSPCA_SPCA506=3Dm=0ACONFIG_USB=
_GSPCA_SPCA508=3Dm=0ACONFIG_USB_GSPCA_SPCA561=3Dm=0ACONFIG_USB_GSPCA_SQ905=
=3Dm=0ACONFIG_USB_GSPCA_SQ905C=3Dm=0ACONFIG_USB_GSPCA_STK014=3Dm=0ACONFIG_U=
SB_GSPCA_SUNPLUS=3Dm=0ACONFIG_USB_GSPCA_T613=3Dm=0ACONFIG_USB_GSPCA_TV8532=
=3Dm=0ACONFIG_USB_GSPCA_VC032X=3Dm=0ACONFIG_USB_GSPCA_ZC3XX=3Dm=0A# CONFIG_=
VIDEO_PVRUSB2 is not set=0A# CONFIG_VIDEO_HDPVR is not set=0A# CONFIG_VIDEO=
_EM28XX is not set=0A# CONFIG_VIDEO_CX231XX is not set=0A# CONFIG_VIDEO_USB=
VISION is not set=0A# CONFIG_USB_VICAM is not set=0A# CONFIG_USB_IBMCAM is =
not set=0A# CONFIG_USB_KONICAWC is not set=0A# CONFIG_USB_QUICKCAM_MESSENGE=
R is not set=0A# CONFIG_USB_ET61X251 is not set=0A# CONFIG_VIDEO_OVCAMCHIP =
is not set=0A# CONFIG_USB_OV511 is not set=0A# CONFIG_USB_SE401 is not set=
=0A# CONFIG_USB_SN9C102 is not set=0A# CONFIG_USB_STV680 is not set=0A# CON=
FIG_USB_ZC0301 is not set=0A# CONFIG_USB_PWC is not set=0ACONFIG_USB_PWC_IN=
PUT_EVDEV=3Dy=0A# CONFIG_USB_ZR364XX is not set=0A# CONFIG_USB_STKWEBCAM is=
 not set=0A# CONFIG_USB_S2255 is not set=0A# CONFIG_RADIO_ADAPTERS is not s=
et=0ACONFIG_DAB=3Dy=0A# CONFIG_USB_DABUSB is not set=0A=0A#=0A# Graphics su=
pport=0A#=0ACONFIG_AGP=3Dy=0A# CONFIG_AGP_ALI is not set=0A# CONFIG_AGP_ATI=
 is not set=0A# CONFIG_AGP_AMD is not set=0ACONFIG_AGP_AMD64=3Dy=0ACONFIG_A=
GP_INTEL=3Dy=0A# CONFIG_AGP_NVIDIA is not set=0A# CONFIG_AGP_SIS is not set=
=0A# CONFIG_AGP_SWORKS is not set=0A# CONFIG_AGP_VIA is not set=0A# CONFIG_=
AGP_EFFICEON is not set=0ACONFIG_VGA_ARB=3Dy=0ACONFIG_DRM=3Dy=0ACONFIG_DRM_=
KMS_HELPER=3Dy=0A# CONFIG_DRM_TDFX is not set=0A# CONFIG_DRM_R128 is not se=
t=0A# CONFIG_DRM_RADEON is not set=0A# CONFIG_DRM_I810 is not set=0A# CONFI=
G_DRM_I830 is not set=0ACONFIG_DRM_I915=3Dy=0A# CONFIG_DRM_I915_KMS is not =
set=0A# CONFIG_DRM_MGA is not set=0A# CONFIG_DRM_SIS is not set=0A# CONFIG_=
DRM_VIA is not set=0A# CONFIG_DRM_SAVAGE is not set=0A# CONFIG_VGASTATE is =
not set=0ACONFIG_VIDEO_OUTPUT_CONTROL=3Dy=0ACONFIG_FB=3Dy=0A# CONFIG_FIRMWA=
RE_EDID is not set=0ACONFIG_FB_DDC=3Dm=0A# CONFIG_FB_BOOT_VESA_SUPPORT is n=
ot set=0ACONFIG_FB_CFB_FILLRECT=3Dy=0ACONFIG_FB_CFB_COPYAREA=3Dy=0ACONFIG_F=
B_CFB_IMAGEBLIT=3Dy=0A# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set=0A# CON=
FIG_FB_SYS_FILLRECT is not set=0A# CONFIG_FB_SYS_COPYAREA is not set=0A# CO=
NFIG_FB_SYS_IMAGEBLIT is not set=0A# CONFIG_FB_FOREIGN_ENDIAN is not set=0A=
# CONFIG_FB_SYS_FOPS is not set=0A# CONFIG_FB_SVGALIB is not set=0A# CONFIG=
_FB_MACMODES is not set=0ACONFIG_FB_BACKLIGHT=3Dy=0ACONFIG_FB_MODE_HELPERS=
=3Dy=0ACONFIG_FB_TILEBLITTING=3Dy=0A=0A#=0A# Frame buffer hardware drivers=
=0A#=0A# CONFIG_FB_CIRRUS is not set=0A# CONFIG_FB_PM2 is not set=0A# CONFI=
G_FB_CYBER2000 is not set=0A# CONFIG_FB_ARC is not set=0A# CONFIG_FB_ASILIA=
NT is not set=0A# CONFIG_FB_IMSTT is not set=0A# CONFIG_FB_VGA16 is not set=
=0A# CONFIG_FB_UVESA is not set=0A# CONFIG_FB_VESA is not set=0ACONFIG_FB_E=
FI=3Dy=0A# CONFIG_FB_N411 is not set=0A# CONFIG_FB_HGA is not set=0A# CONFI=
G_FB_S1D13XXX is not set=0A# CONFIG_FB_NVIDIA is not set=0A# CONFIG_FB_RIVA=
 is not set=0A# CONFIG_FB_I810 is not set=0A# CONFIG_FB_LE80578 is not set=
=0A# CONFIG_FB_MATROX is not set=0ACONFIG_FB_RADEON=3Dm=0ACONFIG_FB_RADEON_=
I2C=3Dy=0ACONFIG_FB_RADEON_BACKLIGHT=3Dy=0A# CONFIG_FB_RADEON_DEBUG is not =
set=0A# CONFIG_FB_ATY128 is not set=0A# CONFIG_FB_ATY is not set=0A# CONFIG=
_FB_S3 is not set=0A# CONFIG_FB_SAVAGE is not set=0A# CONFIG_FB_SIS is not =
set=0A# CONFIG_FB_VIA is not set=0A# CONFIG_FB_NEOMAGIC is not set=0A# CONF=
IG_FB_KYRO is not set=0A# CONFIG_FB_3DFX is not set=0A# CONFIG_FB_VOODOO1 i=
s not set=0A# CONFIG_FB_VT8623 is not set=0A# CONFIG_FB_TRIDENT is not set=
=0A# CONFIG_FB_ARK is not set=0A# CONFIG_FB_PM3 is not set=0A# CONFIG_FB_CA=
RMINE is not set=0A# CONFIG_FB_GEODE is not set=0A# CONFIG_FB_VIRTUAL is no=
t set=0A# CONFIG_FB_METRONOME is not set=0A# CONFIG_FB_MB862XX is not set=
=0A# CONFIG_FB_BROADSHEET is not set=0ACONFIG_BACKLIGHT_LCD_SUPPORT=3Dy=0A#=
 CONFIG_LCD_CLASS_DEVICE is not set=0ACONFIG_BACKLIGHT_CLASS_DEVICE=3Dy=0AC=
ONFIG_BACKLIGHT_GENERIC=3Dy=0A# CONFIG_BACKLIGHT_PROGEAR is not set=0A# CON=
FIG_BACKLIGHT_MBP_NVIDIA is not set=0A# CONFIG_BACKLIGHT_SAHARA is not set=
=0A=0A#=0A# Display device support=0A#=0A# CONFIG_DISPLAY_SUPPORT is not se=
t=0A=0A#=0A# Console display driver support=0A#=0ACONFIG_VGA_CONSOLE=3Dy=0A=
CONFIG_VGACON_SOFT_SCROLLBACK=3Dy=0ACONFIG_VGACON_SOFT_SCROLLBACK_SIZE=3D12=
8=0ACONFIG_DUMMY_CONSOLE=3Dy=0ACONFIG_FRAMEBUFFER_CONSOLE=3Dy=0A# CONFIG_FR=
AMEBUFFER_CONSOLE_DETECT_PRIMARY is not set=0A# CONFIG_FRAMEBUFFER_CONSOLE_=
ROTATION is not set=0ACONFIG_FONTS=3Dy=0A# CONFIG_FONT_8x8 is not set=0ACON=
FIG_FONT_8x16=3Dy=0A# CONFIG_FONT_6x11 is not set=0A# CONFIG_FONT_7x14 is n=
ot set=0A# CONFIG_FONT_PEARL_8x8 is not set=0A# CONFIG_FONT_ACORN_8x8 is no=
t set=0A# CONFIG_FONT_MINI_4x6 is not set=0A# CONFIG_FONT_SUN8x16 is not se=
t=0A# CONFIG_FONT_SUN12x22 is not set=0A# CONFIG_FONT_10x18 is not set=0A# =
CONFIG_LOGO is not set=0ACONFIG_SOUND=3Dy=0ACONFIG_SOUND_OSS_CORE=3Dy=0ACON=
FIG_SOUND_OSS_CORE_PRECLAIM=3Dy=0ACONFIG_SND=3Dy=0ACONFIG_SND_TIMER=3Dy=0AC=
ONFIG_SND_PCM=3Dy=0ACONFIG_SND_HWDEP=3Dy=0ACONFIG_SND_SEQUENCER=3Dy=0ACONFI=
G_SND_SEQ_DUMMY=3Dy=0ACONFIG_SND_OSSEMUL=3Dy=0ACONFIG_SND_MIXER_OSS=3Dy=0AC=
ONFIG_SND_PCM_OSS=3Dy=0ACONFIG_SND_PCM_OSS_PLUGINS=3Dy=0ACONFIG_SND_SEQUENC=
ER_OSS=3Dy=0ACONFIG_SND_HRTIMER=3Dy=0ACONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy=0A=
CONFIG_SND_DYNAMIC_MINORS=3Dy=0ACONFIG_SND_SUPPORT_OLD_API=3Dy=0ACONFIG_SND=
_VERBOSE_PROCFS=3Dy=0A# CONFIG_SND_VERBOSE_PRINTK is not set=0A# CONFIG_SND=
_DEBUG is not set=0ACONFIG_SND_VMASTER=3Dy=0ACONFIG_SND_DMA_SGBUF=3Dy=0A# C=
ONFIG_SND_RAWMIDI_SEQ is not set=0A# CONFIG_SND_OPL3_LIB_SEQ is not set=0A#=
 CONFIG_SND_OPL4_LIB_SEQ is not set=0A# CONFIG_SND_SBAWE_SEQ is not set=0A#=
 CONFIG_SND_EMU10K1_SEQ is not set=0ACONFIG_SND_AC97_CODEC=3Dm=0ACONFIG_SND=
_DRIVERS=3Dy=0A# CONFIG_SND_PCSP is not set=0A# CONFIG_SND_DUMMY is not set=
=0A# CONFIG_SND_VIRMIDI is not set=0A# CONFIG_SND_MTPAV is not set=0A# CONF=
IG_SND_SERIAL_U16550 is not set=0A# CONFIG_SND_MPU401 is not set=0A# CONFIG=
_SND_AC97_POWER_SAVE is not set=0ACONFIG_SND_PCI=3Dy=0A# CONFIG_SND_AD1889 =
is not set=0A# CONFIG_SND_ALS300 is not set=0A# CONFIG_SND_ALS4000 is not s=
et=0A# CONFIG_SND_ALI5451 is not set=0A# CONFIG_SND_ATIIXP is not set=0A# C=
ONFIG_SND_ATIIXP_MODEM is not set=0A# CONFIG_SND_AU8810 is not set=0A# CONF=
IG_SND_AU8820 is not set=0A# CONFIG_SND_AU8830 is not set=0A# CONFIG_SND_AW=
2 is not set=0A# CONFIG_SND_AZT3328 is not set=0A# CONFIG_SND_BT87X is not =
set=0A# CONFIG_SND_CA0106 is not set=0A# CONFIG_SND_CMIPCI is not set=0A# C=
ONFIG_SND_OXYGEN is not set=0A# CONFIG_SND_CS4281 is not set=0A# CONFIG_SND=
_CS46XX is not set=0A# CONFIG_SND_CS5530 is not set=0A# CONFIG_SND_CS5535AU=
DIO is not set=0A# CONFIG_SND_CTXFI is not set=0A# CONFIG_SND_DARLA20 is no=
t set=0A# CONFIG_SND_GINA20 is not set=0A# CONFIG_SND_LAYLA20 is not set=0A=
# CONFIG_SND_DARLA24 is not set=0A# CONFIG_SND_GINA24 is not set=0A# CONFIG=
_SND_LAYLA24 is not set=0A# CONFIG_SND_MONA is not set=0A# CONFIG_SND_MIA i=
s not set=0A# CONFIG_SND_ECHO3G is not set=0A# CONFIG_SND_INDIGO is not set=
=0A# CONFIG_SND_INDIGOIO is not set=0A# CONFIG_SND_INDIGODJ is not set=0A# =
CONFIG_SND_INDIGOIOX is not set=0A# CONFIG_SND_INDIGODJX is not set=0A# CON=
FIG_SND_EMU10K1 is not set=0A# CONFIG_SND_EMU10K1X is not set=0A# CONFIG_SN=
D_ENS1370 is not set=0A# CONFIG_SND_ENS1371 is not set=0A# CONFIG_SND_ES193=
8 is not set=0A# CONFIG_SND_ES1968 is not set=0A# CONFIG_SND_FM801 is not s=
et=0ACONFIG_SND_HDA_INTEL=3Dy=0ACONFIG_SND_HDA_HWDEP=3Dy=0A# CONFIG_SND_HDA=
_RECONFIG is not set=0A# CONFIG_SND_HDA_INPUT_BEEP is not set=0A# CONFIG_SN=
D_HDA_INPUT_JACK is not set=0A# CONFIG_SND_HDA_PATCH_LOADER is not set=0ACO=
NFIG_SND_HDA_CODEC_REALTEK=3Dy=0ACONFIG_SND_HDA_CODEC_ANALOG=3Dy=0ACONFIG_S=
ND_HDA_CODEC_SIGMATEL=3Dy=0ACONFIG_SND_HDA_CODEC_VIA=3Dy=0ACONFIG_SND_HDA_C=
ODEC_ATIHDMI=3Dy=0ACONFIG_SND_HDA_CODEC_NVHDMI=3Dy=0ACONFIG_SND_HDA_CODEC_I=
NTELHDMI=3Dy=0ACONFIG_SND_HDA_ELD=3Dy=0ACONFIG_SND_HDA_CODEC_CIRRUS=3Dy=0AC=
ONFIG_SND_HDA_CODEC_CONEXANT=3Dy=0ACONFIG_SND_HDA_CODEC_CA0110=3Dy=0ACONFIG=
_SND_HDA_CODEC_CMEDIA=3Dy=0ACONFIG_SND_HDA_CODEC_SI3054=3Dy=0ACONFIG_SND_HD=
A_GENERIC=3Dy=0A# CONFIG_SND_HDA_POWER_SAVE is not set=0A# CONFIG_SND_HDSP =
is not set=0A# CONFIG_SND_HDSPM is not set=0A# CONFIG_SND_HIFIER is not set=
=0A# CONFIG_SND_ICE1712 is not set=0A# CONFIG_SND_ICE1724 is not set=0ACONF=
IG_SND_INTEL8X0=3Dm=0ACONFIG_SND_INTEL8X0M=3Dm=0A# CONFIG_SND_KORG1212 is n=
ot set=0A# CONFIG_SND_LX6464ES is not set=0A# CONFIG_SND_MAESTRO3 is not se=
t=0A# CONFIG_SND_MIXART is not set=0A# CONFIG_SND_NM256 is not set=0A# CONF=
IG_SND_PCXHR is not set=0A# CONFIG_SND_RIPTIDE is not set=0A# CONFIG_SND_RM=
E32 is not set=0A# CONFIG_SND_RME96 is not set=0A# CONFIG_SND_RME9652 is no=
t set=0A# CONFIG_SND_SIS7019 is not set=0A# CONFIG_SND_SONICVIBES is not se=
t=0A# CONFIG_SND_TRIDENT is not set=0A# CONFIG_SND_VIA82XX is not set=0A# C=
ONFIG_SND_VIA82XX_MODEM is not set=0A# CONFIG_SND_VIRTUOSO is not set=0A# C=
ONFIG_SND_VX222 is not set=0A# CONFIG_SND_YMFPCI is not set=0A# CONFIG_SND_=
USB is not set=0A# CONFIG_SND_SOC is not set=0A# CONFIG_SOUND_PRIME is not =
set=0ACONFIG_AC97_BUS=3Dm=0ACONFIG_HID_SUPPORT=3Dy=0ACONFIG_HID=3Dy=0ACONFI=
G_HIDRAW=3Dy=0A=0A#=0A# USB Input Devices=0A#=0ACONFIG_USB_HID=3Dy=0ACONFIG=
_HID_PID=3Dy=0ACONFIG_USB_HIDDEV=3Dy=0A=0A#=0A# Special HID drivers=0A#=0AC=
ONFIG_HID_A4TECH=3Dy=0ACONFIG_HID_APPLE=3Dy=0ACONFIG_HID_BELKIN=3Dy=0ACONFI=
G_HID_CHERRY=3Dy=0ACONFIG_HID_CHICONY=3Dy=0ACONFIG_HID_CYPRESS=3Dy=0ACONFIG=
_HID_DRAGONRISE=3Dy=0A# CONFIG_DRAGONRISE_FF is not set=0ACONFIG_HID_EZKEY=
=3Dy=0ACONFIG_HID_KYE=3Dy=0ACONFIG_HID_GYRATION=3Dy=0ACONFIG_HID_TWINHAN=3D=
y=0ACONFIG_HID_KENSINGTON=3Dy=0ACONFIG_HID_LOGITECH=3Dy=0ACONFIG_LOGITECH_F=
F=3Dy=0A# CONFIG_LOGIRUMBLEPAD2_FF is not set=0ACONFIG_HID_MICROSOFT=3Dy=0A=
CONFIG_HID_MONTEREY=3Dy=0ACONFIG_HID_NTRIG=3Dy=0ACONFIG_HID_PANTHERLORD=3Dy=
=0ACONFIG_PANTHERLORD_FF=3Dy=0ACONFIG_HID_PETALYNX=3Dy=0ACONFIG_HID_SAMSUNG=
=3Dy=0ACONFIG_HID_SONY=3Dy=0ACONFIG_HID_SUNPLUS=3Dy=0ACONFIG_HID_GREENASIA=
=3Dy=0A# CONFIG_GREENASIA_FF is not set=0ACONFIG_HID_SMARTJOYPLUS=3Dy=0A# C=
ONFIG_SMARTJOYPLUS_FF is not set=0ACONFIG_HID_TOPSEED=3Dy=0ACONFIG_HID_THRU=
STMASTER=3Dy=0ACONFIG_THRUSTMASTER_FF=3Dy=0ACONFIG_HID_ZEROPLUS=3Dy=0ACONFI=
G_ZEROPLUS_FF=3Dy=0ACONFIG_USB_SUPPORT=3Dy=0ACONFIG_USB_ARCH_HAS_HCD=3Dy=0A=
CONFIG_USB_ARCH_HAS_OHCI=3Dy=0ACONFIG_USB_ARCH_HAS_EHCI=3Dy=0ACONFIG_USB=3D=
y=0ACONFIG_USB_DEBUG=3Dy=0ACONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy=0A=0A#=0A# M=
iscellaneous USB options=0A#=0ACONFIG_USB_DEVICEFS=3Dy=0A# CONFIG_USB_DEVIC=
E_CLASS is not set=0A# CONFIG_USB_DYNAMIC_MINORS is not set=0ACONFIG_USB_SU=
SPEND=3Dy=0A# CONFIG_USB_OTG is not set=0ACONFIG_USB_MON=3Dy=0A# CONFIG_USB=
_WUSB is not set=0A# CONFIG_USB_WUSB_CBAF is not set=0A=0A#=0A# USB Host Co=
ntroller Drivers=0A#=0A# CONFIG_USB_C67X00_HCD is not set=0A# CONFIG_USB_XH=
CI_HCD is not set=0ACONFIG_USB_EHCI_HCD=3Dy=0A# CONFIG_USB_EHCI_ROOT_HUB_TT=
 is not set=0A# CONFIG_USB_EHCI_TT_NEWSCHED is not set=0A# CONFIG_USB_OXU21=
0HP_HCD is not set=0A# CONFIG_USB_ISP116X_HCD is not set=0A# CONFIG_USB_ISP=
1760_HCD is not set=0A# CONFIG_USB_ISP1362_HCD is not set=0ACONFIG_USB_OHCI=
_HCD=3Dy=0A# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set=0A# CONFIG_USB_OHCI=
_BIG_ENDIAN_MMIO is not set=0ACONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy=0ACONFIG_US=
B_UHCI_HCD=3Dy=0A# CONFIG_USB_SL811_HCD is not set=0A# CONFIG_USB_R8A66597_=
HCD is not set=0A# CONFIG_USB_WHCI_HCD is not set=0A# CONFIG_USB_HWA_HCD is=
 not set=0A=0A#=0A# USB Device Class drivers=0A#=0A# CONFIG_USB_ACM is not =
set=0ACONFIG_USB_PRINTER=3Dy=0A# CONFIG_USB_WDM is not set=0A# CONFIG_USB_T=
MC is not set=0A=0A#=0A# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD m=
ay=0A#=0A=0A#=0A# also be needed; see USB_STORAGE Help for more info=0A#=0A=
CONFIG_USB_STORAGE=3Dy=0A# CONFIG_USB_STORAGE_DEBUG is not set=0ACONFIG_USB=
_STORAGE_DATAFAB=3Dm=0A# CONFIG_USB_STORAGE_FREECOM is not set=0A# CONFIG_U=
SB_STORAGE_ISD200 is not set=0ACONFIG_USB_STORAGE_USBAT=3Dm=0ACONFIG_USB_ST=
ORAGE_SDDR09=3Dm=0ACONFIG_USB_STORAGE_SDDR55=3Dm=0ACONFIG_USB_STORAGE_JUMPS=
HOT=3Dm=0ACONFIG_USB_STORAGE_ALAUDA=3Dm=0A# CONFIG_USB_STORAGE_ONETOUCH is =
not set=0A# CONFIG_USB_STORAGE_KARMA is not set=0A# CONFIG_USB_STORAGE_CYPR=
ESS_ATACB is not set=0ACONFIG_USB_LIBUSUAL=3Dy=0A=0A#=0A# USB Imaging devic=
es=0A#=0A# CONFIG_USB_MDC800 is not set=0A# CONFIG_USB_MICROTEK is not set=
=0A=0A#=0A# USB port drivers=0A#=0A# CONFIG_USB_SERIAL is not set=0A=0A#=0A=
# USB Miscellaneous drivers=0A#=0A# CONFIG_USB_EMI62 is not set=0A# CONFIG_=
USB_EMI26 is not set=0A# CONFIG_USB_ADUTUX is not set=0A# CONFIG_USB_SEVSEG=
 is not set=0A# CONFIG_USB_RIO500 is not set=0A# CONFIG_USB_LEGOTOWER is no=
t set=0A# CONFIG_USB_LCD is not set=0A# CONFIG_USB_BERRY_CHARGE is not set=
=0A# CONFIG_USB_LED is not set=0A# CONFIG_USB_CYPRESS_CY7C63 is not set=0A#=
 CONFIG_USB_CYTHERM is not set=0A# CONFIG_USB_IDMOUSE is not set=0A# CONFIG=
_USB_FTDI_ELAN is not set=0A# CONFIG_USB_APPLEDISPLAY is not set=0A# CONFIG=
_USB_SISUSBVGA is not set=0ACONFIG_USB_LD=3Dm=0A# CONFIG_USB_TRANCEVIBRATOR=
 is not set=0A# CONFIG_USB_IOWARRIOR is not set=0A# CONFIG_USB_TEST is not =
set=0A# CONFIG_USB_ISIGHTFW is not set=0A# CONFIG_USB_VST is not set=0A# CO=
NFIG_USB_GADGET is not set=0A=0A#=0A# OTG and related infrastructure=0A#=0A=
# CONFIG_NOP_USB_XCEIV is not set=0A# CONFIG_UWB is not set=0ACONFIG_MMC=3D=
m=0A# CONFIG_MMC_DEBUG is not set=0A# CONFIG_MMC_UNSAFE_RESUME is not set=
=0A=0A#=0A# MMC/SD/SDIO Card Drivers=0A#=0ACONFIG_MMC_BLOCK=3Dm=0ACONFIG_MM=
C_BLOCK_BOUNCE=3Dy=0A# CONFIG_SDIO_UART is not set=0A# CONFIG_MMC_TEST is n=
ot set=0A=0A#=0A# MMC/SD/SDIO Host Controller Drivers=0A#=0A# CONFIG_MMC_SD=
HCI is not set=0A# CONFIG_MMC_WBSD is not set=0A# CONFIG_MMC_AT91 is not se=
t=0A# CONFIG_MMC_ATMELMCI is not set=0A# CONFIG_MMC_TIFM_SD is not set=0A# =
CONFIG_MMC_CB710 is not set=0ACONFIG_MMC_VIA_SDMMC=3Dm=0A# CONFIG_MEMSTICK =
is not set=0ACONFIG_NEW_LEDS=3Dy=0ACONFIG_LEDS_CLASS=3Dy=0A=0A#=0A# LED dri=
vers=0A#=0A# CONFIG_LEDS_ALIX2 is not set=0A# CONFIG_LEDS_PCA9532 is not se=
t=0A# CONFIG_LEDS_LP3944 is not set=0A# CONFIG_LEDS_CLEVO_MAIL is not set=
=0A# CONFIG_LEDS_PCA955X is not set=0A# CONFIG_LEDS_BD2802 is not set=0A=0A=
#=0A# LED Triggers=0A#=0ACONFIG_LEDS_TRIGGERS=3Dy=0A# CONFIG_LEDS_TRIGGER_T=
IMER is not set=0A# CONFIG_LEDS_TRIGGER_IDE_DISK is not set=0A# CONFIG_LEDS=
_TRIGGER_HEARTBEAT is not set=0A# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set=
=0A# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set=0A=0A#=0A# iptables trigger =
is under Netfilter config (LED target)=0A#=0A# CONFIG_ACCESSIBILITY is not =
set=0A# CONFIG_INFINIBAND is not set=0ACONFIG_EDAC=3Dy=0A=0A#=0A# Reporting=
 subsystems=0A#=0A# CONFIG_EDAC_DEBUG is not set=0ACONFIG_EDAC_DECODE_MCE=
=3Dy=0A# CONFIG_EDAC_MM_EDAC is not set=0ACONFIG_RTC_LIB=3Dy=0ACONFIG_RTC_C=
LASS=3Dy=0A# CONFIG_RTC_HCTOSYS is not set=0A# CONFIG_RTC_DEBUG is not set=
=0A=0A#=0A# RTC interfaces=0A#=0ACONFIG_RTC_INTF_SYSFS=3Dy=0ACONFIG_RTC_INT=
F_PROC=3Dy=0ACONFIG_RTC_INTF_DEV=3Dy=0A# CONFIG_RTC_INTF_DEV_UIE_EMUL is no=
t set=0A# CONFIG_RTC_DRV_TEST is not set=0A=0A#=0A# I2C RTC drivers=0A#=0A#=
 CONFIG_RTC_DRV_DS1307 is not set=0A# CONFIG_RTC_DRV_DS1374 is not set=0A# =
CONFIG_RTC_DRV_DS1672 is not set=0A# CONFIG_RTC_DRV_MAX6900 is not set=0A# =
CONFIG_RTC_DRV_RS5C372 is not set=0A# CONFIG_RTC_DRV_ISL1208 is not set=0A#=
 CONFIG_RTC_DRV_X1205 is not set=0A# CONFIG_RTC_DRV_PCF8563 is not set=0A# =
CONFIG_RTC_DRV_PCF8583 is not set=0A# CONFIG_RTC_DRV_M41T80 is not set=0A# =
CONFIG_RTC_DRV_S35390A is not set=0A# CONFIG_RTC_DRV_FM3130 is not set=0A# =
CONFIG_RTC_DRV_RX8581 is not set=0A# CONFIG_RTC_DRV_RX8025 is not set=0A=0A=
#=0A# SPI RTC drivers=0A#=0A=0A#=0A# Platform RTC drivers=0A#=0ACONFIG_RTC_=
DRV_CMOS=3Dy=0A# CONFIG_RTC_DRV_DS1286 is not set=0A# CONFIG_RTC_DRV_DS1511=
 is not set=0A# CONFIG_RTC_DRV_DS1553 is not set=0A# CONFIG_RTC_DRV_DS1742 =
is not set=0A# CONFIG_RTC_DRV_STK17TA8 is not set=0A# CONFIG_RTC_DRV_M48T86=
 is not set=0A# CONFIG_RTC_DRV_M48T35 is not set=0A# CONFIG_RTC_DRV_M48T59 =
is not set=0A# CONFIG_RTC_DRV_BQ4802 is not set=0A# CONFIG_RTC_DRV_V3020 is=
 not set=0A=0A#=0A# on-CPU RTC drivers=0A#=0ACONFIG_DMADEVICES=3Dy=0A=0A#=
=0A# DMA Devices=0A#=0A# CONFIG_INTEL_IOATDMA is not set=0A# CONFIG_AUXDISP=
LAY is not set=0A# CONFIG_UIO is not set=0A=0A#=0A# TI VLYNQ=0A#=0A# CONFIG=
_STAGING is not set=0ACONFIG_X86_PLATFORM_DEVICES=3Dy=0A# CONFIG_ACER_WMI i=
s not set=0A# CONFIG_ACERHDF is not set=0A# CONFIG_ASUS_LAPTOP is not set=
=0A# CONFIG_FUJITSU_LAPTOP is not set=0A# CONFIG_TC1100_WMI is not set=0A# =
CONFIG_MSI_LAPTOP is not set=0A# CONFIG_PANASONIC_LAPTOP is not set=0A# CON=
FIG_COMPAL_LAPTOP is not set=0A# CONFIG_SONY_LAPTOP is not set=0A# CONFIG_T=
HINKPAD_ACPI is not set=0A# CONFIG_INTEL_MENLOW is not set=0A# CONFIG_ACPI_=
WMI is not set=0A# CONFIG_ACPI_ASUS is not set=0A# CONFIG_TOPSTAR_LAPTOP is=
 not set=0A# CONFIG_ACPI_TOSHIBA is not set=0A=0A#=0A# Firmware Drivers=0A#=
=0A# CONFIG_EDD is not set=0ACONFIG_FIRMWARE_MEMMAP=3Dy=0ACONFIG_EFI_VARS=
=3Dy=0A# CONFIG_DELL_RBU is not set=0A# CONFIG_DCDBAS is not set=0ACONFIG_D=
MIID=3Dy=0A# CONFIG_ISCSI_IBFT_FIND is not set=0A=0A#=0A# File systems=0A#=
=0ACONFIG_EXT2_FS=3Dm=0A# CONFIG_EXT2_FS_XATTR is not set=0A# CONFIG_EXT2_F=
S_XIP is not set=0ACONFIG_EXT3_FS=3Dy=0A# CONFIG_EXT3_DEFAULTS_TO_ORDERED i=
s not set=0ACONFIG_EXT3_FS_XATTR=3Dy=0ACONFIG_EXT3_FS_POSIX_ACL=3Dy=0ACONFI=
G_EXT3_FS_SECURITY=3Dy=0ACONFIG_EXT4_FS=3Dm=0ACONFIG_EXT4_FS_XATTR=3Dy=0A# =
CONFIG_EXT4_FS_POSIX_ACL is not set=0A# CONFIG_EXT4_FS_SECURITY is not set=
=0A# CONFIG_EXT4_DEBUG is not set=0ACONFIG_JBD=3Dy=0ACONFIG_JBD2=3Dm=0ACONF=
IG_FS_MBCACHE=3Dy=0A# CONFIG_REISERFS_FS is not set=0A# CONFIG_JFS_FS is no=
t set=0ACONFIG_FS_POSIX_ACL=3Dy=0A# CONFIG_XFS_FS is not set=0A# CONFIG_GFS=
2_FS is not set=0A# CONFIG_OCFS2_FS is not set=0A# CONFIG_BTRFS_FS is not s=
et=0A# CONFIG_NILFS2_FS is not set=0ACONFIG_FILE_LOCKING=3Dy=0ACONFIG_FSNOT=
IFY=3Dy=0ACONFIG_DNOTIFY=3Dy=0ACONFIG_INOTIFY=3Dy=0ACONFIG_INOTIFY_USER=3Dy=
=0A# CONFIG_QUOTA is not set=0A# CONFIG_AUTOFS_FS is not set=0ACONFIG_AUTOF=
S4_FS=3Dy=0A# CONFIG_FUSE_FS is not set=0ACONFIG_GENERIC_ACL=3Dy=0A=0A#=0A#=
 Caches=0A#=0A# CONFIG_FSCACHE is not set=0A=0A#=0A# CD-ROM/DVD Filesystems=
=0A#=0ACONFIG_ISO9660_FS=3Dy=0ACONFIG_JOLIET=3Dy=0ACONFIG_ZISOFS=3Dy=0ACONF=
IG_UDF_FS=3Dm=0ACONFIG_UDF_NLS=3Dy=0A=0A#=0A# DOS/FAT/NT Filesystems=0A#=0A=
CONFIG_FAT_FS=3Dy=0ACONFIG_MSDOS_FS=3Dy=0ACONFIG_VFAT_FS=3Dy=0ACONFIG_FAT_D=
EFAULT_CODEPAGE=3D437=0ACONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"=0ACONFIG=
_NTFS_FS=3Dm=0A# CONFIG_NTFS_DEBUG is not set=0ACONFIG_NTFS_RW=3Dy=0A=0A#=
=0A# Pseudo filesystems=0A#=0ACONFIG_PROC_FS=3Dy=0ACONFIG_PROC_KCORE=3Dy=0A=
CONFIG_PROC_VMCORE=3Dy=0ACONFIG_PROC_SYSCTL=3Dy=0ACONFIG_PROC_PAGE_MONITOR=
=3Dy=0ACONFIG_SYSFS=3Dy=0ACONFIG_TMPFS=3Dy=0ACONFIG_TMPFS_POSIX_ACL=3Dy=0AC=
ONFIG_HUGETLBFS=3Dy=0ACONFIG_HUGETLB_PAGE=3Dy=0A# CONFIG_CONFIGFS_FS is not=
 set=0ACONFIG_MISC_FILESYSTEMS=3Dy=0A# CONFIG_ADFS_FS is not set=0A# CONFIG=
_AFFS_FS is not set=0A# CONFIG_ECRYPT_FS is not set=0A# CONFIG_HFS_FS is no=
t set=0A# CONFIG_HFSPLUS_FS is not set=0A# CONFIG_BEFS_FS is not set=0A# CO=
NFIG_BFS_FS is not set=0A# CONFIG_EFS_FS is not set=0A# CONFIG_CRAMFS is no=
t set=0A# CONFIG_SQUASHFS is not set=0A# CONFIG_VXFS_FS is not set=0A# CONF=
IG_MINIX_FS is not set=0A# CONFIG_OMFS_FS is not set=0A# CONFIG_HPFS_FS is =
not set=0A# CONFIG_QNX4FS_FS is not set=0A# CONFIG_ROMFS_FS is not set=0A# =
CONFIG_SYSV_FS is not set=0A# CONFIG_UFS_FS is not set=0ACONFIG_NETWORK_FIL=
ESYSTEMS=3Dy=0ACONFIG_NFS_FS=3Dy=0ACONFIG_NFS_V3=3Dy=0ACONFIG_NFS_V3_ACL=3D=
y=0ACONFIG_NFS_V4=3Dy=0A# CONFIG_NFS_V4_1 is not set=0ACONFIG_ROOT_NFS=3Dy=
=0A# CONFIG_NFSD is not set=0ACONFIG_LOCKD=3Dy=0ACONFIG_LOCKD_V4=3Dy=0ACONF=
IG_NFS_ACL_SUPPORT=3Dy=0ACONFIG_NFS_COMMON=3Dy=0ACONFIG_SUNRPC=3Dy=0ACONFIG=
_SUNRPC_GSS=3Dy=0ACONFIG_RPCSEC_GSS_KRB5=3Dy=0A# CONFIG_RPCSEC_GSS_SPKM3 is=
 not set=0ACONFIG_SMB_FS=3Dm=0ACONFIG_SMB_NLS_DEFAULT=3Dy=0ACONFIG_SMB_NLS_=
REMOTE=3D"cp437"=0ACONFIG_CIFS=3Dm=0A# CONFIG_CIFS_STATS is not set=0ACONFI=
G_CIFS_WEAK_PW_HASH=3Dy=0A# CONFIG_CIFS_UPCALL is not set=0A# CONFIG_CIFS_X=
ATTR is not set=0A# CONFIG_CIFS_DEBUG2 is not set=0A# CONFIG_CIFS_DFS_UPCAL=
L is not set=0A# CONFIG_CIFS_EXPERIMENTAL is not set=0A# CONFIG_NCP_FS is n=
ot set=0A# CONFIG_CODA_FS is not set=0A# CONFIG_AFS_FS is not set=0A=0A#=0A=
# Partition Types=0A#=0ACONFIG_PARTITION_ADVANCED=3Dy=0A# CONFIG_ACORN_PART=
ITION is not set=0ACONFIG_OSF_PARTITION=3Dy=0ACONFIG_AMIGA_PARTITION=3Dy=0A=
# CONFIG_ATARI_PARTITION is not set=0ACONFIG_MAC_PARTITION=3Dy=0ACONFIG_MSD=
OS_PARTITION=3Dy=0ACONFIG_BSD_DISKLABEL=3Dy=0ACONFIG_MINIX_SUBPARTITION=3Dy=
=0ACONFIG_SOLARIS_X86_PARTITION=3Dy=0ACONFIG_UNIXWARE_DISKLABEL=3Dy=0A# CON=
FIG_LDM_PARTITION is not set=0ACONFIG_SGI_PARTITION=3Dy=0A# CONFIG_ULTRIX_P=
ARTITION is not set=0ACONFIG_SUN_PARTITION=3Dy=0ACONFIG_KARMA_PARTITION=3Dy=
=0ACONFIG_EFI_PARTITION=3Dy=0A# CONFIG_SYSV68_PARTITION is not set=0ACONFIG=
_NLS=3Dy=0ACONFIG_NLS_DEFAULT=3D"utf8"=0ACONFIG_NLS_CODEPAGE_437=3Dy=0A# CO=
NFIG_NLS_CODEPAGE_737 is not set=0A# CONFIG_NLS_CODEPAGE_775 is not set=0AC=
ONFIG_NLS_CODEPAGE_850=3Dm=0ACONFIG_NLS_CODEPAGE_852=3Dm=0A# CONFIG_NLS_COD=
EPAGE_855 is not set=0A# CONFIG_NLS_CODEPAGE_857 is not set=0A# CONFIG_NLS_=
CODEPAGE_860 is not set=0A# CONFIG_NLS_CODEPAGE_861 is not set=0A# CONFIG_N=
LS_CODEPAGE_862 is not set=0A# CONFIG_NLS_CODEPAGE_863 is not set=0A# CONFI=
G_NLS_CODEPAGE_864 is not set=0A# CONFIG_NLS_CODEPAGE_865 is not set=0A# CO=
NFIG_NLS_CODEPAGE_866 is not set=0A# CONFIG_NLS_CODEPAGE_869 is not set=0A#=
 CONFIG_NLS_CODEPAGE_936 is not set=0A# CONFIG_NLS_CODEPAGE_950 is not set=
=0A# CONFIG_NLS_CODEPAGE_932 is not set=0A# CONFIG_NLS_CODEPAGE_949 is not =
set=0A# CONFIG_NLS_CODEPAGE_874 is not set=0A# CONFIG_NLS_ISO8859_8 is not =
set=0ACONFIG_NLS_CODEPAGE_1250=3Dm=0A# CONFIG_NLS_CODEPAGE_1251 is not set=
=0ACONFIG_NLS_ASCII=3Dy=0ACONFIG_NLS_ISO8859_1=3Dy=0ACONFIG_NLS_ISO8859_2=
=3Dm=0A# CONFIG_NLS_ISO8859_3 is not set=0A# CONFIG_NLS_ISO8859_4 is not se=
t=0A# CONFIG_NLS_ISO8859_5 is not set=0A# CONFIG_NLS_ISO8859_6 is not set=
=0A# CONFIG_NLS_ISO8859_7 is not set=0A# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_13 is not set=0A# CONFIG_NLS_ISO8859_14 is not set=0AC=
ONFIG_NLS_ISO8859_15=3Dm=0A# CONFIG_NLS_KOI8_R is not set=0A# CONFIG_NLS_KO=
I8_U is not set=0ACONFIG_NLS_UTF8=3Dy=0A# CONFIG_DLM is not set=0A=0A#=0A# =
Kernel hacking=0A#=0ACONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy=0A# CONFIG_PRINTK_TI=
ME is not set=0A# CONFIG_ENABLE_WARN_DEPRECATED is not set=0A# CONFIG_ENABL=
E_MUST_CHECK is not set=0ACONFIG_FRAME_WARN=3D2048=0A# CONFIG_MAGIC_SYSRQ i=
s not set=0A# CONFIG_STRIP_ASM_SYMS is not set=0A# CONFIG_UNUSED_SYMBOLS is=
 not set=0A# CONFIG_DEBUG_FS is not set=0A# CONFIG_HEADERS_CHECK is not set=
=0A# CONFIG_DEBUG_KERNEL is not set=0A# CONFIG_SLUB_DEBUG_ON is not set=0A#=
 CONFIG_SLUB_STATS is not set=0ACONFIG_DEBUG_BUGVERBOSE=3Dy=0ACONFIG_DEBUG_=
MEMORY_INIT=3Dy=0ACONFIG_ARCH_WANT_FRAME_POINTERS=3Dy=0A# CONFIG_FRAME_POIN=
TER is not set=0A# CONFIG_RCU_CPU_STALL_DETECTOR is not set=0A# CONFIG_LATE=
NCYTOP is not set=0A# CONFIG_SYSCTL_SYSCALL_CHECK is not set=0ACONFIG_USER_=
STACKTRACE_SUPPORT=3Dy=0ACONFIG_HAVE_FUNCTION_TRACER=3Dy=0ACONFIG_HAVE_FUNC=
TION_GRAPH_TRACER=3Dy=0ACONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=3Dy=0ACONFIG_HAV=
E_FUNCTION_TRACE_MCOUNT_TEST=3Dy=0ACONFIG_HAVE_DYNAMIC_FTRACE=3Dy=0ACONFIG_=
HAVE_FTRACE_MCOUNT_RECORD=3Dy=0ACONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy=0ACONFI=
G_TRACING_SUPPORT=3Dy=0A# CONFIG_FTRACE is not set=0A# CONFIG_PROVIDE_OHCI1=
394_DMA_INIT is not set=0A# CONFIG_DMA_API_DEBUG is not set=0A# CONFIG_SAMP=
LES is not set=0ACONFIG_HAVE_ARCH_KGDB=3Dy=0ACONFIG_HAVE_ARCH_KMEMCHECK=3Dy=
=0A# CONFIG_STRICT_DEVMEM is not set=0A# CONFIG_X86_VERBOSE_BOOTUP is not s=
et=0ACONFIG_EARLY_PRINTK=3Dy=0A# CONFIG_EARLY_PRINTK_DBGP is not set=0A# CO=
NFIG_4KSTACKS is not set=0ACONFIG_DOUBLEFAULT=3Dy=0A# CONFIG_IOMMU_STRESS i=
s not set=0ACONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy=0ACONFIG_IO_DELAY_TYPE_0X80=
=3D0=0ACONFIG_IO_DELAY_TYPE_0XED=3D1=0ACONFIG_IO_DELAY_TYPE_UDELAY=3D2=0ACO=
NFIG_IO_DELAY_TYPE_NONE=3D3=0ACONFIG_IO_DELAY_0X80=3Dy=0A# CONFIG_IO_DELAY_=
0XED is not set=0A# CONFIG_IO_DELAY_UDELAY is not set=0A# CONFIG_IO_DELAY_N=
ONE is not set=0ACONFIG_DEFAULT_IO_DELAY_TYPE=3D0=0A# CONFIG_OPTIMIZE_INLIN=
ING is not set=0A=0A#=0A# Security options=0A#=0ACONFIG_KEYS=3Dy=0ACONFIG_K=
EYS_DEBUG_PROC_KEYS=3Dy=0ACONFIG_SECURITY=3Dy=0A# CONFIG_SECURITYFS is not =
set=0ACONFIG_SECURITY_NETWORK=3Dy=0A# CONFIG_SECURITY_NETWORK_XFRM is not s=
et=0A# CONFIG_SECURITY_PATH is not set=0ACONFIG_SECURITY_FILE_CAPABILITIES=
=3Dy=0A# CONFIG_SECURITY_ROOTPLUG is not set=0A# CONFIG_SECURITY_SMACK is n=
ot set=0A# CONFIG_SECURITY_TOMOYO is not set=0A# CONFIG_IMA is not set=0ACO=
NFIG_CRYPTO=3Dy=0A=0A#=0A# Crypto core or helper=0A#=0ACONFIG_CRYPTO_ALGAPI=
=3Dy=0ACONFIG_CRYPTO_ALGAPI2=3Dy=0ACONFIG_CRYPTO_AEAD=3Dy=0ACONFIG_CRYPTO_A=
EAD2=3Dy=0ACONFIG_CRYPTO_BLKCIPHER=3Dy=0ACONFIG_CRYPTO_BLKCIPHER2=3Dy=0ACON=
FIG_CRYPTO_HASH=3Dy=0ACONFIG_CRYPTO_HASH2=3Dy=0ACONFIG_CRYPTO_RNG2=3Dy=0ACO=
NFIG_CRYPTO_PCOMP=3Dy=0ACONFIG_CRYPTO_MANAGER=3Dy=0ACONFIG_CRYPTO_MANAGER2=
=3Dy=0A# CONFIG_CRYPTO_GF128MUL is not set=0A# CONFIG_CRYPTO_NULL is not se=
t=0ACONFIG_CRYPTO_WORKQUEUE=3Dy=0A# CONFIG_CRYPTO_CRYPTD is not set=0ACONFI=
G_CRYPTO_AUTHENC=3Dy=0A# CONFIG_CRYPTO_TEST is not set=0A=0A#=0A# Authentic=
ated Encryption with Associated Data=0A#=0A# CONFIG_CRYPTO_CCM is not set=
=0A# CONFIG_CRYPTO_GCM is not set=0A# CONFIG_CRYPTO_SEQIV is not set=0A=0A#=
=0A# Block modes=0A#=0ACONFIG_CRYPTO_CBC=3Dy=0A# CONFIG_CRYPTO_CTR is not s=
et=0A# CONFIG_CRYPTO_CTS is not set=0ACONFIG_CRYPTO_ECB=3Dy=0A# CONFIG_CRYP=
TO_LRW is not set=0A# CONFIG_CRYPTO_PCBC is not set=0A# CONFIG_CRYPTO_XTS i=
s not set=0A=0A#=0A# Hash modes=0A#=0ACONFIG_CRYPTO_HMAC=3Dy=0A# CONFIG_CRY=
PTO_XCBC is not set=0A# CONFIG_CRYPTO_VMAC is not set=0A=0A#=0A# Digest=0A#=
=0A# CONFIG_CRYPTO_CRC32C is not set=0A# CONFIG_CRYPTO_CRC32C_INTEL is not =
set=0A# CONFIG_CRYPTO_GHASH is not set=0A# CONFIG_CRYPTO_MD4 is not set=0AC=
ONFIG_CRYPTO_MD5=3Dy=0A# CONFIG_CRYPTO_MICHAEL_MIC is not set=0A# CONFIG_CR=
YPTO_RMD128 is not set=0A# CONFIG_CRYPTO_RMD160 is not set=0A# CONFIG_CRYPT=
O_RMD256 is not set=0A# CONFIG_CRYPTO_RMD320 is not set=0ACONFIG_CRYPTO_SHA=
1=3Dy=0A# CONFIG_CRYPTO_SHA256 is not set=0A# CONFIG_CRYPTO_SHA512 is not s=
et=0A# CONFIG_CRYPTO_TGR192 is not set=0A# CONFIG_CRYPTO_WP512 is not set=
=0A=0A#=0A# Ciphers=0A#=0ACONFIG_CRYPTO_AES=3Dy=0ACONFIG_CRYPTO_AES_586=3Dy=
=0A# CONFIG_CRYPTO_ANUBIS is not set=0ACONFIG_CRYPTO_ARC4=3Dy=0A# CONFIG_CR=
YPTO_BLOWFISH is not set=0A# CONFIG_CRYPTO_CAMELLIA is not set=0A# CONFIG_C=
RYPTO_CAST5 is not set=0A# CONFIG_CRYPTO_CAST6 is not set=0ACONFIG_CRYPTO_D=
ES=3Dy=0A# CONFIG_CRYPTO_FCRYPT is not set=0A# CONFIG_CRYPTO_KHAZAD is not =
set=0A# CONFIG_CRYPTO_SALSA20 is not set=0A# CONFIG_CRYPTO_SALSA20_586 is n=
ot set=0A# CONFIG_CRYPTO_SEED is not set=0A# CONFIG_CRYPTO_SERPENT is not s=
et=0A# CONFIG_CRYPTO_TEA is not set=0A# CONFIG_CRYPTO_TWOFISH is not set=0A=
# CONFIG_CRYPTO_TWOFISH_586 is not set=0A=0A#=0A# Compression=0A#=0A# CONFI=
G_CRYPTO_DEFLATE is not set=0A# CONFIG_CRYPTO_ZLIB is not set=0A# CONFIG_CR=
YPTO_LZO is not set=0A=0A#=0A# Random Number Generation=0A#=0A# CONFIG_CRYP=
TO_ANSI_CPRNG is not set=0ACONFIG_CRYPTO_HW=3Dy=0A# CONFIG_CRYPTO_DEV_PADLO=
CK is not set=0A# CONFIG_CRYPTO_DEV_GEODE is not set=0A# CONFIG_CRYPTO_DEV_=
HIFN_795X is not set=0ACONFIG_HAVE_KVM=3Dy=0ACONFIG_VIRTUALIZATION=3Dy=0A# =
CONFIG_KVM is not set=0A# CONFIG_LGUEST is not set=0A# CONFIG_VIRTIO_PCI is=
 not set=0A# CONFIG_VIRTIO_BALLOON is not set=0A# CONFIG_BINARY_PRINTF is n=
ot set=0A=0A#=0A# Library routines=0A#=0ACONFIG_BITREVERSE=3Dy=0ACONFIG_GEN=
ERIC_FIND_FIRST_BIT=3Dy=0ACONFIG_GENERIC_FIND_NEXT_BIT=3Dy=0ACONFIG_GENERIC=
_FIND_LAST_BIT=3Dy=0A# CONFIG_CRC_CCITT is not set=0ACONFIG_CRC16=3Dm=0ACON=
FIG_CRC_T10DIF=3Dy=0ACONFIG_CRC_ITU_T=3Dm=0ACONFIG_CRC32=3Dy=0A# CONFIG_CRC=
7 is not set=0A# CONFIG_LIBCRC32C is not set=0ACONFIG_ZLIB_INFLATE=3Dy=0ACO=
NFIG_ZLIB_DEFLATE=3Dm=0ACONFIG_DECOMPRESS_GZIP=3Dy=0ACONFIG_DECOMPRESS_BZIP=
2=3Dy=0ACONFIG_DECOMPRESS_LZMA=3Dy=0ACONFIG_HAS_IOMEM=3Dy=0ACONFIG_HAS_IOPO=
RT=3Dy=0ACONFIG_HAS_DMA=3Dy=0ACONFIG_NLATTR=3Dy=0A
--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=fstab

# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
proc            /proc           proc    defaults        0       0
/dev/sda1       /               ext3    defaults,errors=remount-ro 0       1
/dev/sda5       none            swap    sw              0       0
#/dev/fd0        /media/floppy0  auto    rw,user,noauto  0       0
/dev/sdb1       /mnt/rack       auto    defaults,quiet,umask=000,user,noauto    0       0
/dev/sda3       /mnt/id         vfat    defaults,quiet,umask=000        0       0
/dev/sda2       /mnt/linux64    ext3    defaults        0       0
/dev/sda1       /mnt/usb        auto    noauto,user,umask=000   0       0
/dev/sr0	/media/cdrom0	auto	ro,defaults,user,noauto 0 0

--ZGiS0Q5IWpPtfppv--
