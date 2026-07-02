Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCB838E113
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975213; cv=none; b=oZ4OwGj6mlvht2By+UgT/IEFBzjkuxB1XAVNLgWygW5PdBPIDFkEKN9FCiuTLCp37vffJIiVcBgdvWhFlsLdza5HNZ65F54BJ5krMqEc5wF7/YJntMyapVJqN5NiHZArCzStOWgO31kVjw3yVUJWRlc2H0bN9nTmxVyauqOZQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975213; c=relaxed/simple;
	bh=UvZEGVG+5noGLmLJPZLW2MEjOA4f+f0P0d1iizjWGgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PsmVHeqUoSmrbbyZekiZWXnDIfEhW51nda0fmq+895WiN8oSKoWXIN/A0uBs43jWGzKVbLjr1XEHxAZQxPDRUiryOfjTi3bNzpg5RZRV2xenrBe9MONYEas1c2V8E8TQvEDeuxCc6L98fLOJaS9CY3n9eYRnRm1cktGvVEmmRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HQFL7w85; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lrVmDU8r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wf/MAsPm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vGIJppCT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HQFL7w85";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lrVmDU8r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wf/MAsPm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vGIJppCT"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A72DF75B9C;
	Thu,  2 Jul 2026 06:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782975209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xaePqti4fPjI5cAGFhGtw7VMsLWUGxzrS43+/o5DFcY=;
	b=HQFL7w85Imd1rmB0JJ+tJXegYXvMy08hhjCCwrKZDIKxAK1mKb+k2X8BqgdnA7V418QMtI
	r8k5QuH2B/QQsdJ5x8LdJouegIoxY0W7YXMwjWjE8XhuEJXnOnnsYrQn04QzB+yq2wG11n
	0htxfWc5CDn5rl7ZeWohRWnFZ8XprYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782975209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xaePqti4fPjI5cAGFhGtw7VMsLWUGxzrS43+/o5DFcY=;
	b=lrVmDU8rgFeGt0oT4ZjsmTZBwYmU1sSf/f/FOA40/vbt+bSpNSqPMFfCeXT1QLyBwt4fGB
	Fj+CR3g8ag6ycMCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782975208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xaePqti4fPjI5cAGFhGtw7VMsLWUGxzrS43+/o5DFcY=;
	b=wf/MAsPmhr4hL0BMhMUfzpIqGRQiMxH2fDX3LpGJpf5F9OY3YhcwEbAyqwbvYe/v8mV4tZ
	j268QF46CtkyEbfAVm3CXxgw30TBTglFEjRqQ/+DMK/AAVcFBFCEndy6Zp+LQrL5Iygeud
	bnYnX43vGYDYAuY5oakFJU6wfLlOYww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782975208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xaePqti4fPjI5cAGFhGtw7VMsLWUGxzrS43+/o5DFcY=;
	b=vGIJppCTPEQGrDYfL4nsTSldzWo4Jta8LjPmZ7kYBoFSKJ/19KpottKBkuwa0bnllbtCZs
	zVokqICw0OE/LECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 882A5779AA;
	Thu,  2 Jul 2026 06:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id deqwH+gKRmpTXQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 02 Jul 2026 06:53:28 +0000
Message-ID: <b8d97da8-10ba-4dcd-a4e8-534f0bbe3757@suse.de>
Date: Thu, 2 Jul 2026 08:53:28 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] ata: libata-scsi: support reporting options 2 in
 REPORT SUPPORTED OPERATION CODES
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-5-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260702063412.1892584-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Level: 
X-Spam-Score: -4.30

On 7/2/26 8:34 AM, Damien Le Moal wrote:
> Add support for the reporting options value 2 of the in REPORT SUPPORTED
> OPERATION CODES command in ata_scsi_report_supported_opcodes(). With this
> reporting option, the specified opcode to check must have a service
> action. Use ata_scsi_supported_cmd_has_sa() to check for this and fill the
> command reply buffer using the one command format based on the command
> support.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 86ac41a7d81a..e75ed573e234 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3737,6 +3737,13 @@ static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
>   			return 0;
>   		}
>   		break;
> +	case 2:
> +		/* One command format, must have sa. */
> +		if (!ata_scsi_supported_cmd_use_sa(cdb[3])) {
> +			ata_scsi_set_invalid_field(dev, cmd, 3, 0xff);
> +			return 0;
> +		}
> +		fallthrough;
>   	case 3:
>   		/* One command format */
>   		sa = get_unaligned_be16(&cdb[4]);

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
