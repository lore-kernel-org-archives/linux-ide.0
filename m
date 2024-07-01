Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94151170855;
	Mon,  1 Jul 2024 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868368; cv=none; b=ChGUwu+1pVmw9aQe5A7aELtif573LrPzTaR4Z/zMcPvlUChJejG8MywOdVCneB+nDDurSsUDfH9T9BHpnJf3Sa10ZxwiGZbo1SY3E3AoxkF+sA96WVumYMQbRPS9TPlDdNtME4tRTe5c2BM60asih9CgI2lneCTRmZGtTnMr/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868368; c=relaxed/simple;
	bh=vfmW7OLRqYKvA9RpQ4HduE9Cx2Tt0CwKOTPEvBQcOpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhVKu+GIj5NgnGNfdtQSsGFIwuWWAlojbAfXtg5q6cksHFtOQ2xwtZ6YGW7B5sLBSQi0/azWOD1/x9KJBTgiOWvVXMwxTtMN7ZdNGtpszQkztdM4NS4QZBXnfm35W+AXdtFWpBplI4Q2QVDj2Rc9zm4SdYgiOoPwGMDFHnt9+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4pbvtif; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4pbvtif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC919C32781;
	Mon,  1 Jul 2024 21:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719868368;
	bh=vfmW7OLRqYKvA9RpQ4HduE9Cx2Tt0CwKOTPEvBQcOpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4pbvtifIx+X348hzCwpft5arY2NFJ5NFdPFODv4Gd2KJIyoxkHnzBvAgmcBrMln2
	 4LkK+ZrJsC/0JNcmKxcoWhjE3iQqlAwV1vHBjDulA66ZrYRkVriIoI1fNcLSNjgBN8
	 gYEH7qemrpyOKPND0qUg7vodRENM/YxM5ReVZeaTPQRKtSPuHkL9P5/LcCwykquu+A
	 yZVMyx9V9MCkEWZI3nu3y2cYurmUU0jWzEB4A5rDE1NzEphRs0n4Xzz7K69eXM8RjS
	 8rBvpUZqKaCT1RuNRHYM2KrPHFiumbCv/rKUJLJFNpALM6hvVj58ShHdo324OPzpQ2
	 sxIOYzbPsKiRg==
Date: Mon, 1 Jul 2024 23:12:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] ata: libata-scsi: Remove redundant sense_buffer
 memsets
Message-ID: <ZoMby8bM3s-HGVsg@ryzen.lan>
References: <20240701195758.1045917-1-ipylypiv@google.com>
 <20240701195758.1045917-5-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701195758.1045917-5-ipylypiv@google.com>

On Mon, Jul 01, 2024 at 07:57:54PM +0000, Igor Pylypiv wrote:
> SCSI layer clears sense_buffer in scsi_queue_rq() so there is no need for
> libata to clear it again.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-scsi.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index ace6b009e7ff..c11ae77d3ca6 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -926,11 +926,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  {
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  	struct ata_taskfile *tf = &qc->result_tf;
> -	unsigned char *sb = cmd->sense_buffer;
>  	u8 sense_key, asc, ascq;
>  
> -	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
> -
>  	/*
>  	 * Use ata_to_sense_error() to map status register bits
>  	 * onto sense key, asc & ascq.
> @@ -965,8 +962,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
>  	u64 block;
>  	u8 sense_key, asc, ascq;
>  
> -	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
> -
>  	if (ata_dev_disabled(dev)) {
>  		/* Device disabled after error recovery */
>  		/* LOGICAL UNIT NOT READY, HARD RESET REQUIRED */
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
