Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B30F381C4;
	Mon,  1 Jul 2024 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868406; cv=none; b=JoH+Cz8/HmBDXUbpwpMjGqbJYb2BBX4At3kpjpIkTqw662YycDXHiPJ9YNfu0wogkeuNrr0SiSH/1pz9tbjN5fFSsN549vwR+32zlHDueioBT1hiI/3LqxcoLYcvyyKh6nBFcnIB+nRL9awm6bC2CGNuasCtCs0xdeBzAG1K1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868406; c=relaxed/simple;
	bh=DR0BUNh5E0mYtyLO0u9vCDIRCz8SdtVEtfWJIMBdNZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQ2SK4TbjevKqXHo5HnWnQVWKyaL22h8BoXSM5WaU7XY7kJlL/rWsOrD0/Gv/Rphe6wcNGh3fJJNbupeIi7d+v5NcX2PAwdAbI5WAr5B2/1YlcZoGhGjNETrCOE3JWVnP1GOl6+cMTDRf0273rOiLx0E8KUXF1D8GT9ZwOnY5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpZRR3vK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpZRR3vK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BF1C116B1;
	Mon,  1 Jul 2024 21:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719868406;
	bh=DR0BUNh5E0mYtyLO0u9vCDIRCz8SdtVEtfWJIMBdNZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CpZRR3vKoyr61KJ/c0TVUIIkwkXpHGr40PLZ3c9KrD1j7BHlZREQ4P031SKaCCEYD
	 2+PSJQvdBx1Ab4hfPZsfQA5AdOrhehlWUchIF2vOnBBDDn9gfeKoaKvCWrPGrXyr/Q
	 hiwRCpb0G5IrGs27faRF4vJXAi6yY56rEWd4bsTVHtOh+FVPQJcgi8YGCvQHu8g0z0
	 09L++1Sg5q5N8QZpOE90UgCAr4J7Lsog7qAPhqXZ53z2BmsRPmWqgWaeGCkJpSMYJw
	 mR/xAoCg2bfwXhQWYNvHJbuBXwEJvrh68u/LXRbH61souG8+gGccrm0fnPKfkpapZC
	 QxMEAKEZPobVg==
Date: Mon, 1 Jul 2024 23:13:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/8] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED
 before using result_tf
Message-ID: <ZoMb8WjhH1c2e5R5@ryzen.lan>
References: <20240701195758.1045917-1-ipylypiv@google.com>
 <20240701195758.1045917-8-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701195758.1045917-8-ipylypiv@google.com>

On Mon, Jul 01, 2024 at 07:57:57PM +0000, Igor Pylypiv wrote:
> qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
> is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
> that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-scsi.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 92d75780fc3b..a66c177b6087 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -242,10 +242,17 @@ void ata_scsi_set_sense_information(struct ata_device *dev,
>   */
>  static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
>  {
> +	struct ata_device *dev = qc->dev;
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  	struct ata_taskfile *tf = &qc->result_tf;
>  	unsigned char *sb = cmd->sense_buffer;
>  
> +	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> +		ata_dev_dbg(dev,
> +			    "missing result TF: can't set ATA PT sense fields\n");
> +		return;
> +	}
> +
>  	if ((sb[0] & 0x7f) >= 0x72) {
>  		unsigned char *desc;
>  		u8 len;
> @@ -923,10 +930,17 @@ static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
>   */
>  static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  {
> +	struct ata_device *dev = qc->dev;
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  	struct ata_taskfile *tf = &qc->result_tf;
>  	u8 sense_key, asc, ascq;
>  
> +	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> +		ata_dev_dbg(dev,
> +			    "missing result TF: can't generate ATA PT sense data\n");
> +		return;
> +	}
> +
>  	/*
>  	 * Use ata_to_sense_error() to map status register bits
>  	 * onto sense key, asc & ascq.
> @@ -967,6 +981,13 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
>  		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
>  		return;
>  	}
> +
> +	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> +		ata_dev_dbg(dev,
> +			    "missing result TF: can't generate sense data\n");
> +		return;
> +	}
> +
>  	/* Use ata_to_sense_error() to map status register bits
>  	 * onto sense key, asc & ascq.
>  	 */
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
