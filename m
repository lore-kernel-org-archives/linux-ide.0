From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] BIOS SATA legacy mode failure
Date: Mon, 09 Sep 2013 22:01:06 -0600
Message-ID: <522E9982.2060504@gmail.com>
References: <522C1AC5.4080105@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:60812 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab3IJEBK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Sep 2013 00:01:10 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so7484747oag.12
        for <linux-ide@vger.kernel.org>; Mon, 09 Sep 2013 21:01:09 -0700 (PDT)
In-Reply-To: <522C1AC5.4080105@linux.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: levex@linux.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On 09/08/2013 12:35 AM, Levente Kurusa wrote:
> Hi,
>
> I have been testing the Linux Kernel on a two year Toshiba NB100
> netbook of mine, however when I enabled SATA compatibility/legacy mode
> instead of AHCI mode in the BIOS, the kernel got stuck. I have pasted
> the relevant dmesg piece along with a patch that fixes it temporarily.
> What I suspect to be the cause is that the BIOS sets the device into
> IDE mode, but it will report it as a SATA device and hence libata tries
> to send ATA commands to it, which obviously makes it go bad. The patch

No, the commands are the same whichever mode the controller is in. The 
problem is presumably something else, like maybe some kind of interrupt 
routing problem when the controller is in legacy mode.

> fixes it, by adding a new field to ata_device called exce_cnt, which
> counts how many exceptions have occured. After three exceptions, it
> automatically disables the device. Also, please note this is my first
> ever patch for the kernel :-)
>
> The following dmesg is stuck in an infinite loop.
> dmesg:
> ata3: lost interrupt (Status 0x50)
> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata3.00: failed command: READ DMA
> ata3.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
>                res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: status: { DRDY }
> ata3: soft resetting link
> ata3.00: configured for UDMA/33 (no error)
> ata3.00: device reported invalid CHS sector 0
> ata3: EH complete
>
> Patch that fixes the infinite loop:
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index f9476fb..eeedf80 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2437,6 +2437,14 @@ static void ata_eh_link_report(struct ata_link
> *link)
>                              ehc->i.action, frozen, tries_buf);
>                  if (desc)
>                          ata_dev_err(ehc->i.dev, "%s\n", desc);
> +               ehc->i.dev->exce_cnt ++;
> +               ata_dev_warn(ehc->i.dev, "Number of exceptions: %d\n",
> ehc->i.dev->exce_cnt);
> +               /**
> +                  * The device is failing terribly,
> +                 * disable it to prevent damage.
> +                 */
> +               if(ehc->i.dev->exce_cnt > 2)
> +                       ata_dev_disable(ehc->i.dev);
>          } else {
>                  ata_link_err(link, "exception Emask 0x%x "
>                               "SAct 0x%x SErr 0x%x action 0x%x%s%s\n",
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index eae7a05..fa52ee6 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -660,7 +660,8 @@ struct ata_device {
>          u8                      devslp_timing[ATA_LOG_DEVSLP_SIZE];
>
>          /* error history */
> -       int                     spdn_cnt;
> +       int                     spdn_cnt; /* Number of speed_downs */
> +       int                     exce_cnt; /* Number of exceptions that
> happenned */
>          /* ering is CLEAR_END, read comment above CLEAR_END */
>          struct ata_ering        ering;
>   };
>

This doesn't seem like a very good fix. It may prevent the apparent 
infinite loop but will just prevent that device from functioning at all. 
It would be better if we could figure out what was actually going wrong.

