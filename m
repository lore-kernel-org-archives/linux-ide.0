Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650EF3382CB
	for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2026 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771489368; cv=none; b=XG96KpH3GsUBgouWr/owMWdCYooKD+r5gQJxrbTGUvirJ42AK46s7a8YLjK/PsNMwvsLLKyP0w2zP6piP7235L+CYNuxZ3osfde2c5w2YPnWpTmHkGPEDXtweG5SOBwLpofHK2FqAJsbF4+6Mr75a8XS9VHzP8RuME/tq0eJ7dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771489368; c=relaxed/simple;
	bh=SkLQlRydiWCMmSev3yFdvvwHKqRD9kduUJzV2BB4d60=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SLx4PgR3GLbiGBEGxUj1NLkhDWj6vwEDHeYH+1eq6RxVuroND9yCtkgU9nB2zw+WuLBkBPnYpHmWK6S4u44pEjRq0yig4I/Wgwm1su1554opkS4trqOI8zePba+yACe6E9JqJ81cPDzDzLSTXogtAyDir6hRV0xZY/qw+lTspow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tMp5LZyY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QMFzWHrV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tMp5LZyY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QMFzWHrV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tMp5LZyY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QMFzWHrV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tMp5LZyY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QMFzWHrV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A938A3E6ED;
	Thu, 19 Feb 2026 08:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771489365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKdea7dftZSxZnEPWEkOVNT25JwALtvrAvRpr6kcSQo=;
	b=tMp5LZyYzC6vjH7Ei31g5XyhrOOfrB5cetg1QISn9v+4RmWpgw9LudBb4ZnfxVdNCBpAjX
	OGUk4a1dDwQtB6Y3UUlLSSYF2avWB7AQMWSpZCoDfG/P9A5CLBPlmLSo2eUFSKVu8XLJa5
	f7uV+/LZThqB+cZ6ieuBWZkOQ0fF6DM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771489365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKdea7dftZSxZnEPWEkOVNT25JwALtvrAvRpr6kcSQo=;
	b=QMFzWHrVb/hYUyWa3zNyGHT9801ED/PMDmRMpz5Z8EkLZDC9K7rDjdcmqCEjKcEXdGRHzW
	Sq/PskAevVE2azAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771489365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKdea7dftZSxZnEPWEkOVNT25JwALtvrAvRpr6kcSQo=;
	b=tMp5LZyYzC6vjH7Ei31g5XyhrOOfrB5cetg1QISn9v+4RmWpgw9LudBb4ZnfxVdNCBpAjX
	OGUk4a1dDwQtB6Y3UUlLSSYF2avWB7AQMWSpZCoDfG/P9A5CLBPlmLSo2eUFSKVu8XLJa5
	f7uV+/LZThqB+cZ6ieuBWZkOQ0fF6DM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771489365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKdea7dftZSxZnEPWEkOVNT25JwALtvrAvRpr6kcSQo=;
	b=QMFzWHrVb/hYUyWa3zNyGHT9801ED/PMDmRMpz5Z8EkLZDC9K7rDjdcmqCEjKcEXdGRHzW
	Sq/PskAevVE2azAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 763D53EA65;
	Thu, 19 Feb 2026 08:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tvlJG1XIlmngZQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 19 Feb 2026 08:22:45 +0000
Message-ID: <dba69aaa-9c8b-4de0-8e3e-56e931b5051e@suse.de>
Date: Thu, 19 Feb 2026 09:22:37 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ata: libata-scsi: make ata_scsi_simulate() static
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260219062312.1030867-1-dlemoal@kernel.org>
 <20260219062312.1030867-5-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260219062312.1030867-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO

On 2/19/26 07:23, Damien Le Moal wrote:
> ata_scsi_simulate() is called only from libata-scsi.c. Move this
> function definition as a static function before its call in
> __ata_scsi_queuecmd() and remove its declaration from
> include/linux/libata.h.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 147 +++++++++++++++++++-------------------
>   include/linux/libata.h    |   1 -
>   2 files changed, 73 insertions(+), 75 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
