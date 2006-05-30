From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/12] libata-hp-prep: implement sata_phy_debounce()
Date: Tue, 30 May 2006 00:10:33 -0400
Message-ID: <447BC5B9.2070509@pobox.com>
References: <11488839583691-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38115 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751464AbWE3EK4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:10:56 -0400
In-Reply-To: <11488839583691-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> With hotplug, PHY always needs to be debounced before a reset as any
> reset might find new devices.  Extract PHY waiting code from
> sata_phy_resume() and extend it to include SStatus debouncing.  Note
> that sata_phy_debounce() is superset of what used to be done inside
> sata_phy_resume().
> 
> Three default debounce timing parameters are defined to be used by
> hot/boot plug.  As resume failure during probing will be properly
> handled as errors, timeout doesn't have to be long as before.
> probeinit() uses the same timeout to retain the original behavior.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |  104 ++++++++++++++++++++++++++++++++++++++------
>  include/linux/libata.h     |    6 +++
>  2 files changed, 95 insertions(+), 15 deletions(-)
> 
> c9aae0f91110060a799f70706bd06ec0dab80cb0
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 009db45..9763395 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -61,6 +61,11 @@ #include <asm/byteorder.h>
>  
>  #include "libata.h"
>  
> +/* debounce timing parameters in msecs { interval, duration, timeout } */
> +const unsigned long sata_deb_timing_boot[]		= {   5,  100, 2000 };
> +const unsigned long sata_deb_timing_eh[]		= {  25,  500, 2000 };
> +const unsigned long sata_deb_timing_before_fsrst[]	= { 100, 2000, 5000 };
> +
>  static unsigned int ata_dev_init_params(struct ata_device *dev,
>  					u16 heads, u16 sectors);
>  static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
> @@ -2427,10 +2432,81 @@ err_out:
>  	DPRINTK("EXIT\n");
>  }
>  
> -static int sata_phy_resume(struct ata_port *ap)
> +/**
> + *	sata_phy_debounce - debounce SATA phy status
> + *	@ap: ATA port to debounce SATA phy status for
> + *	@params: timing parameters { interval, duratinon, timeout } in msec
> + *
> + *	Make sure SStatus of @ap reaches stable state, determined by
> + *	holding the same value where DET is not 1 for @duration polled
> + *	every @interval, before @timeout.  Timeout constraints the
> + *	beginning of the stable state.  Because, after hot unplugging,
> + *	DET gets stuck at 1 on some controllers, this functions waits
> + *	until timeout then returns 0 if DET is stable at 1.
> + *
> + *	LOCKING:
> + *	Kernel thread context (may sleep)
> + *
> + *	RETURNS:
> + *	0 on success, -errno on failure.
> + */
> +int sata_phy_debounce(struct ata_port *ap, const unsigned long *params)
>  {
> -	unsigned long timeout = jiffies + (HZ * 5);
> -	u32 scontrol, sstatus;
> +	unsigned long interval_msec = params[0];
> +	unsigned long duration = params[1] * HZ / 1000;
> +	unsigned long timeout = jiffies + params[2] * HZ / 1000;
> +	unsigned long last_jiffies;
> +	u32 last, cur;
> +	int rc;
> +
> +	if ((rc = sata_scr_read(ap, SCR_STATUS, &cur)))
> +		return rc;
> +	cur &= 0xf;
> +
> +	last = cur;
> +	last_jiffies = jiffies;
> +
> +	while (1) {
> +		msleep(interval_msec);
> +		if ((rc = sata_scr_read(ap, SCR_STATUS, &cur)))
> +			return rc;
> +		cur &= 0xf;
> +
> +		/* DET stable? */
> +		if (cur == last) {
> +			if (cur == 1 && time_before(jiffies, timeout))
> +				continue;
> +			if (time_after(jiffies, last_jiffies + duration))
> +				return 0;
> +			continue;
> +		}

NAK, changes behavior.  We want to preserve the old order of operations 
because some PHYs (sata_via and sata_mv come to mind) are a bit 
sensitive to being pounded immediately after wakeup.

	Jeff



