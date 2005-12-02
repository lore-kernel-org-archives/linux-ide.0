From: Erik Andersen <andersen@codepoet.org>
Subject: Draft libata GET_IDENTITY and DRIVE_TASKFILE
Date: Fri, 2 Dec 2005 05:35:54 -0700
Message-ID: <20051202123554.GA14781@codepoet.org>
References: <20051201214837.GA25256@havoc.gtf.org> <20051201231008.GA7921@codepoet.org> <438FA62D.2040707@pobox.com> <20051202022309.GA10639@codepoet.org> <438FB468.6090504@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from codepoet.org ([166.70.99.138]:38363 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1750713AbVLBMfz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Dec 2005 07:35:55 -0500
Content-Disposition: inline
In-Reply-To: <438FB468.6090504@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>

Here is a first draft patch adding support for HDIO_GET_IDENTITY
and HDIO_DRIVE_TASKFILE to libata.  Unlike the older
ioctl-get-identity.patch, this returns the actual drive identity
rather than kluding out a few fields.  It needs a bit more
cleanup, and review, but the IDENTITY stuff does produce output
matching the sort coming from the ide driver and is enough to
allow i.e.  'smartctl -i -a -d ata /dev/sda' to be happy doing
its thing.  If this goes in, smartctl will be able to Just Work
for sata -- and there will be much rejoicing.  :-)

I opted to copy and adapt the byteswapping code from
ide_fix_driveid() rather than making a function call, since there
is no guarantee the older ide driver would be compiled in and
making the routine shared seems more bother than it's worth.

The TASKFILE stuff seems to sortof work, but could use some
scrubbing from someone with a better understanding of how libata
works, especialy the part doing 'switch (taskfile->data_phase)'
where you can no doubt see I had no idea what I was doing.

It'd be great to get some review and extra eyeballs to weed out
the problems doubtless lurking in here.  Please CC me as I'm not
currently subscribed to linux-ide.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- linux/drivers/scsi.orig/libata-scsi.c	2005-12-01 22:51:48 +0000
+++ linux/drivers/scsi/libata-scsi.c	2005-12-02 10:56:01 +0000
@@ -273,6 +273,366 @@
 	return rc;
 }
 
+/**
+ *	ata_taskfile_ioctl - Handler for HDIO_DRIVE_TASKFILE ioctl
+ *	@scsidev: Device to which we are issuing command
+ *	@arg: User provided data for issuing command
+ *
+ *	LOCKING:
+ *	Defined by the SCSI layer.  We don't really care.
+ *
+ *	RETURNS:
+ *	Zero on success, negative errno on error.
+ */
+int ata_taskfile_ioctl(struct scsi_device *scsidev, void __user *arg)
+{
+	int rc = 0, tasksize = sizeof(struct ide_task_request_s);
+	u8 *outbuf = NULL;
+	u8 *inbuf  = NULL;
+	u8 scsi_cmd[MAX_COMMAND_SIZE];
+	struct scsi_request *sreq;
+	struct ide_task_request_s *taskfile;
+	struct hd_drive_task_hdr *task;
+	struct hd_drive_hob_hdr *hob;
+
+	if (NULL == (void *)arg)
+		return -EINVAL;
+
+	taskfile = kmalloc(tasksize, GFP_KERNEL);
+	if (NULL == (void *)taskfile)
+		return -ENOMEM;
+	memset(taskfile, 0, tasksize);
+
+	if (copy_from_user(taskfile, arg, tasksize)) {
+		kfree(taskfile);
+		return -EFAULT;
+	}
+	task = (struct hd_drive_task_hdr *) taskfile->io_ports;
+	hob = (struct hd_drive_hob_hdr *) taskfile->hob_ports;
+
+	memset(scsi_cmd, 0, sizeof(scsi_cmd));
+	scsi_cmd[0]  = ATA_16;
+	//scsi_cmd[1]  = hob->data;
+	//scsi_cmd[2]  = task->data;
+	scsi_cmd[3]  = hob->feature;
+	scsi_cmd[4]  = task->feature;
+	scsi_cmd[5]  = hob->sector_count;
+	scsi_cmd[6]  = task->sector_count;
+	scsi_cmd[7]  = hob->sector_number;
+	scsi_cmd[8]  = task->sector_number;
+	scsi_cmd[9]  = hob->low_cylinder;
+	scsi_cmd[10] = task->low_cylinder;
+	scsi_cmd[11] = hob->high_cylinder;
+	scsi_cmd[12] = task->high_cylinder;
+	scsi_cmd[13] = hob->control;
+	scsi_cmd[14] = task->command;
+
+	sreq = scsi_allocate_request(scsidev);
+	if (!sreq) {
+		rc = -EINTR;
+		goto error;
+	}
+
+	switch (taskfile->data_phase)
+	{
+		case TASKFILE_IN:
+		case TASKFILE_MULTI_IN:
+			//sreq->sr_data_direction = SCSI_DATA_READ;
+			scsi_cmd[1]  = (4 << 1); /* PIO Data-in */
+			scsi_cmd[2]  = 0x0e;
+			sreq->sr_data_direction = DMA_FROM_DEVICE;
+			break;
+		case TASKFILE_IN_DMA:
+		case TASKFILE_IN_DMAQ:
+			scsi_cmd[1]  = (6 << 1); /* DMA */
+			scsi_cmd[2]  = 0x0e;
+			sreq->sr_data_direction = DMA_FROM_DEVICE;
+			break;
+		case TASKFILE_OUT:
+		case TASKFILE_MULTI_OUT:
+			scsi_cmd[1]  = (5 << 1); /* PIO Data-out */
+			scsi_cmd[2]  = 0x0e;
+			//sreq->sr_data_direction = SCSI_DATA_WRITE;
+			sreq->sr_data_direction = DMA_TO_DEVICE;
+			break;
+		case TASKFILE_OUT_DMA:
+		case TASKFILE_OUT_DMAQ:
+			scsi_cmd[1]  = (6 << 1); /* DMA */
+			scsi_cmd[2]  = 0x0e;
+			sreq->sr_data_direction = DMA_TO_DEVICE;
+			break;
+		case TASKFILE_NO_DATA:
+			scsi_cmd[1]  = (3 << 1); /* Non-data */
+			scsi_cmd[2]  = 0;
+			sreq->sr_data_direction = DMA_NONE;
+			break;
+		default:
+			rc = -EFAULT;
+			goto error;
+	}
+
+	/* Given the nature of scsi_wait_req, we can either
+	 * read, or we can write.  Not both. */
+	if (taskfile->out_size && taskfile->in_size) {
+		rc = -EFAULT;
+		goto error;
+	}
+
+	if (taskfile->out_size) {
+		outbuf = kmalloc(taskfile->out_size, GFP_KERNEL);
+		if (outbuf == NULL) {
+			rc = -ENOMEM;
+			goto error;
+		}
+		memset(outbuf, 0, taskfile->out_size);
+		if (copy_from_user(outbuf, (void *)arg + tasksize,
+					taskfile->out_size))
+		{
+			rc = -EFAULT;
+			goto error;
+		}
+		/* Good values for timeout and retries?  Values below
+		   from scsi_ioctl_send_command() for default case... */
+		scsi_wait_req(sreq, scsi_cmd, outbuf,
+				taskfile->out_size, (10*HZ), 5);
+	} else if (taskfile->in_size) {
+		inbuf = kmalloc(taskfile->in_size, GFP_KERNEL);
+		if (inbuf == NULL) {
+			rc = -ENOMEM;
+			goto error;
+		}
+		memset(inbuf, 0, taskfile->in_size);
+		if (copy_from_user(inbuf, (void *)arg + tasksize +
+					taskfile->out_size, taskfile->in_size))
+		{
+			rc = -EFAULT;
+			goto error;
+		}
+		/* Good values for timeout and retries?  Values below
+		   from scsi_ioctl_send_command() for default case... */
+		scsi_wait_req(sreq, scsi_cmd, inbuf,
+				taskfile->in_size, (10*HZ), 5);
+	} else {
+		/* Good values for timeout and retries?  Values below
+		   from scsi_ioctl_send_command() for default case... */
+		scsi_wait_req(sreq, scsi_cmd, NULL, 0, (10*HZ), 5);
+	}
+
+	if (sreq->sr_result) {
+		rc = -EIO;
+		goto error;
+	}
+
+	/* Need code to retrieve data from check condition? */
+
+	if (copy_to_user(arg, taskfile, tasksize)) {
+		rc = -EFAULT;
+		goto error;
+	}
+
+	if (taskfile->out_size && copy_to_user((void *)arg + tasksize,
+				outbuf, taskfile->out_size))
+	{
+		rc = -EFAULT;
+		goto error;
+	} else if (taskfile->in_size && copy_to_user(
+				(void *)arg + tasksize + taskfile->out_size,
+				inbuf, taskfile->in_size))
+	{
+		rc = -EFAULT;
+		goto error;
+	}
+
+
+error:
+	scsi_release_request(sreq);
+
+	kfree(taskfile);
+	if (inbuf)
+		kfree(inbuf);
+	if (outbuf)
+		kfree(outbuf);
+	return rc;
+}
+
+static void ide_fixstring (u8 *s, const int bytecount)
+{
+	u8 *p = s, *end = &s[bytecount & ~1]; /* bytecount must be even */
+
+#ifndef __BIG_ENDIAN
+# ifdef __LITTLE_ENDIAN
+	/* convert from big-endian to host byte order */
+	for (p = end ; p != s;) {
+		unsigned short *pp = (unsigned short *) (p -= 2);
+		*pp = ntohs(*pp);
+	}
+# else
+#  error "Please fix <asm/byteorder.h>"
+# endif
+#endif
+	/* strip leading blanks */
+	while (s != end && *s == ' ')
+		++s;
+	/* compress internal blanks and strip trailing blanks */
+	while (s != end && *s) {
+		if (*s++ != ' ' || (s != end && *s && *s != ' '))
+			*p++ = *(s-1);
+	}
+	/* wipe out trailing garbage */
+	while (p != end)
+		*p++ = '\0';
+}
+
+static void ide_fix_driveid (struct hd_driveid *id)
+{
+#ifndef __LITTLE_ENDIAN
+# ifdef __BIG_ENDIAN
+	int i;
+	u16 *stringcast;
+
+	id->config         = __le16_to_cpu(id->config);
+	id->cyls           = __le16_to_cpu(id->cyls);
+	id->reserved2      = __le16_to_cpu(id->reserved2);
+	id->heads          = __le16_to_cpu(id->heads);
+	id->track_bytes    = __le16_to_cpu(id->track_bytes);
+	id->sector_bytes   = __le16_to_cpu(id->sector_bytes);
+	id->sectors        = __le16_to_cpu(id->sectors);
+	id->vendor0        = __le16_to_cpu(id->vendor0);
+	id->vendor1        = __le16_to_cpu(id->vendor1);
+	id->vendor2        = __le16_to_cpu(id->vendor2);
+	stringcast = (u16 *)&id->serial_no[0];
+	for (i = 0; i < (20/2); i++)
+		stringcast[i] = __le16_to_cpu(stringcast[i]);
+	id->buf_type       = __le16_to_cpu(id->buf_type);
+	id->buf_size       = __le16_to_cpu(id->buf_size);
+	id->ecc_bytes      = __le16_to_cpu(id->ecc_bytes);
+	stringcast = (u16 *)&id->fw_rev[0];
+	for (i = 0; i < (8/2); i++)
+		stringcast[i] = __le16_to_cpu(stringcast[i]);
+	stringcast = (u16 *)&id->model[0];
+	for (i = 0; i < (40/2); i++)
+		stringcast[i] = __le16_to_cpu(stringcast[i]);
+	id->dword_io       = __le16_to_cpu(id->dword_io);
+	id->reserved50     = __le16_to_cpu(id->reserved50);
+	id->field_valid    = __le16_to_cpu(id->field_valid);
+	id->cur_cyls       = __le16_to_cpu(id->cur_cyls);
+	id->cur_heads      = __le16_to_cpu(id->cur_heads);
+	id->cur_sectors    = __le16_to_cpu(id->cur_sectors);
+	id->cur_capacity0  = __le16_to_cpu(id->cur_capacity0);
+	id->cur_capacity1  = __le16_to_cpu(id->cur_capacity1);
+	id->lba_capacity   = __le32_to_cpu(id->lba_capacity);
+	id->dma_1word      = __le16_to_cpu(id->dma_1word);
+	id->dma_mword      = __le16_to_cpu(id->dma_mword);
+	id->eide_pio_modes = __le16_to_cpu(id->eide_pio_modes);
+	id->eide_dma_min   = __le16_to_cpu(id->eide_dma_min);
+	id->eide_dma_time  = __le16_to_cpu(id->eide_dma_time);
+	id->eide_pio       = __le16_to_cpu(id->eide_pio);
+	id->eide_pio_iordy = __le16_to_cpu(id->eide_pio_iordy);
+	for (i = 0; i < 2; ++i)
+		id->words69_70[i] = __le16_to_cpu(id->words69_70[i]);
+	for (i = 0; i < 4; ++i)
+		id->words71_74[i] = __le16_to_cpu(id->words71_74[i]);
+	id->queue_depth    = __le16_to_cpu(id->queue_depth);
+	for (i = 0; i < 4; ++i)
+		id->words76_79[i] = __le16_to_cpu(id->words76_79[i]);
+	id->major_rev_num  = __le16_to_cpu(id->major_rev_num);
+	id->minor_rev_num  = __le16_to_cpu(id->minor_rev_num);
+	id->command_set_1  = __le16_to_cpu(id->command_set_1);
+	id->command_set_2  = __le16_to_cpu(id->command_set_2);
+	id->cfsse          = __le16_to_cpu(id->cfsse);
+	id->cfs_enable_1   = __le16_to_cpu(id->cfs_enable_1);
+	id->cfs_enable_2   = __le16_to_cpu(id->cfs_enable_2);
+	id->csf_default    = __le16_to_cpu(id->csf_default);
+	id->dma_ultra      = __le16_to_cpu(id->dma_ultra);
+	id->trseuc         = __le16_to_cpu(id->trseuc);
+	id->trsEuc         = __le16_to_cpu(id->trsEuc);
+	id->CurAPMvalues   = __le16_to_cpu(id->CurAPMvalues);
+	id->mprc           = __le16_to_cpu(id->mprc);
+	id->hw_config      = __le16_to_cpu(id->hw_config);
+	id->acoustic       = __le16_to_cpu(id->acoustic);
+	id->msrqs          = __le16_to_cpu(id->msrqs);
+	id->sxfert         = __le16_to_cpu(id->sxfert);
+	id->sal            = __le16_to_cpu(id->sal);
+	id->spg            = __le32_to_cpu(id->spg);
+	id->lba_capacity_2 = __le64_to_cpu(id->lba_capacity_2);
+	for (i = 0; i < 22; i++)
+		id->words104_125[i]   = __le16_to_cpu(id->words104_125[i]);
+	id->last_lun       = __le16_to_cpu(id->last_lun);
+	id->word127        = __le16_to_cpu(id->word127);
+	id->dlf            = __le16_to_cpu(id->dlf);
+	id->csfo           = __le16_to_cpu(id->csfo);
+	for (i = 0; i < 26; i++)
+		id->words130_155[i] = __le16_to_cpu(id->words130_155[i]);
+	id->word156        = __le16_to_cpu(id->word156);
+	for (i = 0; i < 3; i++)
+		id->words157_159[i] = __le16_to_cpu(id->words157_159[i]);
+	id->cfa_power      = __le16_to_cpu(id->cfa_power);
+	for (i = 0; i < 14; i++)
+		id->words161_175[i] = __le16_to_cpu(id->words161_175[i]);
+	for (i = 0; i < 31; i++)
+		id->words176_205[i] = __le16_to_cpu(id->words176_205[i]);
+	for (i = 0; i < 48; i++)
+		id->words206_254[i] = __le16_to_cpu(id->words206_254[i]);
+	id->integrity_word  = __le16_to_cpu(id->integrity_word);
+# else
+#  error "Please fix <asm/byteorder.h>"
+# endif
+#endif
+	ide_fixstring(id->model,     sizeof(id->model));
+	ide_fixstring(id->fw_rev,    sizeof(id->fw_rev));
+	ide_fixstring(id->serial_no, sizeof(id->serial_no));
+}
+
+/**
+ *	ata_identify_ioctl - Handler for HDIO_GET_IDENTITY ioctl
+ *	@scsidev: Device to which we are issuing command
+ *	@id: a SECTOR_SIZE buffer in which to return the ATA identity
+ *
+ *	LOCKING:
+ *	Defined by the SCSI layer.  We don't really care.
+ *
+ *	RETURNS:
+ *	Zero on success, negative errno on error.
+ */
+int ata_identify_ioctl(struct scsi_device *scsidev,
+		int cmd, u8 *argbuf)
+{
+	int rc = 0;
+	u8 scsi_cmd[MAX_COMMAND_SIZE];
+	struct scsi_request *sreq;
+	struct hd_driveid *id;
+
+	sreq = scsi_allocate_request(scsidev);
+	if (!sreq)
+		return -EINTR;
+
+	memset(scsi_cmd, 0, sizeof(scsi_cmd));
+	scsi_cmd[0]  = ATA_16;
+	scsi_cmd[14] = cmd;      /* WIN_IDENTIFY or WIN_PIDENTIFY */
+	scsi_cmd[1]  = (4 << 1); /* PIO Data-in */
+	scsi_cmd[2]  = 0x0e;     /* no off.line or cc, read from dev,
+				    block count in sector count field */
+	sreq->sr_data_direction = DMA_FROM_DEVICE;
+
+	/* Good values for timeout and retries?  Values below
+	   from scsi_ioctl_send_command() for default case... */
+	scsi_wait_req(sreq, scsi_cmd, argbuf, SECTOR_SIZE, (10*HZ), 5);
+
+	if (sreq->sr_result) {
+		rc = -EIO;
+		goto error;
+	}
+
+	/* Need code to retrieve data from check condition? */
+
+	id = (struct hd_driveid *) argbuf;
+	ide_fix_driveid(id);
+
+error:
+	scsi_release_request(sreq);
+	return rc;
+}
+
 int ata_scsi_ioctl(struct scsi_device *scsidev, int cmd, void __user *arg)
 {
 	struct ata_port *ap;
@@ -312,6 +672,39 @@
 			return -EACCES;
 		return ata_task_ioctl(scsidev, arg);
 
+	case HDIO_DRIVE_TASKFILE:
+		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			return -EACCES;
+		return ata_taskfile_ioctl(scsidev, arg);
+
+	case HDIO_GET_IDENTITY:
+	case HDIO_OBSOLETE_IDENTITY:
+		{
+			int ret, idcmd;
+			u8 *argbuf;
+
+			if (!capable(CAP_SYS_RAWIO))
+				return -EACCES;
+
+			argbuf = kmalloc(SECTOR_SIZE, GFP_KERNEL);
+			if (NULL == (void *)argbuf) {
+				return -ENOMEM;
+			}
+
+			idcmd = WIN_IDENTIFY;
+			if (!atapi_enabled && dev->class == ATA_DEV_ATAPI) {
+				idcmd = WIN_PIDENTIFY;
+			}
+			ret = ata_identify_ioctl(scsidev, idcmd, argbuf);
+			if (ret!=0 || copy_to_user((char *)arg, (char *)argbuf,
+					(cmd == HDIO_GET_IDENTITY) ?
+					sizeof(struct hd_driveid) : 142))
+			{
+				ret = -EFAULT;
+			}
+			kfree(argbuf);
+			return ret;
+		}
 	default:
 		rc = -ENOTTY;
 		break;
