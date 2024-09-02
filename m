Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E276E2AE99
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258199; cv=none; b=QDm+pY2dhHwYEePfXLSeT+SACj2a0Bh/okwYA/XcKf9ujfcZ98rg4uD+VXo7yGG+/1eoK+/BhGVhKCikSieIVbfgkwfYZJVv7xzJo8RNxmQDX8Xa8yyzBBkQ9lnxslpZ1xPex4xyD7J2R7mWqGuOWZQNKC7UZcfV4ra9EaioPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258199; c=relaxed/simple;
	bh=jUf62lIeo2I7k2753rI9eTi8J6+xLFvMd5KOhwbD8OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XPPIbjpo7QwsqqaX3sWtNT4zT0SCuIW0qqfpD3LRJ+zC95JRs57WG0IL0GiU4q1Jlo6i8k0CAGHnVCGKDS+C9DVuE0bkdqQOAGlPgv/ehVvjhaiVggmHTWGYJn0JTnzMJXQxcVncTeld2PNIWGshwQQiBazv6s3SEhff8ifLE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JLmDib7w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Iq701eZ4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JLmDib7w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Iq701eZ4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JLmDib7w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Iq701eZ4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JLmDib7w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Iq701eZ4"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 268491FB97;
	Mon,  2 Sep 2024 06:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725258196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjfNuD09NnAxXHi1djAQKpaZc5goTYTPcElkOybQAZA=;
	b=JLmDib7wF2N2HU9AXBQeAuNDkuPusZ5/OZvAoP+lNoEx6iT03tpHOSi3wyljuK5+9OEw0Z
	iMeuhUZ2JRGQz5NfpasfKOeL8GzCJ1vqS9pcOs96dnmUH4ImrDj4q2zv51DfZnLM5ZKpjt
	uplcj0GjJ5gRFppLZ7xqaNYSM5eU8Ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725258196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjfNuD09NnAxXHi1djAQKpaZc5goTYTPcElkOybQAZA=;
	b=Iq701eZ4iWK4fps+PHRnBPOk+2xMXSwjpG8yEQl+sfW/oxJ+hH9gMNyFYkDBFg4N4rZUrb
	U99zHOnejceoqnCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JLmDib7w;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Iq701eZ4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725258196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjfNuD09NnAxXHi1djAQKpaZc5goTYTPcElkOybQAZA=;
	b=JLmDib7wF2N2HU9AXBQeAuNDkuPusZ5/OZvAoP+lNoEx6iT03tpHOSi3wyljuK5+9OEw0Z
	iMeuhUZ2JRGQz5NfpasfKOeL8GzCJ1vqS9pcOs96dnmUH4ImrDj4q2zv51DfZnLM5ZKpjt
	uplcj0GjJ5gRFppLZ7xqaNYSM5eU8Ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725258196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjfNuD09NnAxXHi1djAQKpaZc5goTYTPcElkOybQAZA=;
	b=Iq701eZ4iWK4fps+PHRnBPOk+2xMXSwjpG8yEQl+sfW/oxJ+hH9gMNyFYkDBFg4N4rZUrb
	U99zHOnejceoqnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DABD513AE5;
	Mon,  2 Sep 2024 06:23:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cPLoMdNZ1Wa8GQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Sep 2024 06:23:15 +0000
Message-ID: <16db3823-fac9-4b68-a2cc-d692abdb4015@suse.de>
Date: Mon, 2 Sep 2024 08:23:15 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] ata: libata: Improve CDL resource management
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20240902000043.155495-1-dlemoal@kernel.org>
 <20240902000043.155495-8-dlemoal@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240902000043.155495-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 268491FB97
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

On 9/2/24 02:00, Damien Le Moal wrote:
> The ncq_sense_buf buffer field of struct ata_port is allocated and used
> only for devices that support the Command Duration Limits (CDL) feature.
> However, the cdl buffer of struct ata_device, which is used to cache the
> command duration limits log page for devices supporting CDL is always
> allocated as part of struct ata_device, which is wasteful of memory for
> devices that do not support this feature.
> 
> Clean this up by defining both buffers as part of the new ata_cdl
> structure and allocating this structure only for devices that support
> the CDL feature. This new structure is attached to struct ata_device
> using the cdl pointer.
> 
> The functions ata_dev_init_cdl_resources() and
> ata_dev_cleanup_cdl_resources() are defined to manage this new structure
> allocation, initialization and cleanup when a port is removed or a
> device disabled. ata_dev_init_cdl_resources() is called from
> ata_dev_config_cdl() only for devices that support CDL.
> ata_dev_cleanup_cdl_resources() is called from ata_port_free() and
> ata_eh_dev_disable() to free the ata_cdl structure when a device is
> being disabled by EH or its port being removed.
> 
> Note that the name of the former cdl log buffer of struct ata_device is
> changed to desc_log_buf to make it clearer that it is a buffer for the
> limit descriptors log page.
> 
> This change reduces the size of struct ata_device, thus reducing memory
> usage for ATA devices that do not support the CDL feature.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-core.c | 74 ++++++++++++++++++++++++++-------------
>   drivers/ata/libata-eh.c   |  2 ++
>   drivers/ata/libata-sata.c |  2 +-
>   drivers/ata/libata-scsi.c |  2 +-
>   drivers/ata/libata.h      |  1 +
>   include/linux/libata.h    | 21 ++++++++---
>   6 files changed, 72 insertions(+), 30 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

