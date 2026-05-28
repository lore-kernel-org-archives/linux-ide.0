Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F5B31F993
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948756; cv=none; b=QYoB10BVMQ1gseDp8bIOgW2qaDM1fl0ers2i9GhmLqVlohbjn+AK3aHbUsLrI9pgI9jO1B1m/bwXddDLM9ODfeS9NUaOBmWmReocspqZZMbDJl8rDblwfvEECDjhjZPSDQA6HBUKRhzt5bZnQVBOlEwQXW42uXhp5cly6u1RmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948756; c=relaxed/simple;
	bh=Op3ZL/egZlKXRGi5MJu9DlMejaGvZGZqhdWzzpMmxF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5MZTm6oIjKQyNW26iTWsV52I8P1JtBkbowisU9pvDvku8CCNgFaOlA4ntewUb7uuhuD+l3i+Ha59gPWw+YdBJI+MSq7qgTtF4TByD8xDndo5b31j71h+TyyRQq4H4ZAru+2Gnm1XZcARXD87J8nS8erK49sb3rCFzABHooRor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tkdhoaR4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r603KczN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RcwIdEhT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hUAXGohq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tkdhoaR4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r603KczN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RcwIdEhT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hUAXGohq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6361D672AF;
	Thu, 28 May 2026 06:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779948753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfkkfZ2+oxss3J0ImiMltftDMhjYlTQOJcumc12gars=;
	b=tkdhoaR43BfgpEbQyLJcjzxd+xzO2Yq5gZadJHpCmeaI2JjDSDc7UgrzF2PvorFHfSM47+
	V/6IprfYH5fhWatCas8CCO2CtTnP/AJILXJWWN7h9BoGxypTpoAzfrvINetapbrQyuly9s
	vEiGcCDUayNCEppR+fbOS/ykYoCJsxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779948753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfkkfZ2+oxss3J0ImiMltftDMhjYlTQOJcumc12gars=;
	b=r603KczN/8pn7rrgGCVYr9YsXz6XeTawprDuCePEqyWnTUf9/3VUp2wj9evHYSHheRcMjT
	1nwT/Wt0HB6NehCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RcwIdEhT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hUAXGohq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779948752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfkkfZ2+oxss3J0ImiMltftDMhjYlTQOJcumc12gars=;
	b=RcwIdEhTGu1GvQ6NkKbSKMJq6ihwRLP6RpX2kw77D7m2Vn6piE9iikOD293lGpjq5XWZce
	Nlm1kTxvMrFKa6xjcVRHv+h3IcYX2DmvkyCfv9a3OD8/FxMsBXcGFmfm0Mxwh8KIB8A8a5
	exCRe7FdX1UNMXQyu5H9HztqFmf+rH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779948752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfkkfZ2+oxss3J0ImiMltftDMhjYlTQOJcumc12gars=;
	b=hUAXGohqGPvjjuEoDFootJwhAafdiuOWCx4FKL1YOLPMxVOvFk0Alm2oK3GrOCJAghYhCH
	Eo5fxF1h4Puwf9Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BD8A5AC35;
	Thu, 28 May 2026 06:12:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M18pCdDcF2o3AQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 28 May 2026 06:12:32 +0000
Message-ID: <e8048c96-4205-4399-aef2-b0b15277a5b3@suse.de>
Date: Thu, 28 May 2026 08:12:31 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci: use hweight_long() to count port_map bits
To: kensanya@163.com, dlemoal@kernel.org, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 TanZheng <tanzheng@kylinos.cn>
References: <20260528060050.743599-1-kensanya@163.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260528060050.743599-1-kensanya@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6361D672AF
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com,kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,kylinos.cn:email,suse.de:email,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 5/28/26 08:00, kensanya@163.com wrote:
> From: TanZheng <tanzheng@kylinos.cn>
> 
> Replace the open loop used to calculate the number of set bits
> in the port mapping with the `hweight_long()` function, which
> simplifies the code without altering its functionality.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: TanZheng <tanzheng@kylinos.cn>
> ---
> v2:
> - Add the prefix "ata:" to the patch title
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
