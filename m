Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD9CC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 06:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbiDYGr0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Apr 2022 02:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbiDYGrN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Apr 2022 02:47:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE04B33EAD;
        Sun, 24 Apr 2022 23:44:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CAB0210F3;
        Mon, 25 Apr 2022 06:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650869046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AzFUCTouMzGK1LvggZxibKpXYFAUXPi7HtPz//nN0kE=;
        b=yqy/e06AwAjELWmwL/ConAvSCSNxi8zdvZ8PUeKkDGWj/4Idcmsmh0MHsVBpNOv2gG+vBw
        iaIxViiT1dEX/vF4bSRdeHDJLoodzhUpsXR2zLuumLpGyUa/fa1mM4DPK8Z+OGBCUZg5Qj
        Vva7bStKuMg7k+shunhkTw5Oi+j96Hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650869046;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AzFUCTouMzGK1LvggZxibKpXYFAUXPi7HtPz//nN0kE=;
        b=LI7aCPOWQYTzX/uBFlZhkXqDMhytbozF9lHac/sjS4IBRjsGDwLMPsET+xd2TDiIjNgEbM
        LcmPSOXhd9ciuBAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5254513AE1;
        Mon, 25 Apr 2022 06:44:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GtZXETZDZmIeUgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 25 Apr 2022 06:44:06 +0000
Message-ID: <a884fec0-7ef7-6b89-f445-356d86999647@suse.de>
Date:   Mon, 25 Apr 2022 08:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20220425013417.3947791-1-damien.lemoal@opensource.wdc.com>
 <20220425013417.3947791-5-damien.lemoal@opensource.wdc.com>
 <b64df936-681c-c88e-9f44-ab71e810584f@suse.de>
 <71a4a301-ca96-e1a3-aeee-fd69b8f1eb7b@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 4/5] ata: libata-core: Allow forcing most horkage flags
In-Reply-To: <71a4a301-ca96-e1a3-aeee-fd69b8f1eb7b@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/25/22 08:15, Damien Le Moal wrote:
> On 4/25/22 15:00, Hannes Reinecke wrote:
>> On 4/25/22 03:34, Damien Le Moal wrote:
>>> To facilitate debugging of drive issues in the field without kernel
>>> changes (e.g. temporary test patches), add an entry for most horkage
>>> flags in the force_tbl array to allow controlling these horkage
>>> settings with the libata.force kernel boot parameter.
>>>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> ---
>>>    drivers/ata/libata-core.c | 22 ++++++++++++++++++++--
>>>    1 file changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index e5a0e73b39d3..f68cb5639ec4 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -6230,9 +6230,27 @@ static const struct ata_force_param force_tbl[] __initconst = {
>>>    	force_horkage_onoff(ncqtrim,	ATA_HORKAGE_NO_NCQ_TRIM),
>>>    	force_horkage_onoff(ncqati,	ATA_HORKAGE_NO_NCQ_ON_ATI),
>>>    
>>> -	force_horkage_on(dump_id,	ATA_HORKAGE_DUMP_ID),
>>> +	force_horkage_onoff(trim,	ATA_HORKAGE_NOTRIM),
>>> +	force_horkage_on(trim_zero,	ATA_HORKAGE_ZERO_AFTER_TRIM),
>>> +	force_horkage_on(max_trim_128m, ATA_HORKAGE_MAX_TRIM_128M),
>>> +
>>> +	force_horkage_onoff(dma,	ATA_HORKAGE_NODMA),
>>>    	force_horkage_on(atapi_dmadir,	ATA_HORKAGE_ATAPI_DMADIR),
>>> -	force_horkage_on(disable,	ATA_HORKAGE_DISABLE)
>>> +	force_horkage_on(atapi_mod16_dma, ATA_HORKAGE_ATAPI_MOD16_DMA),
>>> +
>>> +	force_horkage_onoff(dmalog,	ATA_HORKAGE_NO_DMA_LOG),
>>> +	force_horkage_onoff(iddevlog,	ATA_HORKAGE_NO_ID_DEV_LOG),
>>> +	force_horkage_onoff(logdir,	ATA_HORKAGE_NO_LOG_DIR),
>>> +
>>> +	force_horkage_on(max_sec_128,	ATA_HORKAGE_MAX_SEC_128),
>>> +	force_horkage_on(max_sec_1024,	ATA_HORKAGE_MAX_SEC_1024),
>>> +	force_horkage_on(max_sec_lba48,	ATA_HORKAGE_MAX_SEC_LBA48),
>>> +
>>> +	force_horkage_onoff(lpm,	ATA_HORKAGE_NOLPM),
>>> +	force_horkage_onoff(setxfer,	ATA_HORKAGE_NOSETXFER),
>>> +	force_horkage_on(dump_id,	ATA_HORKAGE_DUMP_ID),
>>> +
>>> +	force_horkage_on(disable,	ATA_HORKAGE_DISABLE),
>>
>> ... and this exemplifies my concerns with the 'onoff' mechanism:
>> Why is 'disable' just marked as 'on' ?
> 
> Yeah, I can add the off side of it too. Fairly useless though as these are
> off by default, except for the few cases where we already know that the
> flag is needed, in which case turning it off would be a bad idea. So I do
> not allow it by having the "on" only.
> 
>> Sure we can set it to 'off' (we have to, otherwise that flag would
>> always be set). And if we can set it to 'off', where's the different to
>> 'onoff' ?
> 
> Because of the reversed definition of the flag. E.g. nodmalog means *set*
> ATA_HORKAGE_NO_DMA_LOG flags. so the "no" option means set. If we add the
> off version for non reversed flags, then the "no" option would clear the
> flag, not set it. It is a mess. That is the cleanest way I could think of
> without making things even more messy.
> 
> At best, we can allow everything to be set/cleared using 2 macros:
> onoff and offon, depending on the flag meaning polarity (i.e. a NO flag or
> not).
> 

Hmm. Yeah, I see. Ugly, but probably the easiest for now.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
