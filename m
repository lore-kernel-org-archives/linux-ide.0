Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4F3B182
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257949; cv=none; b=dLSeB+/3hvVUJmOziszq0tsg0ny1zaz62NsZOevZ7qHg2we/chL5FhPjjfxZ0mlP/jg7+7IgUQJl40XjblE1mi6p/11StsNBjfkEYGMa6qHV2NaFo0WWk9aek71JKxSuxGHrv4eC/RkD8WSlgwxpBUP4WLdmzEjeEi361DmNIHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257949; c=relaxed/simple;
	bh=sNMIpwxsP2TS7ela7W+8NoFiMOm9jVgXGUNzOZaLTWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u5PTzVKY2OMZTdaaPIQr5SA6H71DBEqalAEYxogacLjoNbhjuBqQSO8IxkTELrvBWAHuuv5wFYUnm/HaCGDq5wy25p/I0rZvDgxU2huvHANKOoOe2zmG7JsxUursIv9+8ygRrSSvc2Af0f9WJ158IOh39EFvNzTX6CJwt5WCWj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wUanUI77; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XExYtIBP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wUanUI77; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XExYtIBP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wUanUI77";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XExYtIBP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wUanUI77";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XExYtIBP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF0B8219D7;
	Mon,  2 Sep 2024 06:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725257945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2UVVohBV20+NBvBFODMfi8+W8ErADAyROzugI9aack=;
	b=wUanUI77FDydltcMZMI5XuQyUWUEBWhNfX1UmTxOBGu16EuN+oms/zNQAJXGNksLLRJtI+
	DG7KkgP7X+LAsTf9TCOckK0jVJUQxy+7CmeTN+gBJQVwSpBGFR1W3f3VnwAkKgzJ+iXWCj
	oJdYk2TuHyd4r8Q7qPxPmKqLNotq7Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725257945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2UVVohBV20+NBvBFODMfi8+W8ErADAyROzugI9aack=;
	b=XExYtIBPyLAj8Ut08wntiEs4TyEtFme7sGh8jhouLgw4+rOC4EtiqtD/0fLh/f6bMhUZXx
	wgpkBM/Ekt5MEuBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wUanUI77;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XExYtIBP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725257945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2UVVohBV20+NBvBFODMfi8+W8ErADAyROzugI9aack=;
	b=wUanUI77FDydltcMZMI5XuQyUWUEBWhNfX1UmTxOBGu16EuN+oms/zNQAJXGNksLLRJtI+
	DG7KkgP7X+LAsTf9TCOckK0jVJUQxy+7CmeTN+gBJQVwSpBGFR1W3f3VnwAkKgzJ+iXWCj
	oJdYk2TuHyd4r8Q7qPxPmKqLNotq7Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725257945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2UVVohBV20+NBvBFODMfi8+W8ErADAyROzugI9aack=;
	b=XExYtIBPyLAj8Ut08wntiEs4TyEtFme7sGh8jhouLgw4+rOC4EtiqtD/0fLh/f6bMhUZXx
	wgpkBM/Ekt5MEuBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FB0E13AE5;
	Mon,  2 Sep 2024 06:19:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aNHwFtlY1Wa8GQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Sep 2024 06:19:05 +0000
Message-ID: <d8c27c92-a74b-42d3-90b3-608d01bc6968@suse.de>
Date: Mon, 2 Sep 2024 08:19:05 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] ata: libata: Move sata_down_spd_limit() to
 libata-sata.c
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20240902000043.155495-1-dlemoal@kernel.org>
 <20240902000043.155495-4-dlemoal@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240902000043.155495-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF0B8219D7
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 9/2/24 02:00, Damien Le Moal wrote:
> Move the definition of the function sata_down_spd_limit() to
> libata-sata.c where it belongs, together with sata_set_spd().
> The helper function ata_sstatus_online() is also changed to be an
> inline function defined in drivers/ata/libata.h.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-core.c | 85 ---------------------------------------
>   drivers/ata/libata-sata.c | 80 ++++++++++++++++++++++++++++++++++++
>   drivers/ata/libata.h      | 17 +++++++-
>   3 files changed, 96 insertions(+), 86 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

