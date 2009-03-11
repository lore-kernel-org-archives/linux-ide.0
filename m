From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: add support for CFA specified transfer modes (take 3)
Date: Wed, 11 Mar 2009 18:34:01 +0100
Message-ID: <200903111834.01712.bzolnier@gmail.com>
References: <200903102242.58158.sshtylyov@ru.mvista.com> <200903111735.40517.bzolnier@gmail.com> <49B7EFE2.3010806@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:53064 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbZCKReA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 13:34:00 -0400
Received: by ewy25 with SMTP id 25so91797ewy.37
        for <linux-ide@vger.kernel.org>; Wed, 11 Mar 2009 10:33:56 -0700 (PDT)
In-Reply-To: <49B7EFE2.3010806@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, stf_xl@wp.pl

On Wednesday 11 March 2009, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>Add support for the CompactFlash specific PIO modes 5/6 and MWDMA modes 3/4.
> 
> >>Since there were no PIO5 capable hard drives produced and one would also need
> >>66 MHz IDE clock to actually get the difference WRT the address setup timings
> >>programmed, I decided to simply replace the old non-standard PIO mode 5 timings
> >>with the CFA specified ones.
> 
> >>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> >>---
> >>Changes since the previous take:
> >>- added check for CFA modes to 'sl82c105' driver;
> >>- added identify word 163 copying to ide_driveid_update();
> >>- made change based on just posted ide_config_drive_speed() fixlet...
> 
> > applied fixing checkpatch.pl complaint while at it:
> 
> > ERROR: space prohibited after that open parenthesis '('
> > #199: FILE: drivers/ide/sl82c105.c:64:
> > +       if ( (pio > 2 || ata_id_has_iordy(drive->id)) && ]
> 
>     Sigh, that one was done on purpose... :-]
> 
> >>--- linux-2.6.orig/drivers/ide/sl82c105.c
> >>+++ linux-2.6/drivers/ide/sl82c105.c
> >>@@ -61,7 +61,8 @@ static unsigned int get_pio_timings(ide_
> >> 	if (cmd_off == 0)
> >> 		cmd_off = 1;
> >> 
> >>-	if (pio > 2 || ata_id_has_iordy(drive->id))
> >>+	if ( (pio > 2 || ata_id_has_iordy(drive->id)) &&
> >>+	    !(pio > 4 && ata_id_is_cfa(drive->id)))
> >> 		iordy = 0x40;
> 
> > I guess that it would later make sense to abstract this code into
> > ata_id_needs_iordy(id, pio) helper +
> 
>     Er, if we can't reuse libata's stuff, I'd prefer to put this into 

We can't reuse libata's ata_pio_need_iordy() since it resides in
libata-core.c and also checks controller's capabilities.

> <linux/ide.h> as ide_dev_use_iordy()...

Also fine with me, though I see no reason why not to move it to
<linux/ata.h> so libata guys can use it inside ata_pio_need_iordy().

Thanks,
Bart
