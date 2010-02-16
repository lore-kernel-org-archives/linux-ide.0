From: Prajakta Gudadhe <pgudadhe@nvidia.com>
Subject: Re: [PATCH] ahci: disable FPDMA auto-activate optimization on
 NVIDIA AHCI
Date: Tue, 16 Feb 2010 17:46:39 -0500
Message-ID: <1266360399.2257.50.camel@pgudadhe-dt3.nvidia.com>
References: <4B5FC213.1060601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.112.145]:7219 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933181Ab0BPWvK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Feb 2010 17:51:10 -0500
In-Reply-To: <4B5FC213.1060601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>, pgudadhe@nvidia.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mike Cui <cuicui@gmail.com>, Peer Chen <pchen@nvidia.com>

We are currently investigating this MCP79 issue when FPDMA auto activate
feature is enabled. Meanwhile, this patch looks good to me.

--Prajakta Gudadhe

On Tue, 2010-01-26 at 20:33 -0800, Robert Hancock wrote:
> Mike Cui reported that his system with an NVIDIA MCP79 (aka MCP7A) chipset
> stopped working with 2.6.32. The problem appears to be that 2.6.32 now enables
> the FPDMA auto-activate optimization in the ahci driver. The drive works fine
> with this enabled on an Intel AHCI so this appears to be a chipset bug.
> Since MCP79 is a fairly recent NVIDIA chipset and we don't have any info on
> whether any other NVIDIA chipsets have this issue, disable FPDMA AA optimization
> on all NVIDIA AHCI controllers for now.
> 
> Should address http://bugzilla.kernel.org/show_bug.cgi?id=14922
> 
> Signed-off-by: Robert Hancock <hancockrwd@gmail.com>
> 
> ---
> 
> Mike, can you test this out and make sure this resolves the problem for you?
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index b8bea10..47e57dc 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -3067,8 +3067,16 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	ahci_save_initial_config(pdev, hpriv);
>  
>  	/* prepare host */
> -	if (hpriv->cap & HOST_CAP_NCQ)
> -		pi.flags |= ATA_FLAG_NCQ | ATA_FLAG_FPDMA_AA;
> +	if (hpriv->cap & HOST_CAP_NCQ) {
> +		pi.flags |= ATA_FLAG_NCQ;
> +		/* Auto-activate optimization is supposed to be supported on
> +		   all AHCI controllers indicating NCQ support, but it seems
> +		   to be broken at least on some NVIDIA MCP79 chipsets.
> +		   Until we get info on which NVIDIA chipsets don't have this
> +		   issue, if any, disable AA on all NVIDIA AHCIs. */
> +		if (pdev->vendor != PCI_VENDOR_ID_NVIDIA)
> +			pi.flags |= ATA_FLAG_FPDMA_AA;
> +	}
>  
>  	if (hpriv->cap & HOST_CAP_PMP)
>  		pi.flags |= ATA_FLAG_PMP;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
