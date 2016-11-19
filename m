From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 185531] pata_hpt366 irq xx: nobody cared
Date: Sat, 19 Nov 2016 07:15:48 +0000
Message-ID: <bug-185531-11633-JNxQyQvgZr@https.bugzilla.kernel.org/>
References: <bug-185531-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbcKSHPw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 19 Nov 2016 02:15:52 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 6509720414
        for <linux-ide@vger.kernel.org>; Sat, 19 Nov 2016 07:15:50 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id 3D7C2203A4
        for <linux-ide@vger.kernel.org>; Sat, 19 Nov 2016 07:15:49 +0000 (UTC)
In-Reply-To: <bug-185531-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=185531

--- Comment #1 from Ilario Gottardello <ilario.gottardello@gmail.com> ---
Upgraded ubuntu tu 16.10, problem remains:

[  157.920408] irq 19: nobody cared (try booting with the "irqpoll" option)
[  157.920412] CPU: 2 PID: 0 Comm: swapper/2 Tainted: P           OE  
4.8.0-27-generic #29-Ubuntu
[  157.920413] Hardware name: System manufacturer System Product Name/P8H67-V,
BIOS 3707 07/12/2013
[  157.920414]  0000000000200086 49f34aec7d2664cd ffff929caf283e78
ffffffffb342f5b2
[  157.920416]  ffff929c9f6bb400 ffff929c9f6bb4b4 ffff929caf283ea8
ffffffffb30e2b65
[  157.920417]  ffff929c9f6bb400 0000000000000000 ffffffffb3f5a100
0000000000000072
[  157.920419] Call Trace:
[  157.920419]  <IRQ>  [<ffffffffb342f5b2>] dump_stack+0x63/0x81
[  157.920429]  [<ffffffffb30e2b65>] __report_bad_irq+0x35/0xc0
[  157.920430]  [<ffffffffb30e2ef3>] note_interrupt+0x243/0x290
[  157.920431]  [<ffffffffb30e0014>] handle_irq_event_percpu+0x54/0x80
[  157.920433]  [<ffffffffb30e007e>] handle_irq_event+0x3e/0x60
[  157.920433]  [<ffffffffb30e35ef>] handle_fasteoi_irq+0x9f/0x150
[  157.920435]  [<ffffffffb303021a>] handle_irq+0x1a/0x30
[  157.920437]  [<ffffffffb38a18db>] do_IRQ+0x4b/0xd0
[  157.920439]  [<ffffffffb389f9c2>] common_interrupt+0x82/0x82
[  157.920439]  <EOI>  [<ffffffffb371d29f>] ? cpuidle_enter_state+0x11f/0x2c0
[  157.920443]  [<ffffffffb371d477>] cpuidle_enter+0x17/0x20
[  157.920445]  [<ffffffffb30c791a>] call_cpuidle+0x2a/0x50
[  157.920445]  [<ffffffffb30c7d00>] cpu_startup_entry+0x2a0/0x350
[  157.920447]  [<ffffffffb30518a1>] start_secondary+0x151/0x190
[  157.920448] handlers:
[  157.920450] [<ffffffffb3638d90>] ata_bmdma_interrupt
[  157.920451] [<ffffffffb3638d90>] ata_bmdma_interrupt
[  157.920452] Disabling IRQ #19

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
