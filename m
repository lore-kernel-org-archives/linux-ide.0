From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: kerenl 3.0.3: irq x: nobody cared problem
Date: Tue, 6 Sep 2011 11:09:45 +0200
Message-ID: <CAGm1_kti=qsb5NLh3bKPimeqSfx6zQ81_dgNVPzj59exG-HGUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37885 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714Ab1IFJKG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2011 05:10:06 -0400
Received: by vws1 with SMTP id 1so4569609vws.19
        for <linux-ide@vger.kernel.org>; Tue, 06 Sep 2011 02:10:05 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org

I'm using a ks8695 based board with more or less self-made IDE
controller (EPLD). Most CF cards wprked without a problem with kernel
2.6.33 and legacy IDE driver. Now I ported our platform to 3.0.3 and
both legacy driver and libata driver give following error:

ks8695_ether Ethernet driver, V1.02
irq 3: nobody cared (try booting with the "irqpoll" option)
[<c002fbbc>] (unwind_backtrace+0x0/0xe4) from [<c005ffc8>]
(__report_bad_irq.clone.6+0x24/0xa8)
[<c005ffc8>] (__report_bad_irq.clone.6+0x24/0xa8) from [<c0060234>]
(note_interrupt+0x194/0x240)
[<c0060234>] (note_interrupt+0x194/0x240) from [<c005ee58>]
(handle_irq_event_percpu+0x150/0x17c)
[<c005ee58>] (handle_irq_event_percpu+0x150/0x17c) from [<c005eeac>]
(handle_irq_event+0x28/0x38)
[<c005eeac>] (handle_irq_event+0x28/0x38) from [<c006090c>]
(handle_level_irq+0xbc/0xe4)
[<c006090c>] (handle_level_irq+0xbc/0xe4) from [<c005e868>]
(generic_handle_irq+0x34/0x48)
[<c005e868>] (generic_handle_irq+0x34/0x48) from [<c002505c>]
(asm_do_IRQ+0x5c/0x80)
[<c002505c>] (asm_do_IRQ+0x5c/0x80) from [<c002aa88>] (__irq_svc+0x28/0xa0)
Exception stack(0xc3419ed0 to 0xc3419f18)
9ec0:                                     c036a394 00000000 c036a384 60000013
9ee0: 0000002a 00000003 c03822f8 c036a364 00000000 c0382220 c3419f2c 00000003
9f00: 00000000 c3419f18 c003a544 c003a54c 60000013 ffffffff
[<c002aa88>] (__irq_svc+0x28/0xa0) from [<c003a54c>] (vprintk+0x310/0x348)
[<c003a54c>] (vprintk+0x310/0x348) from [<c02b57f4>] (printk+0x18/0x24)
[<c02b57f4>] (printk+0x18/0x24) from [<c0018244>] (ks8695_init+0x14/0x30)
[<c0018244>] (ks8695_init+0x14/0x30) from [<c00088f8>]
(do_one_initcall+0xa8/0x178)
[<c00088f8>] (do_one_initcall+0xa8/0x178) from [<c0008a3c>]
(kernel_init+0x74/0x110)
[<c0008a3c>] (kernel_init+0x74/0x110) from [<c002bd74>]
(kernel_thread_exit+0x0/0x8)
handlers:
[<c01896d8>] ata_sff_interrupt
Disabling IRQ #3
ks8695_ether ks8695_ether.0: ks8695 ethernet (WAN) MAC: 00:04:d9:80:91:69
ks8695_ether ks8695_ether.1: ks8695 ethernet (LAN) MAC: 00:04:d9:80:91:6a

Any idea how solve the problem? The driver fails on every CF card
compared to 2.6.33, which made problems only by some CF types.

Yegor
