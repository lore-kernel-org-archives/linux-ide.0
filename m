Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9B2253EC
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974878; cv=none; b=FxNszj6wXeUtv+6pNnHKzGGtrhMFGPK5qY6O+39Z95Oc4tuR+2FHuYzAaWQ9/So4FPLga1Gm8iwaLganODadDvt8G1pbRD/LFv6iLd3fZusXpfjXal0g99DXmH9RKDyRmkU5MnE7yqhhZQilwJ97VP83TXw3OyQ10RY/iemrpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974878; c=relaxed/simple;
	bh=kjcEehE4mLOyMYcSsIb8A7vHSH4836emt0ihwRvU3pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eeOp2pGk2N/MeYhI7xBN4r81pbRPKy4myyZ9WHf2RaMUKmD7Z9MXOqcbavdoBfj0cZr/7wyYi8oDDDM3xXqCFOmuAPAeX78oH22vqrg7wi23cvJIHYJo0mEVfwCrirC0/Fn4vBuU+B9+9JeEyBYqpjkT2lbJVSssGwCKYbGdAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N3rw8fIz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=By5OOM76; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N3rw8fIz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=By5OOM76; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N3rw8fIz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="By5OOM76";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N3rw8fIz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="By5OOM76"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8A51758AD;
	Thu,  2 Jul 2026 06:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782974786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoIcTkRxFnsAHg8A2NzjHpuhoAjqTvkD/EqK9AK++Vo=;
	b=N3rw8fIzen0U2jLhBTj56c8FTBBe/cNJqo/9EyQQ4kL8VInAgF8PmEMemNOZbMTF1Dgz25
	LLsZAnUJzWvbaEPfBmCt5fQd6QqG+X9JRFMHDNREp/uJXA2yR3Qdz9b1tjrXd+4YA4lBVY
	8lakNuG8qPRsbuReXVB4R3vyJL3nxw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782974786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoIcTkRxFnsAHg8A2NzjHpuhoAjqTvkD/EqK9AK++Vo=;
	b=By5OOM76flBH5aUoQ1haNSf6Wbmg/TDRKTg0l/GT4vQ7cflODMF/w9bay8oBoyASGp+v3J
	+NcWu7Pjm3LMF3AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782974786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoIcTkRxFnsAHg8A2NzjHpuhoAjqTvkD/EqK9AK++Vo=;
	b=N3rw8fIzen0U2jLhBTj56c8FTBBe/cNJqo/9EyQQ4kL8VInAgF8PmEMemNOZbMTF1Dgz25
	LLsZAnUJzWvbaEPfBmCt5fQd6QqG+X9JRFMHDNREp/uJXA2yR3Qdz9b1tjrXd+4YA4lBVY
	8lakNuG8qPRsbuReXVB4R3vyJL3nxw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782974786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoIcTkRxFnsAHg8A2NzjHpuhoAjqTvkD/EqK9AK++Vo=;
	b=By5OOM76flBH5aUoQ1haNSf6Wbmg/TDRKTg0l/GT4vQ7cflODMF/w9bay8oBoyASGp+v3J
	+NcWu7Pjm3LMF3AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6642779AA;
	Thu,  2 Jul 2026 06:46:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +ZggJ0IJRmrkVgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 02 Jul 2026 06:46:26 +0000
Message-ID: <3963f91e-b60e-40e5-8a94-a0e6b1bbd86c@suse.de>
Date: Thu, 2 Jul 2026 08:46:26 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] ata: libata-scsi: support reporting options 2 in
 REPORT SUPPORTED OPERATION CODES
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-5-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260702063412.1892584-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Level: 

On 7/2/26 8:34 AM, Damien Le Moal wrote:
> Add support for the reporting options value 2 of the in REPORT SUPPORTED
> OPERATION CODES command in ata_scsi_report_supported_opcodes(). With this
> reporting option, the specified opcode to check must have a service
> action. Use ata_scsi_supported_cmd_has_sa() to check for this and fill the
> command reply buffer using the one command format based on the command
> support.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
