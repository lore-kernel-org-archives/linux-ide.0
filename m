From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [cdrom_check_status] BUG: unable to handle kernel NULL pointer
 dereference at 000001c0
Date: Wed, 08 Nov 2017 17:28:16 +0100
Message-ID: <7885793.0mqNGdeUvE@amdc3058>
References: <20171107102538.mzbfdxll3fpf2kqg@wfg-t540p.sh.intel.com>
        <CGME20171108162818epcas2p25c73e1093a9d8f20d9efb2f3cd469b45@epcas2p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:13177 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752647AbdKHQ2W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2017 11:28:22 -0500
In-reply-to: <20171107102538.mzbfdxll3fpf2kqg@wfg-t540p.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@sandisk.com>, linux-kernel@vger.kernel.org

On Tuesday, November 07, 2017 06:25:38 PM Fengguang Wu wrote:
> Hello,

Hi Fengguang,

> FYI this happens in v4.14-rc8 -- it's not necessarily a new bug.
> 
> [   22.626306] ide-cd: hdc: ATAPI 4X DVD-ROM drive, 512kB Cache
> [   22.627216] cdrom: Uniform CD-ROM driver Revision: 3.20
> [   22.638941] ide-cd: hdc: ATAPI 4X DVD-ROM drive, 512kB Cache
> [   22.665149] rdac: device handler registered
> [   22.666646] ACPI: Preparing to enter system sleep state S5
> [   22.666764] BUG: unable to handle kernel NULL pointer dereference at 000001c0
> [   22.666773] IP: cdrom_check_status+0x2c/0x90
> [   22.666774] *pde = 00000000 
> [   22.666777] Oops: 0000 [#1] SMP
> [   22.666782] CPU: 1 PID: 155 Comm: kworker/1:2 Not tainted 4.14.0-rc8 #127
> [   22.666783] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   22.666788] Workqueue: events_freezable_power_ disk_events_workfn
> [   22.666790] task: 4fe90980 task.stack: 507ac000
> [   22.666792] EIP: cdrom_check_status+0x2c/0x90
> [   22.666793] EFLAGS: 00210246 CPU: 1
> [   22.666795] EAX: 00000000 EBX: 4fefec00 ECX: 00000000 EDX: 00000000
> [   22.666796] ESI: 00000003 EDI: ffffffff EBP: 467a9340 ESP: 507aded0
> [   22.666797]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> [   22.666799] CR0: 80050033 CR2: 000001c0 CR3: 06e0f000 CR4: 00000690
> [   22.666803] Call Trace:
> [   22.666807]  ? ide_cdrom_check_events_real+0x1d/0x40
> [   22.666811]  ? cdrom_check_events+0xe/0x30
> [   22.666813]  ? disk_check_events+0x3a/0xf0
> [   22.666817]  ? process_one_work+0x16a/0x370
> [   22.666818]  ? process_one_work+0x117/0x370
> [   22.666820]  ? worker_thread+0x31/0x3b0
> [   22.666822]  ? kthread+0xd7/0x110
> [   22.666824]  ? process_one_work+0x370/0x370
> [   22.666826]  ? __kthread_create_on_node+0x160/0x160
> [   22.666830]  ? ret_from_fork+0x19/0x30
> [   22.666831] Code: 53 83 ec 14 89 c3 89 d1 be 03 00 00 00 65 a1 14 00 00 00 89 44 24 10 31 c0 8b 43 18 c7 44 24 04 00 00 00 00 c7 04 24 00 00 00 00 <8a> 80 c0 01 00 00 c7 44 24 08 00 00 00 00 83 e0 03 c7 44 24 0c
> [   22.666863] EIP: cdrom_check_status+0x2c/0x90 SS:ESP: 0068:507aded0
> [   22.666863] CR2: 00000000000001c0
> [   22.666870] ---[ end trace 2410e586dd8f88b2 ]---
> [   22.666872] Kernel panic - not syncing: Fatal exception
> 
> Attached the full dmesg and kconfig.

>From the dmesg:

[   18.372398] Uniform Multi-Platform E-IDE driver
[   18.373507] piix 0000:00:01.1: IDE controller (0x8086:0x7010 rev 0x00)
[   18.374773] piix 0000:00:01.1: not 100% native mode: will probe irqs later
[   18.376676]     ide0: BM-DMA at 0xc080-0xc087
[   18.377411]     ide1: BM-DMA at 0xc088-0xc08f
[   18.378121] Probing IDE interface ide0...
[... (rcu stuff done in parallel)]
[   18.984203] Probing IDE interface ide1...
[   19.772269] hdc: QEMU DVD-ROM, ATAPI CD/DVD-ROM drive
[   20.492253] hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO0
[   20.493396] hdc: MWDMA2 mode selected
[   20.494219] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   20.495001] ide1 at 0x170-0x177,0x376 on irq 15
[   20.497649] piix 0000:00:01.1: IDE controller (0x8086:0x7010 rev 0x00)
[   20.498835] piix 0000:00:01.1: not 100% native mode: will probe irqs later
[   20.500931]     ide0: BM-DMA at 0xc080-0xc087
[   20.501669]     ide1: BM-DMA at 0xc088-0xc08f
[   20.502354] Probing IDE interface ide0...
[   21.112206] Probing IDE interface ide1...
[   21.900269] hdc: QEMU DVD-ROM, ATAPI CD/DVD-ROM drive
[   22.620257] hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO0
[   22.621356] hdc: MWDMA2 mode selected
[   22.622168] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   22.622947] ide1 at 0x170-0x177,0x376 on irq 15
[   22.624740] ide-gd driver 1.18
[   22.625274] ide-cd driver 5.00
[   22.626306] ide-cd: hdc: ATAPI 4X DVD-ROM drive, 512kB Cache
[   22.627216] cdrom: Uniform CD-ROM driver Revision: 3.20
[   22.638941] ide-cd: hdc: ATAPI 4X DVD-ROM drive, 512kB Cache
[   22.665149] rdac: device handler registered
[   22.666646] ACPI: Preparing to enter system sleep state S5
[   22.666764] BUG: unable to handle kernel NULL pointer dereference at 000001c0

we can see that for some reason PIIX PCI IDE controller is probed
twice and later when we attach ide-cd driver to both instances of hdc
(in parallel) it ends up badly..

Something is very wrong here as pci_request_selected_regions() in
drivers/ide/setup-pci.c:ide_pci_enable() should allocate PCI resources
so the second probe attempt should not happen. Also interface/device
names reuse should be prevented by ide_find_port_slot()..

Does the dmesg for the good boot also contain double probe?

If not, can you add some debug to pci_request_selected_regions()?

[ I've seen Linus' opinion but it doesn't seem that IDE is a root
  cause of the problem that we are seeing here.. ] 

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

