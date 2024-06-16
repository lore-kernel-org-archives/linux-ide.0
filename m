Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D149658;
	Sun, 16 Jun 2024 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718580130; cv=none; b=QkKl7+CByeIahV9wOplNZQFju7u/6JN0sS6jPjSc/njIoCfuTffo/ksNr+kbnriBcovuRJIPstxzzKZMgAgKRwGKuadsqEHze9movpb4cGR2o203d9nH/r0qhB8uGyXsCUWvwA8HA3HbjiPsoXXTG3FC2Cuj6d88s0pkuYgiVvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718580130; c=relaxed/simple;
	bh=ATZCUHhwNkfeFpaCIG8LwLsmZwp2iCsQfv4z2yo71nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqM/AMksLNdaAfRzTeCCAiFH7rOvOGryl7OroWN4FaWWEp39pb06BEMNtgjs/PWHLKUu17ksd1cII02jKRgMShefpIV7lvMenpc2XF8kBeA9IxsOiBRlo38m1urxy7czQNbtMbPua67noJJqhXB05gx1yBJRvfq0eLmPUVijYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5KFqvlg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5KFqvlg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4516FC2BD10;
	Sun, 16 Jun 2024 23:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718580129;
	bh=ATZCUHhwNkfeFpaCIG8LwLsmZwp2iCsQfv4z2yo71nw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A5KFqvlgJjZ8VCMA5Sc+rEepI5pAjsXOFgbftg53Jbi+KyvQMeEu0DM5D0FLva2Fa
	 0GW5vrmriE5jc9Js6ildElQdBb27liHxMwZogRnRDMjakWwMOvm56ZSzz84i/CIOgX
	 Xf/LlfrqqiXw1DVbLzxutigRkptiQfmwNQ13np5WCPAKKJJazcJ8RhVgX/hVu9J2t3
	 SHOJW7OY+0ZAAUjrixaj0VQYFdw2xwqkO8uGhisiQBkljMbI+oG60vKzG42ZpEx+aG
	 EGWnlloxbHBdTF8ZqgcSEUTvG4QsPFM2c66uZkmNr9npcPgJNng30jF6GbNYNWwSoe
	 mLMlL+EvZbDwg==
Message-ID: <b87d51d8-5a89-480e-b229-7750c241aa6f@kernel.org>
Date: Mon, 17 Jun 2024 08:22:07 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] ata: libata-scsi: Generate ATA PT sense data when
 ATA ERR/DF are set
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-3-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240614191835.3056153-3-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/15/24 04:18, Igor Pylypiv wrote:
> SCSI/ATA Translation-5 (SAT-5) Table 209 — "ATA command results"
> specifies that SATL shall generate sense data for ATA PASS-THROUGH
> commands when either CK_COND is set or when ATA_ERR or ATA_DF status
> bits are set.
> 
> ata_eh_analyze_tf() sets AC_ERR_DEV bit in qc->err_mask when ATA_ERR
> or ATA_DF bits are set. It looks like qc->err_mask can be used as
> an error indicator but ata_eh_link_autopsy() clears AC_ERR_DEV bit
> when ATA_QCFLAG_SENSE_VALID is set. This effectively clears the error
> indication if no other bits were set in qc->err_mask.
> 
> ata_scsi_qc_complete() should not use qc->err_mask for ATA PASS-THROUGH
> commands because qc->err_mask can be zero (i.e. "no error") even when
> the corresponding command has failed with ATA_ERR/ATA_DF bits set.

If there was a failed command, qc->err_mask will be non-zero since the command
completion will be signaled by an error interrupt. So I am confused here. Are
you seeing this happening in practice ? If yes, doing what with which  adapter ?

> Additionally, the presence of valid sense data (ATA_QCFLAG_SENSE_VALID)
> should not prevent SATL from generating sense data for ATA PASS-THROUGH.

Same here, this is strange: ATA_QCFLAG_SENSE_VALID indicates that we have sense
data for the command, regardless if the command is passthrough or not. So if
that flag is set, we should not overwrite the already valid sense data with
sense data generated from the error and status bits.
Do you see an issue without this change ? If yes, what are the adapter and
operations you are running ?

> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-scsi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 032cf11d0bcc..79e8103ef3a9 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1632,8 +1632,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
>  
>  	/* For ATA pass thru (SAT) commands, generate a sense block if
> -	 * user mandated it or if there's an error.  Note that if we
> -	 * generate because the user forced us to [CK_COND =1], a check
> +	 * user mandated it or if ATA_ERR or ATA_DF bits are set. Note that
> +	 * if we generate because the user forced us to [CK_COND=1], a check
>  	 * condition is generated and the ATA register values are returned
>  	 * whether the command completed successfully or not. If there
>  	 * was no error, we use the following sense data:
> @@ -1641,7 +1641,7 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  	 * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
>  	 */
>  	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
> -	    ((cdb[2] & 0x20) || need_sense))
> +	    ((cdb[2] & 0x20) || (qc->result_tf.status & (ATA_ERR | ATA_DF))))
>  		ata_gen_passthru_sense(qc);
>  	else if (need_sense)
>  		ata_gen_ata_sense(qc);

-- 
Damien Le Moal
Western Digital Research

