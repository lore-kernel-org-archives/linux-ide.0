Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA91EA6F
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751354355; cv=none; b=ZwqZP2dRDFoNopXgc0KoFr+jyjdE9iWGjsA4t+KKrNbwCP3+DMnqmLGLlgmrbJbq5Jxumc2OFT2LXwf3W8108x9suheEg/nX/7egleRXln1Fvv2SaUlNopmX1wneVSNHpgol+LYreemDtQJYIcBGydDBcnUMlkNlTRLHATJBe9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751354355; c=relaxed/simple;
	bh=uTQNCHXxyBFBCBSmW2C7LLliHit9fpuuNCmqFgeXauU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YvLaaW1Hz6vLgWLS0vC32nJsKBEWAqTbohUQMfeJbWpzUYciL7HVvv+q/TojjhlUPFo3nY4lXpd160XTPJOe7/644uYrp0tGtwZtkijR7BIDhkIZGpD4lcZe6c5dN+tqWNrG4fdtro29v8uuqcjfDn5QzLiryaiYEYeRpHaYUrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HdP3cJbf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6rrkGFQZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IRsmvGsq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NTMRL8Qu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HdP3cJbf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6rrkGFQZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IRsmvGsq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NTMRL8Qu"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF75C1F444;
	Tue,  1 Jul 2025 07:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751354352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7XHc41kBK9UVa1bHahkxWSV/88YVpL9cxTGXVJpyII=;
	b=HdP3cJbfPlRksw5IbKP/3KrcHE8b5Yqpi4hI9s/Wjq0eN7BBJhHAEDHZO+WbL33GBw5R0m
	///keXDg0KxFDzCZie3DATBAqiZ8nG1usJmv8wYeUJnYRtzwcnoMo85r4fni6ydkp+IQli
	2ZKFwyirsCrm25lVU1mSNxGRDcqb4vQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751354352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7XHc41kBK9UVa1bHahkxWSV/88YVpL9cxTGXVJpyII=;
	b=6rrkGFQZ5LRkEBQ4jIx77PQvu5YAQIQCpK3nH9qxXfnRDG07VjgsvR2hRdu3phnz2iZfgZ
	XCwj0LrX9EH56IAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IRsmvGsq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NTMRL8Qu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751354351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7XHc41kBK9UVa1bHahkxWSV/88YVpL9cxTGXVJpyII=;
	b=IRsmvGsqt7aOT26ZLCsIhI2uiZzRkgfkDCh6FE/M5yMhd+8Rnixr+IcltiRrl4JtqW23VN
	zDjnc5/y9ryHxhj550LToQYtEw8W+EpsMf05Ku98iqrMh7c7lLu6vGHdPu/YjPP9MPIrC9
	QcHRwe5gUgeGtKPOyzBwTqETWFP8K4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751354351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7XHc41kBK9UVa1bHahkxWSV/88YVpL9cxTGXVJpyII=;
	b=NTMRL8Quqb6iaYT0cgy2YuGA+9IBvu8H9B3EGRlYqOtbSa3rxkO/g+Fl0Gf6xRXRoscEDg
	WkANsaCgcOILxAAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFCDC13890;
	Tue,  1 Jul 2025 07:19:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SoAJKe+LY2iFfgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 07:19:11 +0000
Message-ID: <ec8663cc-0465-446c-9b5f-017f52b6961f@suse.de>
Date: Tue, 1 Jul 2025 09:19:03 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] ata: libata-core: Move device LPM quirk settings to
 ata_dev_config_lpm()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-3-dlemoal@kernel.org>
 <aa7c533b-38fc-44d0-981b-cd499cc20ac6@suse.de>
 <275a49c5-b725-4f32-9191-d6468c14ddcc@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <275a49c5-b725-4f32-9191-d6468c14ddcc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DF75C1F444
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 7/1/25 08:43, Damien Le Moal wrote:
> On 7/1/25 3:13 PM, Hannes Reinecke wrote:
>> On 6/30/25 08:26, Damien Le Moal wrote:
>>> Move the various cases of setting the ATA_QUIRK_NOLPM quirk flag for a
>>> device in ata_dev_configure() to the function ata_dev_config_lpm().
>>> This allows having all LPM related settings in one place to facilitate
>>> maintenance.
>>>
>>> No functional changes.
>>>
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>> ---
>>>    drivers/ata/libata-core.c | 43 +++++++++++++++++++++++----------------
>>>    1 file changed, 26 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index 0d85474f6640..fdce96fd3ffa 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -2798,6 +2798,32 @@ static void ata_dev_config_lpm(struct ata_device *dev)
>>>        struct ata_port *ap = dev->link->ap;
>>>        unsigned int err_mask;
>>>    +    if (ap->flags & ATA_FLAG_NO_LPM) {
>>> +        /*
>>> +         * When the port does not support LPM, we cannot support it on
>>> +         * the device either.
>>> +         */
>>> +        dev->quirks |= ATA_QUIRK_NOLPM;
>>> +    } else {
>>> +        /*
>>> +         * Some WD SATA-1 drives have issues with LPM, turn on NOLPM for
>>> +         * them.
>>> +         */
>>> +        if ((dev->quirks & ATA_QUIRK_WD_BROKEN_LPM) &&
>>> +            (dev->id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
>>> +            dev->quirks |= ATA_QUIRK_NOLPM;
>>> +
>>> +        /* ATI specific quirk */
>>> +        if ((dev->quirks & ATA_QUIRK_NO_LPM_ON_ATI) &&
>>> +            ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI))
>>> +            dev->quirks |= ATA_QUIRK_NOLPM;
>>> +    }
>>> +
>>> +    if (dev->quirks & ATA_QUIRK_NOLPM) {
>>> +        ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
>>> +        ap->target_lpm_policy = ATA_LPM_MAX_POWER;
>>> +    }
>>> +
>>>        /*
>>>         * If the device port does not support Device Initiated Power Management
>>>         * (DIPM), and the device supports this feature, disable it.
>>> @@ -2881,23 +2907,6 @@ int ata_dev_configure(struct ata_device *dev)
>>>        if (rc)
>>>            return rc;
>>>    -    /* some WD SATA-1 drives have issues with LPM, turn on NOLPM for them */
>>> -    if ((dev->quirks & ATA_QUIRK_WD_BROKEN_LPM) &&
>>> -        (id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
>>> -        dev->quirks |= ATA_QUIRK_NOLPM;
>>> -
>>> -    if (dev->quirks & ATA_QUIRK_NO_LPM_ON_ATI &&
>>> -        ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI))
>>> -        dev->quirks |= ATA_QUIRK_NOLPM;
>>> -
>>> -    if (ap->flags & ATA_FLAG_NO_LPM)
>>> -        dev->quirks |= ATA_QUIRK_NOLPM;
>>> -
>>> -    if (dev->quirks & ATA_QUIRK_NOLPM) {
>>> -        ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
>>> -        dev->link->ap->target_lpm_policy = ATA_LPM_MAX_POWER;
>>> -    }
>>> -
>>>        /* let ACPI work its magic */
>>>        rc = ata_acpi_on_devcfg(dev);
>>>        if (rc)
>>
>> And this now is only dealing with modifying LPM setting, independent on
>> any DIPM setting. Why not make two functions (one for DIPM and one for
>> LPM) so make matters less confusing?
> 
> "less confusing" with all LPM things is I think not possible :)
> 
> The idea is to keep things together as much as possible to facilitate
> tweaking/maintenance. There is more like this coming to get port capabilities
> out of ahci.c and into generic libata so that platform AHCI and libsas adapters
> can be supported too. Right now, it is pretty much LPM == AHCI...
> 
Ok, makes sense.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
