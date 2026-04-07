Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9E72EF67A
	for <linux-ide@vger.kernel.org>; Tue,  7 Apr 2026 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558019; cv=none; b=MsaQZfKE1Y8Y/G5xm+S7MDQnDJKY3u+zaVdGtvRV4G/DVUJa1DL1/d5/WoaXLYLWnK2BUrrRMwZotvgBuGjI3ZaYzax4b2d+dCRWwmNLfv1jMBP0+QcR9mty7xYhsIGa7OcpJ/cnoTRMKjN1rwm/R+iEq+DwwfRGPGrYnRnGmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558019; c=relaxed/simple;
	bh=j8B5m4+Isjgnpzw/eakeYgOLEqR903TwkJQcprYP0AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORxVUfeB/fQltLsS6+jsOvq9nwiZui0PxL7Tk20uPxnhUoQBK7mIsbMA6dlbBZZKm+NzeoiQzvg8VCvw2A32RNmqeqhjMYXuujJ0NYOm+PwW58gTpui6gNVkyTbdznmlIYu2aCQbbmkMq3qjLUGUihQ/BMb93DHOXEERBB0n6sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=exo5+S7y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TpviaoIO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=exo5+S7y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TpviaoIO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="exo5+S7y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TpviaoIO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="exo5+S7y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TpviaoIO"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FFF05BD36;
	Tue,  7 Apr 2026 10:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775558016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pP74sis6dk8EQ16ueRbirCN4CsWnk1KHdj8zmASOkRA=;
	b=exo5+S7yKch6oJgmFEfq3AiB6wuCIwRT0IGeJzh0pLglQ2SIDFE3h9uVKqn8JpNRcrkZVE
	MSqinxqcYKaeR6OhUPBBjHQlpXqqWbTarwZNU5jHafYpdUzGMoYAWEJ8cB/XocyV+UFOqD
	NIvm4t/tkHZ+SbtDnyZSzHgqilosmlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775558016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pP74sis6dk8EQ16ueRbirCN4CsWnk1KHdj8zmASOkRA=;
	b=TpviaoIORZd6hc38l9T6rD/ERteAXhaNC7+3+gwQY3Q4Muq89uYTU0ZlY0efYzQcttkfeM
	oRfvEQvtBIYFb/Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=exo5+S7y;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TpviaoIO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775558016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pP74sis6dk8EQ16ueRbirCN4CsWnk1KHdj8zmASOkRA=;
	b=exo5+S7yKch6oJgmFEfq3AiB6wuCIwRT0IGeJzh0pLglQ2SIDFE3h9uVKqn8JpNRcrkZVE
	MSqinxqcYKaeR6OhUPBBjHQlpXqqWbTarwZNU5jHafYpdUzGMoYAWEJ8cB/XocyV+UFOqD
	NIvm4t/tkHZ+SbtDnyZSzHgqilosmlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775558016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pP74sis6dk8EQ16ueRbirCN4CsWnk1KHdj8zmASOkRA=;
	b=TpviaoIORZd6hc38l9T6rD/ERteAXhaNC7+3+gwQY3Q4Muq89uYTU0ZlY0efYzQcttkfeM
	oRfvEQvtBIYFb/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 438424A0B0;
	Tue,  7 Apr 2026 10:33:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gr/bD4Dd1GmiHgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Apr 2026 10:33:36 +0000
Message-ID: <27a9bad3-cef2-471b-9b4f-93237202efb2@suse.de>
Date: Tue, 7 Apr 2026 12:33:35 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ata: libata-transport: split struct ata_internal
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
 <bf2ecd99-cab3-413a-97e4-1828aecd2c23@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <bf2ecd99-cab3-413a-97e4-1828aecd2c23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 5FFF05BD36
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 3/30/26 17:20, Heiner Kallweit wrote:
> There's no need for an umbrella struct, so remove it. It's also a
> prerequisite for making the embedded struct scsi_transport_template
> public.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/ata/libata-transport.c | 53 ++++++++++++++++------------------
>   1 file changed, 25 insertions(+), 28 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
