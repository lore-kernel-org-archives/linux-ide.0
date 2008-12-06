From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 3/7] ata: Fix experimental tags
Date: Fri, 05 Dec 2008 19:05:18 -0600
Message-ID: <4939CFCE.2000901@shaw.ca>
References: <20081205194231.17133.42760.stgit@localhost.localdomain> <20081205194254.17133.67496.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:55890 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815AbYLFBFb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Dec 2008 20:05:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L8lbt-0004uW-SR
	for linux-ide@vger.kernel.org; Sat, 06 Dec 2008 01:05:29 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 06 Dec 2008 01:05:29 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 06 Dec 2008 01:05:29 +0000
In-Reply-To: <20081205194254.17133.67496.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: kai@kaishome.de, jeff@garzik.org

Alan Cox wrote:
> From: Alan Cox <alan@redhat.com>
> 
> Various tags are now way out of date
> ---
> 
>  drivers/ata/Kconfig |   44 ++++++++++++++++++++++----------------------
>  1 files changed, 22 insertions(+), 22 deletions(-)
> 
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 78fbec8..421b7c7 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -153,7 +153,7 @@ config SATA_PROMISE
>  	  If unsure, say N.
>  
>  config SATA_SX4
> -	tristate "Promise SATA SX4 support"
> +	tristate "Promise SATA SX4 support (Experimental)"
>  	depends on PCI && EXPERIMENTAL
>  	help
>  	  This option enables support for Promise Serial ATA SX4.

Forgot to remove the EXPERIMENTAL dependency on this one?

