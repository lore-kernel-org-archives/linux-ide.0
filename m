Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E743A544D
	for <linux-ide@vger.kernel.org>; Fri, 29 May 2026 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035787; cv=none; b=GoraBL5oPnBtgMJxFyjSrTC1Qnh717rlOGtALXWnmupQFs77M2jGYCeA7mKyUkjDYirLz/eMYkfL0EQRzZ0gOtqVkqRS8VsT0aY+m4TXDnf7hAzcpj/TLMK3gn+9fmWTfFwoTPp8Y0dOPE22hSygxLc5tQ+/9PlM+HH0N2BBZnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035787; c=relaxed/simple;
	bh=Dlldkz4atz0IFoTbXPtMMybzj28b+HldOZqQ98ie7sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEcz+NAoP+TCyiMuPbe/fcLBYGXDvnrbkKUcXJ2slmCLWDbzgdJdnkSg5mfPSu85k+m4xXb2aScQmE9ShRsy4o0HkfYbS2OD6w7vQmQOvc8hf1ShWTHUwRa2k1vQRzNdlcDtsxn/zSbQTHW1kQG+MTHVcxGFbU76RSGEclq0NfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CM03s65N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cC7iTqoz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CM03s65N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cC7iTqoz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CM03s65N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cC7iTqoz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CM03s65N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cC7iTqoz"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F375266E2C;
	Fri, 29 May 2026 06:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780035785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvUl5un26cKMHU/msnsQ5s7HWpd+edRo0zJQiI4qrBg=;
	b=CM03s65NBalaLUIDp0mrF+GNKNrlpIWfdD4j9od4rwBxmn87d8KHkYD3gKPQUttPZXQ7ou
	CHgreJfGuR7MxbjaYlXRPWjocSR04NvBoUQv1GclrklwIdN835XAMSJpZ/E+pCLE1mCbXu
	jeSTSQ/8YhuyHajRk+W0aUXEmuopyDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780035785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvUl5un26cKMHU/msnsQ5s7HWpd+edRo0zJQiI4qrBg=;
	b=cC7iTqozgMQ0KDk4Nm2DMN7tNz3Zeeao/dh0VBNhLsKTHU/zFd0QvBh456aYgTI71jOIKR
	G/4pKHpB8rCgB4BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780035785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvUl5un26cKMHU/msnsQ5s7HWpd+edRo0zJQiI4qrBg=;
	b=CM03s65NBalaLUIDp0mrF+GNKNrlpIWfdD4j9od4rwBxmn87d8KHkYD3gKPQUttPZXQ7ou
	CHgreJfGuR7MxbjaYlXRPWjocSR04NvBoUQv1GclrklwIdN835XAMSJpZ/E+pCLE1mCbXu
	jeSTSQ/8YhuyHajRk+W0aUXEmuopyDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780035785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvUl5un26cKMHU/msnsQ5s7HWpd+edRo0zJQiI4qrBg=;
	b=cC7iTqozgMQ0KDk4Nm2DMN7tNz3Zeeao/dh0VBNhLsKTHU/zFd0QvBh456aYgTI71jOIKR
	G/4pKHpB8rCgB4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF3805B1CB;
	Fri, 29 May 2026 06:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nS1vMcgwGWrTGQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:23:04 +0000
Message-ID: <f5860462-792a-4b48-8b9e-57d2a486105e@suse.de>
Date: Fri, 29 May 2026 08:23:04 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ata: Annotate functions in the issuing path with
 __must_hold()
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Marco Elver <elver@google.com>,
 linux-ide@vger.kernel.org
References: <20260528172855.703631-5-cassel@kernel.org>
 <20260528172855.703631-8-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260528172855.703631-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,acm.org:email,suse.de:email,suse.de:mid]

On 5/28/26 19:28, Niklas Cassel wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> Annotate the following functions used in the issuing path:
> ata_qc_issue(), ata_sas_queuecmd(), ata_scsi_qc_issue(),
> ata_scsi_translate(), __ata_scsi_queuecmd()
> 
> These functions are all used in the issuing path, so context analysis will
> be able to verify that the ap lock is held, from it is taken in
> sas_queuecommand() or ata_scsi_queuecmd() all the way down to
> ata_qc_issue().
> 
> Commenting out the spin_lock_irqsave() successfully results in a compiler
> error on Clang 23.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Co-developed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-core.c | 1 +
>   drivers/ata/libata-sata.c | 1 +
>   drivers/ata/libata-scsi.c | 3 +++
>   drivers/ata/libata.h      | 6 ++++--
>   include/linux/libata.h    | 3 ++-
>   5 files changed, 11 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
