From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv: Define module alias for platform device
Date: Sat, 16 Feb 2008 12:22:28 -0500
Message-ID: <47B71BD4.40503@rtr.ca>
References: <20080216171527.GA2552@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3213 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754671AbYBPRWb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Feb 2008 12:22:31 -0500
In-Reply-To: <20080216171527.GA2552@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-ide@vger.kernel.org

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
> 
..

Acked-by: Mark Lord <mlord@pobox.com>

Looks safe enough.
