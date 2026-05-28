Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEC3191D3
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948711; cv=none; b=XNs3uCvXEjU71Xa9ib6bGMxzaxX8GOr3fZPYQdG24ntoR7LmnbtL73lrb3UJfH32SvHwrrak+WjdC3JmmE3lJFr+ICifYCrofK6rWU4WtCTdVV3ZLVcmGpBPefh50Wl0WvADSDsGJVKnyIrOFA0Tsh9vGUu1oecCmScoXiZ53Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948711; c=relaxed/simple;
	bh=wIu3fD79Atza0+EJgYUwqS62FzN2FYHKmzCxoZ9twjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBLrBfUUDEfZlWbT7b6vMh7DWSkLBD7K7OWYYc72Nf1cGszAeGcU7Eht+pfz526bUxkfzqMn+URC1A20MpZnfy+OFdV5D4aw+KeY0xC7QqbAy5wQjcPcoo88LYF7Wo7ksIFChlxoHP8Y4kt/UQmDkwVRbok33X1E+ylGhZ0mJtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MoDM1W3P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AfNTKcV4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MoDM1W3P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AfNTKcV4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MoDM1W3P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AfNTKcV4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MoDM1W3P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AfNTKcV4"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 71026672AF;
	Thu, 28 May 2026 06:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779948708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9XId4b5fyWOvY4FlSx0A9qipb4ndINLfk3HF3+XweI=;
	b=MoDM1W3PoCnDoyTBC4wOalHDPpcvkl+eD0EjA1YvWwgdWh70NmTqFIp215ZMoq7aSGOmco
	W6ASpUgJJ+ZktregB21P8f+jiC0Y6x5nQtzkjz5PZeLVNC25Elb1NhHsueK7PmcC2W4YRh
	nKjm+UDIZA6H+k7EnUDNDAA/eIIQAZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779948708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9XId4b5fyWOvY4FlSx0A9qipb4ndINLfk3HF3+XweI=;
	b=AfNTKcV4Gg44AGPF9OGOXOflV5uAY4wW049wNZmVewmRYUn6BqmRnYgSDkLVIAZBNnQbu7
	9a6EHt19e5b1oRBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MoDM1W3P;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AfNTKcV4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779948708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9XId4b5fyWOvY4FlSx0A9qipb4ndINLfk3HF3+XweI=;
	b=MoDM1W3PoCnDoyTBC4wOalHDPpcvkl+eD0EjA1YvWwgdWh70NmTqFIp215ZMoq7aSGOmco
	W6ASpUgJJ+ZktregB21P8f+jiC0Y6x5nQtzkjz5PZeLVNC25Elb1NhHsueK7PmcC2W4YRh
	nKjm+UDIZA6H+k7EnUDNDAA/eIIQAZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779948708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9XId4b5fyWOvY4FlSx0A9qipb4ndINLfk3HF3+XweI=;
	b=AfNTKcV4Gg44AGPF9OGOXOflV5uAY4wW049wNZmVewmRYUn6BqmRnYgSDkLVIAZBNnQbu7
	9a6EHt19e5b1oRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DE6C5AC33;
	Thu, 28 May 2026 06:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nJMQDaTcF2q8fwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 28 May 2026 06:11:48 +0000
Message-ID: <a2a226bb-2638-4e64-a1d7-7642367678ed@suse.de>
Date: Thu, 28 May 2026 08:11:47 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] ata: libata: Pass the ATA port argument directly
 to __ata_scsi_queuecmd()
To: Bart Van Assche <bvanassche@acm.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Marco Elver <elver@google.com>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-3-bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260521173347.2079560-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 71026672AF
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]

On 5/21/26 19:33, Bart Van Assche wrote:
> Prepare for adding lock context annotations that refer to the ATA port
> argument (ap). No functionality has been changed.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/ata/libata-sata.c | 2 +-
>   drivers/ata/libata-scsi.c | 6 +++---
>   drivers/ata/libata.h      | 3 ++-
>   3 files changed, 6 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
