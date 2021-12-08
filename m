Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35AFC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 11:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhLHLNO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 06:13:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58648 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhLHLNM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 06:13:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1775D1FD2A;
        Wed,  8 Dec 2021 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638961780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmYcQTEDC/K9M1i0GyivJiiFVxRd65i9saUZOPaSUoc=;
        b=MD3cOzwXCltTHu+igG5y+U1OVRu/E7uVnr0zKCyJhB64hr1OYERb6YxmNf99lsWuACmc0w
        7JwrR0H2hwOzGtcX9BeMnKNIs3GwoVT0XV/HFmjeIUMxZYYuFJusY651VEptRnOrH2FFH4
        cU/B0wCOrpKjBCSs9rNatYbIz+hmysY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638961780;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmYcQTEDC/K9M1i0GyivJiiFVxRd65i9saUZOPaSUoc=;
        b=x15MT9L9mfAkXeyZG12REJj685S8yD0phk1ICrwyXOKJPojzFlJ45IF8nii9+e6HMjp1d7
        iQtmi7DFdaqdMPDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AFD213C46;
        Wed,  8 Dec 2021 11:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 879fAnSSsGE9QwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 08 Dec 2021 11:09:40 +0000
Subject: Re: [PATCH] libata: add horkage for ASMedia 1092
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20211208065853.5270-1-hare@suse.de>
 <DM6PR04MB7081F06F8B94345297B0267FE76F9@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <731e355a-9365-3199-6db4-e9f07a79de8c@suse.de>
Date:   Wed, 8 Dec 2021 12:09:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB7081F06F8B94345297B0267FE76F9@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/8/21 11:57 AM, Damien Le Moal wrote:
> On 2021/12/08 15:59, Hannes Reinecke wrote:
>> The ASMedia 1092 has a configuration mode which will present a
>> dummy device; sadly the implementation falsely claims to provide
>> a device with 100M which doesn't actually exist.
>> So disable this device to avoid errors during boot.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>  drivers/ata/libata-core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 9c05177e09c2..f1a2f0a4ce05 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -4416,6 +4416,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>  	{ "VRFDFC22048UCHC-TE*", NULL,		ATA_HORKAGE_NODMA },
>>  	/* Odd clown on sil3726/4726 PMPs */
>>  	{ "Config  Disk",	NULL,		ATA_HORKAGE_DISABLE },
>> +	/* Similar story with ASMedia 1092 */
>> +	{ "ASMT109x- Config",	NULL,		ATA_HORKAGE_DISABLE },
>>  
>>  	/* Weird ATAPI devices */
>>  	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_128 },
>>
> 
> Doesn't this need a Cc stable ? I can add it.
> 
Possibly; device has never worked properly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
