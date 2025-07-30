Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164453FE5
	for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2025 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753855352; cv=none; b=YrkFxn86OHUBhDpcmMlYbNhr0atWezq4EI8QJi7fMzc5p3Il76dYR9hBTYV1FZLQ8FC739bJhDUPFanTGduC9wU1thJOS02YXMfq39UTOfQWBRFKoD9h69ulyE30ZGmBlzeTLpyQBOhK2LiJpxiOcRqgNVNwn3synB9dPKkJNxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753855352; c=relaxed/simple;
	bh=5Gi+IalzBlMvt/HFQUJzdO8Ujt+05mPK2HKtCkyDmEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eo9j2nnyMxaklwAd++cdN1GaCpDiRc76iqKfQE2EWKVgf3MAY+eiWAOKKMMOTv8e73Ua9d1U+uSPmulzIXeA4gHlht+2gSidbkeebbyTyissbc/vP0ZJRU1na0y6MKcA4x8A7zdlbqH+jN+4TmnhHsW1Q1YdaGxmY30D8Wf+1+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yvEqgRs3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H5hoLLnn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yvEqgRs3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H5hoLLnn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yvEqgRs3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H5hoLLnn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yvEqgRs3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H5hoLLnn"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1165D21A93;
	Wed, 30 Jul 2025 06:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753855349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtPop+G10DJ6hJPllcPJMOa3pxLrZvpcjQFDiA2SXTE=;
	b=yvEqgRs3XCTBX40PIrZOmx58Vn03KHMU1Qxl461dyy4zy6ypDXZRSozN3hoFsScE1hTIbs
	Sn+6xCFy94RWMIs35nJXJQBTwIDLjt3uJxBqoD3hk73GeMd0KGsmpzxTuhfMa8jGlPaWhO
	0jIeJweUIqWbFdM+11tdcjx288pYHP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753855349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtPop+G10DJ6hJPllcPJMOa3pxLrZvpcjQFDiA2SXTE=;
	b=H5hoLLnna6UlyfqIjil1Tz17FihcfJwHl6Gr6un53OzW/t3rLYVEAqU42mS/4MRAegZhZ/
	yE85ERnEfKohAKBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yvEqgRs3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H5hoLLnn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753855349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtPop+G10DJ6hJPllcPJMOa3pxLrZvpcjQFDiA2SXTE=;
	b=yvEqgRs3XCTBX40PIrZOmx58Vn03KHMU1Qxl461dyy4zy6ypDXZRSozN3hoFsScE1hTIbs
	Sn+6xCFy94RWMIs35nJXJQBTwIDLjt3uJxBqoD3hk73GeMd0KGsmpzxTuhfMa8jGlPaWhO
	0jIeJweUIqWbFdM+11tdcjx288pYHP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753855349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtPop+G10DJ6hJPllcPJMOa3pxLrZvpcjQFDiA2SXTE=;
	b=H5hoLLnna6UlyfqIjil1Tz17FihcfJwHl6Gr6un53OzW/t3rLYVEAqU42mS/4MRAegZhZ/
	yE85ERnEfKohAKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D155D1388B;
	Wed, 30 Jul 2025 06:02:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XPZPMXS1iWh2LQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Jul 2025 06:02:28 +0000
Message-ID: <f6b85b40-6bb3-487c-8869-702d05177ca7@suse.de>
Date: Wed, 30 Jul 2025 08:02:28 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata-scsi: Return aborted command when missing
 sense and result TF
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: Lorenz Brun <lorenz@brun.one>, Brandon Schwartz <Brandon.Schwartz@wdc.com>
References: <20250730002441.332816-1-dlemoal@kernel.org>
 <20250730002441.332816-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250730002441.332816-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1165D21A93
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 7/30/25 02:24, Damien Le Moal wrote:
> ata_gen_ata_sense() is always called for a failed qc missing sense data
> so that a sense key, code and code qualifier can be generated using
> ata_to_sense_error() from the qc status and error fields of its result
> task file. However, if the qc does not have its result task file filled,
> ata_gen_ata_sense() returns early without setting a sense key.
> 
> Improve this by defaulting to returning ABORTED COMMAND without any
> additional sense code, since we do not know the reason for the failure.
> The same fix is also applied in ata_gen_passthru_sense() with the
> additional check that the qc failed (qc->err_mask is set).
> 
> Fixes: 816be86c7993 ("ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
