From: Joseph Fannin <jfannin@gmail.com>
Subject: IDE OOPS w/udevtrigger
Date: Mon, 25 Aug 2008 14:52:25 -0400
Message-ID: <20080825185224.GA5187@nineveh.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:3575 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbYHYSwa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Aug 2008 14:52:30 -0400
Received: by an-out-0708.google.com with SMTP id d40so251841and.103
        for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 11:52:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello!  I'm getting a new OOPS where I didn't before, and it's a
little bit involved:

When udevtrigger(8) runs from the initscripts on a box I have running
Debian stable, I'm now getting this (and I have an idea why):

[   34.471297] BUG: unable to handle kernel NULL pointer dereference at 00000010
[   34.471297] IP: [<c024e5c0>] kobject_get_path+0x20/0xb0
[   34.471297] *pde = 00000000
[   34.471297] Oops: 0000 [#1] PREEMPT SMP
[   34.471297] Modules linked in: sd_mod ide_core aic7xxx scsi_transport_spi 8139cp scsi_mod 8139too mii uhci_hcd usbcore thermal processor fan ext4dev crc16 jbd2 mbcache
[   34.471297]
[   34.471297] Pid: 1377, comm: udevtrigger Not tainted (2.6.27-rc4-2008082401 #44)
[   34.471297] EIP: 0060:[<c024e5c0>] EFLAGS: 00010202 CPU: 0
[   34.471297] EIP is at kobject_get_path+0x20/0xb0
[   34.471297] EAX: 00000009 EBX: 00000010 ECX: 00000009 EDX: 000000d0
[   34.471297] ESI: c96f56d0 EDI: 00008d6e EBP: c9532e84 ESP: c9532e6c
[   34.471297]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[   34.471297] Process udevtrigger (pid: 1377, ti=c9532000 task=cacf0000 task.ti=c9532000)
[   34.471297] Stack: 000000d0 c024e5fd 000080d0 c96f55f8 c9526ed8 c9526e00 c9532ea8 c02bbb98
[   34.471297]        c9532ebc 000080d0 c950dbc0 c95af000 cac3b0c0 c9526ed8 c02bbae0 c9532efc
[   34.471297]        c024eb7e c95af000 c043e0f5 cc1463cd 00000000 00000000 00000000 c0452604
[   34.471297] Call Trace:
[   34.471297]  [<c024e5fd>] ? kobject_get_path+0x5d/0xb0
[   34.471297]  [<c02bbb98>] ? dev_uevent+0xb8/0x1f0
[   34.471297]  [<c02bbae0>] ? dev_uevent+0x0/0x1f0
[   34.471297]  [<c024eb7e>] ? kobject_uevent_env+0x18e/0x390
[   34.471297]  [<c024edd4>] ? kobject_action_type+0x44/0x80
[   34.471297]  [<c024ed8a>] ? kobject_uevent+0xa/0x10
[   34.471297]  [<c02bbe40>] ? store_uevent+0x30/0x80
[   34.471297]  [<c02bbe10>] ? store_uevent+0x0/0x80
[   34.471297]  [<c02bb724>] ? dev_attr_store+0x34/0x50
[   34.471297]  [<c0206ad7>] ? sysfs_write_file+0xa7/0x100
[   34.471297]  [<c01bcbee>] ? vfs_write+0x9e/0x160
[   34.471297]  [<c01bac39>] ? do_sys_open+0xb9/0xe0
[   34.471297]  [<c0206a30>] ? sysfs_write_file+0x0/0x100
[   34.471297]  [<c01bd462>] ? sys_write+0x42/0x70
[   34.471297]  [<c0104103>] ? sysenter_do_call+0x12/0x3f
[   34.471297]  =======================
[   34.471297] Code: 31 db e8 44 fa ff ff eb cd 89 f6 55 89 e5 57 bf 01 00 00 00 56 89 c6 53 89 c3 83 ec 0c 89 55 e8 8d 74 26 00 8d bc 27 00 00 00 00 <8b> 03 85 c0 74 14 e8 35 53 00 00 8b 5b 0c 85 db 8d 7c 38 01 75
[   34.471297] EIP: [<c024e5c0>] kobject_get_path+0x20/0xb0 SS:ESP 0068:c9532e6c
[   34.479297] ---[ end trace a5b6e0b53e3ad7d6 ]--

... cause if I run `sudo udevtrigger --verbose`, the thing ends with:

/class/ide_port/ide0
Segmentation fault

...and the OOPS reoccurs.  It's entirely reproducable.

The thing is, I know this box has a bad IDE controller on the
motherboard -- which is why it's disabled in the BIOS.  The machine is
SCSI-only.  With IDE off in the BIOS, IRQs 14 and 15 get assigned
elsewhere.

When Debian's initrd scripts fail to discover an IDE controller
though, they modprobe ide-generic, and I have always gotten a
complaint about the IRQs from that, like:

[   23.636344] Probing IDE interface ide1...
[   24.207297] IRQ handler type mismatch for IRQ 14
[   24.207297] current handler: uhci_hcd:usb1
[   24.207297] Pid: 939, comm: modprobe Not tainted 2.6.27-rc4-2008082401 #44
[   24.207297]  [<c017c782>] setup_irq+0x162/0x290
[   24.207297]  [<c015b2ab>] ? trace_hardirqs_on+0xb/0x10
[   24.207297]  [<c017cb05>] request_irq+0xb5/0x120
[   24.207297]  [<cc13b710>] ? ide_intr+0x0/0x200 [ide_core]
[   24.207297]  [<cc13f2c5>] init_irq+0x1a5/0x320 [ide_core]
[   24.207297]  [<c01b7b24>] ? __kmalloc+0x104/0x130
[   24.207297]  [<c0245baa>] ? register_blkdev+0xea/0x120
[   24.207297]  [<cc13ffcc>] ide_host_register+0x37c/0x620 [ide_core]
[   24.207297]  [<cc051198>] ide_generic_init+0x198/0x2e2 [ide_generic]
[   24.207297]  [<c015ee93>] ? smp_call_function_mask+0x53/0x1b0
[   24.207297]  [<c015b2ab>] ? trace_hardirqs_on+0xb/0x10
[   24.207297]  [<c0114740>] ? do_flush_tlb_all+0x0/0x70
[   24.207297]  [<c015b21d>] ? trace_hardirqs_on_caller+0xcd/0x150
[   24.207297]  [<c015b2ab>] ? trace_hardirqs_on+0xb/0x10
[   24.207297]  [<c015b0ab>] ? mark_held_locks+0x6b/0x80
[   24.207297]  [<c015b21d>] ? trace_hardirqs_on_caller+0xcd/0x150
[   24.207297]  [<c015b0ab>] ? mark_held_locks+0x6b/0x80
[   24.207297]  [<c015b2ab>] ? trace_hardirqs_on+0xb/0x10
[   24.207297]  [<c015b21d>] ? trace_hardirqs_on_caller+0xcd/0x150
[   24.207297]  [<c015b2ab>] ? trace_hardirqs_on+0xb/0x10
[   24.207297]  [<c01a8863>] ? __vunmap+0x73/0xe0
[   24.207297]  [<c01a8863>] ? __vunmap+0x73/0xe0
[   24.207297]  [<c01a8986>] ? vfree+0x26/0x30
[   24.207297]  [<c0163299>] ? load_module+0x1879/0x1a90
[   24.207297]  [<c0101254>] do_one_initcall+0x34/0x170
[   24.207297]  [<cc051000>] ? ide_generic_init+0x0/0x2e2 [ide_generic]
[   24.207297]  [<c015b2ab>] ? trace_hardirqs_on+0xb/0x10
[   24.207297]  [<c015b21d>] ? trace_hardirqs_on_caller+0xcd/0x150
[   24.207297]  [<c015b2ab>] ? trace_hardirqs_on+0xb/0x10
[   24.207297]  [<c016353a>] sys_init_module+0x8a/0x1b0
[   24.207297]  [<c015b21d>] ? trace_hardirqs_on_caller+0xcd/0x150
[   24.207297]  [<c02539ec>] ? trace_hardirqs_on_thunk+0xc/0x10
[   24.207297]  [<c010420e>] syscall_call+0x7/0xb

... which I have been ignoring.

The OOPS is new, though.  Worse, since it causes udevtrigger to
segfault, other devices don't get picked up by the initscripts, so now
my ethernet interface doesn't get brought up, psmouse.ko doesn't get
loaded automatically, etc.

I've seen this in Linus's git as of yesterday (2008-08-24) and in
2.6.27-rc1-mm1.  The last kernel I ran on this box didn't have that
problem was 2.6.26-rc9+, as of July 6th, or so.  I haven't run
anything in between those.

So:  the ide hardware is known to be bad, and ide-generic is
necessarily a bit blind, as I understand it... but the OOPS is new,
and it seems like ide-generic isn't cleaning up after itself they way
it did before.  Or maybe sysfs isn't.

I'm willing to try to bisect this, but maybe it's not necessary?

Thanks.
--
Joseph Fannin
jfannin@gmail.com

