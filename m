Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E8F145FE1;
	Tue, 25 Jun 2024 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296552; cv=none; b=f7mdqUZRIiqveV7VV0AKReUsx329tEPtZNuLKVhV78GpvNRiI9e9tFAM8BmdFkEcllovLFeeZ0sHsx6haqdz6jTEeXt9iffQpn3c8YAtdj9o4z7egnlnWeDdMuVLR0hPuvS8t3+77ROpOcmgAIL2N3A1TrCoycE4Sce3hagALkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296552; c=relaxed/simple;
	bh=xYhQzfSK5fqbsda7brR7pesAo8bfuHpS3E7ykkbE+1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXrtV/AMTmlw+ibnXpRyq5wm1QLMO2tF4oRJBZMcbsKKuq1G3YMqJD9hbDyh9sfjDwBNRUEYlFgpCtfP3kw7tI/C/xamfwMTGeh4hFN3bBjbY+P/Qsl79lbdA5vZxo7A1EJoyEanIpz88KW4chWZurI5ZTmPs5FwFjXuX7uKR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pBXd1Fti; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=78HXnixd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0dixvB1v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7GxT3+gC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pBXd1Fti";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="78HXnixd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0dixvB1v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7GxT3+gC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26692219C5;
	Tue, 25 Jun 2024 06:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719296549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7j76KHa6IBWb/Wcc5AldkF2jVeuj8dwZ+b6cUBuoRo=;
	b=pBXd1Fti2jyGIVs571JwWMoKYRrjsfRDe5Iz7CEYBA1s7hQsb+bnewmVNbNeyrNHahyRdI
	CB6HUXU/SD0T020I+qO8sf5Gzgnog0GfjWY/gONfJKX2ZnKCe5u5NtlDK+eQ0LTZw3noMl
	6RQNWlh0Bev+nrWDQ4BIjX6aTPJftY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719296549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7j76KHa6IBWb/Wcc5AldkF2jVeuj8dwZ+b6cUBuoRo=;
	b=78HXnixdTrrCBtheFDAbyseMCskvlkB5rgNPoE43jedHxKQ6KHQjv+UD4OlFOimo+s4BPW
	GtzbK5B7ghyMWhCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0dixvB1v;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7GxT3+gC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719296548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7j76KHa6IBWb/Wcc5AldkF2jVeuj8dwZ+b6cUBuoRo=;
	b=0dixvB1v1Rey5r4CppS3LrCc7YsvYfNkC2aN1uYuXkPjuM9qbNIS1wl/2esifIzpjk8aIm
	5XJRUuOJJqM84MzjGKhIhWo7SWoayn9pmNksqcUP745EDOXv0kKJBoWfZA4aphSkA3R0OU
	zq8+9w2JW27EYq0AMvQusARg1H2OjtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719296548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7j76KHa6IBWb/Wcc5AldkF2jVeuj8dwZ+b6cUBuoRo=;
	b=7GxT3+gCqLXEkFBhaTVvMRSyu5fSoY+nlbtz6Q779Tqt9coO4J1O3maqiLiJr+Eba7S3by
	gjz3HxAVRb+5iKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B24441384C;
	Tue, 25 Jun 2024 06:22:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +GLXJyNiemZ5CwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Jun 2024 06:22:27 +0000
Message-ID: <b6fd8902-f644-41c5-9009-7901ddf6778a@suse.de>
Date: Tue, 25 Jun 2024 08:22:27 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] ata: libata-scsi: Remove redundant sense_buffer
 memsets
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-4-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240624221211.2593736-4-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 26692219C5
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Spam-Level: 

On 6/25/24 00:12, Igor Pylypiv wrote:
> SCSI layer clears sense_buffer in scsi_queue_rq() so there is no need for
> libata to clear it again.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/ata/libata-scsi.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 26b1263f5c7c..1aeab6e1c8b3 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -929,8 +929,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>   	unsigned char *sb = cmd->sense_buffer;
>   	u8 sense_key, asc, ascq;
>   
> -	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
> -
>   	/*
>   	 * Use ata_to_sense_error() to map status register bits
>   	 * onto sense key, asc & ascq.
> @@ -968,8 +966,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
>   	u64 block;
>   	u8 sense_key, asc, ascq;
>   
> -	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
> -
>   	if (ata_dev_disabled(dev)) {
>   		/* Device disabled after error recovery */
>   		/* LOGICAL UNIT NOT READY, HARD RESET REQUIRED */

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

