From: Christopher Chan <cchan@outblaze.com>
Subject: Re: linux 2.6.9 controller order reordered.  was: [Re: linux 2.6.9
 still having network code problems]
Date: Wed, 03 Nov 2004 14:57:36 +0800
Message-ID: <41888160.5080502@outblaze.com>
References: <418741EB.3080701@outblaze.com>	 <20041102011918.2b453e21.akpm@osdl.org> <4187478A.1040002@outblaze.com>	 <20041102014119.1a6096cc.akpm@osdl.org> <41874D93.9000008@outblaze.com>	 <20041102020712.18218d47.akpm@osdl.org> <418751B3.8090003@outblaze.com>	 <20041102022604.262058c4.akpm@osdl.org> <1099413643.24934.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from corpmail.outblaze.com ([203.86.166.82]:29163 "EHLO
	corpmail.outblaze.com") by vger.kernel.org with ESMTP
	id S261437AbUKCG5V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Nov 2004 01:57:21 -0500
In-Reply-To: <1099413643.24934.1.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org


> What are you on about ? The problem is that in the two traces his
> serverworks has moved from ide0 to ide2. 

Here's the other case on another box that has onboard Promise plus an 
add-on Promise card:

2.6.9:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller at PCI slot 0000:01:02.0
PDC20267: chipset revision 2
PDC20267: ROM enabled at 0xfebd0000
PDC20267: 100% native mode on irq 27
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
     ide0: BM-DMA at 0xef00-0xef07, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xef08-0xef0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
PDC20267: IDE controller at PCI slot 0000:00:03.0
PDC20267: chipset revision 2
PDC20267: ROM enabled at 0xfeae0000
PDC20267: 100% native mode on irq 31
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER 
Mode.
     ide2: BM-DMA at 0xdf00-0xdf07, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xdf08-0xdf0f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Maxtor 5T040H4, ATA DISK drive
ide2 at 0xdfe0-0xdfe7,0xdfae on irq 31
Probing IDE interface ide3...
hdg: Maxtor 5T040H4, ATA DISK drive
ide3 at 0xdfa0-0xdfa7,0xdfaa on irq 31
SvrWks OSB4: IDE controller at PCI slot 0000:00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
     ide4: BM-DMA at 0xffa0-0xffa7, BIOS settings: hdi:pio, hdj:pio
     ide5: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdk:pio, hdl:pio
Probing IDE interface ide4...
Probing IDE interface ide5...
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide4...
Probing IDE interface ide5...
hde: max request size: 128KiB
hde: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hde: cache flushes not supported
  hde: hde1 hde2 hde3 hde4 < hde5 >
hdg: max request size: 128KiB
hdg: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdg: cache flushes not supported

2.6.8-1.521smp (FC2):

Oct 14 04:46:49 spf0 kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Oct 14 04:46:49 spf0 kernel: PDC20267: IDE controller at PCI slot 
0000:01:02.0
Oct 14 04:46:49 spf0 kernel: PDC20267: chipset revision 2
Oct 14 04:46:49 spf0 kernel: PDC20267: ROM enabled at 0xfebd0000
Oct 14 04:46:49 spf0 kernel: PDC20267: 100%% native mode on irq 153
Oct 14 04:46:49 spf0 kernel: PDC20267: (U)DMA Burst Bit ENABLED Primary 
PCI Mode Secondary PCI Mode.
Oct 14 04:46:49 spf0 kernel:     ide2: BM-DMA at 0xef00-0xef07, BIOS 
settings: hde:pio, hdf:pio
Oct 14 04:46:49 spf0 kernel:     ide3: BM-DMA at 0xef08-0xef0f, BIOS 
settings: hdg:pio, hdh:pio
Oct 14 04:46:49 spf0 kernel: PDC20267: IDE controller at PCI slot 
0000:00:03.0
Oct 14 04:46:49 spf0 kernel: PDC20267: chipset revision 2
Oct 14 04:46:49 spf0 kernel: PDC20267: ROM enabled at 0xfeae0000
Oct 14 04:46:49 spf0 kernel: PDC20267: 100%% native mode on irq 161
Oct 14 04:46:49 spf0 kernel: PDC20267: (U)DMA Burst Bit ENABLED Primary 
MASTER Mode Secondary MASTER Mode.
Oct 14 04:46:49 spf0 kernel:     ide4: BM-DMA at 0xdf00-0xdf07, BIOS 
settings: hdi:pio, hdj:pio
Oct 14 04:46:49 spf0 kernel:     ide5: BM-DMA at 0xdf08-0xdf0f, BIOS 
settings: hdk:pio, hdl:pio
Oct 14 04:46:49 spf0 kernel: hdi: Maxtor 5T040H4, ATA DISK drive
Oct 14 04:46:49 spf0 kernel: Using cfq io scheduler
Oct 14 04:46:49 spf0 kernel: ide4 at 0xdfe0-0xdfe7,0xdfae on irq 161
Oct 14 04:46:49 spf0 kernel: hdk: Maxtor 5T040H4, ATA DISK drive
Oct 14 04:46:49 spf0 kernel: ide5 at 0xdfa0-0xdfa7,0xdfaa on irq 161
Oct 14 04:46:49 spf0 kernel: SvrWks OSB4: IDE controller at PCI slot 
0000:00:0f.1
Oct 14 04:46:49 spf0 kernel: SvrWks OSB4: chipset revision 0
Oct 14 04:46:49 spf0 kernel: SvrWks OSB4: not 100%% native mode: will 
probe irqs later
Oct 14 04:46:49 spf0 kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS 
settings: hda:pio, hdb:pio
Oct 14 04:46:49 spf0 kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS 
settings: hdc:pio, hdd:pio
Oct 14 04:46:49 spf0 kernel: hdi: max request size: 128KiB
Oct 14 04:46:49 spf0 kernel: hdi: 80043264 sectors (40982 MB) w/2048KiB 
Cache, CHS=65535/16/63, UDMA(100)
Oct 14 04:46:49 spf0 kernel:  hdi: hdi1 hdi2 hdi3 hdi4 < hdi5 >
Oct 14 04:46:49 spf0 kernel: hdk: max request size: 128KiB
Oct 14 04:46:49 spf0 kernel: hdk: 80043264 sectors (40982 MB) w/2048KiB 
Cache, CHS=65535/16/63, UDMA(100)
Oct 14 04:46:49 spf0 kernel:  hdk: hdk1 hdk2 hdk3 hdk4 < hdk5 >
