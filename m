From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 11/24] jmicron: Add quirks to force the device into a
 sane mode
Date: Fri, 07 Jul 2006 12:23:31 -0400
Message-ID: <44AE8A83.8070704@pobox.com>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52967 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932167AbWGGQXg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jul 2006 12:23:36 -0400
In-Reply-To: <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

alan@lxorguk.ukuu.org.uk wrote:
> +/**
> + *	jmicron_pre_reset	-	check for 40/80 pin
> + *	@ap: Port
> + *
> + *	Perform the PATA port setup we need. 
> + 
> + *	On the Jmicron 361/363 there is a single PATA port that can be mapped
> + *	either as primary or secondary (or neither). We don't do any policy
> + *	and setup here. We assume that has been done by init_one and the
> + *	BIOS.
> + */
> + 
> +static int jmicron_pre_reset(struct ata_port *ap)
> +{
> +	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
> +	u32 control;
> +	u32 control5;
> +	int port_mask = 1<< (4 * ap->hard_port_no);

nit: add space after '1'


> +	int is_sata = 0;
> +	int port = ap->hard_port_no;
> +	port_type port_map[2];
> +
> +	/* Check if our port is enabled */
> +	pci_read_config_dword(pdev, 0x40, &control);
> +	if ((control & port_mask) == 0)
> +		return 0;
> +
> +	/* There are two basic mappings. One has the two SATA ports merged
> +	   as master/slave and the secondary as PATA, the other has only the 
> +	   SATA port mapped */
> +	if (control & (1 << 23)) {
> +		port_map[0] = PORT_SATA;
> +		port_map[1] = PORT_PATA0;
> +	} else {
> +		port_map[0] = PORT_SATA;
> +		port_map[1] = PORT_SATA;
> +	}
> +
> +	/* The 365/366 may have this bit set to map the second PATA port
> +	   as the internal primary channel */	
> +	pci_read_config_dword(pdev, 0x80, &control5);
> +	if (control5 & (1<<24))
> +		port_map[0] == PORT_PATA1;
> +
> +	/* The two ports may then be logically swapped by the firmware */
> +	if (control & (1 << 22))
> +		port = port ^ 1;
> +		
> +	/*
> +	 *	Now we know which physical port we are talking about we can
> +	 *	actually do our cable checking etc. Thankfully we don't need
> +	 *	to do the plumbing for other cases.
> +	 */
> +	switch (port_map[port])
> +	{	
> +	case PORT_PATA0:
> +		if (control & (1 << 5))
> +			return 0;
> +		if (control & (1 << 3))	/* 40/80 pin primary */
> +			ap->cbl = ATA_CBL_PATA40;
> +		else	
> +			ap->cbl = ATA_CBL_PATA80;
> +		break;
> +	case PORT_PATA1:
> +		/* Bit 21 is set if the port is enabled */
> +		if ((control5 & (1 << 21)) == 0)
> +			return 0;
> +		if (control5 & (1 << 19))	/* 40/80 pin secondary */
> +			ap->cbl = ATA_CBL_PATA40;
> +		else	
> +			ap->cbl = ATA_CBL_PATA80;
> +		break;
> +	case PORT_SATA:	
> +		ap->cbl = ATA_CBL_SATA
> +		break;
> +	}		
> +	return ata_std_prereset(ap);
> +}
> +
> +/**
> + *	jmicron_error_handler - Setup and error handler
> + *	@ap: Port to handle
> + *
> + *	LOCKING:
> + *	None (inherited from caller).
> + */
> +
> +static void jmicron_error_handler(struct ata_port *ap)
> +{
> +	return ata_bmdma_drive_eh(ap, jmicron_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
> +}
> +
> +/* No PIO or DMA methods needed for this device */
> +
> +static struct scsi_host_template jmicron_sht = {
> +	.module			= THIS_MODULE,
> +	.name			= DRV_NAME,
> +	.ioctl			= ata_scsi_ioctl,
> +	.queuecommand		= ata_scsi_queuecmd,
> +	.can_queue		= ATA_DEF_QUEUE,
> +	.this_id		= ATA_SHT_THIS_ID,
> +	.sg_tablesize		= LIBATA_MAX_PRD,
> +	/* Special handling needed if you have sector or LBA48 limits */
> +	.max_sectors		= ATA_MAX_SECTORS,
> +	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
> +	.emulated		= ATA_SHT_EMULATED,
> +	.use_clustering		= ATA_SHT_USE_CLUSTERING,
> +	.proc_name		= DRV_NAME,
> +	.dma_boundary		= ATA_DMA_BOUNDARY,
> +	.slave_configure	= ata_scsi_slave_config,
> +	/* Use standard CHS mapping rules */
> +	.bios_param		= ata_std_bios_param,
> +};
> +
> +static const struct ata_port_operations jmicron_ops = {
> +	.port_disable		= ata_port_disable,
> +
> +	/* Task file is PCI ATA format, use helpers */
> +	.tf_load		= ata_tf_load,
> +	.tf_read		= ata_tf_read,
> +	.check_status		= ata_check_status,
> +	.exec_command		= ata_exec_command,
> +	.dev_select		= ata_std_dev_select,
> +
> +	.freeze			= ata_bmdma_freeze,
> +	.thaw			= ata_bmdma_thaw,
> +	.error_handler		= jmicron_error_handler,
> +	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
> +
> +	/* BMDMA handling is PCI ATA format, use helpers */
> +	.bmdma_setup		= ata_bmdma_setup,
> +	.bmdma_start		= ata_bmdma_start,
> +	.bmdma_stop		= ata_bmdma_stop,
> +	.bmdma_status		= ata_bmdma_status,
> +	.qc_prep		= ata_qc_prep,
> +	.qc_issue		= ata_qc_issue_prot,
> +	.data_xfer		= ata_pio_data_xfer,
> +
> +	/* Timeout handling. Special recovery hooks here */
> +	.eng_timeout		= ata_eng_timeout,

Remove this, you already use new EH


> +	.irq_handler		= ata_interrupt,
> +	.irq_clear		= ata_bmdma_irq_clear,
> +
> +	/* Generic PATA PCI ATA helpers */
> +	.port_start		= ata_port_start,
> +	.port_stop		= ata_port_stop,
> +	.host_stop		= ata_host_stop,
> +};
> +
> +
> +/**
> + *	jmicron_init_one - Register Netcell ATA PCI device with kernel services
> + *	@pdev: PCI device to register
> + *	@ent: Entry in jmicron_pci_tbl matching with @pdev
> + *
> + *	Called from kernel PCI layer.
> + *
> + *	LOCKING:
> + *	Inherited from PCI layer (may sleep).
> + *
> + *	RETURNS:
> + *	Zero on success, or -ERRNO value.
> + */
> +
> +static int jmicron_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	static struct ata_port_info info = {
> +		.sht		= &jmicron_sht,
> +		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
> +
> +		.pio_mask	= 0x1f,
> +		.mwdma_mask	= 0x07,
> +		.udma_mask 	= 0x3f,
> +
> +		.port_ops	= &jmicron_ops,
> +	};
> +	
> +	u32 reg;
> +
> +	if (id->device_data != 368) {

> +		/* Put the controller into AHCI mode in case the AHCI driver
> +		   has not yet been loaded. This can be done with either
> +		   function present */
> +		   
> +		/* FIXME: We may want a way to override this in future */
> +		pci_write_config_byte(pdev, 0x41, 0xa1);

its easy enough to add a module_param() for this FIXME?


> +MODULE_DESCRIPTION("SCSI low-level driver for Netcell PATA RAID");

obviously wrong :)

