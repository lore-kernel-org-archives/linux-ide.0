Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA823644CA
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974754; cv=none; b=pQWBeV8lC1xjij+QlDdKJwYyZHimATf+I5TbtJ4sr3ZSr5YGuFD6uZOpHwwb2W9JH/R+JFL4szuQIODukb/y+LI9EqVwHBrBWnluNmt/fZ8mjWQuKAXwogK5bj5vwXEQd/SmUM177s8NipnMKHkLuL/KeUOFxMtxzSikaDrHs48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974754; c=relaxed/simple;
	bh=q7aTu6uh7ND7/eTTGiu+Wq8PPLAbuGymd4etaooqZ0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iecAKC7SgMLGmBuuV3MReHhuIGi+DAuLUxUxD5hKAM1c7veAjgzMl73sdhV1ufypMHGYw2jE9gjfqJ03mxTqQco5d8ocvdtQioZRJss44qfEI6rQmz0rqButMoUsrQc2cecl1+iAcxmYYeTSwrLKWpGUbtMiLSeyxpzbAf7Q1Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pBIdOG7c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k8Ij3YL8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pBIdOG7c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k8Ij3YL8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pBIdOG7c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k8Ij3YL8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pBIdOG7c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k8Ij3YL8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A51E075AF9;
	Thu,  2 Jul 2026 06:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782974751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MT918HH2sAXN4PQFbEHVaxVLe0Ef05LD3EGQMrIRZ0=;
	b=pBIdOG7cdRFflHT5yl6uy3hzaUXUe2UZcDSDlkT0uhsOmi0TGKWRM/L+IROhcYYOJw5yXT
	52diXELYs3K5iqlI6uJ3ES7lh2UEnehXxSg82wWDWw/8EcEVMq/QE10BpQFf+RL6gy+OtN
	ayeeHTs86bZc7L4XxcVJ2oyGaG5RGv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782974751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MT918HH2sAXN4PQFbEHVaxVLe0Ef05LD3EGQMrIRZ0=;
	b=k8Ij3YL8OawMXqEN1TaYoRpxOdiBL0RXhS1PPCazaAmu5zvhsevaLuT935XX/2IsWubQgE
	K8UPmMsb8VfgrPBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782974751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MT918HH2sAXN4PQFbEHVaxVLe0Ef05LD3EGQMrIRZ0=;
	b=pBIdOG7cdRFflHT5yl6uy3hzaUXUe2UZcDSDlkT0uhsOmi0TGKWRM/L+IROhcYYOJw5yXT
	52diXELYs3K5iqlI6uJ3ES7lh2UEnehXxSg82wWDWw/8EcEVMq/QE10BpQFf+RL6gy+OtN
	ayeeHTs86bZc7L4XxcVJ2oyGaG5RGv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782974751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MT918HH2sAXN4PQFbEHVaxVLe0Ef05LD3EGQMrIRZ0=;
	b=k8Ij3YL8OawMXqEN1TaYoRpxOdiBL0RXhS1PPCazaAmu5zvhsevaLuT935XX/2IsWubQgE
	K8UPmMsb8VfgrPBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D3A0779AA;
	Thu,  2 Jul 2026 06:45:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lf7GHB8JRmqiVgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 02 Jul 2026 06:45:51 +0000
Message-ID: <25c80cb1-6396-4824-82a1-503afae4d42c@suse.de>
Date: Thu, 2 Jul 2026 08:45:51 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] ata: libata-scsi: improve service action support
 in ata_scsi_report_supported_opcodes()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-4-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260702063412.1892584-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -4.30

On 7/2/26 8:34 AM, Damien Le Moal wrote:
> ata_scsi_report_supported_opcodes() is ignoring the service action
> specified in the SCSI command CDB, but the one command format must take
> this field into consideration. With the reporting options field set to 1,
> the REPORT SUPPORTED OPERATION CODES command must be failed if the
> specified opcode to check has service actions, while reporting option 3
> must match supported opcodes together with the specified service action.
> 
> Stop ignoring the service action by passing it to
> ata_scsi_cmd_is_supported() and searching for commands in the
> array of supported commands (ata_supported_cmds) using both the command
> opcode and service action.
> 
> Introduce the helper function ata_scsi_supported_cmd_use_sa() to determine
> if a particular command has service actions and use this function to fail
> a REPORT SUPPORTED OPERATION CODES command if such command is specified
> with reporting options 1.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 41 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 34 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
