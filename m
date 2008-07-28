From: Tejun Heo <tj@kernel.org>
Subject: Re: + sata_viac-add-support-for-vt8251-fix-the-internal-chips-issue-and.patch
 added to -mm tree
Date: Mon, 28 Jul 2008 17:58:51 +0900
Message-ID: <488D8A4B.2040705@kernel.org>
References: <200807220813.m6M8Dlpt017979@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49280 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbYG1JBY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jul 2008 05:01:24 -0400
In-Reply-To: <200807220813.m6M8Dlpt017979@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, JosephChan@via.com.tw, jeff@garzik.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

For some reason, I didn't receive original for this and the other via patches.  :-(  So, cc'ing linux-ide and commenting here.

akpm@linux-foundation.org wrote:
> Subject: sata_via.c: add support for VT8251, fix the internal chips issue and more
> From: <JosephChan@via.com.tw>
> 
> a. Add board ID for VT8251.
> b. Patch <svia_scr_read> and <svia_scr_write> functions for VT8251
> c. Add function <via_ata_tf_load>
> d. Add function <via_std_set_pio_mode>, <via_std_set_dma_mode> and
>    <via_std_cable_detect>
> e. Add function <via_std_sata_prereset> and <via_std_sata_comreset>
> f. Redefine sata_ops
> 
> Signed-off-by: Josepch Chan <josephchan@via.com.tw>

First of all, thanks a lot for doing this.  We've been getting lots of
bug reports on vt8251 and my attempt to solve the issue didn't fan out
too well.

I have a few comments below and hope this large patch can be splitted
into several smaller ones.  If that's too much work, I'll be happy to
split it for you.

> -static struct ata_port_operations vt6420_sata_ops = {
> -	.inherits		= &ata_bmdma_port_ops,
> +/*
> + * The opertion redefined by VIA to implement sata functions.
> + * Since some via sata controllers support Master/Slave mode,
> + * but the standard hardreset in libata could not work well
> + * for slave slot, so we implement the hardreset during
> + * prereset, and then do softreset. It should be mentioned
> + * that libata does not do softreset for sata controller if
> + * hardreset is availuable, to ensure the slave slot could
> + * be detected, we skip standard hardrest in libata. That is
> + * why we have to redefine the sata operations of sata
> + */
> +static struct ata_port_operations via_std_sata_ops = {
> +	.inherits		= &ata_base_port_ops,
> +

Instead of inheriting from base_port_ops and setting all other SFF
ops, it can inherit from sff_port_ops and override .hardreset to
ATA_OP_NULL, but I don't think putting hardreset into prereset is a
good idea.  More on that later.

> -static struct ata_port_operations vt6421_sata_ops = {
> +static struct ata_port_operations via_std_pata_ops = {
>  	.inherits		= &ata_bmdma_port_ops,
> -	.scr_read		= svia_scr_read,
> -	.scr_write		= svia_scr_write,
> +
> +	.cable_detect	= via_std_cable_detect,
> +	.set_piomode	= via_std_set_pio_mode,
> +	.set_dmamode	= via_std_set_dma_mode,
> +
> +	.sff_tf_load	= via_ata_tf_load,

std means standard ATA ops.  Please use via_ prefix instead of
via_std_.

> +/**
> + * VT8251 has two sata channels, which are both Master/Slave mode. This is different
> + * from the implementation in libata, which supports only master mode
> + */

Please wrap to 80 column && libata does support SATA M/S - ata_piix
and a few others already do this.

> +/**
> + * For controller 0x8251 and ox0581/0x5324, the sata controller registers do not
> + * locate in the PCI BARs, instead, they are in the PCI configure space.
> + */

Ah... this was why SCR was getting all garbage values.  I tried to
drop SCR support altogether for 8251 but it wasn't enough.  :-)

>  static int svia_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
>  {
> -	if (sc_reg > SCR_CONTROL)
> +	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> +	u8  config_space_value;
> +    u8  byte_temp;
> +	u32 scr_value;
> +    u32 dword_temp;
> +    s8  shift;
> +    u8  slot;
> +
> +    unsigned int scr_reg = sc_reg;
> +
> +    if (scr_reg > SCR_CONTROL) {
> +		VPRINTK("invalid scr[%d] address!\n", scr_reg);
>  		return -EINVAL;
> -	*val = ioread32(ap->ioaddr.scr_addr + (4 * sc_reg));
> -	return 0;
> +    }
> +
> +
> +    if (!(pdev->device == 0x5287 || pdev->device == 0x0581 ||
> +		pdev->device == 0x5324))
> +		*val = ioread32(ap->ioaddr.scr_addr + (4 * scr_reg));
> +    else {

Plesae split these into two separate SCR functions and use separate
ops for each case.  We generally try to refrain from demuxing based on
PCI IDs down the ops.  Also, 0x0581 and 0x5324 are not in the
svia_pci_tbl (this is one of the reasons why libata doesn't like
switching on PCI IDs down in the ops.  things are much more obvious if
it's done from device ID list and init.)

> +		config_space_value = 0;
> +		scr_value = 0;
> +		shift     = 0;
> +
> +		/**
> +		 * Since these chips do not use iomap to get the address of scr,
> +		 * we use these register to store the slot index
> +		 */
> +		slot = (u32)ap->ioaddr.scr_addr & 0x03;
> +
> +		if (scr_reg == SCR_STATUS) {

Wouldn't switch (scr_reg) fit better?

> +			pci_read_config_byte(pdev, (0xA0 + (slot & 0x03)),
> +				&config_space_value);
> +
> +			/* Set the DET field, bit0 and 1 of the config byte */
> +			scr_value |= (config_space_value & 0x03);
> +
> +			/* Set the SPD field, bit4 of the configure byte */
> +			if (config_space_value & (1<<4))
> +				scr_value |= (u8)(0x02 << 4);
> +			else
> +				scr_value |= (u8)(0x01 << 4);
> +
> +			/* Set the IPM field, bit2 and 3 of the config byte */
> +			byte_temp = (config_space_value >> 2) & 0x03;
> +			shift = byte_temp - 1;
> +			if (shift < 0)
> +				shift = 0;
> +
> +			dword_temp = (byte_temp + 0x01) << shift;
> +			scr_value  |= ((dword_temp & 0x0f) << 8);

Can you please define named constants and use them instead of directly
writing out numbers?

>  static int svia_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)

The same comments for write as read.

> +/**
> + *	via_ata_sff_tf_load - send taskfile registers to host controller
> + *	@ap: Port to which output is sent
> + *	@tf: ATA taskfile register set
> + *
> + *	Outputs ATA taskfile to standard ATA host controller.
> + *
> + *	Note: This is to fix the internal bug of via chipsets,
> + *  which will reset the device register after changing the IEN bit
> + *  on ctl register
> + */
> +static void via_ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
> +{

How about doing the following to make it shorter and clearer?

	if (tf->ctl != ap->last_ctl)
		tf->flags |= ATA_TFLAG_DEVICE;
	ata_sff_tf_load(ap, tf);

The function bangs at lots of IO registers and the extra call and
condition check wouldn't make any difference as long as the number of
register accesses stay the same.

> +static int via_std_cable_detect(struct ata_port *ap)
> +{
> +	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> +	u8 tmp;
> +	int cfg_addr;
> +
> +	if (ap->port_no == 2) {
> +		if (pdev->device == 0x3249) {

Same as scr ones.  Please implement separate ops && what's 3249?

> +			cfg_addr = 0xB3;
> +			pci_read_config_byte(pdev, cfg_addr, &tmp);
> +			if (tmp & 0x10)
> +				return ATA_CBL_PATA40;
> +			return ATA_CBL_PATA80;
> +		}
> +	} else if (ap->port_no == 1) {
> +		if ((pdev->device == 0x0581) || (pdev->device == 0x5324)) {

And the same question for 0581, 5324.  They're not on svia_pci_tbl?

> + /**
> + *	via_std_sata_comreset - comreset for via sata controller
> + *	@ap: target ATA port
> + *	@isMaster: whether the input port is master slot
> + *
> + *	Some VIA controllers does not use PCI BAR to map the sata
> + *  controller registers, besides, some via data controllers
> + *  have both master and slave slots. As a result, standard
> + *  operations in libata could not work well

Please indent the whole paragraph the same amount.

> + *	LOCKING:
> + *	Kernel thread context (may sleep)
> + *
> + *	RETURNS:
> + *	0 on success, -errno otherwise.
> + */
> +static int via_std_sata_comreset(struct ata_port *ap, int isMaster)
> +{
> +    struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> +	unsigned long timeout = jiffies + (HZ * 5);
> +	u32 sstatus, scontrol, serror;
> +	int online = 0;
> +
> +	int slot;
> +    int slot_start = ap->port_no;
> +	unsigned int dev = 0;
> +
> +	unsigned int cbl_tmp = via_std_cable_detect(ap);
> +	unsigned long flag_tmp = ap->flags;

Please indent uniformly using tab.

> +
> +	if (ap->flags & ATA_FLAG_SLAVE_POSS)
> +		slot_start = slot_start << 1;
> +
> +	ap->cbl = ATA_CBL_SATA;
> +	ap->flags |= ATA_FLAG_SATA;
> +
> +	{

Why start a block?

> +		slot = (isMaster ? 0 : 1) + slot_start;
> +		if (pdev->device == 0x5287 || pdev->device == 0x0581 ||
> +			pdev->device == 0x5324)
> +			ap->ioaddr.scr_addr = (void __iomem *)slot;

Aiee....

Given that currently ata_host maps to single ata_link which hosts
SCRs.  Handling separate links for each port is a bit pain in the ass.
Can you please take a look at how SIDPR SCR access is implemented in
ata_piix?  It basically has the same problem and is handled by merging
the SCR values for master and slave and faking it has single unified
SCR reg set for the channel.  I took this rather adhoc approach
because it looked like an isolated case and didn't look like it
warrants core layer changes.

We can either separate out the SCR merging code into the core layer
and make both ata_piix and sata_via use it or extend libata to handle
separate links for M/S.  I'll investigate more and report back.  In
the meantime, can you please check whether the merged SCR approach
used by ata_piix can be applied to sata_via?

> -static int vt6420_prereset(struct ata_link *link, unsigned long deadline)
> +static int via_std_sata_prereset(struct ata_link *link, unsigned long deadline)
>  {
>  	struct ata_port *ap = link->ap;
> -	struct ata_eh_context *ehc = &ap->link.eh_context;
> -	unsigned long timeout = jiffies + (HZ * 5);
> -	u32 sstatus, scontrol;
> -	int online;
> +    struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> +	int devmask = 0;
> +	int slot_cnt = 0;
> +	int slot;
> +	int rc;
> +	u8 status;
>  
>  	/* don't do any SCR stuff if we're not loading */
>  	if (!(ap->pflags & ATA_PFLAG_LOADING))
>  		goto skip_scr;
>  
> +	slot_cnt = (ap->flags & ATA_FLAG_SLAVE_POSS) ? 2 : 1;
> +	for (slot = 0; slot < slot_cnt; ++slot) {
> +		rc = via_std_sata_comreset(ap, (slot%2 == 0) ? 1 : 0);
> +		if (!rc)
> +			devmask |= (1<<slot);
> +
> +		rc = ata_sff_wait_ready(link, deadline);
> +		status = link->ap->ops->sff_check_status(link->ap);
> +		DPRINTK("Prereset %X for PORT%d status %x: \n", \
> +				pdev->device, ap->port_no, status);
> +		if (rc != 0) {
> +			DPRINTK("Prereset %X for PORT%d failed\n", \
> +						pdev->device, ap->port_no);
> +			devmask &= ~(1<<slot);
> +		}
> +	}
> +
> +	/*
> +	 * To fix the online check in libata. The softreset in libata will check
> +	 * whether the Master slot will be online for an ata link, so we should
> +	 * reset the master port again if the slave slot does not have a device
> +	 * attached
> +	 */
> +	if ((slot_cnt == 2) && (devmask == 0x01))
> +		via_std_sata_comreset(ap, 1);
> +	else if (devmask == 0) {
> +			DPRINTK("Prereset%X for PORT%d failed: (No device)\n", \
> +					pdev->device, ap->port_no);
> +			return -ENODEV;

Aieee... Painful workaround.  As commented above, I think this can be
handled better and even if it needs to be done this way, this can be
done in hardreset.  hardreset can tell libata to do follow-up
softreset by returning -EAGAIN.

> +static void via_std_set_pio_mode(struct ata_port *ap, struct ata_device *adev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>  
> +	u8 cfg_byte;
> +	int cfg_addr;
> +	u16 tmp16;
> +
> +	tmp16 = pdev->device;
> +
> +	if ((tmp16 == 0x3249) && (ap->port_no == 2))/* PATA channel in VT6421 */
> +		cfg_addr = 0xAB;
> +	else if ((tmp16 == 0x0581 || tmp16 == 0x5324) &&
> +		(ap->port_no == 1))/* PATA channel in VT8353 */
> +		cfg_addr = 0x49;
> +	else
> +		return;

Same comment as other places.  If different operations are needed, put
them in separate ops.  If only addresses are different, it's usually
best to add a port private data structure which carries the addresses
and set it from the init routine.

> +	switch (adev->pio_mode & 0x07) {
> +	case 0:
> +		cfg_byte = 0xa8;
> +		break;
> +	case 1:
> +		cfg_byte = 0x65;
> +		break;
> +	case 2:
> +		cfg_byte = 0x65;
> +		break;
> +	case 3:
> +		cfg_byte = 0x31;
> +		break;
> +	case 4:
> +		cfg_byte = 0x20;
> +		break;

Please switch on adev->pio_mode and use XFER_PIO_* for cases.

> +static void via_std_set_dma_mode(struct ata_port *ap, struct ata_device *adev)

About the same commenst for set_dma_mode.

Thanks.

-- 
tejun
