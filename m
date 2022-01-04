Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F704C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 11:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiADLjS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:39:18 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53810 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiADLjR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 06:39:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CC3A01F37F;
        Tue,  4 Jan 2022 11:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641296356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3Gbz1VzwRM60XihAmJWq2oDR4EUcRE16VgjmDJP0bA=;
        b=10MMZy/AxEtvsQ79Fhb1fEkD5+9ERMbsiqaHDMze7l7wuI13c8cusIUWA7v9Kmo6zDYXRk
        LMD5Icdn0AKPOSY28JKFOrhovxvYWlBZ1PijsvmBej2FqV5fZWfY0kFFrjN+7IKqNfJoyk
        Ib4H1AOOp1crcFFPky/dEWV0BP3yjDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641296356;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3Gbz1VzwRM60XihAmJWq2oDR4EUcRE16VgjmDJP0bA=;
        b=hflhTDiABRh8j43q79LEOetT7/DhsfTdRsQ2aeoBCpWYg4Y1x8IbgL7ndKecpWvoFEzQFu
        TPFitVBIHzxsWADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3E1113AE1;
        Tue,  4 Jan 2022 11:39:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id URakL+Qx1GH5PgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Jan 2022 11:39:16 +0000
Subject: Re: [PATCH v2 17/22] ata: pata_legacy: add compile test support
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-18-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0577115c-d5df-7f77-96e0-9d54785a501e@suse.de>
Date:   Tue, 4 Jan 2022 12:39:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220104105843.1730172-18-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 11:58 AM, Damien Le Moal wrote:
> Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
> configs that do not enable ISA.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 59576f92c730..490f0856a271 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1137,7 +1137,7 @@ config PATA_OF_PLATFORM
>  
>  config PATA_QDI
>  	tristate "QDI VLB PATA support"
> -	depends on ISA
> +	depends on ISA || COMPILE_TEST
>  	select PATA_LEGACY
>  	help
>  	  Support for QDI 6500 and 6580 PATA controllers on VESA local bus.
> @@ -1172,7 +1172,7 @@ config PATA_SAMSUNG_CF
>  
>  config PATA_WINBOND_VLB
>  	tristate "Winbond W83759A VLB PATA support (Experimental)"
> -	depends on ISA
> +	depends on ISA || COMPILE_TEST
>  	select PATA_LEGACY
>  	help
>  	  Support for the Winbond W83759A controller on Vesa Local Bus
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
