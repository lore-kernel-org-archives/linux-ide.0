Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8331E8338
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751354465; cv=none; b=PdnUa4ylmO+u6ndDxwglpzNojaKirTQ8wjoZVEHkOSKwvTobQ7hcTE1BfY5sEUu35X2+j+2YoWN5ZS0zG7Lz1w5tSSZ3Dxb9d7pRQSLYekzYt4HicaUlxJzuMF/vxqGddCu7USezjPkUmEUrnM41Xj3L4qaMQJRxd8e/puncA14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751354465; c=relaxed/simple;
	bh=/mn+bV4O8zkfKQKPS2i4WxNe+CJdGd+63/0UAp0qdiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aXv8zSupDF5fJhkBzyGXcL+zU0fNyFZy2ZP34tT0Sd6/2Vnvitz+3V/DVoKyX0Tvd4iuFAl0PjDrmDYUkDAubiYAUWHfA0TtwoonzGePdrhUxh2cYRbnA9fcWV0f9gyJXJ0UMY/hdYAqVX01jCAiXm0qHVElfHE+iYVPFSydDYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jI9KBTjd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZmLdh8/y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jI9KBTjd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZmLdh8/y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jI9KBTjd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZmLdh8/y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jI9KBTjd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZmLdh8/y"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C6E41F444;
	Tue,  1 Jul 2025 07:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751354462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYi3pS0A808HpzV3p9dgNpBHbr5GC8kVvlYxOYXCT3A=;
	b=jI9KBTjdCImOFPUeXpjWTevpX4IMnEGJPxf4BvepLoDbKqnAhRL+KYXWZeUBgSYSW8Swx/
	OOdv2UsOFFuAp+yM3DYTpO7H0bTfwEY2218po6okPkilJ1hpPyfhFFjXAegT8Hy32IT6Fj
	/Wbfk3Sk+o6segd/z04NR3iRnd/kF+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751354462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYi3pS0A808HpzV3p9dgNpBHbr5GC8kVvlYxOYXCT3A=;
	b=ZmLdh8/yAYRLtDyNQ1frM7jUXZxEOAcqxafXG16vM3AGS6NT6411hlCL7JLhSj7Be4DS4q
	X1WmRud1dIYf72Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751354462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYi3pS0A808HpzV3p9dgNpBHbr5GC8kVvlYxOYXCT3A=;
	b=jI9KBTjdCImOFPUeXpjWTevpX4IMnEGJPxf4BvepLoDbKqnAhRL+KYXWZeUBgSYSW8Swx/
	OOdv2UsOFFuAp+yM3DYTpO7H0bTfwEY2218po6okPkilJ1hpPyfhFFjXAegT8Hy32IT6Fj
	/Wbfk3Sk+o6segd/z04NR3iRnd/kF+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751354462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYi3pS0A808HpzV3p9dgNpBHbr5GC8kVvlYxOYXCT3A=;
	b=ZmLdh8/yAYRLtDyNQ1frM7jUXZxEOAcqxafXG16vM3AGS6NT6411hlCL7JLhSj7Be4DS4q
	X1WmRud1dIYf72Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A42D13890;
	Tue,  1 Jul 2025 07:21:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qID9AF6MY2gyfwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 07:21:02 +0000
Message-ID: <16cbf6f7-fc3e-4e9f-94c6-3eed51fd7b03@suse.de>
Date: Tue, 1 Jul 2025 09:21:01 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] ata: libata-eh: Avoid unnecessary resets when
 revalidating devices
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-5-dlemoal@kernel.org>
 <60dd0013-20a3-4b10-a60b-0e567526e0f9@suse.de>
 <097726fe-638a-4336-8427-3eb3055de5b7@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <097726fe-638a-4336-8427-3eb3055de5b7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/1/25 08:48, Damien Le Moal wrote:
> On 7/1/25 3:23 PM, Hannes Reinecke wrote:
>> On 6/30/25 08:26, Damien Le Moal wrote:
>>> In ata_eh_revalidate_and_attach(), a link LPM policy is always
>>> set to ATA_LPM_MAX_POWER before calling ata_dev_revalidate() to ensure
>>> that the call to ata_phys_link_offline() does not return true, thus
>>> causing an unnecessary device reset. This change was introduced
>>> with commit 71d7b6e51ad3 ("ata: libata-eh: avoid needless hard reset
>>> when revalidating link").
>>>
>>> However, setting the link LPM policy to ATA_LPM_MAX_POWER may be
>>> visible only after some time, depending on the power state the link was
>>> in. E.g. transitioning out of the Partial state should take no longer
>>> than a few microseconds, but transitioning out of the Slumber or
>>> DevSleep state may take several milliseconds. So despite the changes
>>> introduced with commit 71d7b6e51ad3 ("ata: libata-eh: avoid needless
>>> hard reset when revalidating link"), we can still endup with
>>> ata_phys_link_offline() seeing a link SCR_STATUS register signaling that
>>> the device is present (DET is equal to 1h) but that the link PHY is
>>> still in a low power mode (e.g. IPM is 2h, signaling "Interface in
>>> Partial power management state"). In such cases, ata_phys_link_offline()
>>> returns true, causing an EIO return for ata_eh_revalidate_and_attach()
>>> and a device reset.
>>>
>>> Avoid such unnecessary device resets by introducing a relaxed version
>>> of the link offline test implemented by ata_phys_link_offline() with
>>> the new helper function ata_eh_link_established(). This functions
>>> returns true if for the link SCR_STATUS register we see that:
>>>    - A device is still present, that is, the DET field is 1h (Device
>>>      presence detected but Phy communication not established) or 3h
>>>      (Device presence detected and Phy communication established).
>>>    - Communication is established, that is, the IPM field is not 0h,
>>>      indicating that the PHY is online or in a low power state.
>>>
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>> ---
>>>    drivers/ata/libata-eh.c | 29 ++++++++++++++++++++++++++++-
>>>    1 file changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>> index f98d5123e1e4..7f5d13f9ca73 100644
>>> --- a/drivers/ata/libata-eh.c
>>> +++ b/drivers/ata/libata-eh.c
>>> @@ -2071,6 +2071,33 @@ static void ata_eh_get_success_sense(struct ata_link
>>> *link)
>>>        ata_eh_done(link, dev, ATA_EH_GET_SUCCESS_SENSE);
>>>    }
>>>    +/*
>>> + * Check if a link is established. This is a relaxed version of
>>> + * ata_phys_link_online() which accounts for the fact that this is potentially
>>> + * called after changing the link power management policy, which may not be
>>> + * reflected immediately in the SSTAUS register (e.g., we may still be seeing
>>> + * the PHY in partial, slumber or devsleep Partial power management state.
>>> + * So check that:
>>> + * - A device is still present, that is, DET is 1h (Device presence detected
>>> + *   but Phy communication not established) or 3h (Device presence detected and
>>> + *   Phy communication established)
>>> + * - Communication is established, that is, IPM is not 0h, indicating that PHY
>>> + *   is online or in a low power state.
>>> + */
>>> +static bool ata_eh_link_established(struct ata_link *link)
>>> +{
>>> +    u32 sstatus;
>>> +    u8 det, ipm;
>>> +
>>> +    if (sata_scr_read(link, SCR_STATUS, &sstatus))
>>> +        return false;
>>> +
>>> +    det = sstatus & 0x0f;
>>> +    ipm = (sstatus >> 8) & 0x0f;
>>> +
>>> +    return (det & 0x01) && ipm;
>>> +}
>>> +
>>>    /**
>>>     *    ata_eh_link_set_lpm - configure SATA interface power management
>>>     *    @link: link to configure
>>> @@ -3275,7 +3302,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link
>>> *link,
>>>                        goto err;
>>>                }
>>>    -            if (ata_phys_link_offline(ata_dev_phys_link(dev))) {
>>> +            if (!ata_eh_link_established(ata_dev_phys_link(dev))) {
>>>                    rc = -EIO;
>>>                    goto err;
>>>                }
>>
>> Makes me wonder: if the phy is taking some time, don't we need to wait
>> at some point for the transition to complete?
> 
> There is a 10ms wait already in sata_link_scr_lpm() but it seems to not always
> be enough. The specs say that transitions out of HIPM "shall not take more than
> 10ms", but hey, we all know how devices always follow the specs, right ? :)
> 
>>  From a cursory glance we just continue, and (apparently) hope that
>> everything will be well eventually.
>> Hmm?
> 
> It is fine to continue because transitions out of DIPM/HIPM/DevSleep are
> automatic if you send a command. So we actually do not need to wait at all and
> probably can remove that 10ms sleep in sata_link_scr_lpm(). But I have not for now.
> 
> 
Ah. Maybe adding that to the description.
... or maybe not, as we seemed to be the only ones caring about this
kinda stuff :-)

Reviewed-by: Hannes Reinecke <hare@suse.de.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
