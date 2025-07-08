Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD252BDC0C
	for <linux-ide@vger.kernel.org>; Tue,  8 Jul 2025 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961108; cv=none; b=nCF5rPOXmntxE00o9iEOFOhEobLkP27hgDqXEhCUPTyOUndms62ntyDC8trYQixCUIYqdGYw/W0nPvVdoHw6vvKQNe0IcO4rDvP/D708hXACdrFPettsdAdBCos6sCW71ys/Anu3RyINi4z6RhwXtn3Hg1YI1e8A5Md0C6JC1EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961108; c=relaxed/simple;
	bh=UdSQu6aKWQSaknT2GPckXesUIjoi5LwY1CSQrtNkwc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kjFBBp+MCmw9aOZicE9H+/nQmLgEywcINV8S7PF4425sts4WzDT5sFPRRdcKIx2p52rLttVfb3smL2DaiOQqe5H+D0LQq9hNFI+6eqaQwRahx9KyhxF+HbjN5okZXiKGpBRn8O59ZLRoZSxIbQIAMFx16M53wTcy7KyDcvB2Bnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M00KIxYC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JrnqwA9G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HDVQ7n5k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=17RfZ/FR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M00KIxYC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JrnqwA9G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HDVQ7n5k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="17RfZ/FR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFFBD1F395;
	Tue,  8 Jul 2025 07:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751961104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSghCudRQc1YhDHDX58M7n2om9GAES7SJn+toHk8atM=;
	b=M00KIxYCiu3Xf7VEZIsXY8sVPb3QRajXhm8SHSI8YeTf7Ke82KaJpId/b6AfJ/IDOgI3TF
	wuE5JPXemdlbuRTX9vO5tqqSHB1ZcFVGjzwJDa0UnOhKUIadBScYtcv6l5Dmiw2W9s6nGb
	+PCcL4nxDwiJMYyM8AnHYbI6XmzSGHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751961104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSghCudRQc1YhDHDX58M7n2om9GAES7SJn+toHk8atM=;
	b=JrnqwA9GIS91p/weFPjpaGLvpV6CjEyTiRHHLhKrFHsJkO8RLFyRXIV32huyhGmBAuJjPY
	1ijPqjN3V1oib1Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HDVQ7n5k;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="17RfZ/FR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751961103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSghCudRQc1YhDHDX58M7n2om9GAES7SJn+toHk8atM=;
	b=HDVQ7n5khgrdkkkWqiBBaOCGVxE+Yy/iQnmq6BOMG3SVqemOgrS+2A3VodSu0UdufgBp6h
	rgyeqf4XOcTLURZdZytCdjvFbctlG1DE6KzI/Yk44ZKxoGl5g4HWKqOPCsqRy9ZYjiojFL
	hSy5Zdxy8RHsXELPtDFdDjM7AfQmsLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751961103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSghCudRQc1YhDHDX58M7n2om9GAES7SJn+toHk8atM=;
	b=17RfZ/FR8uh+dmHl5rvEKcKfULqs+TjPcJWyQZfy/68U8kS/f9foKF45WD/obpMecr+WbW
	ZOAQNEtXwc+w68DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEC8F13A54;
	Tue,  8 Jul 2025 07:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tvlaMQ/ObGhtSwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 08 Jul 2025 07:51:43 +0000
Message-ID: <f48a37d1-1728-4b5a-838c-749beab90f9a@suse.de>
Date: Tue, 8 Jul 2025 09:51:39 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ata: libata-eh: Remove ata_do_eh()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250708073648.45171-1-dlemoal@kernel.org>
 <20250708073648.45171-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250708073648.45171-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EFFBD1F395
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.51

On 7/8/25 09:36, Damien Le Moal wrote:
> The only reason for ata_do_eh() to exist is that the two caller sites,
> ata_std_error_handler() and ata_sff_error_handler() may pass to it a
> NULL hardreset operation so that the built-in (generic) hardreset
> operation for a driver is ignored if the adapter SCR access is not
> available.
> 
> However, ata_std_error_handler() and ata_sff_error_handler()
> modifications of the hardreset port operation can easily be combined as
> they are mutually exclusive. That is, a driver using
> sata_std_hardreset() as its hardreset operation cannot use
> sata_sff_hardreset() and vice-versa.
> 
> With this observation, ata_do_eh() can be removed and its code moved to
> ata_std_error_handler(). The condition used to ignore the builtin
> hardreset port operations is modified to be the one that was used in
> ata_sff_error_handler(). This requires defining a stub for the function
> sata_sff_hardreset() to avoid compilation errors when CONFIG_ATA_SFF is
> not enabled.
> 
> This change simplifies ata_sff_error_handler() as this function now only
> needs to call ata_std_error_handler().
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-eh.c  | 46 ++++++++++++----------------------------
>   drivers/ata/libata-sff.c | 10 +--------
>   include/linux/libata.h   | 11 +++++++---
>   3 files changed, 22 insertions(+), 45 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

