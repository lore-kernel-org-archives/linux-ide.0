Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4862B349CC2
	for <linux-ide@vger.kernel.org>; Fri, 10 Jul 2026 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694199; cv=none; b=iyMsSeDuIZ6YD6sAi/v2wGzsB7JqueFpOarIcbcnpP3s24LQbf1vRX7eAPY6AaMYY004JHVMo3U8U3gOx6doXudiqZ7Yeo0aCdlXMDNjNVu0MSvA4y01wjGRs2nkBgoeuverUCoJTZ2Yo86TZAXWatEYrRx1MyXfDsNEuIJxc9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694199; c=relaxed/simple;
	bh=pIsTvevDMkCZW/p6HTWeOGIuGGYiIPZlcBMHLN2yqh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jsUCZ8ZFjNVgdzCpGfBd6PW5qB1j10DCe9NEb6zmauBE0oyDqU2xZPAs09TluyT8y3ascde7Nzt2J5ZTVc8fjSJETMM7F7IR1FQTctyx5wVqW9LRXsnXgk1/+L5+V0irOwclEknAQ4Nok+sNXA0THhMaLJWOobOtKH8mY4r6oXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ECrH5ymg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fz2UH268; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ggKb7Byl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HZWXBZ6y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ECrH5ymg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fz2UH268";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ggKb7Byl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HZWXBZ6y"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E90075356;
	Fri, 10 Jul 2026 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783694191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlleccKtuetlUE2coYriEAVOWkj0/rHoT6knZXTFMGU=;
	b=ECrH5ymgOK8uI9GgwHodZaL2Josrxl8IDsgaZdCOIwTsGf990JM34B9AkVadJfAQMomJKZ
	AKXfruBWLvMDPLIgZJU+JNLJW4mwYRYcz5lRKsNlm0tEWj+USKQgUBJSW96E5CQ+aPIaI9
	2No4ZgnySbxe1Jjm3Zu0fGJmcCcWQks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783694191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlleccKtuetlUE2coYriEAVOWkj0/rHoT6knZXTFMGU=;
	b=fz2UH268ALu/cYrm9mep63PwgBzCKFrWhOhJXN4lQOQA2r8oGJUcdagysvTUMLO9pZ3jN1
	0ZOf/eLC9314S3AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ggKb7Byl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HZWXBZ6y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783694190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlleccKtuetlUE2coYriEAVOWkj0/rHoT6knZXTFMGU=;
	b=ggKb7BylZKrpnbivcUdhwma2SjaQL3wby5bQYiz8S6QRdk4JzCQNHWZwYhlXwdkrkeMfr6
	YdZvlWQiNdHKcJqHIqassjl0s8CFZnE/+mP5ShqIswEzEb2xIxThJlu/y3I7uVid+fFrpw
	o5PQpEu3CV/7rZlEQXSWTQomk7Cq5k0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783694190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlleccKtuetlUE2coYriEAVOWkj0/rHoT6knZXTFMGU=;
	b=HZWXBZ6ybTyBs2dQqSqkRiGaFqG45F6OWkrYJUf7pAyT+NlF1X5MnNfrwsia5KIgpnTqoo
	77Gc5U2f98kD/3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E139C779BD;
	Fri, 10 Jul 2026 14:36:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 20PCMW0DUWriTgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 10 Jul 2026 14:36:29 +0000
Message-ID: <377b2235-d163-4290-a7e8-5e5f1b4454ec@suse.de>
Date: Fri, 10 Jul 2026 16:36:14 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Remove redundant dev_err()
To: Pan Chuang <panchuang@vivo.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260710110247.426444-1-panchuang@vivo.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260710110247.426444-1-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,vivo.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1E90075356
X-Spam-Score: -4.51

On 7/10/26 1:02 PM, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>   drivers/ata/pata_mpc52xx.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 210a63283f62..1739743427cf 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -769,10 +769,8 @@ static int mpc52xx_ata_probe(struct platform_device *op)
>   	task_irq = bcom_get_task_irq(dmatsk);
>   	rv = devm_request_irq(&op->dev, task_irq, &mpc52xx_ata_task_irq, 0,
>   				"ATA task", priv);
> -	if (rv) {
> -		dev_err(&op->dev, "error requesting DMA IRQ\n");
> +	if (rv)
>   		goto err2;
> -	}
>   	priv->dmatsk = dmatsk;
>   
>   	/* Init the hw */
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
