From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC 1/5] libata-dev: Move out the HSM code from ata_host_intr()
Date: Fri, 10 Mar 2006 18:18:39 +0900
Message-ID: <20060310091839.GA20207@htj.dyndns.org>
References: <440FEA4B.10500@tw.ibm.com> <440FEB0C.5070106@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:48653 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751083AbWCJJTV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Mar 2006 04:19:21 -0500
Received: by pproxy.gmail.com with SMTP id d42so350521pyd
        for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 01:19:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <440FEB0C.5070106@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

The patch contains three trailing whitespaces which are probably just
carried over from the original code.  Please kill the whitespaces.

On Thu, Mar 09, 2006 at 04:45:00PM +0800, Albert Lee wrote:
> Move out the irq-pio HSM code from ata_host_intr() to the new ata_hsm_move() function verbatim.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> 
> ---
> 
> --- irq-pio/drivers/scsi/libata-core.c	2006-03-08 14:24:54.000000000 +0800
> +++ 01_move_out/drivers/scsi/libata-core.c	2006-03-08 18:10:21.000000000 +0800
> @@ -3628,6 +3628,111 @@ static void ata_pio_error(struct ata_por
>  	ata_poll_qc_complete(qc);
>  }
>  
> +static void ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
> +			u8 status)
> +{
> +	/* check error */
> +	if (unlikely(status & (ATA_ERR | ATA_DF))) {
> +		qc->err_mask |= AC_ERR_DEV;
> +		ap->hsm_task_state = HSM_ST_ERR;
> +	}
> +
> +fsm_start:
> +	switch (ap->hsm_task_state) {
> +	case HSM_ST_FIRST:
> +		/* Some pre-ATAPI-4 devices assert INTRQ 

Here.

> +		 * at this state when ready to receive CDB.
> +		 */
> +
> +		/* check device status */
> +		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
> +			/* Wrong status. Let EH handle this */
> +			qc->err_mask |= AC_ERR_HSM;
> +			ap->hsm_task_state = HSM_ST_ERR;
> +			goto fsm_start;
> +		}
> +
> +		atapi_send_cdb(ap, qc);
> +
> +		break;
> +
> +	case HSM_ST:
> +		/* complete command or read/write the data register */
> +		if (qc->tf.protocol == ATA_PROT_ATAPI) {
> +			/* ATAPI PIO protocol */
> +			if ((status & ATA_DRQ) == 0) {
> +				/* no more data to transfer */
> +				ap->hsm_task_state = HSM_ST_LAST;
> +				goto fsm_start;
> +			}
> +			

Here.

> +			atapi_pio_bytes(qc);
> +
> +			if (unlikely(ap->hsm_task_state == HSM_ST_ERR))
> +				/* bad ireason reported by device */
> +				goto fsm_start;
> +
> +		} else {
> +			/* ATA PIO protocol */
> +			if (unlikely((status & ATA_DRQ) == 0)) {
> +				/* handle BSY=0, DRQ=0 as error */
> +				qc->err_mask |= AC_ERR_HSM;
> +				ap->hsm_task_state = HSM_ST_ERR;
> +				goto fsm_start;
> +			}
> +
> +			ata_pio_sectors(qc);
> +
> +			if (ap->hsm_task_state == HSM_ST_LAST &&
> +			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
> +				/* all data read */
> +				ata_altstatus(ap);
> +				status = ata_chk_status(ap);
> +				goto fsm_start;
> +			}
> +		}
> +
> +		ata_altstatus(ap); /* flush */
> +		break;
> +
> +	case HSM_ST_LAST:
> +		if (unlikely(status & ATA_DRQ)) {
> +			/* handle DRQ=1 as error */
> +			qc->err_mask |= AC_ERR_HSM;
> +			ap->hsm_task_state = HSM_ST_ERR;
> +			goto fsm_start;
> +		}
> +
> +		/* no more data to transfer */
> +		DPRINTK("ata%u: command complete, drv_stat 0x%x\n",
> +			ap->id, status);
> +
> +		ap->hsm_task_state = HSM_ST_IDLE;
> +
> +		/* complete taskfile transaction */
> +		qc->err_mask |= ac_err_mask(status);
> +		ata_qc_complete(qc);
> +		break;
> +
> +	case HSM_ST_ERR:
> +		if (qc->tf.command != ATA_CMD_PACKET)
> +			printk(KERN_ERR "ata%u: command error, drv_stat 0x%x host_stat 0x%x\n",
> +			       ap->id, status, host_stat);
> +
> +		/* make sure qc->err_mask is available to 

And here.

-- 
tejun
