Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C073451
	for <linux-ide@vger.kernel.org>; Tue, 24 Sep 2024 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160226; cv=none; b=Ol2gXYzrhttlaA53ttMwVlK48FRld/nsTecRPR2pCiIzIPp7k1Ng+owouCoDNnlFSKKw4paezrtlIueTNs39UdYEGpI/pd5VFsoxtqcixHN2svgCwFuDI+DYdrWGxcvpGWH1QP8wQ1slowMpLP+auCEXlMa+W5lOMFCjLhIH8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160226; c=relaxed/simple;
	bh=eC0h1XfK90rTDNXtyl0F9lpZGxgxOq1z7Tj6gXmn5g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V86YcYG3xWT1gXEcnsTxde/k4igaYWvjywJKV3GFoXwqfjB4acMDyec95BU6kNnTycv+fiuuQsoDpubOllve+ExEFOKi8iEQWkhKoOqa2ZHDY6fX9KtvPZgwtLgPzSwFQi2YYOk2IQCjqPMfWQSc7YXWFz/h1Who1Z/lpuimUoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c0kx7NFN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nrjA23ER; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c0kx7NFN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nrjA23ER; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c0kx7NFN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nrjA23ER";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c0kx7NFN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nrjA23ER"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0553521AE1;
	Tue, 24 Sep 2024 06:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727160223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuP3dvvgsHE9qvAO9s+KXQuzbAl0PDUJ1kFX523GDhI=;
	b=c0kx7NFNpIaZo8FfvqOs8MbutSQTlujeOSTED293+cJgdr0IFbJE6Tu2TcsynlnhJdefjG
	WLV3BVAW89Z8ZNiJGyPPyQhOo2WSwRDWMqWzO3btOZ4t5+thsVgpAV8kDZCYsJEdLmI1+1
	EaKw+MdUuDcAfmP+EF9Pj8+ih7neDJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727160223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuP3dvvgsHE9qvAO9s+KXQuzbAl0PDUJ1kFX523GDhI=;
	b=nrjA23ERRE/zC4gfQUhHmpLxNnXaICW5IYnRQWzmuike0/jLpATa9GTVuzEj0Ia32e+xPw
	RZPsp5goyvL4gjBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c0kx7NFN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nrjA23ER
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727160223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuP3dvvgsHE9qvAO9s+KXQuzbAl0PDUJ1kFX523GDhI=;
	b=c0kx7NFNpIaZo8FfvqOs8MbutSQTlujeOSTED293+cJgdr0IFbJE6Tu2TcsynlnhJdefjG
	WLV3BVAW89Z8ZNiJGyPPyQhOo2WSwRDWMqWzO3btOZ4t5+thsVgpAV8kDZCYsJEdLmI1+1
	EaKw+MdUuDcAfmP+EF9Pj8+ih7neDJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727160223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuP3dvvgsHE9qvAO9s+KXQuzbAl0PDUJ1kFX523GDhI=;
	b=nrjA23ERRE/zC4gfQUhHmpLxNnXaICW5IYnRQWzmuike0/jLpATa9GTVuzEj0Ia32e+xPw
	RZPsp5goyvL4gjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2D471386E;
	Tue, 24 Sep 2024 06:43:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cs+tJ55f8mZzVwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 24 Sep 2024 06:43:42 +0000
Message-ID: <6c6b139e-f941-4a46-a317-e45c4da4d886@suse.de>
Date: Tue, 24 Sep 2024 08:43:38 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: libata-scsi: Fix ata_msense_control_spgt2()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20240923133949.286295-1-dlemoal@kernel.org>
 <20240923133949.286295-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240923133949.286295-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0553521AE1
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 9/23/24 15:39, Damien Le Moal wrote:
> ata_msense_control_spgt2() can be called even for devices that do not
> support CDL when the user requests the ALL_SUB_MPAGES mode sense page,
> but for such device, this will cause a NULL pointer dereference as
> dev->cdl is NULL. Similarly, we should not return any data if
> ata_msense_control_spgt2() is called when the user requested the
> CDL_T2A_SUB_MPAGE or CDL_T2B_SUB_MPAGE pages for a device that does not
> support CDL.
> 
> Avoid this potential NULL pointer dereference by checking if the device
> support CDL on entry to ata_msense_control_spgt2() and return 0 if it
> does not support CDL.
> 
> Reported-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
> Tested-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
> Fixes: 602bcf212637 ("ata: libata: Improve CDL resource management")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 061fe63497bf..97c84b0ec472 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2245,10 +2245,15 @@ static inline u16 ata_xlat_cdl_limit(u8 *buf)
>   static unsigned int ata_msense_control_spgt2(struct ata_device *dev, u8 *buf,
>   					     u8 spg)
>   {
> -	u8 *b, *cdl = dev->cdl->desc_log_buf, *desc;
> +	u8 *b, *cdl, *desc;
>   	u32 policy;
>   	int i;
>   
> +	if (!(dev->flags & ATA_DFLAG_CDL) || !dev->cdl)
> +		return 0;
> +
> +	cdl = dev->cdl->desc_log_buf;
> +
>   	/*
>   	 * Fill the subpage. The first four bytes of the T2A/T2B mode pages
>   	 * are a header. The PAGE LENGTH field is the size of the page

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

