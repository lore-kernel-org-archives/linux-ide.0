Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D17C39E166
	for <linux-ide@vger.kernel.org>; Tue,  7 Apr 2026 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557840; cv=none; b=NFaRqIiE6nreO4YoHOPH+ZHJ2NazAviKR90FMs856KZ/kxJIpyiQmAFvfPlSS9LMm30TKV42u7hWzVelNRX7YvP8JIspXqwrN2zP1MDVadcIrCJxJVuY+Ro8Id0Drv7++IhjQO6HEugI14Rvy15pKZbGQFLFNhqXX+RWflQwZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557840; c=relaxed/simple;
	bh=lYoIDrt0WFH2c7ifcctORyatXUXzglwvdYcnj0MWk0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uz1QBL3JRGKfAo0Bma8fJSgTbZ3hkUugLaBTpjhCc0s44E/KE45LYRvEUFzWIuLvmnoReDqUhIFM6mkSRAGazz+KwHGuKm7/aJoNGD0gyrApFqKSmQTMny0nYh69v/+98Hjo3Xl2tCXGeU1uhvWxj0SrTDdtAaSY4xhgMwxmDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gvD8/D6X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KIhlp97g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gvD8/D6X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KIhlp97g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gvD8/D6X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KIhlp97g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gvD8/D6X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KIhlp97g"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A094A4E3E3;
	Tue,  7 Apr 2026 10:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775557837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsm5AJItqLf95QEpVcHHmux1DcID7eqyEjcc0k9vlmU=;
	b=gvD8/D6X/YML2AmOXBu6QCmaKYIetCMbIZCIqqhIZxJ3pIYwKxY/0pg5DcdS/8E2dzH/WC
	zJAzSyc0lxJkEuH7d0Rmt+RHonc/Kt5vl4FbdE3poHJ6ihRf8ZpmzNMejTlHwMDuGe/TSq
	hb9NNhN4cvJKQbhA+dyjv/4ds+dXH5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775557837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsm5AJItqLf95QEpVcHHmux1DcID7eqyEjcc0k9vlmU=;
	b=KIhlp97g9QWE9Q2LQaajtJNQKveSWNIcYvdWFFqj3BwAxkVYJqQNq4w7NBs62F3St+XpPQ
	viJMjrg0Pz7zqbAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775557837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsm5AJItqLf95QEpVcHHmux1DcID7eqyEjcc0k9vlmU=;
	b=gvD8/D6X/YML2AmOXBu6QCmaKYIetCMbIZCIqqhIZxJ3pIYwKxY/0pg5DcdS/8E2dzH/WC
	zJAzSyc0lxJkEuH7d0Rmt+RHonc/Kt5vl4FbdE3poHJ6ihRf8ZpmzNMejTlHwMDuGe/TSq
	hb9NNhN4cvJKQbhA+dyjv/4ds+dXH5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775557837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsm5AJItqLf95QEpVcHHmux1DcID7eqyEjcc0k9vlmU=;
	b=KIhlp97g9QWE9Q2LQaajtJNQKveSWNIcYvdWFFqj3BwAxkVYJqQNq4w7NBs62F3St+XpPQ
	viJMjrg0Pz7zqbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 789474A0B1;
	Tue,  7 Apr 2026 10:30:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CJKUHM3c1Gm3GwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Apr 2026 10:30:37 +0000
Message-ID: <8b509629-7aea-4cca-9df7-40f0db504cbe@suse.de>
Date: Tue, 7 Apr 2026 12:30:37 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ata: libata-transport: inline
 ata_attach|release_transport
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
 <f9d372b0-cd10-46b2-821f-80c4c29c8992@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f9d372b0-cd10-46b2-821f-80c4c29c8992@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 3/30/26 17:18, Heiner Kallweit wrote:
> Both functions can be merged into libata_transport_init() and
> libata_transport_exit() respectively, thus simplifying the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/ata/libata-core.c      |  2 --
>   drivers/ata/libata-transport.c | 34 +++++++++++-----------------------
>   drivers/ata/libata-transport.h |  3 ---
>   3 files changed, 11 insertions(+), 28 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
