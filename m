Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C97030E844
	for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2026 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771489196; cv=none; b=IoeIYoSCTECkSOjtC9wtY+JR23apcp+qx95NWZEC1jTKDWvC9Y9fij3kcaFl/XLsdKZELCTzbzNwSHxRPWCKqD8HXKWaDshFo8EYxJKzGIA6LwNRAkPnmw5110tZErmlBbh0ZYicgzTHs8M7jq7+Db09uurx0PVxvFz5XWtdMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771489196; c=relaxed/simple;
	bh=uU67RHGZtolgkGztrGBikSlanjgXNnrXeib1Zs0PxrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zqo++eQukuuH4UwpLU4IxW+P3Fs7C78IspnXlV0wumSFvCcdYO84Bj4Le3Hmz+0SKcj/5fBWmqiOloY22HgYLA7j/ynB06nb4jPmzuqEJJe8j+3ESVkKpqrz9aYwolGIX8LxKw4qSRXCWb4Cl/mVmyNmeDbU/N9RiHP2Oe3kMDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VBjU7XvG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=db6kaFh1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VBjU7XvG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=db6kaFh1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VBjU7XvG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="db6kaFh1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VBjU7XvG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="db6kaFh1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 91CD45BCC3;
	Thu, 19 Feb 2026 08:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771489193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8Vv3Ct0WrCTaRQpax2g5AegyJLYSmu7wZBoVlGjjHk=;
	b=VBjU7XvGU1N60VSKe57P4jr9yeMX4q1PgvAr9T0QvPtXKxmufxgSJWsC0rvdFQ6kvszyCI
	iw0twa4cgJbmPRBn7+kX2wnL5IJOksDMA3hTo5v0LdG3ac3i1OzTqKonU+Uk0kBPU0vWws
	Qp14UvUEkSIZ41oXKrgZhhWN3LdvKyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771489193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8Vv3Ct0WrCTaRQpax2g5AegyJLYSmu7wZBoVlGjjHk=;
	b=db6kaFh1DKFKavlIKAZ0TDRdimAXFHxmD7tZhzzzFH0vyULtDfW0lRCEBMsVw3O4GmGlYP
	LvPbbM0lLWzD0wBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771489193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8Vv3Ct0WrCTaRQpax2g5AegyJLYSmu7wZBoVlGjjHk=;
	b=VBjU7XvGU1N60VSKe57P4jr9yeMX4q1PgvAr9T0QvPtXKxmufxgSJWsC0rvdFQ6kvszyCI
	iw0twa4cgJbmPRBn7+kX2wnL5IJOksDMA3hTo5v0LdG3ac3i1OzTqKonU+Uk0kBPU0vWws
	Qp14UvUEkSIZ41oXKrgZhhWN3LdvKyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771489193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8Vv3Ct0WrCTaRQpax2g5AegyJLYSmu7wZBoVlGjjHk=;
	b=db6kaFh1DKFKavlIKAZ0TDRdimAXFHxmD7tZhzzzFH0vyULtDfW0lRCEBMsVw3O4GmGlYP
	LvPbbM0lLWzD0wBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 633D73EA65;
	Thu, 19 Feb 2026 08:19:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LjWOFqnHlmm1YgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 19 Feb 2026 08:19:53 +0000
Message-ID: <12889555-2842-4edb-882f-9ad4927d68b8@suse.de>
Date: Thu, 19 Feb 2026 09:19:53 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ata: libata-core: improve tag checks in
 ata_qc_issue()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260219062312.1030867-1-dlemoal@kernel.org>
 <20260219062312.1030867-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260219062312.1030867-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO

On 2/19/26 07:23, Damien Le Moal wrote:
> Make sure to check that the tag of a queued command is valid when
> ata_qc_issue() is called, and fail the QC if the tag is not valid, or if
> there is an on-going non-NCQ command already on the link.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-core.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
