From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Early ATA devices
Date: Wed, 1 Aug 2007 19:06:17 +0100
Message-ID: <20070801190617.1f40cbf2@the-village.bc.nu>
References: <20070801014137.4ab39e94@the-village.bc.nu>
	<46B08F05.9080306@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47660 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1765667AbXHAR7K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 13:59:10 -0400
In-Reply-To: <46B08F05.9080306@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

> > So in theory we can persuade libata to drive original MFM/RLL disks with
> > relatively few changes
> 
> Crazy :)

Would look something like this (but with geometry handling and some setup
work)

/**
 *	An original IDE/ST412/ST506 driver for libata
 *
 *	Information for hardware archeologists
 *	- IDE is the original pre ATA and 'EIDE' specification interface
 *	  emulating ST412 with some oddments nailed on
 *	- ST412 is the normal PC/AT attachment
 *	- ST506 is the prehistoric version
 *
 *  	This driver will not (currently) handle ST506 unless you set the
 *	precomp value. Nor will it handle the original '8 head' protocol, nor
 *	drives not capable of the 35uS stepper rate. I might fix this for
 *	fun one day if I can find an old enough drive that still works 
 *
 *	How we work the compatibility ATA to ST412
 *	------------------------------------------
 *
 *	Mostly this works as pass through to libata as IDE and ATA were
 *	designed to be compatible in the IDE->ATA direction. The ST412
 *	interface ctrl register maps to the ATA ctl register (which is why it
 *	has lots of 'obsolete' bits). nIEN and SRST map to the IRQ mask
 *	bit on the controller and the controller soft reset.
 *
 *	Original IDE works on the same command set as ST412 as far as we
 *	care (we don't do formatting etc). Some later IDE drives insist
 *	that we tell them their geometry (Initialize Drive) and they also
 *	support better error handling (DIAGNOSE), but we can do that as
 *	it'll just get rejected by the MFM era controller.
 *
 *	The drive select is also cunning arranged so that '512 bytes with ECC'
 *	to the controller is in fact 0xA0 (aka the 'obsolete' bits in ATA)
 *
 *	The big limit on original IDE is that only the BIOS knows the c/h/s
 *	parameters for the drive. For MFM/RLL you can sneak a peek at the
 *	partition table and guess but not alas for early IDE as it requires
 *	you set the geometry before it'll let you look!
 *
 *	ST506
 *	-----
 *
 *	ST506 requires we set 8 v 16 heads correctly and that we provide
 *	write precomp and a couple of other additional values. If you have
 *	a specific application involving rescuing such an ancient disk in
 *	a lab somewhere then let me know, although its probably easier and
 *	safer to read a disk that old in a data recovery lab
 */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/blkdev.h>
#include <linux/delay.h>
#include <scsi/scsi_host.h>
#include <linux/libata.h>
#include <linux/platform_device.h>

#define DRV_NAME "pata_hd"
#define DRV_VERSION "0.0.1"

#define NR_HOST 2

struct platform_device *atahd_device[NR_HOST];
static struct ata_host *atahd_host[NR_HOST];

struct atahd_disk {
	/* Geometry for faking IDENTIFY */
	u16 cyls;
	u8 heads;
	u8 sectors;
	/* Not currently supported - 35uS always used */
	u8 seekrate;
	/* Precompensation for older ST506 */
	u8 wprecomp;
	unsigned int legacy:1;	/* Drive is actually ATA-1+ */
	unsigned int ide:1;	/* Drive is original IDE */
	unsigned int lba:1;	/* Original IDE in LBA mode */
	u8 bios_ident;		/* BIOS id of drive */
}

static struct atahd_param {
	struct atahd_disk param[2];	/* Drive parameters */
	int device;		/* Tracking current device */
	int present;		/* Mask of present devices */
};

static struct atahd_param atahd_param[NR_HOST];
static int nr_atahd_host;
static int bios_ident = 0x80;

/**
 *	atahd_tf_load - send taskfile registers to host controller
 *	@ap: Port to which output is sent
 *	@tf: ATA taskfile register set
 *
 *	Outputs ATA taskfile to ST506/414 host controller.
 *
 *	LOCKING:
 *	Inherited from caller.
 */

void atahd_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
{
	struct ata_ioports *ioaddr = &ap->ioaddr;
	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
	
	if (!p->param[p->device].legacy) {
		ata_tf_load(ap, tf);
		return;
	}

	if (tf->ctl != ap->last_ctl) {
		iowrite8(tf->ctl, ioaddr->ctl_addr);
		ap->last_ctl = tf->ctl;
		ata_wait_idle(ap);
	}
	if (is_addr) {
		/* ST-506 requires the precomp value is loaded, ST-412, IDE
		   and later it is done by the drive. This causes no problem
		   for ST-506 driving IDE but for IDE driving ST we need to
		   fill in the blanks. Later ST-506 drives don't generally
		   use the hardware precomp signal either */
		if (p->param[p->device].wprecomp)
			iowrite8(p->param[p.device].wprecomp, ioaddr->feature_addr);
		else
			iowrite8(tf->feature, ioaddr->feature_addr);
		iowrite8(tf->nsect, ioaddr->nsect_addr);
		iowrite8(tf->lbal, ioaddr->lbal_addr);
		iowrite8(tf->lbam, ioaddr->lbam_addr);
		iowrite8(tf->lbah, ioaddr->lbah_addr);
		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
			tf->feature,
			tf->nsect,
			tf->lbal,
			tf->lbam,
			tf->lbah);
	}

	if (tf->flags & ATA_TFLAG_DEVICE) {
		iowrite8(tf->device, ioaddr->device_addr);
		VPRINTK("device 0x%X\n", tf->device);
	}

	ata_wait_idle(ap);
}

/**
 *	atahd_data_xfer - Transfer data by PIO
 *	@adev: device to target
 *	@buf: data buffer
 *	@buflen: buffer length
 *	@write_data: read/write
 *
 *	Transfer data from/to the device data register by PIO.
 *
 *	LOCKING:
 *	Inherited from caller.
 */

static int atahd_data_xfer(struct ata_device *adev, unsigned char *buf, 
				unsigned int buflen, int write_data)
{
	int r = 0;
	unsigned long flags;
	
	local_irq_save(flags);
	r = ata_data_xfer(adev, buf, buflen, write_data);
	local_irq_restore(flags);
	return r;
}

#if 0
static void atahd_id_data()
{
	BUG_ON(write_data);
	memset(buf, 0, 512);
	id[0] = 0x8000;	/* ATA */
	id[1] = d->cyls;
	id[2] = 0xC837;
	id[3] = d->heads;
	id[6] = d->sectors;
	memset(id + 10, " ", 20);
	/* FIXME: Set some kind of unique serial */
	memcpy(id + 23, "ATAHD001", 8);
	memcpy(id + 27, "ATA HD EMULATION OF MFM/RLL             ", 40);
	id[47] = 0x8000;
	id[49] = 0x30;
}
#endif

static unigned int atahd_emulate_id(struct ata_queued_cmd *qc)
{
	struct atahd_param *p = qc->ap->private_data;
	u16 *id = kzalloc(512, GFP_ATOMIC);
	if (id == NULL)
		return AC_ERR_INVALID;

	ata_dev_select(qc->ap, qc->dev->devno, 1, 0);
	/* Fill in the data block */
	ata_qc_complete(qc);
	kfree(id);
	return 0;
}

static unsigned int atahd_qc_issue_prot(struct ata_queued_cmd *qc)
{
	struct atahd_param *p = qc->ap->private_data;

	/* Non legacy devices need no care and attention */
	if (!p->param[p->device].legacy)
		return ata_qc_issue_prot(qc);

	/* ST412/ST506 controller path [or early equivalen IDE] */
	switch(qc->tf.command) {
		/* Don't do read/write multi - the 1010 can do it but we've
		   no idea how much SRAM is on the board */
		case ATA_CMD_PIO_READ:
		case ATA_CMD_PIO_WRITE:
		case ATA_CMD_VERIFY:
		case 0x10:	/* pre-ATA command 0x10: Restore */
			return ata_qc_issue_prot(qc);
		/* Must fake */
		case ATA_CMD_ID_ATA:
			return atahd_emulate_id(qc);
		/* May work on some very early IDE but will abort on ST412
		   which is fine */
		case ATA_CMD_INIT_DEV_PARAMS:
			return ata_qc_issue_prot(qc);
		/* Also internally the controller supports formatting etc */
		default:
			return AC_ERR_INVALID;
	}
}

static struct scsi_host_template atahd_sht = {
	.module			= THIS_MODULE,
	.name			= DRV_NAME,
	.ioctl			= ata_scsi_ioctl,
	.queuecommand		= ata_scsi_queuecmd,
	.can_queue		= ATA_DEF_QUEUE,
	.this_id		= ATA_SHT_THIS_ID,
	.sg_tablesize		= LIBATA_MAX_PRD,
	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
	.emulated		= ATA_SHT_EMULATED,
	.use_clustering		= ATA_SHT_USE_CLUSTERING,
	.proc_name		= DRV_NAME,
	.dma_boundary		= ATA_DMA_BOUNDARY,
	.slave_configure	= ata_scsi_slave_config,
	.slave_destroy		= ata_scsi_slave_destroy,
	.bios_param		= ata_std_bios_param,
};

static struct ata_port_operations atahd_port_ops = {
	.port_disable	= ata_port_disable,

	.tf_load	= atahd_tf_load,
	.tf_read	= ata_tf_read,
	.check_status 	= atahd_check_status,
	.exec_command	= ata_exec_command,
	.dev_select 	= ata_std_dev_select,

	.freeze		= ata_bmdma_freeze,
	.thaw		= ata_bmdma_thaw,
	.error_handler	= ata_bmdma_error_handler,
	.post_internal_cmd = ata_bmdma_post_internal_cmd,
	.cable_detect	= ata_cable_40wire,

	.qc_prep 	= ata_qc_prep,
	.qc_issue	= atahd_qc_issue_prot,

	.data_xfer	= atahd_data_xfer,

	.irq_clear	= ata_bmdma_irq_clear,
	.irq_on		= ata_irq_on,
	.irq_ack	= ata_irq_ack,

	.port_start	= ata_sff_port_start,
};

/**
 *	st416_poll		-	run polled command
 *	@port; I/O port base
 *	@cmd command byte
 *
 *	Issue a polled no-data command to the ST412 interface. We 
 *	cannot do register games here. An ST412 has the registers on
 *	the controller not on the drive. Instead we issue command 0x10
 *	'RESTORE, 35uS stepping'. A working ST412 drive will assert TRKZ
 *	and the command finish. A working ATA drive may either nop the
 *	command or return aborted (as its a retired command). A bust ST412
 *	drive or missing device will timeout or finish the steppjng and
 *	fail to assert TRKZ
 *
 *	This code path is only used during booting and early probing.
 */

static int st416_poll(unsigned long port, u8 cmd, u8 *err)
{
	u8 status;
	u8 err;
	unsigned long timeout = jiffies + 5 * HZ;
	iowrite8(cmd, port + ATA_REG_CMD);
	ndelay(400);
	
	*err = 0;
	
	while (time_before(jiffies, timeout)) {
		status = ioread8(port + ATA_REG_STATUS);
		if ((status & ATA_BUSY) == 0) {
			if (status & ATA_ERR) {
				*err = ioread8(port + ATA_REG_ERR);
				/* Aborted the command */
				if (err & ATA_ABORTED)
					return 0;
				/* Drive didn't step back to track zero -
				   missing or bust */
				if (*err & 0x01)
					return -ENODEV;
				return 0;
			}
			return 0;
		}
	}
	return -ENODEV;
}

/*
 *	Probe sequence for ST412 and later devices
 *
 *	Firstly we select the device. It should respond. If it does not
 *	then it is not present (ST412). We then issue the RESTORE command
 *	which is retired pre-ATA. ATA will either no-op it, or abort it.
 *	ST412 will track the drive back to track zero. If this fails with
 *	a timeout or TRKZ then the drive is bust or missing.
 *
 *	Thus
 *		0x10		ABORT	-> ATA
 *		0x10		no TRKZ -> Bust/Missing
 *		0x10		OK	-> ST412 or ATA
 *
 *	We then issue 0x90 which is mandatory for all ATA
 *
 *		0x90		ABORT	-> ST412/Early IDE
 *		0x90		OK	-> Probably ATA
 *
 *	If libata gains the ability to handle IDENTIFY being refused (eg
 *	for early ATA) we can skip everything past the TRKZ check
 */

static int st416_probe_drive(unsigned long io, int dev, struct atahd_param *p)
{
	unsigned long timeout = jiffies + 7 * HZ;
	p->param[dev].legacty = 0;
	
	/* ST506/412: Restore 512 bytes with ECC setting
	   ATA: This sequence is intentionally the ATA drive select
	 */

	if (dev)
		iowrite8(ATA_DEVICE_OBS | ATA_DEV1, io + ATA_REG_DEVICE);
	iowrite8(ATA_DEVICE_OBS, io + ATA_REG_DEVICE);
	
	while (time_before(jiffies, timeout)) {
		status = ioread8(port + ATA_REG_STATUS);
		if ((status & (ATA_DRDY|ATA_BUSY)) == ATA_DRDY) {
			/* ST506/412: Set the seek stepper:  Restore drive 0, 35uS step 
			   IDE: Harmless no-op
			 */
			if (st416_poll(io, 0x10, &err) == 0) {
			/* Try issuing EDD - mandatory for all ATA but causes
			   an abort with ST412 / early IDE */
				if (st416_poll(io, 0x90, &err) == 0) {
					if (err & ATA_ABORTED)
						p->param[dev].legacy = 1;
				}
				p->present |= 1 << dev;
				p->param[dev].bios_ident = bios_ident++;
				return 0;
			}
			return -ENODEV;
		}
	}
	return -ETIMEDOUT;
}
	
static void st416_setup(unsigned long io, unsigned long ctl, struct atahd_param *p)
{
	u8 err;

	/* Reset the ST506/412 controller: For ATA this does a reset on
	   the attached devices but the rest of the logic is the same */	
	iowrite8(ATA_NIEN|ATA_SRST, ctl);
	msleep(10);
	iowrite8(ATA_NIEN, ctl);
	st416_probe_drive(io, 0, p);
	st416_probe_drive(io, 1, p);
}
	    	
/**
 *	atahd_init_one		-	attach a qdi interface
 *	@io: I/O port start
 *	@irq: interrupt line
 *
 *	Register an ISA bus IDE interface. Such interfaces are PIO and we
 *	assume do not support IRQ sharing.
 */

static __init int atahd_init_one(unsigned long port, unsigned long io, int irq)
{
	struct platform_device *pdev;
	struct ata_host *host;
	struct ata_port *ap;
	void __iomem *io_addr, *ctl_addr;
	int ret;

	/*
	 *	Look for a controller. It should SRST and respond sanely
	 *	to a RESTORE command. Should do more checks here and in
	 *	pata_legacy for controller presence.
	 */
	 
	if (st416_setup(io_addr, ctl_addr, &atahd_param[nr_atahd_host]) < 0)
		return 0;

	/*
	 *	Fill in a probe structure first of all
	 */

	pdev = platform_device_register_simple(DRV_NAME, nr_atahd_host, NULL, 0);
	if (IS_ERR(pdev))
		return PTR_ERR(pdev);

	ret = -ENOMEM;
	io_addr = devm_ioport_map(&pdev->dev, io, 8);
	ctl_addr = devm_ioport_map(&pdev->dev, io + 0x206, 1);
	if (!io_addr || !ctl_addr)
		goto fail;

	ret = -ENOMEM;
	host = ata_host_alloc(&pdev->dev, 1);
	if (!host)
		goto fail;
	ap = host->ports[0];

	ap->ops = &atahd_port_ops;
	ap->pio_mask = 0x01;
	ap->flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;

	ap->ioaddr.cmd_addr = io_addr;
	ap->ioaddr.altstatus_addr = ctl_addr;
	ap->ioaddr.ctl_addr = ctl_addr;
	ata_std_ports(&ap->ioaddr);
	

	/* activate */
	ret = ata_host_activate(host, irq, ata_interrupt, 0, &atahd_sht);
	if (ret)
		goto fail;

	ap->private_data = &atahd_param[nr_atahd_host];
	atahd_host[nr_atahd_host++] = host;
	return 0;

 fail:
	platform_device_unregister(pdev);
	return ret;
}

/**
 *	atahd_init		-	attach qdi interfaces
 *
 *	Attach qdi IDE interfaces by scanning the ports it may occupy.
 */

static __init int atahd_init(void)
{
	unsigned long flags;
	static const unsigned long atahd_port[2] = { 0x170, 0x1F0 };
	static const int atahd_irq[2] = { 14, 15 };

	int ct = 0;
	int i;

	for (i = 0; i < 2; i++) {
		unsigned long port = atahd_port[i];
		if (atahd_init_one(port, port + 0x206, atahd_irq[i]) == 0)
			ct++;
	}
	if (ct != 0)
		return 0;
	return -ENODEV;
}

static __exit void atahd_exit(void)
{
	int i;

	for (i = 0; i < nr_atahd_host; i++) {
		ata_host_detach(atahd_host[i]);
		platform_device_unregister(atahd_device[i]);
	}
}

MODULE_AUTHOR("Alan Cox");
MODULE_DESCRIPTION("low-level driver for PC/AT hard disk");
MODULE_LICENSE("GPL");
MODULE_VERSION(DRV_VERSION);

module_init(atahd_init);
module_exit(atahd_exit);

