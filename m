Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4687BC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 05:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiDYFyk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Apr 2022 01:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiDYFyi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Apr 2022 01:54:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A04335852;
        Sun, 24 Apr 2022 22:51:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E8EE01F37D;
        Mon, 25 Apr 2022 05:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650865893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ok4WznvDcU1k0vaMviarc55AZcILNCW58EJ2kH/3m3s=;
        b=x/JryM1r/cMKeAp8RvL+Nkam5YEAmOrjO1gdxHEnqmzkjpeWUgK8z5MuOZq+ekNtc/cEMn
        1JnKNO3rJ5adcegEe8468RXtLBxZG90W7grMX0OZXSyCwvS9zlOP6SFI4wdZCvMhB74jv+
        SgvyZO1ad8vtQvKR8F9EgCMNcicnIBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650865893;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ok4WznvDcU1k0vaMviarc55AZcILNCW58EJ2kH/3m3s=;
        b=hc8P/0f+j3q9fAPkPuQHJN3gQpCLKuosFbbPOAOEYX/3z5TiZQpfC3CEHXQKcAaXKpAbXu
        d/qZCIDDrfvoZRAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF96113780;
        Mon, 25 Apr 2022 05:51:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2rxtKeU2ZmK0RAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 25 Apr 2022 05:51:33 +0000
Message-ID: <89bf1477-516c-917e-9dba-d971a087f5f9@suse.de>
Date:   Mon, 25 Apr 2022 07:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 2/5] ata: libata-core: Refactor force_tbl definition
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20220425013417.3947791-1-damien.lemoal@opensource.wdc.com>
 <20220425013417.3947791-3-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220425013417.3947791-3-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/25/22 03:34, Damien Le Moal wrote:
> Introduce the macro definitions force_cbl(), force_spd_limit(),
> force_xfer(), force_lflag(), force_horkage_on() and
> force_horkage_onoff() to define with a more compact syntax the struct
> ata_force_param entries in the force_tbl array defined in the function
> ata_parse_force_one().
> 
> To reduce the indentation of the array declaration, force_tbl definition
> is also moved out of the ata_parse_force_one() function. The entries are
> also reordered to group them by type of the quirck that is applied.
> 
> Finally, fix a comment in ata_parse_force_param() incorrectly
> referencing force_tbl instead of ata_force_tbl.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
>   drivers/ata/libata-core.c | 139 ++++++++++++++++++++++----------------
>   1 file changed, 81 insertions(+), 58 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
