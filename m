From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata total system lockup fix
Date: Thu, 11 Aug 2005 16:13:02 -0400
Message-ID: <42FBB14E.5040002@pobox.com>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com> <20050805040105.GA18466@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:31912 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932420AbVHKUNI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 16:13:08 -0400
In-Reply-To: <20050805040105.GA18466@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Mark Lord <mlord@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, hare@suse.de

Tejun Heo wrote:
>  And this is the combined patch against ncq head of libata-dev-2.6
> tree.  Commit d032ec9048ff82a704b96b93cfd6f2e8e3a06b19.
> 
>  Only ata_piix, sata_sil and ahci are converted and all other SATA
> drivers are broken.  So, enable only those three SATA drivers when
> compiling with this patch.

Overall, the approach of adding a timeout to the 'special' commands is a 
good, and necessary approach.

Comments follow...


> Index: work/drivers/scsi/libata-core.c
> ===================================================================
> --- work.orig/drivers/scsi/libata-core.c	2005-08-05 12:55:08.000000000 +0900
> +++ work/drivers/scsi/libata-core.c	2005-08-05 12:55:50.000000000 +0900
> @@ -49,6 +49,10 @@
>  
>  #include "libata.h"
>  
> +#define ata_for_each_tag(tag, mask) \
> +	for (tag = find_first_bit(&mask, ATA_MAX_CMDS); tag < ATA_MAX_CMDS; \
> +	     tag = find_next_bit(&mask, ATA_MAX_CMDS, tag + 1))
> +
>  static unsigned int ata_busy_sleep (struct ata_port *ap,
>  				    unsigned long tmout_pat,
>  			    	    unsigned long tmout);
> @@ -59,7 +63,6 @@ static int fgb(u32 bitmap);
>  static int ata_choose_xfer_mode(struct ata_port *ap,
>  				u8 *xfer_mode_out,
>  				unsigned int *xfer_shift_out);
> -static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
>  static void __ata_qc_complete(struct ata_queued_cmd *qc);
>  
>  static unsigned int ata_unique_id = 1;
> @@ -70,6 +73,87 @@ MODULE_DESCRIPTION("Library module for A
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(DRV_VERSION);
>  
> +static void ata_qc_complete_noop(struct ata_queued_cmd *qc)
> +{
> +	/* noop */
> +}
> +
> +static void ata_qc_exec_special_timeout(unsigned long data)
> +{
> +	struct completion *wait = (void *)data;
> +	complete(wait);
> +}
> +
> +/**
> + *	ata_qc_exec_special - execute libata internal special command
> + *	@qc: Command to execute
> + *	@tmout: timeout in jiffies
> + *
> + *	Executes libata internal command with timeout.  Timeout and
> + *	error conditions are reported via return value.  No recovery
> + *	action is taken after a command times out.  It's caller's duto
> + *	to clean up after timeout.
> + *
> + *	Also, note that error condition is checked after the qc is
> + *	completed, meaning that if another command is issued before
> + *	checking the condition, we get the wrong values.  As special
> + *	cmds are used only for initialization and recovery, this
> + *	won't cause any problem currently.
> + *
> + *	LOCKING:
> + *	None.  Should be called with kernel context, might sleep.
> + */
> +
> +static int ata_qc_exec_special(struct ata_queued_cmd *qc, unsigned long tmout)
> +{
> +	struct ata_port *ap = qc->ap;
> +	DECLARE_COMPLETION(wait);
> +	struct timer_list timer;
> +	int rc;
> +
> +	might_sleep();
> +
> +	if (ata_busy_sleep(ap, ATA_TMOUT_SPECIAL_QUICK, ATA_TMOUT_SPECIAL))
> +		return -ETIMEDOUT;
> +
> +	qc->complete_fn = ata_qc_complete_noop;
> +	qc->waiting = &wait;
> +
> +	if (tmout) {
> +		init_timer(&timer);
> +		timer.function = ata_qc_exec_special_timeout;
> +		timer.data = (unsigned long)&wait;
> +		timer.expires = jiffies + tmout;
> +		add_timer(&timer);

Just use mod_timer(), and combine these last two lines into a single one.


> +	spin_lock_irq(&ap->host_set->lock);
> +	rc = ata_qc_issue(qc);
> +	spin_unlock_irq(&ap->host_set->lock);
> +
> +	if (rc) {
> +		if (tmout)
> +			del_timer(&timer);

Use del_timer_sync() here, and for every case where you are not inside a 
spinlock.


> +		return -EAGAIN;	/* any better value for issue failure? */
> +	}
> +
> +	wait_for_completion(&wait);
> +
> +	if (tmout && !del_timer(&timer)) {
> +		spin_lock_irq(&ap->host_set->lock);
> +		if (qc->waiting == &wait) {
> +			ata_qc_complete(qc);
> +			rc = -ETIMEDOUT;
> +		}
> +		spin_unlock_irq(&ap->host_set->lock);
> +	}
> +
> +	if (rc == 0 && !ata_ok(ata_chk_status(ap)))
> +		rc = -EIO;

General comment on libata:  we should move away from using the Status 
register directly, and more towards an indication that the taskfile 
described by the queue_cmd is in error.  i.e. add an 'error' flag or 
something like that.

The rest seems fairly sane.

General comment on libata error handling:  as soon as SATA ATAPI is 
complete, we can move libata to using SCSI's fine-grained error handling 
hooks (eh_{abort,timeout,bus,host}_handler), which will make error 
handling easier, and avoid the problems that keep cropping up with the 
->eh_strategy_handler() approach.

	Jeff


