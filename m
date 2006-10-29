From: Theo Baumgartner <tbaumgartner@swissonline.ch>
Subject: sata_promise issue with SATA 300 TX4 (PDC40718)
Date: Sun, 29 Oct 2006 14:10:00 +0200
Message-ID: <200610291310.01120.tbaumgartner@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxout.hispeed.ch ([62.2.95.247]:58243 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S932295AbWJ2MKE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Oct 2006 07:10:04 -0500
Received: from 84-72-181-62.dclient.hispeed.ch (84-72-181-62.dclient.hispeed.ch [84.72.181.62])
	by smtp.hispeed.ch (8.12.11.20060308/8.12.6/taifun-1.0) with ESMTP id k9TCA1fx012695
	for <linux-ide@vger.kernel.org>; Sun, 29 Oct 2006 13:10:02 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello

There seem to be an issue(s) in 2.6.18.1 and also other kernels with
high I/O and the sata_promise driver.

My Log gets filled with these messages with kernel 2.6.18.1 and 2.16.19-rc2-mm1 (from gentoo portage):
----snip
ata1: no sense translation for status: 0x50
ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x50 { DriveReady SeekComplete }
----snip
The Results from kernel 2.6.18.1 are made with these following bonnie++ commands:
bonnie++ -d /mnt/raid-array/ -s 1024 -n 5 -u theo
bonnie++ -d /mnt/raid-array/ -s 4096 -n 5 -u theo


These messages i'm getting with kernel 2.6.17-gentoo-r8
----snip
ata2: status=0x50 { DriveReady SeekComplete }
sdb: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
Info fld=0x10be
----snip
The Results from kernel 2.6.17-gentoo-r8 are made with several
concurrent copy workloads to Disk from Network with NFSv4 over a 100Mbit
NIC. Also made with bonnie++ with same results.

It seem to be the same failure over and over again.

lspci:
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:07.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA 300 TX4) (rev 02)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 440] (rev a3)

/proc/interrupts from 2.6.18.1 and 2.6.17-gentoo-r8 look the same:
           CPU0
  0:     665825    IO-APIC-edge  timer
  1:          9    IO-APIC-edge  i8042
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:       1221    IO-APIC-edge  ide0
 16:        800   IO-APIC-level  eth0
 17:      41397   IO-APIC-level  libata
NMI:          0
LOC:     657650
ERR:          0
MIS:          0


/proc/interrupts from 2.6.19-rc2-mm1:
           CPU0
  0:     541995   IO-APIC-edge      timer
  1:          8   IO-APIC-edge      i8042
  8:          2   IO-APIC-edge      rtc
  9:          0   IO-APIC-fasteoi   acpi
 12:          4   IO-APIC-edge      i8042
 14:       1188   IO-APIC-edge      ide0
 16:       1168   IO-APIC-fasteoi   eth0
 17:      43496   IO-APIC-fasteoi   libata
NMI:          0
LOC:     534837
ERR:          0
MIS:          0


Hope someone can use these Informations.

Greetings
Theo
