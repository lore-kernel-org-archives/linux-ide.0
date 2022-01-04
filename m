Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC5AC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 11:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiADLaI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:30:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51924 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiADLaI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 06:30:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 81A57212B9;
        Tue,  4 Jan 2022 11:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641295807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYvDwlx47h3O8thtO6YZ+gnSFFKvYf5qHBFQ+VbClKU=;
        b=ACiM4JrBaKc53eev5Aqo4c/kkv3dq41iI0dR2rlm/XgD321tZ1VXyFU06FVgthImeqrvwN
        Jb811J5LgllaEDaJ99JbHQz+0fyMf8FmxgaGseHYG9QckQ/7NOO2yOtBKIi72DKyBuqJQH
        pasDxQs0F5MmI+I9pMhPBzEMrIXhHfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641295807;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYvDwlx47h3O8thtO6YZ+gnSFFKvYf5qHBFQ+VbClKU=;
        b=gOyPAoznYnaNySh3m14ovFTApJSxcsnH+qqE2a4C61gj/xLWQNlVeOoT/vUcyumlySEPw3
        XnbTyIGUgZp1ipAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7615113ADF;
        Tue,  4 Jan 2022 11:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KE2JHL8v1GHjOgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Jan 2022 11:30:07 +0000
Subject: Re: [PATCH v2 06/22] ata: ahci_mtk: add compile test support
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-7-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <4849670b-a18e-7657-80ca-ca23fecdeca1@suse.de>
Date:   Tue, 4 Jan 2022 12:30:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220104105843.1730172-7-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 11:58 AM, Damien Le Moal wrote:
> Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
> configs that do not enable ARCH_MEDIATEK.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 83fac101744c..1545201b9104 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -223,7 +223,7 @@ config AHCI_CEVA
>  
>  config AHCI_MTK
>  	tristate "MediaTek AHCI SATA support"
> -	depends on ARCH_MEDIATEK
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
>  	select MFD_SYSCON
>  	select SATA_HOST
>  	help
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
