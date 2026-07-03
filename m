Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8138398D
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062417; cv=none; b=CFH19fwEV4fNgPgXvSxfLOLSALCx2T9AyorAtlVvXUNYIpNB1+uUFColxesZ3Z5Gs1qO0Snu3tt9Jurh3B2UouvE5jjvwsQtNXcy03TSLt43Lz/7gJSU3XmsmJABi8pHS9ap5hu5sYRkoqg/lUrdXYlb8nXu4o7csh2a2unEQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062417; c=relaxed/simple;
	bh=IDVTUvrN6cRv0oAdrBLGQBUplJwRsHa6KF058JbpY0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GFKWR5PfFk5OV3sH+tYKfBreA6DanYBw7kEU1VkCVyl3nvXPIC+WeChHg7ITIEkKwI6O0I3k1iEyg8sbV84rFKh1KpEtQi3b/mfPGU90bpveBFd6dLS0lcc4Gr07bnH4pYeb7/SEFAkBVYK9pL+qQ1ZgTFfC/Bd4Ov8G/SZDxvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d44P78Ic; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Evrq0gUR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d44P78Ic; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Evrq0gUR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d44P78Ic";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Evrq0gUR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d44P78Ic";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Evrq0gUR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83A2D75970;
	Fri,  3 Jul 2026 07:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783062414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIdatU+n8+81V7117auBRvLOIBfT341K4X7jILQww5c=;
	b=d44P78IcbLW3AOdE5qQ2vlVs/xDzC8rqwJFNOfV4ZK3hR5/4emK7TDD20yMxSR08Ii3dt+
	Dp1At9b1LizQtVuii6clLFj122o+RX2PwBIURSz6E18vDMsEb4ODzD58CkL7gU6Euf1d8j
	Tf4CdL9u16okZimNp+sVesfGuh1pc3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783062414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIdatU+n8+81V7117auBRvLOIBfT341K4X7jILQww5c=;
	b=Evrq0gUR5KPMlBIRKgl7quQ8Jx+1BhlIcFCtqCAO8aq7rP+QOC5y5IFGN3x497rSnahAbp
	ilqSeIgxOT9f0UDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783062414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIdatU+n8+81V7117auBRvLOIBfT341K4X7jILQww5c=;
	b=d44P78IcbLW3AOdE5qQ2vlVs/xDzC8rqwJFNOfV4ZK3hR5/4emK7TDD20yMxSR08Ii3dt+
	Dp1At9b1LizQtVuii6clLFj122o+RX2PwBIURSz6E18vDMsEb4ODzD58CkL7gU6Euf1d8j
	Tf4CdL9u16okZimNp+sVesfGuh1pc3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783062414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIdatU+n8+81V7117auBRvLOIBfT341K4X7jILQww5c=;
	b=Evrq0gUR5KPMlBIRKgl7quQ8Jx+1BhlIcFCtqCAO8aq7rP+QOC5y5IFGN3x497rSnahAbp
	ilqSeIgxOT9f0UDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A273779AA;
	Fri,  3 Jul 2026 07:06:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JxqkGI5fR2o/ZgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 03 Jul 2026 07:06:54 +0000
Message-ID: <87c5ad12-50a1-4ed2-8584-ddd6ec5eb61f@suse.de>
Date: Fri, 3 Jul 2026 09:06:49 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] ata: libata-scsi: refactor
 ata_scsi_report_supported_opcodes()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260703040532.2152614-1-dlemoal@kernel.org>
 <20260703040532.2152614-3-dlemoal@kernel.org>
 <63c22af2-09df-47ff-a5cd-a9165bf265fc@suse.de>
 <e98e05a2-03a9-4b62-ac49-f382ea08c932@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e98e05a2-03a9-4b62-ac49-f382ea08c932@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 7/3/26 9:05 AM, Damien Le Moal wrote:
> On 7/3/26 15:44, Hannes Reinecke wrote:
>>> +	{
>>> +		.op = MAINTENANCE_IN,		.cdb_len = 12,
>>> +		.sa_valid = true,
>>> +		.sa = MI_REPORT_SUPPORTED_OPERATION_CODES
>>> +	},
>>> +	{	.op = SECURITY_PROTOCOL_OUT,	.cdb_len = 12	},
>>> +};
>>> +
>>
>> What an unusual formatting. I would have gone for multi-line
>> entries even for the simple ones to keep formatting the same
>> for all entries.
> 
> The multi-line for everything made the array really big, and hard to read. After
> trying different things, I settled on this.
> 
> 
Fair enough.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
