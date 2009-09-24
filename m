From: Frans Pop <elendil@planet.nl>
Subject: Re: 2.6.{30,31} x86_64 ahci problem - irq 23: nobody cared
Date: Thu, 24 Sep 2009 21:24:40 +0200
Message-ID: <200909242124.42187.elendil@planet.nl>
References: <4ABBB8C2.2080901@sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753833AbZIXTYn@vger.kernel.org>
In-reply-To: <4ABBB8C2.2080901@sbg.ac.at>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Huemer <alexander.huemer@sbg.ac.at>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Adding linux-ide to CC.

Alexander Huemer wrote:
> the problem appears under heavy system load and slows down the system to
> unusable speed.
> kernels before .30 were not affected.
> irqpoll does not change behavior.
> 
> error message from .31:
>  [157152.418524] irq 23: nobody cared (try booting with the "irqpoll" option)
>  [157152.418530] Pid: 1359, comm: cc1plus Tainted: G        W  2.6.31-gentoo-blackbit #2
>  [157152.418532] Call Trace:
>  [157152.418534]  <IRQ>  [<ffffffff81066e3f>] ?  __report_bad_irq+0x30/0x7d
>  [157152.418544]  [<ffffffff81066f93>] ? note_interrupt+0x107/0x170
>  [157152.418547]  [<ffffffff81067580>] ? handle_fasteoi_irq+0x8a/0xaa
>  [157152.418551]  [<ffffffff8100d1cf>] ? handle_irq+0x17/0x1d
>  [157152.418554]  [<ffffffff8100c84b>] ? do_IRQ+0x54/0xb2
>  [157152.418558]  [<ffffffff8100b6d3>] ? ret_from_intr+0x0/0xa
>  [157152.418559]  <EOI>
>  [157152.418560] handlers:
>  [157152.418562] [<ffffffff813d2a6f>] (ahci_interrupt+0x0/0x426)
>  [157152.418566] Disabling IRQ #23
>
> bios of the machine is up to date,
> i tried all related bios settings, no change.
> 
> kernel config for .31   http://xx.vu/~ahuemer/config_ahuemer_20090923.gz
> lspci -vxxx             http://xx.vu/~ahuemer/lspci_ahuemer_20090923
> lsusb -v                http://xx.vu/~ahuemer/lsusb_ahuemer_20090923
> /proc/interrupts        http://xx.vu/~ahuemer/proc_interrupts_ahuemer_20090923
> thread in gentoo forums http://forums.gentoo.org/viewtopic-t-780725-start-0.html
> 
> please tell me what additional info is needed.

A full dmesg (or kernel log) starting from a clean boot up to the error
could be useful.

If no others reply and the issue can be reproduced reliably, running a
git bisect between v2.6.29 and v2.6.30 to trace the cause of the regression
could be an option.

Cheers,
FJP
