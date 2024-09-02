Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A43B182
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258025; cv=none; b=IJnvwbwxx7BjVYSgNm6lEHMhmmBXIPIkvplgYd5uyq9aqDdTSXqJZa/41FTNYiPqBj38r6fuihkq2dZdktdPC+JDav53ti3cxmI6L4nx3NvP5wa167UZSBbHHWioS5U+4wNtBN2UkaA4IN6+tfPFzS2w99P/vrlLF/rAagD2GPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258025; c=relaxed/simple;
	bh=xpLa9gpx+0U/bKRKhOzuJLN+KwPIa5/QGhka0MbyhTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a+S1+r7iPmkC/jZBMv5KfuVw1tRoF0xcbs6RsIYd1GnNUTlBQBC7mPVlhZXgDcqvrefrv9cw5cLGzvou2uF3kS1WEoi8jMfjWMhzkkWBrNNw76bZkg4kWBnOwpnw8s2TSKkBPf9AIy6tcVwiyWt8eusWitCdqyTQ7N5TqrQYFnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pt6SFwfV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tW4sSE96; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pt6SFwfV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tW4sSE96; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pt6SFwfV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tW4sSE96";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pt6SFwfV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tW4sSE96"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3F5E1FB97;
	Mon,  2 Sep 2024 06:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725258022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtI+Z5aOP9AZxkUiI2K3A1hIHtwfbtaaWOStlyPlgX4=;
	b=pt6SFwfVjiSjju3YlUfd3ltmuP0OiWpihsVKvw9cdpBLPqiim7UsE7wX25sz2ly4uJm6ke
	8WY4AzO1cAoRBI/8AUNtSOF8Pa+R8JDCFKS0yRNV9THwRYZw+9+YPcv8Adk7rfcC1Gs1OC
	1pDyiUZ/rvDjw0wzQj9WVc33JXriJnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725258022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtI+Z5aOP9AZxkUiI2K3A1hIHtwfbtaaWOStlyPlgX4=;
	b=tW4sSE96tQk+xSQDPjPclbUDCUjMyPM8vXtE0eQnoHytdUGpjo/2g4uHcJ6RKR9B4QSaor
	lfyiRRPLD4AVdUDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725258022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtI+Z5aOP9AZxkUiI2K3A1hIHtwfbtaaWOStlyPlgX4=;
	b=pt6SFwfVjiSjju3YlUfd3ltmuP0OiWpihsVKvw9cdpBLPqiim7UsE7wX25sz2ly4uJm6ke
	8WY4AzO1cAoRBI/8AUNtSOF8Pa+R8JDCFKS0yRNV9THwRYZw+9+YPcv8Adk7rfcC1Gs1OC
	1pDyiUZ/rvDjw0wzQj9WVc33JXriJnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725258022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtI+Z5aOP9AZxkUiI2K3A1hIHtwfbtaaWOStlyPlgX4=;
	b=tW4sSE96tQk+xSQDPjPclbUDCUjMyPM8vXtE0eQnoHytdUGpjo/2g4uHcJ6RKR9B4QSaor
	lfyiRRPLD4AVdUDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB70C13AE5;
	Mon,  2 Sep 2024 06:20:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kLK/ICVZ1Wa8GQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Sep 2024 06:20:21 +0000
Message-ID: <f67a5ba5-8d20-401d-b170-a5127abab4c2@suse.de>
Date: Mon, 2 Sep 2024 08:20:21 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] ata: libata: Rename
 ata_eh_read_sense_success_ncq_log()
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20240902000043.155495-1-dlemoal@kernel.org>
 <20240902000043.155495-6-dlemoal@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240902000043.155495-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 9/2/24 02:00, Damien Le Moal wrote:
> The function ata_eh_read_sense_success_ncq_log() does more that just
> reading the sense data for successful NCQ commands log page as it also
> sets the sense data for all commands listed in the log page.
> 
> Rename this function to ata_eh_get_ncq_success_sense() to better
> describe what the function does. Furthermore, since this function is
> only called from ata_eh_get_success_sense() in libata-eh.c, there is no
> need to export it and its declaration can be moved to
> drivers/ata/libata.h.
> 
> To be consistent with this change, the function
> ata_eh_read_sense_success_non_ncq() is also renamed to
> ata_eh_get_non_ncq_success_sense().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-eh.c   | 6 +++---
>   drivers/ata/libata-sata.c | 7 +++----
>   drivers/ata/libata.h      | 5 +++++
>   include/linux/libata.h    | 5 -----
>   4 files changed, 11 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

