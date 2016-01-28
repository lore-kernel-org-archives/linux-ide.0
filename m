From: Dmitry Vyukov <dvyukov@google.com>
Subject: ata: BUG in ata_sff_hsm_move
Date: Thu, 28 Jan 2016 12:35:43 +0100
Message-ID: <CACT4Y+b_JsOxJu2EZyEf+mOXORc_zid5V1-pLZSroJVxyWdSpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@redhat.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: syzkaller <syzkaller@googlegroups.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: linux-ide@vger.kernel.org

Hello,

I episodically hit the following BUG while running syzkaller fuzzer:


ata2: protocol 2 task_state 0 (dev_stat 0x41)
------------[ cut here ]------------
kernel BUG at drivers/ata/libata-sff.c:1302!
invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
Modules linked in:
CPU: 1 PID: 10679 Comm: syz-executor Not tainted 4.5.0-rc1+ #300
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
task: ffff88002bd00000 ti: ffff88002e048000 task.ti: ffff88002e048000
RIP: 0010:[<ffffffff83a83409>]  [<ffffffff83a83409>]
ata_sff_hsm_move+0x619/0x1c60
RSP: 0000:ffff88003ed07c80  EFLAGS: 00010086
RAX: 000000000000002d RBX: 0000000000000041 RCX: 0000000000000000
RDX: 000000000000002d RSI: ffff88003ed16cd8 RDI: ffffed0007da0f84
RBP: ffff88003ed07d20 R08: 0000000000000001 R09: 0000000000000000
R10: ffff88002bd00000 R11: 1ffffffff134edc5 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff880060bc8000 R15: ffff880060bc8198
FS:  00007fa131e89700(0000) GS:ffff88003ed00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000451a40 CR3: 000000002f797000 CR4: 00000000000006e0
Stack:
 ffff88003ed07e08 ffffffff81455c49 0000000035b0df00 ffff88003dfe7d78
 ffffffff87b5d0d8 dffffc0000000000 ffffffff87b5d0c0 0000000000000000
 ffff880060bc81c0 ffff880060bca408 ffffed000c179038 ffff880060bc81a0
Call Trace:
 <IRQ>
 [<ffffffff83a84c31>] __ata_sff_port_intr+0x1e1/0x3a0
drivers/ata/libata-sff.c:1584
 [<ffffffff83a85611>] ata_bmdma_port_intr+0x71/0x400
drivers/ata/libata-sff.c:2877
 [<     inline     >] __ata_sff_interrupt drivers/ata/libata-sff.c:1629
 [<ffffffff83a85bf3>] ata_bmdma_interrupt+0x253/0x580
drivers/ata/libata-sff.c:2902
 [<ffffffff81479f98>] handle_irq_event_percpu+0x108/0x7e0
kernel/irq/handle.c:157
 [<ffffffff8147a717>] handle_irq_event+0xa7/0x140 kernel/irq/handle.c:205
 [<ffffffff81484573>] handle_edge_irq+0x1e3/0x8d0 kernel/irq/chip.c:623
 [<     inline     >] generic_handle_irq_desc include/linux/irqdesc.h:146
 [<ffffffff811a92bc>] handle_irq+0x10c/0x2a0 arch/x86/kernel/irq_64.c:78
 [<ffffffff811a7e4d>] do_IRQ+0x7d/0x1a0 arch/x86/kernel/irq.c:240
 [<ffffffff86653d4c>] common_interrupt+0x8c/0x8c arch/x86/entry/entry_64.S:520
 <EOI>
 [<     inline     >] rcu_lock_acquire include/linux/rcupdate.h:490
 [<     inline     >] rcu_read_lock include/linux/rcupdate.h:874
 [<ffffffff8164b4a1>] filemap_map_pages+0x131/0xba0 mm/filemap.c:2145
 [<     inline     >] do_fault_around mm/memory.c:2943
 [<     inline     >] do_read_fault mm/memory.c:2962
 [<     inline     >] do_fault mm/memory.c:3133
 [<     inline     >] handle_pte_fault mm/memory.c:3308
 [<     inline     >] __handle_mm_fault mm/memory.c:3418
 [<ffffffff816efb16>] handle_mm_fault+0x2516/0x49a0 mm/memory.c:3447
 [<ffffffff8127dc16>] __do_page_fault+0x376/0x960 arch/x86/mm/fault.c:1238
 [<ffffffff8127e358>] trace_do_page_fault+0xe8/0x420 arch/x86/mm/fault.c:1331
 [<ffffffff8126f514>] do_async_page_fault+0x14/0xd0 arch/x86/kernel/kvm.c:264
 [<ffffffff86655578>] async_page_fault+0x28/0x30 arch/x86/entry/entry_64.S:986
Code: b6 0c 01 48 89 f8 83 e0 07 83 c0 03 38 c8 7c 08 84 c9 0f 85 9e
13 00 00 41 8b 76 24 44 89 e1 48 c7 c7 40 21 d7 86 e8 ac 22 bc fd <0f>
0b 41 83 fc 01 75 84 e8 aa 6d ae fd 48 8b 55 c0 48 b8 00 00
RIP  [<ffffffff83a83409>] ata_sff_hsm_move+0x619/0x1c60
drivers/ata/libata-sff.c:1299
 RSP <ffff88003ed07c80>
---[ end trace 3f182793f8f54475 ]---
Kernel panic - not syncing: Fatal exception in interrupt
Shutting down cpus with NMI
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Fatal exception in interrupt


I've added the following debug print output of which you can see above:

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index cdf6215..30fd154 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1296,6 +1296,9 @@ fsm_start:
                break;
        default:
                poll_next = 0;
+               pr_err("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
+                       ap->print_id, qc->tf.protocol, ap->hsm_task_state,
+                       status);
                BUG();
        }

So the unexpected state is HSM_IDLE.

It is not trivially reproducible. If you want to reproduce, follow
instructions at:
https://github.com/google/syzkaller/wiki/How-to-execute-syzkaller-programs
Using the following file as program:
https://gist.githubusercontent.com/dvyukov/7a9ee0544eb0cda5210d/raw/7076e5a7749c0ebdb59ee83b1683ac9d6ff76059/gistfile1.txt

This is on commit 92e963f50fc74041b5e9e744c330dca48e04f08d.
