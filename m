Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B5233950
	for <linux-ide@vger.kernel.org>; Wed, 24 Jun 2026 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292970; cv=none; b=laGQ+7qqYv0UOguYt0vE9JGPdeJXWVEboKEuZgLUQGlfwycBVwaBk5zQ1dXqrPtoARLWCcSqkqwAPwfg/SrRvUzWv/lgPQzZL48tYwm5LZzrltgljtZpCHZCE3giVpfLrldq0gstjigk/h5mgcSTjVt7NOfYjkO54QJHDB7Fay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292970; c=relaxed/simple;
	bh=aQyP4VihOgG5EsN4mcZWHn/Gv5dvXUSTQ5KqZCDUXCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGUl/jAELNlxZkUpiizgHm24IGEGmHcZJCKLNXjkOrHSGMiqkTlCNhgnNuN1mbt5MB2/2hvBoowkHIbAwM/UYt71ICds9+T6KAnKcfoLnpX8F4gtofiZ0N9y0nMDBuf3OA112jNxNrXcOg2FsZfV7KSFZV+pDZY1mKuY+NZWdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0XYtUv3n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RlSZUBn1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0XYtUv3n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RlSZUBn1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0XYtUv3n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RlSZUBn1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0XYtUv3n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RlSZUBn1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F25A7621B;
	Wed, 24 Jun 2026 09:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782292958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aljUMV3wCcABhAMD19DBPt8T7Gk7zcwlV9Ib8cM+U04=;
	b=0XYtUv3nTdZXfC/bNXfV06Q9+VdmG1KFUBQTmmfdsYWgIDECHzuve415jJFdnvatD4ZXkt
	CzTiOoA6zz1YURnsMOOAz3NVFsN6Kl9xbZI9LxJ+MeupQ2z34ga+1CecjIEzsWGk5/FQSj
	pZj0K2A2vlHFHfumCwwpq63mRM75U1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782292958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aljUMV3wCcABhAMD19DBPt8T7Gk7zcwlV9Ib8cM+U04=;
	b=RlSZUBn1ThVCr7K8aHU7yqnfWAoVkkLGyw77dgNinsdQTvUUETWDGsZOuIUJ6PmCsi5nYu
	J3UhD8pqCBfYMpCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0XYtUv3n;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RlSZUBn1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782292958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aljUMV3wCcABhAMD19DBPt8T7Gk7zcwlV9Ib8cM+U04=;
	b=0XYtUv3nTdZXfC/bNXfV06Q9+VdmG1KFUBQTmmfdsYWgIDECHzuve415jJFdnvatD4ZXkt
	CzTiOoA6zz1YURnsMOOAz3NVFsN6Kl9xbZI9LxJ+MeupQ2z34ga+1CecjIEzsWGk5/FQSj
	pZj0K2A2vlHFHfumCwwpq63mRM75U1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782292958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aljUMV3wCcABhAMD19DBPt8T7Gk7zcwlV9Ib8cM+U04=;
	b=RlSZUBn1ThVCr7K8aHU7yqnfWAoVkkLGyw77dgNinsdQTvUUETWDGsZOuIUJ6PmCsi5nYu
	J3UhD8pqCBfYMpCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63998779A8;
	Wed, 24 Jun 2026 09:22:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4WRjF96hO2qEBQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jun 2026 09:22:38 +0000
Message-ID: <bbd49b9f-f1a4-4685-b8f7-2049a61fd86e@suse.de>
Date: Wed, 24 Jun 2026 11:22:37 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: fix ata_scsi_security_inout_xlat()
 buffer length conversion
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
References: <20260624090931.1483644-1-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260624090931.1483644-1-dlemoal@kernel.org>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F25A7621B
X-Spam-Score: -4.51

On 6/24/26 11:09 AM, Damien Le Moal wrote:
> ata_scsi_security_inout_xlat() converts the SCSI command buffer length
> into the ATA sector size based size by aligning upward the length to 512B.
> That is incorrect as that can lead to specifying a buffer size that is
> larger than the memory allocated for the command buffer, resulting in all
> sorts of possible command failures and/or memory corruptions.
> 
> Ideally, we should bounce the buffer to a large enough size to fit
> the entire SCSI command buffer, but we do not have anything in place to do
> that cleanly. So for now, fix this by converting the command buffer length
> downward with a simple division of the buffer length by ATA_SECT_SIZE.
> 
> Fixes: 818831c8b22f ("libata: implement SECURITY PROTOCOL IN/OUT")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d54ec1631e9a..e78801e7ea8c 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4330,7 +4330,13 @@ static unsigned int ata_scsi_security_inout_xlat(struct ata_queued_cmd *qc)
>   		}
>   
>   		/* convert to the sector-based ATA addressing */
> -		len = (len + 511) / 512;
> +		if (len) {
> +			len = len / ATA_SECT_SIZE;
> +			if (!len) {
> +				ata_scsi_set_invalid_field(qc->dev, scmd, 6, 0);
> +				return 1;
> +			}
> +		}
>   	}
>   
>   	tf->protocol = dma ? ATA_PROT_DMA : ATA_PROT_PIO;

round_down(), maybe?
To make the intention clear?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
