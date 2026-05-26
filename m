Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238733BBA08
	for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802998; cv=none; b=fuUIWiEExiTsUBhRiLXTXIhNxJtwTMzzU7dv2Z1ackstwLbl1jUXjplgu9hXPPLxJXzfSNCHS9tqk5T2yCHttAxMkKeFYzfoBZdVWekT9ighx7UsaR4Aczj7HBGi6hs/a2xNy3kgCZKnvHy4U0rFSXfOSExrkgDC5eccvqnHdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802998; c=relaxed/simple;
	bh=qn29OrkIq0fTzEDGw1CDUUHxpX4NHNdTUCdH8DAs/BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDLPFoL8TNtEaI29bBVl8Ryn+Uxh2966P5J3mE2DAepHm6Bw0zLFQ/dNkyTYtIGtMkkuHp3Qc2H/UO98HAjnsulw3rNlC77ZQsFgTW4+lZzf/D06IIVirw48U0JGdAdw5bFsvnb7qRuGz18BeOhcxbrwQzrlRZDAr/tBSd2dTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLwPA/of; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLwPA/of"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A240B1F000E9;
	Tue, 26 May 2026 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802997;
	bh=hDyq2L8j/CGqlIrqcupGxm9jzIEYMIFllfi/ubDT0tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WLwPA/ofPMTdh3r+Eg0l3YpB+4FgmPCigWtVIOSfIrzTtJCCastvE4tXSQelX/GO1
	 qQcR/eH61syvIo34mlBWQSh8872is6k1ak+0u9tLInU/n0x40zUf+PS72sw/qAf7I4
	 QNv1p92uiPnCbV5hACTSIz7r7A7QCjTwKDz+rDHrGNzVVLcn8HM3RLUAEhWpgtn+08
	 ODSjz8bF/k5t5JDyHExlsCFk7m3UOWkKatV8jwJUgwNete9YZUF3wrz6VHfLu4xwWs
	 YjbCIe1DvuL1/z1GcDe87ypHtPTgvxgJ5BnUmsJ0kFvgrKyNtOpjEUe0SIQm1mSm7N
	 ux4Ma1FksO4TQ==
Date: Tue, 26 May 2026 15:43:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>, Jeff Garzik <jgarzik@redhat.com>,
	Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH v2 1/9] ata: libata: Fix ata_exec_internal()
Message-ID: <ahWjcGUeSo76OIs3@ryzen>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521173347.2079560-2-bvanassche@acm.org>

On Thu, May 21, 2026 at 10:33:29AM -0700, Bart Van Assche wrote:
> Some but not all ata_exec_internal() calls happen from the context of
> the ATA error handler. Commit c0c362b60e25 ("libata: implement cross-port
> EH exclusion") added ata_eh_release() and ata_eh_acquire() calls in
> ata_exec_internal(). Calling these functions is necessary if the caller
> holds the eh_mutex but is not allowed if the caller doesn't hold that
> mutex. Fix this by only calling ata_eh_release() and ata_eh_acquire() if
> the caller holds the eh_mutex. An example of an indirect caller of
> ata_exec_internal() that does not hold the eh_mutex is
> ata_host_register().
> 
> Fixes: c0c362b60e25 ("libata: implement cross-port EH exclusion")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/ata/libata-core.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e76d15411e2a..3d25dec6ac6c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1540,6 +1540,7 @@ unsigned int ata_exec_internal(struct ata_device *dev, struct ata_taskfile *tf,
>  {
>  	struct ata_link *link = dev->link;
>  	struct ata_port *ap = link->ap;
> +	const bool owns_eh_mutex = ap->host->eh_owner == current;

We have similar code in ata_msleep(), which does:

bool owns_eh = ap && ap->host->eh_owner == current;

do we perhaps want the "ap && " here as well?


>  	u8 command = tf->command;
>  	struct ata_queued_cmd *qc;
>  	struct scatterlist sgl;
> @@ -1617,11 +1618,25 @@ unsigned int ata_exec_internal(struct ata_device *dev, struct ata_taskfile *tf,
>  		}
>  	}
>  
> -	ata_eh_release(ap);
> +	if (owns_eh_mutex) {
> +		/*
> +		 * To prevent that the compiler complains about the
> +		 * ata_eh_release() call below.
> +		 */
> +		__acquire(&ap->host->eh_mutex);
> +		ata_eh_release(ap);
> +	}
>  
>  	rc = wait_for_completion_timeout(&wait, msecs_to_jiffies(timeout));
>  
> -	ata_eh_acquire(ap);
> +	if (owns_eh_mutex) {
> +		ata_eh_acquire(ap);
> +		/*
> +		 * To prevent that the compiler complains about the above
> +		 * ata_eh_acquire() call.
> +		 */
> +		__release(&ap->host->eh_mutex);
> +	}
>  
>  	ata_sff_flush_pio_task(ap);
>  

Otherwise, this looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
