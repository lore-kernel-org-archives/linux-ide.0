From: Ansgar Knappheide <ansgar.knappheide@gmx.de>
Subject: Re: sata_promise issue with SATA 300 TX4 (PDC40718)
Date: Sun, 29 Oct 2006 19:11:17 +0100
Message-ID: <4544EEC5.2020808@gmx.de>
References: <200610291310.01120.tbaumgartner@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:32958 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932343AbWJ2SLZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Oct 2006 13:11:25 -0500
In-Reply-To: <200610291310.01120.tbaumgartner@swissonline.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Theo Baumgartner schrieb:
> Hello
>
> There seem to be an issue(s) in 2.6.18.1 and also other kernels with
> high I/O and the sata_promise driver.
>
> My Log gets filled with these messages with kernel 2.6.18.1 and 2.16.19-rc2-mm1 (from gentoo portage):
> ----snip
> ata1: no sense translation for status: 0x50
> ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata1: status=0x50 { DriveReady SeekComplete }
> ----snip
> The Results from kernel 2.6.18.1 are made with these following bonnie++ commands:
> bonnie++ -d /mnt/raid-array/ -s 1024 -n 5 -u theo
> bonnie++ -d /mnt/raid-array/ -s 4096 -n 5 -u theo
>
>
> These messages i'm getting with kernel 2.6.17-gentoo-r8
> ----snip
> ata2: status=0x50 { DriveReady SeekComplete }
> sdb: Current: sense key=0x0
>     ASC=0x0 ASCQ=0x0
> Info fld=0x10be
> ----snip
>   
I have seen this error message on all versions of kernel 2.6 since the 
beginning and also on kernel 2.4 and asked about this error message some 
time ago, but didn't get an answer.
It happens on heavy random access (heavy headmovement) on disk but also 
on fsck(.ext3). Since kernel 2.16 or 2.6.17 (since printing "Info 
fld=xxxxxx) this error message is getting rare.
P.S. I've never seen any data corruption, so this is not a serious error 
for me , but might be for others.

> The Results from kernel 2.6.17-gentoo-r8 are made with several
> concurrent copy workloads to Disk from Network with NFSv4 over a 100Mbit
> NIC. Also made with bonnie++ with same results.
>
> It seem to be the same failure over and over again.
>
> lspci:
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
> 00:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
> 00:07.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA 300 TX4) (rev 02)
> 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
> 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
> 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
> 00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
> 00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 440] (rev a3)
>
> /proc/interrupts from 2.6.18.1 and 2.6.17-gentoo-r8 look the same:
>            CPU0
>   0:     665825    IO-APIC-edge  timer
>   1:          9    IO-APIC-edge  i8042
>   8:          2    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  14:       1221    IO-APIC-edge  ide0
>  16:        800   IO-APIC-level  eth0
>  17:      41397   IO-APIC-level  libata
> NMI:          0
> LOC:     657650
> ERR:          0
> MIS:          0
>
>
> /proc/interrupts from 2.6.19-rc2-mm1:
>            CPU0
>   0:     541995   IO-APIC-edge      timer
>   1:          8   IO-APIC-edge      i8042
>   8:          2   IO-APIC-edge      rtc
>   9:          0   IO-APIC-fasteoi   acpi
>  12:          4   IO-APIC-edge      i8042
>  14:       1188   IO-APIC-edge      ide0
>  16:       1168   IO-APIC-fasteoi   eth0
>  17:      43496   IO-APIC-fasteoi   libata
> NMI:          0
> LOC:     534837
> ERR:          0
> MIS:          0
>
>
> Hope someone can use these Informations.
>
>   
I would be glad to help with info on this, but on patch testing I#m a 
bit careful because my computer is a productive system used on daily base

Ansgar Knappheide
