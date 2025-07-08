Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DD9299A98
	for <linux-ide@vger.kernel.org>; Tue,  8 Jul 2025 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961044; cv=none; b=JQlZxMslotYWFErrVXcnA4rZDcd9edeMu4fz+L+Jas3NlI+HpXvs/js59MwII2f/2mt5UnePcF6RMR5aOJMeecDBirgdRbZrb5FfzNZaR/ZXRLKAh0As5FCkVuikz2h3qGLZ3JIX5CRFy9P6EVhmv23F3mY59hTuVbURR4hvbEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961044; c=relaxed/simple;
	bh=uDCxYA3vrsWeElsTP9dpUgAnerhoEugkkVXPDhBfdYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hquIUpaceOeVfVTQXepYGSy1V7O1ZSJWgdWpshvjbkJ6Xgtc4cvRDsg01Ao1cbDnV5mPNn5Ge3EhyxuMBTZr+CNSuubCtenJl03VVJDYvZu7OBVoHFBPzuJwQh8dk/OgESTGmeJNy+/BFZ/yUMlYGKeF4tfwhmSv7hO+fav6C5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wSAmrYY/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AgJ10rv5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yNSBH4/9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FHgPr2y2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wSAmrYY/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AgJ10rv5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yNSBH4/9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FHgPr2y2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6A2F21160;
	Tue,  8 Jul 2025 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751961041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zP9Gv3LKtWm6uNwekdHVZ3UMN4KWFVFr/83/SnTz/f8=;
	b=wSAmrYY/snHYdq6d1otWESUuYwDj6JYKK73LFXeS967Grdawy4YV1C8tevuKWFq1Ug/F+j
	CTDJ5ZwkyBC3cKD3bn3gbk4p25pxnQP0phAVIH+0iTo5XHHYgod34S7AMF0Z4EUTp0hIA4
	IJDAZPT4VsZjnYqUM5VDvci7XiT3eTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751961041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zP9Gv3LKtWm6uNwekdHVZ3UMN4KWFVFr/83/SnTz/f8=;
	b=AgJ10rv5h5cJMY5wedc824ilOcx8VVGuPiFSS84htaJNkx2DTuKjl6UzdRnDEj7jLEcP03
	GnBRP7VggrkF39Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="yNSBH4/9";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FHgPr2y2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751961040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zP9Gv3LKtWm6uNwekdHVZ3UMN4KWFVFr/83/SnTz/f8=;
	b=yNSBH4/9Xcf2cgkYVO92V9nwSwM8vuJakjbVHH+SkW2Y9LxyibfF4RoYgyuEohfKA7EZ9z
	jOSk/JwTLQbmHE5Pu/9gDXEu4n8L3yNjqUut1Pv4SKKi4Xacnkmgvuq/bxV8EQqqPXKdzn
	1mL5qsvIFPzOp+fgmgSGNBot25XdEKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751961040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zP9Gv3LKtWm6uNwekdHVZ3UMN4KWFVFr/83/SnTz/f8=;
	b=FHgPr2y2BL3VADl85Djb3UpJhfV/nTYVBI7oynoFRuWtUiCFtQfwWCyuUXvKrzc+MMES5k
	CLoPUOho6H0HIcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDC6E13A54;
	Tue,  8 Jul 2025 07:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zg1+LdDNbGgbSwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 08 Jul 2025 07:50:40 +0000
Message-ID: <85aa9ff4-baa1-48ae-8301-8ed6fc7424ad@suse.de>
Date: Tue, 8 Jul 2025 09:50:25 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ata: libata-eh: Make ata_eh_followup_srst_needed()
 return a bool
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250708073648.45171-1-dlemoal@kernel.org>
 <20250708073648.45171-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250708073648.45171-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D6A2F21160
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 7/8/25 09:36, Damien Le Moal wrote:
> ata_eh_followup_srst_needed() returns an integer used as a boolean. So
> change this function to return that type.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-eh.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 42aafb1ddb5a..436536112043 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2781,15 +2781,15 @@ static int ata_do_reset(struct ata_link *link, ata_reset_fn_t reset,
>   	return reset(link, classes, deadline);
>   }
>   
> -static int ata_eh_followup_srst_needed(struct ata_link *link, int rc)
> +static bool ata_eh_followup_srst_needed(struct ata_link *link, int rc)
>   {
>   	if ((link->flags & ATA_LFLAG_NO_SRST) || ata_link_offline(link))
> -		return 0;
> +		return false;
>   	if (rc == -EAGAIN)
> -		return 1;
> +		return true;
>   	if (sata_pmp_supported(link->ap) && ata_is_host_link(link))
> -		return 1;
> -	return 0;
> +		return true;
> +	return false;
>   }
>   
>   int ata_eh_reset(struct ata_link *link, int classify,

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

