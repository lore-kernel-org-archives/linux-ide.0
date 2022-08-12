Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E67BC00140
	for <linux-ide@archiver.kernel.org>; Fri, 12 Aug 2022 05:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbiHLF5y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 12 Aug 2022 01:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbiHLF5x (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 12 Aug 2022 01:57:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1629EA3D76
        for <linux-ide@vger.kernel.org>; Thu, 11 Aug 2022 22:57:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A23CC3F5DF;
        Fri, 12 Aug 2022 05:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660283871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzFVIpT6pGJop60ws3iwHT30ICvREhRWOtIk7FgnEkA=;
        b=XSd7Kd7r/qR/kpK8LQI5ylOmA4AB3piWxJ2EFvncsSu6/g6dsBqYpawtk1seHGh9DfT1Q8
        gmv29eoRu/qWZB+2kh3pRnrN6P9msuGEU4lfWjr3uYb8J1bE+lDoi+9Rsy9tbi5NpfrUDy
        Ir4aubC8BUZtQdHGiAf1gRyK1uXhrhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660283871;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzFVIpT6pGJop60ws3iwHT30ICvREhRWOtIk7FgnEkA=;
        b=JmwmUJdA2TCtgmgXAy9lJrgVZVI4bmMBdYcXveLG3Coh6d1X0qQG7o59+vVGFku9P0RgIW
        UItbMVerXJ/HsyCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87F6613305;
        Fri, 12 Aug 2022 05:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EYVFIN/r9WLVYgAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 12 Aug 2022 05:57:51 +0000
Message-ID: <4dda8ed9-43ca-b529-5cb8-2782a7a56808@suse.de>
Date:   Fri, 12 Aug 2022 07:57:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ata: libata-eh: Add missing command name
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20220811173157.472395-1-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220811173157.472395-1-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/11/22 19:31, Damien Le Moal wrote:
> Add the missing command name for ATA_CMD_NCQ_NON_DATA to
> ata_get_cmd_name().
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/libata-eh.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index ef4508d72c02..7c128c89b454 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2122,6 +2122,7 @@ const char *ata_get_cmd_name(u8 command)
>   		{ ATA_CMD_WRITE_QUEUED_FUA_EXT, "WRITE DMA QUEUED FUA EXT" },
>   		{ ATA_CMD_FPDMA_READ,		"READ FPDMA QUEUED" },
>   		{ ATA_CMD_FPDMA_WRITE,		"WRITE FPDMA QUEUED" },
> +		{ ATA_CMD_NCQ_NON_DATA,		"NCQ NON-DATA" },
>   		{ ATA_CMD_FPDMA_SEND,		"SEND FPDMA QUEUED" },
>   		{ ATA_CMD_FPDMA_RECV,		"RECEIVE FPDMA QUEUED" },
>   		{ ATA_CMD_PIO_READ,		"READ SECTOR(S)" },

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
