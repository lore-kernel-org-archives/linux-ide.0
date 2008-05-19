From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 05/10] libata: ignore recovered PHY errors
Date: Mon, 19 May 2008 17:50:35 -0400
Message-ID: <4831F62B.7050004@garzik.org>
References: <12111273141039-git-send-email-htejun@gmail.com> <12111273183948-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35919 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755029AbYESVug (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 May 2008 17:50:36 -0400
In-Reply-To: <12111273183948-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca

Tejun Heo wrote:
> No reason to get overzealous about recovered comm and data errors.
> Some PHYs habitually sets them w/o no good reason and being draconian
> about these soft error conditions doesn't seem to help anybody.
> 
> If need ever rises, we might need to add soft PHY error condition, say
> AC_ERR_MAYBE_ATA_BUS and use it only to determine whether speed down
> is necessary but I don't think that's very likely to happen.  It's far
> more likely we'll get timeouts or fatal transmission errors if
> recovered errors are so prominent that they hamper operation.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 751dad0..7894d83 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1308,12 +1308,7 @@ static void ata_eh_analyze_serror(struct ata_link *link)
>  	unsigned int err_mask = 0, action = 0;
>  	u32 hotplug_mask;
>  
> -	if (serror & SERR_PERSISTENT) {
> -		err_mask |= AC_ERR_ATA_BUS;
> -		action |= ATA_EH_RESET;
> -	}
> -	if (serror &
> -	    (SERR_DATA_RECOVERED | SERR_COMM_RECOVERED | SERR_DATA)) {
> +	if (serror & (SERR_PERSISTENT | SERR_DATA)) {
>  		err_mask |= AC_ERR_ATA_BUS;
>  		action |= ATA_EH_RESET;

We should keep track of these events, though, a la struct net_device_stats

	Jeff



