From: =?UTF-8?Q?Nuno_Magalh=C3=A3es?= <nunomagalhaes@eu.ipp.pt>
Subject: SATA disks disabled on boot
Date: Fri, 11 Jul 2014 22:06:14 +0100
Message-ID: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:47483 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbaGKVGf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2014 17:06:35 -0400
Received: by mail-wi0-f180.google.com with SMTP id n3so300434wiv.13
        for <linux-ide@vger.kernel.org>; Fri, 11 Jul 2014 14:06:34 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Greetings,

This is my first post, after having been searching around. A major
source of information was this[1] thread but it's old and the OP
changed hardware.

This is mine:
* Asus M2nPV-VM motherboard
* BIOS version 5005 (this was the last version ever released)
* Phenom II X4 910e CPU
* 8GiB DDR2 RAM (dual-channel 800MHz)
* 4 SATA drives:
** 2 Toshiba DTACA100 (ports SATA1 and 3)
** 2 WD Reds WD10EFRX (ports SATA2 and 4)
* ATI/AMD Radeon HD 5450 on a PCIe slot

The toshibas comprise a RAID1, on top of which is LVM with Debian
stable Wheezy 7.5, linux 3.2.0-4-amd64. My boot parameters are:
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX="iommu=noaperture acpi_enforce_resources=lax"
(no AGP and i'm trying to get lm-sensors to work)

The Reds have nothing yet (i'm RTFMing on ZFS) and they are the
problem: randomly, one or the other get disabled at boot.

>From lspci:
00:0d.0 IDE interface: NVIDIA Corporation MCP51 IDE (rev a1)
00:0e.0 IDE interface: NVIDIA Corporation MCP51 Serial ATA Controller (rev a1)
00:0f.0 IDE interface: NVIDIA Corporation MCP51 Serial ATA Controller (rev a1)

>From dmesg:
    # dmesg |grep ata4
    [    0.914589] ata4: SATA max UDMA/133 cmd 0x960 ctl 0xb60 bmdma
0xf308 irq 20
    [    2.356417] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
    [    2.364553] ata4.00: ATA-9: WDC WD10EFRX-68PJCN0, 01.01A01, max UDMA/133
    [    2.364556] ata4.00: 268435455 sectors, multi 1: LBA NCQ (depth 31/32)
    [    2.372541] ata4.00: n_sectors mismatch 268435455 != 1953525168
    [    2.372543] ata4.00: revalidation failed (errno=-19)
    [    2.372590] ata4: limiting SATA link speed to 1.5 Gbps
    [    2.372592] ata4.00: limiting speed to UDMA/133:PIO3
    [    7.824219] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
    [    7.833088] ata4.00: n_sectors mismatch 268435455 != 1953525168
    [    7.833091] ata4.00: revalidation failed (errno=-19)
    [    7.833135] ata4.00: disabled

It happens mostly with ata4 but it's also happened with ata2. The
issue seems to be this:
    [    2.364556] ata4.00: 268435455 sectors, multi 1: LBA NCQ (depth 31/32)
It should be LBA48 NCQ

These are the BIOS settings that seem relevant:

    extended IDE drive: auto
    access mode: auto
    SATA controller 1,2: enabled
    SATA DMA transfer: enabled
    SATA port 3,4: enabled
    SATA2 DMA transfer: enabled
    Plug'n'play OS: yes

I have no clue whether this is because of the drives (hope not!), if
so, how can i go around it (forcing LBA48)? Or a misconfiguration
somewhere. The disks
are new and pass SMART tests.

Could this be ACPI/APIC related? Something about sata_nv?

Any pointers for further debugging/solutions would be welcome.

Cheers,
Nuno

[1] http://lkml.iu.edu/hypermail/linux/kernel/0709.1/1614.html
