From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] winbond IDE depends on IDEDMA
Date: Thu, 30 Nov 2006 21:25:58 +0300
Message-ID: <456F2236.3030401@ru.mvista.com>
References: <20061130143803.GA22451@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:28354 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1030964AbWK3SY2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Nov 2006 13:24:28 -0500
In-Reply-To: <20061130143803.GA22451@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

Hello.

Olaf Hering wrote:
> winbond ide depends on idedma.

[...]

> Index: linux-2.6.19/drivers/ide/Kconfig
> ===================================================================
> --- linux-2.6.19.orig/drivers/ide/Kconfig
> +++ linux-2.6.19/drivers/ide/Kconfig
> @@ -391,7 +391,7 @@ config BLK_DEV_RZ1000
>  
>  config BLK_DEV_SL82C105
>  	tristate "Winbond SL82c105 support"
> -	depends on PCI && (PPC || ARM) && BLK_DEV_IDEPCI
> +	depends on PCI && (PPC || ARM) && BLK_DEV_IDEPCI && BLK_DEV_IDEDMA_PCI
>  	help
>  	  If you have a Winbond SL82c105 IDE controller, say Y here to enable
>  	  special configuration for this chip. This is common on various CHRP

    This whole item should be moved below, under ifdef BLK_DEV_IDEDMA_PCI 
then, for consistency.  Please recast.

WBR, Sergei
