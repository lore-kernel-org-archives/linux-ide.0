From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: prevent HSM state change race between ISR and PIO
Date: Mon, 19 Jan 2015 12:41:41 -0500
Message-ID: <20150119174141.GB10570@htj.dyndns.org>
References: <1421684851-14561-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:46133 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbbASRlx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2015 12:41:53 -0500
Received: by mail-qg0-f47.google.com with SMTP id j5so12530074qga.6
        for <linux-ide@vger.kernel.org>; Mon, 19 Jan 2015 09:41:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1421684851-14561-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org

On Mon, Jan 19, 2015 at 10:27:31AM -0600, David Milburn wrote:
>  void ata_sff_flush_pio_task(struct ata_port *ap)
>  {
> +	struct Scsi_Host *host = ap->scsi_host;
> +	unsigned long flags;
> +
>  	DPRINTK("ENTER\n");
>  
>  	cancel_delayed_work_sync(&ap->sff_pio_task);
> +
> +	/* prevent racing with ISR's use of ap->hsm_task_state */

Can we have a more descriptive comment please?  lock, assign, unlock
sequence is pretty unusual, so let's give the full explanation here.

> +	spin_lock_irqsave(host->host_lock, flags);
>  	ap->hsm_task_state = HSM_ST_IDLE;
> +	spin_unlock_irqrestore(host->host_lock, flags);

Other than that, yeah, nice spotting.

Thanks.

-- 
tejun
