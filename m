From: Andrew Morton <akpm@osdl.org>
Subject: Re: linux 2.6.9 controller order reordered.  was: [Re: linux 2.6.9
 still having network code problems]
Date: Tue, 2 Nov 2004 02:26:04 -0800
Message-ID: <20041102022604.262058c4.akpm@osdl.org>
References: <418741EB.3080701@outblaze.com>
	<20041102011918.2b453e21.akpm@osdl.org>
	<4187478A.1040002@outblaze.com>
	<20041102014119.1a6096cc.akpm@osdl.org>
	<41874D93.9000008@outblaze.com>
	<20041102020712.18218d47.akpm@osdl.org>
	<418751B3.8090003@outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:35271 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261932AbUKBJ1z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Nov 2004 04:27:55 -0500
In-Reply-To: <418751B3.8090003@outblaze.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christopher Chan <cchan@outblaze.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Christopher Chan <cchan@outblaze.com> wrote:
>
> >>Hardware: Tyan mb with Serverworks chipset and onboard Promise controller.
> >>	The two disks on promise channel since Serverworks does not support ATA100
> >>
> >>FC2 Installation will recognise the disks as hde and hdg
> >>fstab is accordingly setup as so for swap (everything else are md)
> >>
> >>Changing to a 2.6.9 kernel that has the promise driver compiled in will 
> >>change the disks to hda and hdc.
> > 
> > 
> > Could you send the dmesg output so we can see the probing activity?
> > 
> 
> With FC2 2.6.8-1.521smp
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~
> Oct 14 11:34:50 spf5-3 kernel: RAMDISK driver initialized: 16 RAM disks 
> of 16384K size 1024 blocksize
> Oct 14 11:34:50 spf5-3 kernel: Uniform Multi-Platform E-IDE driver 
> Revision: 7.00alpha2
> Oct 14 11:34:50 spf5-3 kernel: ide: Assuming 33MHz system bus speed for 
> PIO modes; override with idebus=xx
> Oct 14 11:34:50 spf5-3 nfslock: rpc.statd startup succeeded
> Oct 14 11:34:50 spf5-3 kernel: PDC20267: IDE controller at PCI slot 
> 0000:00:03.0
> Oct 14 11:34:50 spf5-3 kernel: PDC20267: chipset revision 2
> Oct 14 11:34:50 spf5-3 kernel: PDC20267: ROM enabled at 0xfead0000
> Oct 14 11:34:50 spf5-3 kernel: PDC20267: 100%% native mode on irq 161
> Oct 14 11:34:50 spf5-3 kernel: PDC20267: (U)DMA Burst Bit ENABLED 
> Primary MASTER Mode Secondary MASTER Mode.
> Oct 14 11:34:50 spf5-3 kernel:     ide2: BM-DMA at 0xdf00-0xdf07, BIOS 
> settings: hde:pio, hdf:pio
> Oct 14 11:34:50 spf5-3 kernel:     ide3: BM-DMA at 0xdf08-0xdf0f, BIOS 
> settings: hdg:pio, hdh:pio
> Oct 14 11:34:50 spf5-3 kernel: hde: Maxtor 5T040H4, ATA DISK drive
> Oct 14 11:34:50 spf5-3 kernel: Using deadline io scheduler
> Oct 14 11:34:50 spf5-3 kernel: ide2 at 0xdfe0-0xdfe7,0xdfae on irq 161
> Oct 14 11:34:50 spf5-3 kernel: hdg: Maxtor 5T040H4, ATA DISK drive
> Oct 14 11:34:50 spf5-3 kernel: ide3 at 0xdfa0-0xdfa7,0xdfaa on irq 161
> Oct 14 11:34:50 spf5-3 kernel: SvrWks OSB4: IDE controller at PCI slot 
> 0000:00:0f.1
> Oct 14 11:34:50 spf5-3 kernel: PCI: Enabling device 0000:00:0f.1 (0000 
> -> 0001)
> Oct 14 11:34:50 spf5-3 kernel: SvrWks OSB4: chipset revision 0
> Oct 14 11:34:50 spf5-3 kernel: SvrWks OSB4: not 100%% native mode: will 
> probe irqs later
> Oct 14 11:34:50 spf5-3 kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS 
> settings: hda:pio, hdb:pio
> Oct 14 11:34:50 spf5-3 kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS 
> settings: hdc:pio, hdd:pio
> Oct 14 11:34:50 spf5-3 kernel: hde: max request size: 128KiB
> Oct 14 11:34:50 spf5-3 kernel: hde: 80043264 sectors (40982 MB) 
> w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
> Oct 14 11:34:50 spf5-3 kernel:  hde: hde1 hde2 hde3 hde4 < hde5 >
> Oct 14 11:34:50 spf5-3 kernel: hdg: max request size: 128KiB
> Oct 14 11:34:50 spf5-3 kernel: hdg: 80043264 sectors (40982 MB) 
> w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
> Oct 14 11:34:50 spf5-3 kernel:  hdg: hdg1 hdg2 hdg3 hdg4 < hdg5 >
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> With 2.6.9
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Using deadline io scheduler
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> Compaq SMART2 Driver (v 2.6.0)
> HP CISS Driver (v 2.6.2)
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PDC20267: IDE controller at PCI slot 0000:00:03.0
> PDC20267: chipset revision 2
> PDC20267: ROM enabled at 0xfead0000
> PDC20267: 100% native mode on irq 31
> PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER 
> Mode.
>      ide0: BM-DMA at 0xdf00-0xdf07, BIOS settings: hda:pio, hdb:pio
>      ide1: BM-DMA at 0xdf08-0xdf0f, BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> hda: Maxtor 5T040H4, ATA DISK drive
> ide0 at 0xdfe0-0xdfe7,0xdfae on irq 31
> Probing IDE interface ide1...
> hdc: Maxtor 5T040H4, ATA DISK drive
> ide1 at 0xdfa0-0xdfa7,0xdfaa on irq 31
> SvrWks OSB4: IDE controller at PCI slot 0000:00:0f.1
> PCI: Enabling device 0000:00:0f.1 (0000 -> 0001)
> SvrWks OSB4: chipset revision 0
> SvrWks OSB4: not 100% native mode: will probe irqs later
>      ide2: BM-DMA at 0xffa0-0xffa7, BIOS settings: hde:pio, hdf:pio
>      ide3: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdg:pio, hdh:pio
> Probing IDE interface ide2...
> Probing IDE interface ide3...
> Probing IDE interface ide2...
> Probing IDE interface ide3...
> Probing IDE interface ide4...
> ide4: Wait for ready failed before probe !
> Probing IDE interface ide5...
> ide5: Wait for ready failed before probe !
> hda: max request size: 128KiB
> hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
> hda: cache flushes not supported
>   hda: hda1 hda2 hda3 hda4 < hda5 >
> hdc: max request size: 128KiB
> hdc: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
> hdc: cache flushes not supported
>   hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 >
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Well the problem is that "Wait for ready" thing.  Was that an alanism?

