Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968D92A8D0
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 06:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004315; cv=none; b=cMDmZCR3A7AvZglaBY4Ncq1syv97EwSw/6h/9xw4XoTXAMW/V6IWV924GYs/Xa8HQI5R/pxCDoWDRgV5dWMl0xR+GpoXqCP4Bpap9hDm43YpkoV4bG2Vve7R1/IvEjI2WAIcTbfJOObIXEWgGAoy1HS3UYgExGEWKlYebIvJAkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004315; c=relaxed/simple;
	bh=vZjCj3kcqGJQMKdiPcSR188bBpBArguTq9slfRzRdxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DADNsuqh1YOXEdVUUsWSXBDS+w9OOHLO6jBGBCthMSMs3YX5cq7CAB5LhqAwXEbVuCozMQbyUsCcM/HZ06pgkEcRq/uDZd7TPwspbea7mEDOwCb/9fA7RDryM/eHCMk/8m4ZyOwQzSRl0sKdonWRWIdIjfb6a+aZgfPheBg3rrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JUXrvio2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mvtnH734; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JUXrvio2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mvtnH734; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JUXrvio2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mvtnH734";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JUXrvio2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mvtnH734"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E63E91F387;
	Fri, 27 Jun 2025 06:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751004311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZurbjVyaJnXLJGUxOQ1/H476OkR9ZvFxEUd0hIes19E=;
	b=JUXrvio2kDWPyGbhOFRM7HCXn7aQIPiLVnHmFlqYris9fgEnRMqL1bL+69qPTIMzfKqg9s
	CcT9e7/Nn+qWpN1FYjFhOM8/bv5VQhv351pHJyTDqyfMRUkHFT135RshOZGtfX9FJ+fQk3
	XgXglnPRve9uaXar73tmMR2R7UvafXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751004311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZurbjVyaJnXLJGUxOQ1/H476OkR9ZvFxEUd0hIes19E=;
	b=mvtnH734cc6IC36I43FauYlf6+uNQ/746QfijGwpxDtxUeu+TYM9qz+jbZdBIwxENifJMM
	UwdjF5RRZYHZbLAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751004311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZurbjVyaJnXLJGUxOQ1/H476OkR9ZvFxEUd0hIes19E=;
	b=JUXrvio2kDWPyGbhOFRM7HCXn7aQIPiLVnHmFlqYris9fgEnRMqL1bL+69qPTIMzfKqg9s
	CcT9e7/Nn+qWpN1FYjFhOM8/bv5VQhv351pHJyTDqyfMRUkHFT135RshOZGtfX9FJ+fQk3
	XgXglnPRve9uaXar73tmMR2R7UvafXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751004311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZurbjVyaJnXLJGUxOQ1/H476OkR9ZvFxEUd0hIes19E=;
	b=mvtnH734cc6IC36I43FauYlf6+uNQ/746QfijGwpxDtxUeu+TYM9qz+jbZdBIwxENifJMM
	UwdjF5RRZYHZbLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B329313786;
	Fri, 27 Jun 2025 06:05:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XQzTKJc0XmjlMQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Jun 2025 06:05:11 +0000
Message-ID: <bdaadd4d-d7bc-4cb6-b171-c1c87a92a130@suse.de>
Date: Fri, 27 Jun 2025 08:05:11 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] ata: ahci: Clarify mobile_lpm_policy description
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250627011155.701125-1-dlemoal@kernel.org>
 <20250627011155.701125-6-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250627011155.701125-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Level: 

On 6/27/25 03:11, Damien Le Moal wrote:
> Despite its name, the mobile_lpm_policy module parameter defines the
> default LPM policy to use for an AHCI adapter for all chipsets,
> including desktop and server chipsets. Clarify this point in the
> parameter description.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/ahci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index e5e5c2e81d09..9347d0ec8793 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -674,7 +674,9 @@ MODULE_PARM_DESC(marvell_enable, "Marvell SATA via AHCI (1 = enabled)");
>   
>   static int mobile_lpm_policy = -1;
>   module_param(mobile_lpm_policy, int, 0644);
> -MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
> +MODULE_PARM_DESC(mobile_lpm_policy,
> +		 "Default LPM policy. Despite its name, this parameter applies "
> +		 "to all chipsets, including desktop and servers chipsets");
>   
>   static char *ahci_mask_port_map;
>   module_param_named(mask_port_map, ahci_mask_port_map, charp, 0444);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
