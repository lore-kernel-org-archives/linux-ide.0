Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63417BA2;
	Tue, 30 Jun 2026 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782777920; cv=none; b=MGGN370fpKd691wILQOffxxSHU9cMqt4cazHUMITbsPpF5Ka7xEbxQNgfJ3dKFR7a2cCHER77yShi+2Vuq7ayhvAqB4smc2kpfo8KB4DPx/gzmWrf/J1lflWiKSBDIox0o1ccZ1H9J7e3zXMkWLmlm4P8LYzkp7WT1zBqHAoP3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782777920; c=relaxed/simple;
	bh=I/yS8maxt4cAq9huYPSO59xqwjFMAt9P087neFT9M7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9jVsCpipGNxvjgBN64FhuOL1eWSKLw51xSXp7ULJqYdJvPr35YlDlbp9BqULm0tYzyko7+2JqGVbC1h389leUkj2/t9WPEX1iUs6Jq/RBpb85NEFdzM4BHMUtnh37y8oo9bg7Qp0EMoMRowOQiDziAnnCIsNyldzO7xNvXs9hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAkgDS4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAkgDS4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7381F000E9;
	Tue, 30 Jun 2026 00:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782777918;
	bh=CxRAxfRJ5jFNUKLTDQmodCQ3w6aTLwEJlI1EBORcti0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hAkgDS4p3vOK7kfaAUaJ5fJigr96kvUNhlxS6shjCtuIZB+GoI2rsMxAmhdzbA8eL
	 Q5jDJUqotK1XDJv7Ke+wuaF0JWyXZGnGbLeWZ4X/jvco0UQQlXrRRhvyepxtjPxEBc
	 AleqvZbLrVh73n1JSh7jAh2lSoZP08GRl+vl3lF3iSws17txMyubxI0WboTNdLzLF+
	 2nSdPoq7nsmxcvtG2QKnNO77wSAcURflGH73KsRVcTsSKpiD20ohxUGnErf3utHgzG
	 u5D4+7F5kW27VCstQZIgpm4A7MCNrwG0Es8ZHr8BsUkxGyZO0OQ9vmAfuLA/F58WZp
	 uf3ef3fG1K7sw==
Message-ID: <7bef0564-e263-41de-857a-03ecbacc789d@kernel.org>
Date: Tue, 30 Jun 2026 09:05:16 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: limit simulated SCSI command copy to
 response length
To: Karuna Ramkumar <rkaruna@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 ipylypiv@google.com, tadamsjr@google.com
References: <20260629175024.2187500-1-rkaruna@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260629175024.2187500-1-rkaruna@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 02:50, Karuna Ramkumar wrote:
> The function ata_scsi_rbuf_fill() is used to copy the response of
> emulated SCSI commands from ata_scsi_rbuf to the SCSI command's
> scatterlist.
> 
> Currently, sg_copy_from_buffer() is called with the size argument
> set to ATA_SCSI_RBUF_SIZE (2048 bytes). Since ata_scsi_rbuf is
> zeroed out before the simulation actor is invoked, copying the
> full buffer size causes the remainder of the SCSI command's
> transfer buffer (beyond the actual response length 'len') to be
> overwritten with zeroes. This clobbers any pre-existing sentinel
> values or data in the caller's buffer tail, even though the
> correct residual count is reported via scsi_set_resid().
> 
> Fix this by passing the actual response length 'len' as the copy
> size to sg_copy_from_buffer(), ensuring that the tail of the
> caller's buffer remains untouched. Also, add a defensive
> WARN_ON() check to ensure that the actor does not return a
> length exceeding the static buffer capacity.
> 
> The fix was tested by invoking an SCSI SG_IO INQUIRY on
> an ATA disk on vanilla build, and build with the fix. Confirmed
> that the input buffer's tail end remains unmodified with the fix.
> 
> Fixes: 5251ae224d8d ("ata: libata-scsi: Return residual for emulated SCSI commands")
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Karuna Ramkumar <rkaruna@google.com>
> ---
>  drivers/ata/libata-scsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d54ec1631e9a..0ddec111a78c 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1933,8 +1933,10 @@ static void ata_scsi_rbuf_fill(struct ata_device *dev, struct scsi_cmnd *cmd,
>  	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
>  	len = actor(dev, cmd, ata_scsi_rbuf);
>  	if (len) {
> +		if (WARN_ON(len > ATA_SCSI_RBUF_SIZE))
> +			len = ATA_SCSI_RBUF_SIZE;

Yes, it is good to add a warning, but if this ever happen, then it is a serious
bug in libata-scsi and we should fail the command rather than return data from
something buggy. So let's do that rather than just warn.
The other change below looks good.

>  		sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
> -				    ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
> +				    ata_scsi_rbuf, len);
>  		cmd->result = SAM_STAT_GOOD;
>  		if (scsi_bufflen(cmd) > len)
>  			scsi_set_resid(cmd, scsi_bufflen(cmd) - len);


-- 
Damien Le Moal
Western Digital Research
