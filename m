Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA834E777
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974326; cv=none; b=MlWGrVM2kEJDk2svFmnxNBHPHNqEbNhRNtk0TCCU7svrCYl2KscoWz6nyuESgD5Phy8Q8uCOmh56pc26x/dCcsYxv9A8H+4n+aX+Ue5OXQlWo5bfYpS8dvh89PWeAtoGiglmqkR/gyjp6mVuEDieDNIRsB/N8Iq2KZdaXnxFCxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974326; c=relaxed/simple;
	bh=a1GjsmEkHVXla4S45CiiIFkQzb9UxO2yXhQzHWlYgXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AjdWx3Nq1ZFdKNEANWJEZ3jyyXV/Bf1u1hLYwCf31rBLF5iuqX1sh/DYVAPQLO/ha7HJRnNu6VZgKTtZ9HjrqXvYG4Od5tOrTOmf5Vifqj9gw1lzWEIySVWyNF1xOI9jeViJyomd88BgAy+EI2ooMrl9vwPt4g61vQ0IMmVwCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=auP9+W8x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zTFkiaYw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=auP9+W8x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zTFkiaYw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="auP9+W8x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zTFkiaYw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="auP9+W8x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zTFkiaYw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA68E75B35;
	Thu,  2 Jul 2026 06:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782974322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MpX2K5pbBw1Uk9SjZJbTDy9PGebzitoIF29R4z6f0g=;
	b=auP9+W8xmRzwS8OtduFfBbGU6tTvAdhM2Pk3DqXemhloXyBhUynM7Wla7SJxOlCshROy7j
	7LvRvxl/duf6AkgcyNEIXc33Roj0b3QNVWmoeKSTeEL+PFcoHD3YdV4pRsUXk398hIo1z+
	rb9YxdrLH4CZBnA3RrgIrbPiE4U6YKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782974322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MpX2K5pbBw1Uk9SjZJbTDy9PGebzitoIF29R4z6f0g=;
	b=zTFkiaYwLL4IoKt8axpF+cspnKOA4N+s9uFpaPhTopSnrJWcSLp1vZ51prhRBrRK1D/0wr
	+H16JVlVjp2tqHDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782974322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MpX2K5pbBw1Uk9SjZJbTDy9PGebzitoIF29R4z6f0g=;
	b=auP9+W8xmRzwS8OtduFfBbGU6tTvAdhM2Pk3DqXemhloXyBhUynM7Wla7SJxOlCshROy7j
	7LvRvxl/duf6AkgcyNEIXc33Roj0b3QNVWmoeKSTeEL+PFcoHD3YdV4pRsUXk398hIo1z+
	rb9YxdrLH4CZBnA3RrgIrbPiE4U6YKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782974322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MpX2K5pbBw1Uk9SjZJbTDy9PGebzitoIF29R4z6f0g=;
	b=zTFkiaYwLL4IoKt8axpF+cspnKOA4N+s9uFpaPhTopSnrJWcSLp1vZ51prhRBrRK1D/0wr
	+H16JVlVjp2tqHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85DDA779AA;
	Thu,  2 Jul 2026 06:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hcFNHnIHRmrqTgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 02 Jul 2026 06:38:42 +0000
Message-ID: <31e15b73-4f34-42b5-b735-6523f52aad30@suse.de>
Date: Thu, 2 Jul 2026 08:38:42 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] ata: libata: rename ata_dev_is_zac()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260702063412.1892584-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 7/2/26 8:34 AM, Damien Le Moal wrote:
> The helper function ata_dev_is_zac() checks if a device is a ZAC class
> device (host managed zoned disk) or if it is a host aware zoned disk, that
> is, a regular ATA disk that supports the zoned capabilities. So the name
> of this helper function is confusing as it hints at the first case only.
> 
> Rename this helper function to ata_dev_is_zoned() to avoid confusions and
> better reflect the two cases tested.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-core.c | 6 +++---
>   drivers/ata/libata-scsi.c | 7 +++----
>   drivers/ata/libata.h      | 2 +-
>   3 files changed, 7 insertions(+), 8 deletions(-)
> 
Sigh ... This was the first function I ever coded when starting SMR support.

You could have shown a bit more respect ;-)

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
