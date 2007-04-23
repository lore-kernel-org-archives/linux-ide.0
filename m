From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 14/15] ide: rework the code for selecting the best DMA transfer mode
Date: Tue, 24 Apr 2007 00:25:06 +0200
Message-ID: <200704240025.06119.bzolnier@gmail.com>
References: <20070203135301.2546.54884.sendpatchset@localhost.localdomain> <4628D64B.7080500@ru.mvista.com> <4628FFBB.2090900@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:64844 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409AbXDWWaY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 18:30:24 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1727946wra
        for <linux-ide@vger.kernel.org>; Mon, 23 Apr 2007 15:30:23 -0700 (PDT)
In-Reply-To: <4628FFBB.2090900@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Friday 20 April 2007, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >>>> Index: b/drivers/ide/pci/hpt366.c
> >>>> ===================================================================
> >>>> --- a/drivers/ide/pci/hpt366.c
> >>>> +++ b/drivers/ide/pci/hpt366.c
> >>>> @@ -513,43 +513,31 @@ static int check_in_drive_list(ide_drive
> >>>>      return 0;
> >>>>  }
> >>>>  
> >>>> -static u8 hpt3xx_ratemask(ide_drive_t *drive)
> >>>> -{
> >>>> -    struct hpt_info *info    = pci_get_drvdata(HWIF(drive)->pci_dev);
> >>>> -    u8 mode            = info->max_mode;
> >>>> -
> >>>> -    if (!eighty_ninty_three(drive) && mode)
> >>>> -        mode = min(mode, (u8)1);
> >>>> -    return mode;
> >>>> -}
> >>>> -
> >>>>  /*
> >>>>   *    Note for the future; the SATA hpt37x we must set
> >>>>   *    either PIO or UDMA modes 0,4,5
> >>>>   */
> >>>> - -static u8 hpt3xx_ratefilter(ide_drive_t *drive, u8 speed)
> >>>> +
> >>>> +static u8 hpt3xx_udma_filter(ide_drive_t *drive)
> >>>>  {
> >>>>      struct hpt_info *info    = pci_get_drvdata(HWIF(drive)->pci_dev);
> >>>>      u8 chip_type        = info->chip_type;
> >>>> -    u8 mode            = hpt3xx_ratemask(drive);
> >>>> -
> >>>> -    if (drive->media != ide_disk)
> >>>> -        return min(speed, (u8)XFER_PIO_4);
> >>>> +    u8 mode            = info->max_mode;
> >>>> +    u8 mask;
> >>>>  
> >>>>      switch (mode) {
> >>>>          case 0x04:
> >>>> -            speed = min_t(u8, speed, XFER_UDMA_6);
> >>>> +            mask = 0x7f;
> >>>>              break;
> >>>>          case 0x03:
> >>>> -            speed = min_t(u8, speed, XFER_UDMA_5);
> >>>> +            mask = 0x3f;
> >>>>              if (chip_type >= HPT374)
> >>>>                  break;
> >>>>              if (!check_in_drive_list(drive, bad_ata100_5))
> >>>>                  goto check_bad_ata33;
> >>>>              /* fall thru */
> >>>>          case 0x02:
> >>>> -            speed = min_t(u8, speed, XFER_UDMA_4);
> >>>> +            mask = 0x1f;
> >>>>  
> >>>>              /*
> >>>>               * CHECK ME, Does this need to be changed to HPT374 ??
> >>>> @@ -560,13 +548,13 @@ static u8 hpt3xx_ratefilter(ide_drive_t 
> >>>>                  !check_in_drive_list(drive, bad_ata66_4))
> >>>>                  goto check_bad_ata33;
> >>>>  
> >>>> -            speed = min_t(u8, speed, XFER_UDMA_3);
> 
>   Hm, found a buglet in my former filtering rewrite -- the condition in the preceding if stmt should be a reverse one, and speed limitation to XFER_UDMA_3 should have been left under it.  With the current code, XFER_UDMA_2 limitation wouldn't have been applied if the same drive is not in both 'bad_ata66_4' and 'bad_ata66_3' lists -- this, however, actually is not the case since WDC AC310200R drive is in both these lists (maybe I wrote it this way because of this fact :-).

IIRC I've noticed this during the review of the filtering rewrite
but I though that it was meant to be this way. :)

> >>>> +            mask = 0x0f;
> >>>>              if (HPT366_ALLOW_ATA66_3 &&
> >>>>                  !check_in_drive_list(drive, bad_ata66_3))
> >>>>                  goto check_bad_ata33;
> >>>>              /* fall thru */
> >>>>          case 0x01:
> >>>> -            speed = min_t(u8, speed, XFER_UDMA_2);
> >>>> +            mask = 0x07;
> >>>>  
> >>>>          check_bad_ata33:
> >>>>              if (chip_type >= HPT370A)
> 
> >>>   This case 0x01 will *never* be hit for HPT370 chip with the new 
> >>> code, therefore the filter won't get applied.
> 
> >>   Oh, and for HPT36x chips used with 40c cable too (unless they're 
> >> artificaially reduced to UltraDMA/33 by the driver #define's).
> 
> >   It will still get applied since the code always resorts to looking up 
> > the 'bad_ata33' list for HPT36x/370.
> > I've got a bit muddled in my own code -- not sure if it got much clearer 
> > after I'd untangled hpt3xx_ratemask() / hpt3xx_ratefilter() puzzle. :-)
> 
>   Yeah, I'm definitely having trouble understanding my own code after some months have passed... :-/

The filtering code badly needs more comments/documentation
and it was already true for the old code (before your rewrite).

Bart
