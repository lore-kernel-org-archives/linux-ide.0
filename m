Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A33B182
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257879; cv=none; b=nB8mnBG+m/df00BFzsxDR1rpFQeVBvZbf0L8AezecU7TrxA/Zx/MubBgLOPSNHfUbrPmGG2LSajDx+EOVedWxNsHCk53MEylX860TY4yRQOnxEuJ3VE/IepAceIs7uGl7s1XkbyOC52SiKladhiKpQ3Nx7rh8/mXGkJBGn251/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257879; c=relaxed/simple;
	bh=WJeTkwkGQM1KVCz9pRBz9Cl/EFUrh4X2pvyM4YoESOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T1VpzxbNLgMvWBjQUYFWwYW4qWkVCyF3u2VahS5nTd43AhVhzWwoqauSMROjF/krRwqweKhkWMYoP3DckZsGSAgYjzW8XRUscQHeZY8av4YS9p8wGW0rvMFjgpsNYUSTQfF6EyGHmRYcalB6YheG1uuGXuTOW1ju+nQeI96Zd1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vmIwFrAD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mTUUl9Iu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vmIwFrAD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mTUUl9Iu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vmIwFrAD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mTUUl9Iu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vmIwFrAD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mTUUl9Iu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1A30219BB;
	Mon,  2 Sep 2024 06:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725257876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvYCCYIOTZgn8MI2EABXXz3AOeNAM7bFCHrrUZGBF8Y=;
	b=vmIwFrADaod0kgztP17P1cGZ6Gxl3XTAi8R2LL+IvHP3u0W7NgNc3FQ7cm+MHygqU7m8uy
	yYe8xsXhCccHAmkkbK2lieLIfJ3lLoDhaX148X74AAarB7pLR8Bt85AeUN3yMuF9JaQE4I
	ZJi+q4ZtnZg3rw2QZssia8LJtt0gzHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725257876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvYCCYIOTZgn8MI2EABXXz3AOeNAM7bFCHrrUZGBF8Y=;
	b=mTUUl9IuZYlH9oWvGCdiuv8ccqhUbenNgzV2Thmc1tyWvAaIB3CIJj/04h/IMoMioyU13O
	2NoaqhEwit3E02DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725257876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvYCCYIOTZgn8MI2EABXXz3AOeNAM7bFCHrrUZGBF8Y=;
	b=vmIwFrADaod0kgztP17P1cGZ6Gxl3XTAi8R2LL+IvHP3u0W7NgNc3FQ7cm+MHygqU7m8uy
	yYe8xsXhCccHAmkkbK2lieLIfJ3lLoDhaX148X74AAarB7pLR8Bt85AeUN3yMuF9JaQE4I
	ZJi+q4ZtnZg3rw2QZssia8LJtt0gzHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725257876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvYCCYIOTZgn8MI2EABXXz3AOeNAM7bFCHrrUZGBF8Y=;
	b=mTUUl9IuZYlH9oWvGCdiuv8ccqhUbenNgzV2Thmc1tyWvAaIB3CIJj/04h/IMoMioyU13O
	2NoaqhEwit3E02DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BB3013AE5;
	Mon,  2 Sep 2024 06:17:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KAqDGJRY1Wa8GQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Sep 2024 06:17:56 +0000
Message-ID: <5796fcff-51b4-43b4-bfb0-fc8c61f4447a@suse.de>
Date: Mon, 2 Sep 2024 08:17:56 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] ata: libata: Improve __ata_qc_complete()
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20240902000043.155495-1-dlemoal@kernel.org>
 <20240902000043.155495-3-dlemoal@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240902000043.155495-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
> The function __ata_qc_complete() is always called with a qc that already
> has been dereferenced and so is guaranteed to be non-NULL (as otherwise
> the kernel would have crashed). So remove the warning for a NULL qc as
> it is useless.
> 
> Furthermore, the qc passed to __ata_qc_complete() must always be marked
> as active with the ATA_QCFLAG_ACTIVE flag. If that is not the case, in
> addition to the existing warning, return early so that we do not attempt
> to complete an invalid qc.
> 
> Finally, fix the comment related to clearing the qc active flag as that
> operation applies to all devices, not just ATAPI ones.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-core.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

