Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B7D2BB05;
	Mon,  1 Jul 2024 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868559; cv=none; b=qapSCDUJvMZLEYdqjZblrZ9Qk+cKN9nXEmwu+lEK9nYSwPkg2Hca+xuV0oUiZ7bm23YXQiG7qiimpUr5DpwxhDehcgdOJhg1ZPZRO8L5JGoetl6BiE6H25STtPsA6LNq7dT3WxJLTTkZ7528CIc4MdHrMswRZVpAN1CISRFdBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868559; c=relaxed/simple;
	bh=h1IhBGf8UYCEd0sZEKyQ+4tiVcw/QbYUeV4K7LDSHzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPA2VFgoO+l6XWQpXgtAS6XOH03WMNQXDyTciVEq/aK8LQ6fSjfB/p/iNYMqiaxEKiqlRNwLD10spmcDy4oJFzgydlLxqdax/Uq5YHMbPgMjl4dVrI9MUk61WJNPbPLYCXA7JE2QyQYlFotbhOfznt3djWxOAQLq1yApdbaxKz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMw+brKj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMw+brKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C64BC116B1;
	Mon,  1 Jul 2024 21:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719868559;
	bh=h1IhBGf8UYCEd0sZEKyQ+4tiVcw/QbYUeV4K7LDSHzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMw+brKjO98pABwU982xNOMBmiqGSdKy2CJmPzvbgbpa1jIahQ5wmPui4VJ2RRw/9
	 Nq7b31vyPZnLr/bReN6Oz+E4c1DHMrnJ8pXAKWKPcacIUQlz2Sh1G7Tt6GuuOemC7K
	 WcrHSxX7AFemJrFMs6+SiC8PdwJlUNEf89cSUr0bYt1bwz1IWii4Q0yBA/p2Bd9M4B
	 RJputxI/JwMRTgxa7GYIgNC08WfS3hQpY0AMmZrvRExq0XgDXhtMcFoVOetCD757tW
	 uG9of8iar7ddlfzzC3mNVtj9bdM/C4W5Z3AqUobzMm/Xzyizk2+Ha0Ltz1sc6ksYPx
	 /Y0uiJV0uN5Fw==
Date: Mon, 1 Jul 2024 23:15:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] ata: libata-scsi: Make ata_scsi_qc_complete()
 more readable
Message-ID: <ZoMciql1lQcj5MbM@ryzen.lan>
References: <20240701195758.1045917-1-ipylypiv@google.com>
 <20240701195758.1045917-9-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701195758.1045917-9-ipylypiv@google.com>

On Mon, Jul 01, 2024 at 07:57:58PM +0000, Igor Pylypiv wrote:
> The ATA PASS-THROUGH handling logic in ata_scsi_qc_complete() is hard
> to read/understand. Improve the readability of the code by moving checks
> into self-explanatory boolean variables.
> 
> Additionally, always set SAM_STAT_CHECK_CONDITION when CK_COND=1 because
> SAT specification mandates that SATL shall return CHECK CONDITION if
> the CK_COND bit is set.
> 
> Co-developed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-scsi.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a66c177b6087..8f21b3b0bc75 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1659,26 +1659,27 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  {
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  	u8 *cdb = cmd->cmnd;
> -	int need_sense = (qc->err_mask != 0) &&
> -		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
> -	int need_passthru_sense = (qc->err_mask != 0) ||
> -		(qc->flags & ATA_QCFLAG_SENSE_VALID);
> +	bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
> +	bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12;
> +	bool is_ck_cond_request = cdb[2] & 0x20;
> +	bool is_error = qc->err_mask != 0;
>  
>  	/* For ATA pass thru (SAT) commands, generate a sense block if
>  	 * user mandated it or if there's an error.  Note that if we
> -	 * generate because the user forced us to [CK_COND =1], a check
> +	 * generate because the user forced us to [CK_COND=1], a check
>  	 * condition is generated and the ATA register values are returned
>  	 * whether the command completed successfully or not. If there
> -	 * was no error, we use the following sense data:
> +	 * was no error, and CK_COND=1, we use the following sense data:
>  	 * sk = RECOVERED ERROR
>  	 * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
>  	 */
> -	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
> -	    ((cdb[2] & 0x20) || need_passthru_sense)) {
> -		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
> +	if (is_ata_passthru && (is_ck_cond_request || is_error || have_sense)) {
> +		if (!have_sense)
>  			ata_gen_passthru_sense(qc);
>  		ata_scsi_set_passthru_sense_fields(qc);
> -	} else if (need_sense) {
> +		if (is_ck_cond_request)
> +			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
> +	} else if (is_error && !have_sense) {
>  		ata_gen_ata_sense(qc);
>  	} else {
>  		/* Keep the SCSI ML and status byte, clear host byte. */
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

However: I really think that this patch should be squashed with patch 2/8.

Sure, the changes in this patch will make it harder to backport...
but, even patch 2/8 will be a pain to backport...

And this patch will need to have CC: stable and be backported as well...
(such that we always set CHECK_CONDITION when CK_COND=1), so I strongly
suggest that we should squash these, since it will probably be way simpler
to backport the patch that is "patch 2/8 squashed with this patch",
compared to backporting patch 2/8, and then backporting this patch.
(That would just give two patches that will need manual backport, rather
than one patch that needs manual backport.)

Both of these are fixing incorrect sense data for ATA passthough commands
anyway.


Kind regards,
Niklas
