Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6112A8D0
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004291; cv=none; b=MWgbzftzTAzICcRddKpZQ7zbzgKPZiswYfFcSEhOcrUwpfmTfqnKCoAP8m8Wy1F5DYda8IOMFRVgz+lYs37IDRmV+PmKpZfxuFdqg9sqXE+FR3YSdu/108dTsp4iT1RyCytEWttHINRnSSBwSmKzhqvNpGDjH37V7LeLc50i0OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004291; c=relaxed/simple;
	bh=1xZxahIab3DU8n4XhRD1pDKl5pd53HndI2JhOo1kitA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ty5Sw+mf+6MscWmKbu0AImqHQT4qhvbtc4AvaGsOhoBKnVb1oHrmwdiGOI3HvZCelcT2lCjmWztDFWlgdlw51xbGSWLfWiyQeGFVc5JFv/531xJpdDkjEh9Y9vZ/LX3qXUcazGWC7mIOjFi3sStKN5WAxIDvMFdoWhJMJycjyH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DPuT14E9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Im/5usDG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DPuT14E9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Im/5usDG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DPuT14E9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Im/5usDG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DPuT14E9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Im/5usDG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 391011F387;
	Fri, 27 Jun 2025 06:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751004288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/WSvssA14tYKZxG2zfpDD8CNqNp8oJhZ88l4Y7X0t8=;
	b=DPuT14E96OwkUVDbuGTqVUrgDy8LENcnmoi1vh1mnMiyX3UJUf56OUdueRJsI9CHawRqQE
	ZFbo/lmRMGvovQ1qCle5hTIiQfH29ToFzJeFjZBZFcW63unLXxTVvXCWodegYY2OiIIB3f
	bOAbWk4BZOIiptIiCNHQQNjUhLsZw04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751004288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/WSvssA14tYKZxG2zfpDD8CNqNp8oJhZ88l4Y7X0t8=;
	b=Im/5usDGjmc43DLW+8TCTSL0EikdZEOnHBJLVjbpz+R2hXLx43FefHShoJFPyUM/ZbN1sJ
	cGhzM4bA229IdFDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DPuT14E9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Im/5usDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751004288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/WSvssA14tYKZxG2zfpDD8CNqNp8oJhZ88l4Y7X0t8=;
	b=DPuT14E96OwkUVDbuGTqVUrgDy8LENcnmoi1vh1mnMiyX3UJUf56OUdueRJsI9CHawRqQE
	ZFbo/lmRMGvovQ1qCle5hTIiQfH29ToFzJeFjZBZFcW63unLXxTVvXCWodegYY2OiIIB3f
	bOAbWk4BZOIiptIiCNHQQNjUhLsZw04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751004288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/WSvssA14tYKZxG2zfpDD8CNqNp8oJhZ88l4Y7X0t8=;
	b=Im/5usDGjmc43DLW+8TCTSL0EikdZEOnHBJLVjbpz+R2hXLx43FefHShoJFPyUM/ZbN1sJ
	cGhzM4bA229IdFDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 088DA13786;
	Fri, 27 Jun 2025 06:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2fGKO380XmjJMQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Jun 2025 06:04:47 +0000
Message-ID: <5572ab0a-59f5-41f6-98f0-b88add978678@suse.de>
Date: Fri, 27 Jun 2025 08:04:47 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] ata: libata: Improve LPM policies description
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250627011155.701125-1-dlemoal@kernel.org>
 <20250627011155.701125-5-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250627011155.701125-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 391011F387
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 6/27/25 03:11, Damien Le Moal wrote:
> Improve the comments describing the different values of enum
> ata_lpm_policy in include/linux/libata.h. The comments match the
> description given for the CONFIG_SATA_MOBILE_LPM_POLICY config
> parameter.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   include/linux/libata.h | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 721f0805b6c9..f8bdf167bad9 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -499,16 +499,23 @@ enum ata_completion_errors {
>   };
>   
>   /*
> - * Link power management policy: If you alter this, you also need to
> - * alter libata-sata.c (for the ascii descriptions)
> + * Link power management policy: If you alter this, you also need to alter
> + * the policy names used with the sysfs attribute link_power_management_policy
> + * defined in libata-sata.c
>    */
>   enum ata_lpm_policy {
> +	/* 0 => Keep firmware settings */
>   	ATA_LPM_UNKNOWN,
> +	/* 1 => No power savings (maximum performance) */
>   	ATA_LPM_MAX_POWER,
> +	/* 2 => HIPM (Partial) */
>   	ATA_LPM_MED_POWER,
> -	ATA_LPM_MED_POWER_WITH_DIPM, /* Med power + DIPM as win IRST does */
> -	ATA_LPM_MIN_POWER_WITH_PARTIAL, /* Min Power + partial and slumber */
> -	ATA_LPM_MIN_POWER, /* Min power + no partial (slumber only) */
> +	/* 3 => HIPM (Partial) and DIPM (Partial and Slumber) */
> +	ATA_LPM_MED_POWER_WITH_DIPM,
> +	/* 4 => HIPM (Partial and DevSleep) and DIPM (Partial and Slumber) */
> +	ATA_LPM_MIN_POWER_WITH_PARTIAL,
> +	/* 5 => HIPM (Slumber and DevSleep) and DIPM (Partial and Slumber) */
> +	ATA_LPM_MIN_POWER,
>   };
>   
>   enum ata_lpm_hints {

It feels really weird to have the values for the enum in the _comment_.
I'd rather drop them and just have the comments without values.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
