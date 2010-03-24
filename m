From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] ahci: Turn off DMA engines when there's no device
	attached
Date: Wed, 24 Mar 2010 14:19:12 +0000
Message-ID: <20100324141912.GA18644@srcf.ucam.org>
References: <1268253150-24050-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45704 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab0CXOTS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Mar 2010 10:19:18 -0400
Content-Disposition: inline
In-Reply-To: <1268253150-24050-1-git-send-email-mjg@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Any feedback on this?

On Wed, Mar 10, 2010 at 03:32:30PM -0500, Matthew Garrett wrote:
> According to section 10.3.1 of the AHCI spec, PxCMD.ST must not be set
> unless there's a device attached. Following this saves us a measurable
> quantity of power and does not impair hotplug support. Based on a patch
> by Kristen Carlson Accardi.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> ---
>  drivers/ata/ahci.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 6bd930b..ff08317 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1016,11 +1016,30 @@ static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
>  	return -EINVAL;
>  }
>  
> +static int ahci_is_device_present(struct ata_port *ap)
> +{
> +	void __iomem *port_mmio = ahci_port_base(ap);
> +	u8 status = readl(port_mmio + PORT_TFDATA) & 0xff;
> +
> +	/* Make sure PxTFD.STS.BSY and PxTFD.STS.DRQ are 0 */
> +	if (status & (ATA_BUSY | ATA_DRQ))
> +		return 0;
> +
> +	/* Make sure PxSSTS.DET is 3h */
> +	status = readl(port_mmio + PORT_SCR_STAT) & 0xf;
> +	if (status != 3)
> +		return 0;
> +	return 1;
> +}
> +
>  static void ahci_start_engine(struct ata_port *ap)
>  {
>  	void __iomem *port_mmio = ahci_port_base(ap);
>  	u32 tmp;
>  
> +	if (!ahci_is_device_present(ap))
> +		return;
> +
>  	/* start DMA */
>  	tmp = readl(port_mmio + PORT_CMD);
>  	tmp |= PORT_CMD_START;
> -- 
> 1.6.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
