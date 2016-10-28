From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 185531] New: pata_hpt366 irq xx: nobody cared
Date: Fri, 28 Oct 2016 20:13:31 +0000
Message-ID: <bug-185531-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbcJ1UNe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 28 Oct 2016 16:13:34 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 058EE2040F
        for <linux-ide@vger.kernel.org>; Fri, 28 Oct 2016 20:13:33 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id E1071203AA
        for <linux-ide@vger.kernel.org>; Fri, 28 Oct 2016 20:13:31 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=185531

            Bug ID: 185531
           Summary: pata_hpt366 irq xx: nobody cared
           Product: IO/Storage
           Version: 2.5
    Kernel Version: Linux 4.4.0-45-generic Ubuntu SMP x86_64
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
          Assignee: io_ide@kernel-bugs.osdl.org
          Reporter: ilario.gottardello@gmail.com
        Regression: No

Some time after boot, a spurious interrupt make this driver downgrade
performance from udma to pio. This interrupt is assigned solely to this card,
as says /proc/interrupts:

           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5      
CPU6       CPU7
 19:       4147          0          0        188     195666          0         
0          0   IO-APIC  19-fasteoi   pata_hpt366, pata_hpt366

This is the relevant part from dmesg:

[ 3049.573902] irq 19: nobody cared (try booting with the "irqpoll" option)
[ 3049.573910] CPU: 4 PID: 0 Comm: swapper/4 Tainted: P           OE  
4.4.0-45-generic #66-Ubuntu
[ 3049.573912] Hardware name: System manufacturer System Product Name/P8H67-V,
BIOS 3707 07/12/2013
[ 3049.573915]  0000000000000086 d86ed4c7c37291ec ffff88012f303e60
ffffffff813f1fe3
[ 3049.573919]  ffff8800c07a5a00 ffff8800c07a5ab4 ffff88012f303e88
ffffffff810dd7a3
[ 3049.573922]  ffff8800c07a5a00 0000000000000000 0000000000000013
ffff88012f303ec0
[ 3049.573925] Call Trace:
[ 3049.573927]  <IRQ>  [<ffffffff813f1fe3>] dump_stack+0x63/0x90
[ 3049.573940]  [<ffffffff810dd7a3>] __report_bad_irq+0x33/0xc0
[ 3049.573943]  [<ffffffff810ddb37>] note_interrupt+0x247/0x290
[ 3049.573946]  [<ffffffff810dadc7>] handle_irq_event_percpu+0x167/0x1d0
[ 3049.573949]  [<ffffffff810dae6e>] handle_irq_event+0x3e/0x60
[ 3049.573952]  [<ffffffff810de0a6>] handle_fasteoi_irq+0x96/0x150
[ 3049.573956]  [<ffffffff810310fa>] handle_irq+0x1a/0x30
[ 3049.573962]  [<ffffffff8183429b>] do_IRQ+0x4b/0xd0
[ 3049.573965]  [<ffffffff81832382>] common_interrupt+0x82/0x82
[ 3049.573966]  <EOI>  [<ffffffff816c4dce>] ? cpuidle_enter_state+0x10e/0x2b0
[ 3049.573975]  [<ffffffff816c4fa7>] cpuidle_enter+0x17/0x20
[ 3049.573979]  [<ffffffff810c4112>] call_cpuidle+0x32/0x60
[ 3049.573982]  [<ffffffff816c4f83>] ? cpuidle_select+0x13/0x20
[ 3049.573986]  [<ffffffff810c43d0>] cpu_startup_entry+0x290/0x350
[ 3049.573989]  [<ffffffff810516e4>] start_secondary+0x154/0x190
[ 3049.573992] handlers:
[ 3049.573995] [<ffffffff815e81e0>] ata_bmdma_interrupt
[ 3049.573997] [<ffffffff815e81e0>] ata_bmdma_interrupt
[ 3049.573999] Disabling IRQ #19

Already changed cables and moved the card in another slot, the issue still
appears.
I'm willing to help debug the issue. Thanks in advance.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
