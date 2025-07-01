Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB1B18DB27
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751350452; cv=none; b=HrgF372WrSeTgz4GrmY9FI+fB+qvo+6VhDBg2Gpq4rLHlYyPtqflKeIDi9dJi4y0OXHoGQP/QXm3fKW0CbzM/GXVPoxNSWGjRY1xKMrQamLMptNE7zJRiRjGWrQuP9455sYPv0IWB7afGHB99y3LeKbzs+cSR3ZLSFHBmrR4dQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751350452; c=relaxed/simple;
	bh=3ayPyuI200gpdMkUNoGU+g3RnWGLnojrGs6j5ETHpgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZNUWtJwQisCNud0O/esrM96BPSe0ka37/2WoauRpG/lfGjTVxHKkqMmANQDns+6JCXMlqw1k55D+4x0b6e10Gi6VhXePUjBbcwPJ662NTctXQFuI7NlKG4ZrveOeJBzYBgb1ZiHdHQSWYwZJnHZampplcqc/iWBQgQqx9XQ3pVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2O8GHgNR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kOGeS0qp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2O8GHgNR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kOGeS0qp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2O8GHgNR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kOGeS0qp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2O8GHgNR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kOGeS0qp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F91421162;
	Tue,  1 Jul 2025 06:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751350448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/KJuC6WNOx758sJ6W3aH6CTWuJtIlLmUfuzESYbISG4=;
	b=2O8GHgNRfGvUp3WbBh4IrBj1JyzC0S7YM75F2Evv015ySKkAR6dbpJS3QITQXhnpyEj+79
	WaSjlkxEjsB0xqG9s6WGqhY4aTRmMcI0OVgbannTxQRwhINRP9sn37UOcO6Tj/2ioG4oHD
	Yo+O62Px6RFSvpMoqqZ3+8Rft4mVxXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751350448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/KJuC6WNOx758sJ6W3aH6CTWuJtIlLmUfuzESYbISG4=;
	b=kOGeS0qpuR3vbFlxZ6f8uSGTEww+CYuwSH32awVXVFU84meHe4TgTKUlK3EYGfNb5Ou2sS
	x9HZpINX31YxlFBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2O8GHgNR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kOGeS0qp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751350448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/KJuC6WNOx758sJ6W3aH6CTWuJtIlLmUfuzESYbISG4=;
	b=2O8GHgNRfGvUp3WbBh4IrBj1JyzC0S7YM75F2Evv015ySKkAR6dbpJS3QITQXhnpyEj+79
	WaSjlkxEjsB0xqG9s6WGqhY4aTRmMcI0OVgbannTxQRwhINRP9sn37UOcO6Tj/2ioG4oHD
	Yo+O62Px6RFSvpMoqqZ3+8Rft4mVxXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751350448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/KJuC6WNOx758sJ6W3aH6CTWuJtIlLmUfuzESYbISG4=;
	b=kOGeS0qpuR3vbFlxZ6f8uSGTEww+CYuwSH32awVXVFU84meHe4TgTKUlK3EYGfNb5Ou2sS
	x9HZpINX31YxlFBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 787A01364B;
	Tue,  1 Jul 2025 06:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tyScG7B8Y2jYawAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 06:14:08 +0000
Message-ID: <40ee5029-8f93-4435-89f8-025fe7b4f495@suse.de>
Date: Tue, 1 Jul 2025 08:14:08 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] ata: libata-core: Advertize device support for DIPM
 and HIPM features
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-4-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250630062637.258329-4-dlemoal@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9F91421162
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 6/30/25 08:26, Damien Le Moal wrote:
> Modify ata_dev_print_features() to advertize if a device supports the
> Device Initiated Power Management (DIPM) and Host Initiated Power
> Management (HIPM) features.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index fdce96fd3ffa..d1dff9018a3a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2843,11 +2843,13 @@ static void ata_dev_print_features(struct ata_device *dev)
>   		return;
>   
>   	ata_dev_info(dev,
> -		     "Features:%s%s%s%s%s%s%s%s\n",
> +		     "Features:%s%s%s%s%s%s%s%s%s%s\n",
>   		     dev->flags & ATA_DFLAG_FUA ? " FUA" : "",
>   		     dev->flags & ATA_DFLAG_TRUSTED ? " Trust" : "",
>   		     dev->flags & ATA_DFLAG_DA ? " Dev-Attention" : "",
>   		     dev->flags & ATA_DFLAG_DEVSLP ? " Dev-Sleep" : "",
> +		     ata_id_has_hipm(dev->id) ? " HIPM" : "",
> +		     ata_id_has_dipm(dev->id) ? " DIPM" : "",
>   		     dev->flags & ATA_DFLAG_NCQ_SEND_RECV ? " NCQ-sndrcv" : "",
>   		     dev->flags & ATA_DFLAG_NCQ_PRIO ? " NCQ-prio" : "",
>   		     dev->flags & ATA_DFLAG_CDL ? " CDL" : "",

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
