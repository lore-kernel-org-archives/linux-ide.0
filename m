Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313362A8D0
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004073; cv=none; b=iD84XiST1lT8tqr01p7d4gTyrSjyugD2XKONVmIumrSb1x4jhK7hql4Mlb9J+g1TRsuavtkmP1ya+UukA5lOOdQpChM4q6JrrzH5yoZicHuTNtYRgb56S6GCS0zaamkxHeuekJWp9SVL8jYnUwmZ7EeXnNntgGExF4SEdOeqiOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004073; c=relaxed/simple;
	bh=NbbvBHmrTcYiw1BZT19JgdQWslszFfxWl1Bwlt8Ycsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AS12FhSojG0v/kXQIkg11B7JvwEslHvhODpMKiBYO+W7bpe63eEwPyhgoUVHaz8sT/yktl9mVlx7VLCWZhGhkyLIhebbKbKi09SzGuHQMUbnQ5EP0S4er8e3R3K9MjddEeoP4BJ06l0sFnw813KplMin6fzmab8IJZ14uYkRxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=skem5nsG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z4X7QKWX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WGqDClFY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G6Ufj7Xo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="skem5nsG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z4X7QKWX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WGqDClFY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G6Ufj7Xo"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA4AC2116D;
	Fri, 27 Jun 2025 06:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751004070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8He9MgIEGijkBV1V/0Oh0tHRr1rXPAnCd3+xyhL0c8=;
	b=skem5nsG1g3vOuA/qCoLw4uel+mzbxsTPxuKC4YslRiZuSZrCqAO/xoxDNSY3ymDvYZsdp
	u06DjM+9MahMY/sgI3CwDBcNptrWBrjuNi5nB1nhgHkOBnNkuIMaYt/D8yx4cXFHiYKEnF
	lyzCa40x+H3SIfgtx+sdvjvVVAUy6W8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751004070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8He9MgIEGijkBV1V/0Oh0tHRr1rXPAnCd3+xyhL0c8=;
	b=Z4X7QKWXTd7j0WlKFcO1SUX+CaSX01Q8r+J/ooWzTcCA3QNVgNOAMnVwl8CvWFVjsc4B+W
	VYucyob7VhHjPNCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WGqDClFY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=G6Ufj7Xo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751004069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8He9MgIEGijkBV1V/0Oh0tHRr1rXPAnCd3+xyhL0c8=;
	b=WGqDClFYLYbRf2hYivx4bRmCgAGcmz04iyOGtyikVXonWJCgX1U73DRdD+840UTyHmGLkY
	Z7PpHAoyVZrX5lUHZvRvHzVxVkQmxZEKljYHEOtEwtSwfIqlMtTSlq01TC3Gi0wmReYHma
	Jk/YK94BdJIcwymSnGUeJ0uKm7ken8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751004069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8He9MgIEGijkBV1V/0Oh0tHRr1rXPAnCd3+xyhL0c8=;
	b=G6Ufj7XoxgZfc9gyqqOn2hL3LEbsoQdJ0bf4ey4p68au2eppk/LIW42Nkg25pw3b2lmctP
	0Vptn5zlopqFeOCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B67B713786;
	Fri, 27 Jun 2025 06:01:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s3DfKqUzXmjNMAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Jun 2025 06:01:09 +0000
Message-ID: <b50acbe8-6e33-4347-9501-52792608e0b3@suse.de>
Date: Fri, 27 Jun 2025 08:01:09 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ata: libata: Remove ATA_DFLAG_ZAC device flag
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250627011155.701125-1-dlemoal@kernel.org>
 <20250627011155.701125-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250627011155.701125-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DA4AC2116D
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.51
X-Spam-Level: 

On 6/27/25 03:11, Damien Le Moal wrote:
> The ATA device flag ATA_DFLAG_ZAC is used to indicate if a devie is a
> host managed or host aware zoned device. However, this flag is not used
> in the hot path and only used during device scanning/revalidation and
> for inquiry and sense SCSI command translation.
> 
> Save one bit from struct ata_device flags field by replacing this flag
> with the internal helper function ata_dev_is_zac(). This function
> returns true if the device class is ATA_DEV_ZAC (host managed ZAC device
> case) or if its identify data reports it supports the zoned command set
> (host aware ZAC device case).
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-core.c | 13 +------------
>   drivers/ata/libata-scsi.c |  5 ++---
>   drivers/ata/libata.h      |  7 +++++++
>   include/linux/libata.h    |  1 -
>   4 files changed, 10 insertions(+), 16 deletions(-)
> 
Goodbye, ZAC ...

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
