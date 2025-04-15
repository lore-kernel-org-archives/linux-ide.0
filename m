Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD53433A8
	for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2025 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744699915; cv=none; b=tKqVOYylZ7Q/ptOLT3kg5dfjexLsMjv+9FD8nUozTzMRuxQet0bN6xXI6u17oN140na3mXlVxmGlQRzlpAfbYqAm+UNuTbSLycsvoRR2cxE9O2AzIpWV4QOSY9+NGNj07teajFipb1WvsH9nzYzWzWrGTU7sFxWmxQh5MpLpvEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744699915; c=relaxed/simple;
	bh=LcI0KWFFEC11TNcauEhwXE3Z/hVgcoS2vhGe/494R9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0BuTjShghblvabLpLEthiHA+TnLpoKn+9Bkvb2yyKSyN39X7Ocmw4NEKIKzRTcXNxAb84WRi+KJYZWHmAyIp3BenCJ0jtBBYUttWr2bCeZf5QL9/TA7odhDe5+qJSBmaP2kb6XZJ1Rd0SpV0HAsdONWFe7gyOHBYjZuyshSksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MpAXzgd9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+zc9m6+E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MpAXzgd9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+zc9m6+E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MpAXzgd9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+zc9m6+E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MpAXzgd9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+zc9m6+E"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F6011F38A;
	Tue, 15 Apr 2025 06:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744699911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2h/E9d2jVJqEGPbbfIAUl+9CwroCDdU5TaLidlsFf0=;
	b=MpAXzgd98B7Zftt7Dve4TgZbuxH8MNav7ofJHEPDrrZdfRpOipAlHWdhNoymp7dmldfyAC
	XqRG+14fT7d6W045EtQuKGB6y5jMSWt7uensTyEgNLRndjw4sPc7A3320d0n2TRACjsC6a
	8KmHpIrTsLUi1056MNmpbWNhFeS6SeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744699911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2h/E9d2jVJqEGPbbfIAUl+9CwroCDdU5TaLidlsFf0=;
	b=+zc9m6+ETAGZ0NaAJZsoECKwiG3A5J5/PtR86cI9DjCRKevJQrxRiDZoVfRL/MYyIFhtnq
	x/cjNpSOwvwr9KBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MpAXzgd9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+zc9m6+E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744699911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2h/E9d2jVJqEGPbbfIAUl+9CwroCDdU5TaLidlsFf0=;
	b=MpAXzgd98B7Zftt7Dve4TgZbuxH8MNav7ofJHEPDrrZdfRpOipAlHWdhNoymp7dmldfyAC
	XqRG+14fT7d6W045EtQuKGB6y5jMSWt7uensTyEgNLRndjw4sPc7A3320d0n2TRACjsC6a
	8KmHpIrTsLUi1056MNmpbWNhFeS6SeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744699911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2h/E9d2jVJqEGPbbfIAUl+9CwroCDdU5TaLidlsFf0=;
	b=+zc9m6+ETAGZ0NaAJZsoECKwiG3A5J5/PtR86cI9DjCRKevJQrxRiDZoVfRL/MYyIFhtnq
	x/cjNpSOwvwr9KBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2589C137A5;
	Tue, 15 Apr 2025 06:51:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id irlHBwcC/meEJQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 15 Apr 2025 06:51:51 +0000
Message-ID: <24c4c3a3-01a3-4f69-9fdc-8154ceceb5c3@suse.de>
Date: Tue, 15 Apr 2025 08:51:46 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata-sata: Simplify sense_valid fetching
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
References: <20250411132522.126316-3-cassel@kernel.org>
 <20250411132522.126316-4-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250411132522.126316-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F6011F38A
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/11/25 15:25, Niklas Cassel wrote:
> While the sense_valid field is 47 bits according to the specification,
> we are currently only fetching 32 bits, because these are the only
> bits that represent the tags (0-31), which is all we care about.
> 
> Thus, replace the existing logic with a simple get_unaligned_le32().
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-sata.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 2e4463d3a356..5ba79a1053ea 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1529,8 +1529,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
>   		return -EIO;
>   	}
>   
> -	sense_valid = (u64)buf[8] | ((u64)buf[9] << 8) |
> -		((u64)buf[10] << 16) | ((u64)buf[11] << 24);
> +	sense_valid = get_unaligned_le32(&buf[8]);
>   	extended_sense = get_unaligned_le16(&buf[14]);
>   	aux_icc_valid = extended_sense & BIT(15);
>   

Description is ever so misleading; we never fetched 47 bits to start
with. All we do is simplify the logic.
But whatever.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
