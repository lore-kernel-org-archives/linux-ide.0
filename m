From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide-tape: dump gcw fields on error in idetape_identify_device()
Date: Sun, 03 Feb 2008 20:16:42 +0300
Message-ID: <47A5F6FA.3000107@ru.mvista.com>
References: <200802021922.56703.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:54974 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757588AbYBCRPt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Feb 2008 12:15:49 -0500
In-Reply-To: <200802021922.56703.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

Bartlomiej Zolnierkiewicz wrote:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-tape.c
> ===================================================================
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -3852,16 +3852,17 @@ static int idetape_identify_device (ide_
>  
>  	/* Check that we can support this device */
>  
> -	if (gcw.protocol !=2 )
> -		printk(KERN_ERR "ide-tape: Protocol is not ATAPI\n");
> +	if (gcw.protocol != 2)
> +		printk(KERN_ERR "ide-tape: Protocol (0x%02x) is not ATAPI\n",
> +				gcw.protocol);
>  	else if (gcw.device_type != 1)
> -		printk(KERN_ERR "ide-tape: Device type is not set to tape\n");
> +		printk(KERN_ERR "ide-tape: Device type (0x%02x) is not set "
> +				"to tape\n", gcw.device_type);
>  	else if (!gcw.removable)
>  		printk(KERN_ERR "ide-tape: The removable flag is not set\n");
>  	else if (gcw.packet_size != 0) {
> -		printk(KERN_ERR "ide-tape: Packet size is not 12 bytes long\n");
> -		if (gcw.packet_size == 1)
> -			printk(KERN_ERR "ide-tape: Sorry, padding to 16 bytes is still not supported\n");
> +		printk(KERN_ERR "ide-tape: Packet size (0x%02x) is not 12 "
> +				"bytes long\n", gcw.packet_size);

    Shouldn't it be either "packet size is not 12 byted" or "packet is not 12 
bytes long"?

MBR, Sergei
