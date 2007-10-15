From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata-core: Drop in the final bit of IORDY handling
Date: Mon, 15 Oct 2007 23:42:41 +0400
Message-ID: <4713C2B1.7090701@ru.mvista.com>
References: <20071015192040.5a11bcf7@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:11517 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755896AbXJOTm3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 15:42:29 -0400
In-Reply-To: <20071015192040.5a11bcf7@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Hello.

Alan Cox wrote:

> Signed-off-by: Alan Cox <alan@redhat.com>

> diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c linux-2.6.23-mm1/drivers/ata/libata-core.c
> --- linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c	2007-10-15 15:03:26.000000000 +0100
> +++ linux-2.6.23-mm1/drivers/ata/libata-core.c	2007-10-15 15:13:49.000000000 +0100
> @@ -4203,8 +4219,12 @@
>  	tf.command = ATA_CMD_SET_FEATURES;
>  	tf.feature = SETFEATURES_XFER;
>  	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_POLLING;
>  	tf.protocol = ATA_PROT_NODATA;
> -	tf.nsect = dev->xfer_mode;
> + 	/* Ancient devices may need us to avoid IORDY */
> + 	if (ata_pio_need_iordy(dev))
> + 		tf.nsect = dev->xfer_mode;
> + 	else
> + 		tf.nsect = 0x01;

    This is wrong logic as I've alredy pointed out: according to the ATA-2 
setting *any* PIO mode via 0x08..0x0c commands assumes IORDY is enabled.
We should only set mode 0x01 (default w/IORDY disabled) if device supports 
IORDY and the host doesn't.

>  	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);

MBR, Sergei
