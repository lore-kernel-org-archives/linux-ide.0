From: Danny Cox <Danny.Cox@ECWeb.com>
Subject: Re: [PATCH] atapi request sense work
Date: Fri, 21 May 2004 14:23:16 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085163796.833.61.camel@vom>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com>
	 <1085153750.6103.33.camel@patibmrh9>
	 <200405211746.35015.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blackbox.ecweb.com ([199.72.99.40]:45574 "EHLO
	blackbox.ecweb.com") by vger.kernel.org with ESMTP id S265970AbUEUSUo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 14:20:44 -0400
In-Reply-To: <200405211746.35015.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

Bartlomiej,

On Fri, 2004-05-21 at 11:46, Bartlomiej Zolnierkiewicz wrote:
> Keep posting... seconded.
> 
> I'm also reading this and linux-ide needs more traffic/people. ;-)

	Okay, here's some more ;-).

	I've been lurking up to this point, but I've attached a patch that
fixes something that's been an irritation to me for awhile now (at least
two years plus).

	It's especially relevant now too, with the i386 4K stack in place.  In
ide.c, ide_unregister(), old_hwif is allocated on the stack.  The little
sucker is over 1K all by itself!  So, I've modified the code to use
kmalloc().

	It may not be right, but I'd still like to see some form of it used. 
I'm still a newbie, so please don't flame me to a crisp if I've
committed a grave sin.  Thanks!

----------------------------------------------------------
--- drivers/ide/ide.c.old	2004-05-11 08:00:25.000000000 -0400
+++ drivers/ide/ide.c	2004-05-21 14:04:44.904273325 -0400
@@ -615,11 +615,15 @@
 	ide_hwif_t *hwif, *g;
 	ide_hwgroup_t *hwgroup;
 	int irq_count = 0, unit, i;
-	ide_hwif_t old_hwif;
+	ide_hwif_t *old_hwif = NULL;
 
 	if (index >= MAX_HWIFS)
 		BUG();
 		
+	old_hwif = kmalloc(sizeof (*old_hwif), GFP_KERNEL);
+	if (old_hwif == NULL)
+		goto abort;
+
 	BUG_ON(in_interrupt());
 	BUG_ON(irqs_disabled());
 	down(&ide_cfg_sem);
@@ -765,120 +769,123 @@
 		hwif->dma_prdtable = 0;
 	}
 
-	old_hwif			= *hwif;
+
+	*old_hwif			= *hwif;
 
 	init_hwif_data(hwif, index);	/* restore hwif data to pristine status */
 	init_hwif_default(hwif, index);
 
-	hwif->hwgroup			= old_hwif.hwgroup;
+	hwif->hwgroup			= old_hwif->hwgroup;
 
-	hwif->gendev.parent		= old_hwif.gendev.parent;
+	hwif->gendev.parent		= old_hwif->gendev.parent;
 
-	hwif->proc			= old_hwif.proc;
+	hwif->proc			= old_hwif->proc;
 
-	hwif->major			= old_hwif.major;
-//	hwif->index			= old_hwif.index;
-//	hwif->channel			= old_hwif.channel;
-	hwif->straight8			= old_hwif.straight8;
-	hwif->bus_state			= old_hwif.bus_state;
+	hwif->major			= old_hwif->major;
+//	hwif->index			= old_hwif->index;
+//	hwif->channel			= old_hwif->channel;
+	hwif->straight8			= old_hwif->straight8;
+	hwif->bus_state			= old_hwif->bus_state;
 
-	hwif->atapi_dma			= old_hwif.atapi_dma;
-	hwif->ultra_mask		= old_hwif.ultra_mask;
-	hwif->mwdma_mask		= old_hwif.mwdma_mask;
-	hwif->swdma_mask		= old_hwif.swdma_mask;
+	hwif->atapi_dma			= old_hwif->atapi_dma;
+	hwif->ultra_mask		= old_hwif->ultra_mask;
+	hwif->mwdma_mask		= old_hwif->mwdma_mask;
+	hwif->swdma_mask		= old_hwif->swdma_mask;
 
-	hwif->chipset			= old_hwif.chipset;
-	hwif->hold			= old_hwif.hold;
+	hwif->chipset			= old_hwif->chipset;
+	hwif->hold			= old_hwif->hold;
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
-	hwif->pci_dev			= old_hwif.pci_dev;
-	hwif->cds			= old_hwif.cds;
+	hwif->pci_dev			= old_hwif->pci_dev;
+	hwif->cds			= old_hwif->cds;
 #endif /* CONFIG_BLK_DEV_IDEPCI */
 
 #if 0
-	hwif->hwifops			= old_hwif.hwifops;
+	hwif->hwifops			= old_hwif->hwifops;
 #else
-	hwif->identify			= old_hwif.identify;
-	hwif->tuneproc			= old_hwif.tuneproc;
-	hwif->speedproc			= old_hwif.speedproc;
-	hwif->selectproc		= old_hwif.selectproc;
-	hwif->reset_poll		= old_hwif.reset_poll;
-	hwif->pre_reset			= old_hwif.pre_reset;
-	hwif->resetproc			= old_hwif.resetproc;
-	hwif->intrproc			= old_hwif.intrproc;
-	hwif->maskproc			= old_hwif.maskproc;
-	hwif->quirkproc			= old_hwif.quirkproc;
-	hwif->busproc			= old_hwif.busproc;
+	hwif->identify			= old_hwif->identify;
+	hwif->tuneproc			= old_hwif->tuneproc;
+	hwif->speedproc			= old_hwif->speedproc;
+	hwif->selectproc		= old_hwif->selectproc;
+	hwif->reset_poll		= old_hwif->reset_poll;
+	hwif->pre_reset			= old_hwif->pre_reset;
+	hwif->resetproc			= old_hwif->resetproc;
+	hwif->intrproc			= old_hwif->intrproc;
+	hwif->maskproc			= old_hwif->maskproc;
+	hwif->quirkproc			= old_hwif->quirkproc;
+	hwif->busproc			= old_hwif->busproc;
 #endif
 
 #if 0
-	hwif->pioops			= old_hwif.pioops;
+	hwif->pioops			= old_hwif->pioops;
 #else
-	hwif->ata_input_data		= old_hwif.ata_input_data;
-	hwif->ata_output_data		= old_hwif.ata_output_data;
-	hwif->atapi_input_bytes		= old_hwif.atapi_input_bytes;
-	hwif->atapi_output_bytes	= old_hwif.atapi_output_bytes;
+	hwif->ata_input_data		= old_hwif->ata_input_data;
+	hwif->ata_output_data		= old_hwif->ata_output_data;
+	hwif->atapi_input_bytes		= old_hwif->atapi_input_bytes;
+	hwif->atapi_output_bytes	= old_hwif->atapi_output_bytes;
 #endif
 
 #if 0
-	hwif->dmaops			= old_hwif.dmaops;
+	hwif->dmaops			= old_hwif->dmaops;
 #else
-	hwif->ide_dma_read		= old_hwif.ide_dma_read;
-	hwif->ide_dma_write		= old_hwif.ide_dma_write;
-	hwif->ide_dma_begin		= old_hwif.ide_dma_begin;
-	hwif->ide_dma_end		= old_hwif.ide_dma_end;
-	hwif->ide_dma_check		= old_hwif.ide_dma_check;
-	hwif->ide_dma_on		= old_hwif.ide_dma_on;
-	hwif->ide_dma_off_quietly	= old_hwif.ide_dma_off_quietly;
-	hwif->ide_dma_test_irq		= old_hwif.ide_dma_test_irq;
-	hwif->ide_dma_host_on		= old_hwif.ide_dma_host_on;
-	hwif->ide_dma_host_off		= old_hwif.ide_dma_host_off;
-	hwif->ide_dma_verbose		= old_hwif.ide_dma_verbose;
-	hwif->ide_dma_lostirq		= old_hwif.ide_dma_lostirq;
-	hwif->ide_dma_timeout		= old_hwif.ide_dma_timeout;
+	hwif->ide_dma_read		= old_hwif->ide_dma_read;
+	hwif->ide_dma_write		= old_hwif->ide_dma_write;
+	hwif->ide_dma_begin		= old_hwif->ide_dma_begin;
+	hwif->ide_dma_end		= old_hwif->ide_dma_end;
+	hwif->ide_dma_check		= old_hwif->ide_dma_check;
+	hwif->ide_dma_on		= old_hwif->ide_dma_on;
+	hwif->ide_dma_off_quietly	= old_hwif->ide_dma_off_quietly;
+	hwif->ide_dma_test_irq		= old_hwif->ide_dma_test_irq;
+	hwif->ide_dma_host_on		= old_hwif->ide_dma_host_on;
+	hwif->ide_dma_host_off		= old_hwif->ide_dma_host_off;
+	hwif->ide_dma_verbose		= old_hwif->ide_dma_verbose;
+	hwif->ide_dma_lostirq		= old_hwif->ide_dma_lostirq;
+	hwif->ide_dma_timeout		= old_hwif->ide_dma_timeout;
 #endif
 
 #if 0
-	hwif->iops			= old_hwif.iops;
+	hwif->iops			= old_hwif->iops;
 #else
-	hwif->OUTB		= old_hwif.OUTB;
-	hwif->OUTBSYNC		= old_hwif.OUTBSYNC;
-	hwif->OUTW		= old_hwif.OUTW;
-	hwif->OUTL		= old_hwif.OUTL;
-	hwif->OUTSW		= old_hwif.OUTSW;
-	hwif->OUTSL		= old_hwif.OUTSL;
-
-	hwif->INB		= old_hwif.INB;
-	hwif->INW		= old_hwif.INW;
-	hwif->INL		= old_hwif.INL;
-	hwif->INSW		= old_hwif.INSW;
-	hwif->INSL		= old_hwif.INSL;
-#endif
-
-	hwif->mmio			= old_hwif.mmio;
-	hwif->rqsize			= old_hwif.rqsize;
-	hwif->no_lba48			= old_hwif.no_lba48;
+	hwif->OUTB		= old_hwif->OUTB;
+	hwif->OUTBSYNC		= old_hwif->OUTBSYNC;
+	hwif->OUTW		= old_hwif->OUTW;
+	hwif->OUTL		= old_hwif->OUTL;
+	hwif->OUTSW		= old_hwif->OUTSW;
+	hwif->OUTSL		= old_hwif->OUTSL;
+
+	hwif->INB		= old_hwif->INB;
+	hwif->INW		= old_hwif->INW;
+	hwif->INL		= old_hwif->INL;
+	hwif->INSW		= old_hwif->INSW;
+	hwif->INSL		= old_hwif->INSL;
+#endif
+
+	hwif->mmio			= old_hwif->mmio;
+	hwif->rqsize			= old_hwif->rqsize;
+	hwif->no_lba48			= old_hwif->no_lba48;
 #ifndef CONFIG_BLK_DEV_IDECS
-	hwif->irq			= old_hwif.irq;
+	hwif->irq			= old_hwif->irq;
 #endif /* CONFIG_BLK_DEV_IDECS */
 
-	hwif->dma_base			= old_hwif.dma_base;
-	hwif->dma_master		= old_hwif.dma_master;
-	hwif->dma_command		= old_hwif.dma_command;
-	hwif->dma_vendor1		= old_hwif.dma_vendor1;
-	hwif->dma_status		= old_hwif.dma_status;
-	hwif->dma_vendor3		= old_hwif.dma_vendor3;
-	hwif->dma_prdtable		= old_hwif.dma_prdtable;
-
-	hwif->dma_extra			= old_hwif.dma_extra;
-	hwif->config_data		= old_hwif.config_data;
-	hwif->select_data		= old_hwif.select_data;
-	hwif->autodma			= old_hwif.autodma;
-	hwif->udma_four			= old_hwif.udma_four;
-	hwif->no_dsc			= old_hwif.no_dsc;
+	hwif->dma_base			= old_hwif->dma_base;
+	hwif->dma_master		= old_hwif->dma_master;
+	hwif->dma_command		= old_hwif->dma_command;
+	hwif->dma_vendor1		= old_hwif->dma_vendor1;
+	hwif->dma_status		= old_hwif->dma_status;
+	hwif->dma_vendor3		= old_hwif->dma_vendor3;
+	hwif->dma_prdtable		= old_hwif->dma_prdtable;
+
+	hwif->dma_extra			= old_hwif->dma_extra;
+	hwif->config_data		= old_hwif->config_data;
+	hwif->select_data		= old_hwif->select_data;
+	hwif->autodma			= old_hwif->autodma;
+	hwif->udma_four			= old_hwif->udma_four;
+	hwif->no_dsc			= old_hwif->no_dsc;
 
-	hwif->hwif_data			= old_hwif.hwif_data;
+	hwif->hwif_data			= old_hwif->hwif_data;
 abort:
+	if (old_hwif)
+		kfree(old_hwif);
 	spin_unlock_irq(&ide_lock);
 	up(&ide_cfg_sem);
 }

-- 
Daniel S. Cox
Electronic Commerce Systems

