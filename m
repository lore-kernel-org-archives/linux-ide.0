From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 07/24] libata: Fix the host_set hacks and sort out simplex
 mode
Date: Fri, 07 Jul 2006 12:15:53 -0400
Message-ID: <44AE88B9.2080800@pobox.com>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:30695 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932162AbWGGQP7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jul 2006 12:15:59 -0400
In-Reply-To: <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

alan@lxorguk.ukuu.org.uk wrote:
> From: root <root@hraefn.swansea.linux.org.uk>
> 
> A host_set and probe_ent now have an "irq2" field which is used for the
> legacy interface cases. Currently we still check both ports on either IRQ
> but a little thinking suggests this is only a minor performance glitch that
> can be fixed later on.
> 
> Also sorted out the FIXME for making port addresses for legacy ports adjustable
> by platform. This may not be enough for PA-RISC and other platforms with PCI
> bridges hung off a different primary bridge. We'll cross that bridge ;) when
> we come to it.
> 
> Alan
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

I am thinking about touching this area heavily, for iomap support, in 
the next couple days.  iomap support requires making irq/IO/MMIO 
resource handling more sane, and so should be a better patch than this 
(and heavily touches the same areas).

FWIW, iomap means that, like MMIO (ioremap), you must map IO ports 
obtained from pci_resource_start().

If nothing happens in a few days, please yell at me, and I'll apply this 
patch and work on top of it.  As it stands, it does some things I don't 
want (irq2) and wish to avoid.

Some minor inline comments below, as well...


>  drivers/scsi/libata-bmdma.c         |  134 ++++++++++++++++-------------------
>  drivers/scsi/libata-core.c          |   40 ++++++++--
>  include/asm-alpha/libata-portmap.h  |   12 +++
>  include/asm-i386/libata-portmap.h   |   12 +++
>  include/asm-x86_64/libata-portmap.h |   12 +++
>  include/linux/libata.h              |    5 +
>  6 files changed, 135 insertions(+), 80 deletions(-)
>  create mode 100644 include/asm-alpha/libata-portmap.h
>  create mode 100644 include/asm-i386/libata-portmap.h
>  create mode 100644 include/asm-x86_64/libata-portmap.h
> 
> 1addd5a92018c7ed53756bf84854e1b6b45c2d12
> diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
> index 004e1a0..b1dfa8c 100644
> --- a/drivers/scsi/libata-bmdma.c
> +++ b/drivers/scsi/libata-bmdma.c
> @@ -881,7 +881,7 @@ ata_pci_init_native_mode(struct pci_dev 
>  		if (bmdma) {
>  			bmdma += 8;
>  			if(inb(bmdma + 2) & 0x80)
> -			probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
> +				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
>  			probe_ent->port[p].bmdma_addr = bmdma;
>  		}
>  		ata_std_ports(&probe_ent->port[p]);
> @@ -894,45 +894,55 @@ ata_pci_init_native_mode(struct pci_dev 
>  
>  
>  static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev,
> -				struct ata_port_info *port, int port_num)
> +				struct ata_port_info **port, int port_mask)
>  {
>  	struct ata_probe_ent *probe_ent;
> -	unsigned long bmdma;
> +	unsigned long bmdma = pci_resource_start(pdev, 4);
> +
> +	int port_num = 0;
>  
> -	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port);
> +	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
>  	if (!probe_ent)
>  		return NULL;
>  
>  	probe_ent->legacy_mode = 1;
>  	probe_ent->n_ports = 1;
> -	probe_ent->hard_port_no = port_num;
> -	probe_ent->private_data = port->private_data;
> +	probe_ent->hard_port_no = 0;
> +	probe_ent->private_data = port[0]->private_data;
>  
> -	switch(port_num)
> -	{
> -		case 0:
> -			probe_ent->irq = 14;
> -			probe_ent->port[0].cmd_addr = 0x1f0;
> -			probe_ent->port[0].altstatus_addr =
> -			probe_ent->port[0].ctl_addr = 0x3f6;
> -			break;
> -		case 1:
> -			probe_ent->irq = 15;
> -			probe_ent->port[0].cmd_addr = 0x170;
> -			probe_ent->port[0].altstatus_addr =
> -			probe_ent->port[0].ctl_addr = 0x376;
> -			break;
> +	if (port_mask & ATA_PORT_PRIMARY) {
> +		probe_ent->irq = 14;
> +		probe_ent->port[port_num].cmd_addr = ATA_PRIMARY_CMD;
> +		probe_ent->port[port_num].altstatus_addr =
> +		probe_ent->port[port_num].ctl_addr = ATA_PRIMARY_CTL;
> +		if (bmdma) {
> +			probe_ent->port[0].bmdma_addr = bmdma;
> +			if (inb(bmdma + 2) & 0x80)
> +				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
> +		}
> +		ata_std_ports(&probe_ent->port[port_num]);
> +		port_num ++;
>  	}
> -
> -	bmdma = pci_resource_start(pdev, 4);
> -	if (bmdma != 0) {
> -		bmdma += 8 * port_num;
> -		probe_ent->port[0].bmdma_addr = bmdma;
> -		if (inb(bmdma + 2) & 0x80)
> -			probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
> +	if (port_mask & ATA_PORT_SECONDARY) {
> +		if (port_num == 1)
> +			probe_ent->irq2 = 15;
> +		else {
> +			/* Secondary only. IRQ 15 only and "first" port is port 1 */
> +			probe_ent->irq = 15;
> +			probe_ent->hard_port_no = 1;
> +		}
> +		probe_ent->port[port_num].cmd_addr = ATA_SECONDARY_CMD;
> +		probe_ent->port[port_num].altstatus_addr =
> +		probe_ent->port[port_num].ctl_addr = ATA_SECONDARY_CTL;
> +		port_num ++;
> +		if (bmdma) {
> +			probe_ent->port[port_num].bmdma_addr = bmdma + 8;
> +			if (inb(bmdma + 10) & 0x80)
> +				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
> +		}
> +		ata_std_ports(&probe_ent->port[port_num]);
> +		port_num ++;
>  	}
> -	ata_std_ports(&probe_ent->port[0]);
> -

this looks like a needed improvement



> @@ -951,6 +961,10 @@ static struct ata_probe_ent *ata_pci_ini
>   *	regions, sets the dma mask, enables bus master mode, and calls
>   *	ata_device_add()
>   *
> + *	ASSUMPTION:
> + *	Nobody makes a single channel controller that appears solely as
> + *	the secondary legacy port on PCI.
> + *
>   *	LOCKING:
>   *	Inherited from PCI layer (may sleep).
>   *
> @@ -961,7 +975,7 @@ static struct ata_probe_ent *ata_pci_ini
>  int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
>  		      unsigned int n_ports)
>  {
> -	struct ata_probe_ent *probe_ent = NULL, *probe_ent2 = NULL;
> +	struct ata_probe_ent *probe_ent = NULL;
>  	struct ata_port_info *port[2];
>  	u8 tmp8, mask;
>  	unsigned int legacy_mode = 0;
> @@ -1010,35 +1024,34 @@ int ata_pci_init_one (struct pci_dev *pd
>  		goto err_out;
>  	}
>  
> -	/* FIXME: Should use platform specific mappers for legacy port ranges */
>  	if (legacy_mode) {
> -		if (!request_region(0x1f0, 8, "libata")) {
> +		if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {
>  			struct resource *conflict, res;
> -			res.start = 0x1f0;
> -			res.end = 0x1f0 + 8 - 1;
> +			res.start = ATA_PRIMARY_CMD;
> +			res.end = ATA_PRIMARY_CMD + 8 - 1;
>  			conflict = ____request_resource(&ioport_resource, &res);
>  			if (!strcmp(conflict->name, "libata"))
> -				legacy_mode |= (1 << 0);
> +				legacy_mode |= ATA_PORT_PRIMARY;
>  			else {
>  				disable_dev_on_err = 0;
> -				printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n");
> +				printk(KERN_WARNING "ata: 0x%0X IDE port busy\n", ATA_PRIMARY_CMD);
>  			}
>  		} else
> -			legacy_mode |= (1 << 0);
> +			legacy_mode |= ATA_PORT_PRIMARY;
>  
> -		if (!request_region(0x170, 8, "libata")) {
> +		if (!request_region(ATA_SECONDARY_CMD, 8, "libata")) {
>  			struct resource *conflict, res;
> -			res.start = 0x170;
> -			res.end = 0x170 + 8 - 1;
> +			res.start = ATA_SECONDARY_CMD;
> +			res.end = ATA_SECONDARY_CMD + 8 - 1;
>  			conflict = ____request_resource(&ioport_resource, &res);
>  			if (!strcmp(conflict->name, "libata"))
> -				legacy_mode |= (1 << 1);
> +				legacy_mode |= ATA_PORT_SECONDARY;
>  			else {
>  				disable_dev_on_err = 0;
> -				printk(KERN_WARNING "ata: 0x170 IDE port busy\n");
> +				printk(KERN_WARNING "ata: 0x%X IDE port busy\n", ATA_SECONDARY_CMD);
>  			}
>  		} else
> -			legacy_mode |= (1 << 1);
> +			legacy_mode |= ATA_PORT_SECONDARY;
>  	}
>  
>  	/* we have legacy mode, but all ports are unavailable */
> @@ -1056,17 +1069,14 @@ int ata_pci_init_one (struct pci_dev *pd
>  		goto err_out_regions;
>  
>  	if (legacy_mode) {
> -		if (legacy_mode & (1 << 0))
> -			probe_ent = ata_pci_init_legacy_port(pdev, port[0], 0);
> -		if (legacy_mode & (1 << 1))
> -			probe_ent2 = ata_pci_init_legacy_port(pdev, port[1], 1);
> +		probe_ent = ata_pci_init_legacy_port(pdev, port, legacy_mode);
>  	} else {
>  		if (n_ports == 2)
>  			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
>  		else
>  			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY);
>  	}
> -	if (!probe_ent && !probe_ent2) {
> +	if (!probe_ent) {
>  		rc = -ENOMEM;
>  		goto err_out_regions;
>  	}

ditto, some nice cleanups of ugly (but necessary) code


> @@ -1074,35 +1084,17 @@ int ata_pci_init_one (struct pci_dev *pd
>  	pci_set_master(pdev);
>  
>  	/* FIXME: check ata_device_add return */
> -	if (legacy_mode) {
> -		struct device *dev = &pdev->dev;
> -		struct ata_host_set *host_set = NULL;
> -
> -		if (legacy_mode & (1 << 0)) {
> -			ata_device_add(probe_ent);
> -			host_set = dev_get_drvdata(dev);
> -		}
> -
> -		if (legacy_mode & (1 << 1)) {
> -			ata_device_add(probe_ent2);
> -			if (host_set) {
> -				host_set->next = dev_get_drvdata(dev);
> -				dev_set_drvdata(dev, host_set);
> -			}
> -		}
> -	} else
> -		ata_device_add(probe_ent);
> +	ata_device_add(probe_ent);
>  
>  	kfree(probe_ent);
> -	kfree(probe_ent2);
>  
>  	return 0;
>  
>  err_out_regions:
> -	if (legacy_mode & (1 << 0))
> -		release_region(0x1f0, 8);
> -	if (legacy_mode & (1 << 1))
> -		release_region(0x170, 8);
> +	if (legacy_mode & ATA_PORT_PRIMARY)
> +		release_region(ATA_PRIMARY_CMD, 8);
> +	if (legacy_mode & ATA_PORT_SECONDARY)
> +		release_region(ATA_SECONDARY_CMD, 8);
>  	pci_release_regions(pdev);

ditto


> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index d1c1c30..cc6ae67 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -5232,6 +5232,7 @@ static void ata_host_init(struct ata_por
>  	ap->host_set = host_set;
>  	ap->dev = ent->dev;
>  	ap->port_no = port_no;
> +
>  	ap->hard_port_no =
>  		ent->legacy_mode ? ent->hard_port_no : port_no;
>  	ap->pio_mask = ent->pio_mask;
> @@ -5367,6 +5368,7 @@ int ata_device_add(const struct ata_prob
>  	host_set->dev = dev;
>  	host_set->n_ports = ent->n_ports;
>  	host_set->irq = ent->irq;
> +	host_set->irq2 = ent->irq2;
>  	host_set->mmio_base = ent->mmio_base;
>  	host_set->private_data = ent->private_data;
>  	host_set->ops = ent->port_ops;
> @@ -5376,16 +5378,23 @@ int ata_device_add(const struct ata_prob
>  	for (i = 0; i < ent->n_ports; i++) {
>  		struct ata_port *ap;
>  		unsigned long xfer_mode_mask;
> +		int irq_line = ent->irq;
> +
>  
>  		ap = ata_host_add(ent, host_set, i);
>  		if (!ap)
>  			goto err_out;
>  
> +		/* Report the secondary IRQ for second channel legacy */
> +		if (i == 1 && ent->irq2)
> +			irq_line = ent->irq2;
> +
>  		host_set->ports[i] = ap;
>  		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
>  				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
>  				(ap->pio_mask << ATA_SHIFT_PIO);
>  
> +		/* FIXME: maybe print both IRQ lines ? */
>  		/* print per-port info to dmesg */
>  		ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%lX "
>  				"ctl 0x%lX bmdma 0x%lX irq %lu\n",
> @@ -5405,7 +5414,7 @@ int ata_device_add(const struct ata_prob
>  	if (!count)
>  		goto err_free_ret;
>  
> -	/* obtain irq, that is shared between channels */
> +	/* obtain irq, that may be shared between channels */
>  	rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
>  			 DRV_NAME, host_set);
>  	if (rc) {
> @@ -5414,6 +5423,21 @@ int ata_device_add(const struct ata_prob
>  		goto err_out;
>  	}
>  
> +	/* do we have a second IRQ for the other channel, eg legacy mode */
> +	if (ent->irq2) {
> +		/* We will get weird core code crashes later if this is true 
> +		   so trap it now */
> +		BUG_ON(ent->irq == ent->irq2);
> +
> +		rc = request_irq(ent->irq2, ent->port_ops->irq_handler, ent->irq_flags,
> +			 DRV_NAME, host_set);
> +		if (rc) {
> +			dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
> +				   ent->irq2, rc);
> +			goto err_out;
> +		}
> +	}
> +
>  	/* perform each probe synchronously */
>  	DPRINTK("probe begin\n");
>  	for (i = 0; i < count; i++) {

As you know, this is the nasty part that I _really_ want to avoid.

This is compounding my design mistake of putting request_irq() in the 
core code.

Such code is appropriate ONLY in libata-bmdma.c (PCI IDE-specific code).


> @@ -5574,6 +5598,8 @@ void ata_host_set_remove(struct ata_host
>  		ata_port_detach(host_set->ports[i]);
>  
>  	free_irq(host_set->irq, host_set);
> +	if (host_set->irq2)
> +		free_irq(host_set->irq2, host_set);
>  
>  	for (i = 0; i < host_set->n_ports; i++) {
>  		struct ata_port *ap = host_set->ports[i];
> @@ -5583,10 +5609,11 @@ void ata_host_set_remove(struct ata_host
>  		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
>  			struct ata_ioports *ioaddr = &ap->ioaddr;
>  
> -			if (ioaddr->cmd_addr == 0x1f0)
> -				release_region(0x1f0, 8);
> -			else if (ioaddr->cmd_addr == 0x170)
> -				release_region(0x170, 8);
> +			/* FIXME: Add -ac IDE pci mods to remove these special cases */
> +			if (ioaddr->cmd_addr == ATA_PRIMARY_CMD)
> +				release_region(ATA_PRIMARY_CMD, 8);
> +			else if (ioaddr->cmd_addr == ATA_SECONDARY_CMD)
> +				release_region(ATA_SECONDARY_CMD, 8);
>  		}
>  
>  		scsi_host_put(ap->host);

FWIW, this is also the area where ioport_unmap() calls will go.


> @@ -5679,11 +5706,8 @@ void ata_pci_remove_one (struct pci_dev 
>  {
>  	struct device *dev = pci_dev_to_dev(pdev);
>  	struct ata_host_set *host_set = dev_get_drvdata(dev);
> -	struct ata_host_set *host_set2 = host_set->next;
>  
>  	ata_host_set_remove(host_set);
> -	if (host_set2)
> -		ata_host_set_remove(host_set2);
>  
>  	pci_release_regions(pdev);
>  	pci_disable_device(pdev);

Though it is very nice to remove host_set->next.


> diff --git a/include/asm-alpha/libata-portmap.h b/include/asm-alpha/libata-portmap.h
> new file mode 100644
> index 0000000..9202fd0
> --- /dev/null
> +++ b/include/asm-alpha/libata-portmap.h
> @@ -0,0 +1,12 @@
> +#ifndef __ASM_GENERIC_LIBATA_PORTMAP_H
> +#define __ASM_GENERIC_LIBATA_PORTMAP_H
> +
> +#define ATA_PRIMARY_CMD		0x1F0
> +#define ATA_PRIMARY_CTL		0x3F6
> +#define ATA_PRIMARY_IRQ		14
> +
> +#define ATA_SECONDARY_CMD	0x170
> +#define ATA_SECONDARY_CTL	0x376
> +#define ATA_SECONDARY_IRQ	15
> +
> +#endif
> diff --git a/include/asm-i386/libata-portmap.h b/include/asm-i386/libata-portmap.h
> new file mode 100644
> index 0000000..9202fd0
> --- /dev/null
> +++ b/include/asm-i386/libata-portmap.h
> @@ -0,0 +1,12 @@
> +#ifndef __ASM_GENERIC_LIBATA_PORTMAP_H
> +#define __ASM_GENERIC_LIBATA_PORTMAP_H
> +
> +#define ATA_PRIMARY_CMD		0x1F0
> +#define ATA_PRIMARY_CTL		0x3F6
> +#define ATA_PRIMARY_IRQ		14
> +
> +#define ATA_SECONDARY_CMD	0x170
> +#define ATA_SECONDARY_CTL	0x376
> +#define ATA_SECONDARY_IRQ	15
> +
> +#endif
> diff --git a/include/asm-x86_64/libata-portmap.h b/include/asm-x86_64/libata-portmap.h
> new file mode 100644
> index 0000000..9202fd0
> --- /dev/null
> +++ b/include/asm-x86_64/libata-portmap.h
> @@ -0,0 +1,12 @@
> +#ifndef __ASM_GENERIC_LIBATA_PORTMAP_H
> +#define __ASM_GENERIC_LIBATA_PORTMAP_H
> +
> +#define ATA_PRIMARY_CMD		0x1F0
> +#define ATA_PRIMARY_CTL		0x3F6
> +#define ATA_PRIMARY_IRQ		14
> +
> +#define ATA_SECONDARY_CMD	0x170
> +#define ATA_SECONDARY_CTL	0x376
> +#define ATA_SECONDARY_IRQ	15
> +
> +#endif

This is either silly, or obviously-preliminary code.

We don't want to duplicate this information, but instead do as your 
__ASM_GENERIC_LIBATA_PORTMAP_H symbol implies:  put a single copy into 
include/asm-generic.

