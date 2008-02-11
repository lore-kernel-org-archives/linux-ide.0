From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_amd: Note in the module description it handles Nvidia
Date: Mon, 11 Feb 2008 14:31:18 -0500
Message-ID: <47B0A286.3020909@garzik.org>
References: <20080208152239.0fc11e85@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55294 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760882AbYBKTb0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Feb 2008 14:31:26 -0500
In-Reply-To: <20080208152239.0fc11e85@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> This has confused a few people so fix it
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-mm1/drivers/ata/pata_amd.c linux-2.6.24-mm1/drivers/ata/pata_amd.c
> --- linux.vanilla-2.6.24-mm1/drivers/ata/pata_amd.c	2008-02-06 14:14:39.000000000 +0000
> +++ linux-2.6.24-mm1/drivers/ata/pata_amd.c	2008-02-06 14:31:35.000000000 +0000
> @@ -772,7 +772,7 @@
>  }
>  
>  MODULE_AUTHOR("Alan Cox");
> -MODULE_DESCRIPTION("low-level driver for AMD PATA IDE");
> +MODULE_DESCRIPTION("low-level driver for AMD and Nvidia PATA IDE");
>  MODULE_LICENSE("GPL");
>  MODULE_DEVICE_TABLE(pci, amd);
>  MODULE_VERSION(DRV_VERSION);

applied


