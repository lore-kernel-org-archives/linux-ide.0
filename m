From: Prashant Bhole <prashantsmailcenter@gmail.com>
Subject: BUG: spinlock recursion on CPU#0, kblockd/0/54
Date: Tue, 9 Feb 2010 14:44:08 +0530
Message-ID: <9ff69a5d1002090114o302b426fi9efc005e15e859b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:24440 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab0BIJOJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Feb 2010 04:14:09 -0500
Received: by qw-out-2122.google.com with SMTP id 9so827855qwb.37
        for <linux-ide@vger.kernel.org>; Tue, 09 Feb 2010 01:14:08 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,
I am using linux kernel 2.6.24, I get following crash when I unplug a SATA
disk while I/O is going on:

BUG: spinlock recursion on CPU#0, kblockd/0/54
 lock: cffab908, .magic: dead4ead, .owner: kblockd/0/54, .owner_cpu: 0
[<c0315234>] (dump_stack+0x0/0x14) from [<c013a01c>] (spin_bug+0x90/0xa4)
[<c0139f8c>] (spin_bug+0x0/0xa4) from [<c013a17c>] (_raw_spin_lock+0x50/0x15c)
 r5:cffacc00 r4:cffab908
[<c013a12c>] (_raw_spin_lock+0x0/0x15c) from [<c0290f48>] (_spin_lock+0x20/0x24)
[<c0290f28>] (_spin_lock+0x0/0x24) from [<c01b08a8>]
(scsi_device_unbusy+0x7c/0x9c)
 r4:cff81c00
[<c01b082c>] (scsi_device_unbusy+0x0/0x9c) from [<c01a9f7c>]
(scsi_finish_command+0x20/0xc4)
 r6:cffacc00 r5:cffa4620 r4:cff81c00
[<c01a9f5c>] (scsi_finish_command+0x0/0xc4) from [<c01b0a54>]
(scsi_softirq_done+0xd8/0x12c)
 r6:cffa4620 r5:00000005 r4:00000bb8
[<c01b097c>] (scsi_softirq_done+0x0/0x12c) from [<c0123d24>]
(blk_done_softirq+0x7c/0x9c)
[<c0123ca8>] (blk_done_softirq+0x0/0x9c) from [<c0052e3c>]
(__do_softirq+0x64/0xd0)
 r4:c033b8dc
[<c0052dd8>] (__do_softirq+0x0/0xd0) from [<c0052f50>] (do_softirq+0x4c/0x68)
[<c0052f04>] (do_softirq+0x0/0x68) from [<c00530f4>]
(local_bh_enable_ip+0x48/0x70


Can anybody please tell me the reason behind this crash? Is this a
known problem?
I found this http://lkml.indiana.edu/hypermail/linux/kernel/0610.3/index.html#1632
mail thread,
which is similar to this problem.
Please help.

Thanks,

--
~p~r~a~s~h~a~n~t~
