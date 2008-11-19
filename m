From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Suspend w/ sata_promise
Date: Wed, 19 Nov 2008 09:15:29 +0100
Message-ID: <18723.52001.559166.255589@harpo.it.uu.se>
References: <49202CB0.60507@gc-web.de>
	<18720.18615.938839.921189@harpo.it.uu.se>
	<492060D9.20808@gc-web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:56637 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbYKSIPf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Nov 2008 03:15:35 -0500
In-Reply-To: <492060D9.20808@gc-web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Clausen <alex@gc-web.de>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Alexander Clausen writes:
 > Mikael Pettersson wrote:
 > > Do you have anything connected to that mobo's VIA SATA ports? If not,
 > > you could move the disk(s) from the Promise controller to the VIA
 > > controller just to see how the machine behaves over repeated suspend/resume
 > > cycles. (I'm not suggesting you move the disks permanently, this would
 > > just be a data gathering experiment.)
 > 
 > It works fine (~5 cycles tested) with the PCI (non-onboard) controller (VIA VT6421).
 > Of course I'm still interested in getting suspend to work with the promise chip, so I don't
 > have to waste money on the addon card (the one used in testing is just borrowed)

Based on several other libata sata drivers I think handling suspend in
sata_promise may be as simple as hooking ata_pci_device_{suspend,resume},
which is what the patch below does. If this doesn't work then the most
likely solution is to augment the ->resume op with a Promise-specific
controller reset (again similar to several other sata drivers).

Care to give it a try? The patch is against 2.6.28-rc5 but should also
work in 2.6.27.

/Mikael

diff -rupN linux-2.6.28-rc5/drivers/ata/sata_promise.c linux-2.6.28-rc5.sata_promise-suspend-v1/drivers/ata/sata_promise.c
--- linux-2.6.28-rc5/drivers/ata/sata_promise.c	2008-11-18 09:13:29.000000000 +0100
+++ linux-2.6.28-rc5.sata_promise-suspend-v1/drivers/ata/sata_promise.c	2008-11-18 22:47:46.000000000 +0100
@@ -308,6 +308,10 @@ static struct pci_driver pdc_ata_pci_dri
 	.id_table		= pdc_ata_pci_tbl,
 	.probe			= pdc_ata_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
+#endif
 };
 
 static int pdc_common_port_start(struct ata_port *ap)
