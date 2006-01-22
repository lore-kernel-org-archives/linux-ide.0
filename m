From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 04/12] libata: add detailed AC_ERR_* flags
Date: Sun, 22 Jan 2006 04:30:26 -0500
Message-ID: <43D350B2.3020009@pobox.com>
References: <11379167101842-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:16102 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932251AbWAVJa3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 04:30:29 -0500
In-Reply-To: <11379167101842-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> Add detailed AC_ERR_* flags and use them.  Long-term goal is to
> describe all errors with err_mask and tf combination (tf for failed
> sector information, etc...).  After proper error diagnosis is
> implemented, sense data should also be generated from err_mask instead
> of directly from hardware tf registers as it is currently.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/ahci.c        |    6 ++----
>  drivers/scsi/libata-core.c |   12 ++++++------
>  drivers/scsi/sata_mv.c     |    2 +-
>  drivers/scsi/sata_sil24.c  |    2 +-
>  include/linux/libata.h     |   15 ++++++++++-----
>  5 files changed, 20 insertions(+), 17 deletions(-)
> 
> 1939435a8f0e7b2b1578b84cedd49f8adcab1ea9
> diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
> index 30676b0..e7b937b 100644
> --- a/drivers/scsi/ahci.c
> +++ b/drivers/scsi/ahci.c
> @@ -680,7 +680,7 @@ static void ahci_eng_timeout(struct ata_
>  	 	 * not being called from the SCSI EH.
>  	 	 */
>  		qc->scsidone = scsi_finish_command;
> -		qc->err_mask |= AC_ERR_OTHER;
> +		qc->err_mask |= AC_ERR_TIMEOUT;
>  		ata_qc_complete(qc);
>  	}
>  
> @@ -720,10 +720,8 @@ static inline int ahci_host_intr(struct 
>  		/* command processing has stopped due to error; restart */
>  		ahci_restart_port(ap, status);
>  
> -		if (qc) {
> -			qc->err_mask |= AC_ERR_OTHER;
> +		if (qc)
>  			ata_qc_complete(qc);
> -		}

why are you erasing the error mask here?


> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 43a2328..f5519f0 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -1142,7 +1142,7 @@ ata_exec_internal(struct ata_port *ap, s
>  		 * spurious interrupt.  We can live with that.
>  		 */
>  		if (qc->flags & ATA_QCFLAG_ACTIVE) {
> -			qc->err_mask = AC_ERR_OTHER;
> +			qc->err_mask = AC_ERR_TIMEOUT;
>  			ata_qc_complete(qc);
>  			printk(KERN_WARNING "ata%u: qc timeout (cmd 0x%x)\n",
>  			       ap->id, command);
> @@ -2917,7 +2917,7 @@ static unsigned long ata_pio_poll(struct
>  	status = ata_chk_status(ap);
>  	if (status & ATA_BUSY) {
>  		if (time_after(jiffies, ap->pio_task_timeout)) {
> -			qc->err_mask |= AC_ERR_ATA_BUS;
> +			qc->err_mask |= AC_ERR_TIMEOUT;
>  			ap->hsm_task_state = HSM_ST_TMOUT;
>  			return 0;
>  		}

perhaps you want to set both flags?  If BSY is stuck on, that's a 
problem with the ATA bus.


> @@ -4159,14 +4159,14 @@ static void atapi_packet_task(void *_dat
>  	/* sleep-wait for BSY to clear */
>  	DPRINTK("busy wait\n");
>  	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB)) {
> -		qc->err_mask |= AC_ERR_ATA_BUS;
> +		qc->err_mask |= AC_ERR_TIMEOUT;
>  		goto err_out;
>  	}

ditto

