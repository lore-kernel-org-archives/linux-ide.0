From: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: Re: [PATCH] libata: don't whine if ->prereset() returns -ENOENT
Date: Mon, 12 Mar 2007 21:14:03 +0100
Message-ID: <b637ec0b0703121314o747ef0bdl5c9f580b456bae43@mail.gmail.com>
References: <20070309163148.GA12848@havoc.gtf.org>
	 <b637ec0b0703091324q7f15fddbpc8c24b4e1131e3f4@mail.gmail.com>
	 <20070309234839.2070a265@lxorguk.ukuu.org.uk>
	 <45F50E28.7010509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:31579 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbXCLUOE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 16:14:04 -0400
Received: by an-out-0708.google.com with SMTP id b33so1589354ana
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 13:14:03 -0700 (PDT)
In-Reply-To: <45F50E28.7010509@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>

Applied on top of latest GIT this patch make the warning[1] disappear.
Thanks,
Fabio

[1] ata2: reset failed, giving up

On 3/12/07, Tejun Heo <htejun@gmail.com> wrote:
> ->prereset() returns -ENOENT to tell libata that the port is empty and
> reset sequencing should be stopped.  This is not an error condition.
> Update ata_eh_reset() such that it sets device classes to ATA_DEV_NONE
> and return success in on -ENOENT.  This makes spurious error message
> go away.
>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>
> This should do it and better fits the intention of the return value.
> Two things to note.
>
> 1. I think these ports should be made dummy instead of returning
> -ENOENT on prereset().  -ENOENT from prereset() was a hack to keep
> ata_piix's behavior unchanged while converting it to new EH.  If no
> one objcts, I'll convert similar usages to use dummy ports after new
> init model and drop -ENOENT hack in #upstream.
>
> 2. -ENODEV sounds more appropriate.  Why have I used -ENOENT.  :-)
>
> Thanks.
>
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 7349c3d..361953a 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1625,8 +1625,14 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
>                 rc = prereset(ap);
>                 if (rc) {
>                         if (rc == -ENOENT) {
> -                               ata_port_printk(ap, KERN_DEBUG, "port disabled. ignoring.\n");
> +                               ata_port_printk(ap, KERN_DEBUG,
> +                                               "port disabled. ignoring.\n");
>                                 ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
> +
> +                               for (i = 0; i < ATA_MAX_DEVICES; i++)
> +                                       classes[i] = ATA_DEV_NONE;
> +
> +                               rc = 0;
>                         } else
>                                 ata_port_printk(ap, KERN_ERR,
>                                         "prereset failed (errno=%d)\n", rc);
>
