Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88691474B9
	for <linux-ide@vger.kernel.org>; Mon, 11 Nov 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319325; cv=none; b=U28JY5vuEwnngWiX9TK5inRJ03UVAktT8K3CKatojFIneTIBDotvN3dr2f8amwGHv6verbPm9CWpWHnXM/o9c2S9xkOZkObk6wpUQkgKhv49UDmaN4TaMDnSAzNI+nqJ9sY13aSSsYg3clCZVaZ6bzxzKeghA8+UPyzOpMcAK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319325; c=relaxed/simple;
	bh=1JjJLv+IseSM0r2ezpDhLLvpD3UKGrmMJG1dSgpgOrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jnk+Y4x159nADDHxcXiztPfhxk39IM2EFd5a06Vt95GLtUAnlkijmok43h4mpWgdkhFA0opfVpvuFtw9ozhATz9zdc08yOv5ucCAPhw7WbM6JdSjnwgMoSXKD4k1BZiVPuw86ZTlLqU2jta+DXYOIRvqI87WQLjHFEvnzPH/wgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fSR429kC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cAGJg376; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TuGCtYBs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tSNjP6oA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fSR429kC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cAGJg376";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TuGCtYBs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tSNjP6oA"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2DC31F38E;
	Mon, 11 Nov 2024 10:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731319322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5hWCmFZjdujlyQGhVjwuSneIt72TgW3TTYha0rIHv8=;
	b=fSR429kCpHY+OUjH5sxtU0ISlGMzjeRdR4VKBzfymGAE+Aan5fZy3hOc63jnu4hSB6pehH
	dii/9O4hGMicYcFA+Mu/Ymk3f4PUaKTgPClObyEobd5Cwv5NER7iToyCfPNx3zD7u/pqAH
	Npw2hpsfaIc2HH5ouxwcE7g+tx2xCi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731319322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5hWCmFZjdujlyQGhVjwuSneIt72TgW3TTYha0rIHv8=;
	b=cAGJg376P4+op5cruIxrGyUciTs1uvXhCs2bfGY6f18d9H8lHZh1lpm3BND1begEe5k9vM
	+sPJEAKDSsN1i2Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731319321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5hWCmFZjdujlyQGhVjwuSneIt72TgW3TTYha0rIHv8=;
	b=TuGCtYBsGgAv4yVswHDzw8y+tHNshEVLOEk/Vrwexysab2fKzN6ND5lUTjYcRxq8xTlssA
	oDMltpHWT9ET5ftn4fZ/8cO5NwOpPTEiOJcRZb+WQqRv+R1kamaRS1VTmTWgqdlOes7g0O
	3C3vDIU50P5Lf3n5vtnKO9SKqeZOBp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731319321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5hWCmFZjdujlyQGhVjwuSneIt72TgW3TTYha0rIHv8=;
	b=tSNjP6oAiKgSyKxHplobZ3b3U/Z00GeTGAR4gG5TMqDJvaf1BKz6gB5RMda4M7UG0wNVzx
	/Wa5QRmBXCJPAFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C181113301;
	Mon, 11 Nov 2024 10:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4C9+LhnWMWcEEAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 Nov 2024 10:02:01 +0000
Message-ID: <d408fb0d-7fac-427f-8647-c88692508c84@suse.de>
Date: Mon, 11 Nov 2024 11:02:01 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] ata: pata_legacy: use pr_*() instead of
 printk(KERN_*)
To: Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
References: <6cf8979c-c50d-4ef0-b1df-281d932d92b6@omp.ru>
 <5d048235-2bac-4a27-b0ce-32e2aec298cb@omp.ru>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5d048235-2bac-4a27-b0ce-32e2aec298cb@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 11/8/24 21:23, Sergey Shtylyov wrote:
> The PATA legacy device driver still calls printk(KERN_ERR, ...) in
> legacy_probe_add() and printk(KERN_INFO, ...) in probe_chip_type()
> and probe_opti_vlb() -- convert them to calling pr_err() and pr_info()
> respectively, also joining the broken up message strings...
> 
> This helpfully fixes the following complaints from scripts/checkpatch.pl:
> 
> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
> dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> 
> WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
> dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
> 
> WARNING: quoted string split across lines
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
>   drivers/ata/pata_legacy.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
> index e7ac142c2423..9c6918e48448 100644
> --- a/drivers/ata/pata_legacy.c
> +++ b/drivers/ata/pata_legacy.c
> @@ -209,7 +209,7 @@ static int legacy_probe_add(unsigned long port, unsigned int irq,
>   		lp++;
>   	}
>   	if (free == NULL) {
> -		printk(KERN_ERR "pata_legacy: Too many interfaces.\n");
> +		pr_err("pata_legacy: Too many interfaces.\n");
>   		return -1;
>   	}
>   	/* Fill in the entry for later probing */
> @@ -927,8 +927,7 @@ static __init int probe_chip_type(struct legacy_probe *probe)
>   
>   		if ((inb(0x1F2) & 0x80) == 0) {
>   			/* PDC20230c or 20630 ? */
> -			printk(KERN_INFO  "PDC20230-C/20630 VLB ATA controller"
> -							" detected.\n");
> +			pr_info("PDC20230-C/20630 VLB ATA controller detected.\n");
>   			udelay(100);
>   			inb(0x1F5);
>   			local_irq_restore(flags);
> @@ -938,8 +937,7 @@ static __init int probe_chip_type(struct legacy_probe *probe)
>   			inb(0x1F2);
>   			inb(0x1F2);
>   			if (inb(0x1F2) == 0x00)
> -				printk(KERN_INFO "PDC20230-B VLB ATA "
> -						     "controller detected.\n");
> +				pr_info("PDC20230-B VLB ATA controller detected.\n");
>   			local_irq_restore(flags);
>   			return BIOS;
>   		}
> @@ -1096,8 +1094,7 @@ static __init void probe_opti_vlb(void)
>   	u8 ctrl = (opti_syscfg(0x30) & 0xC0) >> 6;
>   
>   	opti82c46x = 3;	/* Assume master and slave first */
> -	printk(KERN_INFO DRV_NAME ": Opti 82C46%s chipset support.\n",
> -								optis[ctrl]);
> +	pr_info(DRV_NAME ": Opti 82C46%s chipset support.\n", optis[ctrl]);
>   	if (ctrl == 3)
>   		chans = (opti_syscfg(0x3F) & 0x20) ? 2 : 1;
>   	ctrl = opti_syscfg(0xAC);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
