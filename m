From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH] via82cxxx: fix typo for VT6415 PCIE PATA IDE Host
 Controller support.
Date: Tue, 20 Jul 2010 00:07:37 +0200
Message-ID: <20100719220736.GB3245@home.lan>
References: <1279494644-3762-1-git-send-email-ydirson@altern.org>
 <20100718232838.GA3245@home.lan>
 <20100718.165620.133871819.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:35019 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965985Ab0GSWCj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jul 2010 18:02:39 -0400
Content-Disposition: inline
In-Reply-To: <20100718.165620.133871819.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org

On Sun, Jul 18, 2010 at 04:56:20PM -0700, David Miller wrote:
> From: Yann Dirson <ydirson@free.fr>
> Date: Mon, 19 Jul 2010 01:28:38 +0200
> 
> > On Mon, Jul 19, 2010 at 01:13:24AM +0200, Yann Dirson wrote:
> >> Without this fix, init of the via82cxxx driver causes a oops with a
> >> stack resembling the one below, and the boot blocks between init of
> >> USB devices and launch of init (was easy to bisect by booting with
> >> init=/bin/sh).
> > 
> > Looks like I was a bit too quick - this backtrace is not one of those
> > I got without this fix (they never made it to the disk), but happens
> > with the fix applied.
> 
> The fix is still correct, so I'll leave it in the tree.

OK, so let's hunt the remaining problem.

Indeed I had not taken too much care of the context in the logs - full
excerpt below, unbalanced enable for an IRQ which is shared with other
things (ehci_hcd:usb1, ehci_hcd:usb3, ehci_hcd:usb5, ide0, ide1,
firewire_ohci).  Not sure if that matters, but I recall the oops I got
before correcting the ID typo involved ohci.

OTOH, we see here that the system believes in existence of "ide1",
although the vt6415 appears to be single-channel
(http://www.via.com.tw/en/products/peripherals/pci_pcie/vt6415/)

I'll be adding a couple of printks and retest with frame-pointers, but
in case someone already knows what's going on... :)

 WARNING: at kernel/irq/manage.c:274 enable_irq+0x3e/0x64()
 Hardware name: System Product Name
 Unbalanced enable for IRQ 17
 Modules linked in: usbhid hid sd_mod crc_t10dif ohci_hcd thermal r8169 mii firewire_ohci(+) ahci firewire_core crc_itu_t ehci_hcd libata scsi_mod thermal_sys usbcore nls_base via82cxxx(+) ide_core
 Pid: 279, comm: work_for_cpu Not tainted 2.6.34.1-00003-ga42ea77 #2
 Call Trace:
  [<ffffffff81045691>] ? warn_slowpath_common+0x76/0x8c
  [<ffffffff810456f9>] ? warn_slowpath_fmt+0x40/0x45
  [<ffffffff812eb5a1>] ? printk+0x40/0x47
  [<ffffffff8108e1fd>] ? enable_irq+0x3e/0x64
  [<ffffffffa0003900>] ? ide_probe_port+0x55c/0x589 [ide_core]
  [<ffffffffa0003f22>] ? ide_host_register+0x273/0x628 [ide_core]
  [<ffffffffa00083e3>] ? ide_pci_init_two+0x4da/0x5c5 [ide_core]
  [<ffffffff8106117e>] ? up+0xe/0x36
  [<ffffffff81045d7e>] ? release_console_sem+0x17e/0x1ae
  [<ffffffff812d945b>] ? klist_iter_exit+0x14/0x1e
  [<ffffffff8120ed23>] ? bus_find_device+0x75/0x83
  [<ffffffffa0022832>] ? via_init_one+0x269/0x28a [via82cxxx]
  [<ffffffffa00223a2>] ? init_chipset_via82cxxx+0x0/0x1ea [via82cxxx]
  [<ffffffff81059f25>] ? do_work_for_cpu+0x0/0x1b
  [<ffffffff81190c65>] ? local_pci_probe+0x12/0x16
  [<ffffffff81059f30>] ? do_work_for_cpu+0xb/0x1b
  [<ffffffff8105d0dd>] ? kthread+0x75/0x7d
  [<ffffffff810097e4>] ? kernel_thread_helper+0x4/0x10
  [<ffffffff8105d068>] ? kthread+0x0/0x7d
  [<ffffffff810097e0>] ? kernel_thread_helper+0x0/0x10


