Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE184C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 06:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiDYGN7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Apr 2022 02:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiDYGN4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Apr 2022 02:13:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E9A3A73E;
        Sun, 24 Apr 2022 23:10:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D8921F37D;
        Mon, 25 Apr 2022 06:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650867051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACDWi+HZXq+GD9B+UOultTxflFHqIy8rAZAnx6UeF2c=;
        b=OupT5VFdpE8CryhSF+5BdgtWsFc4bFxeBWe1FvoJRjMSRPr7ZPlaikjHhHvPEWdLt+eVnT
        vc9hVl1QtSDUmGPhjIv8zSod0TGG/2OGSl8kmwGtNraFV1Nh0/yQO39d3qZvg9YuW9H6UN
        oEbrfm7F5iZaSxJqM2pvc54ZKJJ9oKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650867051;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACDWi+HZXq+GD9B+UOultTxflFHqIy8rAZAnx6UeF2c=;
        b=io6eTgfj9MhHsl/1vMNHK6+nIZOV4BukyDxTTpnK+LhAfPBe28AY8Tj53/zPo6jTp3ojvP
        yYJiHJ5Z9SuSriDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38BE813AED;
        Mon, 25 Apr 2022 06:10:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KoHHC2s7ZmLKSQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 25 Apr 2022 06:10:51 +0000
Message-ID: <b7c875e8-0870-8795-fc78-671387a66b69@suse.de>
Date:   Mon, 25 Apr 2022 08:10:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 3/5] ata: libata-core: Improve link flags forced
 settings
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20220425013417.3947791-1-damien.lemoal@opensource.wdc.com>
 <20220425013417.3947791-4-damien.lemoal@opensource.wdc.com>
 <21b1ef5b-aaf6-6baa-6580-52f3c35d2d67@suse.de>
 <f1185514-a4de-5430-b4a0-b172e22009e8@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <f1185514-a4de-5430-b4a0-b172e22009e8@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/25/22 08:08, Damien Le Moal wrote:
> On 4/25/22 14:56, Hannes Reinecke wrote:
>> On 4/25/22 03:34, Damien Le Moal wrote:
>>> Similarly to the horkage flags, introduce the force_lflag_onoff() macro
>>> to define struct ata_force_param entries of the force_tbl array that
>>> allow turning on or off a link flag using the libata.force boot
>>> parameter. To be consistent with naming, the macro force_lflag() is
>>> renamed to force_lflag_on().
>>>
>>> Using force_lflag_onoff(), define a new force_tbl entry for the
>>> ATA_LFLAG_NO_DEBOUNCE_DELAY link flag, thus allowing testing if an
>>> adapter requires a link debounce delay or not.
>>>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> ---
>>>    drivers/ata/libata-core.c | 32 ++++++++++++++++++++++----------
>>>    1 file changed, 22 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index dfdb23c2bbd6..e5a0e73b39d3 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -96,7 +96,8 @@ struct ata_force_param {
>>>    	unsigned long	xfer_mask;
>>>    	unsigned int	horkage_on;
>>>    	unsigned int	horkage_off;
>>> -	u16		lflags;
>>> +	u16		lflags_on;
>>> +	u16		lflags_off;
>>>    };
>>>    
>>>    struct ata_force_ent {
>>> @@ -386,11 +387,17 @@ static void ata_force_link_limits(struct ata_link *link)
>>>    		}
>>>    
>>>    		/* let lflags stack */
>>> -		if (fe->param.lflags) {
>>> -			link->flags |= fe->param.lflags;
>>> +		if (fe->param.lflags_on) {
>>> +			link->flags |= fe->param.lflags_on;
>>>    			ata_link_notice(link,
>>>    					"FORCE: link flag 0x%x forced -> 0x%x\n",
>>> -					fe->param.lflags, link->flags);
>>> +					fe->param.lflags_on, link->flags);
>>> +		}
>>> +		if (fe->param.lflags_off) {
>>> +			link->flags &= ~fe->param.lflags_off;
>>> +			ata_link_notice(link,
>>> +				"FORCE: link flag 0x%x cleared -> 0x%x\n",
>>> +				fe->param.lflags_off, link->flags);
>>>    		}
>>>    	}
>>>    }
>>> @@ -6153,8 +6160,12 @@ EXPORT_SYMBOL_GPL(ata_platform_remove_one);
>>>    #define force_xfer(mode, shift)				\
>>>    	{ #mode,	.xfer_mask	= (1UL << (shift)) }
>>>    
>>> -#define force_lflag(name, flags)			\
>>> -	{ #name,	.lflags		= (flags) }
>>> +#define force_lflag_on(name, flags)			\
>>> +	{ #name,	.lflags_on	= (flags) }
>>> +
>>> +#define force_lflag_onoff(name, flags)			\
>>> +	{ "no" #name,	.lflags_on	= (flags) },	\
>>> +	{ #name,	.lflags_off	= (flags) }
>>>    
>>>    #define force_horkage_on(name, flag)			\
>>>    	{ #name,	.horkage_on	= (flag) }
>>> @@ -6209,10 +6220,11 @@ static const struct ata_force_param force_tbl[] __initconst = {
>>>    	force_xfer(udma/133,		ATA_SHIFT_UDMA + 6),
>>>    	force_xfer(udma7,		ATA_SHIFT_UDMA + 7),
>>>    
>>> -	force_lflag(nohrst,		ATA_LFLAG_NO_HRST),
>>> -	force_lflag(nosrst,		ATA_LFLAG_NO_SRST),
>>> -	force_lflag(norst,		ATA_LFLAG_NO_HRST | ATA_LFLAG_NO_SRST),
>>> -	force_lflag(rstonce,		ATA_LFLAG_RST_ONCE),
>>> +	force_lflag_on(nohrst,		ATA_LFLAG_NO_HRST),
>>> +	force_lflag_on(nosrst,		ATA_LFLAG_NO_SRST),
>>> +	force_lflag_on(norst,		ATA_LFLAG_NO_HRST | ATA_LFLAG_NO_SRST),
>>> +	force_lflag_on(rstonce,		ATA_LFLAG_RST_ONCE),
>>> +	force_lflag_onoff(dbdelay,	ATA_LFLAG_NO_DEBOUNCE_DELAY),
>>>    
>>>    	force_horkage_onoff(ncq,	ATA_HORKAGE_NONCQ),
>>>    	force_horkage_onoff(ncqtrim,	ATA_HORKAGE_NO_NCQ_TRIM),
>>
>> Hmm.
>>
>> Personally, I'm not a fan of distinct 'flags_on' and 'flags_off'; I
>> always wonder what does happen if one sets the same value for both ...
> 
> Problem is that when parsing the options and gathering the horkages/flags
> about the drive, nothing is known about it yet, so we do not have the link
> flags to directly modify based on the option name. So we have to keep the
> information about which flag to set and which to reset. Generating a
> "flags_mask" variable with all the correct flags set based on the option
> is easy, but we still need to know the operation to do with that mask on
> the device/link flags.
> 
>>
>> And do we really need this? All settings above are just simple flags
>> which can be set or unset.
>> Sure, some flags are inverted, but still they are flags.
>> So why do we need the separation here?
>> Isn't it rather cosmetical?
> 
> For the existing libata.force option, yes, all this is cosmetic.
> For the new flags, we still have to deal with the reversed flags (the
> ATA_XXX_NO_...). And for these, the onoff is definitely reversed from the
> non reversed flags. And given that some of the reversed flags can already
> be set with libata.force, I find this way the cleanest to add new flags
> without breaking the manipulation of existing ones.
> 
Ok.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
