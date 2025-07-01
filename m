Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3C246799
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751350169; cv=none; b=PXjHrTjEfO42Vyg5wmNO5RZgQMXpEK/sC5kS03V/Vo+91H75urUYWVck5yfcDh55EnuptR2Bhr2AsYf6YyItdPFPiRjDSD5JL/fR7ljbsRq1u0C+pfHCnynOxFb4cmCTtORjop6LiTRT6h70Z3u90MmN1C3o+d2iFAbVKHEYl2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751350169; c=relaxed/simple;
	bh=La4ltSIZrFABcHdTmmLYJ4/ifC42P+RB1P6PZeGZ7p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D7Lb4gMbKEr7gAord7YXv/Ox+3EZP7BjJt/WPBLiOOar99tMIgNUWzuYESd+rWp6FCIanWztEe2RPGJawrRqh4DyQhRoHSObrisB++o6qfQecPnVGqrOqJyFbDHexazuaI0X3u7q4eGlNoI9oA6iWpVYcnd2NSOuF2WyLUe7yrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wxiDAW1b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w1ZeOxuf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wxiDAW1b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w1ZeOxuf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wxiDAW1b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w1ZeOxuf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wxiDAW1b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w1ZeOxuf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92E151F388;
	Tue,  1 Jul 2025 06:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751350165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQqIVmYGtmm8rqEGWVheHuI5mNN5J/Ggtja6OlI1JnY=;
	b=wxiDAW1bTTFBwgDgN6QbZksuUOIZTUZczDDV1d4pJYlgLsTEPLqE0YYKKGLRiEoFz1lgzu
	uHjGnIgGaSZnsLBI50DODzL2M3FnNMDLeoMiwehUbFNESVqrV8of1CFjUHzlsCMSJd1RXx
	kRjbEPCxwhAYdt+RJYtlgXzN64ZMF8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751350165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQqIVmYGtmm8rqEGWVheHuI5mNN5J/Ggtja6OlI1JnY=;
	b=w1ZeOxufSSYdnpg/oBEdYYk2E1khS1hH+CDVuxxFIKcivOWrfXypgz6jBjxF1NMTiMrD1j
	8NqXoMN6oQpSgJBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wxiDAW1b;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=w1ZeOxuf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751350165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQqIVmYGtmm8rqEGWVheHuI5mNN5J/Ggtja6OlI1JnY=;
	b=wxiDAW1bTTFBwgDgN6QbZksuUOIZTUZczDDV1d4pJYlgLsTEPLqE0YYKKGLRiEoFz1lgzu
	uHjGnIgGaSZnsLBI50DODzL2M3FnNMDLeoMiwehUbFNESVqrV8of1CFjUHzlsCMSJd1RXx
	kRjbEPCxwhAYdt+RJYtlgXzN64ZMF8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751350165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQqIVmYGtmm8rqEGWVheHuI5mNN5J/Ggtja6OlI1JnY=;
	b=w1ZeOxufSSYdnpg/oBEdYYk2E1khS1hH+CDVuxxFIKcivOWrfXypgz6jBjxF1NMTiMrD1j
	8NqXoMN6oQpSgJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7065B1364B;
	Tue,  1 Jul 2025 06:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /HBMGZV7Y2h9agAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 06:09:25 +0000
Message-ID: <494df6ce-5a92-471a-bc52-c2aba2eee8c4@suse.de>
Date: Tue, 1 Jul 2025 08:09:25 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] ata: libata-core: Introduce ata_dev_config_lpm()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250630062637.258329-2-dlemoal@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 92E151F388
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 6/30/25 08:26, Damien Le Moal wrote:
> If the port of a device does not support Device Initiated Power
> Management (DIPM), that is, the port is flagged with ATA_FLAG_NO_DIPM,
> the DIPM feature of a device should be disabled when the device is first
> configured.
> 
> Introduce the function ata_dev_config_lpm() to disable DIPM on a
> device that supports this feature if the port of the device is flagged
> with ATA_FLAG_NO_DIPM. ata_dev_config_lpm() is called from
> ata_dev_configure(), ensuring that a device DIPM feature is disabled
> when it cannot be used.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-core.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 3918ea624e0b..0d85474f6640 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2790,6 +2790,27 @@ static void ata_dev_config_cpr(struct ata_device *dev)
>   	kfree(buf);
>   }
>   
> +/*
> + * Configure features related to link power management.
> + */
> +static void ata_dev_config_lpm(struct ata_device *dev)
> +{
> +	struct ata_port *ap = dev->link->ap;
> +	unsigned int err_mask;
> +
> +	/*
> +	 * If the device port does not support Device Initiated Power Management
> +	 * (DIPM), and the device supports this feature, disable it.
> +	 */
> +	if (ap->flags & ATA_FLAG_NO_DIPM && ata_id_has_dipm(dev->id)) {
> +		err_mask = ata_dev_set_feature(dev,
> +					SETFEATURES_SATA_DISABLE, SATA_DIPM);
> +		if (err_mask && err_mask != AC_ERR_DEV)
> +			ata_dev_err(dev, "Disable DIPM failed, Emask 0x%x\n",
> +				    err_mask);
> +	}
> +}
> +

Why is it called 'ata_dev_config_lpm()', when it actually disables DIPM?
Why not 'ata_dev_config_dipm()'?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
