From: Bob Stewart <bob@evoria.net>
Subject: Re: [PATCH] libata: add 150ms between completion of hardreset and status checking
Date: Sat, 3 Feb 2007 14:07:55 -0800 (PST)
Message-ID: <653885.83039.qm@web807.biz.mail.mud.yahoo.com>
References: <20070202062927.GA1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web807.biz.mail.mud.yahoo.com ([209.191.90.80]:36551 "HELO
	web807.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751632AbXBCWH4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 17:07:56 -0500
In-Reply-To: <20070202062927.GA1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun,

There is still something else bad going on in your driver.  I've tried
everything I can think of (timing changes, flushes, and whatnot)
but I still get random timeouts and random results from md5sum
on large files.  Even in the case where I don't get a timeout on a large
iso file, the md5sum is still random.  Strangely enough, though, 
the files may be good on-disk, since totem seems to play the DVD.iso
that I'm testing with without a problem.  I'm using debian with a 2.6.19.2
kernel.

Bob


--- Tejun Heo <htejun@gmail.com> wrote:

> Follow the old SRST rule and delay 150ms between completion of
> hardreset and status checking.  Debouncing delay should usually cover
> this but debounce duration could be shorter than 150ms under certain
> circumstances.
> 
> Usefulness depends on host controller implementation but it can't hurt
> and serves as a reminder that 2s delay for GoVault should also be
> added here.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index f210dbd..582e44d 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3014,6 +3014,9 @@ int sata_std_hardreset(struct ata_port *ap, unsigned
> int *class)
>  		return 0;
>  	}
>  
> +	/* wait a while before checking status, see SRST for more info */
> +	msleep(150);
> +
>  	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
>  		ata_port_printk(ap, KERN_ERR,
>  				"COMRESET failed (device not ready)\n");
> -- 
> 1.4.4.4
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

