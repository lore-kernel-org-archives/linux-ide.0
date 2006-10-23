From: Daniel Drake <dsd@gentoo.org>
Subject: promise-sata-pata crash on boot
Date: Mon, 23 Oct 2006 09:38:44 -0400
Message-ID: <453CC5E4.9020001@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp121.iad.emailsrvr.com ([207.97.245.121]:39630 "EHLO
	smtp121.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1751054AbWJWNjo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Oct 2006 09:39:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, erikbenada@yahoo.ca, caver_sean@ou.edu

Hi Jeff,

I've been including the promise-sata-pata patch in the Gentoo kernel for 
quite a while, taken directly from the git branch. The most recent 
incarnations of this patch have stopped working, causing an oops on 
bootup. This has been reproduced with unmodified 2.6.19-rc2 plus the patch.

Unable to handle kernel NULL pointer dereference at 0
RIP: pdc_sata_scr_read+0x3e

Trace:
sata_scr_read
ata_device_add
process_timeout
pdc_ata_init_one
pci_device_probe
driver_probe_device

http://weather.ou.edu/~sarms/panic3.jpeg

We added the following printk to pdc_sata_scr_read:

         printk("pdc_sata_scr_read ap=%p scr_addr %ld sc_reg %d\n", ap,
		ap->ioaddr.scr_addr, sc_reg);

And the output is:

pdc_sata_src_read ap=ffff8100bfce0498 src_addr -68169720896256 sc_reg 2
pdc_sata_src_read ap=ffff8100bfce0498 src_addr -68169720896256 sc_reg 0
pdc_sata_src_read ap=ffff8100bfce0498 src_addr -68169720896256 sc_reg 0
pdc_sata_src_read ap=ffff8100bfce0498 src_addr -68169720896256 sc_reg 2
pdc_sata_src_read ap=ffff8100bfce0498 src_addr -68169720896256 sc_reg 0
ata2: SATA link down (SStatus 0 SControl 300)
pdc_sata_src_read ap=ffff8100bfce0498 src_addr -68169720896256 sc_reg 0
pdc_sata_src_read ap=ffff8100bfd08498 src_addr 0 sc_reg 2
Unable to handle kernel NULL pointer dereference

See http://weather.ou.edu/~sarms/panic4.jpeg


Bug report is at http://bugs.gentoo.org/148059
Any ideas? Should we file this on the kernel bugzilla?

Thanks!
Daniel
