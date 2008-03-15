From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC] Read/Write Buffer support
Date: Sat, 15 Mar 2008 13:18:05 -0400
Message-ID: <47DC04CD.7060209@garzik.org>
References: <20080315153730.GX613@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56074 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbYCORSI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Mar 2008 13:18:08 -0400
In-Reply-To: <20080315153730.GX613@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-ide@vger.kernel.org

Matthew Wilcox wrote:
> This patch adds partial support for the SCSI commands READ_BUFFER and
> WRITE_BUFFER.  Because ATA only supports a single 512-byte buffer per
> drive, this isn't as useful as it could be, but it might prove interesting
> when extended to handle the DOWNLOAD MICROCODE operations.

General concept:  ACK

Minor nits below...


> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 8f0e8f2..f12403f 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1711,6 +1711,117 @@ void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
>  	args->done(cmd);
>  }
>  
> +/*
> + * This helper is used for three subcommands of READ_BUFFER.  Subcommand 0
> + * wants a header prefixing the data.  Subcommand 3 returns a descriptor
> + * and subcommand 0xb returns a descriptor for the echo buffer.  While these
> + * all have slightly different formats, in practise they all look sufficiently
> + * similar that this common function can be used.
> + */
> +static void ata_scsi_fill_buffer_descriptor(struct scsi_cmnd *cmd, int desc)
> +{
> +	u8 *rbuf;
> +	unsigned int buflen;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +
> +	buflen = ata_scsi_rbuf_get(cmd, &rbuf);
> +
> +	memset(rbuf, 0, buflen);
> +	rbuf[0] = desc ? 0xff : 0x0;
> +	rbuf[1] = 0x0;
> +	rbuf[2] = 0x2;
> +	rbuf[3] = 0x0;
> +
> +	ata_scsi_rbuf_put(cmd, rbuf);
> +
> +	local_irq_restore(flags);
> +}

use ata_scsi_rbuf_fill() rather than recreating it manually


> +static int ata_scsi_read_buffer_descriptor(struct scsi_cmnd *cmd)
> +{
> +	ata_scsi_fill_buffer_descriptor(cmd, cmd->cmnd[1] == 0x3);
> +
> +	cmd->result = SAM_STAT_GOOD;
> +	return 1;
> +}
> +
> +static void ata_scsi_rwbuf_header(struct scsi_cmnd *cmd)
> +{
> +	struct scatterlist *sg = scsi_sglist(cmd);
> +	ata_scsi_fill_buffer_descriptor(cmd, 0);
> +
> +	/* XXX: fewer than 4 bytes in the page?  Doomed. */
> +	sg->offset += 4;
> +	sg->length -= 4;

I'm quite uncomfortable skipping any amount of validation.


> +/**
> + * ata_scsi_rwbuf_xlat - Translate READ_BUFFER and WRITE_BUFFER
> + *
> + * SCSI has a very flexible READ_BUFFER and WRITE_BUFFER system.
> + * ATA's READ BUFFER only supports an offset of 0 and length 512.
> + * SCSI also uses WRITE_BUFFER for DOWNLOAD MICROCODE, which is not
> + * yet supported by this function.
> + */
> +static unsigned int ata_scsi_rwbuf_xlat(struct ata_queued_cmd *qc)
> +{
> +	struct scsi_cmnd *scmd = qc->scsicmd;
> +	const u8 *cdb = scmd->cmnd;
> +	struct ata_taskfile *tf = &qc->tf;
> +	int offset = 0;
> +
> +	if (cdb[0] == WRITE_BUFFER) {
> +		tf->flags |= ATA_TFLAG_WRITE;
> +		tf->command = ATA_CMD_WRITE_BUFFER;
> +	} else {
> +		tf->command = ATA_CMD_READ_BUFFER;
> +	}
> +
> +	switch (cdb[1]) {
> +	case 0x0:	/* Read/write data with header */
> +		ata_scsi_rwbuf_header(scmd);
> +		offset = 4;
> +	case 0x2:	/* Read/write data */
> +	case 0xa:	/* Read/write echo buffer */
> +		break;
> +	case 0x3:	/* Read descriptor */
> +	case 0xb:	/* Read echo buffer descriptor */
> +		if (cdb[0] == READ_BUFFER)
> +			return ata_scsi_read_buffer_descriptor(scmd);
> +	case 0x4:
> +	case 0x5:
> +	case 0x6:
> +	case 0x7:
> +		/* XXX: We can translate to DOWNLOAD_MICROCODE here */

Style in libata is "FIXME" or "TODO" not "XXX".  Please help with 
consistency, it makes grepping easier.

Plus, I dunno about you, but I'm not a porn star :)

	Jeff




