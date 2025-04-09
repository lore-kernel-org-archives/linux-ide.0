Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5121DE2CE
	for <linux-ide@vger.kernel.org>; Wed,  9 Apr 2025 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744180185; cv=none; b=qZOX5UEgeeuf8i+TY3Ksl68Dggp92fTEKgECXeWKF4QL9mRTUkR9Sm8+HIgdA2G5VKzaSuxVG1WgpiZJCLhq48mTrQcsv9roj5oTxRIzQsaYaAvfxoEzOxMa4XuMZyE8HS1Ezf84TGAfw+Eut26g/n9n3u8TL6RRScJPPYIJt+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744180185; c=relaxed/simple;
	bh=UJqLfUlTttmYFJdENayH+++nzqHNj7B5G+tkQwav7Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiDa6igNHKcmMa3sYIvyPCx1OeodAEt/kV0eP2WprMZlsrE5d9loEJPQJBYOM9fC8Y8VsM3Z7K+3vGyOz7Mzjj1SkbMnsiBc2dXglgVJeKyEG44Gyl6bNbpl3DJeVHn4Hlbpl0k/99YWeO3jY/9356zz9PMLIfsKIv+eAquVcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIZPlvoC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIZPlvoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB332C4CEE3;
	Wed,  9 Apr 2025 06:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744180185;
	bh=UJqLfUlTttmYFJdENayH+++nzqHNj7B5G+tkQwav7Jg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mIZPlvoCCX0MZnDpK+wvg1MecNBdEBsyxu0soMOT1Z7NcNyBrhWF02fhZEVgdQK/U
	 3SciOy9fzyozsnSxFjG7b+eJtcorCA4FVQJWL4yyHNxTB3Hug5eK1yAU+9KulglVGw
	 2nrP2yztl9F6PXd3eykWJlGF5CMdAHey9mGIz/Twbyg/lZ1ztK/Qoik8Lmlrpn/PGn
	 EaLCPI/8fJlxf5CDBI3leH32rHqo/MY3N/KuG5QblDjVSY1B0od9OsPo7gjnOrBhVh
	 b323VnM0JrYnp3BEuCijT8UIfGqYPHghUtNweF7dRyjiITsDT0SK7enyv7tvGwa8Qd
	 iXLrOvRcsCpSg==
Message-ID: <d64ec1bd-e9a5-4e1a-b097-a5b354ddec19@kernel.org>
Date: Wed, 9 Apr 2025 15:29:03 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-sata: Use LBA from sense data descriptor
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20250408092858.227519-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250408092858.227519-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/25 6:28 PM, Niklas Cassel wrote:
> The definition of the LBA field in the sense data descriptor is:
> 
> "If definition of the sense data to be returned when a command completes
> without an error includes an LBA value, then the LBA field contains the
> defined value. Otherwise, the LBA field contains a copy of the LBA field
> in the command inputs for the command that completed without an error
> and returned sense data."
> 
> Thus, the LBA field in the sense data descriptor can contain a LBA value
> that is different from the LBA field in the command input.
> 
> Therefore, just like how ata_eh_read_log_10h() overrides qc->result_tf
> with the LBA in the NCQ Command Error log, override qc->result_tf with
> the LBA in the Successful NCQ Commands log.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks OK to me. Do we want a fixes tag on this one though ? Technically, this
is a bug, but no-one has stumbled on it...

> ---
>  drivers/ata/libata-sata.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index ba300cc0a3a3..c21fdacd0777 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1556,6 +1556,14 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
>  			continue;
>  		}
>  
> +		/* LBA in sense data desc can be different from LBA in qc->tf */
> +		qc->result_tf.lbal = sense[8];
> +		qc->result_tf.lbam = sense[9];
> +		qc->result_tf.lbah = sense[10];
> +		qc->result_tf.hob_lbal = sense[11];
> +		qc->result_tf.hob_lbam = sense[12];
> +		qc->result_tf.hob_lbah = sense[13];
> +
>  		/* Set sense without also setting scsicmd->result */
>  		scsi_build_sense_buffer(dev->flags & ATA_DFLAG_D_SENSE,
>  					qc->scsicmd->sense_buffer, sk,


-- 
Damien Le Moal
Western Digital Research
