Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B380E3446C9
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951489; cv=none; b=BTfAqqOMHLTlAWs9j1nhXoiXgfjOdHp2nW1+hWXXCyp5P9dbRBQ5fKniHFPO2qWHIvIOYJQf2nMFjlvDaqRWWXMfnXWgMDwv9GBAjiN9F/ZiK/TG9x4r8cw5N6S7V2wWv7DsEotic3NcEivFXTVE2k7hiJoXCeMx+4AbjwGe8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951489; c=relaxed/simple;
	bh=2LnERiHWTlFZymCtwBTJbGYmD+P5C6tYF7S6hjZ0FqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQOeIXsdaqL1+nOpDG6705q3ggSqkAUT0JinTC66FwxxII4zJtnU+sd6ux2WsoXXS2SElQHA2ZuEmQClZEYdBURQdP9/DoYjs1BOSpXyVxmWJOaD1VmEeX1syQCRojXGk/U6xTbAX9sq0Yq3dDdFbE+/mmwWja8+ReDS3fu7fuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kykidXa/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W5hJwuWK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wKQhP47/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Mk+zprY5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kykidXa/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W5hJwuWK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wKQhP47/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mk+zprY5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD55A672DF;
	Thu, 28 May 2026 06:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779951486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IckalRy8q89oYZhrFx/XBHseReNRowkTpsFAZsig2kA=;
	b=kykidXa/RJhWGVii7SDG8RD6uBEfJVJwmhgT7AF3f+5rX9SsE+aVpFa3KTS+BXiH1AZrot
	vGE5CnQjMcFD49i1k2HRnbVngFqJaBR6xt7pY7L7SSr3v1CPQSpCjNVnhRUQrs8EXyqoRf
	uVx/60E/3aZ7gtVNpF7Huo9FvhJAMas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779951486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IckalRy8q89oYZhrFx/XBHseReNRowkTpsFAZsig2kA=;
	b=W5hJwuWKSMSgRSYFocr+RpbcygwcNRzEwltW77Iu4yogGSCRffa3akfPIlKqf62hT7HEC3
	4a0ATAu9JJqXZ3Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="wKQhP47/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Mk+zprY5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779951485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IckalRy8q89oYZhrFx/XBHseReNRowkTpsFAZsig2kA=;
	b=wKQhP47/qc74DZOQe2VJTM3x4S5AdLVqJZigtUkTjDVDBLz/0aGdOQ75tfcT4jnS1PttGT
	AQ+D7zYlarKsRyuFxOEPf1UiQz1z7mH0ahNfC5FD4PUvc9+duPtnM9fykxaCpWoSAIqeN7
	/qt5YqLIqtZVO1FIGtkjq6z+2ytudAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779951485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IckalRy8q89oYZhrFx/XBHseReNRowkTpsFAZsig2kA=;
	b=Mk+zprY5FeHgjyHQI5OMs6U7wDM+vsf1uVFWRYY3ufvHGc5LMSN0iYAoYUMvsSLmXAgzyy
	WyjqCNnelXXk87Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C4685AC61;
	Thu, 28 May 2026 06:58:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 717jH33nF2qHLgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 28 May 2026 06:58:05 +0000
Message-ID: <7ce6e1f0-6c65-439f-9a34-92bc5e977cce@suse.de>
Date: Thu, 28 May 2026 08:58:04 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: libata: Document when host->eh_mutex should be
 held
To: Bart Van Assche <bvanassche@acm.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Marco Elver <elver@google.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Viresh Kumar <vireshk@kernel.org>,
 Mikael Pettersson <mikpelinux@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>
References: <e95c0eb43a8297c9ab5e220341512882f8648512.1779913278.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e95c0eb43a8297c9ab5e220341512882f8648512.1779913278.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DD55A672DF
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,nxp.com,pengutronix.de,gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]

On 5/27/26 22:25, Bart Van Assche wrote:
> Annotate the following functions with __must_hold(&host->eh_mutex):
>   * All ata_port_operations.error_handler() implementations.
>   * ata_eh_reset() and ata_eh_recover() because these functions call
>     ata_eh_release() and ata_eh_acquire().
>   * All callers of ata_eh_reset() and ata_eh_recover().
> 
> Enable Clang's context analysis. This will cause the build to fail if
> e.g. a locking bug would be introduced in an error path. This patch
> should not affect the generated assembler code.
> 
> Note: although the Linux kernel documentation specifies 22 as minimal
> version for Clang for context analysis support, annotating function
> pointers is a Clang 23 feature. As one can see here, a patch has been
> queued that fixes the kernel documentation:
> https://lore.kernel.org/all/177926568868.711.3058599932884307249.tip-bot2@tip-bot2/
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
