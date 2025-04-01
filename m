Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595BF4ED;
	Tue,  1 Apr 2025 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743492838; cv=none; b=hQIVxraIqo6jL1q8erLyXAiwxkDu7AACrrTVIBljns3CvYyb8skE/3aZ8VQSKChv2rKCwt1kHhlBTDbA1S0SyLI8yd+S4nAC7it7sA2bSxDN9f4Mt+0B+6ASmeznSznQzTnidAASFbiheL8BL2eQdW9/5J5/A29O/oLG+9qfUEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743492838; c=relaxed/simple;
	bh=9fUSX84AGTQwcS8mWrhm9T8v7ECk8LOkABdcYYwyGOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZRSPvMnLBoh5hdsIQDH+8FMSL5KYPJly3rJ29dsHN5rfpgxhPTk0zM9EFzSQXw8XkEk9OmpDvjgX3+plbkNHZEbpcokhC96QtVFbfbprbgRrSkRTJ9Crpr4p99vCaLljzaocSHohROXmvssmnvPVAjnLcit/s6VXuGJlulr21U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FawODzXY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FawODzXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D34C4CEE8;
	Tue,  1 Apr 2025 07:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743492836;
	bh=9fUSX84AGTQwcS8mWrhm9T8v7ECk8LOkABdcYYwyGOs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FawODzXYTMWU4tidl5y+TsTAlyiI2AKo+n58vHlgYAwJ+uGXZpaH2hOMsqCLA2SQc
	 1qY/Me+zqIEwYwFng50JQqDAr8f8SzDUl279pTrGqNny+XaTvj1lAMZ/i7Uep1061b
	 0mxRfKl6bTjitBh+895fngPQ891yHIO1OWuQC1rEs0C82MW+BtdkwPJlieUhySBdaU
	 axIR37GP0UNBhmVm7uNm0sGKc6UvCFG8LlekIzz7YzGrqBskraN2lQiGIycN932aGf
	 H20JCdhSh9xBGqQW1fdRA5kmGHojsfVoiVdZMVxhO67CnMYn5dOzBmPp+2Ttu4GUXz
	 H2FuMjscl+K/A==
Message-ID: <93ec66ce-4fa3-4913-a0b5-9debe47ef8b0@kernel.org>
Date: Tue, 1 Apr 2025 16:33:55 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: Set INFORMATION sense data field
 consistently
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250328183047.2132370-1-ipylypiv@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250328183047.2132370-1-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/25 03:30, Igor Pylypiv wrote:
> Populate the INFORMATION field with ATA LBA when sense data is obtained
> by the ata_eh_request_sense(). Kernel already populates the INFORMATION

s/by the/with
s/Kernel/The kernel or s/Kernel/libata-eh

> field when sense data is reported via autosense or when it is generated
> by the ata_gen_ata_sense().
> 
> ATA PASS-THROUGH commands, unlike regular ATA commands, populate
> the INFORMATION field with ATA ERROR, STATUS, DEVICE, and COUNT(7:0)
> fields thus setting ATA LBA into the INFORMATION field is incorrect.

Could you rephrase all of this is a manner that is clearer ? That is, describe
the problem first and then how you fix it. As-is, this is hard to understand.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 2796c0da8257..7e93581439b2 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -216,17 +216,30 @@ void ata_scsi_set_sense(struct ata_device *dev, struct scsi_cmnd *cmd,
>  	scsi_build_sense(cmd, d_sense, sk, asc, ascq);
>  }
>  
> -void ata_scsi_set_sense_information(struct ata_device *dev,
> -				    struct scsi_cmnd *cmd,
> -				    const struct ata_taskfile *tf)
> +/**
> + *	ata_scsi_set_sense_information - Populate INFORMATION field
> + *	@qc: ATA command
> + *
> + *	Populates the INFORMATION field with ATA LBA.
> + *
> + *	LOCKING:
> + *	None.
> + */

The function name is clear enough. We do not need this kdoc block to clarify it
and this is a static function anyway.

> +static void ata_scsi_set_sense_information(struct ata_queued_cmd *qc)
>  {
>  	u64 information;
>  
> -	information = ata_tf_read_block(tf, dev);
> +	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> +		ata_dev_dbg(qc->dev,
> +			    "missing result TF: can't set INFORMATION sense field\n");

Why ata_dev_dbg() ? This should be ata_dev_err(), no ? With your change, this is
not supposed to be called without the rtf filled...

> +		return;
> +	}
> +
> +	information = ata_tf_read_block(&qc->result_tf, qc->dev);
>  	if (information == U64_MAX)
>  		return;
>  
> -	scsi_set_sense_information(cmd->sense_buffer,
> +	scsi_set_sense_information(qc->scsicmd->sense_buffer,
>  				   SCSI_SENSE_BUFFERSIZE, information);
>  }
>  
> @@ -971,8 +984,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>   *	ata_gen_ata_sense - generate a SCSI fixed sense block
>   *	@qc: Command that we are erroring out
>   *
> - *	Generate sense block for a failed ATA command @qc.  Descriptor
> - *	format is used to accommodate LBA48 block address.
> + *	Generate sense block for a failed ATA command @qc.
>   *
>   *	LOCKING:
>   *	None.
> @@ -982,8 +994,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
>  	struct ata_device *dev = qc->dev;
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  	struct ata_taskfile *tf = &qc->result_tf;
> -	unsigned char *sb = cmd->sense_buffer;
> -	u64 block;
>  	u8 sense_key, asc, ascq;
>  
>  	if (ata_dev_disabled(dev)) {
> @@ -1014,12 +1024,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
>  		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
>  		return;
>  	}
> -
> -	block = ata_tf_read_block(&qc->result_tf, dev);
> -	if (block == U64_MAX)
> -		return;
> -
> -	scsi_set_sense_information(sb, SCSI_SENSE_BUFFERSIZE, block);
>  }
>  
>  void ata_scsi_sdev_config(struct scsi_device *sdev)
> @@ -1679,8 +1683,10 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  		ata_scsi_set_passthru_sense_fields(qc);
>  		if (is_ck_cond_request)
>  			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
> -	} else if (is_error && !have_sense) {
> -		ata_gen_ata_sense(qc);
> +	} else if (is_error) {
> +		if (!have_sense)
> +			ata_gen_ata_sense(qc);
> +		ata_scsi_set_sense_information(qc);
>  	}
>  
>  	ata_qc_done(qc);
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 0337be4faec7..ce5c628fa6fd 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -141,9 +141,6 @@ extern int ata_scsi_offline_dev(struct ata_device *dev);
>  extern bool ata_scsi_sense_is_valid(u8 sk, u8 asc, u8 ascq);
>  extern void ata_scsi_set_sense(struct ata_device *dev,
>  			       struct scsi_cmnd *cmd, u8 sk, u8 asc, u8 ascq);
> -extern void ata_scsi_set_sense_information(struct ata_device *dev,
> -					   struct scsi_cmnd *cmd,
> -					   const struct ata_taskfile *tf);
>  extern void ata_scsi_media_change_notify(struct ata_device *dev);
>  extern void ata_scsi_hotplug(struct work_struct *work);
>  extern void ata_scsi_dev_rescan(struct work_struct *work);


-- 
Damien Le Moal
Western Digital Research
