From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [ata_port_probe] BUG: unable to handle kernel NULL pointer
 dereference at 0000000000000350
Date: Tue, 21 Nov 2017 20:19:15 +0800
Message-ID: <20171121121915.k3jcazsc6eugdo3k@wfg-t540p.sh.intel.com>
References: <20171121090529.p3bcdz5y5bs5mqk2@wfg-t540p.sh.intel.com>
 <20171121120935.t3ouyqq7byc5zd43@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:31376 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752083AbdKUMTS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 21 Nov 2017 07:19:18 -0500
Content-Disposition: inline
In-Reply-To: <20171121120935.t3ouyqq7byc5zd43@wfg-t540p.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, lkp@01.org

On Tue, Nov 21, 2017 at 08:09:35PM +0800, Fengguang Wu wrote:
>Hello,
>
>FYI this happens in mainline kernel 4.14.0-00902-g43ff2f4.
>It looks happen since 4.11.
>
>It occurs in 12 out of 108 boots.
>
>[   20.057810] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0c8 irq 15
>[   20.219346] ata2.01: NODEV after polling detection
>[   20.222140] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
>[   20.232461] ata2.00: configured for MWDMA2
>[   20.235209] ata2.00: disabled
>[   20.247746] BUG: unable to handle kernel NULL pointer dereference at 0000000000000350
>[   20.250638] IP: ata_port_wait_eh+0xa1/0xe5:
>						ata_port_wait_eh at include/scsi/scsi_host.h:764
>[   20.251018] PGD 0 P4D 0
>[   20.251018] Oops: 0000 [#1] PREEMPT SMP
>[   20.255428] CPU: 1 PID: 5 Comm: kworker/u4:0 Not tainted 4.14.0-00902-g43ff2f4 #1
>[   20.255428] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>[   20.263368] scsi host0: ata_piix
>[   20.267396] Workqueue: events_unbound async_run_entry_fn
>[   20.270725] scsi host1: ata_piix
>[   20.271036] ata3: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0c0 irq 14
>[   20.271039] ata4: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0c8 irq 15
>[   20.283654] Rounding down aligned max_sectors from 4294967295 to 4294967288
>[   20.298430] task: ffff8800001e6140 task.stack: ffff8800001e8000
>[   20.298430] RIP: 0010:ata_port_wait_eh+0xa1/0xe5:
>						ata_port_wait_eh at include/scsi/scsi_host.h:764
>[   20.298430] RSP: 0000:ffff8800001ebdc0 EFLAGS: 00010286
>[   20.304162] mtdoops: mtd device (mtddev=name/number) must be supplied
>[   20.304484] platform physmap-flash.0: failed to claim resource 0: [mem 0x08000000-0x07ffffff]
>[   20.305254] slram: not enough parameters.
>[   20.305257] Ramix PMC551 PCI Mezzanine Ram Driver. (C) 1999,2000 Nortel Networks.
>[   20.305263] pmc551: not detected
>[   20.327390] RAX: ffffffffffffffff RBX: ffff8800198a8000 RCX: ffff88001c80d8c0
>[   20.327390] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000246
>[   20.327390] RBP: 0000000000000246 R08: 0000000845a00e34 R09: 0000000000000000
>[   20.337395] R10: ffffffff95122ad0 R11: 0000000000000105 R12: ffff8800198ac008
>[   20.337395] R13: ffff880000081000 R14: 0000000000000000 R15: 0000000000000000
>[   20.347394] FS:  0000000000000000(0000) GS:ffff88001c800000(0000) knlGS:0000000000000000
>[   20.347394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[   20.357398] CR2: 0000000000000350 CR3: 000000001dc69000 CR4: 00000000000006a0
>[   20.357398] Call Trace:
>[   20.357398]  ? __list_del_entry+0x1d/0x1d:
>						rcu_read_unlock at include/linux/rcupdate.h:686
>						
>						__list_del_entry+0x1d/0x1d:
>						copy_siginfo at include/linux/signal.h:16
>						
>						__list_del_entry+0x1d/0x1d:
>						worker_detach_from_pool at kernel/workqueue.c:1727
>						
>						__list_del_entry+0x1d/0x1d:
>						kthread at kernel/kthread.c:190
>						
>						__list_del_entry+0x1d/0x1d:
>						attach_task at kernel/sched/fair.c:7239
>						
>						__list_del_entry+0x1d/0x1d:
>						rt_se_prio at kernel/sched/rt.c:891
>						
>						__list_del_entry+0x1d/0x1d:
>						autoremove_wake_function at kernel/sched/wait.c:376
>[   20.357398]  ata_port_probe+0x24/0x28:
>						ata_port_probe at drivers/ata/libata-core.c:6395
>[   20.367393]  async_port_probe+0x2b/0x42:
>						async_port_probe at drivers/ata/libata-core.c:6415
>[   20.367393]  async_run_entry_fn+0x35/0x105:
>						async_run_entry_fn at kernel/async.c:124
>[   20.367393]  process_one_work+0x1c9/0x310:


Here is a similar issue in ata_scsi_scan_host(). It only happened once.


/pkg/linux/x86_64-randconfig-in0-11110243/gcc-6/cf9b0772f2e410645fece13b749bd56505b998b8/dmesg-vm-ivb41-quantal-x86_64-4:20171120120806:x86_64-randconfig-in0-11110243:4.14.0-10859-gcf9b077:1

[   56.376960] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[   56.379169] ata2.00: configured for MWDMA2
[   56.381518] ata2.00: disabled
[   56.385696] sd 1:0:0:0: [sda] Attached SCSI disk
[   56.395326] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[   56.397957] general protection fault: 0000 [#1] PREEMPT SMP
[   56.399327] CPU: 1 PID: 175 Comm: kworker/u4:2 Not tainted 4.14.0-10859-gcf9b077 #1
[   56.401266] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   56.401269] Workqueue: events_unbound async_run_entry_fn
[   56.401269] task: ffff8800157b4b80 task.stack: ffffc90002bd8000
[   56.410136] sd 1:0:0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
[   56.410525] RIP: 0010:ata_dev_next+0xaa/0x1a0
[   56.410525] RSP: 0000:ffffc90002bdbd78 EFLAGS: 00010293
[   56.410525] RAX: ffff8800157baec0 RBX: 0000000000000002 RCX: 6b6b6b6b6b6b6b6b
[   56.416505] sd 1:0:0:0: [sda] Write Protect is off
[   56.416509] sd 1:0:0:0: [sda] Mode Sense: 73 00 10 08
[   56.420129] RDX: ffff8800157ba580 RSI: 0000000000000003 RDI: ffffffff84655e88
[   56.423387] RBP: ffff8800157ba580 R08: ffff8800157b5840 R09: 0000000000000000
[   56.423387] R10: 00000000d8047dcc R11: 00000000874f29a0 R12: 0000000000000000
[   56.426736] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   56.426770] R13: ffff8800157b9fc0 R14: 0000000000000000 R15: 0000000000000002
[   56.433439] FS:  0000000000000000(0000) GS:ffff88001e500000(0000) knlGS:0000000000000000
[   56.440089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.443387] CR2: ffffc900000b4000 CR3: 0000000004057000 CR4: 00000000000006a0
[   56.443387] Call Trace:
[   56.447038]  ata_scsi_scan_host+0x6e/0x290
[   56.447038]  async_run_entry_fn+0x73/0x210
[   56.447038]  process_one_work+0x4e7/0xad0
[   56.447038]  worker_thread+0x3c7/0x6b0
[   56.447038]  ? process_one_work+0xad0/0xad0
[   56.447038]  kthread+0x16b/0x180
[   56.453386]  ? __kthread_bind_mask+0xb0/0xb0
[   56.453386]  ret_from_fork+0x24/0x30
[   56.453386] Code: 0f 85 d2 00 00 00 e9 be 00 00 00 48 8d 04 2a eb 6f 48 89 c5 41 83 fc 01 74 45 41 83 fc 03 74 3f 49 8b 4d 00 48 8d 85 40 09 00 00 <f6> 41 18 01 0f 85 c7 00 00 00 e9 b0 00 00 00 48 01 d1 31 f6 48 
[   56.456714] RIP: ata_dev_next+0xaa/0x1a0 RSP: ffffc90002bdbd78
[   56.471116] ---[ end trace 37cd483db10972b3 ]---
[   56.472284] Kernel panic - not syncing: Fatal exception

Thanks,
Fengguang
