From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Thu, 8 Jan 2015 10:11:51 -0500
Message-ID: <20150108151151.GC9402@htj.dyndns.org>
References: <20150107152648.GC4395@htj.dyndns.org>
 <1420727311-7066-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:59429 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbbAHPLz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jan 2015 10:11:55 -0500
Content-Disposition: inline
In-Reply-To: <1420727311-7066-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org

Hello, Martin.

The patch looks okay to me.  Just one nit.

On Thu, Jan 08, 2015 at 09:28:31AM -0500, Martin K. Petersen wrote:
> @@ -4233,10 +4233,20 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
>  
>  	/* devices that don't properly handle queued TRIM commands */
> -	{ "Micron_M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
> -	{ "Crucial_CT???M500SSD*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
> -	{ "Micron_M550*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
> -	{ "Crucial_CT*M550SSD*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
> +	{ "Micron_M[56]*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> +						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +	{ "Crucial_CT*SSD*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
> +
> +	/*
> +	 * DRAT/RZAT are weak guarantees. Explicitly black/whitelist
> +	 * SSDs that provide reliable zero after TRIM.
> +	 */

Can you please be more detailed on the above explanation?  It's not
like most people would be familiar with acronyms like DRAT/RZAT and
what the surrounding situation is like to require this sort of
whitelisting.

> +	{ "INTEL*SSDSC2MH*",		NULL,	0, }, /* Blacklist intel 510 */
> +	{ "INTEL*SSD*", 		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },

I think the above two can use a bit more verbose explanation too.

> +	{ "SSD*INTEL*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +	{ "Samsung*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +	{ "SAMSUNG*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +	{ "ST[1248][0248]0[FH]*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },

Thanks.

-- 
tejun
