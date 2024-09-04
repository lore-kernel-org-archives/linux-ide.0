Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1E17ADFF
	for <linux-ide@vger.kernel.org>; Wed,  4 Sep 2024 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725492457; cv=none; b=VnP6SlCrIZSuZtaAFXxycNMqilhbE9Z3qHiWTRawltlHgYc1Ho/2XtVaBc9cjWUIFaHcCIFb1eDchUF3rbYGE0bnS5XOJCkFiSfeE4CsMNDoeBLX5D37wTGqGKL+SLTHejP4wXbJmLOzPhpDJjJP6HkFO8lbppbRGnNph39B/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725492457; c=relaxed/simple;
	bh=HPBPrFF+7lfDpdJrXQHOrDz1pN1nE6ETsxYRcgx8Gos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnUcEUOsz5HXfWEt+1rZ0j6BaeyWQctWSPOtE7NjoiuQJWLQv44WTWeycYLJjLoyoIUPLvj0cxh6uPcYddBr6P1WexNvI68Wk57/GbPcZJdcbZMMHz/80fKjeCZbxHsr0X58CGwdtaaOHTfXcXGEQN6K7GhSvyr4ZqtB5Fq2giE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z3ot541t; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z3ot541t"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20546b8e754so50355ad.1
        for <linux-ide@vger.kernel.org>; Wed, 04 Sep 2024 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725492455; x=1726097255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d80WWhs9tvVaoV8l9KT4Bwz8dezGviWL9m69NS2CfjM=;
        b=Z3ot541t36AqzA89uptG9O7dwPogMjZfqdiUx1f4ETruWz/YmE7Iay1sCl6/XTBWTF
         B3fnhgED5bPUqCIB2hmGW6467r1kAmFYERUddEZ0rXMB0weRdToFkNE9CatuNdUfCggQ
         /NFSH1SsWvD/HZH5TJZP0/jeag1DfKs/NT9nJzuq1o5UuIempxeLNu1E41JrHbu/HXAD
         vHpStGAc2tpTr+8xW7s89aEQxQV+GaFVnZLMAwBGVurldg0+XTEZ4x+7YEfIdcOcdRuN
         c8QZfwlzhRnkCeXZtb0BzGSlxck/XGrqoywso2Fl7JIgLkn0T77FuPOpsbVhigi6/0Rz
         KgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725492455; x=1726097255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d80WWhs9tvVaoV8l9KT4Bwz8dezGviWL9m69NS2CfjM=;
        b=Tne/I2eIVReHN6HBKoxW4lslLYgczpgCGFzwDIzNE7R5E4y6tLyJxu554FNi+jdhzs
         7VEqVeLwmjQSoO/PkUkPmz7HtV15zX7d83zLfZxhPIE8v1A//ZdYq9sVr48ya7taEwJG
         S6YbzRfGwIPwCaivSPGJopd/6gL70Dpj1FbXPMX6/sRzMcYp5M3UjfagQvGzSEB6YDrQ
         5W9/tJX2UJowC7VfcdXifkyp3DLhiPJXOTG6jt3ALLs+HS9kiBmUzekNN/FL9gynHGFw
         arF/bgSymIZi7PuRv2skzLpaM3fiBpFEodvW3Uqesg/FPiZcetrcGaI1o/WX7eLlLfJt
         Dadg==
X-Forwarded-Encrypted: i=1; AJvYcCX1v0E/Jo8iefdUMx1AnqKj+r2BQcMb6QmVipjt59caUongPRX7Cugx0VdLTesaGeuzEXJ6+Cmz+Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1g8TRxnfXp0dtU4/PfIN57Mgvpc9UjbXk2ddBxd3XkZzvSk7d
	g+qKZ/jmsQMbvd4S0Fv0VWwW2ij/lzdzQFAPp0EAwSP340V5grekJcrIwzWu4A==
X-Google-Smtp-Source: AGHT+IEvyfbZZ4RNmX2OvXF3YlnXj1NCMEjLzvf409MtvnE5f13xAf1FMCxBRwLcdgLTST9FmKr97A==
X-Received: by 2002:a17:902:dacc:b0:1fd:8c42:61ce with SMTP id d9443c01a7336-206d3b96982mr611495ad.27.1725492455070;
        Wed, 04 Sep 2024 16:27:35 -0700 (PDT)
Received: from google.com (35.72.105.34.bc.googleusercontent.com. [34.105.72.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea5331bsm18319645ad.194.2024.09.04.16.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 16:27:34 -0700 (PDT)
Date: Wed, 4 Sep 2024 23:27:30 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: Clear scsicmd->result when setting
 SAM_STAT_CHECK_CONDITION
Message-ID: <Ztjs4vMNJsJ6_ZtS@google.com>
References: <20240904223727.1149294-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904223727.1149294-1-ipylypiv@google.com>

On Wed, Sep 04, 2024 at 10:37:27PM +0000, Igor Pylypiv wrote:
> commit 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to
> not set CHECK_CONDITION") changed the way how SAM_STAT_CHECK_CONDITION is
> set. Assignment "scmd->result = SAM_STAT_CHECK_CONDITION;" was replaced by
> set_status_byte() which does not clear the scsicmd->result.
> 
> By not clearing the scsicmd->result we end up in a state where both
> the DID_TIME_OUT host byte and the SAM_STAT_CHECK_CONDITION status
> bytes are set.
> 
> The DID_TIME_OUT host byte is getting set a part of error handling:
> 
> ata_qc_complete()
>     ata_qc_schedule_eh()
>         blk_abort_request()
>             WRITE_ONCE(req->deadline, jiffies);
> 
> blk_mq_timeout_work()
>     blk_mq_check_expired()
>         blk_mq_rq_timed_out()
> 	    req->q->mq_ops->timeout() / scsi_timeout()
>                 set_host_byte(scmd, DID_TIME_OUT);
> 
> Having the host byte set to DID_TIME_OUT for a command that didn't timeout
> is confusing. Let's bring the old behavior back by setting scmd->result to
> SAM_STAT_CHECK_CONDITION.
> 
> Fixes: 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to not set CHECK_CONDITION")
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-eh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 214b935c2ced..4927b40e782f 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1605,7 +1605,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc)
>  		 */
>  		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID) &&
>  		    (stat & ATA_SENSE) && ata_eh_request_sense(qc))
> -			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
> +			qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;

Just realized that this needs a comment "/* Clear the host byte. */" to
prevent someone from changing it back to set_status_byte() in the future.
I'll add the comment in v2.

>  		if (err & ATA_ICRC)
>  			qc->err_mask |= AC_ERR_ATA_BUS;
>  		if (err & (ATA_UNC | ATA_AMNF))
> -- 
> 2.46.0.469.g59c65b2a67-goog
> 
