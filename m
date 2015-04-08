From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] libata: Fix division by zero
Date: Wed, 08 Apr 2015 15:52:58 +0200
Message-ID: <5105249.IaGgeTGhXs@amdc1032>
References: <20150408125114.29925.841.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:20827 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbbDHNxO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Apr 2015 09:53:14 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NMH00MVFQKOXP70@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Wed, 08 Apr 2015 22:53:12 +0900 (KST)
In-reply-to: <20150408125114.29925.841.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <gnomes@lxorguk.ukuu.org.uk>
Cc: tj@kernel.org, linux-ide@vger.kernel.org


Hi,

On Wednesday, April 08, 2015 01:51:36 PM Alan wrote:
> (Coverity 1192289, 1192292, 1192294)
> 
> We have several controllers that in some cases use ata_timing_compute but do
> not do UDMA. They pass 0 for UT, which ends up with us doing a division by
> zero. We could pass some other bogus value in or we could make the libata
> code do the sensible thing and treat a UT of 0 as meaning "I'm not asking
> about UDMA".
> 
> This patches does the latter which is IMHO the more robust option.

Please note that we should not end up with the division by zero with
existing host drivers.  EZ(v, unit) checks for v being zero and t->udma
is non-zero only for XFER_UDMA_* xfer modes.  Currently none of host
drivers calls ata_timing_compute() on xfer mode >= XFER_UDMA_0 with
the zero UT argument.  Such usage will be an error and while the old
code explodes immediately, the new one will silently accept it (which
could theoretically result in the wrong timing being set)..

Could you please enhance your patch with a validity code requiring
non-zero UT when speed >= XFER_UDMA_0 is used in ata_timing_compute()?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>  0 files changed
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index f6cb1f1..6b1bd36 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2966,7 +2966,8 @@ static void ata_timing_quantize(const struct ata_timing *t, struct ata_timing *q
>  	q->recover	= EZ(t->recover    * 1000,  T);
>  	q->dmack_hold	= EZ(t->dmack_hold * 1000,  T);
>  	q->cycle	= EZ(t->cycle      * 1000,  T);
> -	q->udma		= EZ(t->udma       * 1000, UT);
> +	if (UT)
> +		q->udma		= EZ(t->udma       * 1000, UT);
>  }
>  
>  void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,

