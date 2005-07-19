From: Jaap Crezee <jaap@jcz.nl>
Subject: Promise 378 TX2plus onboard chip
Date: Tue, 19 Jul 2005 12:53:00 +0200
Message-ID: <42DCDB8C.8040200@jcz.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jcz.nl ([62.212.87.46]:39390 "EHLO jcz.nl") by vger.kernel.org
	with ESMTP id S261615AbVGSKxD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jul 2005 06:53:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, jaap@jcz.nl

Dear sata-promise maintainers and others,


I wanted you to know the following:

I have a MSI K8T Neo VIA k8T800 based board with an athlon 64, this=20
board has 3 disk-controllers on board:

1: 0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420=20
SATA RAID Controller (rev 80)
2: 0000:00:0f.1 IDE interface: VIA Technologies, Inc.=20
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)=20
(prog-if 8a [Master SecP PriP])
3: 0000:00:0d.0 RAID bus controller: Promise Technology, Inc. PDC20378=20
(FastTrak 378/SATA 378) (rev 02)

The 3'rd I assume should be used in conjunction with the sata_promise=20
driver (am I correct? It shows up in the logs as ata3 & ata4). So far,=20
so good.

Now the problem (I would greatly appreciate help here...), this=20
controller has 2 sata ports AND one 'normal' U133DMA ide port. To this=20
port, I connected a working (works in other systems...) IBM-IDE drive=20
(U133); but this disk never shows up; the bios DOES detect it just fine=
=2E

How could I make this disk visible? Where to start looking in the=20
driver? I am using kernel 2.6.12.3.


Please CC me, because I am not on the list,

thanks in advance,


regards,

Jaap Crezee
The Netherlands

------

Some more info:

jaap@tv / $ /sbin/lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP]=20
Host Bridge (rev 01)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge=20
[K8T800/K8T890 South]
0000:00:06.0 Multimedia video controller: Brooktree Corporation Bt848=20
Video Capture (rev 12)
0000:00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k=
1=20
(rev 04)
0000:00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game=20
Port (rev 01)
0000:00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.=20
RTL-8169 Gigabit Ethernet (rev 10)
0000:00:0d.0 RAID bus controller: Promise Technology, Inc. PDC20378=20
(FastTrak 378/SATA 378) (rev 02)
0000:00:0e.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Hos=
t=20
Controller (rev 80)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SAT=
A=20
RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc.=20
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB=20
1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB=20
1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB=20
1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB=20
1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge=20
[KT600/K8T800/K8T890 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.=20
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8=20
[Athlon64/Opteron] HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8=20
[Athlon64/Opteron] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8=20
[Athlon64/Opteron] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8=20
[Athlon64/Opteron] Miscellaneous Control
0000:01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForc=
e=20
=46X 5200] (rev a1)
jaap@tv / $

jaap@tv / $ lspci -n
0000:00:00.0 Class 0600: 1106:3188 (rev 01)
0000:00:01.0 Class 0604: 1106:b188
0000:00:06.0 Class 0400: 109e:0350 (rev 12)
0000:00:0a.0 Class 0401: 1102:0002 (rev 04)
0000:00:0a.1 Class 0980: 1102:7002 (rev 01)
0000:00:0b.0 Class 0200: 10ec:8169 (rev 10)
0000:00:0d.0 Class 0104: 105a:3373 (rev 02)
0000:00:0e.0 Class 0c00: 1106:3044 (rev 80)
0000:00:0f.0 Class 0104: 1106:3149 (rev 80)
0000:00:0f.1 Class 0101: 1106:0571 (rev 06)
0000:00:10.0 Class 0c03: 1106:3038 (rev 81)
0000:00:10.1 Class 0c03: 1106:3038 (rev 81)
0000:00:10.2 Class 0c03: 1106:3038 (rev 81)
0000:00:10.3 Class 0c03: 1106:3038 (rev 81)
0000:00:10.4 Class 0c03: 1106:3104 (rev 86)
0000:00:11.0 Class 0601: 1106:3227
0000:00:11.5 Class 0401: 1106:3059 (rev 60)
0000:00:18.0 Class 0600: 1022:1100
0000:00:18.1 Class 0600: 1022:1101
0000:00:18.2 Class 0600: 1022:1102
0000:00:18.3 Class 0600: 1022:1103
0000:01:00.0 Class 0300: 10de:0322 (rev a1)
jaap@tv / $

Mainboard:
http://www.msi.com.tw/program/products/mainboard/mbd/pro_mbd_detail.php=
?UID=3D496

::
Serial ATA RAID

=95 Promise 20378 On-Board
=95 Supports 2 serial ATA plus 1 ATA133
- RAID 0, RAID 1 or RAID 0+1 is supported
- RAID function work w/ATA133+SATA H/D or 2SATA H/D
=95 Connect up to 2 SATA device and 2 ATA133 devices

So it 'could' work I guess...
