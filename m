Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BAA125B2
	for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050004; cv=none; b=l3FMnjEZC7lnfVRSNy4499+k+6fs7ihupvwv9zPFvuNJls4uwsEnSHfkrvcfdxwLDaqGRzYXS47xiS5PLK1GIQ1L9AZ0goOcx4dpfSuvzjPfdtQJWFGUI6osA7N7GvyrF7COKy/qItFZtPHM0buUUcJLcunAMY8VfbeoGiOPMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050004; c=relaxed/simple;
	bh=7zYTMkk3AYB/Jf/6F4t+rFln7u1WGy6fazYkdR+BqWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cypdb9QASiNawiypLEIRh1ZodRBfaKmHTisNZxP/H2UQc89oDq4VZhDXtx/AOifKvymrAdKe8GdlG93OGDZLH5seyC0InhgONforUHLY5HcoKri6lgnqR4Dxh2dkEYsnJ0+NPVM04dqOTY1L2lUv0Mjhi5os0gUQmmsV3BHUhjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M2q2zAL/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RQlmCTZm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hMorgTQd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bjBd8laA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M2q2zAL/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RQlmCTZm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hMorgTQd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bjBd8laA"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDBF55BCC7;
	Thu, 18 Dec 2025 09:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766050001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYhJAFT01h5jgn69tNo/U+y95VN+PMYB8rXu8seK6H8=;
	b=M2q2zAL/TM1GxAR3jM48IuVCxLjuS9lqOWUxCtdg4M4rnQuNZ6o5CARNOaXz/VlCGU8ROM
	ktQTBDmDm4bmy3Ce1OFOUbBLTch96Kjliuc3df9H0n+SPqrXhXXtXoqdzMUOA2LPP5GheY
	e8DbstJ5q0W5PGxzhjwVsKBsLEjCeps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766050001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYhJAFT01h5jgn69tNo/U+y95VN+PMYB8rXu8seK6H8=;
	b=RQlmCTZmJIU+Z47cSYAs5Tca2fOAJTqysxhCxQnp/R93i4pg1hKReYVCaKED0hOzGaWqJZ
	somaRiiXCmxW9hCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766049999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYhJAFT01h5jgn69tNo/U+y95VN+PMYB8rXu8seK6H8=;
	b=hMorgTQdQlWdI+DQL4DAm742/v71hhEXmia2w7S3FQj1NGO/xipably9gA3UxR3i4gQZx/
	TvQVcpoemYy5aq4ak2LMI3NrumGZXxcsFwveW6MyFQYJy2CV1skcVCw+UDENRHg/Pj8ifm
	RRgPANoEC1bfVJw+4Z3Cy4IO/ExfyEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766049999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYhJAFT01h5jgn69tNo/U+y95VN+PMYB8rXu8seK6H8=;
	b=bjBd8laAAR8RkYGFvSmCQe3/kREendazKZ3ilocOTfU9XRcKRbwfzIthfKsPIUgOz5DI6E
	8XxkjaV0FYs+Z9AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91EA13EA63;
	Thu, 18 Dec 2025 09:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 99eEIs/IQ2kgIwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Dec 2025 09:26:39 +0000
Message-ID: <894666a3-21bd-47fc-a353-db350abfdc1d@suse.de>
Date: Thu, 18 Dec 2025 10:26:39 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata-scsi: avoid passthrough command
 starvation
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>, Xingui Yang <yangxingui@huawei.com>
References: <20251217231712.490765-1-dlemoal@kernel.org>
 <20251217231712.490765-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251217231712.490765-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.26
X-Spam-Level: 
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.16)[-0.809];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,huawei.com:email]

On 12/18/25 00:17, Damien Le Moal wrote:
> When a non-NCQ passthrough command is issued while NCQ commands are
> being executed, ata_scsi_defer() indicates to ata_scsi_translate() that
> ata_qc_issue() should not be called for the passthrough command, and
> instead returns SCSI_MLQUEUE_XXX_BUSY to defer the command execution.
> This command deferring is correct and as mandated by the ACS
> specifications since NCQ and non-NCQ commands cannot be mixed.
> 
> However, in the case of a host adapter using multiple submission queues,
> when the target device is under a constant load of NCQ read or write
> commands, there are no guarantees that requeueing the non-NCQ command
> will lead to it not being deferred again repeatedly, since other
> submission queues can constantly issue NCQ commands from different CPUs
> ahead of the non-NCQ command. This can lead to very long delays for the
> execution of non-NCQ passthrough commands, and even complete starvation
> in the worst case scenario.
> 
> Since the block layer and the SCSI layer do not distinguish between
> queuable (NCQ) and non queueable (non-NCQ) commands, libata-scsi SAT
> implementation must ensure forward progress for non-NCQ commands in the
> presence of NCQ command traffic. This is similar to what SAS HBAs with a
> hardware/firmware based implementation do.
> 
> Implement such forward progress guarantee by limiting requeueing of
> non-NCQ commands: when a non-NCQ command is received and NCQ commands
> are in-flight, do not force a requeue of the non-NCQ command by
> returning SCSI_MLQUEUE_XXX_BUSY in ata_scsi_translate() and instead
> hold on to the qc using the new deferred_qc field of struct ata_port.
> 
> This deferred qc will be issued using the work item deferred_qc_work
> running the function ata_scsi_deferred_qc_work() once all in-flight
> commands complete, which is checked with the port qc_defer() callback
> indicating that no further delay is necessary. This check is done using
> the helper function ata_scsi_schedule_deferred_qc() which is called from
> ata_scsi_qc_complete(). This thus excludes this mechanism from all
> internal non-NCQ commands issued by ATA EH.
> 
> When a port deferred_qc is non NULL, that is, the port has a command
> waiting for the device queue to drain, the issuing of all incoming
> commands (both NCQ and non-NCQ) is deferred using the regular busy
> mechanism. This simplifies the code and also avoids potential denial of
> service problems if a user issues too many non-NCQ passthrough commands.
> 
> Finally, whenever ata EH is scheduled, regardless of the reason, a
> deferred qc is always requeued so that it can be retried once EH
> completes. This is done by calling the function
> ata_scsi_requeue_deferred_qc() from ata_eh_set_pending(). This avoids
> the need for any special processing for the deferred qc in case of NCQ
> error, link or device reset, or device timeout.
> 
> Reported-by: Xingui Yang <yangxingui@huawei.com>
> Reported-by: Igor Pylypiv <ipylypiv@google.com>
> Fixes: 42f22fe36d51 ("scsi: pm8001: Expose hardware queues for pm80xx")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-core.c |  1 +
>   drivers/ata/libata-eh.c   |  6 +++
>   drivers/ata/libata-scsi.c | 93 ++++++++++++++++++++++++++++++++++++++-
>   drivers/ata/libata.h      |  2 +
>   include/linux/libata.h    |  3 ++
>   5 files changed, 104 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
