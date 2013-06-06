From: Yu Liu <liuyu.ac@gmail.com>
Subject: AHCI bug?: a lockup in ahci_interrupt with fbs enabled pmp
Date: Thu, 6 Jun 2013 14:31:20 +0800
Message-ID: <CAASYz_QzjJdiXk6xGq4T-k20F_cQ7Vg60YtpP4irH8sLdgrM0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f68.google.com ([209.85.128.68]:46344 "EHLO
	mail-qe0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969Ab3FFGbV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jun 2013 02:31:21 -0400
Received: by mail-qe0-f68.google.com with SMTP id 6so441226qeb.3
        for <linux-ide@vger.kernel.org>; Wed, 05 Jun 2013 23:31:20 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

I met a lockup while I was running IO test on disks connected
with an fbs enabled pmp board and an ahci host.

looks like the reason for the lockup is as below:
    ahci_interrert()
        | spin_lock(&host->lock);        // get host->lock
        | ahci_port_intr()
            | ahci_error_intr()                // status & PORT_IRQ_ERROR
                | ata_link_online()           // if fbs_enabled
                    | sata_scr_read()
                        | sata_pmp_scr_read()    // using pmp
                            |ata_exec_internal()
                                | ata_exec_internal_sg()
                                    | spin_lock_irqsave(ap->lock, flags);
since ap->lock == &host->lock,
these two spin_lock get conflict

Did I miss anything? Can someone confirm the issue?

my dump info is listed below:
---
RIP: 0010:[<ffffffff814c867f>]  [<ffffffff814c867f>]
_spin_lock_irqsave+0x2f/0x40
RSP: 0000:ffff880001e43c38  EFLAGS: 00000097
RAX: 000000000000b685 RBX: ffff88007654de48 RCX: 000000000000b684
RDX: 0000000000000082 RSI: ffff880001e43d88 RDI: ffff88007930c158
RBP: ffff880001e43c38 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000001ff8 R11: 0000000000000246 R12: ffff88007654c000
R13: ffff88007654de48 R14: ffff88007654dce0 R15: 0000000000000000
FS:  00007fc12e0eb700(0000) GS:ffff880001e40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007f3b55311cc1 CR3: 0000000078f7a000 CR4: 00000000000026e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process gzip (pid: 15126, threadinfo ffff880067a86000, task ffff880037d02a70)
Stack:
 ffff880001e43ce8 ffffffff813558f7 ffff880000000003 0000000000000000
<0> ffffffff81328537 ffff880001e43cc0 000000008134743b ffff880001e43cc0
<0> e4ffffff81262545 ffff880001e43d88 0000000000000000 ffff880001e43cc0
Call Trace:
 <IRQ>
 [<ffffffff813558f7>] ata_exec_internal_sg+0x67/0x570
 [<ffffffff81328537>] ? put_device+0x17/0x20
 [<ffffffff81355e79>] ata_exec_internal+0x79/0xb0
 [<ffffffff8134699f>] ? scsi_run_queue+0xcf/0x380
 [<ffffffff813406c0>] ? __scsi_put_command+0x60/0xa0
 [<ffffffff8136740f>] sata_pmp_read+0x7f/0xb0
 [<ffffffff8101adf5>] ? native_sched_clock+0x15/0x70
 [<ffffffff81367505>] sata_pmp_scr_read+0x35/0xb0
 [<ffffffff81353096>] sata_scr_read+0x26/0x60
 [<ffffffff81353708>] ata_phys_link_online+0x18/0x30
 [<ffffffff81353750>] ata_link_online+0x30/0x70
 [<ffffffffa066b964>] ahci_interrupt+0x684/0x790 [ahci]
 [<ffffffff810d7750>] handle_IRQ_event+0x60/0x170
 [<ffffffff81073983>] ? __do_softirq+0x113/0x1d0
 [<ffffffff810d9e46>] handle_edge_irq+0xc6/0x160
 [<ffffffff81015fb9>] handle_irq+0x49/0xa0
 [<ffffffff814cd62c>] do_IRQ+0x6c/0xf0
 [<ffffffff81013ad3>] ret_from_intr+0x0/0x11
 <EOI>


Thanks,
Yu
