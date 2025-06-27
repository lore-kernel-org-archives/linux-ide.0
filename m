Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693341F9A8B
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004358; cv=none; b=Xq7ezOwwRxbL/6QyufsyHEaWPlsyYBgTXJtDBcyUbsSGQY46yBKjqNn8gSFfQqCu/x3I+KO0Q+yUyZmq3LAC8C2KyFDgz7zqMNPMK1TQBNfEG8TGt5KChPuCC9KmK0lsSF62RshVwO/lC4ZbNzw6nKKae/LQdKqWAecFai+TzW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004358; c=relaxed/simple;
	bh=elkIPvxDXmH5Tq+gVlBFTCFOw+g1Irv+MbIihbDzf5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cjyIWgGWYvqdUokztXfzKNE9YDGXrzBd1p9X9udze+Y7FeNKWsUyBjbP2hma/T/VQgOpmZggOBQooUs3lnA0dcaIpjI4VAKwlgg7dCHKvlVtAvwIKOmas+MQWTL0GJQRo5B/Wz1e5pgirYPuVpgN73ULMK7cj727oEwLYbyd9W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VkUb+r13; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NdPCbjDE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VkUb+r13; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NdPCbjDE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VkUb+r13";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NdPCbjDE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VkUb+r13";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NdPCbjDE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5CEB1F387;
	Fri, 27 Jun 2025 06:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751004355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEkYCjR3LVLr5LmOH2s8+mp04Jcinavj0GCvP0a5kBY=;
	b=VkUb+r13P1wGyUahGprAB0cTY3D8YhdokkDR6Y1CN3zzAc0knYE7A4OV7XGiUqFgcuJgT9
	tkBiNH55Q649u/Ojt7sod0UqqJSq+txfhiy7K1WXSISJR/Nfy7LMR4z1YGr94PaVARbl3y
	PAyBzB+zwDOVyp885bvtlkOeN9o3G3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751004355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEkYCjR3LVLr5LmOH2s8+mp04Jcinavj0GCvP0a5kBY=;
	b=NdPCbjDEgv3Xe23ICyQ9onRBhi/d5LXktAiedrCzNgTVlVliMcLOnKDvy0gKCCYif5lXjt
	tYtSYj6zMSHj6zBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751004355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEkYCjR3LVLr5LmOH2s8+mp04Jcinavj0GCvP0a5kBY=;
	b=VkUb+r13P1wGyUahGprAB0cTY3D8YhdokkDR6Y1CN3zzAc0knYE7A4OV7XGiUqFgcuJgT9
	tkBiNH55Q649u/Ojt7sod0UqqJSq+txfhiy7K1WXSISJR/Nfy7LMR4z1YGr94PaVARbl3y
	PAyBzB+zwDOVyp885bvtlkOeN9o3G3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751004355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEkYCjR3LVLr5LmOH2s8+mp04Jcinavj0GCvP0a5kBY=;
	b=NdPCbjDEgv3Xe23ICyQ9onRBhi/d5LXktAiedrCzNgTVlVliMcLOnKDvy0gKCCYif5lXjt
	tYtSYj6zMSHj6zBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F1E513786;
	Fri, 27 Jun 2025 06:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iaMfHcM0XmgUMgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Jun 2025 06:05:55 +0000
Message-ID: <747de408-13cb-4d4d-a7b1-18434bca65a9@suse.de>
Date: Fri, 27 Jun 2025 08:05:55 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] ata: libata-eh: Move and rename ata_eh_set_lpm()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250627011155.701125-1-dlemoal@kernel.org>
 <20250627011155.701125-7-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250627011155.701125-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
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

On 6/27/25 03:11, Damien Le Moal wrote:
> Move the definition of the function ata_eh_set_lpm() to avoid its
> unnecessary forward declaration and rename the function to
> ata_eh_link_set_lpm() to clarify that it acts on a link.
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-eh.c | 304 ++++++++++++++++++++--------------------
>   1 file changed, 152 insertions(+), 152 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
