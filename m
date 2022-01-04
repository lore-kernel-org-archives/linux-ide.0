Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96E5C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 11:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiADLfM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:35:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52108 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiADLfL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 06:35:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B596121129;
        Tue,  4 Jan 2022 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641296110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7an/joI4LaLJSCaW3Sdfsyj/2hsd8Vv+PIdXtmz+IbU=;
        b=BSppAhSiaqzdYULVsoKKhLBjGoRpePUG9XVMwV4u0Y8l726RprW8MBK9NRhVJWCk8PsPSC
        7fW/LGePWrPJd1TQfc7/xD7sdFFoQ57hLAyiPaNJMI1ThzRCsIQY51fGVLw70wRzT8x2Jz
        gVU/MVJ6HislKcMCy7sjwCVAIppanqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641296110;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7an/joI4LaLJSCaW3Sdfsyj/2hsd8Vv+PIdXtmz+IbU=;
        b=kfDp7LuiE2DvF1+0zRtOKBAAqFvSfPyj00yOGGp238Hz5GlwDpcARI5rcBLiwHJj/rYBz9
        3z5OXsbcqleyTsBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB18113AE1;
        Tue,  4 Jan 2022 11:35:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a8xsKe4w1GEKPQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Jan 2022 11:35:10 +0000
Subject: Re: [PATCH v2 13/22] ata: pata_cs5535: add compile test support
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-14-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <fb93163c-0f17-a817-b6ce-f101bc585011@suse.de>
Date:   Tue, 4 Jan 2022 12:35:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220104105843.1730172-14-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 11:58 AM, Damien Le Moal wrote:
> Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
> configs that do not have X86_32 enabled.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index b706a3a64b11..daf57a4e8196 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -654,7 +654,7 @@ config PATA_CS5530
>  
>  config PATA_CS5535
>  	tristate "CS5535 PATA support (Experimental)"
> -	depends on PCI && X86_32
> +	depends on PCI && (X86_32 || COMPILE_TEST)
>  	help
>  	  This option enables support for the NatSemi/AMD CS5535
>  	  companion chip used with the Geode processor family.
> 
Looks weird, but seems to be de rigeur in ata/Kconfig.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
