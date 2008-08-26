From: Tejun Heo <tj@kernel.org>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 14:55:28 +0200
Message-ID: <48B3FD40.3000109@kernel.org>
References: <20080826072841.GS20055@kernel.dk> <20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk> <20080826101713.GW20055@kernel.dk> <48B3F7C3.6010600@wasp.net.au> <20080826124816.GA20055@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38808 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755899AbYHZM6Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 08:58:16 -0400
In-Reply-To: <20080826124816.GA20055@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Brad Campbell <brad@wasp.net.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org

Jens Axboe wrote:
> Given that this problem should be going away and that it only really
> matters on very select devices (like this SSD), I think we should just
> add a quick white list for the bridge limits.

Yeah, it sucks that up & coming SSDs are still using PATA-SATA bridges.
 The expectation when adding the wildcard limitation was that those P/S
bridges are not gonna be around for too long and the limit is most
likely not be an actual problem.  Oh well...

> Below is a quick'n dirty for that...
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 79e3a8e..fe8033a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2097,9 +2097,70 @@ retry:
>  	return rc;
>  }
>  
> +struct ata_blacklist_entry {
> +	const char *model_num;
> +	const char *model_rev;
> +	unsigned long horkage;
> +};
> +
> +static const struct ata_blacklist_entry ata_bridge_whitelist[] = {
> +	/*
> +	 * The following devices sit behind a bridge, but don't need
> +	 * transfer rate or size limits applied.
> +	 */
> +	{ "Mtron", },
> +
> +	/* End Marker */
> +	{ }
> +};

Any reason this can't be part of the existing blacklist?  It already
supports wildcard matching and all.

Thanks.

-- 
tejun
