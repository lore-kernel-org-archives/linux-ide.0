Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE1335564
	for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2026 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771489317; cv=none; b=iK6p8+qhKxqBA0a7KhoB4x2dExLTNJnwhnEChduwjWCF9JV3jr2iKE+vLcMgNSqihOwO0qBCKR6MpFmokJSQePzh7q+7Fl/NOQyzC7HOAvO9tFjpum0L9bUAciBh8sXawxY0xKr2qUCKeDwuzPQ1V+FH4wA1ORKzKSp3hHtNAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771489317; c=relaxed/simple;
	bh=9NT11uvCctQOio/67Y6yj79qli8zXL8kb5aUpQHjrdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VVNOHeAK/m0658XnJiiT45ttaGJRaKp0sBLDBZcwilWuwnfGjQg16JQIa20XeWF3k0VmijcXPOeuTp5UwLJlRJYtTTJn0NcsNK8D1MmadLRXohhV5lo6AMOUl/m6dJx2tV2pTm2eSJzy1G/PfMVE4fMkcSTjaRm7+fQS1wy0Qq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AXdTC947; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8Dt3z407; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AXdTC947; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8Dt3z407; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AXdTC947";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8Dt3z407";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AXdTC947";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8Dt3z407"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 62C7B5BCC3;
	Thu, 19 Feb 2026 08:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771489314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LihUtkemPPAQr423h7Mi5ztOF2suIpFyIjBOyn7Ddrg=;
	b=AXdTC947KgtJJsnoHV7ISUIoP6S3Y+QOq9CZ+7gQBBaICroYjB90jHnwkPyEVE+oQumXYA
	KjbK7q1FbwyoVyEiOibIqQO0x2o6LAAe/n812BsdyUhM+izRfzxl+kTctLrkMJbABZ7Zmt
	TGpm6V97yIp87yMOqVLhB+8YYiCYXms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771489314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LihUtkemPPAQr423h7Mi5ztOF2suIpFyIjBOyn7Ddrg=;
	b=8Dt3z407qq5pVTLwn4Bzon8Su0yaT0qLIbi5Lhdkcv9fIPM236Eb2zZD17iY68QjIq6/Hj
	2xORb9DCjQF3+nDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771489314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LihUtkemPPAQr423h7Mi5ztOF2suIpFyIjBOyn7Ddrg=;
	b=AXdTC947KgtJJsnoHV7ISUIoP6S3Y+QOq9CZ+7gQBBaICroYjB90jHnwkPyEVE+oQumXYA
	KjbK7q1FbwyoVyEiOibIqQO0x2o6LAAe/n812BsdyUhM+izRfzxl+kTctLrkMJbABZ7Zmt
	TGpm6V97yIp87yMOqVLhB+8YYiCYXms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771489314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LihUtkemPPAQr423h7Mi5ztOF2suIpFyIjBOyn7Ddrg=;
	b=8Dt3z407qq5pVTLwn4Bzon8Su0yaT0qLIbi5Lhdkcv9fIPM236Eb2zZD17iY68QjIq6/Hj
	2xORb9DCjQF3+nDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3109F3EA65;
	Thu, 19 Feb 2026 08:21:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gfchCiLIlmkQZQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 19 Feb 2026 08:21:54 +0000
Message-ID: <3da46b3a-44d4-4c3d-9ca4-32089f36415c@suse.de>
Date: Thu, 19 Feb 2026 09:21:45 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ata: libata-scsi: simplify
 ata_scsi_schedule_deferred_qc()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260219062312.1030867-1-dlemoal@kernel.org>
 <20260219062312.1030867-4-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260219062312.1030867-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 2/19/26 07:23, Damien Le Moal wrote:
> Use ata_qc_done() instead of calling ata_qc_free() and scsi_done()
> directly.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
As noted by Sergey, the description refers to the wrong
function.
Other than that:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
