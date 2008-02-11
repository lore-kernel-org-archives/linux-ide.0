From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] libata: make EH fail gracefully if no reset
 method is available
Date: Mon, 11 Feb 2008 14:25:28 -0500
Message-ID: <47B0A128.4020002@garzik.org>
References: <47A040E2.1050801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56850 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757305AbYBKTZa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Feb 2008 14:25:30 -0500
In-Reply-To: <47A040E2.1050801@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> When no reset method is available, libata currently oopses.  Although
> the condition can't happen unless there's a bug in a low level driver,
> oopsing isn't the best way to report the error condition.  Complain,
> dump stack and fail reset instead.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This patch is on top of
> 
> upstream (a984f58dd97f22f5113700322fed311a0ee29947)
> + prefer-hardreset patchset
>   http://thread.gmane.org/gmane.linux.ide/27447
> 
>  drivers/ata/libata-eh.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 64418f1..8d82b06 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2135,9 +2135,14 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  	if (hardreset) {
>  		reset = hardreset;
>  		ehc->i.action = ATA_EH_HARDRESET;
> -	} else {
> +	} else if (softreset) {
>  		reset = softreset;
>  		ehc->i.action = ATA_EH_SOFTRESET;
> +	} else {
> +		ata_link_printk(link, KERN_ERR, "BUG: no reset method, "
> +				"please report to linux-ide@vger.kernel.org\n");
> +		dump_stack();
> +		return -EINVAL;

ACK, but holding due to hold on prefer-hardreset patch (pinging device 
manufacturers)


