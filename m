From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Serial ATA SIS 964
Date: Fri, 27 Feb 2004 23:55:53 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40401F59.8060604@pobox.com>
References: <1077531578.681.21.camel@uk2.local> <403AA727.6030005@pobox.com> <1077615725.665.22.camel@uk2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58588 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263170AbUB1E4J
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Feb 2004 23:56:09 -0500
In-Reply-To: <1077615725.665.22.camel@uk2.local>
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: linux-ide@vger.kernel.org

Uwe Koziolek wrote:
>>static struct ata_port_info sis_port_info[] = {
>>	/* sis_180 */
>>	{
>>		.sht		= &sis_sht,
>>		.host_flags	= ATA_FLAG_SATA, ATA_FLAG_NO_LEGACY |
>>				  ATA_FLAG_SRST,

Here is one possible cause of DMA failure:  There needs to be a "|" not 
a "," following ATA_FLAG_SATA.

Also, since SIS 180 has SATA control registers ("SCR's"), I would 
recommend replacing ATA_FLAG_SRST with ATA_FLAG_SATA_RESET.


>>		.pio_mask	= 0x03,			/* pio3-4 */
>>		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
>>		.port_ops	= &sis_ops,
>>	}
>>};
>>
>>MODULE_AUTHOR("Uwe Koziolek");
>>MODULE_DESCRIPTION("low-level driver for Silicon Integratad Systems SATA controller");
>>MODULE_LICENSE("GPL");
>>MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
>>
>>
>>static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg)
>>{
>>	DPRINTK("ENTER/LEAVE sc_reg=%d\n", sc_reg);
>>	if (sc_reg >= 16) return 0xffffffffU;

please use two lines for two C statements :)

>>	return inl(ap->ioaddr.scr_addr+(sc_reg*4));

please add spaces to make this more readable.

>>}
>>
>>static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
>>{
>>	DPRINTK("ENTER/LEAVE sc_reg=%d, val=%08x\n", sc_reg,  val);
>>	if (sc_reg >= 16) return;
>>	outl(val, ap->ioaddr.scr_addr+(sc_reg*4));

ditto the above.


>>static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
>>{
>>	struct ata_probe_ent *probe_ent = NULL;
>>	struct ata_port_info *port0 = &sis_port_info[sis_180];
>>	int rc;
>>
>>	DPRINTK("ENTER\n");
>>
>>	rc = pci_enable_device(pdev);
>>	if (rc)
>>		return rc;
>>
>>	rc = pci_request_regions(pdev, DRV_NAME);
>>	if (rc)
>>		goto err_out;
>>
>>	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
>>	if (rc)
>>		goto err_out_regions;
>>
>>	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
>>	if (!probe_ent) {
>>		rc = -ENOMEM;
>>		goto err_out_regions;
>>	}
>>
>>	memset(probe_ent, 0, sizeof(*probe_ent));
>>	probe_ent->pdev = pdev;
>>	INIT_LIST_HEAD(&probe_ent->node);
>>
>>	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
>>	probe_ent->sht = port0->sht;
>>	probe_ent->host_flags = port0->host_flags;
>>	probe_ent->pio_mask = port0->pio_mask;
>>	probe_ent->udma_mask = port0->udma_mask;
>>	probe_ent->port_ops = port0->port_ops;
>>
>>	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
>>	ata_std_ports(&probe_ent->port[0]);
>>	probe_ent->port[0].ctl_addr =
>>		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
>>	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);

this statement duplicates the one above.


>>	probe_ent->port[0].scr_addr = pci_resource_start(pdev, 5);

>>	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
>>	ata_std_ports(&probe_ent->port[1]);
>>	probe_ent->port[1].ctl_addr =
>>		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
>>	probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
>>	probe_ent->port[1].scr_addr = pci_resource_start(pdev, 5) + 64;
>>
>>	probe_ent->n_ports = 2;
>>	probe_ent->irq = pdev->irq;
>>	probe_ent->irq_flags = SA_SHIRQ;
>>
>>	pci_set_master(pdev);
>>
>>	ata_device_add(probe_ent);
>>	kfree(probe_ent);

I can only think of two other things off the top of my head:
* setting bit #5 in Bus Master {Primary | Secondary} IDE Status 
Register, to indicate DMA is capable
* Miscellaneous Control register (90h) controls the "mux" by which two 
SATA channels and one PATA channel are mapped into the primary and 
secondary channels.  We may have to set up this register :(  The easiest 
thing is to ignore the PATA channel (bits 5:4 == 00) completely, and 
have SATA0 channel on internal channel J, and SATA1 channel on internal 
channel K.

	Jeff



