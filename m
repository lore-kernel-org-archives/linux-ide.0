From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: old Plextor CD Writer PX-W1210A is not recognized
Date: Sun, 20 Dec 2009 13:26:25 -0600
Message-ID: <4B2E7A61.7080000@gmail.com>
References: <20091220123215.2ae100e7@x2.grafnetz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:48405 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbZLTT02 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2009 14:26:28 -0500
Received: by iwn1 with SMTP id 1so3247161iwn.33
        for <linux-ide@vger.kernel.org>; Sun, 20 Dec 2009 11:26:27 -0800 (PST)
In-Reply-To: <20091220123215.2ae100e7@x2.grafnetz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mario Bachmann <grafgrimm77@gmx.de>
Cc: linux-ide@vger.kernel.org

On 12/20/2009 05:32 AM, Mario Bachmann wrote:
> Hello,
>
> my old PLEXTOR CD-R PX-W1210A, FwRev=1.09 is not recognized any more in Linux 2.6.31.4.
>
> In my old Rescue-Linux on the same machine with Linux 2.6.25.14 the CD-Writer is recognized and it works.
>
> To give you some Information about the Plextor-CD-Burner, I booted my old 2.6.25.14-Linux:
>
> # uname -a
> Linux amd2000 2.6.25.14 #1 Fri Aug 1 23:55:59 CEST 2008 i686 AMD Athlon(tm) XP 2000+ AuthenticAMD GNU/Linux
>
> # hdparm -Ii /dev/hdc
> /dev/hdc:
>
>   Model=PLEXTOR CD-R PX-W1210A, FwRev=1.09, SerialNo=
>   Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
>   RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
>   BuffType=unknown, BuffSize=0kB, MaxMultSect=0
>   (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
>   IORDY=on/off, tPIO={min:180,w/IORDY:120}, tDMA={min:120,rec:120}
>   PIO modes:  pio0 pio1 pio2 pio3 pio4
>   DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
>   AdvancedPM=no
>
>   * signifies the current active mode
>
> # ls /dev/hd*
> /dev/hda
> /dev/hda1
> /dev/hda10
> /dev/hda11
> /dev/hda2
> /dev/hda3
> /dev/hda4
> /dev/hda5
> /dev/hda6
> /dev/hda7
> /dev/hda8
> /dev/hda9
> /dev/hdb
> /dev/hdb1
> /dev/hdc
>
> # dmesg|grep -e hda -e hdb -e hdc -e hdd
>      ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
>      ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
> hda: SAMSUNG SP1614N, ATA DISK drive
> hdb: SAMSUNG SP1614N, ATA DISK drive
> hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> hda: UDMA/100 mode selected
> hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> hdb: UDMA/100 mode selected
> hdc: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
> hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> hdc: MWDMA2 mode selected
> hda: max request size: 512KiB
> hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63
> hda: cache flushes supported
>   hda: hda1 hda2 hda3 hda4<  hda5 hda6 hda7 hda8 hda9 hda10 hda11>
> hdb: max request size: 512KiB
> hdb: Host Protected Area detected.
> hdb: Host Protected Area disabled.
> hdb: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63
> hdb: cache flushes supported
>   hdb: hdb1
> hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache
> XFS mounting filesystem hda9
> Ending clean XFS mount for filesystem: hda9
> XFS mounting filesystem hda6
> Ending clean XFS mount for filesystem: hda6
> XFS mounting filesystem hda8
> Ending clean XFS mount for filesystem: hda8
> Adding 1199992k swap on /dev/hda10.  Priority:1 extents:1 across:1199992k
>
> # dmesg |grep ide
> BIOS-provided physical RAM map:
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> Kernel command line: BOOT_IMAGE=Rescue ro root=309 video=vesafb:ywrap,mtrr agp=off max_loop=16
> pci 0000:01:00.0: Boot video device
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>      ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
>      ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
> Probing IDE interface ide0...
> Probing IDE interface ide1...
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
>
> The difference between my old 2.6.25.14-Linux and the newer 2.6.31.4-Linux is mainly the actuality of the updates (and the kernel).
> I configured the kernel by my own and the changes were made with "make oldconfig" and answer the questions.
>
> Can You please tell me if/why the Plextor do not work any more. Or better: Give me instructions to get it working again in newer versions of Linux Kernel.

It's difficult to say without seeing the dmesg output from the newer 
kernel. However, from the output you posted above it seems that you may 
not have any hardware-specific IDE driver enabled in your kernel 
configuration and it's using a generic driver. I believe this mode isn't 
supported anymore, at least not by default.
