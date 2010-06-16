From: Tejun Heo <tj@kernel.org>
Subject: Re: Very slow disk speed after "IRQ: nobody cared"
Date: Wed, 16 Jun 2010 13:51:24 +0200
Message-ID: <4C18BABC.8090301@kernel.org>
References: <20100615092818.GF1635@myhost.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52724 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754168Ab0FPLv0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Jun 2010 07:51:26 -0400
In-Reply-To: <20100615092818.GF1635@myhost.felk.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

(cc'ing linux-ide)

On 06/15/2010 11:28 AM, Michal Svoboda wrote:
> Hello list,
> 
> Sometimes I get a 'nobody cared' message such as this
> 
> [  202.078556] irq 16: nobody cared (try booting with the "irqpoll" option)
> [  202.078561] Pid: 0, comm: swapper Not tainted 2.6.33 #1
> [  202.078563] Call Trace:
> [  202.078565]  <IRQ>  [<ffffffff8106ef16>] __report_bad_irq+0x26/0xa0
> [  202.078574]  [<ffffffff8106f11a>] note_interrupt+0x18a/0x1d0
> [  202.078578]  [<ffffffff8106da0a>] ? handle_IRQ_event+0x4a/0xf0
> [  202.078582]  [<ffffffff8106fe3d>] handle_fasteoi_irq+0xcd/0x100
> [  202.078587]  [<ffffffff810055dd>] handle_irq+0x1d/0x30
> [  202.078590]  [<ffffffff81005257>] do_IRQ+0x67/0xf0
> [  202.078595]  [<ffffffff81414493>] ret_from_intr+0x0/0xa
> [  202.078597]  <EOI>  [<ffffffff81211b48>] ? acpi_idle_enter_bm+0x224/0x24d
> [  202.078606]  [<ffffffff81211b3e>] ? acpi_idle_enter_bm+0x21a/0x24d
> [  202.078611]  [<ffffffff8131c72b>] cpuidle_idle_call+0x9b/0x100
> [  202.078615]  [<ffffffff8100099c>] cpu_idle+0x9c/0xf0
> [  202.078618]  [<ffffffff81003290>] ? kernel_thread_helper+0x0/0x10
> [  202.078624]  [<ffffffff813fd9bf>] rest_init+0x8f/0xa0
> [  202.078628]  [<ffffffff815ceb31>] start_kernel+0x322/0x32d
> [  202.078632]  [<ffffffff815ce2e7>] x86_64_start_reservations+0xf7/0xfb
> [  202.078636]  [<ffffffff815ce3d3>] x86_64_start_kernel+0xe8/0xef
> [  202.078638] handlers:
> [  202.078639] [<ffffffff812af0e0>] (mpt_interrupt+0x0/0x990)
> [  202.078645] [<ffffffff812d6ed0>] (usb_hcd_irq+0x0/0x70)
> [  202.078649] Disabling IRQ #16
> 
> And then my disks go turtle speed:
> /dev/sda:
>  Timing cached reads:   9180 MB in  2.00 seconds = 4591.89 MB/sec
>  Timing buffered disk reads:    8 MB in  3.20 seconds =   2.50 MB/sec
> 
> IRQ 16 seems to have something to do with disks:
> [   19.703064] scsi6 : ioc0: LSISAS1068E B3, FwRev=00192f00h, Ports=1,
> MaxQ=266, IRQ=16
> 	    CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
> 	    CPU6       CPU7       
>   16:     200124          0          0          0          0          0
>                0          0   IO-APIC-fasteoi   ioc0, uhci_hcd:usb3
> 
> Is the performance drop caused by the 'disabling IRQ'?  And why would
> the 'nobody cared' message be printed in the first place (it happens
> only sometimes)? And is there a way out of this (ie. enabling the IRQ)
> besides rebooting?

Can you please post full boot log?  Also, can you give a shot at the
following git tree?

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git lost-spurious-irq

Thanks.

-- 
tejun
