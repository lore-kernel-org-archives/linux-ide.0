From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-pmp: add schedule timeout to support some PMP
 cards
Date: Thu, 3 Nov 2011 09:07:59 -0700
Message-ID: <20111103160759.GI4417@google.com>
References: <1320033440-1106-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57808 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933739Ab1KCQIF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Nov 2011 12:08:05 -0400
Received: by ywf7 with SMTP id 7so1475238ywf.19
        for <linux-ide@vger.kernel.org>; Thu, 03 Nov 2011 09:08:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1320033440-1106-1-git-send-email-r66093@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: r66093@freescale.com
Cc: linux-ide@vger.kernel.org

Hello,

On Mon, Oct 31, 2011 at 11:57:20AM +0800, r66093@freescale.com wrote:
> From: Jerry Huang <r66093freescale.com>
> 
> With Freescale SATA controller, some PMP cards(e.g JMB393 PMP card)
> can't work on some platforms (e.g mpc837x, p1022):
> During PMP initialize, when reading the PMP SCR, we will observe the TIMEOUT
> error because PMP card SCR is not ready.
> Therefore, we need enough time to wait for the PMP card ready for SCR read:
> 1. read the SCR after 1ms sleep,
> 2. if failed, looping until read success or timeout (count = 0)
...
> diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> index 224faab..18d5f8e 100644
> --- a/drivers/ata/libata-pmp.c
> +++ b/drivers/ata/libata-pmp.c
> @@ -140,11 +140,19 @@ int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc)
>  int sata_pmp_scr_read(struct ata_link *link, int reg, u32 *r_val)
>  {
>  	unsigned int err_mask;
> +	int count = 20;	/* try 20 times */
>  
>  	if (reg > SATA_PMP_PSCR_CONTROL)
>  		return -EINVAL;
>  
> -	err_mask = sata_pmp_read(link, reg, r_val);
> +	do {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(1 * HZ / 1000); /* sleep 1 msecond */
> +		set_current_state(TASK_RUNNING);
> +
> +		err_mask = sata_pmp_read(link, reg, r_val);
> +	} while ((count--) && err_mask);

Ummm... We can't really issue commands after failure without going
through recovery.  For ahci, it probably works.  For other
controllers, it may not.  Where does this delay come from?  Is there
any other way to wait for device readiness?

Thanks.

-- 
tejun
