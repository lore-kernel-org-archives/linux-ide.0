Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971EB3DABE3
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075343; cv=none; b=B4lmNiZuX2idwPnDE6eVVrF09U1OjmYg1XBaJpgJ58nWJ6id1GxUJcDg8tmBQOo0NYeaHKCNyvGu7wgp3CvjXMkN+AvWFMbrznvZkv789Gp9iA4WXhxIiaDsq0Y+kQt/cSdUh8v1iipqj3Sm/qVyv1ZuuikWSIGoNi/rLz6KP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075343; c=relaxed/simple;
	bh=MU+MpYFMkKJONwETSTIhFYuiQ+UBHhbQvuN0+S7pnYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Air6X7HzXBj/g5LAj9u9klT/zzgoK7b+HYC8fnRTjhvhhZjAayAdU7YmiRxJeQfBrFd/FK2wLrGP3xpj/EGC8Acic8/Jvi2wJwB4fxiLw8UivbtSAFxRTq/kpEeIU+tQyrE2bALuuE55EH0CQe6yrmLWSP5R/rtZRfrejMlVNDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OYn4ezzi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Kf5j+X4+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=paMm/bH8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yZnbT9yJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OYn4ezzi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kf5j+X4+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="paMm/bH8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yZnbT9yJ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF5CA72B11;
	Fri,  3 Jul 2026 10:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783075339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpq4L+tvaCoE1yRsJrXPH6oo534BzZo2aHswyD5EDiA=;
	b=OYn4ezziZoO1cyHNNmpBpMcMx15b4O/e8LDB3LqoOEv3kZe3+C6O10Ms1uMdWUuThCRT1e
	apNZk/HeMu/U2K/wzdJuO3gHHUDQi3MsUY50GY2NxwoMzGpN+4WIhrv5xSVsDhMgZL7t8a
	Bd29WyXgrEIF3BS4w5TZ+qyyAUQXRcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783075339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpq4L+tvaCoE1yRsJrXPH6oo534BzZo2aHswyD5EDiA=;
	b=Kf5j+X4+D05oeuIqjF6Rtej2tK1TFc8/il3eDqLa9pxHh0XOL62u/e0h07LOQarBLm4qoY
	5Yp9GGeuFaiHfLBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783075338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpq4L+tvaCoE1yRsJrXPH6oo534BzZo2aHswyD5EDiA=;
	b=paMm/bH8XBsss4JqgainK9ZCwxVb4H6Ey1b/bnP7amvOHdj7AWiRQEJ/IzgMZmZV9HHMbw
	xQDvFqa2d4C/UOIWXcrK6hf4L2+JNU2BTubnHPGksj/nZFRxTd0LgPEJZXHORp7yEAZBOH
	4GsOizIHQ2Xog1goTyMfx1QF2kmCLHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783075338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpq4L+tvaCoE1yRsJrXPH6oo534BzZo2aHswyD5EDiA=;
	b=yZnbT9yJySyPwpNqZrlHrhk7JAXbDftzBkAZwPZK/hTA7ox/7Bq5dCXirVdb5eZpkBKjoh
	l5Ua2fI0hGcD0dCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAB9E779AA;
	Fri,  3 Jul 2026 10:42:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sOQQCAaSR2rwOgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 03 Jul 2026 10:42:14 +0000
Message-ID: <e1cbfe44-8576-4887-9448-e3f582a8c07c@suse.de>
Date: Fri, 3 Jul 2026 12:42:01 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] ata: libata-scsi: refactor
 ata_scsi_report_supported_opcodes()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260703085152.2350034-1-dlemoal@kernel.org>
 <20260703085152.2350034-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260703085152.2350034-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 7/3/26 10:51 AM, Damien Le Moal wrote:
> ata_scsi_report_supported_opcodes() is very limited in functionality as it
> lacks support for the all command format and also does not handle
> correctly commands that have a service action.
> 
> In preparation for adding these missing features, refactor how
> ata_scsi_report_supported_opcodes() operates to make modifications and
> extensions easier. To do so, introduce the array of supported commands
> ata_supported_cmds. This array entries are of type struct ata_scsi_cmd.
> This structure stores the operation code, CDB length, and the service
> action of a supported SCSI command that libata SAT can translate or
> emulate. Since some service actions (e.g. ZI_REPORT_ZONES) can have a
> value of 0, the field sa_valid of struct ata_scsi_cmd is used to indicate
> if the sa field is valid, or if it should be ignored.
> 
> The helper function ata_scsi_get_supported_cmd() is implemented to search
> for a particular command by opcode in this array. This function is used in
> ata_scsi_cmd_is_supported() together with a struct ata_scsi_cmd_support to
> check based on the target device features if the specified command is
> supported.
> 
> ata_scsi_cmd_is_supported() is used as the main function in
> ata_scsi_report_supported_opcodes() to determine if a particular command
> is supported and fill the command reply rbuf as needed. In the case of a
> command that is not supported, the support field is set to 1 as specified
> in SPC, indicating that the command is not supported.
> 
> Of note is that the old ata_scsi_report_supported_opcodes() code did not
> handle the VARIABLE_LENGTH_CMD/ATA_32 command which is supported and
> translated by libata-scsi. The ata_supported_cmds array includes this
> command. As commented in the code, WRITE_SAME_16 is left out of the array
> of supported command ata_scsi_write_same_xlat() prevents the use of this
> command as a passthrough command.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 197 ++++++++++++++++++++++++++++----------
>   1 file changed, 145 insertions(+), 52 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
