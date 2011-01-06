From: Russell Whitaker <russ@ashlandhome.net>
Subject: Re: 2.6.35.9 bug shown in dmesg (fwd)
Date: Wed, 5 Jan 2011 22:21:21 -0800 (PST)
Message-ID: <alpine.LNX.2.00.1101052112010.1625@bigred.russwhit.org>
References: <alpine.LNX.2.00.1012301233380.3394@bigred.russwhit.org> <20110103230028.GA1456@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 066-241-084-054.bus.ashlandfiber.net ([66.241.84.54]:49233 "EHLO
	bigred.russwhit.org" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753732Ab1AFG1b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 01:27:31 -0500
In-Reply-To: <20110103230028.GA1456@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org



On Tue, 4 Jan 2011, Stanislaw Gruszka wrote:

> Hi
>
> On Thu, Dec 30, 2010 at 12:57:41PM -0800, Russell Whitaker wrote:
>> Since sending the email below found some more info:
>>
>> Tried several kernels from 2.6.32.16 up - same problem.
>>
>> If I build kernel using "ATA/ATAPI/MFM/RLL=y" and right choices in
>> sub-menu (and fstab with hd...) There is no problem.
>>
>> Making change to "serial ATA (prod) and parallel ATA (experimental)=y"
>> the computer crashes during boot-up about 1/3 of the time.
>>
>> Hardware:
>>   Tyan mb s2466 Tiger MPX (2 cpu)
>>   2 segate hd on primary ide
>>
>> If you send me a patch, will try it and let you know what happens.
>
> BUG is from amd76xrom MTD driver, there is some resources conflict.
> Below patch should fix oops in simple_map_write(), but not the conflict.
> Please apply it to confirm oops fix and to show us contents of
> /proc/iomem on ATA/ATAPI/MFM/RLL and on experimental parallel ATA
> for compare.
>
> Stanislaw
>
> ---
>> From 8bcfe30f1c52b1fe61b2885731421ab5998f0629 Mon Sep 17 00:00:00 2001
> From: Stanislaw Gruszka <stf_xl@wp.pl>
> Date: Mon, 3 Jan 2011 23:32:34 +0100
> Subject: [PATCH] amd76xrom: fix oops at boot when resources are not available
>
> For some unknown reason resources needed by amd76xrom driver can not be
> available. Instead of return error, driver crash the kernel with
> messages like below. Patch fix that.
>
> amd76xrom" amd76xrom_init_one(): Unable to register resource 0x00000000ffc00000-0x00000000ffffffff - kernel bug?

Sorry, in my case that's the wrong bug. First found the bug using 
Slackware-current. So I stripped down his config file by removing most 
of what I can't use, recompiled, and the bug was still there.

I'm not using amd76xrom so went into a MTD submenu and changed it to not 
set, etc, and found the bug is still there.

The bug is in pata (experimental). By comparison, ide (depreciated) has
been working solid for years.

comparing config for linux-2.6.35.10, ide vs pata and no other changes:

4c4
< # Tue Jan  4 19:12:25 2011
---
> # Tue Jan  4 12:27:07 2011
1057,1119c1057
< CONFIG_IDE=y
< 
< #
< # Please see Documentation/ide/ide.txt for help/info on IDE drives
< #
< CONFIG_IDE_XFER_MODE=y
< CONFIG_IDE_TIMINGS=y
< CONFIG_IDE_ATAPI=y
< # CONFIG_BLK_DEV_IDE_SATA is not set
< CONFIG_IDE_GD=y
< CONFIG_IDE_GD_ATA=y
< CONFIG_IDE_GD_ATAPI=y
< CONFIG_BLK_DEV_IDECD=y
< CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
< # CONFIG_BLK_DEV_IDETAPE is not set
< CONFIG_BLK_DEV_IDEACPI=y
< # CONFIG_IDE_TASK_IOCTL is not set
< CONFIG_IDE_PROC_FS=y
< 
< #
< # IDE chipset support/bugfixes
< #
< # CONFIG_IDE_GENERIC is not set
< # CONFIG_BLK_DEV_PLATFORM is not set
< # CONFIG_BLK_DEV_CMD640 is not set
< # CONFIG_BLK_DEV_IDEPNP is not set
< CONFIG_BLK_DEV_IDEDMA_SFF=y
< 
< #
< # PCI IDE chipsets support
< #
< CONFIG_BLK_DEV_IDEPCI=y
< CONFIG_IDEPCI_PCIBUS_ORDER=y
< # CONFIG_BLK_DEV_GENERIC is not set
< # CONFIG_BLK_DEV_RZ1000 is not set
< CONFIG_BLK_DEV_IDEDMA_PCI=y
< # CONFIG_BLK_DEV_AEC62XX is not set
< # CONFIG_BLK_DEV_ALI15X3 is not set
< CONFIG_BLK_DEV_AMD74XX=y
< # CONFIG_BLK_DEV_ATIIXP is not set
< # CONFIG_BLK_DEV_CMD64X is not set
< # CONFIG_BLK_DEV_TRIFLEX is not set
< # CONFIG_BLK_DEV_CS5530 is not set
< # CONFIG_BLK_DEV_CS5535 is not set
< # CONFIG_BLK_DEV_CS5536 is not set
< # CONFIG_BLK_DEV_HPT366 is not set
< # CONFIG_BLK_DEV_JMICRON is not set
< # CONFIG_BLK_DEV_SC1200 is not set
< # CONFIG_BLK_DEV_PIIX is not set
< # CONFIG_BLK_DEV_IT8172 is not set
< # CONFIG_BLK_DEV_IT8213 is not set
< # CONFIG_BLK_DEV_IT821X is not set
< # CONFIG_BLK_DEV_NS87415 is not set
< # CONFIG_BLK_DEV_PDC202XX_OLD is not set
< # CONFIG_BLK_DEV_PDC202XX_NEW is not set
< # CONFIG_BLK_DEV_SVWKS is not set
< # CONFIG_BLK_DEV_SIIMAGE is not set
< # CONFIG_BLK_DEV_SIS5513 is not set
< # CONFIG_BLK_DEV_SLC90E66 is not set
< # CONFIG_BLK_DEV_TRM290 is not set
< # CONFIG_BLK_DEV_VIA82CXXX is not set
< # CONFIG_BLK_DEV_TC86C001 is not set
< CONFIG_BLK_DEV_IDEDMA=y
---
> # CONFIG_IDE is not set
1154a1093
> CONFIG_SCSI_SAS_ATA=y
1161c1100,1183
< # CONFIG_ATA is not set
---
> CONFIG_ATA=y
> # CONFIG_ATA_NONSTANDARD is not set
> CONFIG_ATA_VERBOSE_ERROR=y
> CONFIG_ATA_ACPI=y
> # CONFIG_SATA_PMP is not set
> 
> #
> # Controllers with non-SFF native interface
> #
> # CONFIG_SATA_AHCI is not set
> # CONFIG_SATA_AHCI_PLATFORM is not set
> # CONFIG_SATA_INIC162X is not set
> # CONFIG_SATA_SIL24 is not set
> CONFIG_ATA_SFF=y
> 
> #
> # SFF controllers with custom DMA interface
> #
> # CONFIG_PDC_ADMA is not set
> # CONFIG_SATA_QSTOR is not set
> CONFIG_ATA_BMDMA=y
> 
> #
> # SATA SFF controllers with BMDMA
> #
> # CONFIG_ATA_PIIX is not set
> # CONFIG_SATA_MV is not set
> # CONFIG_SATA_NV is not set
> # CONFIG_SATA_PROMISE is not set
> # CONFIG_SATA_SIL is not set
> # CONFIG_SATA_SIS is not set
> # CONFIG_SATA_SVW is not set
> # CONFIG_SATA_ULI is not set
> # CONFIG_SATA_VIA is not set
> # CONFIG_SATA_VITESSE is not set
> 
> #
> # PATA SFF controllers with BMDMA
> #
> # CONFIG_PATA_ALI is not set
> CONFIG_PATA_AMD=y
> # CONFIG_PATA_ARTOP is not set
> # CONFIG_PATA_ATIIXP is not set
> # CONFIG_PATA_ATP867X is not set
> # CONFIG_PATA_CMD64X is not set
> # CONFIG_PATA_CS5520 is not set
> # CONFIG_PATA_CS5530 is not set
> # CONFIG_PATA_CS5536 is not set
> # CONFIG_PATA_EFAR is not set
> # CONFIG_PATA_HPT366 is not set
> # CONFIG_PATA_HPT37X is not set
> # CONFIG_PATA_HPT3X2N is not set
> # CONFIG_PATA_HPT3X3 is not set
> # CONFIG_PATA_IT821X is not set
> # CONFIG_PATA_JMICRON is not set
> # CONFIG_PATA_MARVELL is not set
> # CONFIG_PATA_NETCELL is not set
> # CONFIG_PATA_NINJA32 is not set
> # CONFIG_PATA_NS87415 is not set
> # CONFIG_PATA_OLDPIIX is not set
> # CONFIG_PATA_PDC2027X is not set
> # CONFIG_PATA_PDC_OLD is not set
> # CONFIG_PATA_RDC is not set
> # CONFIG_PATA_SC1200 is not set
> # CONFIG_PATA_SCH is not set
> # CONFIG_PATA_SERVERWORKS is not set
> CONFIG_PATA_SIL680=y
> # CONFIG_PATA_SIS is not set
> # CONFIG_PATA_TRIFLEX is not set
> # CONFIG_PATA_VIA is not set
> # CONFIG_PATA_WINBOND is not set
> 
> #
> # PIO-only SFF controllers
> #
> # CONFIG_PATA_MPIIX is not set
> # CONFIG_PATA_NS87410 is not set
> # CONFIG_PATA_RZ1000 is not set
> 
> #
> # Generic fallback / legacy drivers
> #
> CONFIG_PATA_ACPI=y
> CONFIG_ATA_GENERIC=y
2088d2109
< # CONFIG_LEDS_TRIGGER_IDE_DISK is not set

Here are my thoughts on what's happening:

Typical time for one revolution of the hard drive's platter is 8.3
milliseconds. Let's assume setup takes time t to initialize the hard
drive(s). Then the actual time for setup to be completed is a random
number between time t and time t plus 8.3 milliseconds.

During boot and measuring from the same begining of time t, let's
assume the second cpu tries to access the hard drive at time t plus
4 milliseconds. Now the computer boots up corectly half the time and
shows a bug the other half.

Since the bug is not in ide (depreciated) there must be some small
easily overlooked detail that was not brought forward.

Hope this helps,
    Russ

> BUG: unable to handle kernel paging request at f862aaa0
> IP: [<f8120282>] simple_map_write+0x82/0xbb [map_funcs]
> *pde = 36ad2067 *pte = 00000000
> Oops: 0002 [#1] SMP
> last sysfs file: /sys/devices/pci0000:00/0000:00:07.1/host0/target0:0:1/0:0:1:0/block/sdb/removable
> Modules linked in: rtc_core thermal_sys jedec_probe serio_raw rtc_lib snd_ca0106 snd_rawmidi snd_seq_device snd_ac97_codec cfi_probe hwmon gen_probe cfi_util amd76xrom(+) ac97_bus snd_pcm snd_timer container mtd amd_rng snd amd_k7_agp chipreg map_funcs
> +snd_page_alloc agpgart button
>
> Pid: 690, comm: modprobe Not tainted 2.6.35.9-smp #1 S2466 TIGER MPX/Unknown
> EIP: 0060:[<f8120282>] EFLAGS: 00010212 CPU: 1
> EIP is at simple_map_write+0x82/0xbb [map_funcs]
> EAX: 000000aa EBX: 00000020 ECX: 00000008 EDX: 000000aa
> ESI: f6869a48 EDI: f862aaa0 EBP: f6869a74 ESP: f6869a48
> DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> Process modprobe (pid: 690, ti=f6868000 task=f738ecb0 task.ti=f6868000)
> Stack:
> 000000aa 000000aa 000000aa 000000aa 000000aa 000000aa 000000aa 000000aa
> <0> 00000008 f6869b84 f6869a9c f6869d90 f8159ad4 000000aa 000000aa 000000aa
> <0> 000000aa 000000aa 000000aa 000000aa 000000aa 000aaaa0 00000000 00000004
> Call Trace:
> [<f8159ad4>] ? cfi_qry_mode_on+0xc74/0x1130 [cfi_util]
> [<f864be7c>] ? jedec_probe_chip+0x6fc/0x1394 [jedec_probe]
> [<f819c1c1>] ? cfi_probe_chip+0x41/0x48c [cfi_probe]
> [<f815d1aa>] ? mtd_do_chip_probe+0xaa/0x358 [gen_probe]
> [<f819c00d>] ? cfi_probe+0xd/0x10 [cfi_probe]
> [<f8129154>] ? do_map_probe+0x24/0x73 [chipreg]
> [<f812621a>] ? init_amd76xrom+0x21a/0x3d2 [amd76xrom]
> [<c100122d>] ? do_one_initcall+0x2d/0x180
> [<f8126000>] ? init_amd76xrom+0x0/0x3d2 [amd76xrom]
> [<c10614eb>] ? sys_init_module+0x9b/0x1e0
> [<c10aa49d>] ? sys_write+0x3d/0x70
> [<c134f83c>] ? syscall_call+0x7/0xb
> Code: 7f 17 f0 83 04 24 00 8b 5d f4 8b 75 f8 8b 7d fc 89 ec 5d c3 90 8d 74 26 00 01 cf 81 fb ff 01 00 00 77 2e 89 d9 c1 e9 02 8d 75 d4 <f3> a5 89 d9 83 e1 03 74 02 f3 a4 eb ca 90 01 cf 88 07 eb c3 66
> EIP: [<f8120282>] simple_map_write+0x82/0xbb [map_funcs] SS:ESP 0068:f6869a48
> CR2: 00000000f862aaa0
>
> Reported-by: Russell Whitaker <russ@ashlandhome.net>
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---
> drivers/mtd/maps/amd76xrom.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mtd/maps/amd76xrom.c b/drivers/mtd/maps/amd76xrom.c
> index 19fe92d..370509a 100644
> --- a/drivers/mtd/maps/amd76xrom.c
> +++ b/drivers/mtd/maps/amd76xrom.c
> @@ -154,6 +154,7 @@ static int __devinit amd76xrom_init_one (struct pci_dev *pdev,
> 			__func__,
> 			(unsigned long long)window->rsrc.start,
> 			(unsigned long long)window->rsrc.end);
> +		return -EBUSY;
> 	}
>
>
> -- 
> 1.7.0.4
>
