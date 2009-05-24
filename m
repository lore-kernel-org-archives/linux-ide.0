From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [2.6.30-rc7 regression] kernel/async.c broke pata_legacy.c
Date: Sun, 24 May 2009 14:15:26 -0500
Message-ID: <1243192526.2889.26.camel@localhost.localdomain>
References: <18969.29245.610133.834819@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52242 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750818AbZEXTP0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 May 2009 15:15:26 -0400
In-Reply-To: <18969.29245.610133.834819@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, arjan@linux.intel.com

On Sun, 2009-05-24 at 18:13 +0200, Mikael Pettersson wrote:
> I tried booting 2.6.30-rc7 on my old '486, but it fails miserably
> during libata/pata_legacy's device scan:
[...]
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

OK, so the basic problem here is that pata_legacy attaches the host,
sees if it found any devices and detaches it if none were found.  With
async probing, it's not waiting until discovery is finished before
deciding it has no devices and trying the detach ... the warning is
because the detach is racing with the asynchronous probe.

One way to fix it would be to put an async_synchronize_full() before
looking for devices (try the patch below).  A better way might be to
separate libata into its own domain and only wait for that.

James

---

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index f72c6c5..6932e56 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -48,6 +48,7 @@
  *
  */
 
+#include <linux/async.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -1028,6 +1029,7 @@ static __init int legacy_init_one(struct legacy_probe *probe)
 				&legacy_sht);
 	if (ret)
 		goto fail;
+	async_synchronize_full();
 	ld->platform_dev = pdev;
 
 	/* Nothing found means we drop the port as its probably not there */


