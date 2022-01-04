Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBE3C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 11:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiADLcA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:32:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52080 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiADLb7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 06:31:59 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C1E3821129;
        Tue,  4 Jan 2022 11:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641295918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CHevrVLPTAs4T8ihNw5+8JfNkoj5jUO4Tfjviibvp+Y=;
        b=et4nQLN5EPuvKft01mStv3W6IvuhrjgFb96x+TI/aI15n9M2nqJIrjridhOIQbFRm6Sc8g
        /mDEKe3AJIEYpSVQtmm7iFsVuQjNm1xv5MlS4uhbtRUPc94pjpLVrKJ53ZRJs2U0ZUBBIa
        TJOzMdZ4ubPFsPUBW3T5HbDZBV+LwT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641295918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CHevrVLPTAs4T8ihNw5+8JfNkoj5jUO4Tfjviibvp+Y=;
        b=0Ejcfu5DRg2PUe+WwRJkfm2BEQ5GuV+bv2TJEQhcMD8PwyxPsMLx/R4SMKB8jDeZenRpG/
        BV3OcXABevJCVRDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B778713ADF;
        Tue,  4 Jan 2022 11:31:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N1dzLC4w1GG/OwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Jan 2022 11:31:58 +0000
Subject: Re: [PATCH v2 12/22] ata: pata_bk3710: add compile test support
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-13-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <aa5340ac-469d-4dc1-4ad4-b70a5f4bd684@suse.de>
Date:   Tue, 4 Jan 2022 12:31:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220104105843.1730172-13-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 11:58 AM, Damien Le Moal wrote:
> Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
> configs that do not enable ARCH_DAVINCI.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 8df5b32e6879..b706a3a64b11 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -616,7 +616,7 @@ config PATA_ATP867X
>  
>  config PATA_BK3710
>  	tristate "Palmchip BK3710 PATA support"
> -	depends on ARCH_DAVINCI
> +	depends on ARCH_DAVINCI || COMPILE_TEST
>  	select PATA_TIMINGS
>  	help
>  	  This option enables support for the integrated IDE controller on
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
