From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Not able to set DMA mode other than default using hdparm
Date: Mon, 23 Nov 2009 19:10:03 +0100
Message-ID: <200911231910.03383.bzolnier@gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B02F6D66E3C@dbde02.ent.ti.com> <4B0AC9FE.1070504@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:57918 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbZKWSKz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2009 13:10:55 -0500
Received: by ewy19 with SMTP id 19so2116598ewy.21
        for <linux-ide@vger.kernel.org>; Mon, 23 Nov 2009 10:11:00 -0800 (PST)
In-Reply-To: <4B0AC9FE.1070504@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "Pedanekar, Hemant" <hemantp@ti.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>

On Monday 23 November 2009 06:44:30 pm Sergei Shtylyov wrote:
> Pedanekar, Hemant wrote:
> 
> > I am getting following error when trying to set DMA transfer mode as UDMA2 on latest DaVinci (DM6467) git kernel using hdparm (9.27 or older):
> 
> > # ./hdparm -d1 -Xudma2  /dev/hda
> > /dev/hda:hda: UDMA/66 mode selected
> >  setting using_dma to 1 (on)
> > hda: UDMA/66 mode selected
> >  setting xfermode to 66 (UltraDMA mode2)
> >  HDIO_DRIVE_CMD(setxfermode) failed: Invalid argument
> >  using_dma     =  1 (on)
> 
> > It seems DMA mode setting other than the default mode returns this error. That is, if I use "-Xudma4" in above command it returns success as UDMA4 is the default mode on DM6467.
> 
> > I made following change which allows hdparm to set any supported DMA mode. Can anyone confirm if this is a hdparm compatibility (incorrect use of ioctl?) or the patch below indeed fixes the issue?
> 
> > diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
> > index d3440b5..6e7ae2b 100644
> > --- a/drivers/ide/ide-ioctls.c
> > +++ b/drivers/ide/ide-ioctls.c
> > @@ -162,7 +162,7 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
> >         if (tf->command == ATA_CMD_SET_FEATURES &&
> >             tf->feature == SETFEATURES_XFER &&
> >             tf->nsect >= XFER_SW_DMA_0) {
> > -               xfer_rate = ide_find_dma_mode(drive, XFER_UDMA_6);
> > +               xfer_rate = ide_find_dma_mode(drive, tf->nsect);
> >                 if (xfer_rate != tf->nsect) {
> >                         err = -EINVAL;
> >                         goto abort;
> > 
> 
>     Looks like the patch is correct, the following commit has introduced the 
> mistake:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a9c415090710a108edcd81b3392b90396f190a9a

Indeed, there is a thinko in the above commit and the patch corrects it.

>     Could you resubmit your patch with proper description and sign-off?

You may also add:

	Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

while at it:

Thanks.
--
Bartlomiej Zolnierkiewicz
