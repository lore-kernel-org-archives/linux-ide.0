Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D21946C6;
	Mon, 17 Jun 2024 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621392; cv=none; b=GXrcOAHovYqmQv/z3njS6rA8WQFi97nZA+lrsBxFDZMJV8VfsBnYwgpElAzN/R5A7c1lJobIZJDqNpvOSo1q/bLmD/byl8eKZAwKRSrASTyeTyF7Ex1orU2KtY/d2TR99k5vAS1T6jTMezFLyx5z9FLhHVxh0+toRmTlOdlXIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621392; c=relaxed/simple;
	bh=a6YoxnKL1CWw5PUUrVcCqwtW5thmWAEkDVBS1cGdVVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxDl79gZvGCvxqUE0QokIEcXyMe1FAb5G40xdr72VSEBOWJC1zg5hJ6nt5WU0WjFIwy6djL3TrlS1LCrLmGRiTkSc//5TDGWTk8c/6+SjoiaJjPHdCzN6uaZ9WG262a3L0qMNwjgm4c6EHqVLr3zV61A1pqBmjjLeR6z3JZJuRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFpjbsFp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFpjbsFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8ADC2BD10;
	Mon, 17 Jun 2024 10:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718621391;
	bh=a6YoxnKL1CWw5PUUrVcCqwtW5thmWAEkDVBS1cGdVVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFpjbsFpgGuubiLET71nx7yc5YcY1Q6euKyffum5zOBNSSSwJdWZ0eBNKDv7rgLqq
	 opnyTHXCdjtGoLof9/OIIdwQfKbSIlM/l3L6VMCdbuyE2jWN8UGJVqU0XoFXx+ErEI
	 IbJ2ZuHnW7Q4Q7laFZnDO7nFKYlp1oXZ0imkuSw2lAKcw7y4sXULstKazUozJaC/xr
	 7JIwvzjkIOewfGPqoVA+0leHle8/a4as8iCIUDy47tf6t3mRiKchYmXL7wycMEunBn
	 wn2U4gLqy9CkPBDPv0qX/XP3GbWddow7xCBaaIz1HaBSWBRF7JeUTy2/ZmMz4u5j2A
	 2Wb+7M0CAMekQ==
Date: Mon, 17 Jun 2024 12:49:47 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] ata: libata-scsi: Report valid sense data for ATA
 PT if present
Message-ID: <ZnAUy5C-DXEuliSm@ryzen.lan>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-4-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614191835.3056153-4-ipylypiv@google.com>

On Fri, Jun 14, 2024 at 07:18:34PM +0000, Igor Pylypiv wrote:
> Do not generate sense data from ATA status/error registers
> if valid sense data is already present.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-scsi.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 79e8103ef3a9..4bfe47e7d266 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -858,12 +858,17 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  	unsigned char *desc = sb + 8;
>  	u8 sense_key, asc, ascq;

Like I suggested in the earlier patch,

can't you do a:

if (qc->flags & ATA_QCFLAG_SENSE_VALID)
	return;

here instead?


>  
> -	/*
> -	 * Use ata_to_sense_error() to map status register bits
> -	 * onto sense key, asc & ascq.
> -	 */
> -	if (qc->err_mask ||
> -	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> +	if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
> +		/*
> +		 * Do not generate sense data from ATA status/error
> +		 * registers if valid sense data is already present.
> +		 */
> +	} else if (qc->err_mask ||
> +		   tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> +		/*
> +		 * Use ata_to_sense_error() to map status register bits
> +		 * onto sense key, asc & ascq.
> +		 */
>  		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
>  				   &sense_key, &asc, &ascq);
>  		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
> -- 
> 2.45.2.627.g7a2c4fd464-goog
> 
