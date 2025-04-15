Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655CA48
	for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2025 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703256; cv=none; b=S9iPMriWCUMGXLtaLxBHc5994CgCXwOXhJ9hXAXvYQ5nS3ifdhgH1n1AgL5TPxLnOXnPwg1RSfFsqU7ic50ttu4ww7L1iRu486m0z4hDhFkLWU7vDEZ63KjYDi+f0D3LMRs/aPYdvU+fu5deDM8wwpRozQHHrNZa+PJ2suos54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703256; c=relaxed/simple;
	bh=u7v9wvZJ+hzlo7P47Nbg0tqmEkgceEYbEs6Nu3SQ728=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFbkSVtO3TIovhJ6UXbgSwNgmch8Wz0noNSmCHYyUj/5RSE5vYPLFQAr85eQ97m+6qS4YKSdDAUHWwXfy7nndUsYv0yyPLhWEPBhV5VHSqnxIbmP9FjAlw8wVAEs1rQDuPl3D+wWjs0JCP1lv8TeoL7CxZ+C9xD+Sy/buG8ccU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0x6/ODaV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WVPjDDox; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0x6/ODaV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WVPjDDox; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0x6/ODaV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WVPjDDox";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0x6/ODaV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WVPjDDox"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65FD421171;
	Tue, 15 Apr 2025 07:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744703252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9i7qbkka5Y/iWADV6HZeZLA9aUFpTnt6HxNi5D3DWM=;
	b=0x6/ODaV7wSByBuQ7Ce69ZanBmbKd0XBpvsC7XGhrgfYIA0VLozB7El/lGFhLtVy19ZhiK
	2O6cDmt/NdTXvMgV9fYo0/xKaZTrIcREFvUsfavADLf10ibYv4DU50d2la3iyg6y9TyuH6
	tdo1fmL4MZlgIL2vft3luJoVJgAr978=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744703252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9i7qbkka5Y/iWADV6HZeZLA9aUFpTnt6HxNi5D3DWM=;
	b=WVPjDDoxOfEve2soZNsXnZWLLShxpURO0zF2TkkLW1p5WFjyO51b70jM4DaZSs1occlCrm
	8dbM4lY2NWgqpfBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744703252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9i7qbkka5Y/iWADV6HZeZLA9aUFpTnt6HxNi5D3DWM=;
	b=0x6/ODaV7wSByBuQ7Ce69ZanBmbKd0XBpvsC7XGhrgfYIA0VLozB7El/lGFhLtVy19ZhiK
	2O6cDmt/NdTXvMgV9fYo0/xKaZTrIcREFvUsfavADLf10ibYv4DU50d2la3iyg6y9TyuH6
	tdo1fmL4MZlgIL2vft3luJoVJgAr978=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744703252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9i7qbkka5Y/iWADV6HZeZLA9aUFpTnt6HxNi5D3DWM=;
	b=WVPjDDoxOfEve2soZNsXnZWLLShxpURO0zF2TkkLW1p5WFjyO51b70jM4DaZSs1occlCrm
	8dbM4lY2NWgqpfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32182139A1;
	Tue, 15 Apr 2025 07:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qu6DChQP/mc+NgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 15 Apr 2025 07:47:32 +0000
Message-ID: <2954b8af-1277-4b07-ab03-fa0be391177c@suse.de>
Date: Tue, 15 Apr 2025 09:47:31 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ata: libata-sata: Use BIT() macro
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
References: <20250415073013.414987-5-cassel@kernel.org>
 <20250415073013.414987-8-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250415073013.414987-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/15/25 09:30, Niklas Cassel wrote:
> The BIT() macro is commonly used in the kernel.
> Make use of it when converting a tag, fetched from the Successful NCQ
> Commands log or the NCQ Command Error log, to a bit field.
> This makes the code easier to read.
> 
> Suggested-by: Igor Pylypiv <ipylypiv@google.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-sata.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 076953d18db9..4e3034af285e 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1545,7 +1545,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
>   		 * If the command does not have any sense data, clear ATA_SENSE.
>   		 * Keep ATA_QCFLAG_EH_SUCCESS_CMD so that command is finished.
>   		 */
> -		if (!(sense_valid & (1ULL << tag))) {
> +		if (!(sense_valid & BIT(tag))) {
>   			qc->result_tf.status &= ~ATA_SENSE;
>   			continue;
>   		}
> @@ -1634,7 +1634,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
>   		return;
>   	}
>   
> -	if (!(link->sactive & (1 << tag))) {
> +	if (!(link->sactive & BIT(tag))) {
>   		ata_link_err(link, "log page 10h reported inactive tag %d\n",
>   			     tag);
>   		return;
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
