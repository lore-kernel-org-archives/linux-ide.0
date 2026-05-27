Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6543D412A
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879437; cv=none; b=U3YReP751U9ivBzSOWLnZiGt1Crg8zD1N7bq9ei1fVlQ1J9SXxMi/jMWmoy6lczaS6P/EQ5tDCdm5av2tUracCgQHtgUBn+WqsG6O4DRHdAOTz5p9k4Cti27YWNHq1y36ywFXaWeLZS9cRVCzN9DBHtxjW2e919TFBT+YdS+eD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879437; c=relaxed/simple;
	bh=OCbhBLjyLriXrxwBnlQI3JIImME6pIyaI7rnNHTysrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDD9phryUaeZHKqDL4miRFumAeoPrQOynBAC2AYtfCT8pI9jr2oWaqxDpWkxZr0j4xpw0sC5YFhMjBklikwJH41tJ9QMAGxz+Rq1xVixNo9K6XxQLyVLtTD706z/YjA/mMoEtEFL3D/zKThQ5ZOprWt+Fnurw3UMKPzmzlNTwkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZMS3Ukr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZMS3Ukr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DECF1F000E9;
	Wed, 27 May 2026 10:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779879436;
	bh=O0PNgr+GOeJoA5Iq9PA+h4kl0krFASVnJfERKflsXvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FZMS3Ukr1haMruryf3pqJ5eSVmRvHGMtUJtwTeWvSTNGhchEfk9WGNJtZp++E2scp
	 psBcCXmdZEtGVneSawfoqxi60Hrw5uQ5n4XAWjrFGvZsWzCTwzYGqNplDM2SLvcqBC
	 H9TE0CcXroVT5Ep9AM/inyC1unFim4lvXAR6euCbvJ3ao7DPHiK7hyE6739AntaqfL
	 B94CE0YRa0vPdRtJR9WrbyNDTHQd1Olw0bjI7QcBkEa0wVH9trX8ViQCVxrHFAljLT
	 pZbxc4NuDpR3OFWRhAWGtRWivbXwl2eLA5rlXHMuOjcLJBjywWgDGZ9FNNc0Q/khiI
	 JNDQ3sBqgHhGA==
Date: Wed, 27 May 2026 12:57:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Mikael Pettersson <mikpelinux@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v2 9/9] ata: Annotate the code that uses the host lock
Message-ID: <ahbOCL2EG674wsKn@ryzen>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-10-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521173347.2079560-10-bvanassche@acm.org>

On Thu, May 21, 2026 at 10:33:37AM -0700, Bart Van Assche wrote:
> Annotate all functions and also their direct and indirect callers with
> __must_hold() that have a lockdep_assert_held() statement in their
> function body for the host lock. As one can see in the comments added by
> this patch, locking is missing from the following two functions:
>  * Some of the ata_port_freeze() callers.
>  * nv_do_interrupt().
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---

(snip)

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 8b8081f4dc63..52bcd8c78774 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5027,6 +5027,9 @@ void ata_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc)
>  	struct ata_device *dev = qc->dev;
>  	struct ata_eh_info *ehi = &dev->link->eh_info;
>  
> +	/* Tell the compiler that qc->dev->link->ap == ap. */
> +	__assume_ctx_lock(qc->dev->link->ap->lock);

Is there any way we could avoid this __assume_ctx_lock() ?

Which is the function we call that needs this?

Could we avoid it if we add a ap / qc / link argument to that function?



> +
>  	/* Trigger the LED (if available) */
>  	ledtrig_disk_activity(!!(qc->tf.flags & ATA_TFLAG_WRITE));
>  
> @@ -5162,6 +5165,10 @@ void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
>  	struct ata_link *link = qc->dev->link;
>  	u8 prot = qc->tf.protocol;
>  
> +	/* Tell the compiler that qc->ap == qc->dev->link->ap->lock == ap. */
> +	__assume_ctx_lock(qc->ap->lock);
> +	__assume_ctx_lock(qc->dev->link->ap->lock);

Is there any way we could avoid these two __assume_ctx_lock() ?

Which is the function we call that needs this?

Could we avoid it if we add a ap / qc / link argument to that function?



Kind regards,
Niklas
