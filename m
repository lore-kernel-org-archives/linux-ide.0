Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126F25CC6C
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351193; cv=none; b=cOfgQr8u0liwzbhZbeG+mOcY1aNQLH3yTNR2m11II3U6NuX0uROktVrOszVIpHVfoHxKl1qLefGuhcBD8qZJfK02B4JhTWJsadJ5kFpP+Kv4GZabdW0A7+opq4ecjqcTwJbGXlSZs0TXobpE3/P4qWXSfv+9XEPizz1cHnYal5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351193; c=relaxed/simple;
	bh=BmY8YiibnzubW5xB4MKj2KqzGwD3W64p/f3b8a36/3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U3rD6zZmmERyhscpAONK5hlz90byVH5UwkjmyHgmBLpU8BGD5A3x/L4t2ogoG35cevGZTJWUEtoujv3Qb0Rrl6t7A4RSOW30zkDHuX+mpZi5vsLVWg7swKAATgYfHsgLp76W/X1pc/DxNfcA8RtfjI4PwSeacIJuA0gCCh189zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uL0dcT1m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t29mXh4x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uL0dcT1m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t29mXh4x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uL0dcT1m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t29mXh4x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uL0dcT1m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t29mXh4x"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E9DF1F388;
	Tue,  1 Jul 2025 06:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751351189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DewfBA8yyjP9NWUDYZ0Qv7n9G0V9kz6n+vX5oojZC3M=;
	b=uL0dcT1mWQF52sYMeReQndAqmdhDvRQnu4HRI4LVFIb1nqg1m7e8ikkEuDbCPtOuP/IO4J
	5lIDb5vmL5FP/2uuSOYlkjpf+7eIo2koRnisT3yIus5L48hnFbZOAEB+XvOkWjOqYG6VP0
	ZsCDHvnkAy8cweIJ/MjSC/tWID3FIs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751351189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DewfBA8yyjP9NWUDYZ0Qv7n9G0V9kz6n+vX5oojZC3M=;
	b=t29mXh4xgnCG4cQA4scH2AuCaiiD3MBBv3WhEt/tNGaoSmtb32O5irN10umX3+T6SAWaQp
	l3KJMebTXMUN/TAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751351189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DewfBA8yyjP9NWUDYZ0Qv7n9G0V9kz6n+vX5oojZC3M=;
	b=uL0dcT1mWQF52sYMeReQndAqmdhDvRQnu4HRI4LVFIb1nqg1m7e8ikkEuDbCPtOuP/IO4J
	5lIDb5vmL5FP/2uuSOYlkjpf+7eIo2koRnisT3yIus5L48hnFbZOAEB+XvOkWjOqYG6VP0
	ZsCDHvnkAy8cweIJ/MjSC/tWID3FIs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751351189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DewfBA8yyjP9NWUDYZ0Qv7n9G0V9kz6n+vX5oojZC3M=;
	b=t29mXh4xgnCG4cQA4scH2AuCaiiD3MBBv3WhEt/tNGaoSmtb32O5irN10umX3+T6SAWaQp
	l3KJMebTXMUN/TAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BFB61364B;
	Tue,  1 Jul 2025 06:26:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YqgiHJV/Y2gwbwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 06:26:29 +0000
Message-ID: <556da374-f910-4315-873e-6ccb7c8b4f48@suse.de>
Date: Tue, 1 Jul 2025 08:26:29 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] ata: libata-core: Reduce the number of messages
 signaling broken LPM
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-10-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250630062637.258329-10-dlemoal@kernel.org>
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

On 6/30/25 08:26, Damien Le Moal wrote:
> ata_dev_config_lpm() prints the message "LPM support broken, forcing
> max_power" for devices that have the ATA_QUIRK_NOLPM quirk flag set.
> This messages is repeated for every device revalidation, which is not
> necessary, but also erroneously printed for devices without a broken LPM
> support when connected to a port that does not support LPM (e.g. because
> the port is an external one with hotplug capability).
> 
> Since in all cases the device port target_lpm_policy is set to
> ATA_LPM_MAX_POWER, avoid the "LPM broken" message repetition and
> erroneous output by generating it only if the port target_lpm_policy is
> not already set to ATA_LPM_MAX_POWER.
> 
> This change will suppress the "LPM broken" message for genuine cases of
> a device having broken LPM if the initial LPM policy is set to
> ATA_LPM_MAX_POWER through CONFIG_SATA_MOBILE_LPM_POLICY. This is not a
> problem as the ATA_LPM_MAX_POWER policy implies that LPM is disabled and
> unused, which is safe for devices with broken LPM.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d1dff9018a3a..3e6cf26af4e4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2819,7 +2819,8 @@ static void ata_dev_config_lpm(struct ata_device *dev)
>   			dev->quirks |= ATA_QUIRK_NOLPM;
>   	}
>   
> -	if (dev->quirks & ATA_QUIRK_NOLPM) {
> +	if (dev->quirks & ATA_QUIRK_NOLPM &&
> +	    ap->target_lpm_policy != ATA_LPM_MAX_POWER) {
>   		ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
>   		ap->target_lpm_policy = ATA_LPM_MAX_POWER;
>   	}

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
