From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [ata_port_probe] BUG: unable to handle kernel NULL pointer
 dereference at 0000000000000350
Date: Tue, 21 Nov 2017 20:09:35 +0800
Message-ID: <20171121120935.t3ouyqq7byc5zd43@wfg-t540p.sh.intel.com>
References: <20171121090529.p3bcdz5y5bs5mqk2@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lxfz4orbnubblw2l"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2633 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751782AbdKUMJm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 21 Nov 2017 07:09:42 -0500
Content-Disposition: inline
In-Reply-To: <20171121090529.p3bcdz5y5bs5mqk2@wfg-t540p.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, lkp@01.org


--lxfz4orbnubblw2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

FYI this happens in mainline kernel 4.14.0-00902-g43ff2f4.
It looks happen since 4.11.

It occurs in 12 out of 108 boots.

[   20.057810] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0c8 irq 15
[   20.219346] ata2.01: NODEV after polling detection
[   20.222140] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[   20.232461] ata2.00: configured for MWDMA2
[   20.235209] ata2.00: disabled
[   20.247746] BUG: unable to handle kernel NULL pointer dereference at 0000000000000350
[   20.250638] IP: ata_port_wait_eh+0xa1/0xe5:
						ata_port_wait_eh at include/scsi/scsi_host.h:764
[   20.251018] PGD 0 P4D 0
[   20.251018] Oops: 0000 [#1] PREEMPT SMP
[   20.255428] CPU: 1 PID: 5 Comm: kworker/u4:0 Not tainted 4.14.0-00902-g43ff2f4 #1
[   20.255428] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   20.263368] scsi host0: ata_piix
[   20.267396] Workqueue: events_unbound async_run_entry_fn
[   20.270725] scsi host1: ata_piix
[   20.271036] ata3: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0c0 irq 14
[   20.271039] ata4: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0c8 irq 15
[   20.283654] Rounding down aligned max_sectors from 4294967295 to 4294967288
[   20.298430] task: ffff8800001e6140 task.stack: ffff8800001e8000
[   20.298430] RIP: 0010:ata_port_wait_eh+0xa1/0xe5:
						ata_port_wait_eh at include/scsi/scsi_host.h:764
[   20.298430] RSP: 0000:ffff8800001ebdc0 EFLAGS: 00010286
[   20.304162] mtdoops: mtd device (mtddev=name/number) must be supplied
[   20.304484] platform physmap-flash.0: failed to claim resource 0: [mem 0x08000000-0x07ffffff]
[   20.305254] slram: not enough parameters.
[   20.305257] Ramix PMC551 PCI Mezzanine Ram Driver. (C) 1999,2000 Nortel Networks.
[   20.305263] pmc551: not detected
[   20.327390] RAX: ffffffffffffffff RBX: ffff8800198a8000 RCX: ffff88001c80d8c0
[   20.327390] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000246
[   20.327390] RBP: 0000000000000246 R08: 0000000845a00e34 R09: 0000000000000000
[   20.337395] R10: ffffffff95122ad0 R11: 0000000000000105 R12: ffff8800198ac008
[   20.337395] R13: ffff880000081000 R14: 0000000000000000 R15: 0000000000000000
[   20.347394] FS:  0000000000000000(0000) GS:ffff88001c800000(0000) knlGS:0000000000000000
[   20.347394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.357398] CR2: 0000000000000350 CR3: 000000001dc69000 CR4: 00000000000006a0
[   20.357398] Call Trace:
[   20.357398]  ? __list_del_entry+0x1d/0x1d:
						rcu_read_unlock at include/linux/rcupdate.h:686
						
						__list_del_entry+0x1d/0x1d:
						copy_siginfo at include/linux/signal.h:16
						
						__list_del_entry+0x1d/0x1d:
						worker_detach_from_pool at kernel/workqueue.c:1727
						
						__list_del_entry+0x1d/0x1d:
						kthread at kernel/kthread.c:190
						
						__list_del_entry+0x1d/0x1d:
						attach_task at kernel/sched/fair.c:7239
						
						__list_del_entry+0x1d/0x1d:
						rt_se_prio at kernel/sched/rt.c:891
						
						__list_del_entry+0x1d/0x1d:
						autoremove_wake_function at kernel/sched/wait.c:376
[   20.357398]  ata_port_probe+0x24/0x28:
						ata_port_probe at drivers/ata/libata-core.c:6395
[   20.367393]  async_port_probe+0x2b/0x42:
						async_port_probe at drivers/ata/libata-core.c:6415
[   20.367393]  async_run_entry_fn+0x35/0x105:
						async_run_entry_fn at kernel/async.c:124
[   20.367393]  process_one_work+0x1c9/0x310:
						process_one_work at kernel/workqueue.c:2113
[   20.377388]  ? process_one_work+0x15c/0x310:
						process_one_work at kernel/workqueue.c:2084
[   20.387386]  worker_thread+0x1aa/0x25d:
						worker_thread at include/linux/compiler.h:178
[   20.397397]  ? process_scheduled_works+0x27/0x27:
						worker_thread at kernel/workqueue.c:2190
[   20.397397]  kthread+0xf1/0xf9:
						kthread at kernel/kthread.c:233
[   20.407398]  ? __list_del_entry+0x1d/0x1d:
						rcu_read_unlock at include/linux/rcupdate.h:686
						
						__list_del_entry+0x1d/0x1d:
						copy_siginfo at include/linux/signal.h:16
						
						__list_del_entry+0x1d/0x1d:
						worker_detach_from_pool at kernel/workqueue.c:1727
						
						__list_del_entry+0x1d/0x1d:
						kthread at kernel/kthread.c:190
						
						__list_del_entry+0x1d/0x1d:
						attach_task at kernel/sched/fair.c:7239
						
						__list_del_entry+0x1d/0x1d:
						rt_se_prio at kernel/sched/rt.c:891
						
						__list_del_entry+0x1d/0x1d:
						autoremove_wake_function at kernel/sched/wait.c:376
[   20.407398]  ret_from_fork+0x1f/0x30:
						ret_from_fork at arch/x86/entry/entry_64.S:443
[   20.407398] Code: 7b 10 48 89 ee e8 ed f3 41 00 e8 55 be 41 00 eb cb 48 89 e6 4c 89 e7 e8 6e d2 9a ff 48 8b 7b 10 48 89 ee e8 cf f3 41 00 48 8b 13 <8b> 82 50 03 00 00 83 e8 05 83 f8 02 76 09 f6 82 00 03 00 00 40
[   20.437384] RIP: ata_port_wait_eh+0xa1/0xe5:
						ata_port_wait_eh at include/scsi/scsi_host.h:764 RSP: ffff8800001ebdc0
[   20.447382] CR2: 0000000000000350
[   20.447382] ---[ end trace 28c525956cf088e8 ]---
[   20.447382] Kernel panic - not syncing: Fatal exception

Attached the full dmesg, kconfig and reproduce scripts.

In 4.11, it took different forms though:

/pkg/linux/x86_64-randconfig-a0-09172309/gcc-6/a351e9b9fc24e982ec2f0e76379a49826036da12/dmesg-vm-lkp-nhm-dp1-yocto-ia32-5:20170920183233:x86_64-randconfig-a0-09172309:4.11.0:1

[  322.035010] ata2.00: configured for MWDMA2
[  322.035723] ata2.00: disabled
[  322.036259] sd 0:0:0:0: [sda] Attached SCSI disk
[  322.038824] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  322.046217] ==================================================================
[  322.046951] BUG: KASAN: slab-out-of-bounds in spin_dump+0x39/0x240 at addr ffff88000e84d238
[  322.047779] Read of size 8 by task kworker/u4:0/5
[  322.048271] CPU: 0 PID: 5 Comm: kworker/u4:0 Not tainted 4.11.0 #1
[  322.048873] Workqueue: events_unbound async_run_entry_fn
[  322.049399] Call Trace:
[  322.049657]  dump_stack+0xb3/0x10b
[  322.050182]  kasan_object_err+0x21/0x70
[  322.050586]  kasan_report+0x34a/0x500
[  322.050959]  ? spin_dump+0x39/0x240
[  322.051319]  ? usleep_range+0x124/0x160
[  322.051702]  __asan_report_load8_noabort+0x19/0x20
[  322.052171]  spin_dump+0x39/0x240
[  322.052511]  ? __wake_up_sync+0x20/0x20
[  322.052899]  do_raw_spin_lock+0x63/0x190
[  322.053292]  _raw_spin_lock_irqsave+0x37/0x40
[  322.053729]  ata_port_wait_eh+0x102/0x2d0
[  322.053736] sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
[  322.054823]  ? ata_scsi_cmd_error_handler+0x450/0x450
[  322.055323]  ? __wake_up_common+0x140/0x140
[  322.055742]  ? _raw_spin_unlock_irqrestore+0x41/0x60
[  322.056240]  ata_port_probe+0x7e/0xa0
[  322.056605]  async_port_probe+0xc1/0xe0
[  322.056987]  async_run_entry_fn+0x156/0x5a0
[  322.057405]  process_one_work+0x8c1/0xf60
[  322.057801]  ? finish_task_switch+0x440/0x500
[  322.058232]  worker_thread+0xb27/0xfc0
[  322.058604]  kthread+0x38a/0x3a0
[  322.058927]  ? process_one_work+0xf60/0xf60
[  322.059381]  ? kthread_delayed_work_timer_fn+0x280/0x280
[  322.059553] sd 0:0:0:0: [sda] Write Protect is off
[  322.059561] sd 0:0:0:0: [sda] Mode Sense: 73 00 10 08
[  322.060850]  ret_from_fork+0x31/0x40
[  322.061203] Object at ffff88000e84d228, in cache kmalloc-8 size: 8
[  322.061800] Allocated:
[  322.062038] PID = 71
[  322.062269]  save_stack_trace+0x1b/0x20
[  322.062647]  save_stack+0x46/0xd0
[  322.062978]  kasan_kmalloc+0xb6/0xd0
[  322.063338]  kasan_slab_alloc+0x12/0x20
[  322.063718]  __kmalloc_track_caller+0x19c/0x280
[  322.064161]  kstrdup+0x3e/0x70
[  322.064478]  kstrdup_const+0x3e/0x50
[  322.064835]  kvasprintf_const+0x129/0x160
[  322.065233]  kobject_set_name_vargs+0x5a/0x130
[  322.065670]  device_create_groups_vargs+0x1b8/0x220
[  322.066145]  device_create+0xd8/0x100
[  322.066519]  bsg_register_queue+0x282/0x410
[  322.066932]  scsi_sysfs_add_sdev+0x307/0x540
[  322.067356]  do_scan_async+0x2d7/0x450
[  322.067727]  async_run_entry_fn+0x156/0x5a0
[  322.068137]  process_one_work+0x8c1/0xf60
[  322.068537]  worker_thread+0xb27/0xfc0
[  322.068909]  kthread+0x38a/0x3a0
[  322.069235]  ret_from_fork+0x31/0x40
[  322.069588] Freed:
[  322.069794] PID = 0
[  322.070007] (stack is not available)
[  322.070370] Memory state around the buggy address:
[  322.070838]  ffff88000e84d100: fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc fc


/pkg/linux/x86_64-randconfig-a0-09172309/gcc-6/a351e9b9fc24e982ec2f0e76379a49826036da12/dmesg-vm-lkp-nhm-dp1-yocto-ia32-2:20170920165427:x86_64-randconfig-a0-09172309:4.11.0:1

[  304.092431] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  304.104438] kasan: CONFIG_KASAN_INLINE enabled
[  304.104800] sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
[  304.104880] scsi host1: ata_piix
[  304.106268] kasan: GPF could be caused by NULL-ptr deref or user memory access
[  304.107047] general protection fault: 0000 [#1] PREEMPT SMP KASAN
[  304.107670] CPU: 0 PID: 5 Comm: kworker/u4:0 Not tainted 4.11.0 #1
[  304.108295] Workqueue: events_unbound async_run_entry_fn
[  304.108825] task: ffff88001448a3c0 task.stack: ffff880014498000
[  304.109431] RIP: 0010:ata_port_wait_eh+0x226/0x2d0
[  304.109905] RSP: 0000:ffff88001449fc40 EFLAGS: 00010206
[  304.110438] RAX: 0000000000000047 RBX: ffff8800110c0000 RCX: dffffc0000000000
[  304.111070] sd 0:0:0:0: [sda] Write Protect is off
[  304.111078] sd 0:0:0:0: [sda] Mode Sense: 73 00 10 08
[  304.111127] scsi host2: ata_piix
[  304.111476] ata3: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
[  304.111480] ata4: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
[  304.113088] Error: Driver 'pata_platform' is already registered, aborting...
[  304.114639] RDX: 0000000000000001 RSI: 0000000000000246 RDI: 0000000000000238
[  304.115367] RBP: ffff88001449fd10 R08: ffff880014e228a0 R09: 0000000000000002
[  304.116076] R10: ffffffff85007c38 R11: 0000000000000000 R12: ffffed0002218002
[  304.116953] R13: ffff8800110c3850 R14: 0000000000000000 R15: 0000000000000246
[  304.117670] FS:  0000000000000000(0000) GS:ffff880014e00000(0000) knlGS:0000000000000000
[  304.118443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  304.119008] CR2: 0000000000000000 CR3: 000000000500f000 CR4: 00000000000006b0
[  304.119709] Call Trace:
[  304.119963]  ? ata_scsi_cmd_error_handler+0x450/0x450
[  304.120470]  ? __wake_up_common+0x140/0x140
[  304.120892]  ? _raw_spin_unlock_irqrestore+0x41/0x60
[  304.121078] Rounding down aligned max_sectors from 4294967295 to 4294967288
[  304.122051]  ata_port_probe+0x7e/0xa0
[  304.122414]  async_port_probe+0xc1/0xe0
[  304.122801]  async_run_entry_fn+0x156/0x5a0
[  304.123212]  process_one_work+0x8c1/0xf60
[  304.123606]  ? finish_task_switch+0x440/0x500
[  304.124046]  worker_thread+0xb27/0xfc0
[  304.124325] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[  304.125234]  kthread+0x38a/0x3a0
[  304.125558]  ? process_one_work+0xf60/0xf60
[  304.125977]  ? kthread_delayed_work_timer_fn+0x280/0x280
[  304.126496]  ret_from_fork+0x31/0x40
[  304.126888] Code: d8 48 c1 e8 03 80 3c 08 00 74 08 48 89 df e8 52 10 00 fe 4c 8b 33 48 8b 8d 50 ff ff ff 49 8d be 38 02 00 00 48 89 f8 48 c1 e8 03 <0f> b6 04 08 84 c0 74 09 3c 03 7f 05 e8 09 10 00 fe 41 8b 86 38
[  304.128821] RIP: ata_port_wait_eh+0x226/0x2d0 RSP: ffff88001449fc40
[  304.129532] ---[ end trace 43acb02bbae190ce ]---
[  304.129996] Kernel panic - not syncing: Fatal exception


Thanks,
Fengguang

--lxfz4orbnubblw2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-vm-intel12-yocto-x86_64-4:20171114101205:x86_64-randconfig-s3-11131952:4.14.0-00902-g43ff2f4:1"
Content-Transfer-Encoding: quoted-printable

early console in setup code
[    0.000000] Linux version 4.14.0-00902-g43ff2f4 (kbuild@lkp-hsx03) (gcc =
version 6.4.0 20171026 (Debian 6.4.0-9)) #1 SMP PREEMPT Tue Nov 14 10:00:59=
 CST 2017
[    0.000000] Command line: ip=3D::::vm-intel12-yocto-x86_64-4::dhcp root=
=3D/dev/ram0 user=3Dlkp job=3D/lkp/scheduled/vm-intel12-yocto-x86_64-4/boot=
-1-yocto-minimal-x86_64-2016-04-22.cgz-43ff2f4db9d0f76452b77cfa645f02b47114=
3b24-20171114-84964-oglnnw-29.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-randconfi=
g-s3-11131952 branch=3Dlinus/master commit=3D43ff2f4db9d0f76452b77cfa645f02=
b471143b24 BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-s3-11131952/gcc-6/43ff=
2f4db9d0f76452b77cfa645f02b471143b24/vmlinuz-4.14.0-00902-g43ff2f4 max_upti=
me=3D600 RESULT_ROOT=3D/result/boot/1/vm-intel12-yocto-x86_64/yocto-minimal=
-x86_64-2016-04-22.cgz/x86_64-randconfig-s3-11131952/gcc-6/43ff2f4db9d0f764=
52b77cfa645f02b471143b24/29 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_alway=
s_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkm=
sg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic l=
oad_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=
=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3D=
ttyS0,11520
[    0.000000] KERNEL supported cpus:
[    0.000000] CPU: vendor_id 'GenuineIntel' unknown, using generic init.
[    0.000000] CPU: Your system may be unstable.
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001ffdbfff] usable
[    0.000000] BIOS-e820: [mem 0x000000001ffdc000-0x000000001fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 0=
4/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] tsc: Unable to calibrate against PIT
[    0.000000] tsc: No reference (HPET/PMTIMER) available
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0x1ffdc max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask FF80000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000f6a70-0x000f6a7f] mapped at =
[ffffffffff200a70]
[    0.000000]   mpc: f6a80-f6b74
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
[    0.000000] BRK [0x1f7c0000, 0x1f7c0fff] PGTABLE
[    0.000000] BRK [0x1f7c1000, 0x1f7c1fff] PGTABLE
[    0.000000] BRK [0x1f7c2000, 0x1f7c2fff] PGTABLE
[    0.000000] BRK [0x1f7c3000, 0x1f7c3fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x1fb0c000-0x1ffcffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F6860 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x000000001FFE1628 000030 (v01 BOCHS  BXPCRSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x000000001FFE147C 000074 (v01 BOCHS  BXPCFACP 00=
000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x000000001FFE0040 00143C (v01 BOCHS  BXPCDSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: FACS 0x000000001FFE0000 000040
[    0.000000] ACPI: APIC 0x000000001FFE1570 000080 (v01 BOCHS  BXPCAPIC 00=
000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x000000001FFE15F0 000038 (v01 BOCHS  BXPCHPET 00=
000001 BXPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000001ffdbfff]
[    0.000000] NODE_DATA(0) allocated [mem 0x1ffd9000-0x1ffdbfff]
[    0.000000] kvm-clock: cpu 0, msr 0:1ffd7001, primary cpu clock
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: using sched offset of 3188775168 cycles
[    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles:=
 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000001000-0x000000001ffdbfff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001ffdbfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000001ffdb=
fff]
[    0.000000] On node 0 totalpages: 130938
[    0.000000]   DMA32 zone: 2048 pages used for memmap
[    0.000000]   DMA32 zone: 21 pages reserved
[    0.000000]   DMA32 zone: 130938 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC =
INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC =
INT 05
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC =
INT 09
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC =
INT 0a
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC =
INT 0b
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC =
INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC =
INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC =
INT 04
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC =
INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC =
INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC =
INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC =
INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC =
INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC =
INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC =
INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] e820: [mem 0x20000000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:2 nr_=
node_ids:1
[    0.000000] percpu: Embedded 482 pages/cpu @ffff88001c600000 s1943552 r0=
 d30720 u2097152
[    0.000000] pcpu-alloc: s1943552 r0 d30720 u2097152 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 [0] 1=20
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 1c60d500
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 128869
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: ip=3D::::vm-intel12-yocto-x86_64-4::dhc=
p root=3D/dev/ram0 user=3Dlkp job=3D/lkp/scheduled/vm-intel12-yocto-x86_64-=
4/boot-1-yocto-minimal-x86_64-2016-04-22.cgz-43ff2f4db9d0f76452b77cfa645f02=
b471143b24-20171114-84964-oglnnw-29.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-ran=
dconfig-s3-11131952 branch=3Dlinus/master commit=3D43ff2f4db9d0f76452b77cfa=
645f02b471143b24 BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-s3-11131952/gcc-=
6/43ff2f4db9d0f76452b77cfa645f02b471143b24/vmlinuz-4.14.0-00902-g43ff2f4 ma=
x_uptime=3D600 RESULT_ROOT=3D/result/boot/1/vm-intel12-yocto-x86_64/yocto-m=
inimal-x86_64-2016-04-22.cgz/x86_64-randconfig-s3-11131952/gcc-6/43ff2f4db9=
d0f76452b77cfa645f02b471143b24/29 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq=
_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk=
=2Edevkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=
=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.l=
og_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 co=
nsole=3DttyS
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] PID hash table entries: 2048 (order: 2, 16384 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 459676K/523752K available (11540K kernel code, 2578K=
 rwdata, 5668K rodata, 3064K init, 19332K bss, 64076K reserved, 0K cma-rese=
rved)
[    0.003333] Preemptible hierarchical RCU implementation.
[    0.003333] 	RCU event tracing is enabled.
[    0.003333] 	RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_ids=3D2.
[    0.003333] 	RCU priority boosting: priority 1 delay 500 ms.
[    0.003333] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_ti=
meout).
[    0.003333] 	Tasks RCU enabled.
[    0.003333] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2
[    0.003333] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
[    0.003333] console [ttyS0] enabled
[    0.003333] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.003333] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.003333] ... MAX_LOCK_DEPTH:          48
[    0.003333] ... MAX_LOCKDEP_KEYS:        8191
[    0.003333] ... CLASSHASH_SIZE:          4096
[    0.003333] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.003333] ... MAX_LOCKDEP_CHAINS:      65536
[    0.003333] ... CHAINHASH_SIZE:          32768
[    0.003333]  memory used by lock dependency info: 7871 kB
[    0.003333]  per task-struct memory footprint: 2688 bytes
[    0.003333] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 19112604467 ns
[    0.003333] hpet clockevent registered
[    0.003360] tsc: Detected 2926.328 MHz processor
[    0.004136] tsc: Marking TSC unstable due to TSCs unsynchronized
[    0.004301] Calibrating delay loop (skipped) preset value.. 5854.51 Bogo=
MIPS (lpj=3D9754426)
[    0.006676] pid_max: default: 4096 minimum: 301
[    0.007518] ACPI: Core revision 20170728
[    0.016758] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.018553] Dentry cache hash table entries: 65536 (order: 7, 524288 byt=
es)
[    0.019886] Inode-cache hash table entries: 32768 (order: 6, 262144 byte=
s)
[    0.020093] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
[    0.021176] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 by=
tes)
[    0.024599] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.025439] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.026528] Freeing SMP alternatives memory: 28K
[    0.028563] smpboot: Max logical packages: 2
[    0.030241] x2apic enabled
[    0.031005] Switched APIC routing to physical x2apic.
[    0.031791] enabled ExtINT on CPU#0
[    0.033452] ENABLING IO-APIC IRQs
[    0.034037] init IO_APIC IRQs
[    0.034545]  apic 0 pin 0 not connected
[    0.035226] IOAPIC[0]: Set routing entry (0-1 -> 0x31 -> IRQ 1 Mode:0 Ac=
tive:0 Dest:0)
[    0.036503] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-3 -> 0x33 -> IRQ 3 Mode:0 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-4 -> 0x34 -> IRQ 4 Mode:0 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-5 -> 0x35 -> IRQ 5 Mode:1 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-6 -> 0x36 -> IRQ 6 Mode:0 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-7 -> 0x37 -> IRQ 7 Mode:0 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-8 -> 0x38 -> IRQ 8 Mode:0 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-9 -> 0x39 -> IRQ 9 Mode:1 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-10 -> 0x3a -> IRQ 10 Mode:1 =
Active:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-11 -> 0x3b -> IRQ 11 Mode:1 =
Active:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-12 -> 0x3c -> IRQ 12 Mode:0 =
Active:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-13 -> 0x3d -> IRQ 13 Mode:0 =
Active:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-14 -> 0x3e -> IRQ 14 Mode:0 =
Active:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-15 -> 0x3f -> IRQ 15 Mode:0 =
Active:0 Dest:0)
[    0.036666]  apic 0 pin 16 not connected
[    0.036666]  apic 0 pin 17 not connected
[    0.036666]  apic 0 pin 18 not connected
[    0.036666]  apic 0 pin 19 not connected
[    0.036666]  apic 0 pin 20 not connected
[    0.036666]  apic 0 pin 21 not connected
[    0.036666]  apic 0 pin 22 not connected
[    0.036666]  apic 0 pin 23 not connected
[    0.036666] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.036666] Using local APIC timer interrupts.
[    0.036666] calibrating APIC timer ...
[    0.039999] ... lapic delta =3D 6249836
[    0.039999] ... PM-Timer delta =3D 357946
[    0.039999] ... PM-Timer result ok
[    0.039999] ..... delta 6249836
[    0.039999] ..... mult: 268428439
[    0.039999] ..... calibration result: 3333245
[    0.039999] ..... CPU clock speed is 2926.1825 MHz.
[    0.039999] ..... host bus clock speed is 1000.0245 MHz.
[    0.040067] smpboot: CPU0: GenuineIntel Intel Core i7 9xx (Nehalem Class=
 Core i7) (family: 0x6, model: 0x1a, stepping: 0x3)
[    0.053399] Performance Events: no PMU driver, software events only.
[    0.060022] Hierarchical SRCU implementation.
[    0.076232] NMI watchdog: Perf event create on CPU 0 failed with -2
[    0.076674] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.090014] smp: Bringing up secondary CPUs ...
[    0.120705] x86: Booting SMP configuration:
[    0.121430] .... node  #0, CPUs:      #1
[    0.003333] kvm-clock: cpu 1, msr 0:1ffd7041, secondary cpu clock
[    0.003333] masked ExtINT on CPU#1
[    0.143395] KVM setup async PF for cpu 1
[    0.143395] kvm-stealtime: cpu 1, msr 1c80d500
[    0.144944] smp: Brought up 1 node, 2 CPUs
[    0.146695] smpboot: Total of 2 processors activated (11709.03 BogoMIPS)
[    0.154463] devtmpfs: initialized
[    0.161736] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.163355] futex hash table entries: 16 (order: -1, 2048 bytes)
[    0.164447] xor: measuring software checksum speed
[    0.196675]    prefetch64-sse: 11912.400 MB/sec
[    0.230009]    generic_sse: 10309.200 MB/sec
[    0.230658] xor: using function: prefetch64-sse (11912.400 MB/sec)
[    0.231691] prandom: seed boundary self test passed
[    0.233436] prandom: 100 self tests passed
[    0.234073] pinctrl core: initialized pinctrl subsystem
[    0.235890] regulator-dummy: Failed to create debugfs directory
[    0.236860] RTC time: 10:11:37, date: 11/14/17
[    0.239278] NET: Registered protocol family 16
[    0.242760] workqueue: round-robin CPU selection forced, expect performa=
nce impact
[    0.266888] ACPI: bus type PCI registered
[    0.267498] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.268893] dca service started, version 1.12.1
[    0.270175] PCI: Using configuration type 1 for base access
[    0.344099] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.403370] raid6: sse2x1   gen()  4299 MB/s
[    0.463385] raid6: sse2x1   xor()  2980 MB/s
[    0.520017] raid6: sse2x2   gen()  4862 MB/s
[    0.576677] raid6: sse2x2   xor()  1792 MB/s
[    0.633360] raid6: sse2x4   gen()  2334 MB/s
[    0.690015] raid6: sse2x4   xor()  1576 MB/s
[    0.691395] raid6: using algorithm sse2x2 gen() 4862 MB/s
[    0.693074] raid6: .... xor() 1792 MB/s, rmw enabled
[    0.693344] raid6: using ssse3x2 recovery algorithm
[    0.698159] ACPI: Added _OSI(Module Device)
[    0.698159] ACPI: Added _OSI(Processor Device)
[    0.698624] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.699309] ACPI: Added _OSI(Processor Aggregator Device)
[    0.708075] ACPI: Interpreter enabled
[    0.708741] ACPI: (supports S0 S4 S5)
[    0.709299] ACPI: Using IOAPIC for interrupt routing
[    0.710104] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.756558] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.756684] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.757635] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.758779] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    0.768708] acpiphp: Slot [3] registered
[    0.773492] acpiphp: Slot [4] registered
[    0.774168] acpiphp: Slot [5] registered
[    0.776771] acpiphp: Slot [6] registered
[    0.777475] acpiphp: Slot [7] registered
[    0.778209] acpiphp: Slot [8] registered
[    0.778953] acpiphp: Slot [9] registered
[    0.786775] acpiphp: Slot [10] registered
[    0.787390] acpiphp: Slot [11] registered
[    0.787516] acpiphp: Slot [12] registered
[    0.788258] acpiphp: Slot [13] registered
[    0.789025] acpiphp: Slot [14] registered
[    0.790104] acpiphp: Slot [15] registered
[    0.790845] acpiphp: Slot [16] registered
[    0.791523] acpiphp: Slot [17] registered
[    0.792228] acpiphp: Slot [18] registered
[    0.792946] acpiphp: Slot [19] registered
[    0.793450] acpiphp: Slot [20] registered
[    0.794168] acpiphp: Slot [21] registered
[    0.794858] acpiphp: Slot [22] registered
[    0.800144] acpiphp: Slot [23] registered
[    0.800874] acpiphp: Slot [24] registered
[    0.801594] acpiphp: Slot [25] registered
[    0.802343] acpiphp: Slot [26] registered
[    0.803449] acpiphp: Slot [27] registered
[    0.804206] acpiphp: Slot [28] registered
[    0.804936] acpiphp: Slot [29] registered
[    0.805645] acpiphp: Slot [30] registered
[    0.806774] acpiphp: Slot [31] registered
[    0.807475] PCI host bridge to bus 0000:00
[    0.809520] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.810018] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.813352] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.815567] pci_bus 0000:00: root bus resource [mem 0x20000000-0xfebffff=
f window]
[    0.816685] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.820171] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.825063] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.828981] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.849242] pci 0000:00:01.1: reg 0x20: [io  0xc0c0-0xc0cf]
[    0.856749] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]
[    0.863333] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.876681] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]
[    0.878677] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.881273] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.884416] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX=
4 ACPI
[    0.886700] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX=
4 SMB
[    0.901450] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.909562] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.923346] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.976694] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.986892] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.992177] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    1.009028] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    1.063348] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    1.073451] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
[    1.093351] pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
[    1.116683] pci 0000:00:04.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
[    1.166681] pci 0000:00:04.0: reg 0x20: [mem 0xfe000000-0xfe003fff 64bit=
 pref]
[    1.200727] pci 0000:00:05.0: [1af4:1001] type 00 class 0x010000
[    1.220014] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc0bf]
[    1.236681] pci 0000:00:05.0: reg 0x14: [mem 0xfebf2000-0xfebf2fff]
[    1.286684] pci 0000:00:05.0: reg 0x20: [mem 0xfe004000-0xfe007fff 64bit=
 pref]
[    1.308930] pci 0000:00:06.0: [8086:25ab] type 00 class 0x088000
[    1.324536] pci 0000:00:06.0: reg 0x10: [mem 0xfebf3000-0xfebf300f]
[    1.360575] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    1.362999] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    1.364072] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    1.367413] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    1.369457] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    1.379999] SCSI subsystem initialized
[    1.380314] libata version 3.00 loaded.
[    1.381606] ACPI: bus type USB registered
[    1.383176] usbcore: registered new interface driver usbfs
[    1.383333] usbcore: registered new interface driver hub
[    1.383464] usbcore: registered new device driver usb
[    1.385492] media: Linux media interface: v0.10
[    1.386666] Linux video capture interface: v2.00
[    1.386666] pps_core: LinuxPPS API ver. 1 registered
[    1.386666] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    1.393921] Unable to find dmi tokens
[    1.403333] FPGA manager framework
[    1.403333] PCI: Using ACPI for IRQ routing
[    1.403343] PCI: pci_cache_line_size set to 64 bytes
[    1.405245] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    1.406682] e820: reserve RAM buffer [mem 0x1ffdc000-0x1fffffff]
[    1.418802] HPET: 3 timers in total, 0 timers will be used for per-cpu t=
imer
[    1.420058] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.421452] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    1.428606] clocksource: Switched to clocksource kvm-clock
[    1.429993] FS-Cache: Loaded
[    1.430758] pnp: PnP ACPI init
[    1.432190] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.434732] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.437097] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    1.439202] pnp 00:03: [dma 2]
[    1.440256] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    1.442652] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    1.445070] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.448258] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.452045] pnp: PnP ACPI: found 7 devices
[    1.462390] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    1.465663] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.467677] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.469601] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    1.471861] pci_bus 0000:00: resource 7 [mem 0x20000000-0xfebfffff windo=
w]
[    1.474231] NET: Registered protocol family 1
[    1.475743] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    1.477669] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    1.480163] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    1.482063] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    1.484408] PCI: CLS 0 bytes, default 64
[    1.487745] Trying to unpack rootfs image as initramfs...
[    4.287782] Freeing initrd memory: 4880K
[    4.309559] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2a2=
e6a714ac, max_idle_ns: 440795306413 ns
[    4.318521] Scanning for low memory corruption every 60 seconds
[    4.338018] PCLMULQDQ-NI instructions are not detected.
[    4.339346] AVX or AES-NI instructions are not detected.
[    4.340330] CPU feature 'AVX registers' is not supported.
[    4.341458] CPU feature 'AVX registers' is not supported.
[    4.342432] CPU feature 'AVX registers' is not supported.
[    4.343376] AVX2 instructions are not detected.
[    4.360899] spin_lock-torture:--- Start of test [debug]: nwriters_stress=
=3D4 nreaders_stress=3D0 stat_interval=3D60 verbose=3D1 shuffle_interval=3D=
3 stutter=3D5 shutdown_secs=3D0 onoff_interval=3D0 onoff_holdoff=3D0
[    4.363913] spin_lock-torture: Creating torture_shuffle task
[    4.365176] spin_lock-torture: Creating torture_stutter task
[    4.365621] spin_lock-torture: torture_shuffle task started
[    4.367296] spin_lock-torture: Creating lock_torture_writer task
[    4.368527] spin_lock-torture: torture_stutter task started
[    4.369629] spin_lock-torture: Creating lock_torture_writer task
[    4.370605] spin_lock-torture: lock_torture_writer task started
[    4.381761] spin_lock-torture: Creating lock_torture_writer task
[    4.382874] spin_lock-torture: lock_torture_writer task started
[    4.384000] spin_lock-torture: Creating lock_torture_writer task
[    4.385924] spin_lock-torture: lock_torture_writer task started
[    4.387032] spin_lock-torture: Creating lock_torture_stats task
[    4.388238] spin_lock-torture: lock_torture_writer task started
[    4.389532] spin_lock-torture: lock_torture_stats task started
[   11.049667] torture_init_begin: Refusing rcu init: spin_lock running.
[   11.051623] torture_init_begin: One torture test at a time!
[   11.055266] Initialise system trusted keyrings
[   11.056469] Key type blacklist registered
[   11.071798] workingset: timestamp_bits=3D40 max_order=3D17 bucket_order=
=3D0
[   11.082712] zbud: loaded
[   11.085429] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   11.087553] ntfs: driver 2.1.32 [Flags: R/O DEBUG].
[   11.092533] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[   11.114131] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[   11.136912] qnx6: QNX6 filesystem 1.0.0 registered.
[   11.138870] fuse init (API version 7.26)
[   11.139809] SGI XFS with security attributes, no debug enabled
[   11.178915] gfs2: GFS2 installed
[   11.209501] async_tx: api initialized (async)
[   11.210275] Key type asymmetric registered
[   11.211130] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 248)
[   11.216050] io scheduler noop registered
[   11.216754] io scheduler deadline registered
[   11.217559] io scheduler cfq registered (default)
[   11.218346] io scheduler mq-deadline registered
[   11.219150] io scheduler kyber registered
[   11.219949] io scheduler bfq registered
[   11.225291] test_string_helpers: Running tests...
[   11.252708] test_hexdump: all 1184 tests passed
[   11.253919] test_firmware: interface ready
[   11.270453] test_hash: __hash_32() has no arch implementation to test.
[   11.282654] test_hash: hash_32() has no arch implementation to test.
[   11.283645] test_hash: hash_64() has no arch implementation to test.
[   11.284594] test_hash: 33152 tests passed.
[   11.285225] test_siphash: self-tests: pass
[   11.508419] test_bitmap: test 13: input is '0-2047:128/256' OK, Time: 12=
59
[   11.515551] test_bitmap: all 460506 tests passed
[   11.516272] test_uuid: all 18 tests passed
[   11.517689] crc32: CRC_LE_BITS =3D 64, CRC_BE BITS =3D 64
[   11.518509] crc32: self tests passed, processed 225944 bytes in 188378 n=
sec
[   11.519904] crc32c: CRC_LE_BITS =3D 64
[   11.520542] crc32c: self tests passed, processed 225944 bytes in 92058 n=
sec
[   11.541588] crc32_combine: 8373 self tests passed
[   11.562655] crc32c_combine: 8373 self tests passed
[   11.563888] xz_dec_test: module loaded
[   11.564549] xz_dec_test: Create a device node with 'mknod xz_dec_test c =
247 0' and write .xz files to it.
[   11.566825] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[   11.568338] rbtree testing
[   12.826281]  -> test 1 (latency of nnodes insert+delete): 36811 cycles
[   14.518553]  -> test 2 (latency of nnodes cached insert+delete): 49475 c=
ycles
[   14.723453]  -> test 3 (latency of inorder traversal): 5897 cycles
[   14.725972]  -> test 4 (latency to fetch first node)
[   14.726845]         non-cached: 42 cycles
[   14.727495]         cached: 0 cycles
[   14.818351] augmented rbtree testing
[   16.551871]  -> test 1 (latency of nnodes insert+delete): 50728 cycles
[   18.620614]  -> test 2 (latency of nnodes cached insert+delete): 60458 c=
ycles
[   18.747084] gpio_it87: no device
[   18.748123] gpio-mockup: probe of gpio-mockup failed with error -22
[   18.755175] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
[   18.763552] ipmi message handler version 39.2
[   18.764310] IPMI System Interface driver.
[   18.765258] ipmi_si: Unable to find any System Interface(s)
[   18.766170] IPMI SSIF Interface driver
[   18.766928] IPMI Watchdog: driver initialized
[   18.776006] ioatdma: Intel(R) QuickData Technology Driver 4.00
[   18.904876] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[   18.963714] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[   18.966184] console [ttyS0] disabled
[    0.000000] Linux version 4.14.0-00902-g43ff2f4 (kbuild@lkp-hsx03) (gcc =
version 6.4.0 20171026 (Debian 6.4.0-9)) #1 SMP PREEMPT Tue Nov 14 10:00:59=
 CST 2017
[    0.000000] Command line: ip=3D::::vm-intel12-yocto-x86_64-4::dhcp root=
=3D/dev/ram0 user=3Dlkp job=3D/lkp/scheduled/vm-intel12-yocto-x86_64-4/boot=
-1-yocto-minimal-x86_64-2016-04-22.cgz-43ff2f4db9d0f76452b77cfa645f02b47114=
3b24-20171114-84964-oglnnw-29.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-randconfi=
g-s3-11131952 branch=3Dlinus/master commit=3D43ff2f4db9d0f76452b77cfa645f02=
b471143b24 BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-s3-11131952/gcc-6/43ff=
2f4db9d0f76452b77cfa645f02b471143b24/vmlinuz-4.14.0-00902-g43ff2f4 max_upti=
me=3D600 RESULT_ROOT=3D/result/boot/1/vm-intel12-yocto-x86_64/yocto-minimal=
-x86_64-2016-04-22.cgz/x86_64-randconfig-s3-11131952/gcc-6/43ff2f4db9d0f764=
52b77cfa645f02b471143b24/29 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_alway=
s_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkm=
sg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic l=
oad_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=
=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3D=
ttyS0,11520
[    0.000000] KERNEL supported cpus:
[    0.000000] CPU: vendor_id 'GenuineIntel' unknown, using generic init.
[    0.000000] CPU: Your system may be unstable.
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001ffdbfff] usable
[    0.000000] BIOS-e820: [mem 0x000000001ffdc000-0x000000001fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 0=
4/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] tsc: Unable to calibrate against PIT
[    0.000000] tsc: No reference (HPET/PMTIMER) available
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0x1ffdc max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask FF80000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000f6a70-0x000f6a7f] mapped at =
[ffffffffff200a70]
[    0.000000]   mpc: f6a80-f6b74
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
[    0.000000] BRK [0x1f7c0000, 0x1f7c0fff] PGTABLE
[    0.000000] BRK [0x1f7c1000, 0x1f7c1fff] PGTABLE
[    0.000000] BRK [0x1f7c2000, 0x1f7c2fff] PGTABLE
[    0.000000] BRK [0x1f7c3000, 0x1f7c3fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x1fb0c000-0x1ffcffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F6860 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x000000001FFE1628 000030 (v01 BOCHS  BXPCRSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x000000001FFE147C 000074 (v01 BOCHS  BXPCFACP 00=
000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x000000001FFE0040 00143C (v01 BOCHS  BXPCDSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: FACS 0x000000001FFE0000 000040
[    0.000000] ACPI: APIC 0x000000001FFE1570 000080 (v01 BOCHS  BXPCAPIC 00=
000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x000000001FFE15F0 000038 (v01 BOCHS  BXPCHPET 00=
000001 BXPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000001ffdbfff]
[    0.000000] NODE_DATA(0) allocated [mem 0x1ffd9000-0x1ffdbfff]
[    0.000000] kvm-clock: cpu 0, msr 0:1ffd7001, primary cpu clock
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: using sched offset of 3188775168 cycles
[    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles:=
 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000001000-0x000000001ffdbfff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001ffdbfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000001ffdb=
fff]
[    0.000000] On node 0 totalpages: 130938
[    0.000000]   DMA32 zone: 2048 pages used for memmap
[    0.000000]   DMA32 zone: 21 pages reserved
[    0.000000]   DMA32 zone: 130938 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC =
INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC =
INT 05
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC =
INT 09
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC =
INT 0a
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC =
INT 0b
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC =
INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC =
INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC =
INT 04
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC =
INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC =
INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC =
INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC =
INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC =
INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC =
INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC =
INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] e820: [mem 0x20000000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:2 nr_=
node_ids:1
[    0.000000] percpu: Embedded 482 pages/cpu @ffff88001c600000 s1943552 r0=
 d30720 u2097152
[    0.000000] pcpu-alloc: s1943552 r0 d30720 u2097152 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 [0] 1=20
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 1c60d500
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 128869
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: ip=3D::::vm-intel12-yocto-x86_64-4::dhc=
p root=3D/dev/ram0 user=3Dlkp job=3D/lkp/scheduled/vm-intel12-yocto-x86_64-=
4/boot-1-yocto-minimal-x86_64-2016-04-22.cgz-43ff2f4db9d0f76452b77cfa645f02=
b471143b24-20171114-84964-oglnnw-29.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-ran=
dconfig-s3-11131952 branch=3Dlinus/master commit=3D43ff2f4db9d0f76452b77cfa=
645f02b471143b24 BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-s3-11131952/gcc-=
6/43ff2f4db9d0f76452b77cfa645f02b471143b24/vmlinuz-4.14.0-00902-g43ff2f4 ma=
x_uptime=3D600 RESULT_ROOT=3D/result/boot/1/vm-intel12-yocto-x86_64/yocto-m=
inimal-x86_64-2016-04-22.cgz/x86_64-randconfig-s3-11131952/gcc-6/43ff2f4db9=
d0f76452b77cfa645f02b471143b24/29 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq=
_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk=
=2Edevkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=
=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.l=
og_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 co=
nsole=3DttyS
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] PID hash table entries: 2048 (order: 2, 16384 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 459676K/523752K available (11540K kernel code, 2578K=
 rwdata, 5668K rodata, 3064K init, 19332K bss, 64076K reserved, 0K cma-rese=
rved)
[    0.003333] Preemptible hierarchical RCU implementation.
[    0.003333] 	RCU event tracing is enabled.
[    0.003333] 	RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_ids=3D2.
[    0.003333] 	RCU priority boosting: priority 1 delay 500 ms.
[    0.003333] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_ti=
meout).
[    0.003333] 	Tasks RCU enabled.
[    0.003333] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2
[    0.003333] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
[    0.003333] console [ttyS0] enabled
[    0.003333] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.003333] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.003333] ... MAX_LOCK_DEPTH:          48
[    0.003333] ... MAX_LOCKDEP_KEYS:        8191
[    0.003333] ... CLASSHASH_SIZE:          4096
[    0.003333] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.003333] ... MAX_LOCKDEP_CHAINS:      65536
[    0.003333] ... CHAINHASH_SIZE:          32768
[    0.003333]  memory used by lock dependency info: 7871 kB
[    0.003333]  per task-struct memory footprint: 2688 bytes
[    0.003333] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 19112604467 ns
[    0.003333] hpet clockevent registered
[    0.003360] tsc: Detected 2926.328 MHz processor
[    0.004136] tsc: Marking TSC unstable due to TSCs unsynchronized
[    0.004301] Calibrating delay loop (skipped) preset value.. 5854.51 Bogo=
MIPS (lpj=3D9754426)
[    0.006676] pid_max: default: 4096 minimum: 301
[    0.007518] ACPI: Core revision 20170728
[    0.016758] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.018553] Dentry cache hash table entries: 65536 (order: 7, 524288 byt=
es)
[    0.019886] Inode-cache hash table entries: 32768 (order: 6, 262144 byte=
s)
[    0.020093] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
[    0.021176] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 by=
tes)
[    0.024599] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.025439] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.026528] Freeing SMP alternatives memory: 28K
[    0.028563] smpboot: Max logical packages: 2
[    0.030241] x2apic enabled
[    0.031005] Switched APIC routing to physical x2apic.
[    0.031791] enabled ExtINT on CPU#0
[    0.033452] ENABLING IO-APIC IRQs
[    0.034037] init IO_APIC IRQs
[    0.034545]  apic 0 pin 0 not connected
[    0.035226] IOAPIC[0]: Set routing entry (0-1 -> 0x31 -> IRQ 1 Mode:0 Ac=
tive:0 Dest:0)
[    0.036503] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-3 -> 0x33 -> IRQ 3 Mode:0 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-4 -> 0x34 -> IRQ 4 Mode:0 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-5 -> 0x35 -> IRQ 5 Mode:1 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-6 -> 0x36 -> IRQ 6 Mode:0 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-7 -> 0x37 -> IRQ 7 Mode:0 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-8 -> 0x38 -> IRQ 8 Mode:0 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-9 -> 0x39 -> IRQ 9 Mode:1 Ac=
tive:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-10 -> 0x3a -> IRQ 10 Mode:1 =
Active:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-11 -> 0x3b -> IRQ 11 Mode:1 =
Active:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-12 -> 0x3c -> IRQ 12 Mode:0 =
Active:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-13 -> 0x3d -> IRQ 13 Mode:0 =
Active:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-14 -> 0x3e -> IRQ 14 Mode:0 =
Active:0 Dest:0)
[    0.036666] IOAPIC[0]: Set routing entry (0-15 -> 0x3f -> IRQ 15 Mode:0 =
Active:0 Dest:0)
[    0.036666]  apic 0 pin 16 not connected
[    0.036666]  apic 0 pin 17 not connected
[    0.036666]  apic 0 pin 18 not connected
[    0.036666]  apic 0 pin 19 not connected
[    0.036666]  apic 0 pin 20 not connected
[    0.036666]  apic 0 pin 21 not connected
[    0.036666]  apic 0 pin 22 not connected
[    0.036666]  apic 0 pin 23 not connected
[    0.036666] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.036666] Using local APIC timer interrupts.
[    0.036666] calibrating APIC timer ...
[    0.039999] ... lapic delta =3D 6249836
[    0.039999] ... PM-Timer delta =3D 357946
[    0.039999] ... PM-Timer result ok
[    0.039999] ..... delta 6249836
[    0.039999] ..... mult: 268428439
[    0.039999] ..... calibration result: 3333245
[    0.039999] ..... CPU clock speed is 2926.1825 MHz.
[    0.039999] ..... host bus clock speed is 1000.0245 MHz.
[    0.040067] smpboot: CPU0: GenuineIntel Intel Core i7 9xx (Nehalem Class=
 Core i7) (family: 0x6, model: 0x1a, stepping: 0x3)
[    0.053399] Performance Events: no PMU driver, software events only.
[    0.060022] Hierarchical SRCU implementation.
[    0.076232] NMI watchdog: Perf event create on CPU 0 failed with -2
[    0.076674] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.090014] smp: Bringing up secondary CPUs ...
[    0.120705] x86: Booting SMP configuration:
[    0.121430] .... node  #0, CPUs:      #1
[    0.003333] kvm-clock: cpu 1, msr 0:1ffd7041, secondary cpu clock
[    0.003333] masked ExtINT on CPU#1
[    0.143395] KVM setup async PF for cpu 1
[    0.143395] kvm-stealtime: cpu 1, msr 1c80d500
[    0.144944] smp: Brought up 1 node, 2 CPUs
[    0.146695] smpboot: Total of 2 processors activated (11709.03 BogoMIPS)
[    0.154463] devtmpfs: initialized
[    0.161736] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.163355] futex hash table entries: 16 (order: -1, 2048 bytes)
[    0.164447] xor: measuring software checksum speed
[    0.196675]    prefetch64-sse: 11912.400 MB/sec
[    0.230009]    generic_sse: 10309.200 MB/sec
[    0.230658] xor: using function: prefetch64-sse (11912.400 MB/sec)
[    0.231691] prandom: seed boundary self test passed
[    0.233436] prandom: 100 self tests passed
[    0.234073] pinctrl core: initialized pinctrl subsystem
[    0.235890] regulator-dummy: Failed to create debugfs directory
[    0.236860] RTC time: 10:11:37, date: 11/14/17
[    0.239278] NET: Registered protocol family 16
[    0.242760] workqueue: round-robin CPU selection forced, expect performa=
nce impact
[    0.266888] ACPI: bus type PCI registered
[    0.267498] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.268893] dca service started, version 1.12.1
[    0.270175] PCI: Using configuration type 1 for base access
[    0.344099] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.403370] raid6: sse2x1   gen()  4299 MB/s
[    0.463385] raid6: sse2x1   xor()  2980 MB/s
[    0.520017] raid6: sse2x2   gen()  4862 MB/s
[    0.576677] raid6: sse2x2   xor()  1792 MB/s
[    0.633360] raid6: sse2x4   gen()  2334 MB/s
[    0.690015] raid6: sse2x4   xor()  1576 MB/s
[    0.691395] raid6: using algorithm sse2x2 gen() 4862 MB/s
[    0.693074] raid6: .... xor() 1792 MB/s, rmw enabled
[    0.693344] raid6: using ssse3x2 recovery algorithm
[    0.698159] ACPI: Added _OSI(Module Device)
[    0.698159] ACPI: Added _OSI(Processor Device)
[    0.698624] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.699309] ACPI: Added _OSI(Processor Aggregator Device)
[    0.708075] ACPI: Interpreter enabled
[    0.708741] ACPI: (supports S0 S4 S5)
[    0.709299] ACPI: Using IOAPIC for interrupt routing
[    0.710104] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.756558] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.756684] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.757635] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.758779] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    0.768708] acpiphp: Slot [3] registered
[    0.773492] acpiphp: Slot [4] registered
[    0.774168] acpiphp: Slot [5] registered
[    0.776771] acpiphp: Slot [6] registered
[    0.777475] acpiphp: Slot [7] registered
[    0.778209] acpiphp: Slot [8] registered
[    0.778953] acpiphp: Slot [9] registered
[    0.786775] acpiphp: Slot [10] registered
[    0.787390] acpiphp: Slot [11] registered
[    0.787516] acpiphp: Slot [12] registered
[    0.788258] acpiphp: Slot [13] registered
[    0.789025] acpiphp: Slot [14] registered
[    0.790104] acpiphp: Slot [15] registered
[    0.790845] acpiphp: Slot [16] registered
[    0.791523] acpiphp: Slot [17] registered
[    0.792228] acpiphp: Slot [18] registered
[    0.792946] acpiphp: Slot [19] registered
[    0.793450] acpiphp: Slot [20] registered
[    0.794168] acpiphp: Slot [21] registered
[    0.794858] acpiphp: Slot [22] registered
[    0.800144] acpiphp: Slot [23] registered
[    0.800874] acpiphp: Slot [24] registered
[    0.801594] acpiphp: Slot [25] registered
[    0.802343] acpiphp: Slot [26] registered
[    0.803449] acpiphp: Slot [27] registered
[    0.804206] acpiphp: Slot [28] registered
[    0.804936] acpiphp: Slot [29] registered
[    0.805645] acpiphp: Slot [30] registered
[    0.806774] acpiphp: Slot [31] registered
[    0.807475] PCI host bridge to bus 0000:00
[    0.809520] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.810018] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.813352] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.815567] pci_bus 0000:00: root bus resource [mem 0x20000000-0xfebffff=
f window]
[    0.816685] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.820171] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.825063] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.828981] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.849242] pci 0000:00:01.1: reg 0x20: [io  0xc0c0-0xc0cf]
[    0.856749] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]
[    0.863333] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.876681] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]
[    0.878677] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.881273] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.884416] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX=
4 ACPI
[    0.886700] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX=
4 SMB
[    0.901450] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.909562] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.923346] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.976694] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.986892] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.992177] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    1.009028] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    1.063348] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    1.073451] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
[    1.093351] pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
[    1.116683] pci 0000:00:04.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
[    1.166681] pci 0000:00:04.0: reg 0x20: [mem 0xfe000000-0xfe003fff 64bit=
 pref]
[    1.200727] pci 0000:00:05.0: [1af4:1001] type 00 class 0x010000
[    1.220014] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc0bf]
[    1.236681] pci 0000:00:05.0: reg 0x14: [mem 0xfebf2000-0xfebf2fff]
[    1.286684] pci 0000:00:05.0: reg 0x20: [mem 0xfe004000-0xfe007fff 64bit=
 pref]
[    1.308930] pci 0000:00:06.0: [8086:25ab] type 00 class 0x088000
[    1.324536] pci 0000:00:06.0: reg 0x10: [mem 0xfebf3000-0xfebf300f]
[    1.360575] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    1.362999] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    1.364072] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    1.367413] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    1.369457] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    1.379999] SCSI subsystem initialized
[    1.380314] libata version 3.00 loaded.
[    1.381606] ACPI: bus type USB registered
[    1.383176] usbcore: registered new interface driver usbfs
[    1.383333] usbcore: registered new interface driver hub
[    1.383464] usbcore: registered new device driver usb
[    1.385492] media: Linux media interface: v0.10
[    1.386666] Linux video capture interface: v2.00
[    1.386666] pps_core: LinuxPPS API ver. 1 registered
[    1.386666] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    1.393921] Unable to find dmi tokens
[    1.403333] FPGA manager framework
[    1.403333] PCI: Using ACPI for IRQ routing
[    1.403343] PCI: pci_cache_line_size set to 64 bytes
[    1.405245] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    1.406682] e820: reserve RAM buffer [mem 0x1ffdc000-0x1fffffff]
[    1.418802] HPET: 3 timers in total, 0 timers will be used for per-cpu t=
imer
[    1.420058] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.421452] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    1.428606] clocksource: Switched to clocksource kvm-clock
[    1.429993] FS-Cache: Loaded
[    1.430758] pnp: PnP ACPI init
[    1.432190] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.434732] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.437097] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    1.439202] pnp 00:03: [dma 2]
[    1.440256] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    1.442652] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    1.445070] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.448258] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.452045] pnp: PnP ACPI: found 7 devices
[    1.462390] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    1.465663] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.467677] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.469601] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    1.471861] pci_bus 0000:00: resource 7 [mem 0x20000000-0xfebfffff windo=
w]
[    1.474231] NET: Registered protocol family 1
[    1.475743] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    1.477669] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    1.480163] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    1.482063] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    1.484408] PCI: CLS 0 bytes, default 64
[    1.487745] Trying to unpack rootfs image as initramfs...
[    4.287782] Freeing initrd memory: 4880K
[    4.309559] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2a2=
e6a714ac, max_idle_ns: 440795306413 ns
[    4.318521] Scanning for low memory corruption every 60 seconds
[    4.338018] PCLMULQDQ-NI instructions are not detected.
[    4.339346] AVX or AES-NI instructions are not detected.
[    4.340330] CPU feature 'AVX registers' is not supported.
[    4.341458] CPU feature 'AVX registers' is not supported.
[    4.342432] CPU feature 'AVX registers' is not supported.
[    4.343376] AVX2 instructions are not detected.
[    4.360899] spin_lock-torture:--- Start of test [debug]: nwriters_stress=
=3D4 nreaders_stress=3D0 stat_interval=3D60 verbose=3D1 shuffle_interval=3D=
3 stutter=3D5 shutdown_secs=3D0 onoff_interval=3D0 onoff_holdoff=3D0
[    4.363913] spin_lock-torture: Creating torture_shuffle task
[    4.365176] spin_lock-torture: Creating torture_stutter task
[    4.365621] spin_lock-torture: torture_shuffle task started
[    4.367296] spin_lock-torture: Creating lock_torture_writer task
[    4.368527] spin_lock-torture: torture_stutter task started
[    4.369629] spin_lock-torture: Creating lock_torture_writer task
[    4.370605] spin_lock-torture: lock_torture_writer task started
[    4.381761] spin_lock-torture: Creating lock_torture_writer task
[    4.382874] spin_lock-torture: lock_torture_writer task started
[    4.384000] spin_lock-torture: Creating lock_torture_writer task
[    4.385924] spin_lock-torture: lock_torture_writer task started
[    4.387032] spin_lock-torture: Creating lock_torture_stats task
[    4.388238] spin_lock-torture: lock_torture_writer task started
[    4.389532] spin_lock-torture: lock_torture_stats task started
[   11.049667] torture_init_begin: Refusing rcu init: spin_lock running.
[   11.051623] torture_init_begin: One torture test at a time!
[   11.055266] Initialise system trusted keyrings
[   11.056469] Key type blacklist registered
[   11.071798] workingset: timestamp_bits=3D40 max_order=3D17 bucket_order=
=3D0
[   11.082712] zbud: loaded
[   11.085429] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   11.087553] ntfs: driver 2.1.32 [Flags: R/O DEBUG].
[   11.092533] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[   11.114131] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[   11.136912] qnx6: QNX6 filesystem 1.0.0 registered.
[   11.138870] fuse init (API version 7.26)
[   11.139809] SGI XFS with security attributes, no debug enabled
[   11.178915] gfs2: GFS2 installed
[   11.209501] async_tx: api initialized (async)
[   11.210275] Key type asymmetric registered
[   11.211130] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 248)
[   11.216050] io scheduler noop registered
[   11.216754] io scheduler deadline registered
[   11.217559] io scheduler cfq registered (default)
[   11.218346] io scheduler mq-deadline registered
[   11.219150] io scheduler kyber registered
[   11.219949] io scheduler bfq registered
[   11.225291] test_string_helpers: Running tests...
[   11.252708] test_hexdump: all 1184 tests passed
[   11.253919] test_firmware: interface ready
[   11.270453] test_hash: __hash_32() has no arch implementation to test.
[   11.282654] test_hash: hash_32() has no arch implementation to test.
[   11.283645] test_hash: hash_64() has no arch implementation to test.
[   11.284594] test_hash: 33152 tests passed.
[   11.285225] test_siphash: self-tests: pass
[   11.508419] test_bitmap: test 13: input is '0-2047:128/256' OK, Time: 12=
59
[   11.515551] test_bitmap: all 460506 tests passed
[   11.516272] test_uuid: all 18 tests passed
[   11.517689] crc32: CRC_LE_BITS =3D 64, CRC_BE BITS =3D 64
[   11.518509] crc32: self tests passed, processed 225944 bytes in 188378 n=
sec
[   11.519904] crc32c: CRC_LE_BITS =3D 64
[   11.520542] crc32c: self tests passed, processed 225944 bytes in 92058 n=
sec
[   11.541588] crc32_combine: 8373 self tests passed
[   11.562655] crc32c_combine: 8373 self tests passed
[   11.563888] xz_dec_test: module loaded
[   11.564549] xz_dec_test: Create a device node with 'mknod xz_dec_test c =
247 0' and write .xz files to it.
[   11.566825] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[   11.568338] rbtree testing
[   12.826281]  -> test 1 (latency of nnodes insert+delete): 36811 cycles
[   14.518553]  -> test 2 (latency of nnodes cached insert+delete): 49475 c=
ycles
[   14.723453]  -> test 3 (latency of inorder traversal): 5897 cycles
[   14.725972]  -> test 4 (latency to fetch first node)
[   14.726845]         non-cached: 42 cycles
[   14.727495]         cached: 0 cycles
[   14.818351] augmented rbtree testing
[   16.551871]  -> test 1 (latency of nnodes insert+delete): 50728 cycles
[   18.620614]  -> test 2 (latency of nnodes cached insert+delete): 60458 c=
ycles
[   18.747084] gpio_it87: no device
[   18.748123] gpio-mockup: probe of gpio-mockup failed with error -22
[   18.755175] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
[   18.763552] ipmi message handler version 39.2
[   18.764310] IPMI System Interface driver.
[   18.765258] ipmi_si: Unable to find any System Interface(s)
[   18.766170] IPMI SSIF Interface driver
[   18.766928] IPMI Watchdog: driver initialized
[   18.776006] ioatdma: Intel(R) QuickData Technology Driver 4.00
[   18.904876] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[   18.963714] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[   18.966184] console [ttyS0] disabled
[   19.014797] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[   19.659729] console [ttyS0] enabled
[   19.693898] 00:06: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) =
is a 16550A
[   19.734621] 00:06: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) =
is a 16550A
[   19.762671] Non-volatile memory driver v1.3
[   19.854170] brd: module loaded
[   19.890188] loop: module loaded
[   19.892172] MM: desc_per_page =3D 128
[   19.910807] mtip32xx Version 1.3.1
[   19.923397] null: module loaded
[   19.925308] ibmasm: IBM ASM Service Processor Driver version 1.0 loaded
[   19.933413] dummy-irq: no IRQ given.  Use irq=3DN
[   19.934881] lkdtm: No crash points registered, enable through debugfs
[   19.937651] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Gi=
ometti
[   19.940266] c2port c2port0: C2 port uc added
[   19.953396] c2port c2port0: uc flash has 30 blocks x 512 bytes (15360 by=
tes total)
[   19.956644] Guest personality initialized and is inactive
[   19.958975] VMCI host device registered (name=3Dvmci, major=3D10, minor=
=3D61)
[   19.968490] Initialized host personality
[   19.970869] usbcore: registered new interface driver rtsx_usb
[   19.975434] usbcore: registered new interface driver viperboard
[   19.977657] usbcore: registered new interface driver dln2
[   19.980172] hp_sw: device handler registered
[   19.981527] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[   19.983795] SCSI Media Changer driver v0.25=20
[   20.009883] ata_piix 0000:00:01.1: version 2.13
[   20.039838] scsi host0: ata_piix
[   20.053714] scsi host1: ata_piix
[   20.055022] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0c0 irq 14
[   20.057810] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0c8 irq 15
[   20.219346] ata2.01: NODEV after polling detection
[   20.222140] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[   20.232461] ata2.00: configured for MWDMA2
[   20.235209] ata2.00: disabled
[   20.247746] BUG: unable to handle kernel NULL pointer dereference at 000=
0000000000350
[   20.250638] IP: ata_port_wait_eh+0xa1/0xe5
[   20.251018] PGD 0 P4D 0=20
[   20.251018] Oops: 0000 [#1] PREEMPT SMP
[   20.255428] CPU: 1 PID: 5 Comm: kworker/u4:0 Not tainted 4.14.0-00902-g4=
3ff2f4 #1
[   20.255428] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1 04/01/2014
[   20.263368] scsi host0: ata_piix
[   20.267396] Workqueue: events_unbound async_run_entry_fn
[   20.270725] scsi host1: ata_piix
[   20.271036] ata3: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0c0 irq 14
[   20.271039] ata4: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0c8 irq 15
[   20.283654] Rounding down aligned max_sectors from 4294967295 to 4294967=
288
[   20.298430] task: ffff8800001e6140 task.stack: ffff8800001e8000
[   20.298430] RIP: 0010:ata_port_wait_eh+0xa1/0xe5
[   20.298430] RSP: 0000:ffff8800001ebdc0 EFLAGS: 00010286
[   20.304162] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[   20.304484] platform physmap-flash.0: failed to claim resource 0: [mem 0=
x08000000-0x07ffffff]
[   20.305254] slram: not enough parameters.
[   20.305257] Ramix PMC551 PCI Mezzanine Ram Driver. (C) 1999,2000 Nortel =
Networks.
[   20.305263] pmc551: not detected
[   20.327390] RAX: ffffffffffffffff RBX: ffff8800198a8000 RCX: ffff88001c8=
0d8c0
[   20.327390] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000000=
00246
[   20.327390] RBP: 0000000000000246 R08: 0000000845a00e34 R09: 00000000000=
00000
[   20.337395] R10: ffffffff95122ad0 R11: 0000000000000105 R12: ffff8800198=
ac008
[   20.337395] R13: ffff880000081000 R14: 0000000000000000 R15: 00000000000=
00000
[   20.347394] FS:  0000000000000000(0000) GS:ffff88001c800000(0000) knlGS:=
0000000000000000
[   20.347394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.357398] CR2: 0000000000000350 CR3: 000000001dc69000 CR4: 00000000000=
006a0
[   20.357398] Call Trace:
[   20.357398]  ? __list_del_entry+0x1d/0x1d
[   20.357398]  ata_port_probe+0x24/0x28
[   20.367393]  async_port_probe+0x2b/0x42
[   20.367393]  async_run_entry_fn+0x35/0x105
[   20.367393]  process_one_work+0x1c9/0x310
[   20.377388]  ? process_one_work+0x15c/0x310
[   20.387386]  worker_thread+0x1aa/0x25d
[   20.397397]  ? process_scheduled_works+0x27/0x27
[   20.397397]  kthread+0xf1/0xf9
[   20.407398]  ? __list_del_entry+0x1d/0x1d
[   20.407398]  ret_from_fork+0x1f/0x30
[   20.407398] Code: 7b 10 48 89 ee e8 ed f3 41 00 e8 55 be 41 00 eb cb 48 =
89 e6 4c 89 e7 e8 6e d2 9a ff 48 8b 7b 10 48 89 ee e8 cf f3 41 00 48 8b 13 =
<8b> 82 50 03 00 00 83 e8 05 83 f8 02 76 09 f6 82 00 03 00 00 40=20
[   20.437384] RIP: ata_port_wait_eh+0xa1/0xe5 RSP: ffff8800001ebdc0
[   20.447382] CR2: 0000000000000350
[   20.447382] ---[ end trace 28c525956cf088e8 ]---
[   20.447382] Kernel panic - not syncing: Fatal exception
[   20.447382] Kernel Offset: 0x13a00000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)

Elapsed time: 30

#!/bin/bash

# To reproduce,
# 1) save job-script and this script (both are attached in 0day report emai=
l)
# 2) run this script with your compiled kernel and optional env $INSTALL_MO=
D_PATH

kernel=3D$1

initrds=3D(
	/osimage/yocto/yocto-minimal-x86_64-2016-04-22.cgz
	/lkp/lkp/lkp-x86_64.cgz
)

HTTP_PREFIX=3Dhttps://github.com/0day-ci/lkp-qemu/raw/master
wget --timestamping "${initrds[@]/#/$HTTP_PREFIX}"

{
	cat "${initrds[@]//*\//}"
	[[ $INSTALL_MOD_PATH ]] && (
		cd "$INSTALL_MOD_PATH"
		find lib | cpio -o -H newc --quiet | gzip
	)
	echo  job-script | cpio -o -H newc --quiet | gzip
} > initrd.img

qemu-img create -f qcow2 disk-vm-intel12-yocto-x86_64-4-0 256G
qemu-img create -f qcow2 disk-vm-intel12-yocto-x86_64-4-1 256G

kvm=3D(
	qemu-system-x86_64
	-enable-kvm
	-cpu Nehalem
	-kernel $kernel
	-initrd initrd.img
	-m 512
	-smp 2
	-device e1000,netdev=3Dnet0
	-netdev user,id=3Dnet0
	-boot order=3Dnc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=3Dlocaltime
	-drive file=3Ddisk-vm-intel12-yocto-x86_64-4-0,media=3Ddisk,if=3Dvirtio
	-drive file=3Ddisk-vm-intel12-yocto-x86_64-4-1,media=3Ddisk,if=3Dvirtio
	-serial stdio
	-display none
	-monitor null
)

append=3D(
	ip=3D::::vm-intel12-yocto-x86_64-4::dhcp
	root=3D/dev/ram0
	user=3Dlkp
	job=3D/job-script
	ARCH=3Dx86_64
	kconfig=3Dx86_64-randconfig-s3-11131952
	branch=3Dlinus/master
	commit=3D43ff2f4db9d0f76452b77cfa645f02b471143b24
	BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-s3-11131952/gcc-6/43ff2f4db9d0f7=
6452b77cfa645f02b471143b24/vmlinuz-4.14.0-00902-g43ff2f4
	max_uptime=3D600
	RESULT_ROOT=3D/result/boot/1/vm-intel12-yocto-x86_64/yocto-minimal-x86_64-=
2016-04-22.cgz/x86_64-randconfig-s3-11131952/gcc-6/43ff2f4db9d0f76452b77cfa=
645f02b471143b24/29
	result_service=3Dtmpfs
	debug
	apic=3Ddebug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=3D100
	net.ifnames=3D0
	printk.devkmsg=3Don
	panic=3D-1
	softlockup_panic=3D1
	nmi_watchdog=3Dpanic
	oops=3Dpanic
	load_ramdisk=3D2
	prompt_ramdisk=3D0
	drbd.minor_count=3D8
	systemd.log_level=3Derr
	ignore_loglevel
	console=3Dtty0
	earlyprintk=3DttyS0,115200
	console=3DttyS0,115200
	vga=3Dnormal
	rw
	drbd.minor_count=3D8
)

"${kvm[@]}" -append "${append[*]}"

--lxfz4orbnubblw2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.14.0 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_FHANDLE=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_DELAY=500
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
# CONFIG_MEMCG_SWAP_ENABLED is not set
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_SOCK_CGROUP_DATA is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_POSIX_TIMERS=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_USERFAULTFD is not set
CONFIG_PCI_QUIRKS=y
CONFIG_MEMBARRIER=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
CONFIG_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
CONFIG_CC_STACKPROTECTOR_STRONG=y
CONFIG_THIN_ARCHIVES=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
# CONFIG_HAVE_ARCH_HASH is not set
# CONFIG_ISA_BUS_API is not set
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_CMDLINE_PARSER=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
CONFIG_ACORN_PARTITION_EESOX=y
CONFIG_ACORN_PARTITION_ICS=y
CONFIG_ACORN_PARTITION_ADFS=y
CONFIG_ACORN_PARTITION_POWERTEC=y
CONFIG_ACORN_PARTITION_RISCIX=y
CONFIG_AIX_PARTITION=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CFQ_GROUP_IOSCHED is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_FREEZER=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_DOM0=y
# CONFIG_XEN_PVHVM is not set
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_CALGARY_IOMMU=y
CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT=y
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS=64
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
# CONFIG_VM86 is not set
# CONFIG_X86_16BIT is not set
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
# CONFIG_SCHED_HRTICK is not set
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_RANDOMIZE_MEMORY is not set
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_LEGACY_VSYSCALL_NATIVE is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_DPM_WATCHDOG=y
CONFIG_DPM_WATCHDOG_TIMEOUT=120
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_OPP=y
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
# CONFIG_ACPI_PROCESSOR is not set
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
CONFIG_ACPI_REDUCED_HARDWARE_ONLY=y
CONFIG_ACPI_NFIT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
# CONFIG_ACPI_APEI_PCIEAER is not set
# CONFIG_ACPI_APEI_EINJ is not set
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
CONFIG_DPTF_POWER=y
CONFIG_ACPI_WATCHDOG=y
CONFIG_PMIC_OPREGION=y
# CONFIG_CRC_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
# CONFIG_X86_INTEL_PSTATE is not set
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_CNB20LE_QUIRK=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIE_ECRC=y
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_XEN_PCIDEV_FRONTEND=y
CONFIG_HT_IRQ=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=y
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y

#
# PCI host controller drivers
#
CONFIG_VMD=y

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
# CONFIG_ISA_DMA_API is not set
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
# CONFIG_RAPIDIO_TSI721 is not set
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DMA_ENGINE=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=y
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_TSI568=y
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=y
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# CONFIG_IA32_EMULATION is not set
CONFIG_X86_X32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_NET_KEY is not set
# CONFIG_INET is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
# CONFIG_DST_CACHE is not set
# CONFIG_GRO_CELLS is not set
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_HWSPINLOCK=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_AR7_PARTS=y

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
CONFIG_FTL=y
CONFIG_NFTL=y
CONFIG_NFTL_RW=y
CONFIG_INFTL=y
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
# CONFIG_MTD_SWAP is not set
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_CFI_INTELEXT is not set
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_PCI=y
CONFIG_MTD_GPIO_ADDR=y
CONFIG_MTD_INTEL_VR_NOR=y
CONFIG_MTD_PLATRAM=y
CONFIG_MTD_LATCH_ADDR=y

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
CONFIG_MTD_PMC551_BUGFIX=y
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SMC=y
# CONFIG_MTD_NAND is not set
CONFIG_MTD_ONENAND=y
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
CONFIG_MTD_ONENAND_GENERIC=y
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
CONFIG_MTD_SPI_NOR=y
CONFIG_MTD_MT81xx_NOR=y
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=y
CONFIG_SPI_INTEL_SPI_PCI=y
CONFIG_SPI_INTEL_SPI_PLATFORM=y
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
CONFIG_MTD_UBI_BLOCK=y
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_ADDRESS_PCI=y
CONFIG_OF_IRQ=y
CONFIG_OF_PCI=y
CONFIG_OF_PCI_IRQ=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_UMEM=y
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=y

#
# DRBD disabled because PROC_FS or INET not selected
#
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_XEN_BLKDEV_FRONTEND is not set
# CONFIG_XEN_BLKDEV_BACKEND is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
CONFIG_BLK_DEV_RSXX=y
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_LOOP=y
CONFIG_NVME_TARGET_FC=y
CONFIG_NVME_TARGET_FCLOOP=y

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_VMWARE_BALLOON is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_SRAM is not set
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=y

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=y
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
# CONFIG_SCSI_DH_RDAC is not set
CONFIG_SCSI_DH_HP_SW=y
# CONFIG_SCSI_DH_EMC is not set
# CONFIG_SCSI_DH_ALUA is not set
CONFIG_SCSI_OSD_INITIATOR=y
# CONFIG_SCSI_OSD_ULD is not set
CONFIG_SCSI_OSD_DPRINT_SENSE=1
CONFIG_SCSI_OSD_DEBUG=y
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_AHCI_CEVA is not set
# CONFIG_AHCI_QORIQ is not set
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=y
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=y
# CONFIG_SATA_QSTOR is not set
CONFIG_SATA_SX4=y
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
CONFIG_SATA_DWC=y
CONFIG_SATA_DWC_OLD_DMA=y
# CONFIG_SATA_DWC_DEBUG is not set
CONFIG_SATA_MV=y
CONFIG_SATA_NV=y
CONFIG_SATA_PROMISE=y
# CONFIG_SATA_SIL is not set
CONFIG_SATA_SIS=y
CONFIG_SATA_SVW=y
CONFIG_SATA_ULI=y
CONFIG_SATA_VIA=y
CONFIG_SATA_VITESSE=y

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=y
CONFIG_PATA_AMD=y
CONFIG_PATA_ARTOP=y
# CONFIG_PATA_ATIIXP is not set
CONFIG_PATA_ATP867X=y
CONFIG_PATA_CMD64X=y
# CONFIG_PATA_CYPRESS is not set
CONFIG_PATA_EFAR=y
CONFIG_PATA_HPT366=y
CONFIG_PATA_HPT37X=y
# CONFIG_PATA_HPT3X2N is not set
CONFIG_PATA_HPT3X3=y
CONFIG_PATA_HPT3X3_DMA=y
CONFIG_PATA_IT8213=y
# CONFIG_PATA_IT821X is not set
CONFIG_PATA_JMICRON=y
CONFIG_PATA_MARVELL=y
# CONFIG_PATA_NETCELL is not set
CONFIG_PATA_NINJA32=y
CONFIG_PATA_NS87415=y
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=y
CONFIG_PATA_PDC_OLD=y
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=y
CONFIG_PATA_SCH=y
CONFIG_PATA_SERVERWORKS=y
# CONFIG_PATA_SIL680 is not set
CONFIG_PATA_SIS=y
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
CONFIG_PATA_WINBOND=y

#
# PIO-only SFF controllers
#
CONFIG_PATA_CMD640_PCI=y
CONFIG_PATA_MPIIX=y
CONFIG_PATA_NS87410=y
CONFIG_PATA_OPTI=y
CONFIG_PATA_PLATFORM=y
# CONFIG_PATA_OF_PLATFORM is not set
CONFIG_PATA_RZ1000=y

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
# CONFIG_ATA_GENERIC is not set
CONFIG_PATA_LEGACY=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_AUTODETECT is not set
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=y
CONFIG_BCACHE=y
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BLK_DEV_DM is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=y
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=y
# CONFIG_MACINTOSH_DRIVERS is not set
# CONFIG_NETDEVICES is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
CONFIG_TABLET_USB_AIPTEK=y
CONFIG_TABLET_USB_GTCO=y
CONFIG_TABLET_USB_HANWANG=y
CONFIG_TABLET_USB_KBTAB=y
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_88PM860X is not set
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP_I2C is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
# CONFIG_TOUCHSCREEN_DA9052 is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_ILI210X=y
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
CONFIG_TOUCHSCREEN_MAX11801=y
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=y
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_WM831X is not set
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
CONFIG_TOUCHSCREEN_MC13783=y
CONFIG_TOUCHSCREEN_USB_EGALAX=y
# CONFIG_TOUCHSCREEN_USB_PANJIT is not set
CONFIG_TOUCHSCREEN_USB_3M=y
# CONFIG_TOUCHSCREEN_USB_ITM is not set
CONFIG_TOUCHSCREEN_USB_ETURBO=y
# CONFIG_TOUCHSCREEN_USB_GUNZE is not set
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
# CONFIG_TOUCHSCREEN_USB_IDEALTEK is not set
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
# CONFIG_TOUCHSCREEN_USB_GOTOP is not set
# CONFIG_TOUCHSCREEN_USB_JASTEC is not set
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
# CONFIG_TOUCHSCREEN_USB_ZYTRONIC is not set
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
# CONFIG_TOUCHSCREEN_USB_EASYTOUCH is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
# CONFIG_TOUCHSCREEN_TSC2007 is not set
CONFIG_TOUCHSCREEN_RM_TS=y
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
CONFIG_TOUCHSCREEN_STMFTS=y
# CONFIG_TOUCHSCREEN_SX8654 is not set
CONFIG_TOUCHSCREEN_TPS6507X=y
CONFIG_TOUCHSCREEN_ZET6223=y
# CONFIG_TOUCHSCREEN_ZFORCE is not set
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
# CONFIG_IPMI_POWEROFF is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD756_S4882=y
CONFIG_I2C_AMD8111=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_KEMPLD=y
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_RK3X=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_DLN2 is not set
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PINCTRL=y

#
# Pin controllers
#
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_RK805 is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_GEMINILAKE=y
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH=y
# CONFIG_GPIO_SCH311X is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_SX150X=y
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_CRYSTAL_COVE=y
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_DLN2=y
# CONFIG_GPIO_JANZ_TTL is not set
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP87565=y
# CONFIG_GPIO_TC3589X is not set
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TPS68470 is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
# CONFIG_GPIO_BT8XX is not set
CONFIG_GPIO_ML_IOH=y
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_RDC321X=y
CONFIG_GPIO_SODAVILLE=y

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_GPIO is not set
CONFIG_POWER_RESET_GPIO_RESTART=y
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_RESTART=y
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_PDA_POWER is not set
CONFIG_MAX8925_POWER=y
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
CONFIG_TEST_POWER=y
# CONFIG_BATTERY_88PM860X is not set
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
# CONFIG_CHARGER_MAX8998 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=y
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_I5500=y
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_TPS40422=y
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=y
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_ZL6100=y
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_XGENE=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_OF is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
CONFIG_DA9062_THERMAL=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=y
CONFIG_ACPI_THERMAL_REL=y
# CONFIG_INT3406_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
CONFIG_DA9052_WATCHDOG=y
# CONFIG_DA9055_WATCHDOG is not set
# CONFIG_DA9063_WATCHDOG is not set
CONFIG_DA9062_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=y
CONFIG_WDAT_WDT=y
CONFIG_WM831X_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
# CONFIG_RN5T618_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=y
# CONFIG_RETU_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
CONFIG_ALIM7101_WDT=y
CONFIG_F71808E_WDT=y
CONFIG_SP5100_TCO=y
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=y
CONFIG_KEMPLD_WDT=y
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
CONFIG_PC87413_WDT=y
CONFIG_NV_TCO=y
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=y
CONFIG_NI903X_WDT=y
CONFIG_NIC7018_WDT=y
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
CONFIG_WDTPCI=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_I2C=y
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
# CONFIG_LPC_ICH is not set
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
# CONFIG_INTEL_SOC_PMIC_BXTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RTSX_PCI=y
CONFIG_MFD_RT5033=y
CONFIG_MFD_RTSX_USB=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TPS68470=y
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TI_LP87565=y
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PM8607=y
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AB3100=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9062=y
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421 is not set
CONFIG_REGULATOR_HI6421V530=y
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8907 is not set
# CONFIG_REGULATOR_MAX8925 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6397=y
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_SPMI=y
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_RN5T618=y
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS80031=y
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8994=y
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_DVB_CORE=y
# CONFIG_TTPCI_EEPROM is not set
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_DVB_PLATFORM_DRIVERS=y
# CONFIG_CEC_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
# CONFIG_CYPRESS_FIRMWARE is not set
CONFIG_SMS_SIANO_MDTV=y
CONFIG_SMS_SIANO_RC=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
# CONFIG_VIDEO_IR_I2C is not set

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
CONFIG_VIDEO_TEA6415C=y
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=y
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_TLV320AIC23B=y
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=y
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_SONY_BTF_MPX=y

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set

#
# Video decoders
#
CONFIG_VIDEO_ADV7183=y
# CONFIG_VIDEO_BT819 is not set
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=y
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_ML86V7667=y
CONFIG_VIDEO_AD5820=y
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
# CONFIG_VIDEO_TW9903 is not set
CONFIG_VIDEO_TW9906=y
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
CONFIG_VIDEO_THS8200=y

#
# Camera sensor devices
#
CONFIG_VIDEO_MT9M111=y

#
# Flash devices
#

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=y
# CONFIG_VIDEO_M52790 is not set

#
# Sensors used on soc_camera driver
#

#
# SPI helper chips
#
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_SIMPLE is not set
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MT2131=y
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_XC2028=y
# CONFIG_MEDIA_TUNER_XC5000 is not set
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
# CONFIG_MEDIA_TUNER_MC44S803 is not set
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
# CONFIG_MEDIA_TUNER_TUA9001 is not set
# CONFIG_MEDIA_TUNER_SI2157 is not set
# CONFIG_MEDIA_TUNER_IT913X is not set
CONFIG_MEDIA_TUNER_R820T=y
# CONFIG_MEDIA_TUNER_MXL301RF is not set
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_STB0899 is not set
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
# CONFIG_DVB_STV0910 is not set
# CONFIG_DVB_STV6110x is not set
CONFIG_DVB_STV6111=y
# CONFIG_DVB_MXL5XX is not set

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_TDA18271C2DD=y
CONFIG_DVB_SI2165=y
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
CONFIG_DVB_CX24123=y
# CONFIG_DVB_MT312 is not set
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=y
# CONFIG_DVB_S5H1420 is not set
CONFIG_DVB_STV0288=y
# CONFIG_DVB_STB6000 is not set
# CONFIG_DVB_STV0299 is not set
CONFIG_DVB_STV6110=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_TDA8083=y
CONFIG_DVB_TDA10086=y
CONFIG_DVB_TDA8261=y
CONFIG_DVB_VES1X93=y
# CONFIG_DVB_TUNER_ITD1000 is not set
# CONFIG_DVB_TUNER_CX24113 is not set
CONFIG_DVB_TDA826X=y
CONFIG_DVB_TUA6100=y
CONFIG_DVB_CX24116=y
# CONFIG_DVB_CX24117 is not set
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_SI21XX=y
# CONFIG_DVB_TS2020 is not set
# CONFIG_DVB_DS3000 is not set
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_TDA10071=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=y
# CONFIG_DVB_SP887X is not set
CONFIG_DVB_CX22700=y
CONFIG_DVB_CX22702=y
CONFIG_DVB_S5H1432=y
CONFIG_DVB_DRXD=y
CONFIG_DVB_L64781=y
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_MT352=y
CONFIG_DVB_ZL10353=y
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
# CONFIG_DVB_DIB7000M is not set
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
CONFIG_DVB_TDA10048=y
CONFIG_DVB_AF9013=y
CONFIG_DVB_EC100=y
# CONFIG_DVB_STV0367 is not set
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_CXD2841ER=y
# CONFIG_DVB_AS102_FE is not set
CONFIG_DVB_ZD1301_DEMOD=y
# CONFIG_DVB_GP8PSK_FE is not set

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_VES1820 is not set
CONFIG_DVB_TDA10021=y
CONFIG_DVB_TDA10023=y
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_NXT200X is not set
CONFIG_DVB_OR51211=y
# CONFIG_DVB_OR51132 is not set
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LGDT330X=y
# CONFIG_DVB_LGDT3305 is not set
CONFIG_DVB_LG2160=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_AU8522_V4L=y
# CONFIG_DVB_S5H1411 is not set

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
CONFIG_DVB_DIB8000=y
# CONFIG_DVB_MB86A20S is not set

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_TC90522 is not set

#
# Digital terrestrial only tuners/PLL
#
# CONFIG_DVB_PLL is not set
CONFIG_DVB_TUNER_DIB0070=y
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
# CONFIG_DVB_LNBH25 is not set
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
CONFIG_DVB_ISL6405=y
# CONFIG_DVB_ISL6421 is not set
# CONFIG_DVB_ISL6423 is not set
CONFIG_DVB_A8293=y
# CONFIG_DVB_SP2 is not set
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
CONFIG_DVB_ATBM8830=y
CONFIG_DVB_TDA665x=y
CONFIG_DVB_IX2505V=y
# CONFIG_DVB_M88RS2000 is not set
CONFIG_DVB_AF9033=y
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ASCOT2E=y
CONFIG_DVB_HELENE=y

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y

#
# Graphics support
#
# CONFIG_AGP is not set
# CONFIG_VGA_ARB is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
# CONFIG_FB is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA9052=y
CONFIG_BACKLIGHT_MAX8925=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_88PM860X=y
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_LP8788=y
# CONFIG_BACKLIGHT_SKY81452 is not set
# CONFIG_BACKLIGHT_AS3711 is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_VGASTATE is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACCUTOUCH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_BETOP_FF=y
CONFIG_HID_CHERRY=y
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=y
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
CONFIG_HID_ELO=y
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
CONFIG_HID_HOLTEK=y
CONFIG_HOLTEK_FF=y
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
CONFIG_HID_PICOLCD_LCD=y
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_RETRODE=y
CONFIG_HID_ROCCAT=y
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=y
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WACOM=y
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
# CONFIG_I2C_HID is not set

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_OTG_BLACKLIST_HUB=y
# CONFIG_USB_OTG_FSM is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
# CONFIG_USB_MON is not set
CONFIG_USB_WUSB_CBAF=y
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_FOTG210_HCD=y
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_R8A66597_HCD=y
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
# CONFIG_USB_DWC3_OF_SIMPLE is not set
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PCI=y
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_OF=y
CONFIG_USB_CHIPIDEA_PCI=y
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
CONFIG_USB_RIO500=y
CONFIG_USB_LEGOTOWER=y
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=y
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=y
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=y
CONFIG_TAHVO_USB=y
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_GADGET is not set

#
# USB Power Delivery and Type-C drivers
#
# CONFIG_TYPEC_UCSI is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y
# CONFIG_MMC_BLOCK is not set
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PCI=y
# CONFIG_MMC_RICOH_MMC is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_ARASAN=y
CONFIG_MMC_SDHCI_OF_AT91=y
CONFIG_MMC_SDHCI_CADENCE=y
CONFIG_MMC_SDHCI_F_SDH30=y
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_CB710=y
CONFIG_MMC_VIA_SDMMC=y
CONFIG_MMC_VUB300=y
CONFIG_MMC_USHC=y
CONFIG_MMC_USDHI6ROL0=y
# CONFIG_MMC_REALTEK_PCI is not set
# CONFIG_MMC_REALTEK_USB is not set
CONFIG_MMC_TOSHIBA_PCI=y
CONFIG_MMC_MTK=y
CONFIG_MMC_SDHCI_XENON=y
# CONFIG_MMC_SDHCI_OMAP is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_CLEVO_MAIL=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_USER=y
CONFIG_LEDS_NIC78BX=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_ACCESSIBILITY=y
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=y
CONFIG_INTEL_IOATDMA=y
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_DCA=y
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
CONFIG_XEN_SCRUB_PAGES=y
CONFIG_XEN_DEV_EVTCHN=y
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=y
# CONFIG_XEN_COMPAT_XENFS is not set
# CONFIG_XEN_SYS_HYPERVISOR is not set
CONFIG_XEN_XENBUS_FRONTEND=y
CONFIG_XEN_GNTDEV=y
CONFIG_XEN_GRANT_DEV_ALLOC=y
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_PCIDEV_BACKEND=y
# CONFIG_XEN_SCSI_BACKEND is not set
CONFIG_XEN_PRIVCMD=y
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=y
# CONFIG_ACERHDF is not set
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=y
CONFIG_DELL_SMBIOS=y
CONFIG_DELL_LAPTOP=y
CONFIG_DELL_WMI=y
CONFIG_DELL_WMI_AIO=y
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=y
CONFIG_FUJITSU_LAPTOP=y
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=y
CONFIG_PANASONIC_LAPTOP=y
CONFIG_THINKPAD_ACPI=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
CONFIG_THINKPAD_ACPI_DEBUG=y
CONFIG_THINKPAD_ACPI_UNSAFE_LEDS=y
CONFIG_THINKPAD_ACPI_VIDEO=y
# CONFIG_THINKPAD_ACPI_HOTKEY_POLL is not set
# CONFIG_SENSORS_HDAPS is not set
CONFIG_EEEPC_LAPTOP=y
CONFIG_ASUS_WMI=y
# CONFIG_ASUS_NB_WMI is not set
CONFIG_EEEPC_WMI=y
CONFIG_ASUS_WIRELESS=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
# CONFIG_MSI_WMI is not set
CONFIG_PEAQ_WMI=y
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_TOSHIBA_BT_RFKILL=y
# CONFIG_TOSHIBA_HAPS is not set
CONFIG_TOSHIBA_WMI=y
CONFIG_ACPI_CMPC=y
CONFIG_INTEL_CHT_INT33FE=y
CONFIG_INTEL_INT0002_VGPIO=y
CONFIG_INTEL_HID_EVENT=y
CONFIG_INTEL_VBTN=y
CONFIG_INTEL_IPS=y
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_MXM_WMI is not set
CONFIG_SAMSUNG_Q10=y
CONFIG_APPLE_GMUX=y
CONFIG_INTEL_RST=y
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_PVPANIC=y
CONFIG_INTEL_PMC_IPC=y
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_INTEL_TELEMETRY=y
CONFIG_MLX_PLATFORM=y
# CONFIG_MLX_CPLD_PLATFORM is not set
CONFIG_SILEAD_DMI=y
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CROS_EC_CHARDEV is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
CONFIG_CLK_HSDK=y
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_RK808=y
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_NXP is not set
CONFIG_COMMON_CLK_PWM=y
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
CONFIG_COMMON_CLK_VC5=y
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
CONFIG_MAILBOX_TEST=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
CONFIG_SOC_TI=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_CROS_EC=y
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=y
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=y
# CONFIG_NTB_PERF is not set
CONFIG_NTB_TRANSPORT=y
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_ATMEL_HLCDC_PWM=y
# CONFIG_PWM_CRC is not set
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPSS=y
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=y
# CONFIG_PWM_PCA9685 is not set
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_IMX7 is not set
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STM32 is not set
# CONFIG_RESET_SUNXI is not set
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
CONFIG_FMC_TRIVIAL=y
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_SAMSUNG_USB2=y
# CONFIG_PHY_EXYNOS4210_USB2 is not set
# CONFIG_PHY_EXYNOS4X12_USB2 is not set
# CONFIG_PHY_EXYNOS5250_USB2 is not set
# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
CONFIG_RAS=y
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
CONFIG_LIBNVDIMM=y
# CONFIG_BLK_DEV_PMEM is not set
# CONFIG_ND_BLK is not set
CONFIG_ND_CLAIM=y
CONFIG_BTT=y
# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_STM=y
# CONFIG_STM_DUMMY is not set
# CONFIG_STM_SOURCE_CONSOLE is not set
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
CONFIG_FPGA_REGION=y
CONFIG_FPGA_MGR_ALTERA_CVP=y
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
# CONFIG_XILINX_PR_DECOUPLER is not set

#
# FSI support
#
# CONFIG_FSI is not set

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_COREBOOT_TABLE_ACPI=y
# CONFIG_GOOGLE_COREBOOT_TABLE_OF is not set
CONFIG_GOOGLE_MEMCONSOLE=y
CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=y
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=y
# CONFIG_GOOGLE_VPD is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
# CONFIG_EFI_VARS_PSTORE is not set
CONFIG_EFI_FAKE_MEMMAP=y
CONFIG_EFI_MAX_FAKE_MEM=8
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_TEST=y
CONFIG_UEFI_CPER=y
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
# CONFIG_F2FS_FS_XATTR is not set
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_INDEX=y

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
# CONFIG_CACHEFILES is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=y
# CONFIG_ECRYPT_FS is not set
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=y
# CONFIG_HFSPLUS_FS_POSIX_ACL is not set
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
CONFIG_JFFS2_SUMMARY=y
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y
CONFIG_JFFS2_FS_SECURITY=y
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_LZO=y
# CONFIG_JFFS2_RTIME is not set
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
CONFIG_JFFS2_CMODE_PRIORITY=y
# CONFIG_JFFS2_CMODE_SIZE is not set
# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
# CONFIG_UBIFS_FS_LZO is not set
# CONFIG_UBIFS_FS_ZLIB is not set
CONFIG_UBIFS_ATIME_SUPPORT=y
CONFIG_UBIFS_FS_ENCRYPTION=y
CONFIG_UBIFS_FS_SECURITY=y
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
CONFIG_SQUASHFS_DECOMP_MULTI=y
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
# CONFIG_OMFS_FS is not set
CONFIG_HPFS_FS=y
# CONFIG_QNX4FS_FS is not set
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
# CONFIG_ROMFS_BACKED_BY_BLOCK is not set
# CONFIG_ROMFS_BACKED_BY_MTD is not set
CONFIG_ROMFS_BACKED_BY_BOTH=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_ROMFS_ON_MTD=y
CONFIG_PSTORE=y
# CONFIG_PSTORE_ZLIB_COMPRESS is not set
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=y
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_RAM is not set
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_SPLIT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KMEMCHECK=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_ARCH_HAS_KCOV=y
# CONFIG_KCOV is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHED_INFO is not set
# CONFIG_SCHEDSTATS is not set
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set

#
# Runtime Testing
#
CONFIG_LKDTM=y
CONFIG_TEST_LIST_SORT=y
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=y
# CONFIG_INTERVAL_TREE_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_ASYNC_RAID6_TEST=y
CONFIG_TEST_HEXDUMP=y
CONFIG_TEST_STRING_HELPERS=y
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
# CONFIG_TEST_RHASHTABLE is not set
CONFIG_TEST_HASH=y
CONFIG_TEST_FIRMWARE=y
# CONFIG_TEST_SYSCTL is not set
CONFIG_TEST_UDELAY=y
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_IOMMU_STRESS=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA1_MB=y
CONFIG_CRYPTO_SHA256_MB=y
CONFIG_CRYPTO_SHA512_MB=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
# CONFIG_CRYPTO_SALSA20_X86_64 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
# CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
# CONFIG_DMA_NOOP_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_UCS2_STRING=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set

--lxfz4orbnubblw2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export timeout='10m'
	export job_origin='/lkp/lkp/src/jobs/boot.yaml'
	export queue='validate'
	export testbox='vm-intel12-yocto-x86_64-4'
	export tbox_group='vm-intel12-yocto-x86_64'
	export branch='linus/master'
	export commit='43ff2f4db9d0f76452b77cfa645f02b471143b24'
	export kconfig='x86_64-randconfig-s3-11131952'
	export repeat_to=108
	export submit_id='5a0a4d180b9a934be400151a'
	export job_file='/lkp/scheduled/vm-intel12-yocto-x86_64-4/boot-1-yocto-minimal-x86_64-2016-04-22.cgz-43ff2f4db9d0f76452b77cfa645f02b471143b24-20171114-84964-oglnnw-29.yaml'
	export id='0ac4ac23d0f045b05e3e21f4647258cab41bddce'
	export model='qemu-system-x86_64 -enable-kvm -cpu Nehalem'
	export nr_vm=12
	export nr_cpu=2
	export memory='512M'
	export rootfs='yocto-minimal-x86_64-2016-04-22.cgz'
	export hdd_partitions='/dev/vda'
	export swap_partitions='/dev/vdb'
	export need_kconfig='CONFIG_KVM_GUEST=y'
	export compiler='gcc-6'
	export enqueue_time='2017-11-14 09:55:37 +0800'
	export _id='5a0a4ec00b9a934be4001537'
	export _rt='/result/boot/1/vm-intel12-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-s3-11131952/gcc-6/43ff2f4db9d0f76452b77cfa645f02b471143b24'
	export user='lkp'
	export result_root='/result/boot/1/vm-intel12-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-s3-11131952/gcc-6/43ff2f4db9d0f76452b77cfa645f02b471143b24/29'
	export LKP_SERVER='inn'
	export max_uptime=600
	export initrd='/osimage/yocto/yocto-minimal-x86_64-2016-04-22.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/scheduled/vm-intel12-yocto-x86_64-4/boot-1-yocto-minimal-x86_64-2016-04-22.cgz-43ff2f4db9d0f76452b77cfa645f02b471143b24-20171114-84964-oglnnw-29.yaml
ARCH=x86_64
kconfig=x86_64-randconfig-s3-11131952
branch=linus/master
commit=43ff2f4db9d0f76452b77cfa645f02b471143b24
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s3-11131952/gcc-6/43ff2f4db9d0f76452b77cfa645f02b471143b24/vmlinuz-4.14.0-00902-g43ff2f4
max_uptime=600
RESULT_ROOT=/result/boot/1/vm-intel12-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-s3-11131952/gcc-6/43ff2f4db9d0f76452b77cfa645f02b471143b24/29
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export kernel='/pkg/linux/x86_64-randconfig-s3-11131952/gcc-6/43ff2f4db9d0f76452b77cfa645f02b471143b24/vmlinuz-4.14.0-00902-g43ff2f4'
	export dequeue_time='2017-11-14 10:10:17 +0800'
	export job_initrd='/lkp/scheduled/vm-intel12-yocto-x86_64-4/boot-1-yocto-minimal-x86_64-2016-04-22.cgz-43ff2f4db9d0f76452b77cfa645f02b471143b24-20171114-84964-oglnnw-29.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper last_state
}

"$@"

--lxfz4orbnubblw2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-vm-intel12-yocto-x86_64-4:20171114101205:x86_64-randconfig-s3-11131952:4.14.0-00902-g43ff2f4:1"

#!/bin/bash

# To reproduce,
# 1) save job-script and this script (both are attached in 0day report email)
# 2) run this script with your compiled kernel and optional env $INSTALL_MOD_PATH

kernel=$1

initrds=(
	/osimage/yocto/yocto-minimal-x86_64-2016-04-22.cgz
	/lkp/lkp/lkp-x86_64.cgz
)

HTTP_PREFIX=https://github.com/0day-ci/lkp-qemu/raw/master
wget --timestamping "${initrds[@]/#/$HTTP_PREFIX}"

{
	cat "${initrds[@]//*\//}"
	[[ $INSTALL_MOD_PATH ]] && (
		cd "$INSTALL_MOD_PATH"
		find lib | cpio -o -H newc --quiet | gzip
	)
	echo  job-script | cpio -o -H newc --quiet | gzip
} > initrd.img

qemu-img create -f qcow2 disk-vm-intel12-yocto-x86_64-4-0 256G
qemu-img create -f qcow2 disk-vm-intel12-yocto-x86_64-4-1 256G

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Nehalem
	-kernel $kernel
	-initrd initrd.img
	-m 512
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-drive file=disk-vm-intel12-yocto-x86_64-4-0,media=disk,if=virtio
	-drive file=disk-vm-intel12-yocto-x86_64-4-1,media=disk,if=virtio
	-serial stdio
	-display none
	-monitor null
)

append=(
	ip=::::vm-intel12-yocto-x86_64-4::dhcp
	root=/dev/ram0
	user=lkp
	job=/job-script
	ARCH=x86_64
	kconfig=x86_64-randconfig-s3-11131952
	branch=linus/master
	commit=43ff2f4db9d0f76452b77cfa645f02b471143b24
	BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s3-11131952/gcc-6/43ff2f4db9d0f76452b77cfa645f02b471143b24/vmlinuz-4.14.0-00902-g43ff2f4
	max_uptime=600
	RESULT_ROOT=/result/boot/1/vm-intel12-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-s3-11131952/gcc-6/43ff2f4db9d0f76452b77cfa645f02b471143b24/29
	result_service=tmpfs
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
)

"${kvm[@]}" -append "${append[*]}"

--lxfz4orbnubblw2l--
