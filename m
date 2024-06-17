Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD20194A5A;
	Mon, 17 Jun 2024 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620892; cv=none; b=IsiVpjGR6v3jxMT2ItLFMrP2JEdVmQSYL5Ctzt4i8lB4ZPXG4QwXeLXlefieLX223UJPGt0aW2jSVvM67btRn46LI466B5p6gKGMjoLRYYtuO6N/FTNN/Qn1oojpoDZzxhuEPShjIDpwpmua8sI+QTxKzjJmSLFWpl3khTntKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620892; c=relaxed/simple;
	bh=Dsh3R9ovdsZeHqhJiI9asQDxs3bed9VRFa08ovjqA4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/+qW6ssuXJAObvimi84k0nrEkrqDiepC6cR2QEVX9H5gx9JESMO8BgPWtxlhakS8bYN0o27eumx/+RLyuleoCzqbaWo/w5ui0uRivvN3AWOUcP5MmY4B0U6FQeNPWMY+n2pqM8TIkE+4ETATFsPc16fhkVDQz1tyeJLjVl30u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxSx1KIG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxSx1KIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77994C2BD10;
	Mon, 17 Jun 2024 10:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718620891;
	bh=Dsh3R9ovdsZeHqhJiI9asQDxs3bed9VRFa08ovjqA4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxSx1KIGcUQF7XBY4aoQUS14IK1Zmw+h2XU9SkISgfXziWvfJgqLEOL9V2l+RE5Lf
	 V+qxT4QZcrEcTKc+l4mwshN9M+psHTqSEDlN2ueIoLW17TvREONms1cMErSEh7//PL
	 OHY70PqLHsI6OLyabqEOx4EXLGnVpwyprqarh/6joiB5KUWrmpjqVzIhH5Dh9fNtmx
	 3SY6JSWkhDj+uqzqwh0u1Q1e3yovmTdkAjNyeaoRW+HXo48wnxtpWUgEAn5P5qGokb
	 n58f16kTrrCUe62bqBKBnfNkjipqr2cj1MyFg+wwWV4txvD2Cit1o/uh2rKQti7APm
	 ODHBjF8nb6kuQ==
Date: Mon, 17 Jun 2024 12:41:26 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] ata: libata: Remove redundant sense_buffer memsets
Message-ID: <ZnAS1nux75l7QlqF@ryzen.lan>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-2-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614191835.3056153-2-ipylypiv@google.com>

On Fri, Jun 14, 2024 at 07:18:32PM +0000, Igor Pylypiv wrote:
> scsi_queue_rq() memsets sense_buffer before a command is dispatched.
> 
> Libata is not memsetting sense_buffer before setting sense data that
> was obtained from a disk so there should be no reason to do a memset
> for ATA PASS-THROUGH / ATAPI.
> 
> Memsetting the sense_buffer in ata_gen_passthru_sense() is erasing valid
> sense data that was previously obtained from a disk. A follow-up patch
> will modify ata_gen_passthru_sense() to stop generating sense data based
> on ATA status register bits if a valid sense data is already present.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-eh.c   | 2 --
>  drivers/ata/libata-scsi.c | 4 ----
>  2 files changed, 6 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 214b935c2ced..b5e05efe73f6 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1479,8 +1479,6 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
>  	struct ata_port *ap = dev->link->ap;
>  	struct ata_taskfile tf;
>  
> -	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
> -

Are you sure that this is safe?

atapi_eh_request_sense() is called both by:
ata_eh_analyze_tf():
tmp = atapi_eh_request_sense(.., qc->scsicmd->sense_buffer, ..)

and by:
atapi_eh_clear_ua():
atapi_eh_request_sense(.., sense_buffer, ..);
where sense_buffer is dev->link->ap->sector_buf.


Wouldn't a better fix be for ata_gen_* functions to return early if
ATA_QCFLAG_SENSE_VALID is set?


>  	/* initialize sense_buf with the error register,
>  	 * for the case where they are -not- overwritten
>  	 */
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index cdf29b178ddc..032cf11d0bcc 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -858,8 +858,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  	unsigned char *desc = sb + 8;
>  	u8 sense_key, asc, ascq;
>  
> -	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
> -
>  	/*
>  	 * Use ata_to_sense_error() to map status register bits
>  	 * onto sense key, asc & ascq.
> @@ -953,8 +951,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
>  	u64 block;
>  	u8 sense_key, asc, ascq;
>  
> -	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
> -
>  	if (ata_dev_disabled(dev)) {
>  		/* Device disabled after error recovery */
>  		/* LOGICAL UNIT NOT READY, HARD RESET REQUIRED */
> -- 
> 2.45.2.627.g7a2c4fd464-goog
> 
