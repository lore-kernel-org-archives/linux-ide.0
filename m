Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E0C1FA25C
	for <linux-ide@vger.kernel.org>; Tue,  5 Nov 2024 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791902; cv=none; b=tyX2AauHfvnJ/NqwzVOSNUFwftrZ5BCuwHjSzu0u7fmNh/ekAUyBDFyR/qPhaxHllZpoOp9XG32qCifNdQASvldvhSk9pR8Fe7m4p/quEEaxt50a628maHVM5dICOp01ZZIXtWsdvSsAX+4HaV10892nTVbZnRihtpxAnd+l1D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791902; c=relaxed/simple;
	bh=HCwrkRlLE8bU18d7r6n5id4w2A40DYZWe60R0xwpXGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j//9htHMAlsmS25Vyneg271Hha9n0U1YPwIxO+DrZsokkaiqfV0tv/s6GzTCjkHtcOTWW94al9lKQZhovtn3TTTz5wE79NRyOvLJ1IL5gUyHQ5q7Q1kUYorj0Y5kLLDk9uiHO5xO43NNULxEmUtxwgIYIM6GMzemgNUTN0iKKyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ePd7PJUN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GyRNamFj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ePd7PJUN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GyRNamFj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ePd7PJUN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GyRNamFj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ePd7PJUN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GyRNamFj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9FED921B6E;
	Tue,  5 Nov 2024 07:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730791898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faXDmBALRpGQQh9UBUUzVQn6eMytvSxBsspVLK/ty8I=;
	b=ePd7PJUNjFBzhqR1LLvGwZJcP3J/LcEhqR0vlQ6xbAaOvPB1pdnBht8ch7tNHbmno6Bp87
	uDdReLf3Wqmx+8EhwwpK2YeGnRuTnVrtUIaZ68F1GKKL1RdMesZ6GnqTodLWvf/s863Xgu
	pkQka09bgnEIRL6/6ZnnwyIHOlpIe54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730791898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faXDmBALRpGQQh9UBUUzVQn6eMytvSxBsspVLK/ty8I=;
	b=GyRNamFjpmxeObBoNBNSTi1YWaUlTX6OtLT8oIzdQ9aWkA06hC9eb4KELo5m09vs/PPHIz
	efWlD26HdziOtBAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ePd7PJUN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GyRNamFj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730791898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faXDmBALRpGQQh9UBUUzVQn6eMytvSxBsspVLK/ty8I=;
	b=ePd7PJUNjFBzhqR1LLvGwZJcP3J/LcEhqR0vlQ6xbAaOvPB1pdnBht8ch7tNHbmno6Bp87
	uDdReLf3Wqmx+8EhwwpK2YeGnRuTnVrtUIaZ68F1GKKL1RdMesZ6GnqTodLWvf/s863Xgu
	pkQka09bgnEIRL6/6ZnnwyIHOlpIe54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730791898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faXDmBALRpGQQh9UBUUzVQn6eMytvSxBsspVLK/ty8I=;
	b=GyRNamFjpmxeObBoNBNSTi1YWaUlTX6OtLT8oIzdQ9aWkA06hC9eb4KELo5m09vs/PPHIz
	efWlD26HdziOtBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51D801394A;
	Tue,  5 Nov 2024 07:31:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id piRHEdrJKWcTGgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 05 Nov 2024 07:31:38 +0000
Message-ID: <1f344c71-5132-42cd-a027-2c58f94bdbd2@suse.de>
Date: Tue, 5 Nov 2024 08:31:37 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: libata: Introduce new helper
 ata_qc_complete_success()
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Xingui Yang <yangxingui@huawei.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 linux-ide@vger.kernel.org
References: <20241031140731.224589-4-cassel@kernel.org>
 <20241031140731.224589-5-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241031140731.224589-5-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9FED921B6E
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/31/24 15:07, Niklas Cassel wrote:
> For commands that complete successfully, libata performs some additional
> post processing.
> 
> Move this code to a new helper ata_qc_complete_success(), such that this
> code can be reused from other completion paths.
> 
> A follow-up commit will make use of this helper.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-core.c | 105 +++++++++++++++++++++-----------------
>   include/linux/libata.h    |   1 +
>   2 files changed, 60 insertions(+), 46 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
