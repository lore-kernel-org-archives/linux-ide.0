Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A0772601
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751350989; cv=none; b=JH6jCya9Qg2I7fJGVKt6mxLZOM++eXdnJtXfFIKpsWL2pMibMxFMffGeSpGgIMCYxi5+bebKVcSYz9Zr2nuxu1VJbWUnBD6+eFqGASQlXKf3CP6zRMa6h6EOHRFq5L5ZfGx+k06EW2bQH/c3WOixGMvQf0cw2nhV8A1X8z57Des=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751350989; c=relaxed/simple;
	bh=jEtWh7q9Fc6sbWSTU42pa8DYKTbc3u/RLdDZEXY/11A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mvIxVTZZZrk3WxXZj/ntw6Ci+uWJBnnxlHoAVTfiN2RTssxsE5nIJgSuWHwCbMDvVWQL5DPnMNeDPSEuLdcMcQDi38PVmHsaH/bcIMaii9HoDCCnGgJiB5XW+A4FiE5JMbzTf1hv89E5ol6SkejG7+F2L/QYlgiwERwUnAw01J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o3ZTTGs4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lu9VrXOc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o3ZTTGs4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lu9VrXOc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o3ZTTGs4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lu9VrXOc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o3ZTTGs4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lu9VrXOc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B35E1F388;
	Tue,  1 Jul 2025 06:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751350985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuD/4arPobSud/HVWLLfUjWVrM+XI2JorKZe1me0t7Y=;
	b=o3ZTTGs4hu8NKR2/m3k7A6/1uMjpAKsX8qNTN5yCaHPAeSblH/NAMiwcDLLiFgpoBxk/zi
	C46F8klAP+s1yoDf60huevIec7+sRVkn6o7Wa4mukrc9GLacho+seY24g8DVmsKYmrL+UI
	RG17z+myMuBEFbwr2nqOffone6oxxzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751350985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuD/4arPobSud/HVWLLfUjWVrM+XI2JorKZe1me0t7Y=;
	b=lu9VrXOcQvkiCHRPZpALsZOVLMi0u61sBm6xG+8kh4b11eQMie/QzoKOqInesB6l347fvM
	vMPb3RLUoaQmdkBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o3ZTTGs4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lu9VrXOc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751350985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuD/4arPobSud/HVWLLfUjWVrM+XI2JorKZe1me0t7Y=;
	b=o3ZTTGs4hu8NKR2/m3k7A6/1uMjpAKsX8qNTN5yCaHPAeSblH/NAMiwcDLLiFgpoBxk/zi
	C46F8klAP+s1yoDf60huevIec7+sRVkn6o7Wa4mukrc9GLacho+seY24g8DVmsKYmrL+UI
	RG17z+myMuBEFbwr2nqOffone6oxxzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751350985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuD/4arPobSud/HVWLLfUjWVrM+XI2JorKZe1me0t7Y=;
	b=lu9VrXOcQvkiCHRPZpALsZOVLMi0u61sBm6xG+8kh4b11eQMie/QzoKOqInesB6l347fvM
	vMPb3RLUoaQmdkBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDC1E1364B;
	Tue,  1 Jul 2025 06:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CCUAOMh+Y2g0bgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 06:23:04 +0000
Message-ID: <60dd0013-20a3-4b10-a60b-0e567526e0f9@suse.de>
Date: Tue, 1 Jul 2025 08:23:04 +0200
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
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250630062637.258329-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1B35E1F388
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 6/30/25 08:26, Damien Le Moal wrote:
> In ata_eh_revalidate_and_attach(), a link LPM policy is always
> set to ATA_LPM_MAX_POWER before calling ata_dev_revalidate() to ensure
> that the call to ata_phys_link_offline() does not return true, thus
> causing an unnecessary device reset. This change was introduced
> with commit 71d7b6e51ad3 ("ata: libata-eh: avoid needless hard reset
> when revalidating link").
> 
> However, setting the link LPM policy to ATA_LPM_MAX_POWER may be
> visible only after some time, depending on the power state the link was
> in. E.g. transitioning out of the Partial state should take no longer
> than a few microseconds, but transitioning out of the Slumber or
> DevSleep state may take several milliseconds. So despite the changes
> introduced with commit 71d7b6e51ad3 ("ata: libata-eh: avoid needless
> hard reset when revalidating link"), we can still endup with
> ata_phys_link_offline() seeing a link SCR_STATUS register signaling that
> the device is present (DET is equal to 1h) but that the link PHY is
> still in a low power mode (e.g. IPM is 2h, signaling "Interface in
> Partial power management state"). In such cases, ata_phys_link_offline()
> returns true, causing an EIO return for ata_eh_revalidate_and_attach()
> and a device reset.
> 
> Avoid such unnecessary device resets by introducing a relaxed version
> of the link offline test implemented by ata_phys_link_offline() with
> the new helper function ata_eh_link_established(). This functions
> returns true if for the link SCR_STATUS register we see that:
>   - A device is still present, that is, the DET field is 1h (Device
>     presence detected but Phy communication not established) or 3h
>     (Device presence detected and Phy communication established).
>   - Communication is established, that is, the IPM field is not 0h,
>     indicating that the PHY is online or in a low power state.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-eh.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index f98d5123e1e4..7f5d13f9ca73 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2071,6 +2071,33 @@ static void ata_eh_get_success_sense(struct ata_link *link)
>   	ata_eh_done(link, dev, ATA_EH_GET_SUCCESS_SENSE);
>   }
>   
> +/*
> + * Check if a link is established. This is a relaxed version of
> + * ata_phys_link_online() which accounts for the fact that this is potentially
> + * called after changing the link power management policy, which may not be
> + * reflected immediately in the SSTAUS register (e.g., we may still be seeing
> + * the PHY in partial, slumber or devsleep Partial power management state.
> + * So check that:
> + * - A device is still present, that is, DET is 1h (Device presence detected
> + *   but Phy communication not established) or 3h (Device presence detected and
> + *   Phy communication established)
> + * - Communication is established, that is, IPM is not 0h, indicating that PHY
> + *   is online or in a low power state.
> + */
> +static bool ata_eh_link_established(struct ata_link *link)
> +{
> +	u32 sstatus;
> +	u8 det, ipm;
> +
> +	if (sata_scr_read(link, SCR_STATUS, &sstatus))
> +		return false;
> +
> +	det = sstatus & 0x0f;
> +	ipm = (sstatus >> 8) & 0x0f;
> +
> +	return (det & 0x01) && ipm;
> +}
> +
>   /**
>    *	ata_eh_link_set_lpm - configure SATA interface power management
>    *	@link: link to configure
> @@ -3275,7 +3302,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
>   					goto err;
>   			}
>   
> -			if (ata_phys_link_offline(ata_dev_phys_link(dev))) {
> +			if (!ata_eh_link_established(ata_dev_phys_link(dev))) {
>   				rc = -EIO;
>   				goto err;
>   			}

Makes me wonder: if the phy is taking some time, don't we need to wait
at some point for the transition to complete?
 From a cursory glance we just continue, and (apparently) hope that
everything will be well eventually.
Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
