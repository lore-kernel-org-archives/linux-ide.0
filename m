From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.20-rc3-mm1 2/2] libata: SiS 180 pata/sata support
Date: Sun, 07 Jan 2007 20:33:27 -0500
Message-ID: <45A19F67.6050909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51410 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965289AbXAHBde (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Jan 2007 20:33:34 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, "linux.ide" <linux-ide@vger.kernel.org>, Sven Ladegast <sven@linux4geeks.de>

Uwe Koziolek wrote:
> This patch includes the PATA support for SiS180 importing PATA functionality from pata_sis.c
> 
> Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>
> 
> --- a/drivers/ata/sata_sis.c	2007-01-07 20:54:38.000000000 +0100
> +++ b/drivers/ata/sata_sis.c	2007-01-07 23:42:29.000000000 +0100
> @@ -138,6 +138,10 @@
>  	.port_ops	= &sis_ops,
>  };
>  
> +#ifdef CONFIG_PATA_SIS
> +extern struct ata_port_info sis_info133;
> +#endif

This is a poor way to share code between modules.  It fails when 
pata_sis is a module, and it forces another driver to be loaded, simply 
then to be used as a code library.

If the shared code is tiny, just create a header file and #include it 
(sata_promise and sata_sx4 do this).  Otherwise, create a shared library 
module.

	Jeff


