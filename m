From: "Luciano A. Stertz" <luciano@tteng.com.br>
Subject: Re: T10/04-262 ATA pass thru - patch.
Date: Wed, 29 Sep 2004 15:29:59 -0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <415AFF27.7080906@tteng.com.br>
References: <20040928001633.A8363@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 200-203-041-086.paemt7002.e.brasiltelecom.net.br ([200.203.41.86]:47931
	"EHLO einstein.tteng.com.br") by vger.kernel.org with ESMTP
	id S268779AbUI2SZk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Sep 2004 14:25:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by einstein.tteng.com.br (Postfix) with ESMTP id 212561205E3
	for <linux-ide@vger.kernel.org>; Wed, 29 Sep 2004 15:25:37 -0300 (BRT)
Received: from [192.168.0.141] (luciano.tteng.com.br [192.168.0.141])
	by einstein.tteng.com.br (Postfix) with ESMTP id F20D31205E2
	for <linux-ide@vger.kernel.org>; Wed, 29 Sep 2004 15:25:35 -0300 (BRT)
In-Reply-To: <20040928001633.A8363@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


	Just trying to understand the SATA SMART problem as a whole. With your 
patch, it's possible to send ATA commands that are encapsulated in CDBs, 
right? If so, to enable sending direct ATA commands to a SATA device, 
one has to create a ioctl that receives the command and creates a CDB 
from it, as John Linville did a few weeks ago. This way a user-space 
application (e.g. smartmontools) can use this ioctl to send ATA 
commands. Am I right?
	If I understand it correctly, the kernel receives an ATA command, 
creates a CDB, gets the ATA command from the CDB and issues it.
	It's a nice workaround, but user space software will still have to be 
aware that the target device appears as SCSI but isn't in fact a SCSI 
device... I guess that the ideal situation would be:
	1. The user space program sends SCSI commands to the device, without 
even have to worry if it's really a SCSI device;
	2. The kernel issues equivalent ATA commands and fills in the requested 
data.

	I don't know if it's possible / practical, but would be very convenient 
to user space developers. If it doesn't make sense to have this 
translation done in the kernel, maybe in a user space library?

	Luciano Stertz

Andy Warner wrote:
> Here is a *very* rough and ready patch that implements
> the ATA pass-thru CDB. The patch should apply cleanly
> to any bk://gkernel.bkbits.net/libata-2.6 clone.
> 
> The 16-byte command opcode is a totally arbitrary 0x85,
> allocation of a legit opcode is still pending.
> 
> The 12-byte command is not supported yet.
> 
> Only the following protocols are currently
> supported: Non-Data, PIO-In, PIO-Out, DMA.
> 
> Multiple Count is currently ignored, and
> read/write multiple are handled as vanilla PIO.
> 
> UDMA (protocols 11 & 12 in T10/04-262) probably
> work, since at the libata level all DMA appear to
> be handled the same.
> 
> Not supported are any of the reset protocols, packet,
> queued, device diagnostics or FPDMA. I have no plans
> to add packet support or queued support any time soon.
> This should be enough to start SMART work, though.
> 
> This is my first patch generated from a bk-based
> tree, so let me know if there are any problems
> due to the way I've generated the patch.
> 
> Feedback/complaints -> me.
> 
> 
> ------------------------------------------------------------------------
> 
> diff -ur -X /tmp/dontdiff libata-2.6-vanilla/drivers/scsi/libata-core.c t10-parser/drivers/scsi/libata-core.c
> --- libata-2.6-vanilla/drivers/scsi/libata-core.c	2004-09-27 17:30:29.000000000 -0500
> +++ t10-parser/drivers/scsi/libata-core.c	2004-09-27 21:30:23.000000000 -0500
> @@ -1946,7 +1946,7 @@
>  	sg->offset = (unsigned long) buf & ~PAGE_MASK;
>  	sg_dma_len(sg) = buflen;
>  
> -	WARN_ON(buflen > PAGE_SIZE);
> +//    WARN_ON(buflen > PAGE_SIZE);
>  }
>  
>  void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
> diff -ur -X /tmp/dontdiff libata-2.6-vanilla/drivers/scsi/libata-scsi.c t10-parser/drivers/scsi/libata-scsi.c
> --- libata-2.6-vanilla/drivers/scsi/libata-scsi.c	2004-09-27 17:30:29.000000000 -0500
> +++ t10-parser/drivers/scsi/libata-scsi.c	2004-09-27 23:42:44.733522940 -0500
> @@ -623,10 +623,22 @@
>  {
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  
> -	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
> -		ata_to_sense_error(qc, drv_stat);
> -	else
> -		cmd->result = SAM_STAT_GOOD;
> +	/*
> +	 * If this was a pass-thru command, and the user requested
> +	 * a check condition return including register values.
> +	 * Note that check condition is generated, and the ATA
> +	 * register values are returned, whether the command completed
> +	 * successfully or not. If there was no error, SK, ASC and
> +	 * ASCQ will all be zero.
> +	 */
> +	if ((cmd->cmnd[0] == ATA_16) && (cmd->cmnd[2] & 0x20)) {
> +/*DWD*/		printk("XX  0x%0x/0x%0x\n", qc->tf.flags, qc->tf.protocol) ;
> +	} else {
> +		if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
> +			ata_to_sense_error(qc, drv_stat);
> +		else
> +			cmd->result = SAM_STAT_GOOD;
> +	}
>  
>  	qc->scsidone(cmd);
>  
> @@ -688,7 +700,6 @@
>  
>  	if (xlat_func(qc, scsicmd))
>  		goto err_out;
> -
>  	/* select device, send command to hardware */
>  	if (ata_qc_issue(qc))
>  		goto err_out;
> @@ -1368,6 +1379,98 @@
>  	return dev;
>  }
>  
> +/*
> + * ata_scsi_map_proto() -	Map the protocol specified
> + *				in the pass-thru CDB onto the
> + *				protocol values used by taskfiles.
> + */
> +static u8
> +ata_scsi_map_proto(u8 byte1)
> +{
> +	switch((byte1 & 0x1e) >> 1) {
> +		case 3:		/* Non-data */
> +			return ATA_PROT_NODATA;
> +
> +		case 6:		/* DMA */
> +			return ATA_PROT_DMA;
> +
> +		case 4:		/* PIO Data-in */
> +		case 5:		/* PIO Data-out */
> +			if (byte1 & 0xe0) {
> +				return ATA_PROT_PIO_MULT;
> +			}
> +			return ATA_PROT_PIO;
> +
> +		case 10:	/* Device Reset */
> +		case 0:		/* Hard Reset */
> +		case 1:		/* SRST */
> +		case 2:		/* Bus Idle */
> +		case 7:		/* Packet */
> +		case 8:		/* DMA Queued */
> +		case 9:		/* Device Diagnostic */
> +		case 11:	/* UDMA Data-in */
> +		case 12:	/* UDMA Data-Out */
> +		case 13:	/* FPDMA */
> +		default:	/* Reserved */
> +			break;
> +	}
> +
> +	return ATA_PROT_UNKNOWN;
> +}
> +
> +static unsigned int
> +ata_scsi_pass_thru_16(struct ata_queued_cmd *qc, u8 *scsicmd)
> +{
> +	struct ata_taskfile *tf = &(qc->tf);
> +	struct scsi_cmnd *cmd = qc->scsicmd;
> +
> +	if ((tf->protocol = ata_scsi_map_proto(scsicmd[1])) == ATA_PROT_UNKNOWN) {
> +		return 1;
> +	}
> +
> +	/*
> +	 * If the CDB claims to contain extended
> +	 * ATA commands copy the upper byte register values.
> +	 * 
> +	 * NOTE: at present copy all register fields,
> +	 * regardless of which ones are valid according
> +	 * to the .En bits. TODO: research optimal
> +	 * algorithm for this.
> +	 */
> +	if (scsicmd[1] & 0x01) {
> +		tf->hob_feature = scsicmd[3];
> +		tf->hob_nsect = scsicmd[5];
> +		tf->hob_lbal = scsicmd[7];
> +		tf->hob_lbam = scsicmd[9];
> +		tf->hob_lbah = scsicmd[11];
> +		tf->flags |= ATA_TFLAG_LBA48 ;
> +	} else {
> +		tf->flags &= ~ATA_TFLAG_LBA48 ;
> +	}
> +
> +	tf->feature = scsicmd[4];
> +	tf->nsect = scsicmd[6];
> +	tf->lbal = scsicmd[8];
> +	tf->lbam = scsicmd[10];
> +	tf->lbah = scsicmd[12];
> +
> +	tf->flags |= (ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE) ;
> +	tf->device = scsicmd[13];
> +	tf->command = scsicmd[14];
> +
> +	/*
> +	 * TODO: find out if we need to do more here to
> +	 *       cover scatter/gather case.
> +	 */
> +	qc->nsect = cmd->bufflen / ATA_SECT_SIZE ;
> +
> +	if (cmd->sc_data_direction == SCSI_DATA_WRITE) {
> +		tf->flags |= ATA_TFLAG_WRITE;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   *	ata_get_xlat_func - check if SCSI to ATA translation is possible
>   *	@dev: ATA device
> @@ -1400,6 +1503,9 @@
>  	case VERIFY:
>  	case VERIFY_16:
>  		return ata_scsi_verify_xlat;
> +
> +	case ATA_16:
> +		return ata_scsi_pass_thru_16 ;
>  	}
>  
>  	return NULL;
> diff -ur -X /tmp/dontdiff libata-2.6-vanilla/include/scsi/scsi.h t10-parser/include/scsi/scsi.h
> --- libata-2.6-vanilla/include/scsi/scsi.h	2004-09-27 17:30:40.000000000 -0500
> +++ t10-parser/include/scsi/scsi.h	2004-09-27 22:11:07.000000000 -0500
> @@ -113,6 +113,9 @@
>  /* values for service action in */
>  #define	SAI_READ_CAPACITY_16  0x10
>  
> +/* Temporary values for T10/04-262 until official values are allocated */
> +#define	ATA_16		      0x85	/* 16-byte pass-thru [0x85 == unused]*/
> +#define	ATA_12		      0xb3	/* 12-byte pass-thru [0xb3 == obsolete set limits command] */
>  
>  /*
>   *  SCSI Architecture Model (SAM) Status codes. Taken from SAM-3 draft


-- 
Luciano A. Stertz
luciano@tteng.com.br
T&T Engenheiros Associados Ltda
http://www.tteng.com.br
Fone/Fax (51) 3224 8425
