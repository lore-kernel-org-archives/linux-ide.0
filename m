From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Not able to set DMA mode other than default using hdparm
Date: Mon, 23 Nov 2009 20:44:30 +0300
Message-ID: <4B0AC9FE.1070504@ru.mvista.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B02F6D66E3C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:34171 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753644AbZKWRnj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2009 12:43:39 -0500
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B02F6D66E3C@dbde02.ent.ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Pedanekar, Hemant wrote:

> I am getting following error when trying to set DMA transfer mode as UDMA2 on latest DaVinci (DM6467) git kernel using hdparm (9.27 or older):

> # ./hdparm -d1 -Xudma2  /dev/hda
> /dev/hda:hda: UDMA/66 mode selected
>  setting using_dma to 1 (on)
> hda: UDMA/66 mode selected
>  setting xfermode to 66 (UltraDMA mode2)
>  HDIO_DRIVE_CMD(setxfermode) failed: Invalid argument
>  using_dma     =  1 (on)

> It seems DMA mode setting other than the default mode returns this error. That is, if I use "-Xudma4" in above command it returns success as UDMA4 is the default mode on DM6467.

> I made following change which allows hdparm to set any supported DMA mode. Can anyone confirm if this is a hdparm compatibility (incorrect use of ioctl?) or the patch below indeed fixes the issue?

> diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
> index d3440b5..6e7ae2b 100644
> --- a/drivers/ide/ide-ioctls.c
> +++ b/drivers/ide/ide-ioctls.c
> @@ -162,7 +162,7 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
>         if (tf->command == ATA_CMD_SET_FEATURES &&
>             tf->feature == SETFEATURES_XFER &&
>             tf->nsect >= XFER_SW_DMA_0) {
> -               xfer_rate = ide_find_dma_mode(drive, XFER_UDMA_6);
> +               xfer_rate = ide_find_dma_mode(drive, tf->nsect);
>                 if (xfer_rate != tf->nsect) {
>                         err = -EINVAL;
>                         goto abort;
> 

    Looks like the patch is correct, the following commit has introduced the 
mistake:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a9c415090710a108edcd81b3392b90396f190a9a

    Could you resubmit your patch with proper description and sign-off?

MBR, Sergei
