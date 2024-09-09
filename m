Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93317C9E8
	for <linux-ide@vger.kernel.org>; Mon,  9 Sep 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906609; cv=none; b=PoBLz5w/ikMA54QhpT9ZCF0Vv96X0LJenFw1WeQMeNawhWQzcdAoH0O6n+Zp7obmf/MxypB3c8RQ8HDy7uYFZwW/23WLkR4dzhHLd4sZg7rxOlLZODp0jF0McTbVL5qui4VFwkimpXKJfxK/VNqtQUQURKTB2apOsVJFukASzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906609; c=relaxed/simple;
	bh=4iWHQkAoxCtd6TpNZPDeQeMYMld6Bg6tYS1/pgkZAAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YD2LGgqCH4LqCGIFquOAlYptqiEgoY4L6pblJQrRs36feuNItYzByOPUNIBmXrjhmeNcGNTyCCPc0oLO15sIdrqjVThjLQyA4sLVxcuGAM7BApmzpzbDPda+L/PuF6YYua6wV5AbEy6DSajLVfixFs1598PXiEd+flhjFtkmIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+4vfRQJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+4vfRQJ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-206fee0a3d7so26785ad.0
        for <linux-ide@vger.kernel.org>; Mon, 09 Sep 2024 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725906607; x=1726511407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2B1Vn9F4s/nQSqb/JGDdpEGhf4y0Cyt+C5NA3VDNdmY=;
        b=m+4vfRQJIuMLDlitJIjAibQPoeU+D0jZ5fEGXcvibSogEicIHe7kI2VGhPy2gfwCDj
         6FSUag5QeYkmrIQ7RT73ppaAtVzCLUWf8Fw1t1DqIfgoKhv3x08h328Tv/NL/BpS1j9W
         iYswaObXODKCoOwfNRM+I/Pn/0NFCA6oYmt5bJ7fKHFXcXO1LUHVc+X1q70PDba5Duld
         aVYgPnhQZbofqiOBTUbzGTnyXVSf1OVIlsR67Ya1FHxoWdYs6E8xhSGkWHJfvQdnJC/l
         8W49tVnllWGG16dN7Gd3LRtbxUr7b4cIKAmRn3ZCg/fjigNY0EMt6+qtQsIQMLbrZgb5
         khRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725906607; x=1726511407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2B1Vn9F4s/nQSqb/JGDdpEGhf4y0Cyt+C5NA3VDNdmY=;
        b=KxvneKGri96GfLUz6jlKaR90iLfb4lGbl6RWOKo5p5f6mYRu1NGEehrZcjXOJ1AZuM
         7oCwM1XE+nEB/O6tTfm5XGX7Ehu3wbfAvd65DcVMZymKwPRtgCuqGPw2GCkp0Z+RyGhk
         s7Qi1jF31isKU4DQ5m4ZQUspnznZtgpTbzDLk8SoJRz9wMyzTqv79CDJ9FuYmEjX3KIW
         GNb2urybc70hT9ElhImHnm+YsXPWkKAlcwFs8ToA7vT4D/53QgTRh73PHAkcc1t0NMnn
         50dyOjlvCRp944IBo7Dwn00XLid5VAH1lNpvC6Erh/yK86V+VfZQ0egqxy/yocvbo6oB
         RPUg==
X-Forwarded-Encrypted: i=1; AJvYcCVtYFcnxsfHhL+6UaeK9KGlQ5AOjzBXqx3qw2BUJyaydHVjBWmltU8RPYF5sWJEe07diwhzCElJxFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxE3bL2FL7xfnWWvhq14Maaoug9AQ5YEuPlxw7sWaouvuQoeAG
	VXJPJCYTbvcVEumJyc/6uaDqbylfEgN2bTCZWx1DS4zuvIa5a8CkOH6kaiNqJA==
X-Google-Smtp-Source: AGHT+IGbuAI+H+yF0spgCYS9BsFFZ46GaWBUFgqNvMJBk4u4otGawCFrryaorbdBLg4GWCzF6mEwJQ==
X-Received: by 2002:a17:903:18f:b0:206:b7b2:4876 with SMTP id d9443c01a7336-20744a7c68amr223365ad.20.1725906606713;
        Mon, 09 Sep 2024 11:30:06 -0700 (PDT)
Received: from google.com (35.72.105.34.bc.googleusercontent.com. [34.105.72.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc127c66sm6946059a91.51.2024.09.09.11.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 11:30:06 -0700 (PDT)
Date: Mon, 9 Sep 2024 18:30:01 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v3] ata: libata: Clear DID_TIME_OUT for ATA PT commands
 with sense data
Message-ID: <Zt8-qfz9UbBT3YEX@google.com>
References: <20240909154237.3656000-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909154237.3656000-2-cassel@kernel.org>

On Mon, Sep 09, 2024 at 05:42:38PM +0200, Niklas Cassel wrote:
> When ata_qc_complete() schedules a command for EH using
> ata_qc_schedule_eh(), blk_abort_request() will be called, which leads to
> req->q->mq_ops->timeout() / scsi_timeout() being called.
> 
> scsi_timeout(), if the LLDD has no abort handler (libata has no abort
> handler), will set host byte to DID_TIME_OUT, and then call
> scsi_eh_scmd_add() to add the command to EH.
> 
> Thus, when commands first enter libata's EH strategy_handler, all the
> commands that have been added to EH will have DID_TIME_OUT set.
> 
> libata has its own flag (AC_ERR_TIMEOUT), that it sets for commands that
> have not received a completion at the time of entering EH.
> 
> Thus, libata doesn't really care about DID_TIME_OUT at all, and currently
> clears the host byte at the end of EH, in ata_scsi_qc_complete(), before
> scsi_eh_finish_cmd() is called.
> 
> However, this clearing in ata_scsi_qc_complete() is currently only done
> for commands that are not ATA passthrough commands.
> 
> Since the host byte is visible in the completion that we return to user
> space for ATA passthrough commands, for ATA passthrough commands that got
> completed via EH (commands with sense data), the user will incorrectly see:
> ATA pass-through(16): transport error: Host_status=0x03 [DID_TIME_OUT]
> 
> Fix this by moving the clearing of the host byte (which is currently only
> done for commands that are not ATA passthrough commands) from
> ata_scsi_qc_complete() to the start of EH (regardless if the command is
> ATA passthrough or not).
> 
> While at it, use the proper helper function to clear the host byte, rather
> than open coding the clearing.
> 
> This will make sure that we:
> -Correctly clear DID_TIME_OUT for both ATA passthrough commands and
>  commands that are not ATA passthrough commands.
> -Do not needlessly clear the host byte for commands that did not go via EH.
>  ata_scsi_qc_complete() is called both for commands that are completed
>  normally (without going via EH), and for commands that went via EH,
>  however, only commands that went via EH will have DID_TIME_OUT set.
> 
> Fixes: 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to not set CHECK_CONDITION")
> Reported-by: Igor Pylypiv <ipylypiv@google.com>
> Closes: https://lore.kernel.org/linux-ide/ZttIN8He8TOZ7Lct@google.com/

Tested-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor

> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v2: use set_host_byte() as suggested by Damien.
> 
>  drivers/ata/libata-eh.c   | 8 ++++++++
>  drivers/ata/libata-scsi.c | 3 ---
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 7de97ee8e78b..703f5ce26765 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -630,6 +630,14 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>  	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
>  		struct ata_queued_cmd *qc;
>  
> +		/*
> +		 * If the scmd was added to EH, via ata_qc_schedule_eh() ->
> +		 * scsi_timeout() -> scsi_eh_scmd_add(), scsi_timeout() will
> +		 * have set DID_TIME_OUT (since libata does not have an abort
> +		 * handler). Thus, to clear DID_TIME_OUT, clear the host byte.
> +		 */
> +		set_host_byte(scmd, DID_OK);
> +
>  		ata_qc_for_each_raw(ap, qc, i) {
>  			if (qc->flags & ATA_QCFLAG_ACTIVE &&
>  			    qc->scsicmd == scmd)
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 3a442f564b0d..6a90062c8b55 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1680,9 +1680,6 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
>  	} else if (is_error && !have_sense) {
>  		ata_gen_ata_sense(qc);
> -	} else {
> -		/* Keep the SCSI ML and status byte, clear host byte. */
> -		cmd->result &= 0x0000ffff;
>  	}
>  
>  	ata_qc_done(qc);
> -- 
> 2.46.0
> 
