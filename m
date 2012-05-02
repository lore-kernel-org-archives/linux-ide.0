From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-eh don't waste time retrying media errors (v3)
Date: Wed, 2 May 2012 12:33:43 -0700
Message-ID: <20120502193343.GA6411@google.com>
References: <4FA043BE.2010009@teksavvy.com>
 <4FA04714.7050602@teksavvy.com>
 <20120501215854.GA21677@google.com>
 <4FA07655.6090506@teksavvy.com>
 <4FA07932.2090003@teksavvy.com>
 <4FA0A3F7.7000401@teksavvy.com>
 <20120502155414.GB21677@google.com>
 <4FA1898C.5070108@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44166 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756401Ab2EBTds (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 May 2012 15:33:48 -0400
Received: by pbbrp8 with SMTP id rp8so1499135pbb.19
        for <linux-ide@vger.kernel.org>; Wed, 02 May 2012 12:33:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FA1898C.5070108@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, May 02, 2012 at 03:22:52PM -0400, Mark Lord wrote:
> ATA and SATA drives have had built-in retries for media errors
> for as long as they've been commonplace in computers (early 1990s).
> 
> When libata stumbles across a bad sector, it can waste minutes
> sitting there doing retry after retry before finally giving up
> and letting the higher layers deal with it.
> 
> This patch removes retries for media errors only.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> version 3: try to improve readability.
> 
> --- old/drivers/ata/libata-eh.c	2012-04-27 13:17:35.000000000 -0400
> +++ linux/drivers/ata/libata-eh.c	2012-05-02 15:20:19.946827031 -0400
> @@ -2046,6 +2046,26 @@
>  }
> 
>  /**
> + *	ata_eh_worth_retry - analyze error and decide whether to retry
> + *	@qc: qc to possibly retry
> + *
> + *	Look at the cause of the error and decide if a retry
> + * 	might be useful or not.  We don't want to retry media errors
> + *	because the drive itself has probably already taken 10-30 seconds
> + *	doing its own internal retries before reporting the failure.
> + */
> +static inline int ata_eh_worth_retry(struct ata_queued_cmd *qc)

Return bool? && maybe split the patch into two - the first separating
out the logic into a function, the latter changing emedia handling?

> +{
> +	if (qc->flags & AC_ERR_MEDIA)
> +		return 0;	/* don't retry media errors */
> +	if (qc->flags & ATA_QCFLAG_IO)
> +		return 1;	/* otherwise retry anything from fs stack */
> +	if (qc->err_mask & AC_ERR_INVALID)
> +		return 0;	/* don't retry these */
> +	return qc->err_mask != AC_ERR_DEV;  /* retry if not dev error */
> +}

Other than that,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
