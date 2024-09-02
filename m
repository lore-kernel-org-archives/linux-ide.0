Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664BF19E96F
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280372; cv=none; b=PDCnO9wo7KPGTsEf4QUZZuUO0knE5Bx7Pb4AsduN6pejtW+K9yphmrHej9FeqJIEa1mjm3457z/Yuj+V5siK3ZvgRN5F//Qllya/x5KTYD3tjwHA6MKIrMICfSjIbakcD2SZBwkeYGs48cGgaLhvsVuAotM0mpUNf21w5HhFUhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280372; c=relaxed/simple;
	bh=2SXkug7r9A1TXZQN2aGOLPk7r+iIbuDqK+BtPaLI+o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QkbcKnuXwF+/1y3GKLKENYEQ/AgLVS8nB5rI9Q9ZYbtb9t31mOF2qlli+84njMNGfs9HxXLM6u8jFsW1A6lLvshVIWrVZWQeuM5aF8zSXdOYHbFmq+E7E/m0/8oUqnalxn0r5NglSPnjf0NvllVXGk0dDuTecAKrJzBVduxkxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EASbwTKn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OBwg1APk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r8TPQUH/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=se8shCSF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EASbwTKn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OBwg1APk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r8TPQUH/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="se8shCSF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7781E1FBAC;
	Mon,  2 Sep 2024 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725280369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTlE6M5tnPx/BUj4652DBs546B/4e4LcwrNvKqF21Bo=;
	b=EASbwTKnEdlZze9hs8pTnspflTMAjFESQCneBwevSJgdZDyTWk+/OY9w65AqRZfiwXlZ3Y
	9JVEpXpEqJAQEiCjiHWxjMvZHfNPWCKrKJuaL62imp/hCJ6XZRJGVRsg2MeOhCOzgpKNVF
	CGX9xG8dWhJBFz8enUo10UyMdShUHhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725280369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTlE6M5tnPx/BUj4652DBs546B/4e4LcwrNvKqF21Bo=;
	b=OBwg1APkUT3Io45p+B6faSQ9ItVMwWNILFc7eiQhgcVKgPByibQtQgILQvM7WIAH+DlcPS
	6qFyinR3IQW9J3AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725280368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTlE6M5tnPx/BUj4652DBs546B/4e4LcwrNvKqF21Bo=;
	b=r8TPQUH/JVqYe4doGq+lNP0hHVEjTcYJ+7Otp6lnH+qwkT7gdsDf4O6OZghyyMY5vlQkNE
	7ew/jg25zo71yEmVCXlK3ju2hJWFJiFOSsYzZWfNMOBs6nvHg1UR/G1rS/LqkJ59hAjFHB
	JwyIw6tGeFlI1xmy6Etu4ttkGkQez4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725280368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTlE6M5tnPx/BUj4652DBs546B/4e4LcwrNvKqF21Bo=;
	b=se8shCSFQmpaXlnVBfLy/6Ho7UHrm55/u8RrSxlLlbI3UUDmCmkHw1beltQgHNQj4ohhnf
	GtD7i3aT7ZOnx2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59E3013AE0;
	Mon,  2 Sep 2024 12:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ENx5FXCw1Wb2EAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Sep 2024 12:32:48 +0000
Message-ID: <d0f0f75b-5daf-4abf-973b-2329a9bd8dbd@suse.de>
Date: Mon, 2 Sep 2024 14:32:47 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] ata: libata: Cleanup libata-transport
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20240902115400.166881-1-dlemoal@kernel.org>
 <20240902115400.166881-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240902115400.166881-2-dlemoal@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 9/2/24 13:53, Damien Le Moal wrote:
> Move the ATA link transport device related functions after the ATA
> transport device related functions to avoid the need for forward
> declaring ata_tdev_add() and ata_tdev_delete().
> 
> And while at it, do the following:
> 1) Change ata_is_ata_dev() and ata_is_link() to return a boolean
> 2) Fix a pointer declaration style in ata_is_ata_dev()
> 3) Improve the kdoc comments for ata_tdev_free(), ata_tdev_delete(),
>     ata_tdev_add(), ata_tlink_delete() and ata_tlink_add()
> 
> No functional changes are introduced by this cleanup.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-transport.c | 299 ++++++++++++++++-----------------
>   1 file changed, 147 insertions(+), 152 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

