From: Prashant <0xfffff0@gmail.com>
Subject: spinlock recursion in scsi_end_request() (kernel 2.6.24)
Date: Mon, 17 May 2010 17:02:39 +0530
Message-ID: <AANLkTilIYz-UITAugWx08u-AvKB5gI-E1M3LORZ55wro@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:36417 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171Ab0EQLck (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2010 07:32:40 -0400
Received: by pxi5 with SMTP id 5so2470346pxi.19
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2010 04:32:40 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,
I have a board with backplane for SATA disks. Sometimes when  I unplug
a disk while
IO is going on, I get following problem. Has anybody of you
experienced this before?
Sometimes spinlock owner is kblockd, sometimes it is scsi_eh.

sd 7:0:0:0: rejecting I/O to offline device
sd 7:0:0:0: rejecting I/O to offline device
sd 7:0:0:0: [sda] Result: hostbyte=0x01 driverbyte=0x00
BUG: spinlock recursion on CPU#0, kblockd/0/54
 lock: cf53a138, .magic: dead4ead, .owner: kblockd/0/54, .owner_cpu: 0
[<c033af90>] (dump_stack+0x0/0x14) from [<c013f710>] (spin_bug+0x90/0xa4)
[<c013f680>] (spin_bug+0x0/0xa4) from [<c013f870>] (_raw_spin_lock+0x50/0x15c)
 r5:20000013 r4:cf53a138
[<c013f820>] (_raw_spin_lock+0x0/0x15c) from [<c029e390>]
(_spin_lock_irqsave+0x2c/0x34)
[<c029e364>] (_spin_lock_irqsave+0x0/0x34) from [<c01c0794>]
(scsi_end_request+0x94/0xdc)
 r5:cfffe3e0 r4:cf539e84
[<c01c0700>] (scsi_end_request+0x0/0xdc) from [<c01c0d10>]
(scsi_io_completion+0x314/0x330)
 r8:00000000 r7:cf539e84 r6:00010000 r5:cfffe3e0 r4:00000000
[<c01c09fc>] (scsi_io_completion+0x0/0x330) from [<c01bb744>]
(scsi_finish_command+0x84/0x88)
[<c01bb6c0>] (scsi_finish_command+0x0/0x88) from [<c01c1394>]
(scsi_softirq_done+0xbc/0x114)
 r6:cfffe3e0 r5:00000005 r4:00000bb8
[<c01c12d8>] (scsi_softirq_done+0x0/0x114) from [<c01282a0>]
(blk_done_softirq+0x7c/0x9c)
 r7:c0373760 r6:0000000a r5:00000001 r4:cfcafcd0
[<c0128224>] (blk_done_softirq+0x0/0x9c) from [<c0053f58>]
(__do_softirq+0x64/0xd0)
 r4:c03737bc
[<c0053ef4>] (__do_softirq+0x0/0xd0) from [<c005406c>] (do_softirq+0x4c/0x68)


Thanks,
prashant
