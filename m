From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support (revised)
Date: Tue, 29 Apr 2008 20:38:17 +0400
Message-ID: <48174EF9.8020208@ru.mvista.com>
References: <20080426140007.63cfeede@dxy.sh.intel.com>	<20080428094123.59d055c7@core>	<20080428170751.097bdbe6@dxy.sh.intel.com>	<200804282101.33012.bzolnier@gmail.com> <20080429113905.757703fd@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:22259 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752183AbYD2Qi5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 12:38:57 -0400
In-Reply-To: <20080429113905.757703fd@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

Alek Du wrote:

> Modified the patch again. Add and use DECLARE_SCH_DEV instead of DECLARE_ICH_DEV
> to avoid enable_bits. But I still use ATA_CBL_UNK, because according to my test,
> it works fine -- it could set the disk to UDMA5 mode when using 80 wire cable.
> Please review it again, thanks.

> This patch adds Intel SCH chipsets (US15W, US15L, UL11L) PATA controller
> support.

> Signed-off-by: Alek Du <alek.du@intel.com>

    NAK this patch completely -- both libata and IDE parts.
    Luckily, I have just had a quick look at the datasheet to which you've 
linked and that was enough to conclude that SCH is *not* compatible to 
ICH/PIIX family, so absolutely needs a separate driver!

> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index ea2c764..4ec4178 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -136,6 +136,7 @@ enum piix_controller_ids {
>  	ich_pata_33,		/* ICH up to UDMA 33 only */
>  	ich_pata_66,		/* ICH up to 66 Mhz */
>  	ich_pata_100,		/* ICH up to UDMA 100 */
> +	sch_pata_100,		/* SCH up to UDMA 100 */
>  	ich5_sata,
>  	ich6_sata,
>  	ich6m_sata,
> @@ -216,6 +217,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
>  	{ 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
>  	/* ICH8 Mobile PATA Controller */
>  	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
> +	/* Intel SCH PATA Controller */
> +	{ 0x8086, 0x811A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sch_pata_100 },
>  
>  	/* NOTE: The following PCI ids must be kept in sync with the
>  	 * list in drivers/pci/quirks.c.
> @@ -311,6 +314,13 @@ static struct ata_port_operations ich_pata_ops = {
>  	.set_dmamode		= ich_set_dmamode,
>  };
>  
> +static struct ata_port_operations sch_pata_ops = {
> +	.inherits		= &piix_pata_ops,
> +	.cable_detect		= ata_cable_unknown,
> +	.prereset		= ata_sff_prereset,
> +	.set_dmamode		= ich_set_dmamode,

    The ich_set_dmamode() won't work with SCH.

> +};
> +
>  static struct ata_port_operations piix_sata_ops = {
>  	.inherits		= &ata_bmdma_port_ops,
>  };
> @@ -470,6 +480,15 @@ static struct ata_port_info piix_port_info[] = {
>  		.port_ops	= &ich_pata_ops,
>  	},
>  
> +	[sch_pata_100] =
> +	{
> +		.flags		= PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
> +		.pio_mask	= 0x1f,	/* pio0-4 */
> +		.mwdma_mask	= 0x06, /* mwdma1-2 */

    Wrong, SCH does support MWDMA0, so the mask would be 0x07...

> diff --git a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
> index 21c5dd2..d224a67 100644
> --- a/drivers/ide/pci/piix.c
> +++ b/drivers/ide/pci/piix.c
> @@ -340,6 +340,19 @@ static const struct ide_port_ops piix_port_ops = {
>  		.udma_mask	= udma, \
>  	}
>  
> +#define DECLARE_SCH_DEV(name_str, udma) \

    Well, a single instance hardly deserved its own macro, could just put the 
whole initializer in its array slot like for MPIIX (which probably shouldn't 
be in this driver anyway though :-)...

> +	{ \
> +		.name		= name_str, \
> +		.init_chipset	= init_chipset_ich, \

    This method read/writes IOCFG register which as you've yourself noted is 
missing on SCH (among with any ICH compatible registers ;-).

> +		.init_hwif	= init_hwif_ich, \
> +		.port_ops	= &piix_port_ops, \
> +		.host_flags	= IDE_HFLAGS_PIIX, \
> +		.pio_mask	= ATA_PIO4, \
> +		.swdma_mask	= ATA_SWDMA2_ONLY, \

    Wrong, no SWDMA support in SCH.

> +		.mwdma_mask	= ATA_MWDMA12_ONLY, \

    Shoud have been ATA_MWDMA2.

> +		.udma_mask	= udma, \

    This is fixed to AATA_UDMA5 so there was no need to parametrize...

MBR, Sergei
