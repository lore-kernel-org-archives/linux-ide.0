From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: prevent EH from being scheduled
 after port is detached
Date: Mon, 20 Aug 2007 21:27:35 +0900
Message-ID: <46C988B7.8030408@gmail.com>
References: <20070820115000.GA2909@htj.dyndns.org> <20070820115356.GB2909@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:19397 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbXHTM1m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Aug 2007 08:27:42 -0400
Received: by rv-out-0910.google.com with SMTP id k20so954220rvb
        for <linux-ide@vger.kernel.org>; Mon, 20 Aug 2007 05:27:42 -0700 (PDT)
In-Reply-To: <20070820115356.GB2909@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> SCSI EH thread is stopped during SCSI host release which can happen
> after ATA host detach and free.  This leads to the following oops.
> 
>   general protection fault: 0000 [1] PREEMPT SMP 
>   CPU 0 
>   Modules linked in: ahci libata
>   Pid: 98, comm: kblockd/0 Not tainted 2.6.23-rc2-work #19
>   RIP: 0010:[<ffffffff80242aa7>]  [<ffffffff80242aa7>] run_workqueue+0xb7/0x190
>   RSP: 0018:ffff81001fd2be80  EFLAGS: 00010087
>   RAX: 6b6b6b6b6b6b6b6b RBX: ffff81001fae4a18 RCX: 1240000000000000
>   RDX: 6b6b6b6b6b6b6b6b RSI: 9200000000000000 RDI: ffff81001fc1b930
>   RBP: ffff81001fd2beb0 R08: fffffffffedc0049 R09: 0000000000000000
>   R10: ffffffff80242a09 R11: 0000000000000000 R12: ffff81001fae4a10
>   R13: ffff81001fc1b930 R14: 6b6b6b6b6b6b6b6b R15: ffff81001fc1b960
>   FS:  0000000000000000(0000) GS:ffffffff808cb000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
>   CR2: 00002b531964d890 CR3: 0000000000201000 CR4: 00000000000006e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
>   Process kblockd/0 (pid: 98, threadinfo ffff81001fd2a000, task ffff81001fe78140)
>   Stack:  ffff81001fd2beb0 ffff81001fc1b970 ffff81001fc1b930 ffff81001fd2bec0
>    ffff81001fc1b960 0000000000000000 ffff81001fd2bf10 ffffffff8024385a
>    0000000000000000 ffff81001fe78140 ffffffff80247450 ffff81001fd2bed8
>   Call Trace:
>    [<ffffffff8024385a>] worker_thread+0xca/0x130
>    [<ffffffff80247450>] autoremove_wake_function+0x0/0x40
>    [<ffffffff80243790>] worker_thread+0x0/0x130
>    [<ffffffff8024706d>] kthread+0x4d/0x80
>    [<ffffffff8020cbf8>] child_rip+0xa/0x12
>    [<ffffffff8020c2e0>] restore_args+0x0/0x30
>    [<ffffffff80247178>] kthreadd+0xd8/0x160
>    [<ffffffff80247020>] kthread+0x0/0x80
>    [<ffffffff8020cbee>] child_rip+0x0/0x12
> 
> This patch clears ATA_PFLAG_RUNNING after final freeze and moves
> ATA_PFLAG_RUNNING check into ata_eh_set_pending() to cover all EH
> schedule functions.

Oops, please hold a bit.  After 30min of testing, it happened again.  It
seems it needs more fixing.  I'll write when I know more.

Thanks.

-- 
tejun
