From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] ata: Clean up hard coded array size calculation.
Date: Tue, 10 Nov 2009 00:00:19 -0500
Message-ID: <4AF8F363.3010806@rtr.ca>
References: <1257708657-1232-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:34341 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbZKJFAP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Nov 2009 00:00:15 -0500
In-Reply-To: <1257708657-1232-1-git-send-email-tfransosi@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
Cc: jgarzik@pobox.com, mlord@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Thiago Farina wrote:
> Use ARRAY_SIZE macro of kernel api instead.
> 
> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
> ---
>  drivers/ata/sata_mv.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 6f5093b..a8a7be0 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2217,7 +2217,7 @@ static unsigned int mv_qc_issue_fis(struct ata_queued_cmd *qc)
>  	int err = 0;
>  
>  	ata_tf_to_fis(&qc->tf, link->pmp, 1, (void *)fis);
> -	err = mv_send_fis(ap, fis, sizeof(fis) / sizeof(fis[0]));
> +	err = mv_send_fis(ap, fis, ARRAY_SIZE(fis));
>  	if (err)
>  		return err;
>  
..

What's the point of this ?

There is no "hardcoded array size" there to begin with,
and using that silly macro obscures the actual calculation.

So now, instead of being able to verify correctness at a glance,
I have to go off and research some silly macro and verify that
it does the right thing.

Kind of like all of those "typedef structs" that are abhored around here.

-ml
