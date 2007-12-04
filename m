From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA
	device driver
Date: Tue, 4 Dec 2007 12:48:26 -0600
Message-ID: <20071204184826.GA5758@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170719.GB15599@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:33613 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbXLDSoY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 13:44:24 -0500
Content-Disposition: inline
In-Reply-To: <20071204170719.GB15599@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kumar Gala <galak@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>

Hi,

On Tue, Dec 04, 2007 at 08:07:19PM +0300, Anton Vorontsov wrote:
> This driver nicely wraps around pata_platform library functions,
> and provides OF platform bus bindings to the PATA devices.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/ata/Kconfig            |   10 ++++
>  drivers/ata/Makefile           |    1 +
>  drivers/ata/pata_of_platform.c |  102 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/pata_of_platform.c
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index ba63619..5a492fa 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -614,6 +614,16 @@ config PATA_PLATFORM
>  
>  	  If unsure, say N.
>  
> +config PATA_OF_PLATFORM
> +	tristate "OpenFirmware platform device PATA support"
> +	depends on PATA_PLATFORM && PPC_OF
> +	help
> +	  This option enables support for generic directly connected ATA
> +	  devices commonly found on embedded systems with OpenFirmware
> +	  bindings.
> +
> +	  If unsure, say N.
> +

There's a typo in the dependencies for PATA_PLATFORM that you should change:

depends on EMBEDDED || ARCH_RPC

(note ARCH_>R<PC). With my font it's hard to tell a difference :)

It should really be:

depends on EMBEDDED || PPC

Care to change that while you're at it?

> +static struct of_device_id pata_of_platform_match[] = {
> +	{ .compatible = "ata-generic", },
> +};

Needs to be terminated by empty entry, and please add:
MODULE_DEVICE_TABLE(of, pata_of_platform_match);


-Olof
