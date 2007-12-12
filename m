From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: [PATCH] sata_mv: improve warnings about Highpoint RocketRAID
	23xx cards
Date: Wed, 12 Dec 2007 13:47:50 +0530
Message-ID: <1197447470.4710.20.camel@subratamodak.linux.ibm.com>
References: <475ECFAD.2030901@rtr.ca>
Reply-To: subrata@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:51109 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755026AbXLLIR5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Dec 2007 03:17:57 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBC8Hsuk009415
	for <linux-ide@vger.kernel.org>; Wed, 12 Dec 2007 03:17:54 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id lBC8HsiN135918
	for <linux-ide@vger.kernel.org>; Wed, 12 Dec 2007 03:17:54 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lBC8Hrap003493
	for <linux-ide@vger.kernel.org>; Wed, 12 Dec 2007 03:17:54 -0500
In-Reply-To: <475ECFAD.2030901@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, hp@syntomax.com, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Would you like to submit the Driver Test Cases to LTP ? Or, if you have
your Driver test cases written in C, we can port to LTP and have it
inside the LTP package.
You can also check out the following links for more info, and can always
ping me for anything:
http://ltp.cvs.sourceforge.net/ltp/ltp/testcases/kernel/device-drivers/,
http://ltp.sourceforge.net/documentation/how-to/ltp.php?

Regards--
Subrata
(LTP Maintainer)


On Tue, 2007-12-11 at 12:58 -0500, Mark Lord wrote:
> Improve the existing boot/load time warnings from sata_mv
> for Highpoint RocketRAID 23xx cards, based on new knowledge
> about where the BIOS likes to overwrite sectors with metadata.
> 
> Harmless to us, but very useful for end users.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> This should ideally go upstream for 2.6.24.
> 
> --- old/drivers/ata/sata_mv.c	2007-12-10 18:14:09.000000000 -0500
> +++ linux/drivers/ata/sata_mv.c	2007-12-11 12:51:51.000000000 -0500
> @@ -2506,11 +2506,31 @@
>  		if (pdev->vendor == PCI_VENDOR_ID_TTI &&
>  		    (pdev->device == 0x2300 || pdev->device == 0x2310))
>  		{
> -			printk(KERN_WARNING "sata_mv: Highpoint RocketRAID BIOS"
> -				" will CORRUPT DATA on attached drives when"
> -				" configured as \"Legacy\".  BEWARE!\n");
> -			printk(KERN_WARNING "sata_mv: Use BIOS \"JBOD\" volumes"
> -				" instead for safety.\n");
> +			/*
> +			 * Highpoint RocketRAID PCIe 23xx series cards:
> +			 *
> +			 * Unconfigured drives are treated as "Legacy"
> +			 * by the BIOS, and it overwrites sector 8 with
> +			 * a "Lgcy" metadata block prior to Linux boot.
> +			 *
> +			 * Configured drives (RAID or JBOD) leave sector 8
> +			 * alone, but instead overwrite a high numbered
> +			 * sector for the RAID metadata.  This sector can
> +			 * be determined exactly, by truncating the physical
> +			 * drive capacity to a nice even GB value.
> +			 *
> +			 * RAID metadata is at: (dev->n_sectors & ~0xfffff)
> +			 *
> +			 * Warn the user, lest they think we're just buggy.
> +			 */
> +			printk(KERN_WARNING DRV_NAME ": Highpoint RocketRAID"
> +				" BIOS CORRUPTS DATA on all attached drives,"
> +				" regardless of if/how they are configured."
> +				" BEWARE!\n");
> +			printk(KERN_WARNING DRV_NAME ": For data safety, do not"
> +				" use sectors 8-9 on \"Legacy\" drives,"
> +				" and avoid the final two gigabytes on"
> +				" all RocketRAID BIOS initialized drives.\n");
>  		}
>  	case chip_6042:
>  		hpriv->ops = &mv6xxx_ops;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

