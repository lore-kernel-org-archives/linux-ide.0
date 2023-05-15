Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865E5C77B7D
	for <linux-ide@archiver.kernel.org>; Mon, 15 May 2023 07:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbjEOHBt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 May 2023 03:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbjEOHBr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2023 03:01:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C78C93
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2023 00:01:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C996D61459
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2023 07:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA378C433D2;
        Mon, 15 May 2023 07:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684134105;
        bh=DsQTrJnlFLOm2yu2Mgbrt613luuAtbwn2pGk+B5A/M8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZsswkF7khKK9MWB4ggOXYxRXAkRvpj44583P5/dbzCGlNBSkjg9avy+LMi/NO/7FG
         It6Y569+9Siy3KCEieF6oiHZzXQhSqoEwIs2D8hzYkUxJOYbXDL0EXTnGF3nin4eN8
         QojidYkGFTcKfom/MV2ipqzkoBlDC6AOu+j+Hyw+n2XTpe/vqYjrtvh1FRDMiHtA+K
         wul7ohbuuZMmI8jjqsmrUkyPJVfamsMZ/TayeQ/9AUfLsWmcAMyXqKruNHSiL/8DS5
         XDfXsdCeC581i1bc0d9hFc7gouvPu7xXSX7RE4ahco+pwdc/0SiUxf7SHGOHhqZCoe
         K5wU4xRqCF+Dg==
Message-ID: <b6e3d385-1371-9331-cd64-28b59a4c0fe6@kernel.org>
Date:   Mon, 15 May 2023 16:01:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/6] ata: remove reference to non-existing error_handler()
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20230510225211.111113-1-hare@suse.de>
 <20230510225211.111113-2-hare@suse.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230510225211.111113-2-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/11/23 07:52, Hannes Reinecke wrote:
> With commit 65a15d6560df ("scsi: ipr: Remove SATA support") all
> libata drivers now have the error_handler() callback provided,
> so we can stop checking for non-existing error_handler callback.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libata-core.c | 158 ++++++++++++++------------------------
>  drivers/ata/libata-eh.c   | 148 +++++++++++++++--------------------
>  drivers/ata/libata-sata.c |   5 +-
>  drivers/ata/libata-scsi.c |  21 ++---
>  drivers/ata/libata-sff.c  |  32 +++-----
>  5 files changed, 139 insertions(+), 225 deletions(-)
> 

[...]

> -		case ATA_CMD_SLEEP:
> -			dev->flags |= ATA_DFLAG_SLEEPING;
> +	trace_ata_qc_complete_done(qc);
> +	/* Some commands need post-processing after successful
> +	 * completion.
> +	 */

While at it, can you fix this comment style ?
It may actually fit on one line...

[...]

> +	/* Exception might have happened after ->error_handler
> +	 * recovered the port but before this point.  Repeat
> +	 * EH in such case.
> +	 */

Same here. Multi-line comment format...

[...]

> -		/* end eh (clear host_eh_scheduled) while holding
> -		 * ap->lock such that if exception occurs after this
> -		 * point but before EH completion, SCSI midlayer will
> -		 * re-initiate EH.
> -		 */
> -		ap->ops->end_eh(ap);
> +	/* end eh (clear host_eh_scheduled) while holding
> +	 * ap->lock such that if exception occurs after this
> +	 * point but before EH completion, SCSI midlayer will
> +	 * re-initiate EH.
> +	 */

And here.

[...]

> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index f3e7396e3191..bd2a754b645c 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1138,11 +1138,8 @@ EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
>  int ata_sas_port_start(struct ata_port *ap)
>  {
>  	/*
> -	 * the port is marked as frozen at allocation time, but if we don't
> -	 * have new eh, we won't thaw it
> +	 * the port is marked as frozen at allocation time
>  	 */

This one can be a single line comment, no ?

[...]

> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 9d28badfe41d..aa286d48e847 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -883,31 +883,23 @@ static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
>  {
>  	struct ata_port *ap = qc->ap;
>  
> -	if (ap->ops->error_handler) {
> -		if (in_wq) {
> -			/* EH might have kicked in while host lock is
> -			 * released.
> -			 */
> -			qc = ata_qc_from_tag(ap, qc->tag);
> -			if (qc) {
> -				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
> -					ata_sff_irq_on(ap);
> -					ata_qc_complete(qc);
> -				} else
> -					ata_port_freeze(ap);
> -			}
> -		} else {
> -			if (likely(!(qc->err_mask & AC_ERR_HSM)))
> +	if (in_wq) {
> +		/* EH might have kicked in while host lock is
> +		 * released.
> +		 */

Comment format again.

Also, please add linux-scsi and John to the distribution list when resending.

-- 
Damien Le Moal
Western Digital Research

