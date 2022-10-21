Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F21C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 21 Oct 2022 06:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJUGV1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Oct 2022 02:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJUGV0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2022 02:21:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1BF226E7D
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 23:21:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C798722C5F;
        Fri, 21 Oct 2022 06:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666333283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cqxU5rD3gvrFOHlZWZ2f+zXfyJC4FcxFtcnEHRtxGNc=;
        b=cYOS5ZhZPVXwojBrFzhON/bFgYrEbW+GpvavCwDGdX1kSWZO47hBT1USbb0vP+ByQlDaBy
        C3iFwu6VUf4689fDm4+kt6S18/bB5pa7Q/H3UpY6W0j1m37niCQ78SCscXNQWGjJ04/WWa
        mO6w6p5gp8RxDvKCErsByjrGxEJJiGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666333283;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cqxU5rD3gvrFOHlZWZ2f+zXfyJC4FcxFtcnEHRtxGNc=;
        b=MHOnmpf0wBL4Rob132V2O4nUrSPyjzwOhKN7P9j4Zy+iPKHLGPFR0S/Xc8Nqz2rWJc/Gvi
        YinW+rlW6LPCaXAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99D2E1331A;
        Fri, 21 Oct 2022 06:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ihrFImM6UmOHDwAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 21 Oct 2022 06:21:23 +0000
Message-ID: <c1fc6322-d6d4-4579-1281-130e0546883b@suse.de>
Date:   Fri, 21 Oct 2022 08:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/3] ata: libata: allow toggling fua parameter at runtime
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
 <20221021053809.237651-3-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221021053809.237651-3-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/21/22 07:38, Damien Le Moal wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Currently, the libata.fua parameter isn't runtime-writable, so a
> system restart is required in order to toggle it.
> This unnecessarily complicates testing how drives behave with FUA on and
> off.
> 
> Let's make this parameter R/W instead, like many others in the kernel.
> 
> Example usage:
> Disable the parameter:
> echo 0 >/sys/module/libata/parameters/fua
> 
> Revalidate disk cache settings:
> F=/sys/class/scsi_disk/0\:0\:0\:0/cache_type; echo `cat $F` >$F
> 
> [Damien]
> Enabling fua support by setting libata.fua to 1 will have no effect if
> the libata module is loaded with libata.force=[ID]nofua, which disables
> fua support for the ata device(s) identified with ID or all ata devices
> if no ID is specified.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/libata-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 6008f7ed1c42..1bb9616b10d9 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -128,7 +128,7 @@ module_param(atapi_passthru16, int, 0444);
>   MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
>   
>   int libata_fua = 0;
> -module_param_named(fua, libata_fua, int, 0444);
> +module_param_named(fua, libata_fua, int, 0644);
>   MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
>   
>   static int ata_ignore_hpa;
Hmm. I guess you'll need to revalidate the drive when changing that; but 
this can be done in a later patch.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

