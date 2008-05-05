From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: Add Intel SCH PATA Support
Date: Mon, 05 May 2008 14:33:40 +0400
Message-ID: <481EE284.2010708@ru.mvista.com>
References: <20080505172356.636649e6@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:37755 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754019AbYEEKeQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 May 2008 06:34:16 -0400
In-Reply-To: <20080505172356.636649e6@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Alek Du wrote:

> This patch adds Intel SCH chipsets

    Looks good, yet there's some nits...

> (US15W, US15L, UL11L) PATA controller support.

    From the Intel's documentation I got the impression that the part numbers 
start with AF82 (82 being the usual Intel's chip number prefix).

> Signed-off-by: Alek Du <alek.du@intel.com>

> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index b693d82..ec589e2 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ATA)		+= libata.o
>  obj-$(CONFIG_SATA_AHCI)		+= ahci.o
>  obj-$(CONFIG_SATA_SVW)		+= sata_svw.o
>  obj-$(CONFIG_ATA_PIIX)		+= ata_piix.o
> +obj-$(CONFIG_ATA_SCH)		+= ata_sch.o

    The name of the drivers for the pure PATA chips are prefixed with 'pata_', 
not 'ata_'.

>  obj-$(CONFIG_SATA_PROMISE)	+= sata_promise.o
>  obj-$(CONFIG_SATA_QSTOR)	+= sata_qstor.o
>  obj-$(CONFIG_SATA_SIL)		+= sata_sil.o
> diff --git a/drivers/ata/ata_sch.c b/drivers/ata/ata_sch.c
> new file mode 100644
> index 0000000..2c7b358
> --- /dev/null
> +++ b/drivers/ata/ata_sch.c
> @@ -0,0 +1,271 @@

[...]

> +/* see SCH datasheet page 351 */
> +enum {
> +	D0TIM	= 0x80,		/* Device 0 Timing Register */
> +	D1TIM	= 0x84,		/* Device 1 Timing Register */
> +	PIO	= 0x07,		/* PIO Mode Bit Mask */

    The SCH datasheet calls this field PM and since you've got all other names 
form there, why not call it PM too?

> +	MDM	= (0x03 << 8),	/* Multi-word DMA Mode Bit Mask */
> +	UDM	= (0x07 << 16), /* Ultra DMA Mode Bit Mask */
> +	PPE	= (1 << 30),	/* Prefetch/Post Enable */
> +	USD	= (1 << 31),	/* Use Synchronous DMA */
> +};

> +enum sch_controller_ids {
> +	/* controller IDs */
> +	sch_pata_100,		/* SCH up to UDMA 100 */
> +};

    I don't see why you need the above.

> +static unsigned int in_module_init = 1;
> +
> +static struct ata_port_operations sch_pata_ops = {
> +	.inherits		= &ata_bmdma_port_ops,
> +	.cable_detect		= ata_cable_unknown,
> +	.set_piomode		= sch_set_piomode,
> +	.set_dmamode		= sch_set_dmamode,
> +	.prereset		= ata_sff_prereset,

    ata_sff_prereset is the default method, why not just inherit it?

> +/**
> + *	sch_set_piomode - Initialize host controller PATA PIO timings
> + *	@ap: Port whose timings we are configuring
> + *	@adev: um
> + *
> + *	Set PIO mode for device, in host controller PCI config space.
> + *
> + *	LOCKING:
> + *	None (inherited from caller).
> + */
> +
> +static void sch_set_piomode(struct ata_port *ap, struct ata_device *adev)
> +{
> +	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
> +	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
> +	unsigned int port	= adev->devno ? D1TIM : D0TIM;
> +	unsigned int data;
> +
> +	/* SCH only support primary channel with one master and one slave*/
> +	if (ap->port_no != 0)
> +		return;

    There should be no references to the secondary channel from libata since 
you should explicitly specify that there is no secondary channel.

> +
> +	pci_read_config_dword(dev, port, &data);
> +	/* see SCH datasheet page 351 */
> +	/* enable PIO with PPE*/

    No space before */...

> +	data &= ~(PIO);

    Unneeded parens.

> +	data |= (PPE |pio);

    You shouldn't enable prefetch for ATAPI deives I think -- look at what 
ata_piix does...
    Also, unneeded parens, no space after | operator. Be consistent please.

> +	/* mask reserved bits */

    Why?

> +	data = data & (USD|PPE|UDM|MDM|PIO);

    No spaces between | operator and operands.

> +	pci_write_config_dword(dev, port, data);
> +}
> +
> +/**
> + *	sch_set_dmamode - Initialize host controller PATA DMA timings
> + *	@ap: Port whose timings we are configuring
> + *	@adev: um
> + *
> + *	Set MW/UDMA mode for device, in host controller PCI config space.
> + *
> + *	LOCKING:
> + *	None (inherited from caller).
> + */
> +
> +static void sch_set_dmamode(struct ata_port *ap, struct ata_device *adev)
> +{
> +	unsigned int dma_mode	= adev->dma_mode;
> +	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
> +	unsigned int port	= adev->devno ? D1TIM : D0TIM;
> +	unsigned int data;
> +
> +	/* SCH only support primary channel with one master and one slave*/
> +	if (ap->port_no != 0)
> +		return;

    Same comment as in sch_set_piomode().

> +
> +	pci_read_config_dword(dev, port, &data);
> +	/* see SCH datasheet page 351 */
> +	if (dma_mode >= XFER_UDMA_0) {
> +		/* enable Synchronous DMA mode */
> +		data |= USD;
> +		data &= ~(UDM);

    Unneeded parens.

> +		data |= (dma_mode - XFER_UDMA_0) << 16;
> +	} else { /* must be MWDMA mode, since we masked SWDMA already */
> +		data &= ~(USD|MDM);

    No spaces between | and operands.

> +		data |= (dma_mode - XFER_MW_DMA_0) << 8;
> +	}
> +	/* mask reserved bits */

    Why again?

> +	data = data & (USD|PPE|UDM|MDM|PIO);

    No spaces between | and operands.

MBR, Sergei
