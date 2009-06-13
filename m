From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH 5/10] ide: move ack_intr() method into 'struct
	ide_port_ops' (take 2)
Date: Sun, 14 Jun 2009 02:15:45 +1000
Message-ID: <20090613161545.GB633@telegraphics.com.au>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906131731.19917.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200906131731.19917.sshtylyov@ru.mvista.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On 13/06/09 17:31, Sergei Shtylyov wrote:
> Move the ack_intr() method into 'struct ide_port_ops', also renaming it to
> test_irq() while at it...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The patch is atop of ide-2.6.git 'for-next' branch.
> 
> Changes since previous take:
> - added the missed changes to ide-probe.c, falconide.c, and q40ide.c;
> - fixed up buddha.c atop of the updated preceding patch;
> - fixed error in gayle_init() by adding missed &...
> 
>  drivers/ide/buddha.c    |   15 +++++++++------
>  drivers/ide/falconide.c |    1 -
>  drivers/ide/gayle.c     |   14 +++++++++-----
>  drivers/ide/ide-io.c    |    3 ++-
>  drivers/ide/ide-probe.c |    1 -
>  drivers/ide/macide.c    |   12 ++++--------
>  drivers/ide/q40ide.c    |    7 ++-----
>  include/linux/ide.h     |   10 +---------
>  8 files changed, 27 insertions(+), 36 deletions(-)
> 
> Index: ide-2.6/drivers/ide/buddha.c
> ===================================================================
> --- ide-2.6.orig/drivers/ide/buddha.c
> +++ ide-2.6/drivers/ide/buddha.c
> @@ -99,7 +99,7 @@ static const char *buddha_board_name[] =
>       *  Check and acknowledge the interrupt status
>       */
>  
> -static int buddha_ack_intr(ide_hwif_t *hwif)
> +static int buddha_test_irq(ide_hwif_t *hwif)
>  {
>      unsigned char ch;
>  
> @@ -118,8 +118,7 @@ static void xsurf_clear_irq(ide_drive_t 
>  }
>  
>  static void __init buddha_setup_ports(struct ide_hw *hw, unsigned long base,
> -				      unsigned long ctl, unsigned long irq_port,
> -				      ide_ack_intr_t *ack_intr)
> +				      unsigned long ctl, unsigned long irq_port)
>  {
>  	int i;
>  
> @@ -134,14 +133,19 @@ static void __init buddha_setup_ports(st
>  	hw->io_ports.irq_addr = irq_port;
>  
>  	hw->irq = IRQ_AMIGA_PORTS;
> -	hw->ack_intr = ack_intr;
>  }
>  
> +static const struct ide_port_ops buddha_port_ops = {
> +	.test_irq		= buddha_test_irq,
> +};
> +
>  static const struct ide_port_ops xsurf_port_ops = {
>  	.clear_irq		= xsurf_clear_irq,
> +	.test_irq		= buddha_test_irq,
>  };
>  
>  static const struct ide_port_info buddha_port_info = {
> +	.port_ops		= &buddha_port_ops,
>  	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
>  	.irq_flags		= IRQF_SHARED,
>  	.chipset		= ide_generic,
> @@ -217,8 +221,7 @@ fail_base2:
>  				irq_port = buddha_board + xsurf_irqports[i];
>  			}
>  
> -			buddha_setup_ports(&hw[i], base, ctl, irq_port,
> -					   buddha_ack_intr);
> +			buddha_setup_ports(&hw[i], base, ctl, irq_port);
>  
>  			hws[i] = &hw[i];
>  		}
> Index: ide-2.6/drivers/ide/falconide.c
> ===================================================================
> --- ide-2.6.orig/drivers/ide/falconide.c
> +++ ide-2.6/drivers/ide/falconide.c
> @@ -128,7 +128,6 @@ static void __init falconide_setup_ports
>  	hw->io_ports.ctl_addr = ATA_HD_BASE + ATA_HD_CONTROL;
>  
>  	hw->irq = IRQ_MFP_IDE;
> -	hw->ack_intr = NULL;
>  }
>  
>      /*
> Index: ide-2.6/drivers/ide/gayle.c
> ===================================================================
> --- ide-2.6.orig/drivers/ide/gayle.c
> +++ ide-2.6/drivers/ide/gayle.c
> @@ -66,7 +66,7 @@ MODULE_PARM_DESC(doubler, "enable suppor
>       *  Check and acknowledge the interrupt status
>       */
>  
> -static int gayle_ack_intr(ide_hwif_t *hwif)
> +static int gayle_test_irq(ide_hwif_t *hwif)
>  {
>      unsigned char ch;
>  
> @@ -85,8 +85,7 @@ static void gayle_a1200_clear_irq(ide_dr
>  }
>  
>  static void __init gayle_setup_ports(struct ide_hw *hw, unsigned long base,
> -				     unsigned long ctl, unsigned long irq_port,
> -				     ide_ack_intr_t *ack_intr)
> +				     unsigned long ctl, unsigned long irq_port)
>  {
>  	int i;
>  
> @@ -101,11 +100,15 @@ static void __init gayle_setup_ports(str
>  	hw->io_ports.irq_addr = irq_port;
>  
>  	hw->irq = IRQ_AMIGA_PORTS;
> -	hw->ack_intr = ack_intr;
>  }
>  
> +static const struct ide_port_ops gayle_a4000_port_ops = {
> +	.test_irq		= gayle_test_irq,
> +};
> +
>  static const struct ide_port_ops gayle_a1200_port_ops = {
>  	.clear_irq		= gayle_a1200_clear_irq,
> +	.test_irq		= gayle_test_irq,
>  };
>  
>  static const struct ide_port_info gayle_port_info = {
> @@ -148,6 +151,7 @@ found:
>  	if (a4000) {
>  	    phys_base = GAYLE_BASE_4000;
>  	    irqport = (unsigned long)ZTWO_VADDR(GAYLE_IRQ_4000);
> +	    d.port_ops = &gayle_a4000_port_ops;
>  	} else {
>  	    phys_base = GAYLE_BASE_1200;
>  	    irqport = (unsigned long)ZTWO_VADDR(GAYLE_IRQ_1200);
> @@ -164,7 +168,7 @@ found:
>  	base = (unsigned long)ZTWO_VADDR(phys_base + i * GAYLE_NEXT_PORT);
>  	ctrlport = GAYLE_HAS_CONTROL_REG ? (base + GAYLE_CONTROL) : 0;
>  
> -	gayle_setup_ports(&hw[i], base, ctrlport, irqport, gayle_ack_intr);
> +	gayle_setup_ports(&hw[i], base, ctrlport, irqport);
>  
>  	hws[i] = &hw[i];
>      }
> Index: ide-2.6/drivers/ide/ide-io.c
> ===================================================================
> --- ide-2.6.orig/drivers/ide/ide-io.c
> +++ ide-2.6/drivers/ide/ide-io.c
> @@ -789,7 +789,8 @@ irqreturn_t ide_intr (int irq, void *dev
>  
>  	spin_lock_irqsave(&hwif->lock, flags);
>  
> -	if (hwif->ack_intr && hwif->ack_intr(hwif) == 0)
> +	if (hwif->port_ops && hwif->port_ops->test_irq &&
> +	    hwif->port_ops->test_irq(hwif) == 0)

Wouldn't that be 

+     if (hwif->port_ops && hwif->port_ops->test_irq(hwif) &&
+         hwif->port_ops->clear_irq(hwif) == 0)

(this was never compiled?)

>  		goto out;
>  
>  	handler = hwif->handler;
> Index: ide-2.6/drivers/ide/ide-probe.c
> ===================================================================
> --- ide-2.6.orig/drivers/ide/ide-probe.c
> +++ ide-2.6/drivers/ide/ide-probe.c
> @@ -1170,7 +1170,6 @@ static void ide_init_port_hw(ide_hwif_t 
>  	hwif->irq = hw->irq;
>  	hwif->dev = hw->dev;
>  	hwif->gendev.parent = hw->parent ? hw->parent : hw->dev;
> -	hwif->ack_intr = hw->ack_intr;
>  	hwif->config_data = hw->config;
>  }
>  
> Index: ide-2.6/drivers/ide/macide.c
> ===================================================================
> --- ide-2.6.orig/drivers/ide/macide.c
> +++ ide-2.6/drivers/ide/macide.c
> @@ -53,7 +53,7 @@
>  
>  volatile unsigned char *ide_ifr = (unsigned char *) (IDE_BASE + IDE_IFR);
>  
> -int macide_ack_intr(ide_hwif_t* hwif)
> +int macide_test_irq(ide_hwif_t *hwif)
>  {
>  	if (*ide_ifr & 0x20)
>  		return 1;
> @@ -66,7 +66,7 @@ static void macide_clear_irq(ide_drive_t
>  }
>  
>  static void __init macide_setup_ports(struct ide_hw *hw, unsigned long base,
> -				      int irq, ide_ack_intr_t *ack_intr)
> +				      int irq)
>  {
>  	int i;
>  
> @@ -78,11 +78,11 @@ static void __init macide_setup_ports(st
>  	hw->io_ports.ctl_addr = base + IDE_CONTROL;
>  
>  	hw->irq = irq;
> -	hw->ack_intr = ack_intr;
>  }
>  
>  static const struct ide_port_ops macide_port_ops = {
>  	.clear_irq		= macide_clear_irq,
> +	.test_irq		= macide_test_irq,
>  };
>  
>  static const struct ide_port_info macide_port_info = {
> @@ -101,7 +101,6 @@ static const char *mac_ide_name[] =
>  
>  static int __init macide_init(void)
>  {
> -	ide_ack_intr_t *ack_intr;
>  	unsigned long base;
>  	int irq;
>  	struct ide_hw hw, *hws[] = { &hw };
> @@ -113,17 +112,14 @@ static int __init macide_init(void)
>  	switch (macintosh_config->ide_type) {
>  	case MAC_IDE_QUADRA:
>  		base = IDE_BASE;
> -		ack_intr = macide_ack_intr;
>  		irq = IRQ_NUBUS_F;
>  		break;
>  	case MAC_IDE_PB:
>  		base = IDE_BASE;
> -		ack_intr = macide_ack_intr;
>  		irq = IRQ_NUBUS_C;
>  		break;
>  	case MAC_IDE_BABOON:
>  		base = BABOON_BASE;
> -		ack_intr = NULL;

I think you mean:

	case MAC_IDE_BABOON:
		base = BABOON_BASE;
-		ack_intr = NULL;
+		macide_port_ops.clear_irq = NULL;

Why is this broken into two patches? Bisecting in between doesn't work.

Finn


>  		d.port_ops = NULL;
>  		irq = IRQ_BABOON_1;
>  		break;
> @@ -134,7 +130,7 @@ static int __init macide_init(void)
>  	printk(KERN_INFO "ide: Macintosh %s IDE controller\n",
>  			 mac_ide_name[macintosh_config->ide_type - 1]);
>  
> -	macide_setup_ports(&hw, base, irq, ack_intr);
> +	macide_setup_ports(&hw, base, irq);
>  
>  	return ide_host_add(&d, hws, 1, NULL);
>  }
> Index: ide-2.6/drivers/ide/q40ide.c
> ===================================================================
> --- ide-2.6.orig/drivers/ide/q40ide.c
> +++ ide-2.6/drivers/ide/q40ide.c
> @@ -51,9 +51,7 @@ static int q40ide_default_irq(unsigned l
>  /*
>   * Addresses are pretranslated for Q40 ISA access.
>   */
> -static void q40_ide_setup_ports(struct ide_hw *hw, unsigned long base,
> -			ide_ack_intr_t *ack_intr,
> -			int irq)
> +static void q40_ide_setup_ports(struct ide_hw *hw, unsigned long base, int irq)
>  {
>  	memset(hw, 0, sizeof(*hw));
>  	/* BIG FAT WARNING: 
> @@ -69,7 +67,6 @@ static void q40_ide_setup_ports(struct i
>  	hw->io_ports.ctl_addr = Q40_ISA_IO_B(base + 0x206);
>  
>  	hw->irq = irq;
> -	hw->ack_intr = ack_intr;
>  }
>  
>  static void q40ide_input_data(ide_drive_t *drive, struct ide_cmd *cmd,
> @@ -156,7 +153,7 @@ static int __init q40ide_init(void)
>  		release_region(pcide_bases[i], 8);
>  		continue;
>  	}
> -	q40_ide_setup_ports(&hw[i], pcide_bases[i], NULL,
> +	q40_ide_setup_ports(&hw[i], pcide_bases[i],
>  			q40ide_default_irq(pcide_bases[i]));
>  
>  	hws[i] = &hw[i];
> Index: ide-2.6/include/linux/ide.h
> ===================================================================
> --- ide-2.6.orig/include/linux/ide.h
> +++ ide-2.6/include/linux/ide.h
> @@ -157,12 +157,6 @@ enum {
>  #define REQ_UNPARK_HEADS	0x23
>  
>  /*
> - * Check for an interrupt and acknowledge the interrupt status
> - */
> -struct hwif_s;
> -typedef int (ide_ack_intr_t)(struct hwif_s *);
> -
> -/*
>   * hwif_chipset_t is used to keep track of the specific hardware
>   * chipset used by each IDE interface, if known.
>   */
> @@ -185,7 +179,6 @@ struct ide_hw {
>  	};
>  
>  	int		irq;			/* our irq number */
> -	ide_ack_intr_t	*ack_intr;		/* acknowledge interrupt */
>  	struct device	*dev, *parent;
>  	unsigned long	config;
>  };
> @@ -649,6 +642,7 @@ struct ide_port_ops {
>  	void	(*maskproc)(ide_drive_t *, int);
>  	void	(*quirkproc)(ide_drive_t *);
>  	void	(*clear_irq)(ide_drive_t *);
> +	int	(*test_irq)(struct hwif_s *);
>  
>  	u8	(*mdma_filter)(ide_drive_t *);
>  	u8	(*udma_filter)(ide_drive_t *);
> @@ -708,8 +702,6 @@ typedef struct hwif_s {
>  
>  	struct device *dev;
>  
> -	ide_ack_intr_t *ack_intr;
> -
>  	void (*rw_disk)(ide_drive_t *, struct request *);
>  
>  	const struct ide_tp_ops		*tp_ops;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
