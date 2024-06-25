Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6094D143889;
	Tue, 25 Jun 2024 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296735; cv=none; b=Cz279R3AlBtvcmfDXFkICUoAOEBryJZdjrUjLj+U5JlMRpL6W0zzh+8AhlWtP84MdNqdYH3hCmCD6OxWNUMEkdAmgr8cGKLoWHMhtd5cbcrNROdLunvW7FOs0j75anRHjCMsDxkzYdrFwWAodaWzAio54ZA5FcUSxQ4qYj9JKxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296735; c=relaxed/simple;
	bh=5hs6+x4C0rKz5/gLhw0/T11oJIER3nlY+VfTf37aAY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Awmv0MLEVa24UiVA76v201RjyzM7uRNVgMa8OPZh+3ExrVcVPSqH84bpD2k049XQOVozvOq3YAwtqm1vaAU4315Mr5sMbZbqd9WsZ4NotMIJEh7x9ZsvJ0NX/XRyIBbTD6M9sB1xb/Ix77UvII2axTbSZAcV9f6WruYhbpIW2Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TOTM8Dbz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/9H/ULaK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TOTM8Dbz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/9H/ULaK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TOTM8Dbz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/9H/ULaK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TOTM8Dbz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/9H/ULaK"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D428211F8;
	Tue, 25 Jun 2024 06:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719296731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pF3gSK0XxffpFM8+WWNG7MGUrXr8jl0Rtix7rM2sYws=;
	b=TOTM8Dbz8rMi7/X19F/knnIpfE16fbwZSzzFD4t/wOoq/L/IFCmMt1X0gjCoW9d2QrLXMQ
	Q5YgQJb5ArlPCGWAgHDUU3yDZA4xNA5tytJesycHEQ7iZFb2hL/48WvHKjqNhOmBxYwvqL
	LEVWfcrjvKeXjqyu/2GHFftKwPT/fxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719296731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pF3gSK0XxffpFM8+WWNG7MGUrXr8jl0Rtix7rM2sYws=;
	b=/9H/ULaKku0nLOY4BeXGw3TfRsy+1/TgROmTtlH8iUV3upGHdqqusZxuhY5/oErISbRRwT
	3OQVIafgkkWUEhBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TOTM8Dbz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/9H/ULaK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719296731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pF3gSK0XxffpFM8+WWNG7MGUrXr8jl0Rtix7rM2sYws=;
	b=TOTM8Dbz8rMi7/X19F/knnIpfE16fbwZSzzFD4t/wOoq/L/IFCmMt1X0gjCoW9d2QrLXMQ
	Q5YgQJb5ArlPCGWAgHDUU3yDZA4xNA5tytJesycHEQ7iZFb2hL/48WvHKjqNhOmBxYwvqL
	LEVWfcrjvKeXjqyu/2GHFftKwPT/fxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719296731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pF3gSK0XxffpFM8+WWNG7MGUrXr8jl0Rtix7rM2sYws=;
	b=/9H/ULaKku0nLOY4BeXGw3TfRsy+1/TgROmTtlH8iUV3upGHdqqusZxuhY5/oErISbRRwT
	3OQVIafgkkWUEhBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 327341384C;
	Tue, 25 Jun 2024 06:25:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mIWkCdtiemZbDAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Jun 2024 06:25:31 +0000
Message-ID: <c54a55f2-4347-4211-8327-a73edba73aed@suse.de>
Date: Tue, 25 Jun 2024 08:25:30 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] ata: libata: Set ATA_QCFLAG_RTF_FILLED in
 fill_result_tf()
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-6-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240624221211.2593736-6-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8D428211F8
X-Spam-Score: -4.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/25/24 00:12, Igor Pylypiv wrote:
> ATA_QCFLAG_RTF_FILLED is not specific to ahci and can be used generally
> to check if qc->result_tf contains valid data.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/ata/libahci.c     | 10 ----------
>   drivers/ata/libata-core.c |  8 ++++++++
>   2 files changed, 8 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

