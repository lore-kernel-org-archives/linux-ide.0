Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9A17E9;
	Thu, 27 Jun 2024 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719447560; cv=none; b=VGcrCgDLeSRHSqujEOC8TyadezaIG2m2RQIiz53SP8Wci3B0/k7MCTHHVUMs3NL7X8BHcSnSdVZzeQBgA1eCqYggwjaRG0agVSoHTpGAJa30fWhIBNdOs5u2E/Kz3K8pB4NA8BI0GD/4jtvHWFyj/z+NPC4TiOz6+oDPy4WnsRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719447560; c=relaxed/simple;
	bh=4Sjqdcm/Et8J9GCcvmGd3GMWAtR29LoWgvKP95CeIys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2G22hTv3U5boIwQsv1Zo8/wod99XKmR+Owz3YL8KuFJvGsW9zyEQTyDui+O02lWFdJzDfb1Lui+j/J1C3TAc9xd+0Wmoj0gipsSNskLaF+2oxYOkKIiSffw365CZhZZLCVMXtoD2wWmmOUeYf2oz23DXHcawIuB9vBpMtTy8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvAECljf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvAECljf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46FEC116B1;
	Thu, 27 Jun 2024 00:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719447559;
	bh=4Sjqdcm/Et8J9GCcvmGd3GMWAtR29LoWgvKP95CeIys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JvAECljfRKaUWYY5aNax0Tfq2aFFARHHeEkyO3KIBcNGgw44INw7luL6qipn4lZew
	 DXV6Jn1HMos9ValIUBps1sZHSBj+L0VTD6iZWN+XUfQeHVDOViAj41nww65z+X2SH6
	 F0mxdo3nx3H9yQ+GGRB17E6AY4qlaJ97UXVI0tJoXaO0cJ5cJpayeB9P0KPrxyEXzV
	 ydlVNV0mp/p5ST/RGa0lBFZYJQBXNs7EIEvwdbIuuaXzAFqJkSELIT1JKDYCCeU6+B
	 fR3AZSjoOp5aa45+3WnOf1oVH9FC5s9NW4Cgurd+7w0uIUiW9NqONKeTKlFvx+KruV
	 LdKTWcckmrcUw==
Message-ID: <9c8d751c-8d38-40f4-a88d-cfc39c7b6967@kernel.org>
Date: Thu, 27 Jun 2024 09:19:17 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED
 before using result_tf
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-7-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240626230411.3471543-7-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/24 08:04, Igor Pylypiv wrote:
> qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
> is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
> that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Please change "RTF" to "result TF" in the messages below, to be clear (RTF is
not). Feel free to split the ata_dev_dbg() lines after "dev," to avoid long lines.

With that:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

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

-- 
Damien Le Moal
Western Digital Research

