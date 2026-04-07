Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938EC39A7E5
	for <linux-ide@vger.kernel.org>; Tue,  7 Apr 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557774; cv=none; b=VaORYNPKNIbH1590HcLeW5IPJnYGIO90Pl0CJYx+iKK9QkFhDV8m8yjUYiazNHxm7VXEWGN0bvGCURs9md8N1Jk0iUOvCOhy/D18ZYyp7dcgioy47PnjCJCLIeYMpFuHaHBRD3UyAQHLDnYUfreISxWOuPvOi0seof8vnoeD9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557774; c=relaxed/simple;
	bh=xCvb5yBAeM7YhPF8uZFruT4toCtoX9gUtPyqt6QG3T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrKd0cXPW5MvP1ppXuY9A77ZZl3HPvDMOowQ2L7nQRqj09ry1EUT48UGbfjmNI6aq12UoH/3uRXUB2VONK5X+gjq3xyNZ3BCWKCQJO2Y1O9BidaBuxFPpQnDYyqyIg+d1ZCc10hGuwfgg/xw26e1UmgTxZbY8jNdMhA1AVLiqqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X0/PvlQ6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=43awxsfa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X0/PvlQ6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=43awxsfa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X0/PvlQ6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="43awxsfa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X0/PvlQ6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="43awxsfa"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BE0A5BD36;
	Tue,  7 Apr 2026 10:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775557770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Azdf7pvKfi1zUr2vA/FRBnH9TEtGXp2OeeqNOQ1GqGQ=;
	b=X0/PvlQ62YA/cRcHu+q5m3UVObK0NYFmN+vDj7yIdmXF4+1+hHxm1JSljjxeps+dIuj/SA
	6N/aRmpBMMCWXfnwljG4BMl+54dSkaV3VJjQseypbBaxXCRn+C5GS6xKIz79vvrNmVM4mR
	XE4MNYwNkhQhFb5GfvRMZNI5joojyYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775557770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Azdf7pvKfi1zUr2vA/FRBnH9TEtGXp2OeeqNOQ1GqGQ=;
	b=43awxsfasyylhvGdgurLq/bBrdSRTWo0d28Xkz6OX7hpncN9W7EQ1hGPPIbuqRhJgmYI5n
	lk+JBaJVQFw9o5BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775557770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Azdf7pvKfi1zUr2vA/FRBnH9TEtGXp2OeeqNOQ1GqGQ=;
	b=X0/PvlQ62YA/cRcHu+q5m3UVObK0NYFmN+vDj7yIdmXF4+1+hHxm1JSljjxeps+dIuj/SA
	6N/aRmpBMMCWXfnwljG4BMl+54dSkaV3VJjQseypbBaxXCRn+C5GS6xKIz79vvrNmVM4mR
	XE4MNYwNkhQhFb5GfvRMZNI5joojyYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775557770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Azdf7pvKfi1zUr2vA/FRBnH9TEtGXp2OeeqNOQ1GqGQ=;
	b=43awxsfasyylhvGdgurLq/bBrdSRTWo0d28Xkz6OX7hpncN9W7EQ1hGPPIbuqRhJgmYI5n
	lk+JBaJVQFw9o5BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 728344A0B1;
	Tue,  7 Apr 2026 10:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xEFFG4rc1GlFGgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Apr 2026 10:29:30 +0000
Message-ID: <8abd467a-5a5f-4799-be4c-f4c01eccf8c7@suse.de>
Date: Tue, 7 Apr 2026 12:29:30 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ata: libata-transport: instantiate struct
 ata_internal statically
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
 <ad6ef45a-1e47-4bc4-b9fd-6ba3ec8ca83e@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ad6ef45a-1e47-4bc4-b9fd-6ba3ec8ca83e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On 3/30/26 17:18, Heiner Kallweit wrote:
> Struct ata_internal is only instantiated once, in module init code.
> So we can also instantiate it statically, what allows to simplify the
> code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/ata/libata-core.c      | 11 ++-----
>   drivers/ata/libata-transport.c | 57 +++++++++++++++-------------------
>   drivers/ata/libata-transport.h |  2 +-
>   3 files changed, 28 insertions(+), 42 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
