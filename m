Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAF0C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 11:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiADL25 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:28:57 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51834 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiADL24 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 06:28:56 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C748C21129;
        Tue,  4 Jan 2022 11:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641295735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYnSuFL3f4JgxgjUw+unO/SKQe8/yyMiXI1efIodQV0=;
        b=UeaUKVPQFbagSyvSCCZLSEzNy/3VEBys9E8YT8VLFicfxV37CK0uINrxJ4aSiVNThm/s5E
        Q4FqeuFPW8OFNeAAWCoNoFHBf5zDce7INiODvyMxEji2dtWJFHPHIR7em+2UBY68quBrgq
        LtcLc0EtOmueL2K5+MgcwLxymUPv1fA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641295735;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYnSuFL3f4JgxgjUw+unO/SKQe8/yyMiXI1efIodQV0=;
        b=kpKz/GsdcNv1jIrBcshOy9L5s1AUwYQFpxRHjm8H7M9rEHZsf5me4mhng++q5QWaJgs/58
        4uWXqPgpklhUjOCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC80613ADF;
        Tue,  4 Jan 2022 11:28:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lWWmLXcv1GE1OgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Jan 2022 11:28:55 +0000
Subject: Re: [PATCH v2 02/22] ata: ahci_brcm: add compile test support
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-3-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <575f24a4-a237-cedb-62bd-bc9fc5d341b8@suse.de>
Date:   Tue, 4 Jan 2022 12:28:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220104105843.1730172-3-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 11:58 AM, Damien Le Moal wrote:
> Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
> configs that do not enable ARCH_BRCMSTB, BMIPS_GENERIC or ARCH_BCM_XXX.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 80bad7cba631..3bf38a328851 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -163,7 +163,7 @@ config SATA_AHCI_PLATFORM
>  config AHCI_BRCM
>  	tristate "Broadcom AHCI SATA support"
>  	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_NSP || \
> -		   ARCH_BCM_63XX
> +		   ARCH_BCM_63XX || COMPILE_TEST
>  	select SATA_HOST
>  	help
>  	  This option enables support for the AHCI SATA3 controller found on
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
