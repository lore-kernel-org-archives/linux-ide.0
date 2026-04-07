Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891C2EF67A
	for <linux-ide@vger.kernel.org>; Tue,  7 Apr 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557955; cv=none; b=S4aJZHn/pItVBIVK3NbKIKb9OCo9EGIE+VatJzR43/HVpXHKElyeLHSX6yYa2ZbbzpOtPeHJ9eYGqSky+7MzKX1pSh/BttDKojxS8b6kIsaPlxUzTnpJN9d5h9xBY0Zs2c+bKOSe6irv6kWZbRMYH8bGWICASjq++GXJtB6/23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557955; c=relaxed/simple;
	bh=bbN/0mE0vmz8SX7sRN1p5y05Of9C+zyzEQ03w70qNqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIDXYVy4BFgsSiR0FjgtxtVcN29mniUBaAVg+XAAlscfNcGFr0rXGXlDm+V3BZiBSf4GsReTMrb+uTV7BK0++csWP5XtFLyL03JiYvB3FcrDyl+zKPuTT6sg8IFOTnXGarrmvkxJyiHNioGZQq6JO/ZZvV50mkFQ/Vm9gAp1ONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nwAiONzy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uuvArw5P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nwAiONzy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uuvArw5P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nwAiONzy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uuvArw5P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nwAiONzy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uuvArw5P"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5ECC14D31F;
	Tue,  7 Apr 2026 10:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775557952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RP2smhb2ZJvCjKvHYtY3a3yRyvJVW6yJ6yxZSRH+1/0=;
	b=nwAiONzy43J1Eb18Icy3ohzWTusymeMuq5FUVlgunTccTv1P6PeCUyFzYm4X6qU6g+cBf9
	exoItyb02hzYzDXQtXR/LeIcak5Y3leiiV8O+9ogQpsTLSoXZiq51WMMgmMG7FXRjloK7J
	6ymuZ1gASDzd87OHAzdJG/sEyLiArXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775557952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RP2smhb2ZJvCjKvHYtY3a3yRyvJVW6yJ6yxZSRH+1/0=;
	b=uuvArw5PUBzr/DLZGlsGkB1zn8SnJHLFRq7uKI0g3m2BQ+1Itqb5FjBmmtpZwje1kOHXl5
	lwldsTSwanjEdZBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nwAiONzy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uuvArw5P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775557952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RP2smhb2ZJvCjKvHYtY3a3yRyvJVW6yJ6yxZSRH+1/0=;
	b=nwAiONzy43J1Eb18Icy3ohzWTusymeMuq5FUVlgunTccTv1P6PeCUyFzYm4X6qU6g+cBf9
	exoItyb02hzYzDXQtXR/LeIcak5Y3leiiV8O+9ogQpsTLSoXZiq51WMMgmMG7FXRjloK7J
	6ymuZ1gASDzd87OHAzdJG/sEyLiArXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775557952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RP2smhb2ZJvCjKvHYtY3a3yRyvJVW6yJ6yxZSRH+1/0=;
	b=uuvArw5PUBzr/DLZGlsGkB1zn8SnJHLFRq7uKI0g3m2BQ+1Itqb5FjBmmtpZwje1kOHXl5
	lwldsTSwanjEdZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46D4D4A0B0;
	Tue,  7 Apr 2026 10:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OewiEEDd1Gl+HQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Apr 2026 10:32:32 +0000
Message-ID: <d65ab9c4-91cc-4ae7-ab0f-b87fd1450ef8@suse.de>
Date: Tue, 7 Apr 2026 12:32:31 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ata: libata-transport: use static struct
 ata_transport_internal to simplify match functions
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
 <a0fbf4ec-cbd8-43e3-b52c-39eaf937052c@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a0fbf4ec-cbd8-43e3-b52c-39eaf937052c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5ECC14D31F

On 3/30/26 17:19, Heiner Kallweit wrote:
> Both matching functions can make use of static struct
> ata_transport_internal. This eliminates the dependency on static
> variable ata_scsi_transport_template, and it allows to remove helper
> to_ata_internal(). Small drawback is that a forward declaration of
> both functions is needed.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/ata/libata-transport.c | 44 ++++++++++++++++++----------------
>   1 file changed, 23 insertions(+), 21 deletions(-)
> 
Hmm. Exchanging one set of helpers with another set of helpers is
not really gaining us much, but if you must...

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
