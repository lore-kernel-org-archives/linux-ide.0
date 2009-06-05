From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH bug fix 13378] pata_legacy: wait for async probing
Date: Fri, 5 Jun 2009 17:04:43 +0200
Message-ID: <18985.13323.190252.350912@pilspetsen.it.uu.se>
References: <1244212899.3922.8.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:47938 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbZFEPFt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Jun 2009 11:05:49 -0400
In-Reply-To: <1244212899.3922.8.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>, Mikael Pettersson <mikpe@it.uu.se>

James Bottomley writes:
 > The basic problem here that pata_legacy attaches the host, sees if it found
 > any devices and detaches it if none were found.  With async probing, it's not
 > waiting until discovery is finished before deciding it has no devices and
 > trying the detach leading to this warning:
 > 
 > ata1: PATA max PIO4 cmd 0x1f0 ctl 0x3f6 irq 14
 > ------------[ cut here ]------------
 > WARNING: at drivers/ata/libata-core.c:6222 ata_host_detach+0x75/0x90()
 > Modules linked in:
 > Pid: 1, comm: swapper Not tainted 2.6.30-rc7 #1
 > Call Trace:
 >  [<c01fbb05>] ? ata_host_detach+0x75/0x90
 >  [<c01fbb05>] ? ata_host_detach+0x75/0x90
 >  [<c01139b5>] ? warn_slowpath_common+0x45/0x80
 >  [<c01139fa>] ? warn_slowpath_null+0xa/0x10
 >  [<c01fbb05>] ? ata_host_detach+0x75/0x90
 >  [<c02f40e0>] ? legacy_init+0x44e/0x87f
 >  [<c02f3c92>] ? legacy_init+0x0/0x87f
 >  [<c0101021>] ? _stext+0x21/0x140
 >  [<c01890ff>] ? proc_register+0x2f/0x190
 >  [<c018938c>] ? create_proc_entry+0x5c/0xc0
 >  [<c0135ebe>] ? register_irq_proc+0x6e/0x90
 >  [<c02e6484>] ? kernel_init+0x6e/0xbf
 >  [<c02e6416>] ? kernel_init+0x0/0xbf
 >  [<c01031d7>] ? kernel_thread_helper+0x7/0x10
 > ---[ end trace ef1ee36e873ae3a0 ]---
 > 
 > Because it detaches before the probe is complete.
 > 
 > One way to fix it would be to put an async_synchronize_full() before looking
 > for devices, which this patch does.  A better way might be to separate libata
 > into its own domain and only wait for that.

It's not apparent from this description, but the bug is worse
than some warnings from the kernel: the kernel hangs hard.

 > 
 > Reported-by: Mikael Pettersson <mikpe@it.uu.se>
 > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

and
Tested-by: Mikael Pettersson <mikpe@it.uu.se>

 > 
 > 
 > ---
 > 
 > Index: linux-2.6/drivers/ata/pata_legacy.c
 > ===================================================================
 > --- linux-2.6.orig/drivers/ata/pata_legacy.c
 > +++ linux-2.6/drivers/ata/pata_legacy.c
 > @@ -48,6 +48,7 @@
 >   *
 >   */
 >  
 > +#include <linux/async.h>
 >  #include <linux/kernel.h>
 >  #include <linux/module.h>
 >  #include <linux/pci.h>
 > @@ -1028,6 +1029,7 @@ static __init int legacy_init_one(struct
 >  				&legacy_sht);
 >  	if (ret)
 >  		goto fail;
 > +	async_synchronize_full();
 >  	ld->platform_dev = pdev;
 >  
 >  	/* Nothing found means we drop the port as its probably not there */
 > 
