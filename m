From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] atiixp: missing parentheses?
Date: Tue, 17 Feb 2009 16:10:11 +0100
Message-ID: <200902171610.11528.bzolnier@gmail.com>
References: <499AB75F.6060709@gmail.com> <499AC8E2.60406@ru.mvista.com> <499AC92D.50108@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:41653 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbZBQPJo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Feb 2009 10:09:44 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1131539mue.1
        for <linux-ide@vger.kernel.org>; Tue, 17 Feb 2009 07:09:42 -0800 (PST)
In-Reply-To: <499AC92D.50108@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Roel Kluin <roel.kluin@gmail.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tuesday 17 February 2009, Sergei Shtylyov wrote:
> I wrote:
> 
> >> This looks odd, is below what was intended? note that timing_shift can
> >> only be 16, 8 or 0. Maybe intended was 24, 16, 8 or 0? then we should do:
> 
> >    Looking at the libata driver, yes, it should be 0, 8, 16, and 24.
> 
> >> int timing_shift = ((drive->dn & 2) ? 16 : 0) + ((drive->dn & 1) ? 0 : 
> >> 8);
> >> --------------------------->8-------------8<------------------------------ 
> >>
> >> Add missing parentheses
> > 
> > 
> >> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> > 
> > 
> >> diff --git a/drivers/ide/atiixp.c b/drivers/ide/atiixp.c
> >> index b2735d2..b7813ec 100644
> >> --- a/drivers/ide/atiixp.c
> >> +++ b/drivers/ide/atiixp.c
> >> @@ -52,7 +52,7 @@ static void atiixp_set_pio_mode(ide_drive_t *drive, 
> >> const u8 pio)
> >>  {
> >>      struct pci_dev *dev = to_pci_dev(drive->hwif->dev);
> >>      unsigned long flags;
> >> -    int timing_shift = (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 
> >> : 8;
> >> +    int timing_shift = (drive->dn & 2) ? 16 : 0 + ((drive->dn & 1) ? 
> >> 0 : 8);
> >>      u32 pio_timing_data;
> >>      u16 pio_mode_data;
> >>  
> >> @@ -85,7 +85,7 @@ static void atiixp_set_dma_mode(ide_drive_t *drive, 
> >> const u8 speed)
> >>  {
> >>      struct pci_dev *dev = to_pci_dev(drive->hwif->dev);
> >>      unsigned long flags;
> >> -    int timing_shift = (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 
> >> : 8;
> >> +    int timing_shift = (drive->dn & 2) ? 16 : 0 + ((drive->dn & 1) ? 
> >> 0 : 8);
> >>      u32 tmp32;
> >>      u16 tmp16;
> >>      u16 udma_ctl = 0;
> > 
> > 
> >    Why didn't you add parens around the first ?: then? They are surely 
> > needed. Though this clearly needs to be simplified to (drive->dn * 8).
> 
>     Oh, actually, timing_shift = (drive->dn ^ 1) * 8.

Yes, this way we'll get the correct:

8 0 24 16

instead of the current

8 0 16 16

[ Luckily after DMA timings gets programmed for the third device to
  offset 16 they get overwritten with DMA timings for fourth device.

  Since BIOS should program DMA timings for the third device all
  should work fine till suspend/resume... ] 

Roel, please fix the patch and resubmit.

Thanks,
Bart
