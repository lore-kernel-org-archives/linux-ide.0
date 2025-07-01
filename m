Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA12AE97
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379057; cv=none; b=BE4o0f4pQKvIMx7Im52AE7voUZkSRtQs5HkmGlTKpi2NtCCChIzMud0Xg58XMe5mlyvzV6O2sO768vWoQdSwdS0X3uYcQ4V8/oG3RgJ4YieBZA9R0+BsKgOGXVgtwAQci5Zxx/tmAIIxHDQViy22C+LFlbLdUEHY05cYi+9jG+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379057; c=relaxed/simple;
	bh=ila5i7LQ38vaozFAlsdyvcLqzzUywkMIfzNGMa+fzWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SAFx+0q5yLP3TA6b6RtdnYxo54iB/kmOFJym4s0WhJ/qKYLuXtzrDqLoZCj8OuyQP3WKuDmXED5f1lAk7QWjLKBgyCdHnD23ImRWyCVTc2i1bma3fFIZoC1SQSlva051CztB/oz+RLiUJkSyukZxm8yrn12uYhERl80Gsbxd340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AYzIRjSI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=652E+bwe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VLhnZxH7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W64McvqM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AYzIRjSI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="652E+bwe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VLhnZxH7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W64McvqM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A382F21134;
	Tue,  1 Jul 2025 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751379053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kK/+coXryvC5Qs3aC1UYsGPu1FUEQyWDb42QbyHV7w=;
	b=AYzIRjSI1o2UGxnTZ7dYPd2/L8VSOqm1JL8PUI+96EKxZaYOPcdnsJCOLF5e+Fiu9xl7GA
	g+eWyCy99Fnm0/llIejLbZUU8NBF66FAzsCZYoL+vFnTdoI5jmNHoCIXxOt1rHmuHc49v/
	h55oejKmrFra2sYFqBT4rtl+wg42mUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751379053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kK/+coXryvC5Qs3aC1UYsGPu1FUEQyWDb42QbyHV7w=;
	b=652E+bweFXit7E9kTv7akjqm+Ou9GfFv7GJ/FtgvvLtWZhUmcosYXbkp3y4/vqbS/RQ3oS
	CPuNpG8EewQoi6BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VLhnZxH7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=W64McvqM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751379052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kK/+coXryvC5Qs3aC1UYsGPu1FUEQyWDb42QbyHV7w=;
	b=VLhnZxH72qe86zSOwXxSRPhcyWC9QjbiqhwYTo3qp+3dOMaJKgGYJPoQqWV1UP/sbaj/V1
	i1GbPCUuIaHpsfQv5hDADHLdaX3T8IVZutJHVBOzkMHfdq+lo0Dl8o9sYvzoMfg/z/jS1N
	DK8XjB2Iz1VJKyh+Oj0XK9EEFe8x06Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751379052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kK/+coXryvC5Qs3aC1UYsGPu1FUEQyWDb42QbyHV7w=;
	b=W64McvqMiYZYdziPh+GHFstAfOfmOpTUAfRdgJq+50rLSve2SyICDXekUaUpBJeMu3vSYX
	UizLtxhhyUhGvYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 792DC1364B;
	Tue,  1 Jul 2025 14:10:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cIbtGGzsY2g4CwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 14:10:52 +0000
Message-ID: <85aabe97-d73f-4668-8e5d-564a36a57b15@suse.de>
Date: Tue, 1 Jul 2025 16:10:51 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] ata: libata-core: Introduce ata_dev_config_lpm()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250701125321.69496-1-dlemoal@kernel.org>
 <20250701125321.69496-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250701125321.69496-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
X-Rspamd-Queue-Id: A382F21134
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 7/1/25 14:53, Damien Le Moal wrote:
> If the port of a device does not support Device Initiated Power
> Management (DIPM), that is, the port is flagged with ATA_FLAG_NO_DIPM,
> the DIPM feature of a device should not be used. Though DIPM is disabled
> by default on a device, the "Software Settings Preservation feature"
> may keep DIPM enabled or DIPM may have been enabled by the system
> firmware.
> 
> Introduce the function ata_dev_config_lpm() to always disable DIPM on a
> device that supports this feature if the port of the device is flagged
> with ATA_FLAG_NO_DIPM. ata_dev_config_lpm() is called from
> ata_dev_configure(), ensuring that a device DIPM feature is disabled
> when it cannot be used.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-core.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
