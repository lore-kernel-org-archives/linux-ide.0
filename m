Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D9156444;
	Fri, 28 Jun 2024 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603778; cv=none; b=QJ1xuYxdXK218SIWn6s3GiYy6KFsX8DdEhegBxMH9amOXNGe0q6pfb9aKV1Kfqx6p541qEy/A83CP3SyJmLQzvimAVCmq6n1cDeDwN4uihnharAQ3I+lRhXtuEUfeSygOVkDfcH9o2DwhYM2ohu/1/66SLxU8N47BHt0o8EHbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603778; c=relaxed/simple;
	bh=azzMXAYWdML81bvBEeMLV/S4wFPRaOArS+pvGUlUIL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fc/VgJsPwuEVj1Xo9KnrMe1Hga3o2DeGvSRiSK6INGIOSmX1ECuLJNU5xugV6mD4Nb3IDGhh1KSQECvUbPOeMXeXimDrfQuhrodJzBNICR+bjMkyRGlgUNV2pEuK5PaXkO1sMqqXeRnliX8FIdW9c+R057xwRV5EfLm9+jUvDpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0Dtfvbo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0Dtfvbo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5221C116B1;
	Fri, 28 Jun 2024 19:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719603778;
	bh=azzMXAYWdML81bvBEeMLV/S4wFPRaOArS+pvGUlUIL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0DtfvboT9qXDQsxvgCjCzxwqtlQOmR6ntEJFj1Vnd1cJ9DV77yWK+ektlrZ3WELy
	 rjzg7+5boW1xf0K06TadxfCWlpoWyxn/4gm0k2h26+EI0AnRDjMFH5m6tsns0I54nM
	 eAS6bS8BXbgmKy6nmtU0NKIRo37nxLHPm/MO3w7EluGAOy9hNmHUUzKKJby8WEX2tT
	 GiMf1IzjSOi9Z9B6qLqN348DviFeN2SJ4LiOchoO13YIVSP5V/+oqZHp8qE2pjBfTH
	 5h8G9v68S8JHx93XIO+w6H5Fipkzq0W0SxyKZ++T+gRwlpLDh3oIex4PJPpaFiM+jM
	 q5COyddYjdxEQ==
Date: Fri, 28 Jun 2024 21:42:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED
 before using result_tf
Message-ID: <Zn8SPZG4y4wvSH-g@ryzen.lan>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-7-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626230411.3471543-7-ipylypiv@google.com>

On Wed, Jun 26, 2024 at 11:04:11PM +0000, Igor Pylypiv wrote:
> qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
> is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
> that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-scsi.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 02af4d5d5799..d5874d4b9253 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -242,10 +242,16 @@ void ata_scsi_set_sense_information(struct ata_device *dev,
>   */
>  static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
>  {
> +	struct ata_device *dev = qc->dev;
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  	struct ata_taskfile *tf = &qc->result_tf;
>  	unsigned char *sb = cmd->sense_buffer;
>  
> +	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> +		ata_dev_dbg(dev, "Missing RTF: cannot set ATA PT sense fields.\n");
> +		return;
> +	}
> +
>  	if ((sb[0] & 0x7f) >= 0x72) {
>  		unsigned char *desc;
>  		u8 len;
> @@ -923,10 +929,16 @@ static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
>   */
>  static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  {
> +	struct ata_device *dev = qc->dev;
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  	struct ata_taskfile *tf = &qc->result_tf;
>  	u8 sense_key, asc, ascq;
>  
> +	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> +		ata_dev_dbg(dev, "Missing RTF: cannot generate ATA PT sense data.\n");
> +		return;
> +	}
> +
>  	/*
>  	 * Use ata_to_sense_error() to map status register bits
>  	 * onto sense key, asc & ascq.
> @@ -970,6 +982,12 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
>  		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
>  		return;
>  	}
> +
> +	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> +		ata_dev_dbg(dev, "Missing RTF: cannot generate sense data.\n");
> +		return;
> +	}
> +
>  	/* Use ata_to_sense_error() to map status register bits
>  	 * onto sense key, asc & ascq.
>  	 */
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

In order to be more consistent with existing prints in this file,
please do not capitalize the first letter, and remove the punctuation.


Kind regards,
Niklas
