Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270C3B784
	for <linux-ide@vger.kernel.org>; Tue,  5 Nov 2024 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791989; cv=none; b=Vk824jpqQWQO9ONdOxTQEeCILeqial8l5Wk8wy2pLApRc0TI+CQ6DHO26fI4ygsTnFm4MClPiIwZpSLQkfj2rRsZnvAr/hict3N7AlcMivT7V9bqVf9kLLHv27w/7xL1tdfsd3wHAoj2Muj3lSHxWCs+h6/XwoKYl2p+VhApgko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791989; c=relaxed/simple;
	bh=ThREmPRAehJZRyPHbTxwc4rD9uAD43u8san1wWle4ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAJQreeXA1A3sg9OzI2X4Ju3uiMDDdzC4W3WqgXQAA4r3G3fdedXQfpwPG264q0mqT/WU8fQm4dKw/GjC7mp3ltoCSkx2rhrsHeLNLlOFc03u7e8VBs/h81Te1a+9js63gVCcRDiaiUCMmyzNtu6GSDV5zi1/o14nxee2Zv3v3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hnfF0KAQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c1wmY8Gf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SNlxi7mQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C7BbFshe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hnfF0KAQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c1wmY8Gf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SNlxi7mQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C7BbFshe"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7C631FBAE;
	Tue,  5 Nov 2024 07:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730791985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzqDh7prlmJXX7tef8O4NXF7Abhff5l8yffMxAvkoU8=;
	b=hnfF0KAQJgu16tBat8NcaIeZ2rA9+xcmOOecwVSU/F298UQ8xTDH59Zl6urfwaCDJAFKTp
	AiMbSsynyux0NQboddj54pMmRoHrR2mQTgI7HSpM/ZXy+Hx0ibjA+OblHxVTN7Czczth6O
	EZKmDCVktmD9VDvXmTGJRWHbyKF4TC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730791985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzqDh7prlmJXX7tef8O4NXF7Abhff5l8yffMxAvkoU8=;
	b=c1wmY8Gf6Az1VxRB3JgRLfoFF09sYDZUU2LvE0/2eyz6HvFPv/gVHMq7TpJVdbhRRnEJxY
	9seeKb17ls+gSYAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730791984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzqDh7prlmJXX7tef8O4NXF7Abhff5l8yffMxAvkoU8=;
	b=SNlxi7mQiIvbfO6+SftufYBLbJo6Tp8wtuo9y2svWUId0qE688A8g89qeO20kfKC92OiD2
	hAyHFjPRkSA1jd3grYiAsPg8VhHrgm/JssAsREc5mz8uibaK7/W1yuzUZxVEUy9gQHEv7Z
	j3mdfY76JWf1kzO84BDlVefGdsSltX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730791984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzqDh7prlmJXX7tef8O4NXF7Abhff5l8yffMxAvkoU8=;
	b=C7BbFsheJwhyTsWBsb1k1BFJEa3sh/xqyksarW9IA0HpKOUiT/18cYie1+LwB/GDn8jrZE
	ZZB4nhmeXizm2hDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CB2C1394A;
	Tue,  5 Nov 2024 07:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1TDaFjDKKWdxGgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 05 Nov 2024 07:33:04 +0000
Message-ID: <86f91958-b462-4589-922b-2493f37bd344@suse.de>
Date: Tue, 5 Nov 2024 08:33:03 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata: Issue non-NCQ command via EH when NCQ
 commands in-flight
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Xingui Yang <yangxingui@huawei.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 linux-ide@vger.kernel.org
References: <20241031140731.224589-4-cassel@kernel.org>
 <20241031140731.224589-6-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241031140731.224589-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/31/24 15:07, Niklas Cassel wrote:
> libata is responsible to ensure that NCQ and non-NCQ commands are not mixed
> in the command list for the same device.
> 
> This is handled using the .qc_defer callback (ata_std_qc_defer()), which
> will defer a non-NCQ command as long as there are NCQ commands in flight.
> 
> The problem is that if an application is continuously submitting NCQ
> commands (e.g. fio with a queue depth greater than 1), this can completely
> starve out another application that is sending a non-NCQ command (because
> the non-NCQ command will be deferred forever).
> 
> Solve this by triggering EH if there are NCQ commands in flight when a
> non-NCQ is submitted. If EH is scheduled, no new commands will be accepted,
> and EH will wake up when there are no commands in flight. We will then
> submit the non-NCQ command from EH context, and synchronously wait for the
> completion. When EH is finished, libata will continue to accept new
> commands like normal.
> 
> Reported-by: Xingui Yang <yangxingui@huawei.com>
> Closes: https://lore.kernel.org/linux-block/eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com/
> Suggested-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-core.c | 169 +++++++++++++++++++++++++++++++++++---
>   drivers/ata/libata-eh.c   |  60 +++++++++++++-
>   drivers/ata/libata-scsi.c |  16 +++-
>   drivers/ata/libata.h      |   1 +
>   include/linux/libata.h    |   7 +-
>   5 files changed, 237 insertions(+), 16 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
