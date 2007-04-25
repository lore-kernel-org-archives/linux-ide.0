From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.21-rc7-mm1 BUG at kernel/sched-clock.c:175 init_sched_clock()
Date: Wed, 25 Apr 2007 17:42:41 +0900
Message-ID: <462F1481.8010807@gmail.com>
References: <462E4C4D.9020806@gmail.com> <20070425011654.222a2b4b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423307AbXDYImt@vger.kernel.org>
In-Reply-To: <20070425011654.222a2b4b.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Berck E. Nash" <flyboy@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Andrew Morton wrote:
>> [    2.953862] RIP: 0010:[<ffffffff803ae98b>]  [<ffffffff803ae98b>] scsi_schedule_eh+0xa/0x57
>> [    3.058672]  [<ffffffff803e1e01>] ata_port_schedule_eh+0x4c/0x50
>> [    3.064725]  [<ffffffff803e1ea7>] ata_port_abort+0xa2/0xae
>> [    3.070248]  [<ffffffff803e1ef9>] ata_port_freeze+0x46/0x57
>> [    3.075853]  [<ffffffff803e4c39>] ahci_interrupt+0x300/0x47a
>> [    3.081552]  [<ffffffff8020eb83>] handle_IRQ_event+0x27/0x57
>> [    3.087253]  [<ffffffff8029a021>] handle_edge_irq+0xee/0x133
>> [    3.092960]  [<ffffffff8025f4e1>] do_IRQ+0x6d/0xd5
>> [    3.097793]  [<ffffffff80255071>] ret_from_intr+0x0/0xa
>> [    3.103059]  [<ffffffff8024e88b>] mwait_idle+0x46/0x4b
>> [    3.108231]  [<ffffffff802422f4>] cpu_idle+0x87/0xaa
>> [    3.113227]  [<ffffffff8025c988>] rest_init+0x49/0x4b
>> [    3.118322]  [<ffffffff805dca5d>] start_kernel+0x291/0x29c
>> [    3.123837]  [<ffffffff805dc13a>] _sinittext+0x13a/0x141
>>
> 
> So we took an AHCI interrupt when ata_port.scsi_host was still NULL.
> 
> It appears that ATA is presently requesting its IRQ before allocating all
> the resources which are needed to handle an interrupt.  Does this
> (resource-leaky) patch fix things?

No, that would break host probing.  The port is in frozen (controller
initialized and IRQs masked off) state, so it's not allowed to take
interrupt.  If interrupt triggers at this point, it's low level driver
bug.  Berck, how reliably can you reproduce this problem?  Can you post
the result of 'lspci -nn'?

-- 
tejun
