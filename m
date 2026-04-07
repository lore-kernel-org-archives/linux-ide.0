Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC60F3A8746
	for <linux-ide@vger.kernel.org>; Tue,  7 Apr 2026 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558349; cv=none; b=CVAjGt1LnWzhYvDhMsbRxYRhYy4JcS6hhAchnjtzbihQeoKSztjVVNnGr7+Mg3EwO0Dkhe2e4ES2B3qlvmvgtrMHkuWNMaOLhBK3cW/6xR4TihSynaMMt380alLtE1JHsa1z75UTdu6NpRlFuBQ+8b+uIQgfFuUgCIfr1JW6Q9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558349; c=relaxed/simple;
	bh=1C/x1K9tpwrzDl75cEEXZLcpaEZTvMWQSGr2zmpsx4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBaDj8ge3EnuJgELKV92QLeY3PHevg7r7rH/Yk3TYaJ5BOjUV8BX7MEvEbyUwDRP8OQjQoBESZwvbW7CX1TP2EZwI9+tAgNoBuNQxx3l/zcgezpedjMfAcD+za3ozL/hyu8BIRVaJmpVlAFn+3JyAaE8MF1wU7O1nS2Jhz/BVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nuzdkKOV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fAecOp7o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=19+bATp+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qYIgmtq+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nuzdkKOV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fAecOp7o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="19+bATp+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qYIgmtq+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0185A4E3E8;
	Tue,  7 Apr 2026 10:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775558346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1WBG+7KJ4506PGTWri4IK6YPhtrIA99Sxo6dE227Ik=;
	b=nuzdkKOVlb1plXTDxDRGZ1vjtSvJyjfZ8xfA5hyPiHY9dI+Mir1dXm+YAlBjMi7HiQHWn7
	+pLHg5ZMAhZwXKXcnNAuNp/76MInTNQsw1D19XkkrTTRfes0DqEz2pDkXsGlofMyY61BEc
	Nit0JSB2h1nosDEROd/fWzPhFDahefc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775558346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1WBG+7KJ4506PGTWri4IK6YPhtrIA99Sxo6dE227Ik=;
	b=fAecOp7oozgQXc4WkDmey4UYxnadqmVvtXu8DqZMgjfHc/Pfcsn49pWkWLY1ABhY8+jhi3
	6F7N5W0VKcHT/YAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775558345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1WBG+7KJ4506PGTWri4IK6YPhtrIA99Sxo6dE227Ik=;
	b=19+bATp+Ics3w+VKZyZWxF9v2v19IosPXeIOLINIAEkgAkpe4gXillkTUaWYZE5WzN4okv
	ciaMDUcLglIaqxjLV4VxcVY95kJjL+mP4dam3aFO1EDya2OAqTm+WUdtJDUogfC3vWcfz6
	7RBg5XwCUkKzOfwJnrk6WebCpfWcsaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775558345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1WBG+7KJ4506PGTWri4IK6YPhtrIA99Sxo6dE227Ik=;
	b=qYIgmtq+4iCNa+ajbAKLntMbft6O95rrhvTfcEm8d8Z+wrwLjCgIKfMNKbcQDwrA0GaHBe
	Qf78lXnxE8fbtjAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF1F14A0B0;
	Tue,  7 Apr 2026 10:39:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gi6UNcje1GlFJAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Apr 2026 10:39:04 +0000
Message-ID: <05030d56-c59d-474f-8b77-c5d0c456647e@suse.de>
Date: Tue, 7 Apr 2026 12:39:04 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ata: libata-transport: remove static variable
 ata_scsi_transport_template
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
 <c23f827a-2ff9-4a6d-afcb-fce83fda4899@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c23f827a-2ff9-4a6d-afcb-fce83fda4899@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 3/30/26 17:21, Heiner Kallweit wrote:
> Simplify the code by making struct ata_scsi_transportt public, instead
> of using separate variable ata_scsi_transport_template.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/ata/libata-scsi.c      | 2 +-
>   drivers/ata/libata-transport.c | 9 ++-------
>   drivers/ata/libata-transport.h | 2 +-
>   3 files changed, 4 insertions(+), 9 deletions(-)
> 
Huh. Not a big fan of this.

The idea of using a pointer is that it'll be initialized to 'NULL'
if the module / file isn't present.
Exposing a static pointer is tricky in that regard.

Not sure if that is the direction we want to go, but I'll leave it
to the maintainers to decide.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
