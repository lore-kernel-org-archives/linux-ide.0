From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] ide: add support for CFA specified transfer modes
Date: Sun, 8 Mar 2009 17:38:01 +0100
Message-ID: <200903081738.01959.bzolnier@gmail.com>
References: <200903032034.49372.sshtylyov@ru.mvista.com> <200903071723.26150.bzolnier@gmail.com> <49B2A5C1.8090409@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:51540 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbZCHQl4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Mar 2009 12:41:56 -0400
Received: by fxm24 with SMTP id 24so964801fxm.37
        for <linux-ide@vger.kernel.org>; Sun, 08 Mar 2009 09:41:53 -0700 (PDT)
In-Reply-To: <49B2A5C1.8090409@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, stf_xl@wp.pl

On Saturday 07 March 2009, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>Add support for the CompactFlash specific PIO modes 5/6 and MWDMA modes 3/4.
> 
> > Thanks for picking this up.
> 
> >>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> >>---
> >>This patch is against the current pata-2.6 series. Since there were no PIO5
> >>capable hard drives produced and you also need 66 MHz input clock to actually
> >>get the difference WRT the setup timing programmed, I decided to simply replace
> >>the old non-standard PIO mode 5 timings with CFA specified ones.
> >>Phew, hopefully I haven't overlooked anything -- quite a lot had to be changed.
> 
> > It looks fine overall, few comments below.
> 
> >>@@ -389,6 +389,8 @@ int ide_config_drive_speed(ide_drive_t *
> >> 	id[ATA_ID_UDMA_MODES]  &= ~0xFF00;
> >> 	id[ATA_ID_MWDMA_MODES] &= ~0x0F00;
> >> 	id[ATA_ID_SWDMA_MODES] &= ~0x0F00;
> >>+	if (ata_id_is_cfa(id))
> >>+		id[ATA_ID_CFA_MODES] &= ~0x0F30;
> 
> > Shouldn't the mask be ~0x0FC0 here?
> 
>     Oops, indeed. :-<
> 
> >>@@ -90,6 +93,10 @@ u16 ide_pio_cycle_time(ide_drive_t *driv
> >> 		/* conservative "downgrade" for all pre-ATA2 drives */
> >> 		if (pio < 3 && cycle < t->cycle)
> >> 			cycle = 0; /* use standard timing */
> >>+
> >>+		/* IORDY must be ignored for CF specific PIO modes */
> >>+		if (pio > 4 && ata_id_is_cfa(id))
> >>+			cycle = 0; /* use standard timing */
> 
> > This comment seems out of place for the code dealing with cycle timing.
> 
> > When it comes to IORDY I recalled that some host drivers already support
> > "harddisk" PIO5 so they may need to be updated to not force IORDY setting
> > (seems like at least sl82c105.c is affected).
> 
>     I thought I have taken care of this with the generic code... the need for 
> the driver-level CF specific changes looks iffy as not all these drivers ever 

Theoretically all drivers can drive CF devices using IDE-CF adapters so we
shouldn't be making any such assumptions.  There are also some interesting
hardware designs, i.e. Vortex 86SX SoC which uses ITE 8211 chipset for IDE
(embedded x86 devices using this SoC are often equipped with CF slot).

> drive CF. I need to think about it... won't be the part of this patch in any case.

The problem is that <linux/ata.h> lacks ata_id_needs_iordy(id, pio) so
drivers are using ata_id_has_iordy() which doesn't know about CF specific
needs, i.e. sl82c105.c does:

        if (pio > 2 || ata_id_has_iordy(drive->id))
                iordy = 0x40;

and since the driver declares PIO5 support once this patch gets applied
PIO5 will be used also for CF devices.

Thanks,
Bart
