Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931301465BB
	for <linux-ide@vger.kernel.org>; Thu, 11 Apr 2024 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833259; cv=none; b=fqcuSqqe6yXLGTYREqFnrQZvllMdPQlpopB2TfU4S2oI3PqSPJ/S/q+exgi5YU8zjqvpKZpStndPWjxl+dlNuismupPz9lUwFHMgOhm5z0Cc6nQrn+xCJHs/0mQ/Lw1yWYMAVTyi8JXS/iuslMTTHb7VnrCrjtgQD9xm5Ea55JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833259; c=relaxed/simple;
	bh=OLpOM3KthfyLG7vuby36SMhdg6FJpbw+CjKjWgwga2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd4rNdQqhAie9Mw0mwMbxxT3WA5xc/bfKMmVLCp2sjMvStnTYE47pj9ZfE71zKrO2mhQtoGPK7h0afsH9O9V2lsh3/CAK2XGixwb6xEiKkoKJbuysDjhwJyLJoGkIAHrnCk9+hJqGbc7AY0c+xPiPiwWivyrzFZUMJq2F6X85tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJW7xBEg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJW7xBEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF2EC433C7;
	Thu, 11 Apr 2024 11:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712833259;
	bh=OLpOM3KthfyLG7vuby36SMhdg6FJpbw+CjKjWgwga2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJW7xBEg74NcdUSzeE6jwo88tSIkew2oldFwP89Fw3sGZUbPlTnw4bTnIV6ZOp2Am
	 H8A1eB0IGb4Fs6nG7TSn0RkkRTti80DBM2F5DxS7YN1cvjA0P1sRqUwswTZ3yT0fao
	 nNNn2I9gb9TQIr2Me/5DF/6nxZGLLC4U2gc7yy0eMHUqeBdpK53LxPdA3z8cBQ1S6F
	 epsZd/L5lEukrFeHwPKAk4HCs7heno0G3ZPgR9IqzjaABYZO4U4kfaX2r/aWkIr6gL
	 rT7bmZHOE7q5mxHnVCh7HOp2FiKFjic/YnLJF9lEg47qpwOga6X8H/XvL9gQpo5M8K
	 F8MUGNw/7csdA==
Date: Thu, 11 Apr 2024 13:00:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Remove ata_exec_internal_sg()
Message-ID: <ZhfC5+R2wB3I2bwp@x1-carbon>
References: <20240411083158.723212-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411083158.723212-1-dlemoal@kernel.org>

On Thu, Apr 11, 2024 at 05:31:58PM +0900, Damien Le Moal wrote:
> ata_exec_internal() is the only caller of ata_exec_internal_sg() and
> always calls this function with a single element scattergather list.
> Remove ata_exec_internal_sg() and code it directly in
> ata_exec_internal(), simplifying a little the sgl handling for the
> command.
> 
> While at it, cleanup comments (capitalization) and change the variable
> auto_timeout type to a boolean.
> 
> No functional change.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-core.c | 105 ++++++++++++--------------------------
>  1 file changed, 34 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index be3412cdb22e..ec7e57a0f684 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1480,19 +1480,19 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
>  }
>  
>  /**
> - *	ata_exec_internal_sg - execute libata internal command
> + *	ata_exec_internal - execute libata internal command
>   *	@dev: Device to which the command is sent
>   *	@tf: Taskfile registers for the command and the result
>   *	@cdb: CDB for packet command
>   *	@dma_dir: Data transfer direction of the command
> - *	@sgl: sg list for the data buffer of the command
> - *	@n_elem: Number of sg entries
> + *	@buf: Data buffer of the command
> + *	@buflen: Length of data buffer
>   *	@timeout: Timeout in msecs (0 for default)
>   *
> - *	Executes libata internal command with timeout.  @tf contains
> - *	command on entry and result on return.  Timeout and error
> - *	conditions are reported via return value.  No recovery action
> - *	is taken after a command times out.  It's caller's duty to
> + *	Executes libata internal command with timeout. @tf contains
> + *	the command on entry and the result on return. Timeout and error
> + *	conditions are reported via the return value. No recovery action
> + *	is taken after a command times out. It is the caller's duty to
>   *	clean up after timeout.
>   *
>   *	LOCKING:
> @@ -1501,34 +1501,37 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
>   *	RETURNS:
>   *	Zero on success, AC_ERR_* mask on failure
>   */
> -static unsigned ata_exec_internal_sg(struct ata_device *dev,
> -				     struct ata_taskfile *tf, const u8 *cdb,
> -				     int dma_dir, struct scatterlist *sgl,
> -				     unsigned int n_elem, unsigned int timeout)
> +unsigned int ata_exec_internal(struct ata_device *dev,
> +			       struct ata_taskfile *tf, const u8 *cdb,
> +			       int dma_dir, void *buf, unsigned int buflen,
> +			       unsigned int timeout)
>  {
>  	struct ata_link *link = dev->link;
>  	struct ata_port *ap = link->ap;
>  	u8 command = tf->command;
> -	int auto_timeout = 0;
>  	struct ata_queued_cmd *qc;
>  	unsigned int preempted_tag;
>  	u32 preempted_sactive;
>  	u64 preempted_qc_active;
>  	int preempted_nr_active_links;
> +	bool auto_timeout = false;
>  	DECLARE_COMPLETION_ONSTACK(wait);
>  	unsigned long flags;
>  	unsigned int err_mask;
>  	int rc;
>  
> +	if (WARN_ON(dma_dir != DMA_NONE && !buf))
> +		return AC_ERR_INVALID;
> +
>  	spin_lock_irqsave(ap->lock, flags);
>  
> -	/* no internal command while frozen */
> +	/* No internal command while frozen */
>  	if (ata_port_is_frozen(ap)) {
>  		spin_unlock_irqrestore(ap->lock, flags);
>  		return AC_ERR_SYSTEM;
>  	}
>  
> -	/* initialize internal qc */
> +	/* Initialize internal qc */
>  	qc = __ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
>  
>  	qc->tag = ATA_TAG_INTERNAL;
> @@ -1547,12 +1550,12 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>  	ap->qc_active = 0;
>  	ap->nr_active_links = 0;
>  
> -	/* prepare & issue qc */
> +	/* Prepare and issue qc */
>  	qc->tf = *tf;
>  	if (cdb)
>  		memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);
>  
> -	/* some SATA bridges need us to indicate data xfer direction */
> +	/* Some SATA bridges need us to indicate data xfer direction */
>  	if (tf->protocol == ATAPI_PROT_DMA && (dev->flags & ATA_DFLAG_DMADIR) &&
>  	    dma_dir == DMA_FROM_DEVICE)
>  		qc->tf.feature |= ATAPI_DMADIR;
> @@ -1560,13 +1563,10 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>  	qc->flags |= ATA_QCFLAG_RESULT_TF;
>  	qc->dma_dir = dma_dir;
>  	if (dma_dir != DMA_NONE) {
> -		unsigned int i, buflen = 0;
> -		struct scatterlist *sg;
> +		struct scatterlist sgl;

Here you stack allocate a sgl, and save that stack allocated address
for sgl in in qc->sg (using ata_sg_init()), however, a stack allocated
variable is only valid until the scope ends.
(See my comment at the end of this email.)

So by having the stack allocated variable here (instead of at e.g. the
top of the function), when __ata_qc_complete() calls ata_sg_clean(),
or when ata_qc_issue() uses qc->sg, the value that they access might
be something else, since this variable has already went out of scope,
and some other variable might have been allocated at that stack address.


>  
> -		for_each_sg(sgl, sg, n_elem, i)
> -			buflen += sg->length;
> -
> -		ata_sg_init(qc, sgl, n_elem);
> +		sg_init_one(&sgl, buf, buflen);
> +		ata_sg_init(qc, &sgl, 1);
>  		qc->nbytes = buflen;
>  	}
>  
> @@ -1578,11 +1578,11 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>  	spin_unlock_irqrestore(ap->lock, flags);
>  
>  	if (!timeout) {
> -		if (ata_probe_timeout)
> +		if (ata_probe_timeout) {
>  			timeout = ata_probe_timeout * 1000;
> -		else {
> +		} else {
>  			timeout = ata_internal_cmd_timeout(dev, command);
> -			auto_timeout = 1;
> +			auto_timeout = true;
>  		}
>  	}
>  
> @@ -1597,28 +1597,29 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>  	if (!rc) {
>  		spin_lock_irqsave(ap->lock, flags);
>  
> -		/* We're racing with irq here.  If we lose, the
> -		 * following test prevents us from completing the qc
> -		 * twice.  If we win, the port is frozen and will be
> -		 * cleaned up by ->post_internal_cmd().
> +		/*
> +		 * We are racing with irq here. If we lose, the following test
> +		 * prevents us from completing the qc twice. If we win, the port
> +		 * is frozen and will be cleaned up by ->post_internal_cmd().
>  		 */
>  		if (qc->flags & ATA_QCFLAG_ACTIVE) {
>  			qc->err_mask |= AC_ERR_TIMEOUT;
>  
>  			ata_port_freeze(ap);
>  
> -			ata_dev_warn(dev, "qc timeout after %u msecs (cmd 0x%x)\n",
> +			ata_dev_warn(dev,
> +				     "qc timeout after %u msecs (cmd 0x%x)\n",
>  				     timeout, command);
>  		}
>  
>  		spin_unlock_irqrestore(ap->lock, flags);
>  	}
>  
> -	/* do post_internal_cmd */
> +	/* Do post_internal_cmd */
>  	if (ap->ops->post_internal_cmd)
>  		ap->ops->post_internal_cmd(qc);
>  
> -	/* perform minimal error analysis */
> +	/* Perform minimal error analysis */
>  	if (qc->flags & ATA_QCFLAG_EH) {
>  		if (qc->result_tf.status & (ATA_ERR | ATA_DF))
>  			qc->err_mask |= AC_ERR_DEV;
> @@ -1632,7 +1633,7 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>  		qc->result_tf.status |= ATA_SENSE;
>  	}
>  
> -	/* finish up */
> +	/* Finish up */
>  	spin_lock_irqsave(ap->lock, flags);
>  
>  	*tf = qc->result_tf;
> @@ -1652,44 +1653,6 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>  	return err_mask;
>  }
>  
> -/**
> - *	ata_exec_internal - execute libata internal command
> - *	@dev: Device to which the command is sent
> - *	@tf: Taskfile registers for the command and the result
> - *	@cdb: CDB for packet command
> - *	@dma_dir: Data transfer direction of the command
> - *	@buf: Data buffer of the command
> - *	@buflen: Length of data buffer
> - *	@timeout: Timeout in msecs (0 for default)
> - *
> - *	Wrapper around ata_exec_internal_sg() which takes simple
> - *	buffer instead of sg list.
> - *
> - *	LOCKING:
> - *	None.  Should be called with kernel context, might sleep.
> - *
> - *	RETURNS:
> - *	Zero on success, AC_ERR_* mask on failure
> - */
> -unsigned ata_exec_internal(struct ata_device *dev,
> -			   struct ata_taskfile *tf, const u8 *cdb,
> -			   int dma_dir, void *buf, unsigned int buflen,
> -			   unsigned int timeout)
> -{
> -	struct scatterlist *psg = NULL, sg;

So before you allocated a sg entry on the stack here,
which would be allocated until the end of the function.

So when ata_exec_internal_sg() calls ata_qc_issue(),
and the eventual __ata_qc_complete() comes, which can call
ata_sg_clean(), which uses the stack allocated address of sg
here, it would still be valid.


> -	unsigned int n_elem = 0;
> -
> -	if (dma_dir != DMA_NONE) {
> -		WARN_ON(!buf);
> -		sg_init_one(&sg, buf, buflen);
> -		psg = &sg;
> -		n_elem++;
> -	}
> -
> -	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, psg, n_elem,
> -				    timeout);
> -}
> -
>  /**
>   *	ata_pio_need_iordy	-	check if iordy needed
>   *	@adev: ATA device
> -- 
> 2.44.0
> 
