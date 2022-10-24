Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F578C3A59D
	for <linux-ide@archiver.kernel.org>; Mon, 24 Oct 2022 07:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJXHwl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Oct 2022 03:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJXHwj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2022 03:52:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BC658068
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 00:52:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EDB15219A1;
        Mon, 24 Oct 2022 07:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666597956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/GnWVa6+wdck212S9oIg3lKL9kyS2uis5kp0xRfxDw=;
        b=ru3tppEFKDTP6Rws59C5RD/21LIageoRTNlo3wVRMeqDwVQNxNQmIx8hGNLICIxtwtFTqT
        l7jZBI6LqnzMKubpNIBUrcqViLmJYJYIwNX9EwTArESMxs+JltkvwIImqm8Z9i3jrBZc8x
        pQjqd2yq1sGV6AWLvYQl2Fk48Ud9P/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666597956;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/GnWVa6+wdck212S9oIg3lKL9kyS2uis5kp0xRfxDw=;
        b=6jhAFwq0Yuw+aZeObeKw0zRNxSnpqbl0iA1kf8BD0lWNKnQwQslcbbTTCofmPHJTugxv4p
        7VeVUgE5sPwd12DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAB2F13A79;
        Mon, 24 Oct 2022 07:52:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5U5LNEREVmOWPAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 24 Oct 2022 07:52:36 +0000
Message-ID: <244d9dbe-a077-b927-b097-96535be21c0b@suse.de>
Date:   Mon, 24 Oct 2022 09:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/3] ata: libata: blacklist FUA support for known buggy
 drives
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
 <20221024072609.346502-3-damien.lemoal@opensource.wdc.com>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221024072609.346502-3-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/24/22 09:26, Damien Le Moal wrote:
> Thread [1] reported back in 2012 problems with enabling FUA for 3
> different drives. Add these drives to ata_device_blacklist[] to mark
> them with the ATA_HORKAGE_NO_FUA flag. To be conservative and avoid
> rpoblems on old systems, the model number for the three new entries
> are defined as to widely match all drives in the same product line.
> 
> [1]: https://lore.kernel.org/lkml/CA+6av4=uxu_q5U_46HtpUt=FSgbh3pZuAEY54J5_xK=MKWq-YQ@mail.gmail.com/
> 
> Suggested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/libata-core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 6008f7ed1c42..27aec8e63a8c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4128,6 +4128,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>   
>   	/* Buggy FUA */
>   	{ "Maxtor",		"BANC1G10",	ATA_HORKAGE_NO_FUA },
> +	{ "WDC*WD2500J*",	NULL,		ATA_HORKAGE_NO_FUA },
> +	{ "OCZ-VERTEX*",	NULL,		ATA_HORKAGE_NO_FUA },
> +	{ "INTEL*SSDSC2CT*",	NULL,		ATA_HORKAGE_NO_FUA },
>   
>   	/* End Marker */
>   	{ }
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

