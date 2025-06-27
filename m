Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9748F4A0C
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015338; cv=none; b=j3zKpUJUXOaejA2CS72b+2lp6rvhSb3+XwxQIkwz8pz+PtSEgyP0SvC/sUvuX0vabscsZgFFy0/lvuN6Xvwo2pXwb3yKOt5EsLna1h7ZYUqlgCLsX6i+JcrAJUVDwyQuxQ1Jyc8DU5E1ESZ1lrA9Nty+h0p220YBgd8vG/gExO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015338; c=relaxed/simple;
	bh=M9U1XfMitWlX0neuRy7agZ3ff7L0aa4ZjbjkYBWtjI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MzTLRlUR4l8JseEBUEeEEAIE1i82VSZOBTcEbpEzT0n6wCcdPMofifbvJutZoFZOKsV2K1wE+3abXUmrC8GpPRLE64GP8O11QwjPO6ElwSSBRWEvNwS7dpj44uN2pkHq43e0XDyJJHLmgeSYyklgQY9eFLgUrLwihJ6BqP733vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H1S3qLF3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=22LA2c3V; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H1S3qLF3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=22LA2c3V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H1S3qLF3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="22LA2c3V";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H1S3qLF3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="22LA2c3V"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C17BA1F38D;
	Fri, 27 Jun 2025 09:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751015334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ak7g6BFroi2GddNUGdxljueHmwoi5eLoX46A6LMCkg=;
	b=H1S3qLF3lJWiwnFqJXEnZqtLjfeNMQ/wKsyx2bhhWdeks7yqSdAcQuNVjOb1I3mRv2Fvwj
	CtxsfM4+xifzcNZ1sIkffqKguCGxMOQC2CCyGd/q+PSJBmROF+4xhkaQP0cZzuG9G8vekR
	YuRxzbYGeIBCsfvtMbkpwYkUId6PRcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751015334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ak7g6BFroi2GddNUGdxljueHmwoi5eLoX46A6LMCkg=;
	b=22LA2c3VLnrVO0aI0Bx+6eDmZoefs/WAdEfA5V42o//D155wrSHytWK+jLUmmr0Q1HxmGo
	zbr+efY4732D34BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751015334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ak7g6BFroi2GddNUGdxljueHmwoi5eLoX46A6LMCkg=;
	b=H1S3qLF3lJWiwnFqJXEnZqtLjfeNMQ/wKsyx2bhhWdeks7yqSdAcQuNVjOb1I3mRv2Fvwj
	CtxsfM4+xifzcNZ1sIkffqKguCGxMOQC2CCyGd/q+PSJBmROF+4xhkaQP0cZzuG9G8vekR
	YuRxzbYGeIBCsfvtMbkpwYkUId6PRcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751015334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ak7g6BFroi2GddNUGdxljueHmwoi5eLoX46A6LMCkg=;
	b=22LA2c3VLnrVO0aI0Bx+6eDmZoefs/WAdEfA5V42o//D155wrSHytWK+jLUmmr0Q1HxmGo
	zbr+efY4732D34BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2DE6138A7;
	Fri, 27 Jun 2025 09:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KdJeJqZfXmhCZwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Jun 2025 09:08:54 +0000
Message-ID: <ea7bb0d8-62bb-4aea-9477-ca984570363d@suse.de>
Date: Fri, 27 Jun 2025 11:08:54 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] ata: libata: Improve LPM policies description
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250627075207.23969-1-dlemoal@kernel.org>
 <20250627075207.23969-5-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250627075207.23969-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Level: 

On 6/27/25 09:52, Damien Le Moal wrote:
> Improve the comment describing enum ata_lpm_policy and add comments
> within that enum to describe each of the different possible values.
> The enum values comments match the description given for the
> CONFIG_SATA_MOBILE_LPM_POLICY config parameter.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   include/linux/libata.h | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
