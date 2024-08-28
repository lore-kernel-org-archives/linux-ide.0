Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C70E43AA9
	for <linux-ide@vger.kernel.org>; Wed, 28 Aug 2024 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724808702; cv=none; b=N+v77CJPytgqRH7k9unsbCr/D/HwA05zjFoMmd4iRi94r376LtbGEKQXNvOLf8CDjqf/3jgYNG/M37qfIEud3+X3Vv2DHp3pSufd31Ab2APzCRlIsYnqV6l2n6jE5ISPTgE+OdY+12q7yxSMfCS6qfdKw7CyMqN6KjdkBDA69n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724808702; c=relaxed/simple;
	bh=1LiVqFuWVPL1rnc06E7BPDV60ttARWjor/lnQKvwAoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtpOTBBOegZuTyeJMUM1SzoeCLkX3wZCMJzshEZ/WZ27vTeFo6JvXr0M5eKC7r0QISqKIKClm8AosIwBunGlmz6cLla95hXcu9FVprlArK/UzK2qVerLDHYIGx/2p6DJi0iEEjeclUMoR8wlT+E1QbENWamlSuYy7UNhHW+4XTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FStBqlAW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FStBqlAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1750EC32782;
	Wed, 28 Aug 2024 01:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724808701;
	bh=1LiVqFuWVPL1rnc06E7BPDV60ttARWjor/lnQKvwAoU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FStBqlAWB3jnAZy5zee5W/nAJNh9RZ27woUDky0lRkYPRi3bxdaT5vheX+lyfhXNj
	 ejUW2zvPHmrF5YfV4L5aJ9ufG+yLp3yBO6hTZ4gbJdkFzn/1waFnwGsvEVPoO9SfOg
	 kvrXbmNakVMLd+L7rXiEY2cigReTAOORFyQlO8iN3ok5Ez6/hqYZ5wrNgmgammai/e
	 pclWINCtCBsgZraCRZAX2pDkr6y2UUMI8Y/J2EWFGKVgFkv7t6Y6+YicHzk7l+sP8j
	 PKoZpX3KeFXhOZmsZGHrpfEaObHHZHS5slnMP1yl82/oEd0jOGtXxOJmqskqbBXje7
	 JvsmB4AgL8n8w==
Message-ID: <139417e1-b01e-4549-9cfe-b417edb0b678@kernel.org>
Date: Wed, 28 Aug 2024 10:31:39 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: Add helper ata_eh_decide_disposition()
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20240827164821.331130-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240827164821.331130-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/24 01:48, Niklas Cassel wrote:
> Every time I see libata code calling scsi_check_sense(), I get confused
> why the code path that is working fine for SCSI code, is not sufficient
> for libata code.
> 
> The reason is that SCSI usually gets the sense data as part of the
> completion, and will thus automatically call scsi_check_sense(), which
> will set the SCSI ML byte (if any).
> 
> However, for libata queued commands, we always need to fetch the sense
> data via SCSI EH, and thus do not get the luxury of having
> scsi_check_sense() called automatically.
> 
> Add a new helper, ata_eh_decide_disposition(), that has a ata_eh_ prefix
> to more clearly highlight that this is only needed for code called by EH,
> while also having a similar name to scsi_decide_disposition(), such that
> it is easier to compare the libata code with the equivalent SCSI code.
> 
> Also add a big kdoc comment explaining why this helper is called/needed in
> the first place.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-eh.c   | 46 ++++++++++++++++++++++++++++++++++-----
>  drivers/ata/libata-sata.c |  8 +++----
>  drivers/ata/libata.h      |  1 +
>  3 files changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 214b935c2ced..173769999c13 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1401,6 +1401,43 @@ unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key)
>  	return err_mask;
>  }
>  
> +/**
> + *	ata_eh_decide_disposition - Disposition a qc based on sense data
> + *	@qc: qc to examine
> + *
> + *	For a regular SCSI command, the SCSI completion callback (scsi_done())
> + *	will call scsi_complete(), which will call scsi_decide_disposition(),
> + *	which will call scsi_check_sense(). scsi_complete() finally calls
> + *	scsi_finish_command(). This is fine for SCSI, since any eventual sense
> + *	data is usually returned in the completion itself (without invoking SCSI
> + *	EH). However, for a QC, we always need to fetch the sense data
> + *	explicitly using SCSI EH.
> + *
> + *	A command that is completed via SCSI EH will instead be completed using
> + *	scsi_eh_flush_done_q(), which will call scsi_finish_command() directly
> + *	(without ever calling scsi_check_sense()).
> + *
> + *	For a command that went through SCSI EH, it is the responsibility of the
> + *	SCSI EH strategy handler to call scsi_decide_disposition(), see e.g. how
> + *	scsi_eh_get_sense() calls scsi_decide_disposition() for SCSI LLDDs that
> + *	do not get the sense data as part of the completion.
> + *
> + *	Thus, for QC commands that went via SCSI EH, we need to call
> + *	scsi_check_sense() ourselves, similar to how scsi_eh_get_sense() calls
> + *	scsi_decide_disposition(), which calls scsi_check_sense(), in order to
> + *	set the correct SCSI ML byte (if any).
> + *
> + *	LOCKING:
> + *	EH context.
> + *
> + *	RETURNS:
> + *	SUCCESS or FAILED or NEEDS_RETRY or ADD_TO_MLQUEUE
> + */
> +enum scsi_disposition ata_eh_decide_disposition(struct ata_queued_cmd *qc)
> +{
> +	return scsi_check_sense(qc->scsicmd);
> +}
> +
>  /**
>   *	ata_eh_request_sense - perform REQUEST_SENSE_DATA_EXT
>   *	@qc: qc to perform REQUEST_SENSE_SENSE_DATA_EXT to
> @@ -1627,7 +1664,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc)
>  	}
>  
>  	if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
> -		enum scsi_disposition ret = scsi_check_sense(qc->scsicmd);
> +		enum scsi_disposition ret = ata_eh_decide_disposition(qc);

While at it, please add the missing blank line after this declaration.
Other than this, looks fine to me.

>  		/*
>  		 * SUCCESS here means that the sense code could be
>  		 * evaluated and should be passed to the upper layers
> @@ -1942,11 +1979,10 @@ static int ata_eh_read_sense_success_non_ncq(struct ata_link *link)
>  		return -EIO;
>  
>  	/*
> -	 * If we have sense data, call scsi_check_sense() in order to set the
> -	 * correct SCSI ML byte (if any). No point in checking the return value,
> -	 * since the command has already completed successfully.
> +	 * No point in checking the return value, since the command has already
> +	 * completed successfully.
>  	 */
> -	scsi_check_sense(qc->scsicmd);
> +	ata_eh_decide_disposition(qc);
>  
>  	return 0;
>  }
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 48660d445602..76904dce017e 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1455,12 +1455,10 @@ int ata_eh_read_sense_success_ncq_log(struct ata_link *link)
>  		qc->flags |= ATA_QCFLAG_SENSE_VALID;
>  
>  		/*
> -		 * If we have sense data, call scsi_check_sense() in order to
> -		 * set the correct SCSI ML byte (if any). No point in checking
> -		 * the return value, since the command has already completed
> -		 * successfully.
> +		 * No point in checking the return value, since the command has
> +		 * already completed successfully.
>  		 */
> -		scsi_check_sense(qc->scsicmd);
> +		ata_eh_decide_disposition(qc);
>  	}
>  
>  	return ret;
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 6abf265f626e..e4029626641d 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -162,6 +162,7 @@ extern void ata_eh_finish(struct ata_port *ap);
>  extern int ata_ering_map(struct ata_ering *ering,
>  			 int (*map_fn)(struct ata_ering_entry *, void *),
>  			 void *arg);
> +enum scsi_disposition ata_eh_decide_disposition(struct ata_queued_cmd *qc);
>  extern unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key);
>  extern unsigned int atapi_eh_request_sense(struct ata_device *dev,
>  					   u8 *sense_buf, u8 dfl_sense_key);

-- 
Damien Le Moal
Western Digital Research

