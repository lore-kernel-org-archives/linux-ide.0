Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F107612CD8B
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948604; cv=none; b=IqrYF7y7YWsAQM8YVkjS47MeH3/qqSTux2tM9upYPHRgxB1NSoUbUFCejMgQcDgCIvgWZirJzK2RrNPhaw2gv/DrRJE/fsOazoPZfMqGeWhiqn6XPF1lhB4poE1kEhfeAWcoRmz0r47AIBVdFumCQWo3R1zi+19iEBzYtxrr+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948604; c=relaxed/simple;
	bh=9pAq9tYn+nytKoewBa874xPdVn8QsO+prYPTaUrx4V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWuOZ9rw/5bs7C5nK281xXctJ/tNRCUfdyTZPUlccPd3v0i+iF8mNtXZuVPTYwzTYiQRBnKo+FiK7njxXbfbA3s6UrXAfs60QYr7nsX4r3sA3obrxLlFxsqYDYk5kvobPpaQD/BTXMw1bm4rhq/wWzoQCZG1EafsQx7ntmr4yNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UY8eFqvm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ofgz32gD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UY8eFqvm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ofgz32gD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UY8eFqvm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ofgz32gD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UY8eFqvm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ofgz32gD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E5E067253;
	Thu, 28 May 2026 06:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779948601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN2jhCRNxd3Tv4ntGKyJP+Sh8HcpVuFXmHUuviU2yDo=;
	b=UY8eFqvmvrB0KvrpOgxgrzMoa7fEYKT6QRhw67CvMAcsGliap0ELsfK4BKp9YPv45kcyFf
	cNJlVEvFK/6Dfhvda3KUbl5WpiiwrjhWpgFa6/dn1xGaqLKSHvM4C1qeq+Ye2Xg/+uAe/n
	b8dCty0SkTuiMy4JDLGMpmdpJ1QUuvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779948601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN2jhCRNxd3Tv4ntGKyJP+Sh8HcpVuFXmHUuviU2yDo=;
	b=ofgz32gDqKxDEvpH4WSCNIvk2eHpPyJAmqbVcCjhT1n7wICOP4nHkc8/bQh1WcwI2PKMw9
	yWbQehkbIaJHbXCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779948601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN2jhCRNxd3Tv4ntGKyJP+Sh8HcpVuFXmHUuviU2yDo=;
	b=UY8eFqvmvrB0KvrpOgxgrzMoa7fEYKT6QRhw67CvMAcsGliap0ELsfK4BKp9YPv45kcyFf
	cNJlVEvFK/6Dfhvda3KUbl5WpiiwrjhWpgFa6/dn1xGaqLKSHvM4C1qeq+Ye2Xg/+uAe/n
	b8dCty0SkTuiMy4JDLGMpmdpJ1QUuvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779948601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN2jhCRNxd3Tv4ntGKyJP+Sh8HcpVuFXmHUuviU2yDo=;
	b=ofgz32gDqKxDEvpH4WSCNIvk2eHpPyJAmqbVcCjhT1n7wICOP4nHkc8/bQh1WcwI2PKMw9
	yWbQehkbIaJHbXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECD0B5AC31;
	Thu, 28 May 2026 06:10:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sOfANzjcF2omfgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 28 May 2026 06:10:00 +0000
Message-ID: <fda69a7d-622b-4523-b07e-0fc79739fccd@suse.de>
Date: Thu, 28 May 2026 08:10:00 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] ata: libata: Fix ata_exec_internal()
To: Bart Van Assche <bvanassche@acm.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Marco Elver <elver@google.com>, Jeff Garzik <jgarzik@redhat.com>,
 Tejun Heo <htejun@gmail.com>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-2-bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260521173347.2079560-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[acm.org:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]

On 5/21/26 19:33, Bart Van Assche wrote:
> Some but not all ata_exec_internal() calls happen from the context of
> the ATA error handler. Commit c0c362b60e25 ("libata: implement cross-port
> EH exclusion") added ata_eh_release() and ata_eh_acquire() calls in
> ata_exec_internal(). Calling these functions is necessary if the caller
> holds the eh_mutex but is not allowed if the caller doesn't hold that
> mutex. Fix this by only calling ata_eh_release() and ata_eh_acquire() if
> the caller holds the eh_mutex. An example of an indirect caller of
> ata_exec_internal() that does not hold the eh_mutex is
> ata_host_register().
> 
> Fixes: c0c362b60e25 ("libata: implement cross-port EH exclusion")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/ata/libata-core.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
