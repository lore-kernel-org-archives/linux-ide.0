Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C61C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 27 Jan 2022 08:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbiA0IFN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Jan 2022 03:05:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55172 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbiA0IFM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jan 2022 03:05:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7047521983;
        Thu, 27 Jan 2022 08:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643270711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9l1h3lq4RKYA9+5FOuAG+DckwzizwC9KWPouUW+gV1M=;
        b=doxiVjZZ+d8IEGYcXbMmOfIUPkoz3931TbmGgxuWD99WuP7BbAVt5AQB5w+Sh5hWAysd5j
        h/HL95Y0WGu8X9GZtDjISBUlb2gW/ez6aFOCVajTlGg7WDQaMwZNfrCqG1ZitgJP/302An
        clfTzabj1QVfL5pEYoluI6Yu04bC2Mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643270711;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9l1h3lq4RKYA9+5FOuAG+DckwzizwC9KWPouUW+gV1M=;
        b=bDrXTjUzmdmxbX1DkgQtIK0wX3kNDF1K/3NfAnFFDK6NQxGEkY3HUiR4o+O0OUr64gfo86
        qmpjAgDlrZuXebCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43C0013F69;
        Thu, 27 Jan 2022 08:05:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CmeyDzdS8mG6FgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 27 Jan 2022 08:05:11 +0000
Message-ID: <5af2c2b5-0090-842f-4580-acaa186920d7@suse.de>
Date:   Thu, 27 Jan 2022 09:05:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/3] ata: libata-scsi: Cleanup ata_get_xlat_func()
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
References: <20220127072919.139615-1-damien.lemoal@opensource.wdc.com>
 <20220127072919.139615-2-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220127072919.139615-2-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/27/22 08:29, Damien Le Moal wrote:
> Remove the unnecessary "break" after the return statement in the
> MODE_SELECT/MODE_SELECT_10 case.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/libata-scsi.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index ed8be585a98f..c73e94c06147 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3933,7 +3933,6 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
>   	case MODE_SELECT:
>   	case MODE_SELECT_10:
>   		return ata_scsi_mode_select_xlat;
> -		break;
>   
>   	case ZBC_IN:
>   		return ata_scsi_zbc_in_xlat;

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
