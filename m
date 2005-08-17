From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH] add correct device link to ide-cs
Date: Wed, 17 Aug 2005 15:20:59 +0200
Message-ID: <430339BB.1010503@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040804070806020201040209"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:64206 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751123AbVHQNVB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2005 09:21:01 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E188F7FC
	for <linux-ide@vger.kernel.org>; Wed, 17 Aug 2005 15:20:59 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040804070806020201040209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jens,

the ide-cs driver does not create the correct device link; instead of
being connected to the appropriate PCMCIA slot it just sits und
/sys/devices. Clearly unsatisfactory.

To fix I've added a field 'dev' to include/linux/ide.h:hw_regs_t.
This is being passed over as the 'gendev.parent' link for hwif, thus
allowing us to set the device link even for non-PCI devices.

I think it's a quite sensible approach, but it's probably not for me to
decide.

Comments etc welcome.
Otherwise, please apply.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstra=DFe 5				+49 911 74053 688
90409 N=FCrnberg				http://www.suse.de

--------------040804070806020201040209
Content-Type: text/plain;
 name="ide-cs-correct-device-link"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-cs-correct-device-link"

From: Hannes Reinecke <hare@suse.de>
Subject: Incorrect device link for ide-cs

Devices driven by ide-cs will appear under /sys/devices instead of the
appropriate PCMCIA device. To fix this I had to extend the hw_regs_t
structure with a 'struct device' field, which allows us to set the
parent link for the appropriate hwif.

Signed-off-by: Hannes Reinecke <hare@suse.de>

diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -803,6 +803,7 @@ found:
 	hwif->irq = hw->irq;
 	hwif->noprobe = 0;
 	hwif->chipset = hw->chipset;
+	hwif->gendev.parent = hw->dev;
 
 	if (!initializing) {
 		probe_hwif_init_with_fixup(hwif, fixup);
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -182,13 +182,14 @@ static void ide_detach(dev_link_t *link)
     
 } /* ide_detach */
 
-static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq)
+static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq, struct pcmcia_device *handle)
 {
     hw_regs_t hw;
     memset(&hw, 0, sizeof(hw));
-    ide_init_hwif_ports(&hw, io, ctl, NULL);
+    ide_std_init_ports(&hw, io, ctl);
     hw.irq = irq;
     hw.chipset = ide_pci;
+    hw.dev = &handle->dev;
     return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);
 }
 
@@ -328,12 +329,12 @@ static void ide_config(dev_link_t *link)
 
     /* retry registration in case device is still spinning up */
     for (hd = -1, i = 0; i < 10; i++) {
-	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ);
+	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ, handle);
 	if (hd >= 0) break;
 	if (link->io.NumPorts1 == 0x20) {
 	    outb(0x02, ctl_base + 0x10);
 	    hd = idecs_register(io_base + 0x10, ctl_base + 0x10,
-				link->irq.AssignedIRQ);
+				link->irq.AssignedIRQ, handle);
 	    if (hd >= 0) {
 		io_base += 0x10;
 		ctl_base += 0x10;
diff --git a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -230,6 +230,7 @@ typedef struct hw_regs_s {
 	int		dma;			/* our dma entry */
 	ide_ack_intr_t	*ack_intr;		/* acknowledge interrupt */
 	hwif_chipset_t  chipset;
+	struct device	*dev;
 } hw_regs_t;
 
 /*

--------------040804070806020201040209--
