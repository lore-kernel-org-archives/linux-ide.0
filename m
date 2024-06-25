Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3DE143889;
	Tue, 25 Jun 2024 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296615; cv=none; b=UQ9QniU9aOgmnZK5eGYa9Vr8IVn/T+04svH2/6mpCDHzQ/rR9V3us53xagLXEOpuRB8kjJuiDg0/Hj81a4DT+irV1/who77KdYTOl4Iz4LxSrKz4qY/nbXyYRJMxj9U7OC+MAavQPBncPh9wjOlfo70Dny4VD92JgRSeTlKjMEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296615; c=relaxed/simple;
	bh=o36e1rWQnzMGs957wZNP+HYveOhcO3ZOgclxudoAsic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AERKSMGRFEg+gfTGKfBxt0ZUWozGkYyYgfYkcJ+0YMzq1vGEOQ4H2MzGFmikXq92/d8p9abpApHQnp3cHf4VTA4FhUNjgKLJ40DmQdZrejTtU25DLWXj1grkakY/tX3EOGbyArWmNlPhV2uE6YvZfIBR4n/do5ho/vU4F1adNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L1M5t+Fo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/Yrck5sd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vXVWaYOh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eqN7hnoE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L1M5t+Fo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/Yrck5sd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vXVWaYOh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eqN7hnoE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF668211F8;
	Tue, 25 Jun 2024 06:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719296612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95zJ1MzLYcur/dA25/Ui/CSFCezs8GPrvTaAE0Ax+WU=;
	b=L1M5t+FoTN+8Np3BQ6fJX6c7200BfR97B+DLIu8Ikr1RI9kouwfxJiODguh9iJSiGlBNkx
	+WVi3in84tu0rYNszq9Coa/yFvMt33yA56e2iZPPqw/g4QTzHBKuwMPGIFGupH6Hs9br1N
	l1LQXgIe7sUjIoeRambV7zRmMpD+8Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719296612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95zJ1MzLYcur/dA25/Ui/CSFCezs8GPrvTaAE0Ax+WU=;
	b=/Yrck5sdy0Ac6dZsQ8xmLI/8Xyp7X5XWKCiEIDUDuxRb/x120T4+RWchq6qKeyh+dT/d13
	IAKKGT2h46XbwaCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719296610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95zJ1MzLYcur/dA25/Ui/CSFCezs8GPrvTaAE0Ax+WU=;
	b=vXVWaYOhi5nunjXuiOgA489DrmsnehmdT5ErndFWwfPo+Zse21xIE8ohMDqo0XLbtmM3cS
	xajPYiKuLjd4lqA9GUFVZt7mIvhOm8veA0PlC/rhPyUUk57pm5CbdH3c4JSER1YBP0Ohyc
	DtU7laTvwvcAN3UhZ+ZtMjIg6+YoUC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719296610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95zJ1MzLYcur/dA25/Ui/CSFCezs8GPrvTaAE0Ax+WU=;
	b=eqN7hnoEBEceohQ3OY0x7pej/Qljs+ALJ678LfNdXzMWIW6OO1XiEmo5RcL4JB2/uQJQxs
	XlL83+otc8E9ncBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A7291384C;
	Tue, 25 Jun 2024 06:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yJlQFmJiemZ5CwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Jun 2024 06:23:30 +0000
Message-ID: <5f62e67e-cef4-45dc-8503-8899b28048e6@suse.de>
Date: Tue, 25 Jun 2024 08:23:30 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] ata: libata-scsi: Do not pass ATA device id to
 ata_to_sense_error()
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-5-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240624221211.2593736-5-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]

On 6/25/24 00:12, Igor Pylypiv wrote:
> ATA device id is not used in ata_to_sense_error().
> 
> Fixes: ff8072d589dc ("ata: libata: remove references to non-existing error_handler()")
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/ata/libata-scsi.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

