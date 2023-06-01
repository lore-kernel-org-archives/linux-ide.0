Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FBEC77B73
	for <linux-ide@archiver.kernel.org>; Thu,  1 Jun 2023 00:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjFAAQl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 May 2023 20:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFAAQl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 May 2023 20:16:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FAC121
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2023 17:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3EF763F7C
        for <linux-ide@vger.kernel.org>; Thu,  1 Jun 2023 00:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FCBC433D2;
        Thu,  1 Jun 2023 00:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685578599;
        bh=hHigXL5o3aR4Rd7hVynxKgrNcNPY8Rxseqz14xovFzI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XHFzunW+Q2uzHDDPgPl92OGLudFlgMN5mcUn5q8p/pYQgab8LjpxYCkq+onHaGuc7
         GNMZBCpW41GZ/ZqJjXM0xrSfKGh7IJs2SeZXG6eWiP8yt+1mJVk2t1zL0/C9OqCNUI
         rag7bU+Hog6mxlwVbUO/o18Z09rEe7A5uBGcP0XQpcXOKOlCCDG28Uko23AYCrVo5Z
         tXKB9nl3eO/KzWNvwZopIGdHq6oAxmQSmb4EjbVf+JXLskRQqFScgoBOrzgoklcArK
         XevGU+IhPtR9KvlSf4AZkgB4FqdscgO278LBpZ/BLBa4KrXwzktlWUEsvqDEwiCZpS
         ZpI8LAgzYtUBg==
Message-ID: <dcdd2831-bf3d-782f-6d8f-d50d62237115@kernel.org>
Date:   Thu, 1 Jun 2023 09:16:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ata: libata-eh: Clarify ata_eh_qc_retry() behavior at
 call site
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20230519104003.37843-1-nks@flawful.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230519104003.37843-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/19/23 19:40, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> While the function documentation for ata_eh_qc_retry() is clear,
> from simply reading the single function that calls ata_eh_qc_retry(),
> it is not clear that ata_eh_qc_retry() might not retry the command.
> 
> Add a comment in the single function that calls ata_eh_qc_retry() to
> clarify the behavior.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Applied to for-6.5 with one nit (see below). Thanks !

> ---
>  drivers/ata/libata-eh.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index a6c901811802..170326dc1073 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -3814,6 +3814,12 @@ void ata_eh_finish(struct ata_port *ap)
>  			 * considering both err_mask and tf.
>  			 */
>  			if (qc->flags & ATA_QCFLAG_RETRY)
> +				/*
> +				 * Since qc->err_mask is set, ata_eh_qc_retry()
> +				 * will not increment scmd->allowed, so upper
> +				 * layer will only retry the command if it has
> +				 * not already been retried too many times.
> +				 */
>  				ata_eh_qc_retry(qc);

I added curly braces here (while not strictly needed, this if is multi-line with
the comment added, so I prefer having the braces around it).

>  			else
>  				ata_eh_qc_complete(qc);

And here as well to match the if side.

> @@ -3823,6 +3829,12 @@ void ata_eh_finish(struct ata_port *ap)
>  			} else {
>  				/* feed zero TF to sense generation */
>  				memset(&qc->result_tf, 0, sizeof(qc->result_tf));
> +				/*
> +				 * Since qc->err_mask is not set,
> +				 * ata_eh_qc_retry() will increment
> +				 * scmd->allowed, so upper layer is guaranteed
> +				 * to retry the command.
> +				 */
>  				ata_eh_qc_retry(qc);
>  			}
>  		}

-- 
Damien Le Moal
Western Digital Research

