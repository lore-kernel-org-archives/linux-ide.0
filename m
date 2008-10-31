From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/1] sata_sil: Option to use IO space to access TF	registers.
Date: Fri, 31 Oct 2008 11:26:06 +0900
Message-ID: <490A6CBE.8030906@kernel.org>
References: <20081022182243.9471.87443.stgit@linux-chris2.mips.com> <20081022221623.344aea62@lxorguk.ukuu.org.uk> <20081022233439.GA30488@ftp.linux-mips.org> <20081023083215.74e48b03@lxorguk.ukuu.org.uk> <20081030225853.GA525@ftp.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47898 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbYJaC00 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Oct 2008 22:26:26 -0400
In-Reply-To: <20081030225853.GA525@ftp.linux-mips.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Dearman <chris@linux-mips.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

Just some nitpickings.

Chris Dearman wrote:
> sata_sil: Option to use IO space to access TF registers.
> 
> From: Chris Dearman <chris@linux-mips.org>
> 
> Provide an alternative way to access the TaskFile registers if mmio
> doesn't work.
> 
> Signed-off-by: Chris Dearman <chris@linux-mips.org>
> ---
> 
>  drivers/ata/sata_sil.c |   67 ++++++++++++++++++++++++++++++++++++++++--------
>  1 files changed, 56 insertions(+), 11 deletions(-)
> 
> 
> diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
> index 88bf421..79f974a 100644
> --- a/drivers/ata/sata_sil.c
> +++ b/drivers/ata/sata_sil.c
> @@ -49,6 +49,10 @@
>  #define DRV_VERSION	"2.3"
>  
>  enum {
> +	SIL_IO_IDE0TF_BAR	= 0,
> +	SIL_IO_IDE0CTL_BAR	= 1,
> +	SIL_IO_IDE1TF_BAR	= 2,
> +	SIL_IO_IDE1CTL_BAR	= 3,
>  	SIL_MMIO_BAR		= 5,
>  
>  	/*
> @@ -237,6 +241,18 @@ static const struct {
>  	{ 0x2C0, 0x2CA, 0x208, 0x218, 0x244, 0x380, 0x3c8, 0x2f4, 0x3cc },
>  	/* ... port 3 */
>  };

Care to put a blank line here?

> +/* per-port IO based register offsets */
> +static const struct {
> +	unsigned int tfbar;	/* ATA taskfile BAR */
> +	unsigned int tf;	/* ATA taskfile register block */
> +	unsigned int ctlbar;	/* ATA control/altstatus BAR */
> +	unsigned int ctl;	/* ATA control/altstatus register block */
> +} sil_ioport[] = {
> +	{ SIL_IO_IDE0TF_BAR, 0, SIL_IO_IDE0CTL_BAR, 2 },
> +	{ SIL_IO_IDE1TF_BAR, 0, SIL_IO_IDE1CTL_BAR, 2 },
> +	{ SIL_IO_IDE0TF_BAR, 0, SIL_IO_IDE0CTL_BAR, 2 },
> +	{ SIL_IO_IDE1TF_BAR, 0, SIL_IO_IDE1CTL_BAR, 2 }
> +};
>  
>  MODULE_AUTHOR("Jeff Garzik");
>  MODULE_DESCRIPTION("low-level driver for Silicon Image SATA controller");
> @@ -248,6 +264,9 @@ static int slow_down;
>  module_param(slow_down, int, 0444);
>  MODULE_PARM_DESC(slow_down, "Sledgehammer used to work around random problems, by limiting commands to 15 sectors (0=off, 1=on)");
>  
> +static int tfio;
> +module_param(tfio, int, 0444);
> +MODULE_PARM_DESC(tfio, "Access Taskfile registers via IO space (0=off, 1=on)");
>  
>  static unsigned char sil_get_device_cache_line(struct pci_dev *pdev)
>  {
> @@ -630,7 +649,17 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (rc)
>  		return rc;
>  
> -	rc = pcim_iomap_regions(pdev, 1 << SIL_MMIO_BAR, DRV_NAME);
> +	if (tfio)
> +		rc = pcim_iomap_regions(pdev,
> +					(1 << SIL_IO_IDE0TF_BAR) |
> +					(1 << SIL_IO_IDE0CTL_BAR) |
> +					(1 << SIL_IO_IDE1TF_BAR) |
> +					(1 << SIL_IO_IDE1CTL_BAR) |
> +					(1 << SIL_MMIO_BAR),
> +					DRV_NAME);
> +	else
> +		rc = pcim_iomap_regions(pdev, 1 << SIL_MMIO_BAR, DRV_NAME);
> +

You can move pcim_iomap_regions() downward such that
pcim_iomap_regions() and ioaddr initialization can live in the same
if/else blocks.

>  	if (rc == -EBUSY)
>  		pcim_pin_device(pdev);
>  	if (rc)
> @@ -649,16 +678,32 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	for (i = 0; i < host->n_ports; i++) {
>  		struct ata_port *ap = host->ports[i];
>  		struct ata_ioports *ioaddr = &ap->ioaddr;
> -
> -		ioaddr->cmd_addr = mmio_base + sil_port[i].tf;
> -		ioaddr->altstatus_addr =
> -		ioaddr->ctl_addr = mmio_base + sil_port[i].ctl;
> -		ioaddr->bmdma_addr = mmio_base + sil_port[i].bmdma;
> -		ioaddr->scr_addr = mmio_base + sil_port[i].scr;
> -		ata_sff_std_ports(ioaddr);
> -
> -		ata_port_pbar_desc(ap, SIL_MMIO_BAR, -1, "mmio");
> -		ata_port_pbar_desc(ap, SIL_MMIO_BAR, sil_port[i].tf, "tf");
> +		void __iomem *tf_iobase = host->iomap[sil_ioport[i].tfbar];
> +		void __iomem *ctl_iobase = host->iomap[sil_ioport[i].ctlbar];

Please put a blank line here too.

> +		if (tfio) {
> +			ioaddr->cmd_addr = tf_iobase + sil_ioport[i].tf;
> +			ioaddr->altstatus_addr =
> +			ioaddr->ctl_addr = ctl_iobase + sil_ioport[i].ctl;
> +			ioaddr->bmdma_addr = mmio_base + sil_port[i].bmdma;
> +			ioaddr->scr_addr = mmio_base + sil_port[i].scr;

Hmm... so, mmio access to tf and ctl don't work but bmdma and scr are
okay?  Ah... it's those odd bytes accesses, right.  Anyways, please
put a brief comment explanining why it's useful and
ata_port_pbar_desc() or a dev_printk() to indicate that tfio mode is
in use.

Thanks.

-- 
tejun
