From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch, resend] libata: Fix LBA48 on pata_it821x RAID volumes.
Date: Mon, 27 Oct 2008 23:58:20 -0400
Message-ID: <49068DDC.8030001@garzik.org>
References: <20081026181019.073dd529@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54402 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbYJ1D60 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 23:58:26 -0400
In-Reply-To: <20081026181019.073dd529@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-ide@vger.kernel.org, Ondrej Zary <linux@rainbow-software.org>, Alan Cox <alan@redhat.com>

Chuck Ebbert wrote:
> From: Ondrej Zary <linux@rainbow-software.org>
> 
> libata: Fix LBA48 on pata_it821x RAID volumes.
> 
> [http://lkml.org/lkml/2008/10/18/82]
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> Acked-by: Alan Cox <alan@redhat.com>
> 
> --- linux-2.6.27-orig/drivers/ata/pata_it821x.c	2008-10-18 17:09:07.000000000 +0200
> +++ linux-2.6.27-pentium/drivers/ata/pata_it821x.c	2008-10-18 17:10:24.000000000 +0200
> @@ -557,9 +557,8 @@
>  	if (strstr(model_num, "Integrated Technology Express")) {
>  		/* Set feature bits the firmware neglects */
>  		id[49] |= 0x0300;	/* LBA, DMA */
> -		id[82] |= 0x0400;	/* LBA48 */
>  		id[83] &= 0x7FFF;
> -		id[83] |= 0x4000;	/* Word 83 is valid */
> +		id[83] |= 0x4400;	/* Word 83 is valid and LBA48 */
>  		id[86] |= 0x0400;	/* LBA48 on */
>  		id[ATA_ID_MAJOR_VER] |= 0x1F;

applied


