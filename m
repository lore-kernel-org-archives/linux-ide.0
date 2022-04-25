Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41F6C433FE
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 06:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241355AbiDYGEL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Apr 2022 02:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbiDYGDp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Apr 2022 02:03:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A36A39689;
        Sun, 24 Apr 2022 23:00:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFE0E1F390;
        Mon, 25 Apr 2022 06:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650866425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+gDiZpvKGwccGtLprTaPsGmiM6iEv+9bhucdNBBywEs=;
        b=RPIoXQ3vSxrIqNGmo3W4f9Nt1Io+80tfu237oEweSAY857YiHavap07WRgsoIwLxsNE6sH
        kdb/PAmaDKldLiscPjof2icIz3TrWa9hTkVy1A06mogzBzqkxnvH6YjIyVglyFpZqJD22a
        bl0KkIrKkusBmE8TjOyiFf3hUrEUXJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650866425;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+gDiZpvKGwccGtLprTaPsGmiM6iEv+9bhucdNBBywEs=;
        b=Uavpx+Aokr8jIJrfzPpUla32fD74xqYXs3lYVtYmz2Kmfna9vr89qNtuj5krOqzsbiMJWC
        S14MucYnzUcrbdAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C721E13AED;
        Mon, 25 Apr 2022 06:00:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id elrgL/k4ZmISRwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 25 Apr 2022 06:00:25 +0000
Message-ID: <b64df936-681c-c88e-9f44-ab71e810584f@suse.de>
Date:   Mon, 25 Apr 2022 08:00:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 4/5] ata: libata-core: Allow forcing most horkage flags
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20220425013417.3947791-1-damien.lemoal@opensource.wdc.com>
 <20220425013417.3947791-5-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220425013417.3947791-5-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/25/22 03:34, Damien Le Moal wrote:
> To facilitate debugging of drive issues in the field without kernel
> changes (e.g. temporary test patches), add an entry for most horkage
> flags in the force_tbl array to allow controlling these horkage
> settings with the libata.force kernel boot parameter.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
>   drivers/ata/libata-core.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e5a0e73b39d3..f68cb5639ec4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6230,9 +6230,27 @@ static const struct ata_force_param force_tbl[] __initconst = {
>   	force_horkage_onoff(ncqtrim,	ATA_HORKAGE_NO_NCQ_TRIM),
>   	force_horkage_onoff(ncqati,	ATA_HORKAGE_NO_NCQ_ON_ATI),
>   
> -	force_horkage_on(dump_id,	ATA_HORKAGE_DUMP_ID),
> +	force_horkage_onoff(trim,	ATA_HORKAGE_NOTRIM),
> +	force_horkage_on(trim_zero,	ATA_HORKAGE_ZERO_AFTER_TRIM),
> +	force_horkage_on(max_trim_128m, ATA_HORKAGE_MAX_TRIM_128M),
> +
> +	force_horkage_onoff(dma,	ATA_HORKAGE_NODMA),
>   	force_horkage_on(atapi_dmadir,	ATA_HORKAGE_ATAPI_DMADIR),
> -	force_horkage_on(disable,	ATA_HORKAGE_DISABLE)
> +	force_horkage_on(atapi_mod16_dma, ATA_HORKAGE_ATAPI_MOD16_DMA),
> +
> +	force_horkage_onoff(dmalog,	ATA_HORKAGE_NO_DMA_LOG),
> +	force_horkage_onoff(iddevlog,	ATA_HORKAGE_NO_ID_DEV_LOG),
> +	force_horkage_onoff(logdir,	ATA_HORKAGE_NO_LOG_DIR),
> +
> +	force_horkage_on(max_sec_128,	ATA_HORKAGE_MAX_SEC_128),
> +	force_horkage_on(max_sec_1024,	ATA_HORKAGE_MAX_SEC_1024),
> +	force_horkage_on(max_sec_lba48,	ATA_HORKAGE_MAX_SEC_LBA48),
> +
> +	force_horkage_onoff(lpm,	ATA_HORKAGE_NOLPM),
> +	force_horkage_onoff(setxfer,	ATA_HORKAGE_NOSETXFER),
> +	force_horkage_on(dump_id,	ATA_HORKAGE_DUMP_ID),
> +
> +	force_horkage_on(disable,	ATA_HORKAGE_DISABLE),

... and this exemplifies my concerns with the 'onoff' mechanism:
Why is 'disable' just marked as 'on' ?
Sure we can set it to 'off' (we have to, otherwise that flag would 
always be set). And if we can set it to 'off', where's the different to 
'onoff' ?

Style-differences apart it looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
