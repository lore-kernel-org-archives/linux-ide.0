Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDBE346FAD
	for <linux-ide@vger.kernel.org>; Fri, 29 May 2026 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035762; cv=none; b=eaFv3iBxGN/4p7XQGu6bK0QbZEVpFZ/BbLIkoydrr/qXZ4YLeUaNmqBZIrP1obdP40KvV2pYycAPdC+scCuCHMCU6/YGrnSMZZUeMayyg53noG2YyrC17MFrO2KAP6O/dL5m4p9YEkgPLNfiTad/LlszFH+43b/8muP/HlBHEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035762; c=relaxed/simple;
	bh=EBY8xPDDwDCy3Gjig9yUGoMFsjRLueduUySYehkoTiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoBFK7l5KHHnltQ/BQJyifxuZr99Tml/aA47nKUiEB5nmUMhNmK+aOpr2AJeLLI5Frqt1KgX5+wMUO5HuZE5xnxSWDKZMkwUemdeppQQBWPYQOnwypWkLaYdd3GAzlP1qpC9N2djnn+tV3D2A0ZqazPVhR0fww8tKWVNtAQw0Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v+e8tLIz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tFbAEIJY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v+e8tLIz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tFbAEIJY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v+e8tLIz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tFbAEIJY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v+e8tLIz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tFbAEIJY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3DD6A66E2C;
	Fri, 29 May 2026 06:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780035759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBHDcHLxsvlDFZWX062kzNyWs+ekp9kIagpTUzua/a8=;
	b=v+e8tLIz5E4FGDfR4T9r34nRoDDR8yACmmMKmkotXesavqhUodsdsx10ZXCsguPqNASJxt
	OdPiW9oLhDrva+w1T7Alg0A4rpoJSWNt4057D7j9t+L5TPw9sIrVxEdYGjSv38GSOPUOXr
	uDgMMmhhXjj6g3lB//d9xmpvIR6XWfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780035759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBHDcHLxsvlDFZWX062kzNyWs+ekp9kIagpTUzua/a8=;
	b=tFbAEIJYNbMZEmoY0kKrYlSrQc49qkk0v9qDCDMGEh63wxYsUc24ZfiWrYR+ehybxWkh+m
	Dfaw9Lt8bM+KYvDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780035759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBHDcHLxsvlDFZWX062kzNyWs+ekp9kIagpTUzua/a8=;
	b=v+e8tLIz5E4FGDfR4T9r34nRoDDR8yACmmMKmkotXesavqhUodsdsx10ZXCsguPqNASJxt
	OdPiW9oLhDrva+w1T7Alg0A4rpoJSWNt4057D7j9t+L5TPw9sIrVxEdYGjSv38GSOPUOXr
	uDgMMmhhXjj6g3lB//d9xmpvIR6XWfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780035759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBHDcHLxsvlDFZWX062kzNyWs+ekp9kIagpTUzua/a8=;
	b=tFbAEIJYNbMZEmoY0kKrYlSrQc49qkk0v9qDCDMGEh63wxYsUc24ZfiWrYR+ehybxWkh+m
	Dfaw9Lt8bM+KYvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10D185B1CA;
	Fri, 29 May 2026 06:22:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2t7kAq8wGWpBGQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:22:39 +0000
Message-ID: <5c884208-ee67-44e4-9c85-ec3668589237@suse.de>
Date: Fri, 29 May 2026 08:22:38 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ata: libata: Pass ap parameter directly to functions
 in the issuing path
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Marco Elver <elver@google.com>,
 linux-ide@vger.kernel.org
References: <20260528172855.703631-5-cassel@kernel.org>
 <20260528172855.703631-7-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260528172855.703631-7-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

On 5/28/26 19:28, Niklas Cassel wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> Context analysis cannot recognize that qc->ap == ap.
> 
> Therefore, grow a struct ata_port parameter to the following functions:
> ata_qc_issue(), __ata_scsi_queuecmd(), and ata_scsi_translate()
> such that we will be able to enable context analysis in a follow-up commit.
> 
> No functionality has been changed.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/ata/libata-core.c |  5 ++---
>   drivers/ata/libata-sata.c |  2 +-
>   drivers/ata/libata-scsi.c | 15 +++++++--------
>   drivers/ata/libata.h      |  5 +++--
>   4 files changed, 13 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
