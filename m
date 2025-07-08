Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38E2DA77B
	for <linux-ide@vger.kernel.org>; Tue,  8 Jul 2025 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978057; cv=none; b=VXsiUjyWy9vzdT2lh5ulSZFAI9jx09JHzXy14hmeI+HMhTDUc42Q874TmMU9RhQY8m+9QWu4+j36icQh4UFTAdoTL0M6gwVW3+YD69v755eZlcDHqYzfSi+2XD9o5Acwb9UNKbNwwipFPUy58rn0NMONlEN1fLPUd6ukm4VKa10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978057; c=relaxed/simple;
	bh=DOx7F8P9VhX3YW/VXEy+U0JLfF70BL7tBIb/FfjO/cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRBAzH7fkyXuMnr7ogIz7VdDH3d0UD68sp4YV1O4UjyOmQPmM0GUvDxsEBq+hN8TM5w/fhKKM48sPSsx1aLK6c4WmN9OFWsJCxDDvY18pSJ0eC1kvR7QiQyC/GhcURMZRuhqWuV8Las+cwJsWUqZE3U7RpAIx4LdnsF2IMwff+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCgND0T3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCgND0T3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE99BC4CEF0;
	Tue,  8 Jul 2025 12:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751978057;
	bh=DOx7F8P9VhX3YW/VXEy+U0JLfF70BL7tBIb/FfjO/cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCgND0T3Y1Zt8mR0YOW112iB7YXt2sznAt2RRt5rpvxV9lxfm1XRL9eCTka4BORQa
	 7DvJBLBTCztpt3um+tS1TOt8yILjeg6C5G8y/oilDdmAcjWlJxnCyQ9frQwpfzgy2i
	 QE+QVB/5uODbUIfFpxd8jAJynBiaVn/o9wQn/LT2WioytCUk7upR94RAO8LPZT3g5q
	 AjHeABW1benAHmRqBep/7VyJjbiWHLtt4zpmyB8KKSTGU3Vfp0i8EogBAdP0xSPFEH
	 oxCBj/8dDgJsbhErRetp6ewdFasBAXmC55+/v3ueoUU87GNR4GaedHYUMeoXgIzs7w
	 1voa1y43XtjAg==
Date: Tue, 8 Jul 2025 14:34:14 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ata: libata-eh: Remove ata_do_eh()
Message-ID: <aG0QRvgIt4R3ZNFi@ryzen>
References: <20250708073648.45171-1-dlemoal@kernel.org>
 <20250708073648.45171-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708073648.45171-3-dlemoal@kernel.org>

On Tue, Jul 08, 2025 at 04:36:47PM +0900, Damien Le Moal wrote:
> The only reason for ata_do_eh() to exist is that the two caller sites,
> ata_std_error_handler() and ata_sff_error_handler() may pass to it a

s/may pass to it a/may pass it a/


> NULL hardreset operation so that the built-in (generic) hardreset
> operation for a driver is ignored if the adapter SCR access is not
> available.
> 
> However, ata_std_error_handler() and ata_sff_error_handler()
> modifications of the hardreset port operation can easily be combined as
> they are mutually exclusive. That is, a driver using

sata_std_hardreset() can be on previous line without exceeding 75 columns.


> sata_std_hardreset() as its hardreset operation cannot use
> sata_sff_hardreset() and vice-versa.
> 
> With this observation, ata_do_eh() can be removed and its code moved to
> ata_std_error_handler(). The condition used to ignore the builtin

s/builtin/built-in/


> hardreset port operations is modified to be the one that was used in

s/operations/operations/

(you are ignoring the built-in hardreset operation, which is either
sata_std_hardreset() or sata_sff_hardreset(), but still the function
pointer will point to a single operation, so I think singular is more
correct here.)


> ata_sff_error_handler(). This requires defining a stub for the function
> sata_sff_hardreset() to avoid compilation errors when CONFIG_ATA_SFF is
> not enabled.
> 
> This change simplifies ata_sff_error_handler() as this function now only
> needs to call ata_std_error_handler().
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-eh.c  | 46 ++++++++++++----------------------------
>  drivers/ata/libata-sff.c | 10 +--------
>  include/linux/libata.h   | 11 +++++++---
>  3 files changed, 22 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 436536112043..68581adc6f87 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -4067,59 +4067,39 @@ void ata_eh_finish(struct ata_port *ap)
>  }
>  
>  /**
> - *	ata_do_eh - do standard error handling
> + *	ata_std_error_handler - standard error handler
>   *	@ap: host port to handle error for
>   *
> - *	@prereset: prereset method (can be NULL)
> - *	@softreset: softreset method (can be NULL)
> - *	@hardreset: hardreset method (can be NULL)
> - *	@postreset: postreset method (can be NULL)
> - *
>   *	Perform standard error handling sequence.
>   *
>   *	LOCKING:
>   *	Kernel thread context (may sleep).
>   */
> -void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
> -	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
> -	       ata_postreset_fn_t postreset)
> +void ata_std_error_handler(struct ata_port *ap)
>  {
> -	struct ata_device *dev;
> +	struct ata_port_operations *ops = ap->ops;
> +	ata_reset_fn_t hardreset = ops->hardreset;
>  	int rc;
>  
> +	/* Ignore built-in hardresets if SCR access is not available */
> +	if ((hardreset == sata_std_hardreset ||
> +	     hardreset == sata_sff_hardreset) && !sata_scr_valid(&ap->link))
> +		hardreset = NULL;

I think it would be nicer to just do:

if ((hardreset == sata_std_hardreset ||
     hardreset == sata_sff_hardreset) && !sata_scr_valid(&ap->link))
     link->flags |= ATA_LFLAG_NO_HRST;

since ata_eh_reset() will already do
hardreset = NULL; if that flag is set.

This way, we can also simplify the function signature of ata_eh_recover() to:

int ata_eh_recover(struct ata_port *ap, bool use_pmp_ops,
                   struct ata_link **r_failed_link)

and ata_eh_reset() to:

int ata_eh_reset(struct ata_link *link, int classify, bool use_pmp_ops)


And then in:
int ata_eh_reset(struct ata_link *link, int classify, bool use_pmp_ops)
{
	...
	if (use_pmp_ops) {
		prereset = ops->prereset;
		softreset = ops->softreset;
		hardreset = ops->hardreset;
		postreset = ops->postreset;
	} else {
		prereset = ops->pmp_prereset;
		softreset = ops->pmp_softreset;
		hardreset = ops->pmp_hardreset;
		postreset = ops->pmp_postreset;
	}

	if (link->flags & ATA_LFLAG_NO_HRST)
		hardreset = NULL;

	...
}


(The if (link->flags & ATA_LFLAG_NO_HRST) statement is already there in
ata_eh_reset().)


> +
>  	ata_eh_autopsy(ap);
>  	ata_eh_report(ap);
>  
> -	rc = ata_eh_recover(ap, prereset, softreset, hardreset, postreset,
> -			    NULL);
> +	rc = ata_eh_recover(ap, ops->prereset, ops->softreset,
> +			    hardreset, ops->postreset, NULL);
>  	if (rc) {
> +		struct ata_device *dev;
> +
>  		ata_for_each_dev(dev, &ap->link, ALL)
>  			ata_dev_disable(dev);
>  	}
>  
>  	ata_eh_finish(ap);
>  }
> -
> -/**
> - *	ata_std_error_handler - standard error handler
> - *	@ap: host port to handle error for
> - *
> - *	Standard error handler
> - *
> - *	LOCKING:
> - *	Kernel thread context (may sleep).
> - */
> -void ata_std_error_handler(struct ata_port *ap)
> -{
> -	struct ata_port_operations *ops = ap->ops;
> -	ata_reset_fn_t hardreset = ops->hardreset;
> -
> -	/* ignore built-in hardreset if SCR access is not available */
> -	if (hardreset == sata_std_hardreset && !sata_scr_valid(&ap->link))
> -		hardreset = NULL;
> -
> -	ata_do_eh(ap, ops->prereset, ops->softreset, hardreset, ops->postreset);
> -}
>  EXPORT_SYMBOL_GPL(ata_std_error_handler);
>  
>  #ifdef CONFIG_PM
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 5a46c066abc3..e61f00779e40 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -2054,8 +2054,6 @@ EXPORT_SYMBOL_GPL(ata_sff_drain_fifo);
>   */
>  void ata_sff_error_handler(struct ata_port *ap)
>  {
> -	ata_reset_fn_t softreset = ap->ops->softreset;
> -	ata_reset_fn_t hardreset = ap->ops->hardreset;
>  	struct ata_queued_cmd *qc;
>  	unsigned long flags;
>  
> @@ -2077,13 +2075,7 @@ void ata_sff_error_handler(struct ata_port *ap)
>  
>  	spin_unlock_irqrestore(ap->lock, flags);
>  
> -	/* ignore built-in hardresets if SCR access is not available */
> -	if ((hardreset == sata_std_hardreset ||
> -	     hardreset == sata_sff_hardreset) && !sata_scr_valid(&ap->link))
> -		hardreset = NULL;
> -
> -	ata_do_eh(ap, ap->ops->prereset, softreset, hardreset,
> -		  ap->ops->postreset);
> +	ata_std_error_handler(ap);
>  }
>  EXPORT_SYMBOL_GPL(ata_sff_error_handler);
>  
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index d092747be588..0bfdec20496f 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1412,9 +1412,6 @@ extern void ata_eh_thaw_port(struct ata_port *ap);
>  extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
>  extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
>  
> -extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
> -		      ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
> -		      ata_postreset_fn_t postreset);
>  extern void ata_std_error_handler(struct ata_port *ap);
>  extern void ata_std_sched_eh(struct ata_port *ap);
>  extern void ata_std_end_eh(struct ata_port *ap);
> @@ -2152,6 +2149,14 @@ static inline u8 ata_wait_idle(struct ata_port *ap)
>  
>  	return status;
>  }
> +#else /* CONFIG_ATA_SFF */
> +

Looking at this file, we usually don't have newlines after #else,
so I would drop this newline.


> +static inline int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
> +				     unsigned long deadline)
> +{
> +	return -EOPNOTSUPP;
> +}
> +

Looking at this file, we usually don't have newlines before #endif,
so I would drop this newline.


>  #endif /* CONFIG_ATA_SFF */
>  
>  #endif /* __LINUX_LIBATA_H__ */
> -- 
> 2.50.0
> 
