From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: get rid of ATA_MAX_QUEUE loop in	ata_qc_complete_multiple()
Date: Wed, 20 May 2009 16:26:05 +0900
Message-ID: <4A13B08D.3060005@gmail.com>
References: <20090520065752.GC11363@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:49366 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbZETHeJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 03:34:09 -0400
Received: by pxi29 with SMTP id 29so247280pxi.33
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 00:34:10 -0700 (PDT)
In-Reply-To: <20090520065752.GC11363@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Hello, Jens.

Jens Axboe wrote:
> @@ -5039,16 +5039,19 @@ int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active)
>  		return -EINVAL;
>  	}
>  
> -	for (i = 0; i < ATA_MAX_QUEUE; i++) {
> +	while (done_mask) {
>  		struct ata_queued_cmd *qc;
> +		unsigned int next = __ffs(done_mask);
>  
> -		if (!(done_mask & (1 << i)))
> -			continue;
> -
> -		if ((qc = ata_qc_from_tag(ap, i))) {
> +		qc = ata_qc_from_tag(ap, i + next);
> +		if (qc) {
>  			ata_qc_complete(qc);
>  			nr_done++;
>  		}
> +		if (++next >= ATA_MAX_QUEUE)
> +			break;

Given that __ffs doesn't care how far the first bit is on most archs
(even the generic one), I think it would be simpler and more efficient
to simply do done_mask &= ~(1 << i) and loop without adding to index
and shifting.

Thanks.

-- 
tejun
