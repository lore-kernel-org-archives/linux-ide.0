Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3D3C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 11:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiADLbn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:31:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53402 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiADLbm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 06:31:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE6531F397;
        Tue,  4 Jan 2022 11:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641295901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSwyx0+FMLd2lc3x7uXvaOAmwDfymChd72thV6nagro=;
        b=D7kQHEnIk3qaogfPZO4Ufhk+1dfdkCHfPC/ZjW1EVSWMXV5KQ17aWk6Wy/+GMZLwcZq+mG
        S5FTSyk5BgBaWJBj8ppehTF5muCpREoRliuOf7ITWXCmWZ1bhGXJ0tmp+bCzR28IEsZamY
        Sl0X0qkIxVCfXRqrQwwdfGCIpITP5Kw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641295901;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSwyx0+FMLd2lc3x7uXvaOAmwDfymChd72thV6nagro=;
        b=vawmbfQGhrsT8A7ZwndfNKtDCZ2y6GqsElFfMBkSbNU3FEGFlY0tt/dRlzlUCNLuIGD5OI
        Pqks5IOscSiE/iDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A497B13ADF;
        Tue,  4 Jan 2022 11:31:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +pXgJx0w1GGpOwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Jan 2022 11:31:41 +0000
Subject: Re: [PATCH v2 11/22] ata: ahci_seattle: add compile test support
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-12-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b9623119-f359-886e-e218-9ecf2fffb3ef@suse.de>
Date:   Tue, 4 Jan 2022 12:31:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220104105843.1730172-12-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 11:58 AM, Damien Le Moal wrote:
> Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
> configs that do not enable ARCH_SEATTLE.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 1be6a14e46e1..8df5b32e6879 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -311,7 +311,7 @@ config SATA_GEMINI
>  
>  config SATA_AHCI_SEATTLE
>  	tristate "AMD Seattle 6.0Gbps AHCI SATA host controller support"
> -	depends on ARCH_SEATTLE
> +	depends on ARCH_SEATTLE || COMPILE_TEST
>  	select SATA_HOST
>  	help
>  	 This option enables support for AMD Seattle SATA host controller.
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
