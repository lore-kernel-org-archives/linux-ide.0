From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_mv: Define module alias for platform device
Date: Wed, 20 Feb 2008 12:09:43 -0500
Message-ID: <47BC5ED7.5010800@garzik.org>
References: <20080216171527.GA2552@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56919 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932488AbYBTRJs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Feb 2008 12:09:48 -0500
In-Reply-To: <20080216171527.GA2552@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Martin Michlmayr wrote:
> The sata_mv driver can be loaded as a platform device, as is done by
> various Orion (ARM) based devices.  The driver needs to define a module
> alias for the platform driver so udev will load it automatically.
> Tested with Debian on a QNAP TS-209.
> 
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
> 
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -3198,6 +3198,7 @@ MODULE_DESCRIPTION("SCSI low-level driver for Marvell SATA controllers");
>  MODULE_LICENSE("GPL");
>  MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
>  MODULE_VERSION(DRV_VERSION);
> +MODULE_ALIAS("platform:sata_mv");
>  
>  #ifdef CONFIG_PCI
>  module_param(msi, int, 0444);

applied


