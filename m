Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F9381C4;
	Mon,  1 Jul 2024 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868380; cv=none; b=ND0RbOAHpREGLdQ+Ow73/HKt3pXnS51Mm7alky+mb88s7wFTVaW0OjH/VYdfnSraNhZafEWCS0M1YLecZbT3u9qSQ9/r/6ufXguzps9mcPQY3LW5Pwc16agWUJbqO+E7JkJrN3QrW07Uyh+EEX4kb1gXWcbSmxsWC/US/EI5Tz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868380; c=relaxed/simple;
	bh=s9D/bbCBqH2D007MYFrkp/LZUjG7brUXh/t3L+vvGvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCxyxI6zOx5sdCsXZIwi8LF2RVgJsYzVuClBKB53By5k/Po/5yzGtY78VU7V306lL6de4XlRPRHH0XS4ZT5wrY+XxEWqdl4/m+wyC3EbfzumtBF9TCgMYBuMhuT6OK6646lBXQH2miLu45JdPJBiY5nWkeMTDmhkmifzgDIRKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuhpYtlQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuhpYtlQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C193AC116B1;
	Mon,  1 Jul 2024 21:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719868380;
	bh=s9D/bbCBqH2D007MYFrkp/LZUjG7brUXh/t3L+vvGvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuhpYtlQYl1j44wHgBFTlwK2fXdKte5pGmJAXbloGgGLQCy+J1KOyDGB/XdNKOJNS
	 i2AVuHl8lOic8LBwhoyJDSVv1DqJiDxBEtkNE6G4rBc9mulKDIlIi3qnqrWusTuXIf
	 2jrE7PCOBTp+b8gEgKx39bcgU1aea6d5SNudjOQhNgppkKze155f/iRLSy6v9SMGQN
	 LbGjBfumt+zeGS4PnOnJi49a0ZNyuXwlrzGtjXDiaAVotVjMwdhcIPScg82cTD/MTC
	 fYyYakycvosrFcRBphsrbRZea9GFLGBfq7hd0XN+XAvrIiZNt0F7u6eh+skpBZYhiP
	 a8pqmVoFYgJ+A==
Date: Mon, 1 Jul 2024 23:12:56 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] ata: libata-scsi: Do not pass ATA device id to
 ata_to_sense_error()
Message-ID: <ZoMb2MaDZKJndm0a@ryzen.lan>
References: <20240701195758.1045917-1-ipylypiv@google.com>
 <20240701195758.1045917-6-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701195758.1045917-6-ipylypiv@google.com>

On Mon, Jul 01, 2024 at 07:57:55PM +0000, Igor Pylypiv wrote:
> ATA device id is not used in ata_to_sense_error().
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-scsi.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index c11ae77d3ca6..92d75780fc3b 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -785,7 +785,6 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
>  
>  /**
>   *	ata_to_sense_error - convert ATA error to SCSI error
> - *	@id: ATA device number
>   *	@drv_stat: value contained in ATA status register
>   *	@drv_err: value contained in ATA error register
>   *	@sk: the sense key we'll fill out
> @@ -799,8 +798,8 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
>   *	LOCKING:
>   *	spin_lock_irqsave(host lock)
>   */
> -static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
> -			       u8 *asc, u8 *ascq)
> +static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
> +			       u8 *ascq)
>  {
>  	int i;
>  
> @@ -934,7 +933,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  	 */
>  	if (qc->err_mask ||
>  	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> -		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
> +		ata_to_sense_error(tf->status, tf->error,
>  				   &sense_key, &asc, &ascq);
>  		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
>  	} else {
> @@ -973,7 +972,7 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
>  	 */
>  	if (qc->err_mask ||
>  	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> -		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
> +		ata_to_sense_error(tf->status, tf->error,
>  				   &sense_key, &asc, &ascq);
>  		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
>  	} else {
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
