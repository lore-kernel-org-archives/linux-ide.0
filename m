From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 31022] New: Kernel oops under
 dequeue_task_fair
Date: Mon, 14 Mar 2011 15:25:04 -0700
Message-ID: <20110314152504.bda4940b.akpm@linux-foundation.org>
References: <bug-31022-10286@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36730 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757412Ab1CNW0a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2011 18:26:30 -0400
In-Reply-To: <bug-31022-10286@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, sgunderson@bigfoot.com


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

The ata driver detected an error and the kernel immediately oopsed
somewhere in the CPU scheduler.  I'd be suspecting a bug somewhere in a
rarely-used ata/block codepath.


On Sun, 13 Mar 2011 00:31:38 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=31022
> 
>            Summary: Kernel oops under dequeue_task_fair
>            Product: Process Management
>            Version: 2.5
>     Kernel Version: 2.6.38-rc3
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>         AssignedTo: process_other@kernel-bugs.osdl.org
>         ReportedBy: sgunderson@bigfoot.com
>         Regression: No
> 
> 
> Hi,
> 
> Under somewhat heavy load, I first had problems with eth0 going haywire:
> 
> [1041371.708420] e1000e 0000:04:00.0: eth0: Detected Hardware Unit Hang:
> [1041371.708423]   TDH                  <0>
> [1041371.708424]   TDT                  <2>
> [1041371.708426]   next_to_use          <2>
> [1041371.708427]   next_to_clean        <0>
> [1041371.708428] buffer_info[next_to_clean]:
> [1041371.708429]   time_stamp           <13e0d57d6>
> [1041371.708431]   next_to_watch        <0>
> [1041371.708432]   jiffies              <13e0d7e5c>
> [1041371.708433]   next_to_watch.status <0>
> [1041371.708434] MAC Status             <2080783>
> [1041371.708436] PHY Status             <792d>
> [1041371.708437] PHY 1000BASE-T Status  <7800>
> [1041371.708438] PHY Extended Status    <3000>
> [1041371.708439] PCI Status             <c110>
> <repeat the above ten times or so>
> [1041371.782410] e1000e 0000:04:00.0: eth0: Reset adapter
> [1041415.765409] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow
> Control: None
> 
> I switched the cables, took out the module, renamed eth1 to eth0 and added
> things back. But 15 minutes later or so, I got the following oops:
> 
> [1041979.906665] ata9.00: exception Emask 0x32 SAct 0x0 SErr 0x1000400 action
> 0x6 frozen
> [1041979.915101] ata9.00: irq_stat 0x18000000, host bus error, interface fatal
> error
> [1041979.923457] ata9: SError: { Proto TrStaTrns }
> [1041979.929119] ata9.00: failed command: READ DMA
> [1041979.934597] ata9.00: cmd c8/00:38:18:a2:7b/00:00:00:00:00/e0 tag 0 dma
> 28672 in
> [1041979.934608]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x32
> (host bus error)
> [1041979.951381] ata9.00: status: { DRDY }
> [1041979.955938] ata9: hard resetting link
> [1041980.002432] BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000181
> [1041980.003006] IP: [<ffffffff8102dd5c>] dequeue_task_fair+0x20/0x227
> [1041980.003006] PGD 1310b4067 PUD 11d62d067 PMD 0 
> [1041980.003006] Oops: 0000 [#1] SMP 
> [1041980.003006] last sysfs file:
> /sys/devices/system/cpu/cpu7/cache/index2/shared_cpu_map
> [1041980.003006] CPU 5 
> [1041980.003006] Modules linked in: e1000e ip_gre gre ipt_REJECT iptable_filter
> ip_tables af_packet microcode nfsd exportfs nfs lockd auth_rpcgss sunrpc ext2
> ext4 jbd2 crc16 fuse coretemp hwmon_vid ide_generic ide_gd_mod ide_cd_mod
> ide_core cdrom forcedeth i2c_i801 psmouse rtc_cmos i2c_core ghes pcspkr shpchp
> hed rtc_core serio_raw rtc_lib evdev pci_hotplug ext3 jbd mbcache dm_mod
> raid456 async_pq async_xor xor async_memcpy async_raid6_recov raid6_pq async_tx
> raid1 md_mod usbhid sd_mod uhci_hcd ahci libahci ehci_hcd sata_mv unix [last
> unloaded: e1000e]
> [1041980.003006] 
> [1041980.003006] Pid: 31125, comm: exifautotran Tainted: G        W  
> 2.6.38-rc6 #1 Supermicro X7DBN/X7DBN
> [1041980.003006] RIP: 0010:[<ffffffff8102dd5c>]  [<ffffffff8102dd5c>]
> dequeue_task_fair+0x20/0x227
> [1041980.003006] RSP: 0018:ffff88021ac6db00  EFLAGS: 00010006
> [1041980.003006] RAX: ffffffff8133ec20 RBX: ffff8800cfd51800 RCX:
> 0000000000000000
> [1041980.003006] RDX: 0000000000000001 RSI: 0000000000000001 RDI:
> ffff8800cfd51800
> [1041980.003006] RBP: ffff88021ac6db28 R08: 0000000000000000 R09:
> ffff8800cfccd8e0
> [1041980.003006] R10: 0000000000000052 R11: 0000000000000054 R12:
> 0000000000000039
> [1041980.003006] R13: ffff88021ac6de10 R14: ffff880129179660 R15:
> ffff880129179660
> [1041980.003006] FS:  00007f1441b39700(0000) GS:ffff8800cfd40000(0000)
> knlGS:0000000000000000
> [1041980.003006] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [1041980.003006] CR2: 0000000000000181 CR3: 00000001444f1000 CR4:
> 00000000000006e0
> [1041980.003006] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [1041980.003006] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400
> [1041980.003006] Process exifautotran (pid: 31125, threadinfo ffff88021ac6c000,
> task ffff880129179660)
> [1041980.003006] Stack:
> [1041980.003006]  0000ffff8102df56 ffff880129179660 ffff8800cfd51800
> ffff88021ac6de10
> [1041980.003006]  0000000000000000 ffff88021ac6db58 ffffffff8102adea
> 0000000300000041
> [1041980.003006]  0000000000000001 ffff8800cfd51800 7fffffffffffffff
> ffff88021ac6db78
> [1041980.003006] Call Trace:
> [1041980.003006]  [<ffffffff8102adea>] dequeue_task+0x80/0x8e
> [1041980.003006]  [<ffffffff8102ae20>] deactivate_task+0x28/0x30
> [1041980.003006]  [<ffffffff8132613c>] schedule+0x383/0xaac
> [1041980.003006]  [<ffffffff810a0a29>] ? get_page_from_freelist+0x39d/0x45b
> [1041980.003006]  [<ffffffff8111614a>] ? dquot_file_open+0x16/0x37
> [1041980.003006]  [<ffffffff8113d1b8>] ? security_dentry_open+0x59/0x5e
> [1041980.003006]  [<ffffffff810d2f1e>] ? __dentry_open+0x182/0x274
> [1041980.003006]  [<ffffffff810dca75>] ? generic_permission+0x17/0x93
> [1041980.003006]  [<ffffffff81058579>] ? sched_clock_local+0x1c/0x82
> [1041980.003006]  [<ffffffff81326996>] schedule_timeout+0x28/0x208
> [1041980.003006]  [<ffffffff8102ae80>] ? enqueue_task+0x58/0x66
> [1041980.003006]  [<ffffffff81325ca7>] wait_for_common+0xbf/0x135
> [1041980.003006]  [<ffffffff81033f0c>] ? default_wake_function+0x0/0xf
> [1041980.003006]  [<ffffffff81325db7>] wait_for_completion+0x18/0x1a
> [1041980.003006]  [<ffffffff8107247a>] stop_one_cpu+0x5b/0x75
> [1041980.003006]  [<ffffffff810339d6>] ? migration_cpu_stop+0x0/0x1d
> [1041980.003006]  [<ffffffff810325e9>] sched_exec+0xa7/0xbe
> [1041980.003006]  [<ffffffff810dac13>] do_execve+0xb8/0x2a9
> [1041980.003006]  [<ffffffff81008d2b>] sys_execve+0x3e/0x5c
> [1041980.003006]  [<ffffffff810022dc>] stub_execve+0x6c/0xc0
> [1041980.003006] Code: 89 e0 5b 41 5c 41 5d 41 5e c9 c3 55 48 89 e5 41 57 41 5e
> 51 89 d6 41 55 41 54 4c 8d 66 38 53 48 89 fb 48 83 ec 08 e9 9a 01 00 00 <4d> 8b
> ac 24 48 01 00 00 4c 89 ef e8 d6 c5 ff ff 4d 3b 65 50 74 
> [1041980.003006] RIP  [<ffffffff8102dd5c>] dequeue_task_fair+0x20/0x227
> [1041980.003006]  RSP <ffff88021ac6db00>
> [1041980.003006] CR2: 0000000000000181
> [1041980.003006] ---[ end trace 342ac00b53041caa ]---
>
> ...
>
