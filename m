Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD35C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 11:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiADLlz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:41:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53980 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiADLly (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 06:41:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 065281F37F;
        Tue,  4 Jan 2022 11:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641296513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T6suY503uxiXoadH/2nCcvlCqyeUL/WJwRPxcCLZ/r0=;
        b=z8hqo/mfGJFlixmHd+8xTkERPQtuFhlRHNJcydOcYN08uDeo8Emm+uQCgR1GYtS4jKK0tR
        ebQMedd0o2yurLt5TX3zA11YJPsUjVw1gxUBKhzOJmO90U44rrgP1LYGY95YiK3mKjSiKB
        XIOTiGipaLVNDgsDb/AUa1lgdJ4xHPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641296513;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T6suY503uxiXoadH/2nCcvlCqyeUL/WJwRPxcCLZ/r0=;
        b=qa/06OnEYClCmQMzFZgRHYt89+C6US+tbHn+jXkPrh2Y5DjRImUSQMtxBX67f10Y4tFv95
        aykoSk3Fk0GS2LBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E690E13AF4;
        Tue,  4 Jan 2022 11:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ue8SOIAy1GEyQAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Jan 2022 11:41:52 +0000
Subject: Re: [PATCH v2 19/22] ata: sata_fsl: fix scsi host initialization
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-20-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <31e11af3-5a75-48d1-6f79-73db6a5d6087@suse.de>
Date:   Tue, 4 Jan 2022 12:41:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220104105843.1730172-20-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 11:58 AM, Damien Le Moal wrote:
> When compiling with W=1, the sata_fsl driver compilation throws the
> warning:
> 
> drivers/ata/sata_fsl.c:1385:22: error: initialized field overwritten
> [-Werror=override-init]
>  1385 |         .can_queue = SATA_FSL_QUEUE_DEPTH,
> 
> This is due to the driver scsi host template initialization overwriting
> the can_queue field that is already set using the ATA_NCQ_SHT()
> initializer macro, resulting in the same field being initialized twice
> in the host template declaration.
> 
> To remove this warning, introduce the ATA_SUBBASE_SHT_QD() and
> ATA_NCQ_SHT_QD() initialization macros to allow specifying a queue depth
> different from the default ATA_DEF_QUEUE using an additional argument to
> the macro.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/sata_fsl.c |  3 +--
>  include/linux/libata.h | 11 +++++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 142e65d5efc7..101d4dd79f62 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1380,8 +1380,7 @@ static void sata_fsl_host_stop(struct ata_host *host)
>   * scsi mid-layer and libata interface structures
>   */
>  static struct scsi_host_template sata_fsl_sht = {
> -	ATA_NCQ_SHT("sata_fsl"),
> -	.can_queue = SATA_FSL_QUEUE_DEPTH,
> +	ATA_NCQ_SHT_QD("sata_fsl", SATA_FSL_QUEUE_DEPTH),
>  	.sg_tablesize = SATA_FSL_MAX_PRD_USABLE,
>  	.dma_boundary = ATA_DMA_BOUNDARY,
>  };
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index ab2d404cde08..cafe360ab3cd 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1385,6 +1385,12 @@ extern const struct attribute_group *ata_common_sdev_groups[];
>  	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
>  	.slave_configure	= ata_scsi_slave_config
>  
> +#define ATA_SUBBASE_SHT_QD(drv_name, drv_qd)			\
> +	__ATA_BASE_SHT(drv_name),				\
> +	.can_queue		= drv_qd,			\
> +	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
> +	.slave_configure	= ata_scsi_slave_config
> +
>  #define ATA_BASE_SHT(drv_name)					\
>  	ATA_SUBBASE_SHT(drv_name),				\
>  	.sdev_groups		= ata_common_sdev_groups
> @@ -1396,6 +1402,11 @@ extern const struct attribute_group *ata_ncq_sdev_groups[];
>  	ATA_SUBBASE_SHT(drv_name),				\
>  	.sdev_groups		= ata_ncq_sdev_groups,		\
>  	.change_queue_depth	= ata_scsi_change_queue_depth
> +
> +#define ATA_NCQ_SHT_QD(drv_name, drv_qd)			\
> +	ATA_SUBBASE_SHT_QD(drv_name, drv_qd),			\
> +	.sdev_groups		= ata_ncq_sdev_groups,		\
> +	.change_queue_depth	= ata_scsi_change_queue_depth
>  #endif
>  
>  /*
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
