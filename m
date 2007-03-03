From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata Kconfig: Update the various experimentality levels
Date: Fri, 02 Mar 2007 19:13:27 -0500
Message-ID: <45E8BDA7.3070800@garzik.org>
References: <20070302150512.281af8d3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55020 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992785AbXCCANc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 19:13:32 -0500
In-Reply-To: <20070302150512.281af8d3@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2/drivers/ata/Kconfig linux-2.6.21-rc2/drivers/ata/Kconfig
> --- linux.vanilla-2.6.21-rc2/drivers/ata/Kconfig	2007-03-01 13:36:03.000000000 +0000
> +++ linux-2.6.21-rc2/drivers/ata/Kconfig	2007-03-02 13:30:50.535164824 +0000
> @@ -184,7 +184,7 @@
>  	  If unsure, say N.
>  
>  config PATA_AMD
> -	tristate "AMD/NVidia PATA support (Experimental)"
> +	tristate "AMD/NVidia PATA support"
>  	depends on PCI
>  	help
>  	  This option enables support for the AMD and NVidia PATA
> @@ -273,7 +283,7 @@
>  	  If unsure, say N.
>  
>  config PATA_HPT366
> -	tristate "HPT 366/368 PATA support (Very Experimental)"
> +	tristate "HPT 366/368 PATA support (Experimental)"
>  	depends on PCI && EXPERIMENTAL

ACK the changes you've presented, but please do resend combined with a 
patch that updates the CONFIG_EXPERIMENTAL dependencies at the same time


