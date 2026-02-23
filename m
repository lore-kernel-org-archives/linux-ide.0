Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE86335C1B4
	for <linux-ide@vger.kernel.org>; Mon, 23 Feb 2026 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848582; cv=none; b=lfn+3KHlX7nDXfLvLa76TfPG87a/+WEtZMSie1FJmk9YDjKqSrQwP/qDXWim9uMqHLJmXn44kRrmRaOsfM3vXGEG5Vo9FeXt3ZCohFD1LmhwD+7LMiXvSx39X98NFHBobQQL1rY0hepzvm3+E/B9akMa0d3x8E0+aEMecxZpirM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848582; c=relaxed/simple;
	bh=93wpzq27VSeZYgca0FEwSN5btWqnQHiYr015d2Ytz10=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h0jIBxj3chEX1YJMTO2HY2kRpsayiwO7Hh8yHjziyyThcsNfGu9vYcbeKpKndPjWCEPEVIyVfjJTCCytf7tFKdO/+OYvhmMRPE+yfgDyG0vztLm7NlbZCcYEYTgcoMtTLWVUThUTCooHIBsVjdGLDik5jf0pwtvHIJZA5/vEphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MDcsPB1Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uQDm22O2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VAWm8trO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DrUcPpYc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MDcsPB1Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uQDm22O2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VAWm8trO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DrUcPpYc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA8165BD12;
	Mon, 23 Feb 2026 12:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771848579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ne9bz9icA2RpvnD9mM6snq1tPivc6nD+FfaSPe0KnY=;
	b=MDcsPB1QX4ovNrwrGueYB3sEEIM3c2C1wqYjp8/byjr1iEeIQn53TBV0Zpcs75Yd4wBJSZ
	r9nADsUrCoZLjwcQDPFcZPFbEnwcVEmbHRaNuM5crj1N0dPA16eWPLvyZjIdq6N1y6WSfZ
	7mpTUaGggQ2dgyYwHH6YuGoCnodwitc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771848579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ne9bz9icA2RpvnD9mM6snq1tPivc6nD+FfaSPe0KnY=;
	b=uQDm22O2mDKDR+hfxSW2VVx5PY6D6KY8xdO8jFiTnEx7Kxr0J5CUWR1gHzQxDcSU6k2Gk4
	jmcfrH2tZFgXYuBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VAWm8trO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DrUcPpYc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771848578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ne9bz9icA2RpvnD9mM6snq1tPivc6nD+FfaSPe0KnY=;
	b=VAWm8trOZH3TgJhx6tUt+J4D05Ima5+i4emVB3+R4ivGTsFh8ncmWrKxHlGVKd/MMsv6Bh
	joHAsgSr1pk00Cplp89yLAKFODMXSGiTjFrttNs3Y49ongxk0BqQpNQ0+o272GpLZL9bos
	CR1Qt/P1IMQVolxUpOgurZZz8K0gVao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771848578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ne9bz9icA2RpvnD9mM6snq1tPivc6nD+FfaSPe0KnY=;
	b=DrUcPpYcMGYHk7d1IU4k7J3c34qExqalvBCkF9rXyjA0hKaClx2Q0ff/9nVPEHe78TtbE+
	yTq/41yjQnYAzCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D299F3EA68;
	Mon, 23 Feb 2026 12:09:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zwrsMoJDnGlRUwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 12:09:38 +0000
Message-ID: <633f2603-6460-484a-88b2-d8da7b2ec858@suse.de>
Date: Mon, 23 Feb 2026 13:09:38 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ata: libata-core: fix cancellation of a port
 deferred qc work
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <20260220221439.533771-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260220221439.533771-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: EA8165BD12
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 2/20/26 23:14, Damien Le Moal wrote:
> cancel_work_sync() is a sleeping function so it cannot be called with
> the spin lock of a port being held. Move the call to this function in
> ata_port_detach() after EH completes, with the port lock released,
> together with other work cancellation calls.
> 
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-core.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
