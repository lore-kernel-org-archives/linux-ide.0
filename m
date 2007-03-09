From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_promise: Switch to cable method, clean up some bits
 as a result
Date: Fri, 09 Mar 2007 08:02:55 -0500
Message-ID: <45F15AFF.6060905@pobox.com>
References: <20070308230647.0cda2afc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55858 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767254AbXCINC6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 08:02:58 -0500
In-Reply-To: <20070308230647.0cda2afc@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <number6@the-village.bc.nu>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/sata_promise.c linux-2.6.21-rc3-mm2/drivers/ata/sata_promise.c
> --- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/sata_promise.c	2007-03-08 16:01:10.000000000 +0000
> +++ linux-2.6.21-rc3-mm2/drivers/ata/sata_promise.c	2007-03-08 16:40:20.000000000 +0000
> @@ -45,7 +45,7 @@
>  #include "sata_promise.h"
>  
>  #define DRV_NAME	"sata_promise"
> -#define DRV_VERSION	"2.00"
> +#define DRV_VERSION	"2.00ac1"

applied, after fixing version to remove graphitti


