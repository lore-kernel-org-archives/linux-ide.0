From: Ben Collins <bcollins@debian.org>
Subject: Re: IDE corruption datapoint
Date: Wed, 16 Jul 2003 10:28:13 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030716142813.GJ685@phunnypharm.org>
References: <20030716042020.780126b9.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bristol.phunnypharm.org ([65.207.35.130]:15558 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S270859AbTGPOO3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Jul 2003 10:14:29 -0400
Content-Disposition: inline
In-Reply-To: <20030716042020.780126b9.davem@redhat.com>
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@redhat.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, alan@redhat.com, linux-ide@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 16, 2003 at 04:20:20AM -0700, David S. Miller wrote:
> 
> FWIW, just like my alim5x3 based Sparcs, I have to boot with ide=nodma
> on my VAIO laptop which uses PIIX chipsets, otherwise I get data
> corruptions.

Let's not forget this patch, which has allowed me to run 2.4.21 and
2.4.22-pre's with DMA enabled on my sb100 (alim5x3) without corruption.


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="3-ali-ide-dma-fix.diff"

On Tue, May 27, 2003 at 02:31:52PM +0200, Willy Tarreau wrote:
> Sorry, I pasted the .config that I used just after, and which allowed me to
> boot. Later I set CONFIG_BLK_DEV_ALI15X3 again and CONFIG_BLK_DEV_IDEDMA_PCI,
> but I left CONFIG_IDEDMA_PCI_AUTO disabled. I now can boot and enable DMA
> later. That's weird, but it works.

Perhaps not that weird. From my experience, ALi DMA is sensitive to
some of "PIO timings". That is, if SRM hasn't initialized the chipset
properly (on Nautilus it has, BTW), DMA won't work. When you boot with
DMA disabled, driver has to set right PIO mode, so you can safely
enable DMA later.

Can you (and Jason) try this patch with CONFIG_IDEDMA_PCI_AUTO=y?

Ivan.

--- linux/drivers/ide/pci/alim15x3.c.orig	Tue Apr 22 19:17:22 2003
+++ linux/drivers/ide/pci/alim15x3.c	Tue May 27 17:42:17 2003
@@ -525,10 +525,14 @@ static int ali15x3_config_drive_for_dma(
 
 	drive->init_speed = 0;
 
+	/* Set reasonable PIO timings first - some of them are needed
+	   for DMA as well. */
+	hwif->tuneproc(drive, 255);
+
 	if ((id->capability & 1) != 0 && drive->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (hwif->ide_dma_bad_drive(drive))
-			goto ata_pio;
+			goto no_dma_set;
 		if ((id->field_valid & 4) && (m5229_revision >= 0xC2)) {
 			if (id->dma_ultra & hwif->ultra_mask) {
 				/* Force if Capable UltraDMA */
@@ -550,11 +554,9 @@ try_dma_modes:
 			if (!config_chipset_for_dma(drive))
 				goto no_dma_set;
 		} else {
-			goto ata_pio;
+			goto no_dma_set;
 		}
 	} else {
-ata_pio:
-		hwif->tuneproc(drive, 255);
 no_dma_set:
 		return hwif->ide_dma_off_quietly(drive);
 	}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--2oS5YaxWCcQjTEyO--
