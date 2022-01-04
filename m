Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3231C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 11:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiADL2b (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:28:31 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53170 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiADL21 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 06:28:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0485F1F386;
        Tue,  4 Jan 2022 11:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641295706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a00ye2NTZAaU7LSq8Np+tTVvgWheInIm94irYNHhGI8=;
        b=iYDDwPr5Xo/x+J4cLw97Iav2ho5C+biTGjBykSVBQYoKH6P3j9VOKic9ZDrzCercUCiHpm
        Bkqsw0pHxpMsK3RsbcOUB0K8tfBODTJOV1NFcIHuNGMSaL6OzrcDef964bZeav4aVak92x
        d85s6qhTK0L38MkR1TjCkGGJ72O7guM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641295706;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a00ye2NTZAaU7LSq8Np+tTVvgWheInIm94irYNHhGI8=;
        b=WHYyCiaOEj+628B2U11hL0UxKdmkMcpY7YH96GDEmKow7a7PfnVOAPp7/qj5BEW95bv25P
        MhRDkbMXiM1iu8Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2C0D13ADF;
        Tue,  4 Jan 2022 11:28:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mTYXN1kv1GEEOgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Jan 2022 11:28:25 +0000
Subject: Re: [PATCH v2 01/22] ata: sata_fsl: add compile test support
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-2-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5f927de0-ec57-a652-80c8-378bfaf4a625@suse.de>
Date:   Tue, 4 Jan 2022 12:28:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220104105843.1730172-2-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 11:58 AM, Damien Le Moal wrote:
> Add dependendy on COMPILE_TEST to allow compile tests with configs that
> do not enable FSL_SOC.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 9ebaa3c288dd..80bad7cba631 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -290,7 +290,7 @@ config AHCI_QORIQ
>  
>  config SATA_FSL
>  	tristate "Freescale 3.0Gbps SATA support"
> -	depends on FSL_SOC
> +	depends on FSL_SOC || COMPILE_TEST
>  	select SATA_HOST
>  	help
>  	  This option enables support for Freescale 3.0Gbps SATA controller.
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
