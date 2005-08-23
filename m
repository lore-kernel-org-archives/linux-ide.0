From: Michael Fortson <mfortson@permabit.com>
Subject: Re: libata passthru  (S.M.A.R.T.) support for 2.4.31?
Date: Tue, 23 Aug 2005 15:53:45 -0400
Message-ID: <430B7EC9.3050802@permabit.com>
References: <430B1E7A.30406@permabit.com> <20050823132235.GA21267@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [66.228.95.230] ([66.228.95.230]:17080 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S932354AbVHWTxv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Aug 2005 15:53:51 -0400
In-Reply-To: <20050823132235.GA21267@tuxdriver.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

John W. Linville wrote:
> On Tue, Aug 23, 2005 at 09:02:50AM -0400, Michael Fortson wrote:
> 
>>Apologies if this is the wrong list for this question.
>>
>>Is there a patch which provides libata passthru support for the 2.4.31 
>>kernel?  I've seen that Jeff Garzik has a patch for 2.6.x which provides 
>>S.M.A.R.T. support for SATA disks using the libata passthru stuff and 
>>I'd like to apply a similar patch to 2.4.31, if one exists.
> 
> 
> Have you tried applying that passthru patch to the 2.4.31 sources?
> I do not know if that will work or not, but in the past the 2.4 libata
> code was very close to the 2.6 libata code.  So, it might just apply
> directly...?
> 
> Give it a try.  If it doesn't work-out, I'll be happy to try to
> assist you.
> 
> John

I attempted to use 
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.13-rc6-git10-libata1.patch.bz2 
against 2.4.31 but several portions of the patch were rejected and one 
file (drivers/scsi/Kconfig) doesn't exist at all.

Here are the rejects and the actual rejected chunks:

     ./include/linux/libata.h.rej
     ./include/linux/pci_ids.h.rej
     ./drivers/scsi/Makefile.rej
     ./drivers/scsi/ahci.c.rej
     ./drivers/scsi/ata_piix.c.rej
     ./drivers/scsi/libata-core.c.rej
     ./drivers/scsi/libata-scsi.c.rej

-------------------------------------------------------
---- ./include/linux/libata.h.rej
-------------------------------------------------------

***************
*** 645,651 ****
   	ap->ops->scr_write(ap, reg, val);
   }

- static inline void scr_write_flush(struct ata_port *ap, unsigned int reg,
   				   u32 val)
   {
   	ap->ops->scr_write(ap, reg, val);
--- 652,658 ----
   	ap->ops->scr_write(ap, reg, val);
   }

+ static inline void scr_write_flush(struct ata_port *ap, unsigned int reg,
   				   u32 val)
   {
   	ap->ops->scr_write(ap, reg, val);

-------------------------------------------------------
---- ./include/linux/pci_ids.h.rej
-------------------------------------------------------

***************
*** 1249,1254 ****
   #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA	0x0266
   #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2	0x0267
   #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE	0x036E
   #define PCI_DEVICE_ID_NVIDIA_NVENET_12		0x0268
   #define PCI_DEVICE_ID_NVIDIA_NVENET_13		0x0269
   #define PCI_DEVICE_ID_NVIDIA_MCP51_AUDIO	0x026B
--- 1249,1255 ----
   #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA	0x0266
   #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2	0x0267
   #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE	0x036E
+ #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA	0x036F
   #define PCI_DEVICE_ID_NVIDIA_NVENET_12		0x0268
   #define PCI_DEVICE_ID_NVIDIA_NVENET_13		0x0269
   #define PCI_DEVICE_ID_NVIDIA_MCP51_AUDIO	0x026B

-------------------------------------------------------
---- ./drivers/scsi/Makefile.rej
-------------------------------------------------------

***************
*** 120,131 ****
   obj-$(CONFIG_SCSI_NSP32)	+= nsp32.o
   obj-$(CONFIG_SCSI_IPR)		+= ipr.o
   obj-$(CONFIG_SCSI_IBMVSCSI)	+= ibmvscsi/
   obj-$(CONFIG_SCSI_SATA_AHCI)	+= libata.o ahci.o
   obj-$(CONFIG_SCSI_SATA_SVW)	+= libata.o sata_svw.o
   obj-$(CONFIG_SCSI_ATA_PIIX)	+= libata.o ata_piix.o
   obj-$(CONFIG_SCSI_SATA_PROMISE)	+= libata.o sata_promise.o
   obj-$(CONFIG_SCSI_SATA_QSTOR)	+= libata.o sata_qstor.o
   obj-$(CONFIG_SCSI_SATA_SIL)	+= libata.o sata_sil.o
   obj-$(CONFIG_SCSI_SATA_VIA)	+= libata.o sata_via.o
   obj-$(CONFIG_SCSI_SATA_VITESSE)	+= libata.o sata_vsc.o
   obj-$(CONFIG_SCSI_SATA_SIS)	+= libata.o sata_sis.o
--- 120,134 ----
   obj-$(CONFIG_SCSI_NSP32)	+= nsp32.o
   obj-$(CONFIG_SCSI_IPR)		+= ipr.o
   obj-$(CONFIG_SCSI_IBMVSCSI)	+= ibmvscsi/
+ obj-$(CONFIG_SCSI_ATA_ADMA)	+= libata.o ata_adma.o
   obj-$(CONFIG_SCSI_SATA_AHCI)	+= libata.o ahci.o
   obj-$(CONFIG_SCSI_SATA_SVW)	+= libata.o sata_svw.o
   obj-$(CONFIG_SCSI_ATA_PIIX)	+= libata.o ata_piix.o
+ obj-$(CONFIG_SCSI_PATA_PDC2027X)+= libata.o pata_pdc2027x.o
   obj-$(CONFIG_SCSI_SATA_PROMISE)	+= libata.o sata_promise.o
   obj-$(CONFIG_SCSI_SATA_QSTOR)	+= libata.o sata_qstor.o
   obj-$(CONFIG_SCSI_SATA_SIL)	+= libata.o sata_sil.o
+ obj-$(CONFIG_SCSI_SATA_SIL24)	+= libata.o sata_sil24.o
   obj-$(CONFIG_SCSI_SATA_VIA)	+= libata.o sata_via.o
   obj-$(CONFIG_SCSI_SATA_VITESSE)	+= libata.o sata_vsc.o
   obj-$(CONFIG_SCSI_SATA_SIS)	+= libata.o sata_sis.o

-------------------------------------------------------
---- ./drivers/scsi/ahci.c.rej
-------------------------------------------------------

***************
*** 269,274 ****
   	  board_ahci }, /* ESB2 */
   	{ PCI_VENDOR_ID_INTEL, 0x2683, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
   	  board_ahci }, /* ESB2 */
   	{ }	/* terminate list */
   };

--- 269,276 ----
   	  board_ahci }, /* ESB2 */
   	{ PCI_VENDOR_ID_INTEL, 0x2683, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
   	  board_ahci }, /* ESB2 */
+ 	{ PCI_VENDOR_ID_INTEL, 0x27c6, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+ 	  board_ahci }, /* ICH7-M DH */
   	{ }	/* terminate list */
   };


-------------------------------------------------------
---- ./drivers/scsi/ata_piix.c.rej
-------------------------------------------------------

***************
*** 629,641 ****
   	port_info[1] = NULL;

   	if (port_info[0]->host_flags & PIIX_FLAG_AHCI) {
-                u8 tmp;
-                pci_read_config_byte(pdev, PIIX_SCC, &tmp);
-                if (tmp == PIIX_AHCI_DEVICE) {
-                        int rc = piix_disable_ahci(pdev);
-                        if (rc)
-                            return rc;
-                }
   	}

   	if (port_info[0]->host_flags & PIIX_FLAG_COMBINED) {
--- 629,641 ----
   	port_info[1] = NULL;

   	if (port_info[0]->host_flags & PIIX_FLAG_AHCI) {
+ 		u8 tmp;
+ 		pci_read_config_byte(pdev, PIIX_SCC, &tmp);
+ 		if (tmp == PIIX_AHCI_DEVICE) {
+ 			int rc = piix_disable_ahci(pdev);
+ 			if (rc)
+ 				return rc;
+ 		}
   	}

   	if (port_info[0]->host_flags & PIIX_FLAG_COMBINED) {

-------------------------------------------------------
---- ./drivers/scsi/libata-core.c.rej
-------------------------------------------------------

***************
*** 1194,1205 ****
   /**
    * 	ata_dev_config - Run device specific handlers and check for
    * 			 SATA->PATA bridges
-  * 	@ap: Bus
    * 	@i:  Device
    *
    * 	LOCKING:
    */
-
   void ata_dev_config(struct ata_port *ap, unsigned int i)
   {
   	/* limit bridge transfers to udma5, 200 sectors */
--- 1232,1243 ----
   /**
    * 	ata_dev_config - Run device specific handlers and check for
    * 			 SATA->PATA bridges
+  * 	@ap: Bus
    * 	@i:  Device
    *
    * 	LOCKING:
    */
+
   void ata_dev_config(struct ata_port *ap, unsigned int i)
   {
   	/* limit bridge transfers to udma5, 200 sectors */
***************
*** 2020,2025 ****
   }

   /**
    *	ata_sg_clean - Unmap DMA memory associated with command
    *	@qc: Command containing DMA memory to be released
    *
--- 2058,2111 ----
   }

   /**
+  *	ata_dev_init_params - Issue INIT DEV PARAMS command
+  *	@ap: Port associated with device @dev
+  *	@dev: Device to which command will be sent
+  *
+  *	LOCKING:
+  */
+
+ static void ata_dev_init_params(struct ata_port *ap, struct ata_device 
*dev)
+ {
+ 	DECLARE_COMPLETION(wait);
+ 	struct ata_queued_cmd *qc;
+ 	int rc;
+ 	unsigned long flags;
+ 	u16 sectors = dev->id[6];
+ 	u16 heads   = dev->id[3];
+
+ 	/* Number of sectors per track 1-255. Number of heads 1-16 */
+ 	if (sectors < 1 || sectors > 255 || heads < 1 || heads > 16)
+ 		return;
+
+ 	/* set up init dev params taskfile */
+ 	DPRINTK("init dev params \n");
+
+ 	qc = ata_qc_new_init(ap, dev);
+ 	BUG_ON(qc == NULL);
+
+ 	qc->tf.command = ATA_CMD_INIT_DEV_PARAMS;
+ 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+ 	qc->tf.protocol = ATA_PROT_NODATA;
+ 	qc->tf.nsect = sectors;
+ 	qc->tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
+
+ 	qc->waiting = &wait;
+ 	qc->complete_fn = ata_qc_complete_noop;
+
+ 	spin_lock_irqsave(&ap->host_set->lock, flags);
+ 	rc = ata_qc_issue(qc);
+ 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+ 	if (rc)
+ 		ata_port_disable(ap);
+ 	else
+ 		wait_for_completion(&wait);
+
+ 	DPRINTK("EXIT\n");
+ }
+
+ /**
    *	ata_sg_clean - Unmap DMA memory associated with command
    *	@qc: Command containing DMA memory to be released
    *
***************
*** 2369,2379 ****

   	kunmap(page);

- 	if (bytes) {
   		goto next_sg;
- 	}
   }

   static void atapi_pio_bytes(struct ata_queued_cmd *qc)
   {
   	struct ata_port *ap = qc->ap;
--- 2572,2592 ----

   	kunmap(page);

+ 	if (bytes)
   		goto next_sg;
   }

+ /**
+  *	atapi_pio_bytes - Transfer data from/to the ATAPI device.
+  *	@qc: Command on going
+  *
+  *	Transfer Transfer data from/to the ATAPI device.
+  *
+  *	LOCKING:
+  *	Inherited from caller.
+  *
+  */
+
   static void atapi_pio_bytes(struct ata_queued_cmd *qc)
   {
   	struct ata_port *ap = qc->ap;

-------------------------------------------------------
---- ./drivers/scsi/libata-scsi.c.rej
-------------------------------------------------------

***************
*** 213,317 ****
   		{0x04, 		RECOVERED_ERROR, 0x11, 0x00},	// Recovered ECC error	 
Medium error, recovered
   		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
   	};
- 	int i = 0;
-
- 	cmd->result = SAM_STAT_CHECK_CONDITION;

   	/*
   	 *	Is this an error we can process/parse
   	 */

- 	if(drv_stat & ATA_ERR)
- 		/* Read the err bits */
- 		err = ata_chk_err(qc->ap);
-
- 	/* Display the ATA level error info */
-
- 	printk(KERN_WARNING "ata%u: status=0x%02x { ", qc->ap->id, drv_stat);
- 	if(drv_stat & 0x80)
- 	{
- 		printk("Busy ");
- 		err = 0;	/* Data is not valid in this case */
   	}
- 	else {
- 		if(drv_stat & 0x40)	printk("DriveReady ");
- 		if(drv_stat & 0x20)	printk("DeviceFault ");
- 		if(drv_stat & 0x10)	printk("SeekComplete ");
- 		if(drv_stat & 0x08)	printk("DataRequest ");
- 		if(drv_stat & 0x04)	printk("CorrectedError ");
- 		if(drv_stat & 0x02)	printk("Index ");
- 		if(drv_stat & 0x01)	printk("Error ");
- 	}
- 	printk("}\n");
-
- 	if(err)
- 	{
- 		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, err);
- 		if(err & 0x04)		printk("DriveStatusError ");
- 		if(err & 0x80)
- 		{
- 			if(err & 0x04)
- 				printk("BadCRC ");
- 			else
- 				printk("Sector ");
   		}
- 		if(err & 0x40)		printk("UncorrectableError ");
- 		if(err & 0x10)		printk("SectorIdNotFound ");
- 		if(err & 0x02)		printk("TrackZeroNotFound ");
- 		if(err & 0x01)		printk("AddrMarkNotFound ");
- 		printk("}\n");

- 		/* Should we dump sector info here too ?? */
   	}


- 	/* Look for err */
- 	while(sense_table[i][0] != 0xFF)
- 	{
- 		/* Look for best matches first */
- 		if((sense_table[i][0] & err) == sense_table[i][0])
- 		{
- 			sb[0] = 0x70;
- 			sb[2] = sense_table[i][1];
- 			sb[7] = 0x0a;
- 			sb[12] = sense_table[i][2];
- 			sb[13] = sense_table[i][3];
- 			return;
- 		}
- 		i++;
   	}
- 	/* No immediate match */
- 	if(err)
- 		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", 
qc->ap->id, err);

- 	i = 0;
- 	/* Fall back to interpreting status bits */
- 	while(stat_table[i][0] != 0xFF)
- 	{
- 		if(stat_table[i][0] & drv_stat)
- 		{
- 			sb[0] = 0x70;
- 			sb[2] = stat_table[i][1];
- 			sb[7] = 0x0a;
- 			sb[12] = stat_table[i][2];
- 			sb[13] = stat_table[i][3];
- 			return;
- 		}
- 		i++;
   	}
- 	/* No error ?? */
- 	printk(KERN_ERR "ata%u: called with no error (%02X)!\n", qc->ap->id, 
drv_stat);
- 	/* additional-sense-code[-qualifier] */

   	sb[0] = 0x70;
- 	sb[2] = MEDIUM_ERROR;
- 	sb[7] = 0x0A;
- 	if (cmd->sc_data_direction == DMA_FROM_DEVICE) {
- 		sb[12] = 0x11; /* "unrecovered read error" */
- 		sb[13] = 0x04;
- 	} else {
- 		sb[12] = 0x0C; /* "write error -             */
- 		sb[13] = 0x02; /*  auto-reallocation failed" */
   	}
   }

--- 413,599 ----
   		{0x04, 		RECOVERED_ERROR, 0x11, 0x00},	// Recovered ECC error	 
Medium error, recovered
   		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
   	};

   	/*
   	 *	Is this an error we can process/parse
   	 */
+ 	if (drv_stat & ATA_BUSY) {
+ 		drv_err = 0;	/* Ignore the err bits, they're invalid */
+ 	}

+ 	if (drv_err) {
+ 		/* Look for drv_err */
+ 		for (i = 0; sense_table[i][0] != 0xFF; i++) {
+ 			/* Look for best matches first */
+ 			if ((sense_table[i][0] & drv_err) ==
+ 			    sense_table[i][0]) {
+ 				*sk = sense_table[i][1];
+ 				*asc = sense_table[i][2];
+ 				*ascq = sense_table[i][3];
+ 				goto translate_done;
+ 			}
+ 		}
+ 		/* No immediate match */
+ 		printk(KERN_WARNING "ata%u: no sense translation for "
+ 		       "error 0x%02x\n", id, drv_err);
   	}
+
+ 	/* Fall back to interpreting status bits */
+ 	for (i = 0; stat_table[i][0] != 0xFF; i++) {
+ 		if (stat_table[i][0] & drv_stat) {
+ 			*sk = stat_table[i][1];
+ 			*asc = stat_table[i][2];
+ 			*ascq = stat_table[i][3];
+ 			goto translate_done;
   		}
+ 	}
+ 	/* No error?  Undecoded? */
+ 	printk(KERN_WARNING "ata%u: no sense translation for status: 0x%02x\n",
+ 	       id, drv_stat);
+
+ 	/* For our last chance pick, use medium read error because
+ 	 * it's much more common than an ATA drive telling you a write
+ 	 * has failed.
+ 	 */
+ 	*sk = MEDIUM_ERROR;
+ 	*asc = 0x11; /* "unrecovered read error" */
+ 	*ascq = 0x04; /*  "auto-reallocation failed" */
+
+  translate_done:
+ 	printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
+ 	       "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, drv_stat, drv_err,
+ 	       *sk, *asc, *ascq);
+ 	return;
+ }

+ /*
+  *	ata_gen_ata_desc_sense - Generate check condition sense block.
+  *	@qc: Command that completed.
+  *
+  *	This function is specific to the ATA descriptor format sense
+  *	block specified for the ATA pass through commands.  Regardless
+  *	of whether the command errored or not, return a sense
+  *	block. Copy all controller registers into the sense
+  *	block. Clear sense key, ASC & ASCQ if there is no error.
+  *
+  *	LOCKING:
+  *	spin_lock_irqsave(host_set lock)
+  */
+ void ata_gen_ata_desc_sense(struct ata_queued_cmd *qc)
+ {
+ 	struct scsi_cmnd *cmd = qc->scsicmd;
+ 	struct ata_taskfile *tf = &qc->tf;
+ 	unsigned char *sb = cmd->sense_buffer;
+ 	unsigned char *desc = sb + 8;
+
+ 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
+
+ 	cmd->result = SAM_STAT_CHECK_CONDITION;
+
+ 	/*
+ 	 * Read the controller registers.
+ 	 */
+ 	assert(NULL != qc->ap->ops->tf_read);
+ 	qc->ap->ops->tf_read(qc->ap, tf);
+
+ 	/*
+ 	 * Use ata_to_sense_error() to map status register bits
+ 	 * onto sense key, asc & ascq.
+ 	 */
+ 	if (unlikely(tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+ 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
+ 				   &sb[1], &sb[2], &sb[3]);
+ 		sb[1] &= 0x0f;
   	}

+ 	/*
+ 	 * Sense data is current and format is descriptor.
+ 	 */
+ 	sb[0] = 0x72;

+ 	desc[0] = 0x09;
+
+ 	/*
+ 	 * Set length of additional sense data.
+ 	 * Since we only populate descriptor 0, the total
+ 	 * length is the same (fixed) length as descriptor 0.
+ 	 */
+ 	desc[1] = sb[7] = 14;
+
+ 	/*
+ 	 * Copy registers into sense buffer.
+ 	 */
+ 	desc[2] = 0x00;
+ 	desc[3] = tf->feature;	/* == error reg */
+ 	desc[5] = tf->nsect;
+ 	desc[7] = tf->lbal;
+ 	desc[9] = tf->lbam;
+ 	desc[11] = tf->lbah;
+ 	desc[12] = tf->device;
+ 	desc[13] = tf->command; /* == status reg */
+
+ 	/*
+ 	 * Fill in Extend bit, and the high order bytes
+ 	 * if applicable.
+ 	 */
+ 	if (tf->flags & ATA_TFLAG_LBA48) {
+ 		desc[2] |= 0x01;
+ 		desc[4] = tf->hob_nsect;
+ 		desc[6] = tf->hob_lbal;
+ 		desc[8] = tf->hob_lbam;
+ 		desc[10] = tf->hob_lbah;
   	}
+ }

+ /**
+  *	ata_gen_fixed_sense - generate a SCSI fixed sense block
+  *	@qc: Command that we are erroring out
+  *
+  *	Leverage ata_to_sense_error() to give us the codes.  Fit our
+  *	LBA in here if there's room.
+  *
+  *	LOCKING:
+  *	inherited from caller
+  */
+ void ata_gen_fixed_sense(struct ata_queued_cmd *qc)
+ {
+ 	struct scsi_cmnd *cmd = qc->scsicmd;
+ 	struct ata_taskfile *tf = &qc->tf;
+ 	unsigned char *sb = cmd->sense_buffer;
+
+ 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
+
+ 	cmd->result = SAM_STAT_CHECK_CONDITION;
+
+ 	/*
+ 	 * Read the controller registers.
+ 	 */
+ 	assert(NULL != qc->ap->ops->tf_read);
+ 	qc->ap->ops->tf_read(qc->ap, tf);
+
+ 	/*
+ 	 * Use ata_to_sense_error() to map status register bits
+ 	 * onto sense key, asc & ascq.
+ 	 */
+ 	if (unlikely(tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+ 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
+ 				   &sb[2], &sb[12], &sb[13]);
+ 		sb[2] &= 0x0f;
   	}

   	sb[0] = 0x70;
+ 	sb[7] = 0x0a;
+
+ #if 0 /* when C/H/S support is merged */
+ 	if (tf->flags & ATA_TFLAG_LBA && !(tf->flags & ATA_TFLAG_LBA48)) {
+ #endif
+ 	if (!(tf->flags & ATA_TFLAG_LBA48)) {
+ 		/* A small (28b) LBA will fit in the 32b info field */
+ 		sb[0] |= 0x80;		/* set valid bit */
+ 		sb[3] = tf->device & 0x0f;
+ 		sb[4] = tf->lbah;
+ 		sb[5] = tf->lbam;
+ 		sb[6] = tf->lbal;
   	}
   }



-Michael Fortson
