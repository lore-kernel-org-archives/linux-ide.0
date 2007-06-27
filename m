From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_it821x: fix section mismatch warning
Date: Wed, 27 Jun 2007 02:45:37 -0400
Message-ID: <46820791.4080904@pobox.com>
References: <20070625104222.6bc805e9.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37972 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756879AbXF0Gpk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Jun 2007 02:45:40 -0400
In-Reply-To: <20070625104222.6bc805e9.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: ide <linux-ide@vger.kernel.org>, alan@redhat.com, bzolnier@gmail.com

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix section mismatch when CONFIG_HOTPLUG=n (but functions are used
> for resume):
> 
> WARNING: drivers/ata/pata_it821x.o(.text+0x3f): Section mismatch: reference to .init.text: (between 'it821x_reinit_one' and 'it821x_program_udma')
> WARNING: drivers/ata/pata_it821x.o(.text+0x691): Section mismatch: reference to .init.text: (between 'it821x_init_one' and 'it821x_passthru_set_dmamode')
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/ata/pata_it821x.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.22-rc6.orig/drivers/ata/pata_it821x.c
> +++ linux-2.6.22-rc6/drivers/ata/pata_it821x.c
> @@ -690,7 +690,7 @@ static struct ata_port_operations it821x
>  	.port_start	= it821x_port_start,
>  };
>  
> -static void __devinit it821x_disable_raid(struct pci_dev *pdev)
> +static void it821x_disable_raid(struct pci_dev *pdev)
>  {
>  	/* Reset local CPU, and set BIOS not ready */
>  	pci_write_config_byte(pdev, 0x5E, 0x01);

applied


