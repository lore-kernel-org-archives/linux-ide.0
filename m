Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C39D18DB0D
	for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771489225; cv=none; b=KB6i7LhiwIRw1XIG0uO8CvCnmXu8Uwc7jNO8htV272aLSJ/uCJ/s9+nbwfDYk1PS7IVDyG2I6V40rwViI9rMICKDy7BYbf+W1xgoYKldsQ2RYXTy5w9SjHD7r2C1i1BhPKLdIxykguiqqg7FaES4c79H7BnH4Tew/sT8QUttyzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771489225; c=relaxed/simple;
	bh=7udo/Gn+MW/uWR0AVHGtAofQOcPMb717ERCuTWCe8hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nztwC5uIxJQmHXDRNGoVZbwrOtluK9zBm+Bd+wqvad3BZTGxMweC2X8ffJqctSkFHS3bRCvwgnsPimk53FuVwh9U8BYVam0MI+MirbHuOM60H5dZUduV6ljDnPgHG9Bniui8syDJHynSOUwLvyPqB9x3VNnktjllrM2wnGpIzOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HnoEJDwg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zFnsGue7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HnoEJDwg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zFnsGue7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HnoEJDwg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zFnsGue7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HnoEJDwg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zFnsGue7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC3733E6ED;
	Thu, 19 Feb 2026 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771489222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+u23Oxa2R9GLB30+fQ3dkFKVKqqvV1h3Su3uIxcA4g=;
	b=HnoEJDwgA4Hl5kX6djYodjmigpLi2DJrSLtdGhamwSkQZ0JOeE6NsPf6BDrxJWXOYhg+j/
	LS0sQ42UgAj6PRErBK3JItNqn9f4vv1T2wWLvvlIAuDYqKm/zttn2Hc3MUeAowMzwQ0YBs
	9I5ehZlvJ3ctP+8Wyho/86xFLfzfOSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771489222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+u23Oxa2R9GLB30+fQ3dkFKVKqqvV1h3Su3uIxcA4g=;
	b=zFnsGue7206isKAKfikDDtxQsOpxdxwxQMl4txvwvUE0BU+AFl6We2cMKWKQNoq2RZKjX8
	ikRZ9CdC9H20nEDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HnoEJDwg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zFnsGue7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771489222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+u23Oxa2R9GLB30+fQ3dkFKVKqqvV1h3Su3uIxcA4g=;
	b=HnoEJDwgA4Hl5kX6djYodjmigpLi2DJrSLtdGhamwSkQZ0JOeE6NsPf6BDrxJWXOYhg+j/
	LS0sQ42UgAj6PRErBK3JItNqn9f4vv1T2wWLvvlIAuDYqKm/zttn2Hc3MUeAowMzwQ0YBs
	9I5ehZlvJ3ctP+8Wyho/86xFLfzfOSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771489222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+u23Oxa2R9GLB30+fQ3dkFKVKqqvV1h3Su3uIxcA4g=;
	b=zFnsGue7206isKAKfikDDtxQsOpxdxwxQMl4txvwvUE0BU+AFl6We2cMKWKQNoq2RZKjX8
	ikRZ9CdC9H20nEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8214F3EA65;
	Thu, 19 Feb 2026 08:20:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PxwkHsbHlmnfYgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 19 Feb 2026 08:20:22 +0000
Message-ID: <33348ad5-408e-407b-b378-f1036772f1bb@suse.de>
Date: Thu, 19 Feb 2026 09:20:18 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ata: libata-sata: simplify ata_sas_queuecmd()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260219062312.1030867-1-dlemoal@kernel.org>
 <20260219062312.1030867-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260219062312.1030867-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: AC3733E6ED
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 2/19/26 07:23, Damien Le Moal wrote:
> Change ata_sas_queuecmd() to return early the result of
> __ata_scsi_queuecmd() and remove the rc local variable.
> This simplifies the code without any functional change.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-sata.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reineke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
