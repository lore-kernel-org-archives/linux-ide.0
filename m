Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1181D38E10F
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975881; cv=none; b=ez2P5RQup9X5EubIOAqlWQU/sArhwGuxKKkyqr1amLqkVC5YIQgO8lzRsSUkoDDDCtOYlF9kHh/MbBj9qp9si3FHD1FhMjUeaxc6jU+nVGH97OGwuK5eH8a4pTqdpgAQj8qDKbZVJeL1gFkTb0u81N4O1f63leirxAeTM6CfTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975881; c=relaxed/simple;
	bh=2ctiVOf1aKcYL+6i2yvP9KyRMOnOl/hOL/N+UPqxsvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2dzHp+LQ/+/VZpTogYOOIEaAMBPDF+ks2tCc5Iz+NJXksXY7S8VaPMr6rxoMtcmN4TKCO+YuLUdDaTijogx464mRQrSjY5vcNzXN7zw9NxWOXcnqGw6T7dg3+GucD7iHCkgnVUZoa6VeDIkJ9egIhZEwaMCx5ZftXgE2VZZ3YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HkaiRpxQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EqSW7J5m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HkaiRpxQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EqSW7J5m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HkaiRpxQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EqSW7J5m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HkaiRpxQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EqSW7J5m"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 87E3A73351;
	Thu,  2 Jul 2026 07:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782975877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXq3/p6R6KUhtuIe5F4vNky3JdtUpQIPSK99p1ikGUs=;
	b=HkaiRpxQNWuITHJhZFAZsVXTVhLa5VhOi3L4kV6iFQUVkC5UJOwC1isiyw68UKDEF+hXVP
	UGm5nSY/B4Hhk7xvnh+b/8xp/s+lxg7KkUfepa+YJ0JqFp3i4EyyHKcpqJJCC6yoyQXrYO
	Y/cJesrvZKmzGhTrznbbDxHOgQNMKHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782975877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXq3/p6R6KUhtuIe5F4vNky3JdtUpQIPSK99p1ikGUs=;
	b=EqSW7J5mThnxhdSYvFpSMN5fnev2u2ED+EtGyObpiX0pCFa++1td3u3u2gVIQB87fuulo+
	d6LiqMa9UPkdtzCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782975877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXq3/p6R6KUhtuIe5F4vNky3JdtUpQIPSK99p1ikGUs=;
	b=HkaiRpxQNWuITHJhZFAZsVXTVhLa5VhOi3L4kV6iFQUVkC5UJOwC1isiyw68UKDEF+hXVP
	UGm5nSY/B4Hhk7xvnh+b/8xp/s+lxg7KkUfepa+YJ0JqFp3i4EyyHKcpqJJCC6yoyQXrYO
	Y/cJesrvZKmzGhTrznbbDxHOgQNMKHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782975877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXq3/p6R6KUhtuIe5F4vNky3JdtUpQIPSK99p1ikGUs=;
	b=EqSW7J5mThnxhdSYvFpSMN5fnev2u2ED+EtGyObpiX0pCFa++1td3u3u2gVIQB87fuulo+
	d6LiqMa9UPkdtzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56484779AA;
	Thu,  2 Jul 2026 07:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SkidEoUNRmouaAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 02 Jul 2026 07:04:37 +0000
Message-ID: <d15952bd-8a11-4116-a0dc-05dd4d70456d@suse.de>
Date: Thu, 2 Jul 2026 09:04:36 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata-scsi: scale DSM TRIM payload by MAX PAGES
 PER DSM COMMAND
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org
References: <20260701224638.1835123-4-cassel@kernel.org>
 <20260701224638.1835123-6-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260701224638.1835123-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Level: 
X-Spam-Score: -4.30

On 7/2/26 12:46 AM, Niklas Cassel wrote:
> DSM TRIM currently always emits a single 512-byte page of LBA Range Entries
> (ATA_MAX_TRIM_RNUM == 64 ranges), regardless of how many pages the device
> can accept in one DATA SET MANAGEMENT command.
> 
> The maximum is reported by MAX PAGES PER DSM COMMAND (IDENTIFY DEVICE word
> 105).  Honour it: size the TRIM descriptor as a whole number of 512-byte
> pages, bounded by that limit and by the logical sector size (the WRITE SAME
> data-out buffer is a single logical block).  Build and transfer only as
> many pages as the request needs, and set the DSM COUNT field, qc->nbytes
> and the maximum WRITE SAME length in the Block Limits VPD page accordingly.
> 
> Build the descriptor straight into the WRITE SAME data-out buffer using an
> atomic sg_miter mapping, instead of staging it in the shared ata_scsi_rbuf
> and copying it out.  This removes the global ata_scsi_rbuf_lock and a
> memcpy from the TRIM path.
> 
> While commit 9379e6b8e0f9 ("libata: Safely overwrite attached page in WRITE
> SAME xlat") replaced direct access to the data-out buffer with an
> intermediate step that writes the entries in the ata_scsi_rbuf buffer, this
> solution writes to the data-out buffer using sg_miter, which maps each
> segment with kmap_atomic (SG_MITER_ATOMIC), so it's highmem- and
> multi-segment-safe, and it's usable from the non-sleeping
> command-submission path (unlike the page_address() access that
> ata_scsi_rbuf originally replaced).
> 
> A 512-byte-sector device still uses a single page, so its behaviour is
> unchanged.
> 
> Add ata_id_dsm_max_pages() to read IDENTIFY DEVICE word 105.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 132 ++++++++++++++++++++++++++------------
>   include/linux/ata.h       |  13 ++++
>   2 files changed, 104 insertions(+), 41 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
