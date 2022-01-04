Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB96C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 11:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiADLkM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:40:12 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53880 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiADLkM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 06:40:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D0B71F386;
        Tue,  4 Jan 2022 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641296411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5+lGZGH3DxJhlGcbR5d78WZvGy+BJrXBQ1j1DZopQ4=;
        b=Lb/nBDwYVV3zF7eRj/+sCr+2ymiH+vN2Y5ymB7dALfAfpsxuss2/SuJdt+LxWEKIgHtS9r
        fgD1OpS7ENyNtDBGhU2aJiCsjZUedZ1r8k+Ng2Pp2pLXsFJLV8sGJHSo7q9rpFrifsXaU7
        ARLGWXUjyBug/KSO6ELUCdI3wyExpiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641296411;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5+lGZGH3DxJhlGcbR5d78WZvGy+BJrXBQ1j1DZopQ4=;
        b=Q36Anr3qQbMrYLKlooLAsHMFyGcif6+bpDGjGxKjXsuZR+6MR5Atcvmrtw+DM8kUYjt7eg
        c/Q0PmZAoO+9f1DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 541C313AF4;
        Tue,  4 Jan 2022 11:40:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kBI5FBsy1GF0PwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Jan 2022 11:40:11 +0000
Subject: Re: [PATCH v2 18/22] ata: pata_samsung_cf: add compile test support
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-19-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3038ba52-6690-da93-c017-ad02ce55cb78@suse.de>
Date:   Tue, 4 Jan 2022 12:40:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220104105843.1730172-19-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 11:58 AM, Damien Le Moal wrote:
> Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
> configs that do not enable SAMSUNG_DEV_IDE.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 490f0856a271..8af5659a7676 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1162,7 +1162,7 @@ config PATA_RZ1000
>  
>  config PATA_SAMSUNG_CF
>  	tristate "Samsung SoC PATA support"
> -	depends on SAMSUNG_DEV_IDE
> +	depends on SAMSUNG_DEV_IDE || COMPILE_TEST
>  	select PATA_TIMINGS
>  	help
>  	  This option enables basic support for Samsung's S3C/S5P board
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
