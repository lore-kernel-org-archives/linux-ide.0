Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AABF137747
	for <linux-ide@vger.kernel.org>; Mon, 11 Nov 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319193; cv=none; b=i+d1dA/q2MRx8reYP4vUoOjk41t2Oe/2r/4yN6MYLxKJYgRmxOycKE1toXntXDWXsFVwnouPaWlX5sSyjv0vuXmrbQOU2ppiyJg1X7POVriGFqudPjZ4JMVO+LWK/j/n53i0CwREEE/K6oRqVFP3hQPgsUa7VwfB8IQ7ykvtV5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319193; c=relaxed/simple;
	bh=9vpNTfe5pat2WiCEAA3uPQR3GIVamQo8c/mxAGOcA/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nAoafnIUh/oJXLUpsiziMZD/MGORtTyVpzxydIKDWmVvzU2CQO2h1hDF+32gLabPM4i7wlPZVe964fl4PyZj1c+fmYRWOQj1jRpilF/ZNB2JOqujTC5wpkqYESnUMVDHVkCyGNRQ2xjxtfCyspdAwmRuirXyt4YNn3FI4EFoR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EzNqbQnl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CP6fCwxz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EzNqbQnl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CP6fCwxz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EzNqbQnl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CP6fCwxz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EzNqbQnl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CP6fCwxz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C70F1F38E;
	Mon, 11 Nov 2024 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731319189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTfMxJW+sN/4q/S6KFACwE4J3geecSFjFQd7tZb88VU=;
	b=EzNqbQnlUkxhlGiefyx8AaSez98VuUsO6NUnMBnJ2cnvXA5ETPhQL8pvW2vdakG60YAnRN
	7RVHcxAX/+/djsossI8YkoBGu2/1FNJRYWShTPU8jrgNKUDAcf4PHLevFf487ma2ASnhxZ
	NL7br8+o7Lb77hY/sBMQudHWPEKsdRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731319189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTfMxJW+sN/4q/S6KFACwE4J3geecSFjFQd7tZb88VU=;
	b=CP6fCwxzZtlFZ13PhV4RWbIHAOgHzefDQzH6vKqupQUaQEbD5GeRzNe7z1JRux0Ad873gm
	YCT+vW4ij+Ly12CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EzNqbQnl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CP6fCwxz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731319189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTfMxJW+sN/4q/S6KFACwE4J3geecSFjFQd7tZb88VU=;
	b=EzNqbQnlUkxhlGiefyx8AaSez98VuUsO6NUnMBnJ2cnvXA5ETPhQL8pvW2vdakG60YAnRN
	7RVHcxAX/+/djsossI8YkoBGu2/1FNJRYWShTPU8jrgNKUDAcf4PHLevFf487ma2ASnhxZ
	NL7br8+o7Lb77hY/sBMQudHWPEKsdRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731319189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTfMxJW+sN/4q/S6KFACwE4J3geecSFjFQd7tZb88VU=;
	b=CP6fCwxzZtlFZ13PhV4RWbIHAOgHzefDQzH6vKqupQUaQEbD5GeRzNe7z1JRux0Ad873gm
	YCT+vW4ij+Ly12CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3217C13301;
	Mon, 11 Nov 2024 09:59:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xs62C5XVMWccDwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 Nov 2024 09:59:49 +0000
Message-ID: <3d63d5e1-668a-4d21-9655-d5e688429615@suse.de>
Date: Mon, 11 Nov 2024 10:59:48 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ata: acard-ahci: use dev_info() instead of,
 printk(KERN_INFO)
To: Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
References: <6cf8979c-c50d-4ef0-b1df-281d932d92b6@omp.ru>
 <ca23d30e-7444-4490-a7f2-7020e8cf6fb9@omp.ru>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ca23d30e-7444-4490-a7f2-7020e8cf6fb9@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C70F1F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 11/8/24 21:16, Sergey Shtylyov wrote:
> The ACard AHCI PCI device driver still calls printk(KERN_INFO, ...) in its
> probe() method -- convert it to calling dev_info(), also somewhat rewording
> the message itself...
> 
> This helpfully fixes the following complaint from scripts/checkpatch.pl:
> 
> WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
> dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
>   drivers/ata/acard-ahci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
> index 547f56341705..0e16e64d1c5d 100644
> --- a/drivers/ata/acard-ahci.c
> +++ b/drivers/ata/acard-ahci.c
> @@ -415,7 +415,7 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
>   	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
>   		host->flags |= ATA_HOST_PARALLEL_SCAN;
>   	else
> -		printk(KERN_INFO "ahci: SSS flag set, parallel bus scan disabled\n");
> +		dev_info(&pdev->dev, "AHCI SSS flag set, parallel bus scan disabled\n");
>   
>   	for (i = 0; i < host->n_ports; i++) {
>   		struct ata_port *ap = host->ports[i];

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
