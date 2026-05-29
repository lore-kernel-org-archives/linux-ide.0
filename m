Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808083A2551
	for <linux-ide@vger.kernel.org>; Fri, 29 May 2026 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035724; cv=none; b=Fn3vl8CGENA9gcWpkwFupXwkEEBuN1SC25+bOyV35YF+7IApXlvyfODA9kyg3Ts8pjq73gotA32Gq2pVg+yDucTPN/CMejm3TYaYLVGCAKWBMte4uQ4RKSYt8d2B4AvReGORqwZ+d9V0eeM7YVgcp0X5QO6smWWK/L8fauoviVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035724; c=relaxed/simple;
	bh=Skg6ceva6nw6YUgI9AAHOvmaXpsxH+JHoGagp9HcMwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWo05gWkIVVHWI7dLz7af9bSU9Nq6zK3yFlKBPbpQ2i2zm7yHjNpk8iGZKrMaQETgiNSsuhMPLO0ZhJZ/TCsyfP5pjgwak9MKc3U++rZUifPi2JuNOD/nedDkgQjFxhR5QAQEqUbcF4QYeTS5fL3WDcJoTqSESX+gtNHTyYyPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HDJkJs4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RQF9ng7D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HDJkJs4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RQF9ng7D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HDJkJs4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RQF9ng7D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HDJkJs4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RQF9ng7D"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6FAA66E2C;
	Fri, 29 May 2026 06:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780035721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBn6pxnpqRpCAVX2cT2YTisOls4MBX+wA378OCDVcAY=;
	b=HDJkJs4X+G77nqI/zrZlPGAfUIkmxxRom6ZSwglbWuVQgzhg3UOnOkt2pOBtKC4Bcg/nCh
	Omfy1PMBR7dG7tGIrLSOw8Ds+ZaOBKICTNW2C/+md59fu9IT+F1s7pIJ6zQKZ3I1XU/VBP
	gU44UFCDyNMArYwTzvEw27HB8QTl1us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780035721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBn6pxnpqRpCAVX2cT2YTisOls4MBX+wA378OCDVcAY=;
	b=RQF9ng7Dh/Jywuq8av5EAvEyxa5qN2nGFKcRF652XFpkV0Spbwqxt0/KUJyHLf/ruZqTYG
	5yTnrVYLWqTRYCDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780035721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBn6pxnpqRpCAVX2cT2YTisOls4MBX+wA378OCDVcAY=;
	b=HDJkJs4X+G77nqI/zrZlPGAfUIkmxxRom6ZSwglbWuVQgzhg3UOnOkt2pOBtKC4Bcg/nCh
	Omfy1PMBR7dG7tGIrLSOw8Ds+ZaOBKICTNW2C/+md59fu9IT+F1s7pIJ6zQKZ3I1XU/VBP
	gU44UFCDyNMArYwTzvEw27HB8QTl1us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780035721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBn6pxnpqRpCAVX2cT2YTisOls4MBX+wA378OCDVcAY=;
	b=RQF9ng7Dh/Jywuq8av5EAvEyxa5qN2nGFKcRF652XFpkV0Spbwqxt0/KUJyHLf/ruZqTYG
	5yTnrVYLWqTRYCDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 899925B1CA;
	Fri, 29 May 2026 06:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RuhZH4kwGWoDGQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:22:01 +0000
Message-ID: <a58dc40d-265c-44d2-9090-bc296881668a@suse.de>
Date: Fri, 29 May 2026 08:22:01 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ata: libata-scsi: Remove lockdep_assert_held() in
 ata_scsi_translate()
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Marco Elver <elver@google.com>,
 linux-ide@vger.kernel.org
References: <20260528172855.703631-5-cassel@kernel.org>
 <20260528172855.703631-6-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260528172855.703631-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 5/28/26 19:28, Niklas Cassel wrote:
> lockdep_assert_held() indirectly calls __assume_ctx_lock(), which will
> suppress any real context analysis from being performed.
> 
> Remove the lockdep_assert_held(). This will be replaced with context
> analysis in a follow-up commit.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 2 --
>   1 file changed, 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
