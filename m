Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189E3C7EE23
	for <linux-ide@archiver.kernel.org>; Mon, 22 May 2023 00:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjEVAs2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 21 May 2023 20:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEVAs1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 21 May 2023 20:48:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240CEC5
        for <linux-ide@vger.kernel.org>; Sun, 21 May 2023 17:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B409A614B5
        for <linux-ide@vger.kernel.org>; Mon, 22 May 2023 00:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3410C433EF;
        Mon, 22 May 2023 00:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684716506;
        bh=vihi6NxpeZKUxoTI28T4VQDVdbws9iXXjeFFW+HxEFI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ARezDHIxZPEVLvNbSMffA4yxC+/819MHi120KgOBZqGP3QzYV2OXmTbH9cTVBYs+m
         LbXfPH0bMXSzcrF6ByIos35EauXIXVBQsq1AxPU4aqrtP34yWIYdbrEWLc+fTNAs3s
         amCcWH9y1SVBwpkJCDcvohm4VrTKNWENqcwFLK9sWy894qOQT/Pj/ID81BQe8iD6Ra
         +F8r2Gfu0zRHr5CAxsN8zUNObJf/5cARXyCgagnxiwSblVkCrC6qHIsy90WpUYTylI
         uo20Ie6Xj5zcmAjO7tVzbethRqOVzikL8zGs0839eobHTwlhVc3VKXlcBQIZMluuMC
         xdIX9mHeg0UMQ==
Message-ID: <9cec80a5-9846-d1a4-9a9a-27ed9b510445@kernel.org>
Date:   Mon, 22 May 2023 09:48:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ata: libata-eh: Clarify ata_eh_qc_retry() behavior at
 call site
Content-Language: en-US
To:     Niklas Cassel <nks@flawful.org>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
References: <20230519104003.37843-1-nks@flawful.org>
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

Looks good. But may be resend this rebased on top of Hannes v2 of the error
handler cleanup once he sends it ?

> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
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
>  			else
>  				ata_eh_qc_complete(qc);
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

