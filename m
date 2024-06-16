Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2876949658;
	Sun, 16 Jun 2024 23:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718580357; cv=none; b=hAruoy+VPpzmeu0n2b7jIXuuey/6F2gPqoV5OgEKlE2L3+fao97ITN3UztoFpquBnYhIlcf5VoDUZyHB5PkTpn+5Qctm7ZsMhXZssDPeo2bkwAgnvd2ypqNxdVPXnmvJs3rRr+7C4nqqwfs2Oi2D+36gg7o90+f2yyYrXJ9bfpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718580357; c=relaxed/simple;
	bh=a7pkhSX/Pw7+Pms73pM4XNmLMG8g4TIhDylfzJ6SZ+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwmxjPo3LYXqjoUvBF5pGMDI74lTWRqKF860SUA+cQy+Hf3VJrY9MH4QGpH4v0vwSAwHwBS9F53nBbyfqxVhMzhfbD+KlxMBvLshZKDit5NcWU569Tq2FkKrEBMr6rbxHyyXkItvkf0SanI94LB61IuKkNCijcKvXxmzHRE0uQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q36ZnSxo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q36ZnSxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6260C2BBFC;
	Sun, 16 Jun 2024 23:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718580356;
	bh=a7pkhSX/Pw7+Pms73pM4XNmLMG8g4TIhDylfzJ6SZ+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q36ZnSxo2yP7B4oVqcKCNAAXDmGC8l5sS6cI1gkjp/kYzBrd9blTHDdXwf+7nc3ui
	 Kpmn2a2cgTWMCVHdewSZZKg2ie39b/rgUfpoId3UFdaC2KSLrTREycinAy4cVdCNiv
	 Q0ZaCZPt76lrqEQCTIJonYj72hdqCHjDz0I4MmPPClmduDRFsxbdMgrV6utS5FWjrH
	 CA3o07y6XgzCqxCzizeBHj1hH3oundnHf5nGMjniJzhNPjOK5jQipdBqbY8E+pQ5AL
	 N0POCkPo+Gt9Pj/k+ojGFfhS+hcOvIKsz2RIzB7mx0GAMCsv+w3/HpsE04kwx8c4Tg
	 kIwBM8nG5v/Tw==
Message-ID: <dfb741e5-2fe6-4b36-b1ab-55c3c33032d0@kernel.org>
Date: Mon, 17 Jun 2024 08:25:54 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] ata: libata-scsi: Report valid sense data for ATA
 PT if present
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-4-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240614191835.3056153-4-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/24 04:18, Igor Pylypiv wrote:
> Do not generate sense data from ATA status/error registers
> if valid sense data is already present.

This kind of contradicts what you said in patch 2... So I am really confused now.
Though this patch actually looks good to me, modulo the comment below.
But shouldn't this be squashed with patch 2 ?

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

The empty "if" here is really horrible. Please revert the condition and add it
as a "&&" in the below if.

> +	} else if (qc->err_mask ||
> +		   tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> +		/*
> +		 * Use ata_to_sense_error() to map status register bits
> +		 * onto sense key, asc & ascq.
> +		 */
>  		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
>  				   &sense_key, &asc, &ascq);
>  		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);

-- 
Damien Le Moal
Western Digital Research

