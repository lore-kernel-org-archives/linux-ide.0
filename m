Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0886FC4332F
	for <linux-ide@archiver.kernel.org>; Fri, 21 Oct 2022 06:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJUGWK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Oct 2022 02:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJUGWJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2022 02:22:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7866228CCB
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 23:22:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 797A61F893;
        Fri, 21 Oct 2022 06:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666333327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TbOEm2uR/wuFrdjY+f/XZJg6lRY+4M19BvGFELagJ+s=;
        b=a+Y0g/QeOs0zjGt9sRAxpvS49DqNERHOytyx0J/J5wBmexCUTwGqmjlXLqoUPSul30aJl0
        OhVGt5oubxHrWL5X9RiMbrDOSYy//yUuAKCzy6MebXBw2gJHItBxxf+FWRY5GmdTH8Jxyh
        yTGakW/4vPcsIMHMFejjyByR3mYQu/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666333327;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TbOEm2uR/wuFrdjY+f/XZJg6lRY+4M19BvGFELagJ+s=;
        b=VhqW4qnay+0E9dBeqo15ml25lrVKpGWcRZ4vcuTQrFsKkzVNC64uhPCW+MevwNQ1d9k2g5
        TCd0B6uXIrnHJeBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FE481331A;
        Fri, 21 Oct 2022 06:22:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RvpkFo86UmPbDwAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 21 Oct 2022 06:22:07 +0000
Message-ID: <2d1f1e3b-8e91-271a-3da3-fd640cdf3188@suse.de>
Date:   Fri, 21 Oct 2022 08:22:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] ata: libata: Enable fua support by default
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
 <20221021053809.237651-4-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221021053809.237651-4-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/21/22 07:38, Damien Le Moal wrote:
> Change the default value of the fua module parameter to 1 to enable fua
> support by default for all devices supporting it. This parameter
> description is also updated to indicate it is deprecated and that
> libata.force=[no]fua should be used to control fua support.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/libata-core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 1bb9616b10d9..140e7e7d7833 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -127,9 +127,9 @@ int atapi_passthru16 = 1;
>   module_param(atapi_passthru16, int, 0444);
>   MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
>   
> -int libata_fua = 0;
> +int libata_fua = 1;
>   module_param_named(fua, libata_fua, int, 0644);
> -MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
> +MODULE_PARM_DESC(fua, "FUA support (0=off, 1=on [default])");
>   
>   static int ata_ignore_hpa;
>   module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

