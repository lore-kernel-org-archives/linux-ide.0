From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ATA_PIIX] state of ICH8M PATA Support
Date: Tue, 03 Jul 2007 10:19:42 -0400
Message-ID: <468A5AFE.7090004@garzik.org>
References: <200706171309.00043.chunkeey@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60381 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753836AbXGCOTp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 10:19:45 -0400
In-Reply-To: <200706171309.00043.chunkeey@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chr <chunkeey@web.de>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Chr wrote:
> Hi,
> 
> I got a new laptop and I had a little problem that the DVD drive wasn't recognized by
> libata's piix driver (but the old IDE Subsystem found it!!).
> 
> So, after adding the new pciid 8086:2850 it works!
> But, I don't know if it's ich_pata_100 or ich_pata_133 since the 
> dvd/cd drives only goes up to udma2 speeds.
> 
> Thanks,
> 	Chr.
> 
> 
> -
> this patch adds a necessary PCIID for santa rosa's PATA controller.
> 
> Signed-off-by: Christian Lamparter <chunkeey@web.de>
> -
> 
> 
> ------------------------------------------------------------------------
> 
> --- ata_piix.c.org	2007-06-17 12:58:17.000000000 +0200
> +++ ata_piix.c	2007-06-17 13:00:24.000000000 +0200
> @@ -201,6 +201,8 @@ static const struct pci_device_id piix_p
>  	/* ICH7/7-R (i945, i975) UDMA 100*/
>  	{ 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
>  	{ 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
> +	/* ICH8 Mobile PATA Controller */
> +	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },

applied


