Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D8381C4;
	Mon,  1 Jul 2024 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868393; cv=none; b=luuu7+IOwmSTuFd6NSW3plPs4zrJTv8FsGLUb7MhrJm0Sbh7xcfO4/xUunREOWOuwM+e7wPR/wO1TIUak0qLn7byYJPc2FDFJo3p7Hk8IYWVWMUeyymZdfAVFMm+Jok8I23wNT+yPpWgsEIrxfNwkPxl+9BEFYJ3nd305qNU63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868393; c=relaxed/simple;
	bh=DLNmXQ5S21rdL4mdHO5o9Zo3GS3llGMHk1uCtXa78XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5lNZ45ivBAAy4AQtzXU60pHzH2mJ12z1rKRY/xpU/io7B4o4KiNXBhqO5Qh503TVrpvlomVXMM3KqRgvpDlPBvdCaoOCFViZ6UGYt0wKCMJ46NEq8/MQxaVKM7vETaMEC7IxSauy5tFtth3/7v2aB3WiyjS0U1yaRrXYjYup2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nwy57nGu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nwy57nGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C63C116B1;
	Mon,  1 Jul 2024 21:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719868393;
	bh=DLNmXQ5S21rdL4mdHO5o9Zo3GS3llGMHk1uCtXa78XY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nwy57nGutYMvS+TOuv/pTNSxTZDtBbO0GT2dXaJ7+Y96odeNermyTECCfnHoUtnQu
	 Xa9cfVTtCqMPpi7mPJ29yGKDT/YVzz0IIA63uDOZyvKw4+HzfwGlvh1ecIc83tDB09
	 w41trn6ou5kLB7yVqD9ozVTo9ul6X+ms9nQw0p1Mn/HxDen6S0Wa1qvom0gj4tzwvV
	 wx3lmE7i40s8OIqMyW7jESXyfAtuajuhtPCtu2dttB/Zafh2xibOdD0172ZYBBGNg9
	 vH2u9OJnyPeM8zzoOmnX1qbqs/O5XQ7R3OkRIKEhRCQAwFcPXrpqLZwNt7MIXUOJRM
	 QSr/5OjYdVUhQ==
Date: Mon, 1 Jul 2024 23:13:08 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/8] ata: libata-core: Set ATA_QCFLAG_RTF_FILLED in
 fill_result_tf()
Message-ID: <ZoMb5HjHFxcfFJdD@ryzen.lan>
References: <20240701195758.1045917-1-ipylypiv@google.com>
 <20240701195758.1045917-7-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701195758.1045917-7-ipylypiv@google.com>

On Mon, Jul 01, 2024 at 07:57:56PM +0000, Igor Pylypiv wrote:
> ATA_QCFLAG_RTF_FILLED is not specific to ahci and can be used generally
> to check if qc->result_tf contains valid data.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libahci.c     | 12 ++----------
>  drivers/ata/libata-core.c |  8 ++++++++
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 83431aae74d8..fdfa7b266218 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2075,13 +2075,6 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
>  	struct ahci_port_priv *pp = qc->ap->private_data;
>  	u8 *rx_fis = pp->rx_fis;
>  
> -	/*
> -	 * rtf may already be filled (e.g. for successful NCQ commands).
> -	 * If that is the case, we have nothing to do.
> -	 */
> -	if (qc->flags & ATA_QCFLAG_RTF_FILLED)
> -		return;
> -
>  	if (pp->fbs_enabled)
>  		rx_fis += qc->dev->link->pmp * AHCI_RX_FIS_SZ;
>  
> @@ -2095,7 +2088,6 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
>  	    !(qc->flags & ATA_QCFLAG_EH)) {
>  		ata_tf_from_fis(rx_fis + RX_FIS_PIO_SETUP, &qc->result_tf);
>  		qc->result_tf.status = (rx_fis + RX_FIS_PIO_SETUP)[15];
> -		qc->flags |= ATA_QCFLAG_RTF_FILLED;
>  		return;
>  	}
>  
> @@ -2118,12 +2110,10 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
>  		 */
>  		qc->result_tf.status = fis[2];
>  		qc->result_tf.error = fis[3];
> -		qc->flags |= ATA_QCFLAG_RTF_FILLED;
>  		return;
>  	}
>  
>  	ata_tf_from_fis(rx_fis + RX_FIS_D2H_REG, &qc->result_tf);
> -	qc->flags |= ATA_QCFLAG_RTF_FILLED;
>  }
>  
>  static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
> @@ -2158,6 +2148,7 @@ static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
>  			if (qc && ata_is_ncq(qc->tf.protocol)) {
>  				qc->result_tf.status = status;
>  				qc->result_tf.error = error;
> +				qc->result_tf.flags = qc->tf.flags;
>  				qc->flags |= ATA_QCFLAG_RTF_FILLED;
>  			}
>  			done_mask &= ~(1ULL << tag);
> @@ -2182,6 +2173,7 @@ static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
>  			fis += RX_FIS_SDB;
>  			qc->result_tf.status = fis[2];
>  			qc->result_tf.error = fis[3];
> +			qc->result_tf.flags = qc->tf.flags;
>  			qc->flags |= ATA_QCFLAG_RTF_FILLED;
>  		}
>  		done_mask &= ~(1ULL << tag);
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 74b59b78d278..949662bc50e4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4800,8 +4800,16 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
>  {
>  	struct ata_port *ap = qc->ap;
>  
> +	/*
> +	 * rtf may already be filled (e.g. for successful NCQ commands).
> +	 * If that is the case, we have nothing to do.
> +	 */
> +	if (qc->flags & ATA_QCFLAG_RTF_FILLED)
> +		return;
> +
>  	qc->result_tf.flags = qc->tf.flags;
>  	ap->ops->qc_fill_rtf(qc);
> +	qc->flags |= ATA_QCFLAG_RTF_FILLED;
>  }
>  
>  static void ata_verify_xfer(struct ata_queued_cmd *qc)
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
