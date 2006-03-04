From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_promise: Support FastTrak TX4310
Date: Fri, 03 Mar 2006 21:25:41 -0500
Message-ID: <4408FAA5.1070103@pobox.com>
References: <43F10DDD.901@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:10909 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750716AbWCDCZo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2006 21:25:44 -0500
In-Reply-To: <43F10DDD.901@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-ide@vger.kernel.org

Daniel Drake wrote:
> This patch adds support for the Promise FastTrak TX4310, a 4-port PCI 
> SATA controller based on the PDC40719 chip.
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux/drivers/scsi/sata_promise.c.orig	2006-02-12 17:12:34.000000000 +0000
> +++ linux/drivers/scsi/sata_promise.c	2006-02-12 17:13:46.000000000 +0000
> @@ -228,6 +228,8 @@ static const struct pci_device_id pdc_at
>  	  board_20319 },
>  	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_20319 },
> +	{ PCI_VENDOR_ID_PROMISE, 0x3515, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  board_20319 },
>  	{ PCI_VENDOR_ID_PROMISE, 0x3519, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_20319 },
>  	{ PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,

Can you resend with the patch inline?  Attachments continue to be 
discouraged...

	Jeff


