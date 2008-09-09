From: Antonio Cardoso Martins <digiplan.pt@gmail.com>
Subject: Re: UDMA with CS5530 using IBM Netvista N2200 (8363)
Date: Wed, 10 Sep 2008 00:13:23 +0100
Message-ID: <48C70313.6080704@gmail.com>
References: <48C45BEF.5090502@gmail.com>	<20080908094332.7b021b4e@lxorguk.ukuu.org.uk>	<48C5BD49.6090204@gmail.com> <20080909115248.580eba78@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:41143 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbYIIXNc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Sep 2008 19:13:32 -0400
Received: by gxk9 with SMTP id 9so12167184gxk.13
        for <linux-ide@vger.kernel.org>; Tue, 09 Sep 2008 16:13:30 -0700 (PDT)
In-Reply-To: <20080909115248.580eba78@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Alan Cox wrote:
>> The ATA adapter is embedded into the motherboard. Looking at the board,
>> the chipset reads Cyrix Cx5530. There is some contradictory information
>> about whether this chip supports DMA or not. Regarding the CF, i am
>>     
>
> The CS5530 supports UDMA, the CF card may well support UDMA but there is
> a third ingredient in the CF cases - whatever connects the two must
> support UDMA. A lot of (especially older) CF convertors, CF cards slots
> on boards and the like do not even have the required wiring present,
> others don't have to to the standard needed for UDMA.
>
>   
>> ata1.00: ATA-5: SILICON POWER, 2.0, mas UDMA/66
>>     
>
> Your CF card reports that it supports UDMA so I am quite sure it does.
>
>   
>> sd 0:0:0:0: [sda] 2000880 512-byte hardware sectors (1024 MB)
>> sd 0:0:0:0: [sda] Write Protect is off
>> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
>> support DPO or FUA
>>     
>
> So PIO works and DMA doesn't.
>
>   
>> Does this give any interesting info to the problem?
>>     
>
> It matches the other driver behaviour which is very helpful.
>
>   
>> PS: Since i cannot provide parameters to the kernel, i don't know how
>> the kernel i have completely working (2.6.22.15) figure out that he
>> should continue boot from root=/dev/hda1. This kernel does not seem to
>> get to that conclusion.
>>     
>
> It would be /dev/sda1. I've no idea how the firmware bootloader passes
> information to the kernel on your netvista. You could see if the old
> rdev stuff is used (rdev /vmlinuz /dev/sda1) 
> For the PIO find
>
> static int libata_dma_mask = ....
>
> In drivers/ata/libata-core.c and change it to = 0;
>
>   
Booting with CONFIG_BLK_DEV_CS5530=n and CONFIG_PATA_CS5530=y and
libdata_dma_mask=0
kernel 2.6.24.7:
...
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Driver 'sd' needs updating - please use bus_type methods
scsi0: pata_cs5530
scsi1: pata_cs5530
ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
ata1.00: ATA-5: SILICON POWER, 2.0, mas UDMA/66
ata1.00: 2000880 sectors, multi 1: LBA
ata1.00: configured for PIO4
scsi 0:0:0:0: Direct-Access      ATA     SILICON POWER    2.0  PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 2000880 512-byte hardware sectors (1024 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 2000880 512-byte hardware sectors (1024 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1
sd 0:0:0.0: [sda] attached SCSI disk
sd 0:0:0.0: Attached scsi generic sg0 type 0
...
VFS: Cannot open root device "<NULL>" or unknown-block(0,0)
Please append a correct "root=" boot option; here are the available
partitions:
0800        1000440 sda driver: sd
  0801          999905 sda1
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)


So PIO4 is now working. Great. But i am stuck with the root device.

Netvista 8363 firmware calls vmlinux (not bzImage) directly from an ext2 partition since the filename is kernel.2x00 and ELF program-header-count (offset 0x2c) is patched with the value 1. I am not sure, but rdev doesn't apply to vmlinux.
Until 2.6.23.17, the kernel figured that the root device is /dev/hda1. From kernel 2.6.24.1, the root device cannot be mounted because the root is <NULL>. This must be hardcoded somewhere and changed in 2.6.24.1 as the firmware does not pass any parameters to the kernel. Any hints?

Best regards

