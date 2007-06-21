From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/5] ide: add short cables support
Date: Thu, 21 Jun 2007 21:38:23 +0200
Message-ID: <200706212138.23623.bzolnier@gmail.com>
References: <200706101558.08990.bzolnier@gmail.com> <200706160140.28380.bzolnier@gmail.com> <467569BD.9070506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:61196 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbXFUTnu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jun 2007 15:43:50 -0400
Received: by ug-out-1314.google.com with SMTP id j3so650982ugf
        for <linux-ide@vger.kernel.org>; Thu, 21 Jun 2007 12:43:49 -0700 (PDT)
In-Reply-To: <467569BD.9070506@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 17 June 2007, Sergei Shtylyov wrote:

[ ... ]

> >>>Index: b/drivers/ide/pci/alim15x3.c
> >>>===================================================================
> >>>--- a/drivers/ide/pci/alim15x3.c
> >>>+++ b/drivers/ide/pci/alim15x3.c
> >>>@@ -594,7 +594,7 @@ out:
> >>>  *	FIXME: frobs bits that are not defined on newer ALi devicea
> >>>  */
> >>> 
> >>>-static unsigned int __devinit ata66_ali15x3 (ide_hwif_t *hwif)
> >>>+static u8 __devinit ata66_ali15x3(ide_hwif_t *hwif)
> >>> {
> >>> 	struct pci_dev *dev	= hwif->pci_dev;
> >>> 	unsigned int ata66	= 0;
> >>>@@ -657,7 +657,7 @@ static unsigned int __devinit ata66_ali1
> >>> 
> >>> 	local_irq_restore(flags);
> >>> 
> >>>-	return(ata66);
> >>>+	return ata66 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
> 
> >>    Ahem... I'd think it was about the right time to fix the abomination which
> >>those ata66 and cable_80_pin[2] are, something like this:
> 
> >>static unsigned int __devinit ata66_ali15x3 (ide_hwif_t *hwif)
> >>{
> >>         struct pci_dev *dev     = hwif->pci_dev;
> >>         unsigned int cbl        = ATA_CBL_PATA40;
> >>         unsigned long flags;
> >>         u8 tmpbyte, mask	= hwif->channel ? 0x02 : 0x01;
> >>
> >>         local_irq_save(flags); /* Not sure if it's necessary... */
> >>
> >>         if (m5229_revision >= 0xC2) {
> >>                 /*
> >>                  * Ultra66 cable detection (from Host View)
> >>                  * m5229, 0x4a, bit0: primary, bit1: secondary
> >>		 * 0: 80 pin, 1: 40 pin
> >>                  */
> >>                 pci_read_config_byte(dev, 0x4a, &tmpbyte);
> >>                 /*
> >>                  * Allow ata66 if cable of current channel has 80 pins
> >>                  */
> >>                 cbl = (tmpbyte & mask) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
> >>         } else {
> 
> >>[Following code frankly speaking has no business being in this function]
> 
> > patch #3/5 already takes care of cable_80_pin[2] part,
> 
>     I really should have looked thru all the series but lacked the time. :-<
> 
> > ata66 part was left as an exercise for the reader ;-)
> 
>     Hm, now that I've looked at that patch I saw both these things killed.
> What, you don't know your own code? ;-)

It seems that I indeed dealt with ata66 part already... :-)

However I had something different in mind while writing about code gymnastics
- code unrelated to cable detection should be split off from ata66_ali15x3. 

Thanks,
Bart
