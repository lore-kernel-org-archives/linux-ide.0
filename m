From: valdis.kletnieks@vt.edu
Subject: linux-next 20170117 - lockdep whines and BUGs in ata_scsi_rbuf_fill()
Date: Thu, 19 Jan 2017 02:28:35 -0500
Message-ID: <21348.1484810915@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1484810915_2585P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

--==_Exmh_1484810915_2585P
Content-Type: text/plain; charset=us-ascii

linux-next 20170110 didn't exhibit this.

Am seeing at boot a lockdep whine, followed by 3 BUGs. ata_scsi_rbuf_fill() is
in the traceback for all of them.    'git log' hints that it's one of 6 commits
against drivers/ata/libata-scsi.c by Christoph, but none of them spring out
as being the guilty party.  This ring any bells, or should I start
cherrypicking reverts and bisecting?

(-dirty due to a local patch to net/ipv6/addrconf.c for a VPN issue)

Lockdep:

[    3.359133] =================================
[    3.359162] [ INFO: inconsistent lock state ]
[    3.359192] 4.10.0-rc4-next-20170117-dirty #375 Not tainted
[    3.359229] ---------------------------------
[    3.359258] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[    3.359299] kworker/u8:0/5 [HC0[0]:SC0[0]:HE1:SE1] takes:
[    3.359334]  (&(&host->lock)->rlock){?.....}, at: [<ffffffffa99f4e4f>] ata_scsi_queuecmd+0x4f/0x420
[    3.359398] {IN-HARDIRQ-W} state was registered at:
[    3.359431]
[    3.359434] [<ffffffffa915cc66>] __lock_acquire+0x636/0x18b0
[    3.359484]
[    3.359486] [<ffffffffa915e4d9>] lock_acquire+0x119/0x2d0
[    3.359533]
[    3.359535] [<ffffffffaa1baf01>] _raw_spin_lock+0x41/0x80
[    3.359582]
[    3.359584] [<ffffffffa9a0be14>] ahci_single_level_irq_intr+0x44/0x90
[    3.359638]
[    3.359640] [<ffffffffa91710f7>] __handle_irq_event_percpu+0x127/0x690
[    3.359694]
[    3.359696] [<ffffffffa9171694>] handle_irq_event_percpu+0x34/0xb0
[    3.359747]
[    3.359749] [<ffffffffa917175b>] handle_irq_event+0x4b/0xc0
[    3.359797]
[    3.359799] [<ffffffffa9177725>] handle_edge_irq+0xb5/0x3d0
[    3.359847]
[    3.359849] [<ffffffffa90396d6>] handle_irq+0xa6/0x2c0
[    3.359895]
[    3.359897] [<ffffffffaa1be4f3>] do_IRQ+0x83/0x1b0
[    3.359940]
[    3.359942] [<ffffffffaa1bc8d0>] ret_from_intr+0x0/0x19
[    3.359989]
[    3.359992] [<ffffffffa9bb87c4>] cpuidle_enter_state+0xe4/0x660
[    3.360043]
[    3.360045] [<ffffffffa9bb8d97>] cpuidle_enter+0x17/0x20
[    3.360092]
[    3.360095] [<ffffffffa9147757>] do_idle+0x2f7/0x3d0
[    3.360139]
[    3.360142] [<ffffffffa9147f5c>] cpu_startup_entry+0x7c/0x90
[    3.360190]
[    3.360193] [<ffffffffaa1a959c>] rest_init+0x15c/0x170
[    3.360239]
[    3.360242] [<ffffffffab63a734>] start_kernel+0x747/0x788
[    3.360288]
[    3.360291] [<ffffffffab6383b8>] x86_64_start_reservations+0x4f/0x70
[    3.360344]
[    3.360346] [<ffffffffab63871d>] x86_64_start_kernel+0x344/0x38b
[    3.360397]
[    3.360400] [<ffffffffa90001c4>] verify_cpu+0x0/0xf1
[    3.360445] irq event stamp: 160102
[    3.360470] hardirqs last  enabled at (160101): [<ffffffffaa1bb47e>] _raw_spin_unlock_irq+0x2e/0x80
[    3.360529] hardirqs last disabled at (160102): [<ffffffffaa1bb15e>] _raw_spin_lock_irqsave+0x1e/0x90
[    3.360589] softirqs last  enabled at (159762): [<ffffffffaa1c1ded>] __do_softirq+0x55d/0xa39
[    3.360644] softirqs last disabled at (159741): [<ffffffffa90c2a81>] irq_exit+0x111/0x170
[    3.360695]
               other info that might help us debug this:
[    3.360737]  Possible unsafe locking scenario:

[    3.360775]        CPU0
[    3.360793]        ----
[    3.360810]   lock(&(&host->lock)->rlock);
[    3.360839]   <Interrupt>
[    3.360857]     lock(&(&host->lock)->rlock);
[    3.360887]
                *** DEADLOCK ***

[    3.360926] 4 locks held by kworker/u8:0/5:
[    3.360954]  #0:  ("events_unbound"){.+.+.+}, at: [<ffffffffa90ef887>] process_one_work+0x347/0xe10
[    3.361015]  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffffa90ef887>] process_one_work+0x347/0xe10
[    3.361075]  #2:  (&shost->scan_mutex){+.+.+.}, at: [<ffffffffa99c258c>] __scsi_add_device+0xac/0x150
[    3.361137]  #3:  (&(&host->lock)->rlock){?.....}, at: [<ffffffffa99f4e4f>] ata_scsi_queuecmd+0x4f/0x420
[    3.362428] usbcore: registered new interface driver uvcvideo
[    3.362429] USB Video Class driver (1.1.1)
[    3.367023]
               stack backtrace:
[    3.370918] CPU: 1 PID: 5 Comm: kworker/u8:0 Not tainted 4.10.0-rc4-next-20170117-dirty #375
[    3.372913] Hardware name: Dell Inc. Latitude E6530/07Y85M, BIOS A17 08/19/2015
[    3.374918] Workqueue: events_unbound async_run_entry_fn
[    3.376925] Call Trace:
[    3.378912]  dump_stack+0x7b/0xd1
[    3.380888]  print_usage_bug+0x27b/0x330
[    3.382850]  mark_lock+0x6ea/0x8a0
[    3.384787]  ? print_shortest_lock_dependencies+0x380/0x380
[    3.386726]  mark_held_locks+0x93/0x160
[    3.388651]  ? add_lock_to_list.isra.17.constprop.33+0xa7/0x160
[    3.390591]  ? cache_alloc_refill+0x9dd/0x1360
[    3.392533]  trace_hardirqs_on_caller+0x103/0x2c0
[    3.394464]  trace_hardirqs_on+0xd/0x10
[    3.396390]  cache_alloc_refill+0x9dd/0x1360
[    3.398301]  ? ___might_sleep+0x1e2/0x300
[    3.400203]  ? __might_sleep+0x66/0x1f0
[    3.402091]  kmem_cache_alloc_trace+0xf3/0x4f0
[    3.403976]  ? ata_scsiop_inq_00+0x160/0x160
[    3.405854]  ata_scsi_rbuf_fill+0x39/0x110
[    3.407696]  ata_scsi_simulate+0x2e8/0x4b0
[    3.409533]  ata_scsi_queuecmd+0x303/0x420
[    3.411350]  scsi_dispatch_cmd+0x188/0x690
[    3.413154]  scsi_request_fn+0x709/0xd00
[    3.414958]  __blk_run_queue+0x7e/0xb0
[    3.416733]  blk_execute_rq_nowait+0x1c5/0x210
[    3.418515]  ? blk_execute_rq_nowait+0x210/0x210
[    3.420304]  blk_execute_rq+0x14b/0x210
[    3.422088]  ? blk_rq_append_bio+0x9d/0x100
[    3.423864]  ? blk_rq_map_kern+0x11b/0x200
[    3.425584]  ? blk_get_request+0x149/0x290
[    3.427285]  __scsi_execute+0x148/0x210
[    3.429035]  scsi_execute_req_flags+0x98/0x110
[    3.430786]  scsi_probe_and_add_lun+0x29e/0x1210
[    3.432519]  ? _raw_spin_unlock_irqrestore+0x87/0x90
[    3.434250]  ? __pm_runtime_resume+0x52/0x90
[    3.435972]  __scsi_add_device+0x121/0x150
[    3.437701]  ata_scsi_scan_host+0x127/0x240
[    3.439424]  async_port_probe+0x4a/0x90
[    3.441127]  async_run_entry_fn+0x66/0x2b0
[    3.442828]  process_one_work+0x3dc/0xe10
[    3.444522]  ? process_one_work+0x347/0xe10
[    3.446203]  worker_thread+0x352/0xb40
[    3.447882]  kthread+0x176/0x250
[    3.449543]  ? process_one_work+0xe10/0xe10
[    3.451215]  ? kthread_create_on_node+0x60/0x60
[    3.452866]  ret_from_fork+0x2e/0x40
[    3.454614] scsi 0:0:0:0: Direct-Access     ATA      ST500LX003-1AC15 DEM4 PQ: 0 ANSI: 5

The 3 BUGs have essentially the same traceback:

[    4.260406] BUG: sleeping function called from invalid context at mm/slab.h:408
[    4.264460] in_atomic(): 1, irqs_disabled(): 1, pid: 362, name: ata_id
[    4.268485] INFO: lockdep is turned off.
[    4.272516] irq event stamp: 0
[    4.276490] hardirqs last  enabled at (0): [<          (null)>]           (null)
[    4.280535] hardirqs last disabled at (0): [<ffffffffa90b23db>] copy_process.part.33+0xb0b/0x3b50
[    4.284604] softirqs last  enabled at (0): [<ffffffffa90b23db>] copy_process.part.33+0xb0b/0x3b50
[    4.288538] softirqs last disabled at (0): [<          (null)>]           (null)
[    4.292428] CPU: 2 PID: 362 Comm: ata_id Not tainted 4.10.0-rc4-next-20170117-dirty #375
[    4.296395] Hardware name: Dell Inc. Latitude E6530/07Y85M, BIOS A17 08/19/2015
[    4.300432] Call Trace:
[    4.304460]  dump_stack+0x7b/0xd1
[    4.308451]  ___might_sleep+0x194/0x300
[    4.312457]  __might_sleep+0x66/0x1f0
[    4.316420]  kmem_cache_alloc_trace+0x2fc/0x4f0
[    4.320436]  ? ata_scsiop_inq_00+0x160/0x160
[    4.323049]  ata_scsi_rbuf_fill+0x39/0x110
[    4.325212]  ata_scsi_simulate+0x2e8/0x4b0
[    4.327388]  ata_scsi_queuecmd+0x303/0x420
[    4.329549]  scsi_dispatch_cmd+0x188/0x690
[    4.331733]  scsi_request_fn+0x709/0xd00
[    4.333853]  __blk_run_queue+0x7e/0xb0
[    4.335945]  __elv_add_request+0x1f2/0x680
[    4.338105]  blk_execute_rq_nowait+0x1bd/0x210
[    4.340235]  ? blk_execute_rq_nowait+0x210/0x210
[    4.342334]  blk_execute_rq+0x14b/0x210
[    4.344459]  ? blk_rq_map_user+0x92/0xe0
[    4.346597]  sg_io+0x357/0x510
[    4.348734]  ? __check_object_size+0x19d/0x4f8
[    4.350852]  scsi_cmd_ioctl+0x38d/0x540
[    4.352944]  scsi_cmd_blk_ioctl+0x50/0x80
[    4.355027]  sd_ioctl+0x8f/0xf0
[    4.357103]  blkdev_ioctl+0x5ed/0x1090
[    4.359183]  ? trace_hardirqs_on_caller+0x16/0x2c0
[    4.361277]  block_ioctl+0x57/0xa0
[    4.363295]  do_vfs_ioctl+0xc0/0xb00
[    4.365325]  SyS_ioctl+0x79/0x90
[    4.367319]  do_syscall_64+0x8c/0x290
[    4.369243]  entry_SYSCALL64_slow_path+0x25/0x25
[    4.371159] RIP: 0033:0x7ff3910156c7
[    4.373051] RSP: 002b:00007ffcc3a22448 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[    4.374956] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff3910156c7
[    4.376846] RDX: 00007ffcc3a224a0 RSI: 0000000000002285 RDI: 0000000000000003
[    4.378714] RBP: 00007ffcc3a22b90 R08: 0000000000000000 R09: 0000000000000000
[    4.380543] R10: 00007ff391b3e080 R11: 0000000000000246 R12: 00000000ffffffff
[    4.382391] R13: 00007ffcc3a22f1a R14: 00007ffcc3a22700 R15: 0000000000000003
[    4.386253] ata_id (362) used greatest stack depth: 12136 bytes left


--==_Exmh_1484810915_2585P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.5 07/13/2001

iQEVAwUBWIBqo40DS38y7CIcAQJRnAf/WXsKk5DkRkp0hFWRgMGTRcL/F8HC0z+f
rHKd1q21OY4h3Bgs166RY3eARu1nMZRVJBexmbQ+JeVNJreya4HWKzkvQDCquxgs
sBGqVMJ04W82q/TzsbSS4yr77oFXfwaMeqCtrC/MPEhyagKksMaTG5e4RwnHjgYx
9dfiFiBU+p6JnfdQt6nhA+1t3TlSy/swiqGyd+qdyD2xztuXgzb5rI/JhFdGAZsS
fDVuOHqUCtfVkiskzhkh3vIWetnYyyYxy5JEQ/EDZslK2hjMGwKXWYEpVxa9eVMe
GR5UKkgi7oX3tWVe2BVXZY6BVyKoSoQywbxtYW5y6coFLSM4zxDGIA==
=h6Zk
-----END PGP SIGNATURE-----

--==_Exmh_1484810915_2585P--
