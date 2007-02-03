From: Bob Stewart <bob@evoria.net>
Subject: Re: [PATCH] sata_inic162x: fix a few glitches in hardreset
Date: Sat, 3 Feb 2007 14:10:29 -0800 (PST)
Message-ID: <20070203221029.55415.qmail@web813.biz.mail.mud.yahoo.com>
References: <20070202062952.GB1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web813.biz.mail.mud.yahoo.com ([209.191.90.86]:38449 "HELO
	web813.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751649AbXBCWKa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 17:10:30 -0500
In-Reply-To: <20070202062952.GB1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Aaarrgghh, So sorry.  I meant to reply to this subject, not the other
one.  It's the sata_inic162x driver that I'm getting random results
and timeouts from.

Bob


--- Tejun Heo <htejun@gmail.com> wrote:

> * Hardreset must not exit without actually performing reset regardless
>   of link status.  We're resetting the link after all.
> 
> * Minor message update.
> 
> * 150ms delay is meaningful iff link is online after reset is
>   complete.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/sata_inic162x.c |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
> index b2a6f77..fad2bd3 100644
> --- a/drivers/ata/sata_inic162x.c
> +++ b/drivers/ata/sata_inic162x.c
> @@ -429,11 +429,6 @@ static int inic_hardreset(struct ata_port *ap, unsigned
> int *class)
>  	/* hammer it into sane state */
>  	inic_reset_port(port_base);
>  
> -	if (ata_port_offline(ap)) {
> -		*class = ATA_DEV_NONE;
> -		return 0;
> -	}
> -
>  	val = readw(idma_ctl);
>  	writew(val | IDMA_CTL_RST_ATA, idma_ctl);
>  	readw(idma_ctl);	/* flush */
> @@ -443,16 +438,17 @@ static int inic_hardreset(struct ata_port *ap, unsigned
> int *class)
>  	rc = sata_phy_resume(ap, timing);
>  	if (rc) {
>  		ata_port_printk(ap, KERN_WARNING, "failed to resume "
> -				"link for reset (errno=%d)\n", rc);
> +				"link after reset (errno=%d)\n", rc);
>  		return rc;
>  	}
>  
> -	msleep(150);
> -
>  	*class = ATA_DEV_NONE;
>  	if (ata_port_online(ap)) {
>  		struct ata_taskfile tf;
>  
> +		/* wait a while before checking status */
> +		msleep(150);
> +
>  		if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
>  			ata_port_printk(ap, KERN_WARNING,
>  					"device busy after hardreset\n");
> -- 
> 1.4.4.4
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

