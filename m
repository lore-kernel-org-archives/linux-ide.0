Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EA8199920
	for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049802; cv=none; b=NMM/GnszSCUZFQ7UTdEj4sbTFy7+jw08UCkN0qCdigopm4h5WmJc2w2rZpSnh9MRVpc5rhT4cyL5fRC7g7BJsD8aNJwq7atxTQfskqFeRbYAISsQnWVuP8nHpcLJISCOA7nXei7aIBYdIuVC1dBfUwU6YTitlFGMqpfbj9jpYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049802; c=relaxed/simple;
	bh=vOyLlNmu3NLeQonemImfAwlA8jYEumFpngJD1FVoxdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hewf0LbPrzONsOlCYQWy+CE4NUL/il5eUSnltx7zFRTIiyQTunfA5JcPP5rUv/FQz2n1y/aILIAL9GnBGBEK9GWS3fy1MYpSTmtXlUNBVKj+FjGOKusHAurrm+fYtIfq6dReusOnKGRdjqNcJc277EFhurfF8sspxRBR0XHFTog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WS6EkQx5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wsHI/z3p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WS6EkQx5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wsHI/z3p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WS6EkQx5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wsHI/z3p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WS6EkQx5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wsHI/z3p"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B0BB33710;
	Thu, 18 Dec 2025 09:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766049798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPWLIKe105+r4LDVOgIMzsoDys1VyL4u7KoYtrrWl1E=;
	b=WS6EkQx5jiSVL869iEBuvbmjPNlrzTlPU4ro8qZFJDsE2w5XENI9TfNRYJuaVTaXCZ2MSb
	X/kkjS/vzba1y69CYQaclfdN/mJ6auqNzyZJ5LO33OtTAZm4vGOXbjBOD624kemDeP5dah
	ydew0PjtxlnLRi4iuiwqj35wxeC5C5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766049798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPWLIKe105+r4LDVOgIMzsoDys1VyL4u7KoYtrrWl1E=;
	b=wsHI/z3pRtuae8ChwjOQpBTcNsQVhdA+/5VSw//iy5lDyvyDuT0TsKIXnrF+GONkSUm3Hy
	jFoSxloW2UfZPICQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766049798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPWLIKe105+r4LDVOgIMzsoDys1VyL4u7KoYtrrWl1E=;
	b=WS6EkQx5jiSVL869iEBuvbmjPNlrzTlPU4ro8qZFJDsE2w5XENI9TfNRYJuaVTaXCZ2MSb
	X/kkjS/vzba1y69CYQaclfdN/mJ6auqNzyZJ5LO33OtTAZm4vGOXbjBOD624kemDeP5dah
	ydew0PjtxlnLRi4iuiwqj35wxeC5C5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766049798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPWLIKe105+r4LDVOgIMzsoDys1VyL4u7KoYtrrWl1E=;
	b=wsHI/z3pRtuae8ChwjOQpBTcNsQVhdA+/5VSw//iy5lDyvyDuT0TsKIXnrF+GONkSUm3Hy
	jFoSxloW2UfZPICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13EDA3EA63;
	Thu, 18 Dec 2025 09:23:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 09iTAwbIQ2lTIgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Dec 2025 09:23:18 +0000
Message-ID: <309c96aa-e6ae-4bd3-8488-0e193a731bec@suse.de>
Date: Thu, 18 Dec 2025 10:23:17 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: libata-scsi: refactor ata_scsi_translate()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>, Xingui Yang <yangxingui@huawei.com>
References: <20251217231712.490765-1-dlemoal@kernel.org>
 <20251217231712.490765-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251217231712.490765-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.16)[-0.795];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.26

On 12/18/25 00:17, Damien Le Moal wrote:
> Factor out of ata_scsi_translate() the code handling queued command
> deferral using the port qc_defer callback into the new function
> ata_scsi_defer(), and simplify the goto used in ata_scsi_translate().
> While at it, also add a lockdep annotation to check that the port lock
> is held when ata_scsi_translate() is called.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 66 ++++++++++++++++++++++++---------------
>   1 file changed, 40 insertions(+), 26 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
