From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: Re: [PATCH v2 1/3] PATA host controller driver for ep93xx
Date: Thu, 05 Apr 2012 09:52:01 +0200
Message-ID: <4F7D4F21.2060401@metasoft.pl>
References: <4F7B0C54.8010804@metasoft.pl> <4F7C64B8.5000909@metasoft.pl> <4F7C65CE.6000309@metasoft.pl> <201204041523.50872.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:57109 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab2DEHwS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Apr 2012 03:52:18 -0400
In-Reply-To: <201204041523.50872.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, H Hartley Sweeten <hartleys@visionengravers.com>, "bzolnier@gmail.com" <bzolnier@gmail.com>

On 2012-04-04 17:23, Arnd Bergmann wrote:
> On Wednesday 04 April 2012, Rafal Prylowski wrote:
>>>
>>> According to ATA specification, maximum IORDY pulse width is 1250ns,
>>> so I'll set timeout to 2ms (I should check this before posting the driver..).
>>
>> 2ms is far too big value... Should be 2us.
> 
> Ok, in this case, don't use jiffies. I guess it was already flawed because
> jiffies doesn't get updated while you are in an interrupt handler.
> 
> You could use ktime_get to get a high-resolution time stamp to compare to,
> but it depends on how accurate your clocksource is.

Jiffies seem to work. I was wrong with this interrupt handler. Actually
IDE register read/write (and IORDY polling) is called from softirq,
this is only triggered by interrupt. I hope this backtrace confirm this:

BUG: scheduling while atomic: swapper/0/0x40000100
[<c000cb8c>] (unwind_backtrace+0x0/0xf4) from [<c023e1c4>] (__schedule+0x2e0/0x3
30)
[<c023e1c4>] (__schedule+0x2e0/0x330) from [<c0033740>] (__cond_resched+0x24/0x3
4)
[<c0033740>] (__cond_resched+0x24/0x34) from [<c023e2a4>] (_cond_resched+0x38/0x
40)
[<c023e2a4>] (_cond_resched+0x38/0x40) from [<c016d64c>] (ep93xx_pata_wait_for_i
ordy+0x20/0x64)
[<c016d64c>] (ep93xx_pata_wait_for_iordy+0x20/0x64) from [<c016da5c>] (ep93xx_pa
ta_read+0xac/0xb4)
[<c016da5c>] (ep93xx_pata_read+0xac/0xb4) from [<c016daa8>] (ep93xx_pata_check_s
tatus+0x1c/0x28)
[<c016daa8>] (ep93xx_pata_check_status+0x1c/0x28) from [<c016cfa4>] (T.508+0x3c/
0xf0)
[<c016cfa4>] (T.508+0x3c/0xf0) from [<c016d2bc>] (ata_bmdma_qc_issue+0x50/0x19c)
[<c016d2bc>] (ata_bmdma_qc_issue+0x50/0x19c) from [<c015c2ac>] (ata_qc_issue+0x1
98/0x2f8)
[<c015c2ac>] (ata_qc_issue+0x198/0x2f8) from [<c0160c20>] (ata_scsi_translate+0x
98/0x178)
[<c0160c20>] (ata_scsi_translate+0x98/0x178) from [<c0164514>] (ata_scsi_queuecm
d+0x7c/0x230)
[<c0164514>] (ata_scsi_queuecmd+0x7c/0x230) from [<c0149750>] (scsi_dispatch_cmd
+0xd8/0x1b4)
[<c0149750>] (scsi_dispatch_cmd+0xd8/0x1b4) from [<c014ee5c>] (scsi_request_fn+0
x308/0x378)
[<c014ee5c>] (scsi_request_fn+0x308/0x378) from [<c00fb9b4>] (__blk_run_queue+0x
18/0x1c)
[<c00fb9b4>] (__blk_run_queue+0x18/0x1c) from [<c00fb9f4>] (blk_run_queue+0x14/0
x1c)
[<c00fb9f4>] (blk_run_queue+0x14/0x1c) from [<c014e574>] (scsi_run_queue+0xc0/0x
208)
[<c014e574>] (scsi_run_queue+0xc0/0x208) from [<c014f084>] (scsi_next_command+0x
2c/0x38)
[<c014f084>] (scsi_next_command+0x2c/0x38) from [<c014fa54>] (scsi_io_completion
+0x258/0x56c)
[<c014fa54>] (scsi_io_completion+0x258/0x56c) from [<c0102024>] (blk_done_softir
q+0x80/0x98)
[<c0102024>] (blk_done_softirq+0x80/0x98) from [<c0018af8>] (__do_softirq+0x94/0
x150)
[<c0018af8>] (__do_softirq+0x94/0x150) from [<c0018d00>] (irq_exit+0x48/0x50)
[<c0018d00>] (irq_exit+0x48/0x50) from [<c00097c0>] (handle_IRQ+0x34/0x84)
[<c00097c0>] (handle_IRQ+0x34/0x84) from [<c000849c>] (vic_handle_irq+0x94/0xd4)
[<c000849c>] (vic_handle_irq+0x94/0xd4) from [<c0008c14>] (__irq_svc+0x34/0x40)

Sorry for the mess. I'm doing kernel development only occasionally...

I changed msecs_to_jiffies() to usecs_to_jiffies(). Is it possible that
ktime_get() give us better resolution?
Thanks for all hints.

RP
