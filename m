From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 7/15] pcmcia: Make ide_cs work with the memory space of CF-Cards if IO space is not available
Date: Fri, 30 Jun 2006 21:56:57 +0200
Message-ID: <20060630195657.GH9095@dominikbrodowski.de>
References: <20060630195107.GA9095@dominikbrodowski.de> <20060630195217.GB9095@dominikbrodowski.de> <20060630195255.GC9095@dominikbrodowski.de> <20060630195358.GD9095@dominikbrodowski.de> <20060630195439.GE9095@dominikbrodowski.de> <20060630195501.GF9095@dominikbrodowski.de> <20060630195600.GG9095@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:34747 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1750841AbWF3UMk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2006 16:12:40 -0400
Content-Disposition: inline
In-Reply-To: <20060630195600.GG9095@dominikbrodowski.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl



From: Thomas Kleffel <tk@maintech.de>
Date: Sun, 14 May 2006 15:16:30 +0200
Subject: [PATCH] pcmcia: Make ide_cs work with the memory space of CF-Cards if IO space is not available

This patch enables ide_cs to access CF-cards via their common memory
rather than via their IO space.

Signed-off-by: Thomas Kleffel <tk@maintech.de>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/ide/legacy/ide-cs.c |   81 ++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
index 602797a..b7e459e 100644
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -146,7 +146,16 @@ static void ide_detach(struct pcmcia_dev
     kfree(link->priv);
 } /* ide_detach */
 
-static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq, struct pcmcia_device *handle)
+static void idecs_mmio_fixup(ide_hwif_t *hwif)
+{
+	default_hwif_mmiops(hwif);
+	hwif->mmio = 2;
+
+	ide_undecoded_slave(hwif);
+}
+
+static int idecs_register(unsigned long io, unsigned long ctl,
+	unsigned long irq, struct pcmcia_device *handle, int is_mmio)
 {
     hw_regs_t hw;
     memset(&hw, 0, sizeof(hw));
@@ -154,7 +163,19 @@ static int idecs_register(unsigned long 
     hw.irq = irq;
     hw.chipset = ide_pci;
     hw.dev = &handle->dev;
-    return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);
+
+    if(is_mmio)
+    	return ide_register_hw_with_fixup(&hw, NULL, idecs_mmio_fixup);
+    else
+        return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);
+}
+
+void outb_io(unsigned char value, unsigned long port) {
+	outb(value, port);
+}
+
+void outb_mem(unsigned char value, unsigned long port) {
+	writeb(value, (void __iomem *) port);
 }
 
 /*======================================================================
@@ -180,7 +201,8 @@ static int ide_config(struct pcmcia_devi
     } *stk = NULL;
     cistpl_cftable_entry_t *cfg;
     int i, pass, last_ret = 0, last_fn = 0, hd, is_kme = 0;
-    unsigned long io_base, ctl_base;
+    unsigned long io_base, ctl_base, is_mmio, try_slave;
+    void (*my_outb)(unsigned char, unsigned long);
 
     DEBUG(0, "ide_config(0x%p)\n", link);
 
@@ -210,7 +232,7 @@ static int ide_config(struct pcmcia_devi
     /* Not sure if this is right... look up the current Vcc */
     CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(link, &stk->conf));
 
-    pass = io_base = ctl_base = 0;
+    pass = io_base = ctl_base = is_mmio = try_slave = 0;
     tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
     tuple.Attributes = 0;
     CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(link, &tuple));
@@ -258,11 +280,45 @@ static int ide_config(struct pcmcia_devi
 			goto next_entry;
 		io_base = link->io.BasePort1;
 		ctl_base = link->io.BasePort1 + 0x0e;
+
+		if (io->win[0].len >= 0x20)
+			try_slave = 1;
+
 	    } else goto next_entry;
 	    /* If we've got this far, we're done */
 	    break;
 	}
 
+	if ((cfg->mem.nwin > 0) || (stk->dflt.mem.nwin > 0)) {
+	    win_req_t req;
+	    memreq_t map;
+	    cistpl_mem_t *mem = (cfg->mem.nwin) ? &cfg->mem : &stk->dflt.mem;
+
+	    if (mem->win[0].len < 16)
+	    	goto next_entry;
+
+	    req.Attributes = WIN_DATA_WIDTH_16|WIN_MEMORY_TYPE_CM;
+	    req.Attributes |= WIN_ENABLE;
+	    req.Base = mem->win[0].host_addr;
+	    req.Size = 0;
+
+	    req.AccessSpeed = 0;
+	    if (pcmcia_request_window(&link, &req, &link->win) != 0)
+		goto next_entry;
+	    map.Page = 0; map.CardOffset = mem->win[0].card_addr;
+	    if (pcmcia_map_mem_page(link->win, &map) != 0)
+		goto next_entry;
+
+      	    io_base = (unsigned long) ioremap(req.Base, req.Size);
+    	    ctl_base = io_base + 0x0e;
+    	    is_mmio = 1;
+
+    	    if (mem->win[0].len >= 0x20)
+    	    	try_slave = 1;
+
+	    break;
+	}
+
     next_entry:
 	if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
 	    memcpy(&stk->dflt, cfg, sizeof(stk->dflt));
@@ -278,21 +334,26 @@ static int ide_config(struct pcmcia_devi
     CS_CHECK(RequestIRQ, pcmcia_request_irq(link, &link->irq));
     CS_CHECK(RequestConfiguration, pcmcia_request_configuration(link, &link->conf));
 
+    if(is_mmio)
+    	my_outb = outb_mem;
+    else
+    	my_outb = outb_io;
+
     /* disable drive interrupts during IDE probe */
-    outb(0x02, ctl_base);
+    my_outb(0x02, ctl_base);
 
     /* special setup for KXLC005 card */
     if (is_kme)
-	outb(0x81, ctl_base+1);
+	my_outb(0x81, ctl_base+1);
 
     /* retry registration in case device is still spinning up */
     for (hd = -1, i = 0; i < 10; i++) {
-	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ, link);
+	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ, link, is_mmio);
 	if (hd >= 0) break;
-	if (link->io.NumPorts1 == 0x20) {
-	    outb(0x02, ctl_base + 0x10);
+	if (try_slave) {
+	    my_outb(0x02, ctl_base + 0x10);
 	    hd = idecs_register(io_base + 0x10, ctl_base + 0x10,
-				link->irq.AssignedIRQ, link);
+				link->irq.AssignedIRQ, link, is_mmio);
 	    if (hd >= 0) {
 		io_base += 0x10;
 		ctl_base += 0x10;
-- 
1.4.0

