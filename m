Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF8194158;
	Mon, 17 Jun 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623770; cv=none; b=Sk+FSLzGk2BOnuPmOO1I/SPV04uRJMJLu8Vl3V3gAyZa6d1HJxyyyzX/FfX5xQUPXbRiRaRAJ6Nlfg0H0irOAc5Z0TtM2J3AkTQK2n4Mb/CLwNCVt9c1xIwKYex4uA3lq6r1a83nuqiYzB34lGw4xn2jo788t0rhlIhCWu54bis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623770; c=relaxed/simple;
	bh=l+eY3rO3cTAcIXKGLx/9rS3o99sJERAR97d7qGO0mXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgepsheW24HyCFrJMMmnXeNUu4KJSbAsX+tAKtpYrXClVPsMCznAAmFX/huH3fHievAISpvLxLPIwdVTz6BcGO8WD5ZvrHMSuCwqEFTC8fyXooYitqkd0IoMkVDDvmrVF7Lj75HRH8xZBMR+JxJl7EXI2XQfLNdUc+uQNMO7ayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB7l49eK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB7l49eK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E786C2BD10;
	Mon, 17 Jun 2024 11:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718623770;
	bh=l+eY3rO3cTAcIXKGLx/9rS3o99sJERAR97d7qGO0mXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RB7l49eKMFf3EPtybAI211NOb9FTiIDTXFAqe1HnMufIFQs0nIL62q7OiZsZEvvc4
	 ZelsaWtxB+Q3LsUzB0D7s7nmMzXq0ygFc2TATe/z03sVMZs9Y0AVdE8ax8iF7REY2h
	 PC3uGo/VSnmtAfEKcO1QunxsAtcKUmg5U/oQf7PhXk64gvkzp8MSg2jpmmwuAejkOM
	 QMs0AtW3szJ9hxiMzlHJ2qpk4lJz+CAIAG6jGjJkPk+m+tZCGhZSicCirVWVaFo3AH
	 qJoZJfGW305bDliPzTl4OIOmlaZk2g3CfWYai5+ME0hUgPF7HiibL42tPlDvOohEqR
	 V0hiDdaqa+vvQ==
Date: Mon, 17 Jun 2024 13:29:25 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] ata: libata-scsi: Generate ATA PT sense data when
 ATA ERR/DF are set
Message-ID: <ZnAeFbdt02zge2my@ryzen.lan>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-3-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614191835.3056153-3-ipylypiv@google.com>

On Fri, Jun 14, 2024 at 07:18:33PM +0000, Igor Pylypiv wrote:
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

The reason why libata clears the err_mask when having sense data,
is because the upper layer, i.e. SCSI, should determine what to do
with the command, if there is sense data.

For a non-passthrough command, this will be done by
scsi_io_completion_action():
https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/scsi/scsi_lib.c#L1084-L1087


However, if there is any bits set in cmd->result,
scsi_io_completion_nz_result() will be called:
https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/scsi/scsi_lib.c#L1052-L1053

which will do the following for a passthrough command:
https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/scsi/scsi_lib.c#L969-L978
which will set blk_stat.

After that, scsi_io_completion() which check blk_stat and if it is a
scsi_noretry_cmd():
https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/scsi/scsi_lib.c#L1073-L1078

A passthrough command will return true for scsi_noretry_cmd(), so
scsi_io_completion_action() should NOT get called for a passthough command.

So IIUC, for a non-passthrough command, scsi_io_completion_action() will
decide what to do depending on the sense data, but a passthrough command will
get finished with the sense data, leaving the user to decide what to do.


> 
> ata_scsi_qc_complete() should not use qc->err_mask for ATA PASS-THROUGH
> commands because qc->err_mask can be zero (i.e. "no error") even when
> the corresponding command has failed with ATA_ERR/ATA_DF bits set.
> 
> Additionally, the presence of valid sense data (ATA_QCFLAG_SENSE_VALID)
> should not prevent SATL from generating sense data for ATA PASS-THROUGH.
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

qc->result_tf can only be used if qc->flags has ATA_QCFLAG_RESULT_TF set,
otherwise it can contain bogus data.
You don't seem to check if ATA_QCFLAG_RESULT_TF is set.

ata_scsi_pass_thru() does set ATA_QCFLAG_RESULT_TF.


>  		ata_gen_passthru_sense(qc);
>  	else if (need_sense)
>  		ata_gen_ata_sense(qc);
> -- 
> 2.45.2.627.g7a2c4fd464-goog
> 
