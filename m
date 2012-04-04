From: Thang Nguyen <tqnguyen@apm.com>
Subject: RE: [PATCH 1/1] Add support 2 SATA ports for Maui and change filename
 from sata_dwc_460ex.c to sata_dwc_4xx.c
Date: Wed, 4 Apr 2012 15:18:25 +0700
Message-ID: <c5426e824eda13201d89be15df61fa68@mail.gmail.com>
References: <1333447938-16461-1-git-send-email-tqnguyen@apm.com>
 <4F7AE584.3050805@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <4F7AE584.3050805@mvista.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-ide@vger.kernel.org

Thanks Sergei for quick response.
In the original driver (sata_dwc_460ex.c), an instance of the
sata_dwc_host_priv structure is declared and used globally. This will not
require functions to have ata_port structure or alternative structures
(ata_link, hsdev,...) to be declared in the function calls.

However, for supporting 2 ports, we can't use the sata_dwc_host_priv
structure as functions need to know what SATA port they are working on.
This is the reason why you see the ata_port, ata_link, sata_dwc_device,
sata_dwc_device_port,... structures declared in functions.

I will update the patch as your feedback and separate also the
bluestone.dts device tree to the another patch


Thanks and best regards,
Thang Nguyen -
Applied Micro

-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
Sent: Tuesday, April 03, 2012 6:57 PM
To: Thang Q. Nguyen
Cc: Benjamin Herrenschmidt; Paul Mackerras; Jeff Garzik; Grant Likely; Rob
Herring; linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org;
linux-ide@vger.kernel.org; devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 1/1] Add support 2 SATA ports for Maui and change
filename from sata_dwc_460ex.c to sata_dwc_4xx.c

Hello.

On 03-04-2012 14:12, Thang Q. Nguyen wrote:

> Signed-off-by: Thang Q. Nguyen<tqnguyen@apm.com>
> ---
> Changes for v2:
> 	- Use git rename feature to change the driver to the newname and
for
> 	  easier review.

>   arch/powerpc/boot/dts/bluestone.dts              |   21 +
>   drivers/ata/Makefile                             |    2 +-
>   drivers/ata/{sata_dwc_460ex.c =3D>  sata_dwc_4xx.c} | 1371
++++++++++++++--------
>   3 files changed, 904 insertions(+), 490 deletions(-)
>   rename drivers/ata/{sata_dwc_460ex.c =3D>  sata_dwc_4xx.c} (56%)

    You submitted a magapatch doing several things at once (some even
needlessly) and even in two areas of the kernel. This needs proper
splitting/description.

> diff --git a/arch/powerpc/boot/dts/bluestone.dts
b/arch/powerpc/boot/dts/bluestone.dts
> index cfa23bf..803fda6 100644
> --- a/arch/powerpc/boot/dts/bluestone.dts
> +++ b/arch/powerpc/boot/dts/bluestone.dts
> @@ -155,6 +155,27 @@
>   					/*RXDE*/  0x5 0x4>;
>   		};
>
> +		/* SATA DWC devices */
> +		SATA0: sata@bffd1000 {
> +			compatible =3D "amcc,sata-apm821xx";
> +			reg =3D<4 0xbffd1000 0x800   /* SATA0 */
> +			       4 0xbffd0800 0x400>; /* AHBDMA */
> +			dma-channel=3D<0>;
> +			interrupt-parent =3D<&UIC0>;
> +			interrupts =3D<26 4    /* SATA0 */
> +			              25 4>;  /* AHBDMA */
> +		};
> +
> +		SATA1: sata@bffd1800 {
> +			compatible =3D "amcc,sata-apm821xx";
> +			reg =3D<4 0xbffd1800 0x800   /* SATA1 */
> +			       4 0xbffd0800 0x400>; /* AHBDMA */
> +			dma-channel=3D<1>;
> +			interrupt-parent =3D<&UIC0>;
> +			interrupts =3D<27 4    /* SATA1 */
> +			              25 4>;  /* AHBDMA */
> +		};
> +
>   		POB0: opb {
>   			compatible =3D "ibm,opb";
>   			#address-cells =3D<1>;

    The above should be in a separate patch for PPC people, of course.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_4xx.c
> similarity index 56%
> rename from drivers/ata/sata_dwc_460ex.c
> rename to drivers/ata/sata_dwc_4xx.c
> index 69f7cde..bdbb35a 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_4xx.c
> @@ -1,5 +1,5 @@
>   /*
> - * drivers/ata/sata_dwc_460ex.c
> + * drivers/ata/sata_dwc_4xx.c

    This line should be removed altogether.

>    *
>    * Synopsys DesignWare Cores (DWC) SATA host driver
>    *
[...]
> @@ -135,13 +146,12 @@ enum {
>   	DMA_CTL_LLP_DSTEN =3D	0x08000000, /* Blk chain enable Dst */
>   };
>
> -#define	DMA_CTL_BLK_TS(size)	((size)&  0x000000FFF)	/* Blk
Transfer size */
> +#define DMA_CTL_BLK_TS(size)	((size)&  0x000000FFF)	/* Blk Transfer
size */

    Avoid random whitespoace changes.

>   #define DMA_CHANNEL(ch)		(0x00000001<<  (ch))	/* Select
channel */
>   	/* Enable channel */
> -#define	DMA_ENABLE_CHAN(ch)	((0x00000001<<  (ch)) |
\
> -				 ((0x000000001<<  (ch))<<  8))
> +#define	DMA_ENABLE_CHAN(ch)	(0x00000101<<  (ch))
>   	/* Disable channel */
> -#define	DMA_DISABLE_CHAN(ch)	(0x00000000 | ((0x000000001<<
(ch))<<  8))
> +#define	DMA_DISABLE_CHAN(ch)	(0x000000100<<  (ch))
>   	/* Transfer Type&  Flow Controller */

   These cleanups are not related to adding support for 2 channels

> @@ -298,43 +313,32 @@ struct sata_dwc_device_port {
>   #define HSDEV_FROM_QC(qc)	((struct sata_dwc_device *)\
>   					(qc)->ap->host->private_data)
>   #define HSDEV_FROM_HSDEVP(p)	((struct sata_dwc_device *)\
> -						(hsdevp)->hsdev)
> +					(hsdevp)->hsdev)

    Avoid random whitespoace changes.

> +/*
> + * Globals
> + */
> +static struct sata_dwc_device *dwc_dev_list[2];
> +static struct ahb_dma_regs *sata_dma_regs;

    This assumes that the system only has single controller, doesn't it?

>  /*
> - * Function: get_burst_length_encode
> - * arguments: datalength: length in bytes of data
> - * returns value to be programmed in register corresponding to data
length
> + * Calculate value to be programmed in register corresponding to data
length
>   * This value is effectively the log(base 2) of the length
>   */
> -static  int get_burst_length_encode(int datalength)
> +static int get_burst_length_encode(int datalength)

    Is it releated to adding support to 2 ports?

>   {
>   	int items =3D datalength>>  2;	/* div by 4 to get lword count */
>
> @@ -414,152 +416,205 @@ static  int get_burst_length_encode(int
datalength)
>   	return 0;
>   }
>
> -static  void clear_chan_interrupts(int c)
> +/*
> + * Clear channel interrupt. No interrupt for the specified channel
> + * generated until it is enabled again.
> + */
> +static void clear_chan_interrupts(int c)
>   {
> -	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.tfr.low),
> -		 DMA_CHANNEL(c));
> -	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.block.low),
> +	out_le32(&(sata_dma_regs->interrupt_clear.tfr.low),
DMA_CHANNEL(c));
> +	out_le32(&(sata_dma_regs->interrupt_clear.block.low),
DMA_CHANNEL(c));
> +	out_le32(&(sata_dma_regs->interrupt_clear.srctran.low),
>   		 DMA_CHANNEL(c));
> -	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.srctran.low),
> -		 DMA_CHANNEL(c));
> -	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.dsttran.low),
> -		 DMA_CHANNEL(c));
> -	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.error.low),
> +	out_le32(&(sata_dma_regs->interrupt_clear.dsttran.low),
>   		 DMA_CHANNEL(c));
> +	out_le32(&(sata_dma_regs->interrupt_clear.error.low),
DMA_CHANNEL(c));

    () with & are not necessary.

>   }
>
>   /*
> - * Function: dma_request_channel
> - * arguments: None
> - * returns channel number if available else -1
> - * This function assigns the next available DMA channel from the list
to the
> - * requester
> + * Check if the selected DMA channel is currently enabled.
>    */
> -static int dma_request_channel(void)
> +static int sata_dwc_dma_chk_en(int ch)
>   {
> -	int i;
> +	u32 dma_chan_reg;
> +	/* Read the DMA channel register */
> +	dma_chan_reg =3D in_le32(&(sata_dma_regs->dma_chan_en.low));
> +	/* Check if it is currently enabled */
> +	if (dma_chan_reg & DMA_CHANNEL(ch))
> +		return 1;
> +	return 0;
> +}

    Is this related to the claimed subject of adding support for 2 ports?

>
> -	for (i =3D 0; i<  DMA_NUM_CHANS; i++) {
> -		if
(!(in_le32(&(host_pvt.sata_dma_regs->dma_chan_en.low))&\
> -			DMA_CHANNEL(i)))
> -			return i;
> +/*
> + * Terminate the current DMA transfer
> + *
> + * Refer to the "Abnormal Transfer Termination" section
> + * Disable the corresponding bit in the ChEnReg register
> + * and poll that register to until the channel is terminated.
> + */
> +static void sata_dwc_dma_terminate(struct ata_port *ap, int dma_ch)
> +{
> +	int enabled =3D sata_dwc_dma_chk_en(dma_ch);
> +	/* If the channel is currenly in use, release it. */
> +	if (enabled)  {
> +		dev_dbg(ap->dev,
> +			"%s terminate DMA on channel=3D%d (mask=3D0x%08x)
...",
> +			__func__, dma_ch, DMA_DISABLE_CHAN(dma_ch));
> +		dev_dbg(ap->dev, "ChEnReg=3D0x%08x\n",
> +			in_le32(&(sata_dma_regs->dma_chan_en.low)));
> +		/* Disable the selected channel */
> +		out_le32(&(sata_dma_regs->dma_chan_en.low),
> +			DMA_DISABLE_CHAN(dma_ch));
> +
> +		/* Wait for the channel is disabled */
> +		do {
> +			enabled =3D sata_dwc_dma_chk_en(dma_ch);
> +			ndelay(1000);
> +		} while (enabled);
> +		dev_dbg(ap->dev, "done\n");
>   	}
> -	dev_err(host_pvt.dwc_dev, "%s NO channel chan_en: 0x%08x\n",
__func__,
> -		in_le32(&(host_pvt.sata_dma_regs->dma_chan_en.low)));
> +}

    Same question.

> +
> +/*
> + * Check if the DMA channel is currently available for transferring
data
> + * on the specified ata_port.
> + */
> +static int dma_request_channel(struct ata_port *ap)
> +{
> +	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
> +
> +	/* Check if the channel is not currently in use */
> +	if (!(in_le32(&(sata_dma_regs->dma_chan_en.low))&\
> +		DMA_CHANNEL(hsdev->dma_channel)))
> +		return hsdev->dma_channel;
> +
> +	dev_err(ap->dev, "%s Channel %d is currently in use\n", __func__,
> +		hsdev->dma_channel);
>   	return -1;
>   }

    Same question.

> +/*
> + * Registers ISR for a particular DMA channel interrupt
> + */
> +static int dma_request_interrupts(struct sata_dwc_device *hsdev, int
irq)
> +{
> +	int retval;
> +
> +	/* Unmask error interrupt */
> +	out_le32(&sata_dma_regs->interrupt_mask.error.low,
> +		in_le32(&sata_dma_regs->interrupt_mask.error.low) |
> +		 DMA_ENABLE_CHAN(hsdev->dma_channel));
> +
> +	/* Unmask end-of-transfer interrupt */
> +	out_le32(&sata_dma_regs->interrupt_mask.tfr.low,
> +		in_le32(&sata_dma_regs->interrupt_mask.tfr.low) |
> +		 DMA_ENABLE_CHAN(hsdev->dma_channel));
> +
> +	retval =3D request_irq(irq, dma_dwc_handler, IRQF_SHARED, "SATA
DMA",
> +		hsdev);
>   	if (retval) {
> -		dev_err(host_pvt.dwc_dev, "%s: could not get IRQ %d\n",
> +		dev_err(hsdev->dev, "%s: could not get IRQ %d\n",\
>   		__func__, irq);
>   		return -ENODEV;
>   	}
>
>   	/* Mark this interrupt as requested */
>   	hsdev->irq_dma =3D irq;
> +
>   	return 0;
>   }

    Same question.

>   /*
> - * Function: dma_dwc_exit
> - * arguments: None
> - * returns status
> - * This function exits the SATA DMA driver
> - */
> -static void dma_dwc_exit(struct sata_dwc_device *hsdev)
> -{
> -	dev_dbg(host_pvt.dwc_dev, "%s:\n", __func__);
> -	if (host_pvt.sata_dma_regs) {
> -		iounmap(host_pvt.sata_dma_regs);
> -		host_pvt.sata_dma_regs =3D NULL;
> -	}
> -
> -	if (hsdev->irq_dma) {
> -		free_irq(hsdev->irq_dma, hsdev);
> -		hsdev->irq_dma =3D 0;
> -	}
> -}

    Same question.

>   static int sata_dwc_scr_read(struct ata_link *link, unsigned int scr,
u32 *val)
>   {
> -	if (scr>  SCR_NOTIFICATION) {
> +	if (unlikely(scr>  SCR_NOTIFICATION)) {
>   		dev_err(link->ap->dev, "%s: Incorrect SCR offset
0x%02x\n",
>   			__func__, scr);
>   		return -EINVAL;
>   	}
>
>   	*val =3D in_le32((void *)link->ap->ioaddr.scr_addr + (scr * 4));
> -	dev_dbg(link->ap->dev, "%s: id=3D%d reg=3D%d val=3Dval=3D0x%08x\n",
> +	dev_dbg(link->ap->dev, "%s: id=3D%d reg=3D%d val=3D0x%08x\n",
>   		__func__, link->ap->print_id, scr, *val);
>
>   	return 0;
> @@ -828,7 +867,7 @@ static int sata_dwc_scr_write(struct ata_link *link,
unsigned int scr, u32 val)
>   {
>   	dev_dbg(link->ap->dev, "%s: id=3D%d reg=3D%d val=3Dval=3D0x%08x\n",
>   		__func__, link->ap->print_id, scr, val);
> -	if (scr>  SCR_NOTIFICATION) {
> +	if (unlikely(scr>  SCR_NOTIFICATION)) {
>   		dev_err(link->ap->dev, "%s: Incorrect SCR offset
0x%02x\n",
>   			 __func__, scr);
>   		return -EINVAL;

    Same question.

> @@ -838,23 +877,24 @@ static int sata_dwc_scr_write(struct ata_link
*link, unsigned int scr, u32 val)
>   	return 0;
>   }
>
> -static u32 core_scr_read(unsigned int scr)
> +static u32 core_scr_read(struct ata_port *ap, unsigned int scr)
>   {
> -	return in_le32((void __iomem *)(host_pvt.scr_addr_sstatus) +\
> -			(scr * 4));
> +	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);

    Insert empty line here, please.

> +	return in_le32((void __iomem *)hsdev->scr_base + (scr * 4));
>   }
>
> -static void core_scr_write(unsigned int scr, u32 val)
> +
> +static void core_scr_write(struct ata_port *ap, unsigned int scr, u32
val)
>   {
> -	out_le32((void __iomem *)(host_pvt.scr_addr_sstatus) + (scr * 4),
> -		val);
> +	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);

     And here.

> +	out_le32((void __iomem *)hsdev->scr_base + (scr * 4), val);
>   }
>
> -static void clear_serror(void)
> +static void clear_serror(struct ata_port *ap)
>   {
> -	u32 val;
> -	val =3D core_scr_read(SCR_ERROR);
> -	core_scr_write(SCR_ERROR, val);
> +	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);

    And here.

> +	out_le32((void __iomem *)hsdev->scr_base + 4,
> +		in_le32((void __iomem *)hsdev->scr_base + 4));
>
>   }
>
> @@ -864,12 +904,105 @@ static void clear_interrupt_bit(struct
sata_dwc_device *hsdev, u32 bit)
>   		 in_le32(&hsdev->sata_dwc_regs->intpr));
>   }
>
> +/*
> + * Porting the ata_bus_softreset function from the libata-sff.c
library.
> + */
> +static int sata_dwc_bus_softreset(struct ata_port *ap, unsigned int
devmask,
> +		unsigned long deadline)
> +{
> +	struct ata_ioports *ioaddr =3D&ap->ioaddr;
> +
> +	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
> +
> +	/* Software reset.  causes dev0 to be selected */
> +	iowrite8(ap->ctl, ioaddr->ctl_addr);
> +	udelay(20);	/* FIXME: flush */
> +	iowrite8(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
> +	udelay(20);	/* FIXME: flush */
> +	iowrite8(ap->ctl, ioaddr->ctl_addr);
> +	ap->last_ctl =3D ap->ctl;
> +
> +	/* Wait the port to become ready */
> +	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
> +}

    I don't see

> +
> +/*
> + * Do soft reset on the current SATA link.
> + */
> +static int sata_dwc_softreset(struct ata_link *link, unsigned int
*classes,
> +				unsigned long deadline)
> +{
> +	int rc;
> +	u8 err;
> +	struct ata_port *ap =3D link->ap;
> +	unsigned int devmask =3D 0;

    Why delcare it at all if it's always 0?

> +	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
> +
> +	/* Select device 0 again */
> +	ap->ops->sff_dev_select(ap, 0);
> +
> +	DPRINTK("about to softreset, devmask=3D%x\n", devmask);
> +	rc =3D sata_dwc_bus_softreset(ap, devmask, deadline);
> +
> +	/* If link is occupied, -ENODEV too is an error */
> +	if (rc && (rc !=3D -ENODEV || sata_scr_valid(link))) {
> +		ata_link_printk(link, KERN_ERR, "SRST failed(errno=3D%d)\n",
rc);
> +		return rc;
> +	}
> +
> +	/* Determine by signature whether we have ATA or ATAPI devices */
> +	classes[0] =3D ata_sff_dev_classify(&link->device[0],
> +				devmask&  (1<<  0),&err);

     Always 0, and it should be 1.

> +	DPRINTK("EXIT, classes[0]=3D%u [1]=3D%u\n", classes[0], classes[1]);

    classes[1] will always be empty.

> +	clear_serror(link->ap);
> +
> +	/* Terminate DMA if it is currently in use */
> +	sata_dwc_dma_terminate(link->ap, hsdev->dma_channel);

    Isn't it too late?

> +
> +	return rc;
> +}
> +
> +/*
> + * Reset all internal parameters to default value.
> + * This function should be called in hardreset
> + */
> +static void dwc_reset_internal_params(struct ata_port *ap)
> +{
> +	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
> +	int tag;

    Empty line here please.

> +	for (tag =3D 0; tag<  SATA_DWC_QCMD_MAX; tag++)
> +		hsdevp->dma_pending[tag] =3D SATA_DWC_DMA_PENDING_NONE;
> +
> +	hsdevp->sata_dwc_sactive_issued =3D 0;
> +	hsdevp->sata_dwc_sactive_queued =3D 0;
> +}
> +
> +static int sata_dwc_hardreset(struct ata_link *link, unsigned int
*classes,
> +			unsigned long deadline)
> +{
> +	int rc;
> +	const unsigned long *timing =3D
sata_ehc_deb_timing(&link->eh_context);
> +	bool online;
> +
> +	/* Reset internal parameters to default values */
> +	dwc_reset_internal_params(link->ap);
> +
> +	/* Call standard hard reset */
> +	rc =3D sata_link_hardreset(link, timing, deadline,&online, NULL);
> +
> +	/* Reconfigure the port after hard reset */
> +	if (ata_link_online(link))
> +		sata_dwc_init_port(link->ap);
> +
> +	return online ? -EAGAIN : rc;
> +}
> +

    What does this have to do with adding support for 2 ports again?

> @@ -918,11 +1049,7 @@ static void sata_dwc_error_intr(struct ata_port
*ap,
>   }
>
>   /*
> - * Function : sata_dwc_isr
> - * arguments : irq, void *dev_instance, struct pt_regs *regs
> - * Return value : irqreturn_t - status of IRQ
>   * This Interrupt handler called via port ops registered function.
> - * .irq_handler =3D sata_dwc_isr
>   */
>   static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
>   {
> @@ -930,14 +1057,14 @@ static irqreturn_t sata_dwc_isr(int irq, void
*dev_instance)
>   	struct sata_dwc_device *hsdev =3D HSDEV_FROM_HOST(host);
>   	struct ata_port *ap;
>   	struct ata_queued_cmd *qc;
> -	unsigned long flags;
>   	u8 status, tag;
> -	int handled, num_processed, port =3D 0;
> -	uint intpr, sactive, sactive2, tag_mask;
> +	int handled, port =3D 0;
> +	int num_lli;
> +	uint intpr, sactive, tag_mask;
>   	struct sata_dwc_device_port *hsdevp;
> -	host_pvt.sata_dwc_sactive_issued =3D 0;
> +	u32 mask;
>
> -	spin_lock_irqsave(&host->lock, flags);
> +	spin_lock(&host->lock);
>
>   	/* Read the interrupt register */
>   	intpr =3D in_le32(&hsdev->sata_dwc_regs->intpr);
> @@ -958,38 +1085,61 @@ static irqreturn_t sata_dwc_isr(int irq, void
*dev_instance)
>   	/* Check for DMA SETUP FIS (FP DMA) interrupt */
>   	if (intpr&  SATA_DWC_INTPR_NEWFP) {
>   		clear_interrupt_bit(hsdev, SATA_DWC_INTPR_NEWFP);
> +		if (ap->qc_allocated =3D=3D 0x0) {
> +			handled =3D 1;
> +			goto DONE;
> +		}
>
>   		tag =3D (u8)(in_le32(&hsdev->sata_dwc_regs->fptagr));
> +		mask =3D qcmd_tag_to_mask(tag);
>   		dev_dbg(ap->dev, "%s: NEWFP tag=3D%d\n", __func__, tag);
> -		if (hsdevp->cmd_issued[tag] !=3D SATA_DWC_CMD_ISSUED_PEND)
> +		if ((hsdevp->sata_dwc_sactive_queued&  mask) =3D=3D 0)
>   			dev_warn(ap->dev, "CMD tag=3D%d not pending?\n",
tag);
>
> -		host_pvt.sata_dwc_sactive_issued |=3D qcmd_tag_to_mask(tag);
> -
>   		qc =3D ata_qc_from_tag(ap, tag);
>   		/*
>   		 * Start FP DMA for NCQ command.  At this point the tag is
the
>   		 * active tag.  It is the tag that matches the command
about to
>   		 * be completed.
>   		 */
> -		qc->ap->link.active_tag =3D tag;
> -		sata_dwc_bmdma_start_by_tag(qc, tag);
> +		if (qc) {
> +			hsdevp->sata_dwc_sactive_issued |=3D mask;
> +			/* Prevent to issue more commands */
> +			qc->ap->link.active_tag =3D tag;
> +			qc->dev->link->sactive |=3D (1<<  qc->tag);
> +			num_lli =3D map_sg_to_lli(ap, qc->sg, qc->n_elem, \
> +				hsdevp->llit[tag], hsdevp->llit_dma[tag],
\
> +				(void
*__iomem)(&hsdev->sata_dwc_regs->dmadr), \
> +				qc->dma_dir);
> +			sata_dwc_bmdma_start_by_tag(qc, tag);
> +			wmb();
> +			qc->ap->hsm_task_state =3D HSM_ST_LAST;
> +		} else {
> +		    hsdevp->sata_dwc_sactive_issued&=3D ~mask;
> +		    dev_warn(ap->dev, "No QC available for tag %d (intpr=3D"
> +		    "0x%08x, qc_allocated=3D0x%08x, qc_active=3D0x%08x)\n",
tag,\
> +			intpr, ap->qc_allocated, ap->qc_active);

    Indent the above preperly with tabs.

> +		}
>
[...]
> @@ -1167,70 +1245,51 @@ static void sata_dwc_clear_dmacr(struct
sata_dwc_device_port *hsdevp, u8 tag)
>   	}
>   }
>
> -static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32
check_status)
> -{
> -	struct ata_queued_cmd *qc;
> -	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
> -	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
> -	u8 tag =3D 0;
> -
> -	tag =3D ap->link.active_tag;
> -	qc =3D ata_qc_from_tag(ap, tag);
> -	if (!qc) {
> -		dev_err(ap->dev, "failed to get qc");
> -		return;
> -	}
> -
> -#ifdef DEBUG_NCQ
> -	if (tag>  0) {
> -		dev_info(ap->dev, "%s tag=3D%u cmd=3D0x%02x dma dir=3D%s
proto=3D%s "
> -			 "dmacr=3D0x%08x\n", __func__, qc->tag,
qc->tf.command,
> -			 get_dma_dir_descript(qc->dma_dir),
> -			 get_prot_descript(qc->tf.protocol),
> -			 in_le32(&(hsdev->sata_dwc_regs->dmacr)));
> -	}
> -#endif
> -
> -	if (ata_is_dma(qc->tf.protocol)) {
> -		if (hsdevp->dma_pending[tag] =3D=3D SATA_DWC_DMA_PENDING_NONE)
{
> -			dev_err(ap->dev, "%s DMA protocol RX and TX DMA
not "
> -				"pending dmacr: 0x%08x\n", __func__,
> -				in_le32(&(hsdev->sata_dwc_regs->dmacr)));
> -		}
> -
> -		hsdevp->dma_pending[tag] =3D SATA_DWC_DMA_PENDING_NONE;
> -		sata_dwc_qc_complete(ap, qc, check_status);
> -		ap->link.active_tag =3D ATA_TAG_POISON;
> -	} else {
> -		sata_dwc_qc_complete(ap, qc, check_status);
> -	}
> -}

    What does this chenge have to do with the claimed target of thye
patch.

>   static int sata_dwc_qc_complete(struct ata_port *ap, struct
ata_queued_cmd *qc,
>   				u32 check_status)
>   {
> -	u8 status =3D 0;
> -	u32 mask =3D 0x0;
> +	u8 status;
> +	int i;
>   	u8 tag =3D qc->tag;
>   	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
> -	host_pvt.sata_dwc_sactive_queued =3D 0;
> +	u32 serror;
>   	dev_dbg(ap->dev, "%s checkstatus? %x\n", __func__, check_status);
>
> -	if (hsdevp->dma_pending[tag] =3D=3D SATA_DWC_DMA_PENDING_TX)
> -		dev_err(ap->dev, "TX DMA PENDING\n");
> -	else if (hsdevp->dma_pending[tag] =3D=3D SATA_DWC_DMA_PENDING_RX)
> -		dev_err(ap->dev, "RX DMA PENDING\n");
> +	/* Check main status, clearing INTRQ */
> +	status =3D ap->ops->sff_check_status(ap);
> +
> +	if (check_status) {
> +		i =3D 0;
> +		while (status&  ATA_BUSY) {
> +			if (++i>  10)
> +				break;
> +			status =3D ap->ops->sff_check_altstatus(ap);
> +		};
> +
> +		if (unlikely(status&  ATA_BUSY))
> +			dev_err(ap->dev, "QC complete cmd=3D0x%02x STATUS
BUSY "
> +				"(0x%02x) [%d]\n", qc->tf.command, status,
i);
> +		serror =3D core_scr_read(ap, SCR_ERROR);
> +		if (unlikely(serror&  SATA_DWC_SERROR_ERR_BITS))
> +			dev_err(ap->dev, "****** SERROR=3D0x%08x ******\n",
> +				serror);
> +	}
>   	dev_dbg(ap->dev, "QC complete cmd=3D0x%02x status=3D0x%02x ata%u:"
>   		" protocol=3D%d\n", qc->tf.command, status, ap->print_id,
>   		 qc->tf.protocol);
>
> -	/* clear active bit */
> -	mask =3D (~(qcmd_tag_to_mask(tag)));
> -	host_pvt.sata_dwc_sactive_queued =3D
(host_pvt.sata_dwc_sactive_queued) \
> -						&  mask;
> -	host_pvt.sata_dwc_sactive_issued =3D
(host_pvt.sata_dwc_sactive_issued) \
> -						&  mask;
> -	ata_qc_complete(qc);
> +	hsdevp->sata_dwc_sactive_issued&=3D ~qcmd_tag_to_mask(tag);
> +
> +	/* Complete taskfile transaction (does not read SCR registers) */
> +	if (ata_is_atapi(qc->tf.protocol))
> +		ata_sff_hsm_move(ap, qc, status, 0);
> +	else
> +		ata_qc_complete(qc);
> +
> +	if (hsdevp->sata_dwc_sactive_queued =3D=3D 0)
> +		ap->link.active_tag =3D ATA_TAG_POISON;
> +
>   	return 0;
>   }

    Same question.

> +static void sata_dwc_init_port(struct ata_port *ap)
> +{
> +	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
> +
> +	/* Configure DMA */
> +	if (ap->port_no =3D=3D 0)  {
> +		dev_dbg(ap->dev, "%s: clearing TXCHEN, RXCHEN in DMAC\n",
> +				__func__);
> +
> +		/* Clear all transmit/receive bits */
> +		out_le32(&hsdev->sata_dwc_regs->dmacr,
> +			 SATA_DWC_DMACR_TXRXCH_CLEAR);
> +
> +		dev_dbg(ap->dev, "%s: setting burst size DBTSR\n",
__func__);
> +		out_le32(&hsdev->sata_dwc_regs->dbtsr,
> +			 (SATA_DWC_DBTSR_MWR(AHB_DMA_BRST_DFLT) |
> +			  SATA_DWC_DBTSR_MRD(AHB_DMA_BRST_DFLT)));

    Why not put the above init. in a separate function, instead of
associating
with channehl 0?

> +	}
> +
> +	/* Enable interrupts */
> +	sata_dwc_enable_interrupts(hsdev);
> +}
> +
>   static void sata_dwc_setup_port(struct ata_ioports *port, unsigned
long base)
>   {
>   	port->cmd_addr =3D (void *)base + 0x00;
> @@ -1276,10 +1359,7 @@ static void sata_dwc_setup_port(struct
ata_ioports *port, unsigned long base)
>   }
>
>   /*
> - * Function : sata_dwc_port_start
> - * arguments : struct ata_ioports *port
> - * Return value : returns 0 if success, error code otherwise
> - * This function allocates the scatter gather LLI table for AHB DMA
> + * Allocates the scatter gather LLI table for AHB DMA
>    */
>   static int sata_dwc_port_start(struct ata_port *ap)
>   {
> @@ -1287,6 +1367,7 @@ static int sata_dwc_port_start(struct ata_port
*ap)
>   	struct sata_dwc_device *hsdev;
>   	struct sata_dwc_device_port *hsdevp =3D NULL;
>   	struct device *pdev;
> +	u32 sstatus;
>   	int i;
>
>   	hsdev =3D HSDEV_FROM_AP(ap);
> @@ -1308,12 +1389,10 @@ static int sata_dwc_port_start(struct ata_port
*ap)
>   		err =3D -ENOMEM;
>   		goto CLEANUP;
>   	}
> +	memset(hsdevp, 0, sizeof(*hsdevp));

   We already called kzalloc(), so the allocated buffer is already
cleared.

>   	hsdevp->hsdev =3D hsdev;
>
> -	for (i =3D 0; i<  SATA_DWC_QCMD_MAX; i++)
> -		hsdevp->cmd_issued[i] =3D SATA_DWC_CMD_ISSUED_NOT;
> -
> -	ap->bmdma_prd =3D 0;	/* set these so libata doesn't use them */
> +	ap->bmdma_prd =3D 0;  /* set these so libata doesn't use them */

    Avoid random whitespace changes.

> @@ -1347,32 +1426,47 @@ static int sata_dwc_port_start(struct ata_port
*ap)
>   	}
>
>   	/* Clear any error bits before libata starts issuing commands */
> -	clear_serror();
> +	clear_serror(ap);
>   	ap->private_data =3D hsdevp;
> +
> +	/* Are we in Gen I or II */
> +	sstatus =3D core_scr_read(ap, SCR_STATUS);
> +	switch (SATA_DWC_SCR0_SPD_GET(sstatus)) {
> +	case 0x0:
> +		dev_info(ap->dev, "**** No neg speed (nothing
attached?)\n");
> +		break;
> +	case 0x1:
> +		dev_info(ap->dev, "**** GEN I speed rate negotiated\n");
> +		break;
> +	case 0x2:
> +		dev_info(ap->dev, "**** GEN II speed rate negotiated\n");
> +		break;
> +	}
> +

    libata will negoptiate the speed, why this is needed?

>   static void sata_dwc_port_stop(struct ata_port *ap)
>   {
>   	int i;
> -	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
>   	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
>
>   	dev_dbg(ap->dev, "%s: ap->id =3D %d\n", __func__, ap->print_id);
>
> -	if (hsdevp&&  hsdev) {
> -		/* deallocate LLI table */
> +	if (hsdevp) {
> +		/* De-allocate LLI table */
>   		for (i =3D 0; i<  SATA_DWC_QCMD_MAX; i++) {
>   			dma_free_coherent(ap->host->dev,
> -					  SATA_DWC_DMAC_LLI_TBL_SZ,
> -					 hsdevp->llit[i],
hsdevp->llit_dma[i]);
> +				SATA_DWC_DMAC_LLI_TBL_SZ,
> +				hsdevp->llit[i], hsdevp->llit_dma[i]);

    It was properly indented before.

> @@ -1381,15 +1475,76 @@ static void sata_dwc_port_stop(struct ata_port
*ap)
>   }
>
>   /*
> - * Function : sata_dwc_exec_command_by_tag
> - * arguments : ata_port *ap, ata_taskfile *tf, u8 tag, u32 cmd_issued
> - * Return value : None
> - * This function keeps track of individual command tag ids and calls
> - * ata_exec_command in libata
> + * As our SATA is master only, no dev_select function needed.
> + * This just overwrite the ata_sff_dev_select() function in
> + * libata-sff
> + */
> +void sata_dwc_dev_select(struct ata_port *ap, unsigned int device)
> +{
> +	ndelay(100);

    Why?

> +}
> +
> +/**
> + * Filter ATAPI cmds which are unsuitable for DMA.
> + *
> + * The bmdma engines cannot handle speculative data sizes
> + * (bytecount under/over flow). So only allow DMA for
> + * data transfer commands with known data sizes.
> + */
> +static int sata_dwc_check_atapi_dma(struct ata_queued_cmd *qc)
> +{
> +	struct scsi_cmnd *scmd =3D qc->scsicmd;
> +	int pio =3D 1; /* ATAPI DMA disabled by default */
> +	unsigned int lba;
> +
> +	if (scmd) {
> +		switch (scmd->cmnd[0]) {
> +		case WRITE_6:
> +		case WRITE_10:
> +		case WRITE_12:
> +		case READ_6:
> +		case READ_10:
> +		case READ_12:
> +			pio =3D 0; /* DMA is safe */
> +			break;
> +		}
> +
> +		/* Command WRITE_10 with LBA between -45150 (FFFF4FA2)
> +		 * and -1 (FFFFFFFF) shall use PIO mode */
> +		if (scmd->cmnd[0] =3D=3D WRITE_10) {
> +			lba =3D (scmd->cmnd[2]<<  24) |
> +				(scmd->cmnd[3]<<  16) |
> +				(scmd->cmnd[4]<<  8) |
> +				 scmd->cmnd[5];
> +			if (lba>=3D 0xFFFF4FA2)
> +				pio =3D 1;
> +		}
> +		/*
> +		* WORK AROUND: Fix DMA issue when blank CD/DVD disc
> +		* in the drive and user use the 'fdisk -l' command.
> +		* No DMA data returned so we can not complete the QC.
> +		*/
> +		if (scmd->cmnd[0] =3D=3D READ_10) {
> +			lba =3D (scmd->cmnd[2]<<  24) |
> +				  (scmd->cmnd[3]<<  16) |
> +				  (scmd->cmnd[4]<<  8) |
> +				   scmd->cmnd[5];
> +			if (lba<  0x20)
> +				pio =3D 1;
> +		}
> +	}
> +	dev_dbg(qc->ap->dev, "%s - using %s mode for command
cmd=3D0x%02x\n", \
> +		__func__, (pio ? "PIO" : "DMA"), scmd->cmnd[0]);
> +	return pio;
> +}

    ATAPI support is a different matter then 2-port support. Needs to be
in a
separate patch.

> @@ -1437,42 +1588,54 @@ static void sata_dwc_bmdma_start_by_tag(struct
ata_queued_cmd *qc, u8 tag)
[...]
>   	dev_dbg(ap->dev, "%s qc=3D%p tag: %x cmd: 0x%02x dma_dir: %s "
>   		"start_dma? %x\n", __func__, qc, tag, qc->tf.command,
>   		get_dma_dir_descript(qc->dma_dir), start_dma);
> -	sata_dwc_tf_dump(&(qc->tf));
> +	sata_dwc_tf_dump(hsdev->dev, &(qc->tf));

    () with & not necessary.

>
> +	/* Enable to start DMA transfer */
>   	if (start_dma) {
> -		reg =3D core_scr_read(SCR_ERROR);
> -		if (reg&  SATA_DWC_SERROR_ERR_BITS) {
> +		reg =3D core_scr_read(ap, SCR_ERROR);
> +		if (unlikely(reg&  SATA_DWC_SERROR_ERR_BITS)) {
>   			dev_err(ap->dev, "%s: ****** SError=3D0x%08x
******\n",
>   				__func__, reg);

    libata will print SError register...

>   		}
>
> -		if (dir =3D=3D DMA_TO_DEVICE)
> +		if (dir =3D=3D DMA_TO_DEVICE) {
>   			out_le32(&hsdev->sata_dwc_regs->dmacr,
>   				SATA_DWC_DMACR_TXCHEN);
> -		else
> +		} else {
>   			out_le32(&hsdev->sata_dwc_regs->dmacr,
>   				SATA_DWC_DMACR_RXCHEN);
> +		}
>
>   		/* Enable AHB DMA transfer on the specified channel */
> -		dma_dwc_xfer_start(dma_chan);
> +		dwc_dma_xfer_start(dma_chan);
> +		hsdevp->sata_dwc_sactive_queued&=3D ~qcmd_tag_to_mask(tag);
>   	}
>   }
> @@ -1490,34 +1653,98 @@ static void sata_dwc_bmdma_start(struct
ata_queued_cmd *qc)
>   	sata_dwc_bmdma_start_by_tag(qc, tag);
>   }
>
> +static u8 sata_dwc_dma_status(struct ata_port *ap)
> +{
> +	u32 status =3D 0;
> +	u32 tfr_reg, err_reg;
> +	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
> +
> +	/* Check DMA register for status */
> +	tfr_reg =3D in_le32(&(sata_dma_regs->interrupt_status.tfr.low));
> +	err_reg =3D in_le32(&(sata_dma_regs->interrupt_status.error.low));
> +
> +	if (unlikely(err_reg&  DMA_CHANNEL(hsdev->dma_channel)))
> +		status =3D ATA_DMA_ERR | ATA_DMA_INTR;

    Error bit in BMIDE (SFF-8038i) specification doesn't cause interrupt.

> +	else if (tfr_reg&  DMA_CHANNEL(hsdev->dma_channel))
> +		status =3D ATA_DMA_INTR;
> +	return status;
> +}
> +
[...]
> +
> +int sata_dwc_qc_defer(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap =3D qc->ap;
> +	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
> +	u8 status;
> +	int ret;
> +
> +	dev_dbg(qc->ap->dev, "%s -\n", __func__);
> +	ret =3D ata_std_qc_defer(qc);
> +	if (ret) {
> +		printk(KERN_DEBUG "STD Defer %s cmd %s tag=3D%d\n",
> +			(ret =3D=3D ATA_DEFER_LINK) ? "LINK" : "PORT",
> +			ata_get_cmd_descript(qc->tf.command), qc->tag);
> +		return ret;
> +	}
> +
> +	/* Check the SATA host for busy status */
> +	if (ata_is_ncq(qc->tf.protocol)) {
> +		status =3D ap->ops->sff_check_altstatus(ap);
> +		if (status&  ATA_BUSY) {
> +			dev_dbg(ap->dev,
> +				"Defer PORT cmd %s tag=3D%d as host is
busy\n",
> +				ata_get_cmd_descript(qc->tf.command),
qc->tag);
> +			return ATA_DEFER_PORT;/*HOST BUSY*/
> +		}
> +
> +		/* This will prevent collision error */
> +		if (hsdevp->sata_dwc_sactive_issued) {
> +			dev_dbg(ap->dev, "Defer PORT cmd %s with tag %d "
\
> +				"because another dma xfer is
outstanding\n",
> +				ata_get_cmd_descript(qc->tf.command),
qc->tag);

    What kind of NCQ is this if you can't start another comamnd when some
are
active already?!

> +
> +			return ATA_DEFER_PORT;/*DEVICE&HOST BUSY*/
> +		}
> +
> +	}
> +
> +	return 0;
> +}

> +void sata_dwc_exec_command(struct ata_port *ap, const struct
ata_taskfile *tf)
> +{
> +	iowrite8(tf->command, ap->ioaddr.command_addr);
> +	/* If we have an mmio device with no ctl and no altstatus
> +	 * method, this will fail. No such devices are known to exist.
> +	 */
> +	if (ap->ioaddr.altstatus_addr)

    Isn't it always set?

> +		ioread8(ap->ioaddr.altstatus_addr);
> +
> +	ndelay(400);
>   }

    Why duplicate the standard sff_exec_command() method at all?

> @@ -1525,6 +1752,8 @@ static unsigned int sata_dwc_qc_issue(struct
ata_queued_cmd *qc)
>   	u32 sactive;
>   	u8 tag =3D qc->tag;
>   	struct ata_port *ap =3D qc->ap;
> +	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(qc->ap);
> +	u8 status;
>
>   #ifdef DEBUG_NCQ
>   	if (qc->tag>  0 || ap->link.sactive>  1)
> @@ -1541,50 +1770,148 @@ static unsigned int sata_dwc_qc_issue(struct
ata_queued_cmd *qc)
>   	sata_dwc_qc_prep_by_tag(qc, tag);
>
>   	if (ata_is_ncq(qc->tf.protocol)) {
> -		sactive =3D core_scr_read(SCR_ACTIVE);
> +		status =3D ap->ops->sff_check_altstatus(ap);
> +		if (status&  ATA_BUSY) {
> +			/* Ignore the QC when device is BUSY */
> +			sactive =3D core_scr_read(qc->ap, SCR_ACTIVE);
> +			dev_info(ap->dev, "Ignore current QC as device
BUSY"
> +				"tag=3D%d, sactive=3D0x%08x)\n", qc->tag,
sactive);
> +			return AC_ERR_SYSTEM;
> +		}
> +
> +		if (hsdevp->sata_dwc_sactive_issued)
> +			return AC_ERR_SYSTEM;

    Very strange NCQ... was there a point in implementing it at all?

> +
> +		sactive =3D core_scr_read(qc->ap, SCR_ACTIVE);
>   		sactive |=3D (0x00000001<<  tag);
> -		core_scr_write(SCR_ACTIVE, sactive);
> +		qc->dev->link->sactive |=3D (0x00000001<<  tag);

    () not needed.

> +		core_scr_write(qc->ap, SCR_ACTIVE, sactive);
>
>   		dev_dbg(qc->ap->dev, "%s: tag=3D%d ap->link.sactive =3D 0x%08x
"
> -			"sactive=3D0x%08x\n", __func__, tag,
qc->ap->link.sactive,
> +			"sactive=3D0x%x\n", __func__, tag,
qc->ap->link.sactive,

    Why?

>   			sactive);
>
>   		ap->ops->sff_tf_load(ap,&qc->tf);
> -		sata_dwc_exec_command_by_tag(ap,&qc->tf, qc->tag,
> -					     SATA_DWC_CMD_ISSUED_PEND);
> +		sata_dwc_exec_command_by_tag(ap,&qc->tf, qc->tag);
>   	} else {
> -		ata_sff_qc_issue(qc);
> +		ap->link.active_tag =3D qc->tag;
> +		/* Pass QC to libata-sff to process */
> +		ata_bmdma_qc_issue(qc);

    This don't have to do with the claimed subject of the patch.

>   	}
>   	return 0;
>   }
>
>   /*
> - * Function : sata_dwc_qc_prep
> - * arguments : ata_queued_cmd *qc
> - * Return value : None
> - * qc_prep for a particular queued command
> + * Prepare for a particular queued command
>    */
>
>   static void sata_dwc_qc_prep(struct ata_queued_cmd *qc)
>   {
> -	if ((qc->dma_dir =3D=3D DMA_NONE) || (qc->tf.protocol =3D=3D
ATA_PROT_PIO))
> +	if ((qc->dma_dir =3D=3D DMA_NONE) || (qc->tf.protocol =3D=3D ATA_PROT_P=
IO)
> +		|| (qc->tf.protocol =3D=3D ATAPI_PROT_PIO))

    Adding support for ATAPI is another matter than adding support for two

ports. Should be in a patch of its own.

>   		return;
>
>   #ifdef DEBUG_NCQ
>   	if (qc->tag>  0)
>   		dev_info(qc->ap->dev, "%s: qc->tag=3D%d
ap->active_tag=3D0x%08x\n",
>   			 __func__, qc->tag, qc->ap->link.active_tag);
> -
> -	return ;
>   #endif
>   }
>
> +/*
> + * Get the QC currently used for transferring data
> + */
> +static struct ata_queued_cmd *sata_dwc_get_active_qc(struct ata_port
*ap)
> +{
> +	struct ata_queued_cmd *qc;
> +
> +	qc =3D ata_qc_from_tag(ap, ap->link.active_tag);
> +	if (qc&&  !(qc->tf.flags&  ATA_TFLAG_POLLING))
> +		return qc;
> +	return NULL;
> +}
> +
> +/*
> + * dwc_lost_interrupt -  check and process if interrupt is lost.
> + * @ap: ATA port
> + *
> + * Process the command when it is timeout.
> + * Check to see if interrupt is lost. If yes, complete the qc.
> + */
> +static void sata_dwc_lost_interrupt(struct ata_port *ap)
> +{
> +	u8 status;
> +	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
> +	struct ata_queued_cmd *qc;
> +
> +	dev_dbg(ap->dev, "%s -\n", __func__);
> +	/* Only one outstanding command per SFF channel */
> +	qc =3D sata_dwc_get_active_qc(ap);
> +	/* We cannot lose an interrupt on a non-existent or polled command
*/
> +	if (!qc)
> +		return;
> +
> +	/* See if the controller thinks it is still busy - if so the
command
> +	 isn't a lost IRQ but is still in progress */
> +	status =3D ap->ops->sff_check_altstatus(ap);
> +	if (status&  ATA_BUSY) {
> +		ata_port_printk(ap, KERN_INFO, "%s - ATA_BUSY\n",
__func__);
> +		return;
> +	}
> +
> +	/* There was a command running, we are no longer busy and we have
> +	   no interrupt. */
> +	ata_link_printk(qc->dev->link, KERN_WARNING,
> +		"lost interrupt (Status 0x%x)\n", status);
> +
> +	if (sata_dwc_dma_chk_en(hsdev->dma_channel)) {
> +		/* When DMA does transfer does not complete,
> +		 see if DMA fails */
> +		qc->err_mask |=3D AC_ERR_DEV;
> +		ap->hsm_task_state =3D HSM_ST_ERR;
> +		sata_dwc_dma_terminate(ap, hsdev->dma_channel);
> +	}
> +	sata_dwc_qc_complete(ap, qc, 1);
> +}
> +
 > +
>  static void sata_dwc_error_handler(struct ata_port *ap)
>  {
> -	ap->link.flags |=3D ATA_LFLAG_NO_HRST;
> +	bool thaw =3D false;
> +	struct ata_queued_cmd *qc;
> +	u8 status =3D ap->ops->bmdma_status(ap);
> +
> +	qc =3D sata_dwc_get_active_qc(ap);
> +	/* In case of DMA timeout, process it. */
> +	if (qc && ata_is_dma(qc->tf.protocol)) {
> +		if ((qc->err_mask =3D=3D AC_ERR_TIMEOUT)
> +			&& (status & ATA_DMA_ERR)) {
> +			qc->err_mask =3D AC_ERR_HOST_BUS;
> +			thaw =3D true;
> +		}
> +
> +		if (thaw) {
> +			ap->ops->sff_check_status(ap);
> +			if (ap->ops->sff_irq_clear)
> +				ap->ops->sff_irq_clear(ap);
> +		}
> +	}
> +	if (thaw)
> +		ata_eh_thaw_port(ap);
> +
>  	ata_sff_error_handler(ap);
>  }
>

    I don't think this goes well with adding support for 2 ports. Seems to
be
material for another patch.

[...]
> +u8 sata_dwc_check_status(struct ata_port *ap)
> +{
> +	return ioread8(ap->ioaddr.status_addr);
> +}

    This method is equivalent to ata_sff_check_status(), why redefine it?

> +
> +u8 sata_dwc_check_altstatus(struct ata_port *ap)
> +{
> +	return ioread8(ap->ioaddr.altstatus_addr);
> +}

    This method is optional. The above is equivalent to the default
implementnation, why redefine it?

> @@ -1604,7 +1931,10 @@ static struct ata_port_operations sata_dwc_ops =3D
{
>   	.inherits		=3D&ata_sff_port_ops,
>
>   	.error_handler		=3D sata_dwc_error_handler,
> +	.softreset		=3D sata_dwc_softreset,
> +	.hardreset		=3D sata_dwc_hardreset,
>
> +	.qc_defer		=3D sata_dwc_qc_defer,
>   	.qc_prep		=3D sata_dwc_qc_prep,
>   	.qc_issue		=3D sata_dwc_qc_issue,
>
> @@ -1614,8 +1944,17 @@ static struct ata_port_operations sata_dwc_ops =3D
{
>   	.port_start		=3D sata_dwc_port_start,
>   	.port_stop		=3D sata_dwc_port_stop,
>
> +	.check_atapi_dma	=3D sata_dwc_check_atapi_dma,
>   	.bmdma_setup		=3D sata_dwc_bmdma_setup,
>   	.bmdma_start		=3D sata_dwc_bmdma_start,
> +	.bmdma_status		=3D sata_dwc_dma_status,
> +
> +	.sff_dev_select		=3D sata_dwc_dev_select,
> +	.sff_check_status	=3D sata_dwc_check_status,
> +	.sff_check_altstatus	=3D sata_dwc_check_altstatus,
> +	.sff_exec_command	=3D sata_dwc_exec_command,
> +
> +	.lost_interrupt		=3D sata_dwc_lost_interrupt,
>   };
>
>   static const struct ata_port_info sata_dwc_port_info[] =3D {
> @@ -1639,21 +1978,49 @@ static int sata_dwc_probe(struct platform_device
*ofdev)
>   	struct ata_port_info pi =3D sata_dwc_port_info[0];
>   	const struct ata_port_info *ppi[] =3D {&pi, NULL };
 >

    Why empty line here?

> +	const unsigned int *dma_chan;
> +
>   	/* Allocate DWC SATA device */
> -	hsdev =3D kzalloc(sizeof(*hsdev), GFP_KERNEL);
> +	hsdev =3D kmalloc(sizeof(*hsdev), GFP_KERNEL);

    Why change kzalloc() to kmalloc() if you do memset() later?

>   	if (hsdev =3D=3D NULL) {
>   		dev_err(&ofdev->dev, "kmalloc failed for hsdev\n");
>   		err =3D -ENOMEM;
> -		goto error;
> +		goto error_out_5;
>   	}
> +	memset(hsdev, 0, sizeof(*hsdev));
>
[...]
> +	/* Identify SATA controller index from the cell-index property */

    Comment don't match the code?

> +	dma_chan =3D of_get_property(ofdev->dev.of_node, "dma-channel",
NULL);
> +	if (dma_chan) {
> +		dev_notice(&ofdev->dev, "Getting DMA channel %d\n",
*dma_chan);
> +		hsdev->dma_channel =3D *dma_chan;
> +	} else {
> +		hsdev->dma_channel =3D 0;
> +	}
> +
[...]
> @@ -1777,7 +2159,18 @@ static struct platform_driver sata_dwc_driver =3D {
>   	.remove =3D sata_dwc_remove,
>   };
>
> -module_platform_driver(sata_dwc_driver);
> +static int __init sata_dwc_init(void)
> +{
> +	return platform_driver_register(&sata_dwc_driver);
> +}
> +
> +static void __exit sata_dwc_exit(void)
> +{
> +	platform_driver_unregister(&sata_dwc_driver);
> +}
> +
> +module_init(sata_dwc_init);
> +module_exit(sata_dwc_exit);

    Why you changed this from module_platfrom_driver()?

MBR, Sergei
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, =

is for the sole use of the intended recipient(s) and contains information=
=A0
that is confidential and proprietary to AppliedMicro Corporation or its sub=
sidiaries. =

It is to be used solely for the purpose of furthering the parties' business=
 relationship. =

All unauthorized review, use, disclosure or distribution is prohibited. =

If you are not the intended recipient, please contact the sender by reply e=
-mail =

and destroy all copies of the original message.
