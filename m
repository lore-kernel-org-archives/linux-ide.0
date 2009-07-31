From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Implement SATA AHCI FIS-based switching support
Date: Fri, 31 Jul 2009 15:17:34 +0900
Message-ID: <4A728C7E.7080307@kernel.org>
References: <1248947988.3341.5.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52795 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbZGaGSn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Jul 2009 02:18:43 -0400
In-Reply-To: <1248947988.3341.5.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello, Shane.

Shane Huang wrote:
> Implement SATA AHCI FIS-based switching support.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> 
> diff -ruNp a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> --- a/drivers/ata/ahci.c	2009-07-29 14:38:39.000000000 +0800
> +++ b/drivers/ata/ahci.c	2009-07-30 17:10:40.000000000 +0800
> @@ -93,6 +93,8 @@ enum {
>  	AHCI_CMD_TBL_AR_SZ	= AHCI_CMD_TBL_SZ * AHCI_MAX_CMDS,
>  	AHCI_PORT_PRIV_DMA_SZ	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_AR_SZ +
>  				  AHCI_RX_FIS_SZ,
> +	AHCI_PORT_PRIV_FBS_DMA	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_AR_SZ +
> +				  (AHCI_RX_FIS_SZ * 16),

AHCI_PORT_PRIV_FBS_DMA_SZ

> +	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
> +	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
> +	PORT_FBS_DEV_OFFSET	= 8,  /* FBS device to issue offset */
> +	PORT_FBS_DEV		= (0xf << PORT_FBS_DEV_OFFSET),  /* FBS.DEV */

PORT_FBS_DEV_MASK

> +	PORT_FBS_SDE		= (1 << 2), /* FBS single device error */
> +	PORT_FBS_DEC		= (1 << 1), /* FBS device error clear */
> +	PORT_FBS_EN		= (1 << 0), /* Enable FBS */
> +
>  	/* hpriv->flags bits */
>  	AHCI_HFLAG_NO_NCQ		= (1 << 0),
>  	AHCI_HFLAG_IGN_IRQ_IF_ERR	= (1 << 1), /* ignore IRQ_IF_ERR */
> @@ -284,6 +297,9 @@ struct ahci_port_priv {
>  	unsigned int		ncq_saw_dmas:1;
>  	unsigned int		ncq_saw_sdb:1;
>  	u32 			intr_mask;	/* interrupts to enable */
> +	int			fbs_enabled;	/* set iff FBS is enabled */
> +	int			fbs_last_dev;	/* save FBS.DEV of last FIS */
> +	int			fbs_need_dec;	/* need clear device error */

fbs_enabled and fbs_need_dec can probably be bool or bool bitfields.

> @@ -1582,12 +1603,21 @@ static int ahci_kick_engine(struct ata_p
>  {
>  	void __iomem *port_mmio = ahci_port_base(ap);
>  	struct ahci_host_priv *hpriv = ap->host->private_data;
> -	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
> +	struct ahci_port_priv *pp = ap->private_data;
> +	u8 status;
>  	u32 tmp;
>  	int busy, rc;
>  
> -	/* do we need to kick the port? */
> -	busy = status & (ATA_BUSY | ATA_DRQ);
> +	/* do we need to kick the port?
> +	 * It is unsafe to refer to PxTFD register to determine
> +	 * command completion when doing FBS. (AHCI-1.2 9.3.7)
> +	 */
> +	if (pp->fbs_enabled && (ap->nr_active_links >= 2))
> +		busy = readl(port_mmio + PORT_CMD_ISSUE);
> +	else {
> +		status = readl(port_mmio + PORT_TFDATA) & 0xFF;
> +		busy = status & (ATA_BUSY | ATA_DRQ);
> +	}

Hmmm... the only case where @force_start is zero is when it's called
from ahci_p5wdh_hardreset() in which case FBS or not doesn't make any
difference.  Actually at that point, BSY is pretty much guaranteed to
be set.  Can you please add a prep patch which kills @force_restart?

>  static int ahci_check_ready(struct ata_link *link)
>  {
> -	void __iomem *port_mmio = ahci_port_base(link->ap);
> -	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
> +	struct ata_port *ap = link->ap;
> +	struct ahci_port_priv *pp = ap->private_data;
> +	void __iomem *port_mmio = ahci_port_base(ap);
> +	u8 status = 0;
> +
> +	/* It is unsafe to refer to PxTFD register to determine
> +	 * command completion when doing FBS. (AHCI-1.2 9.3.7)
> +	 */
> +	if (pp->fbs_enabled && (ap->nr_active_links >= 2)) {
> +		u32 tmp = readl(port_mmio + PORT_CMD_ISSUE);
> +		if (tmp)
> +			status |= ATA_BUSY;
> +	} else
> +		status = readl(port_mmio + PORT_TFDATA) & 0xFF;

The problem with this is that ahci_check_ready() isn't always used
with command issues.  For hardresets, the above wouldn't wait for the
first D2H Reg FIS properly.  The correct way to do this is to set BSY
in the respective FIS RX area for D2H Reg and then wait till it gets
cleared.  Please take a look at how ahci_hardreset() waits for the
first D2H Reg FIS.

> @@ -1732,8 +1774,10 @@ static int ahci_softreset(struct ata_lin
>  
>  static int ahci_sb600_check_ready(struct ata_link *link)
>  {
> -	void __iomem *port_mmio = ahci_port_base(link->ap);
> -	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
> +	struct ata_port *ap = link->ap;
> +	struct ahci_port_priv *pp = ap->private_data;
> +	void __iomem *port_mmio = ahci_port_base(ap);
> +	u8 status = 0;
>  	u32 irq_status = readl(port_mmio + PORT_IRQ_STAT);
>  
>  	/*
> @@ -1743,6 +1787,16 @@ static int ahci_sb600_check_ready(struct
>  	if (irq_status & PORT_IRQ_BAD_PMP)
>  		return -EIO;
>  
> +	/* It is unsafe to refer to PxTFD register to determine
> +	 * command completion when doing FBS. (AHCI-1.2 9.3.7)
> +	 */
> +	if (pp->fbs_enabled && (ap->nr_active_links >= 2)) {
> +		u32 tmp = readl(port_mmio + PORT_CMD_ISSUE);
> +		if (tmp)
> +			status |= ATA_BUSY;
> +	} else
> +		status = readl(port_mmio + PORT_TFDATA) & 0xFF;
> +

Ditto.

> @@ -1967,12 +2032,25 @@ static void ahci_error_intr(struct ata_p
>  	struct ata_link *link = NULL;
>  	struct ata_queued_cmd *active_qc;
>  	struct ata_eh_info *active_ehi;
> -	u32 serror;
> +	void __iomem *port_mmio = ahci_port_base(ap);
> +	u32 serror, fbs = 0;
> +	int rc = 0;
>  
> -	/* determine active link */
> +	if (pp->fbs_enabled)
> +		fbs = readl(port_mmio + PORT_FBS);
> +
> +	/* determine active link with error */
>  	ata_for_each_link(link, ap, EDGE)
> -		if (ata_link_active(link))
> -			break;
> +		if (ata_link_active(link)) {
> +			if (!pp->fbs_enabled)
> +				break;
> +			if ((fbs & PORT_FBS_SDE) &&
> +			    (link->pmp == (fbs >> PORT_FBS_DWE_OFFSET)))
> +				break;
> +			rc = sata_scr_read(link, SCR_ERROR, &serror);
> +			if ((rc == 0) && serror)
> +				break;
> +		}

This really should look like

if (pp->fbs_enabled) {
	read fbs;
	determine failed link according to fbs;
} else
	look for the first (and only) active link;

Also, you can't read SCR_ERROR of PMP link from interrupt handler.
Why does the interrupt handler need to care about that?  If it's SDE,
the interrupt handler clears the condition and drains other commands
and then pass the port to EH, if not, everything should be aborted and
EH can take over immediately.

> @@ -2046,7 +2133,11 @@ static void ahci_error_intr(struct ata_p
>  	if (irq_stat & PORT_IRQ_FREEZE)
>  		ata_port_freeze(ap);
>  	else
> -		ata_port_abort(ap);
> +		if (pp->fbs_enabled && pp->fbs_need_dec &&
> +		    !ata_is_host_link(link))
> +			ata_link_abort(link);
> +		else
> +			ata_port_abort(ap);

DEC should be done here so that the controller can execute the
remaining commands.  The sequence on SDE should look like the
following.

1. SDE detected, interrupt handler invoked.

2. interrupt handler determines which device failed and records
   in-flight commands for the device failed (ata_link_abort()).

3. interrupt handler does DEC so that controller can continue handling
   commands for other devices.

4. When all commands in flight for other devices complete (may succeed
   or fail), EH takes over.

>  static void ahci_port_intr(struct ata_port *ap)
> @@ -2098,12 +2189,17 @@ static void ahci_port_intr(struct ata_po
>  			/* If the 'N' bit in word 0 of the FIS is set,
>  			 * we just received asynchronous notification.
>  			 * Tell libata about it.
> +			 *
> +			 * Lack of SNotification should not appear in
> +			 * ahci 1.2, so the workaround is unnecessary
> +			 * when FBS is enabled.
>  			 */
> -			const __le32 *f = pp->rx_fis + RX_FIS_SDB;
> -			u32 f0 = le32_to_cpu(f[0]);
> -
> -			if (f0 & (1 << 15))
> -				sata_async_notification(ap);
> +			if (!pp->fbs_enabled) {
> +				const __le32 *f = pp->rx_fis + RX_FIS_SDB;
> +				u32 f0 = le32_to_cpu(f[0]);
> +				if (f0 & (1 << 15))
> +					sata_async_notification(ap);
> +			}

It would probably be nice to warn during attach if controller reports
FBS but doesn't have SNotification.

> +static int ahci_eh_fbs_dec(struct ata_port *ap)
> +{
> +	struct ahci_port_priv *pp = ap->private_data;
> +	DPRINTK("ENTER\n");
> +
> +	if (pp->fbs_enabled) {
> +		void __iomem *port_mmio = ahci_port_base(ap);
> +		u32 fbs = readl(port_mmio + PORT_FBS);
> +
> +		writel(fbs | PORT_FBS_DEC, port_mmio + PORT_FBS);
> +		fbs = readl(port_mmio + PORT_FBS);
> +		if (fbs & PORT_FBS_DEC)
> +			return -EIO;
> +	} else {
> +		dev_printk(KERN_ERR, ap->host->dev,
> +			   "PMP is not used or FBS is disabled.\n");
> +		return -ENODEV;
> +	}

>From the spec, it looks like the controller might take some time to
clear DEC although it doesn't specify how long.  Maybe adding retry
loop is a good idea?

>  static void ahci_error_handler(struct ata_port *ap)
>  {
> +	struct ahci_port_priv *pp = ap->private_data;
> +
>  	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
>  		/* restart engine */
>  		ahci_stop_engine(ap);
>  		ahci_start_engine(ap);
>  	}
>  
> -	sata_pmp_error_handler(ap);
> +	if (pp->fbs_enabled && pp->fbs_need_dec) {
> +		int rc = ahci_eh_fbs_dec(ap);
> +		pp->fbs_need_dec = 0;

As written above, DEC should be done _before_ EH takes over.  Once EH
takes over DEC doesn't make much sense.  We're gonna reset (kick) the
controller anyway.

> @@ -2377,11 +2600,19 @@ static int ahci_port_start(struct ata_po
>  	if (!pp)
>  		return -ENOMEM;
>  
> -	mem = dmam_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma,
> -				  GFP_KERNEL);
> +	if (ahci_fbs_supported(ap))
> +		mem = dmam_alloc_coherent(dev, AHCI_PORT_PRIV_FBS_DMA,
> +					  &mem_dma, GFP_KERNEL);
> +	else
> +		mem = dmam_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
> +					  &mem_dma, GFP_KERNEL);
>  	if (!mem)
>  		return -ENOMEM;
> -	memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);
> +
> +	if (ahci_fbs_supported(ap))
> +		memset(mem, 0, AHCI_PORT_PRIV_FBS_DMA);
> +	else
> +		memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);

Maybe setting a size_t var to AHCI_PORT_PRIV_FBS_DMA_SZ or
AHCI_PORT_PRIV_DMA_SZ and using it is better?

> @@ -2399,8 +2630,13 @@ static int ahci_port_start(struct ata_po
>  	pp->rx_fis = mem;
>  	pp->rx_fis_dma = mem_dma;
>  
> -	mem += AHCI_RX_FIS_SZ;
> -	mem_dma += AHCI_RX_FIS_SZ;
> +	if (ahci_fbs_supported(ap)) {
> +		mem += AHCI_RX_FIS_SZ * 16;
> +		mem_dma += AHCI_RX_FIS_SZ * 16;
> +	} else {
> +		mem += AHCI_RX_FIS_SZ;
> +		mem_dma += AHCI_RX_FIS_SZ;
> +	}

like

if (ahci_fbs_supported(ap)) {
	dma_sz = AHCI_PORT_PRIV_FBS_DMA_SZ;
	rx_fis_sz = AHCI_RX_FIS_SZ * 16;
} else {
	dma_sz = AHCI_PORT_PRIV_DMA_SZ;
	rx_fis_sze = AHCI_RX_FIS_SZ;
}

> diff -ruNp a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> --- a/drivers/ata/libata-pmp.c	2009-07-29 14:39:11.000000000 +0800
> +++ b/drivers/ata/libata-pmp.c	2009-07-29 14:39:15.000000000 +0800
> @@ -221,6 +221,8 @@ static const char *sata_pmp_spec_rev_str
>  {
>  	u32 rev = gscr[SATA_PMP_GSCR_REV];
>  
> +	if ((rev & (1 << 2)) && (rev & (1 << 1)))
> +		return "1.2";

Probably best to put this in a separate patch along with other
non-ahci changes?

>  	if (rev & (1 << 2))
>  		return "1.1";
>  	if (rev & (1 << 1))
> diff -ruNp a/include/linux/libata.h b/include/linux/libata.h
> --- a/include/linux/libata.h	2009-07-29 14:39:30.000000000 +0800
> +++ b/include/linux/libata.h	2009-07-29 14:39:34.000000000 +0800
> @@ -208,6 +208,7 @@ enum {
>  	ATA_FLAG_DISABLED	= (1 << 23), /* port is disabled, ignore it */
>  
>  	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
> +	ATA_FLAG_FBS		= (1 << 24), /* controller supports FBS */

Oops, you can't overflow into 24:31 area.  They're reserved for LLD
usage.  Please use bit 14.  Eh... this is getting crowded.

>  	/* struct ata_port pflags */
> @@ -228,6 +229,7 @@ enum {
>  
>  	ATA_PFLAG_PIO32		= (1 << 20),  /* 32bit PIO */
>  	ATA_PFLAG_PIO32CHANGE	= (1 << 21),  /* 32bit PIO can be turned on/off */
> +	ATA_PFLAG_FBSCP		= (1 << 22),  /* FBS Capable Port */

Why two separate bits?  Can't this be folded into ATA_FLAG_FBS?
PFLAGs aren't supposed to indicate port capabilities.

At the second thought, why would libata core layer care about FBS or
FBSCP at all?  From looking at the patch, there's no reason these
flags should live in ATA_[P]FLAG_* space and sil24 does fine without
them.

> +static inline bool sata_fbs_supported(struct ata_port *ap)
> +{
> +	return (ap->flags & ATA_FLAG_PMP) && (ap->flags & ATA_FLAG_FBS);
> +}

If ATA_FLAG_FBS really is necessary, please add a WARN_ON() if a
driver sets FBS w/o PMP and then just test ATA_FLAG_PMP directly.  The
only reason sata_pmp_attached() has helper to test it is because PMP
support can be configured off.

Thanks.

-- 
tejun
