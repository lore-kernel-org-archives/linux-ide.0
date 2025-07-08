Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB2298999
	for <linux-ide@vger.kernel.org>; Tue,  8 Jul 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961146; cv=none; b=c/kFpV/bvxEv6M4NEg7FavA24w17fuZ0Aek0+9e2x+xHb2mezLajeb3xoc0fBjY9xrXbxhplcMswOB5MjKGRkR0ySL3tZoqf+lA4rGZAXJfGDbFl1QMcvVfa8L8mlNE3yiz3Ko9VNwEbu4X+IEH6sUqKntLcBS+j6aGWEMlZv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961146; c=relaxed/simple;
	bh=Uucf7kcTIbWr/8CRwUvFhoYsR8+UIGd6D7cyxEKScAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J5Tcmox8ci+62cINSmLTDkln+eos3PZegGd30DkulXx9EmVlk1EYk7jKJWq+0E+xSWGetvDnTozfS9ChUO+KxG3FtGGpqInbKoS8oXQyHkIgOh65RPb1J5e4sPBteDWxwzWTvKPqQw+lbSoUpbVhyyA1ij8J1ExKVb9ebR96WTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jQFtOfVI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9z7BpB/R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jQFtOfVI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9z7BpB/R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jQFtOfVI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9z7BpB/R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jQFtOfVI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9z7BpB/R"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B486A1F390;
	Tue,  8 Jul 2025 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751961142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aR/vwFQUUZrxlnShsriTnqojfPc+ZyHHB4u9qLEQlyc=;
	b=jQFtOfVIc+vq/uIbwGwQbFxXMZ8/nSQ/10diTwl3PbWLAreeG7wFVTG/u3ImVEbt+e2tFO
	iYmBzeKScLlzIIaiNwYDqJlGJ8r5Ha2Uv3plX7goNnFpiwgwVIk8eYodBdtlfbCF0X7v90
	RkQ94MQNVLdi7oG/ipXgTNgX83q/Z54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751961142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aR/vwFQUUZrxlnShsriTnqojfPc+ZyHHB4u9qLEQlyc=;
	b=9z7BpB/R7Fmo6pVdPFQgtIecWGHs58T4OeBDV18f6uOZLU+451deuf1u1hMcKi1CTDj9rN
	BUzwCRaV1xXq7qCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jQFtOfVI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="9z7BpB/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751961142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aR/vwFQUUZrxlnShsriTnqojfPc+ZyHHB4u9qLEQlyc=;
	b=jQFtOfVIc+vq/uIbwGwQbFxXMZ8/nSQ/10diTwl3PbWLAreeG7wFVTG/u3ImVEbt+e2tFO
	iYmBzeKScLlzIIaiNwYDqJlGJ8r5Ha2Uv3plX7goNnFpiwgwVIk8eYodBdtlfbCF0X7v90
	RkQ94MQNVLdi7oG/ipXgTNgX83q/Z54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751961142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aR/vwFQUUZrxlnShsriTnqojfPc+ZyHHB4u9qLEQlyc=;
	b=9z7BpB/R7Fmo6pVdPFQgtIecWGHs58T4OeBDV18f6uOZLU+451deuf1u1hMcKi1CTDj9rN
	BUzwCRaV1xXq7qCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BDB613A54;
	Tue,  8 Jul 2025 07:52:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lVXuJDbObGiTSwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 08 Jul 2025 07:52:22 +0000
Message-ID: <521b67dc-6325-4e30-9347-bcc3472f81bf@suse.de>
Date: Tue, 8 Jul 2025 09:52:18 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Documentation: driver-api: Update libata error
 handler information
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250708073648.45171-1-dlemoal@kernel.org>
 <20250708073648.45171-4-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250708073648.45171-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: B486A1F390
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 7/8/25 09:36, Damien Le Moal wrote:
> Update ``->error_handler()`` section of the libata documentation file
> Documentation/driver-api/libata.rst to remove the reference to the
> function ata_do_eh() as that function was removed. The reference to the
> function ata_bmdma_drive_eh() is also removed as that function does not
> exist at all. And while at it, cleanup the description of the various
> port reset operations using a bullet list.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   Documentation/driver-api/libata.rst | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

