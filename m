From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-core: auditting chk_status v check_status
Date: Tue, 23 Oct 2007 21:25:27 -0400
Message-ID: <471E9F07.3070802@garzik.org>
References: <20071023165002.15a7b09e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38321 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753159AbXJXBZg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2007 21:25:36 -0400
In-Reply-To: <20071023165002.15a7b09e@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Did a complete audit of these and found we have another error case.
> 
> ata_bus_softreset calls ata_check_status which means that it tries to do
> an ioread8 on the port blindly and check versus 0xFF for an error.
> 
> It should of course be using the ap->ops method for this via chk_status,
> and this bug causes a wrog status call on the NS87415 at least.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c linux-2.6.23-mm1/drivers/ata/libata-core.c
> --- linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c	2007-10-15 15:03:26.000000000 +0100
> +++ linux-2.6.23-mm1/drivers/ata/libata-core.c	2007-10-23 13:39:25.861931504 +0100
> @@ -3305,7 +3323,7 @@
>  	 * the bus shows 0xFF because the odd clown forgets the D7
>  	 * pulldown resistor.
>  	 */
> -	if (ata_check_status(ap) == 0xFF)
> +	if (ata_chk_status(ap) == 0xFF)
>  		return -ENODEV;

applied


