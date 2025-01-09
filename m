Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1784A2010EB
	for <linux-ide@vger.kernel.org>; Thu,  9 Jan 2025 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407072; cv=none; b=JaDAed1w0U5auE0NYOWg1gGuqq+ZEAI8e6DwIqWri7IWgaxf/lxQa4RrOaSwOozMxE9Xc72Litzy8CLsjdwgFOKDl6DGKxWJc29w6QP761cAb67hgHdK5EJOLPYLla/jgcRmzEPj8aI06WWbc8i6Nt4hddrcDDh0ygY4EFG+w3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407072; c=relaxed/simple;
	bh=U7J3YjCJ+FybrcSPqxRoLwnVDjkHzwBZkYDJtkpQ6uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WY0Hg7EHFomdDD/fiuuL77+AZcSTCeTs9+5j7e+oYpttEeO8zXLJNMPGDTqf5A9oToy7ART10b2Q7yghmQee7PUehPt9XvGbS/8ItnNECFgurlLuVf9ttBpUzDoa7Z7bDmEY73RpHVQ1Lg2bTOYljKZf19xNdpEzNTf8obC0WjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U/UlZyeG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WzQtFmuz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U/UlZyeG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WzQtFmuz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U/UlZyeG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WzQtFmuz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U/UlZyeG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WzQtFmuz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1418C1F385;
	Thu,  9 Jan 2025 07:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736407067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRqju7CtJh3zOiNyN6t/6uAC5IozpZjkEgVHq+73vhM=;
	b=U/UlZyeGfum/W+5vIaBe9PaTkgcCpxSet4bJh+rJrLos/b/XiDqLgCCoO2hLksES672Tmt
	gEg86aWiQgo/LX4yv0SdHL+efwWLipO/Gt3RBzvhpNmi4dG2wHe3Fs8b4POXh32NoBGfi2
	WjUNNFtCqeX3YksY9SW2l9g461saFic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736407067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRqju7CtJh3zOiNyN6t/6uAC5IozpZjkEgVHq+73vhM=;
	b=WzQtFmuzWx6nxUK0JZ3Vno+d5V92u+K4ZUwgbqh95ob0C/wFT2cM9ehwvSwrtKx41KwU0S
	UDVfG1+uVti3XeBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="U/UlZyeG";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WzQtFmuz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736407067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRqju7CtJh3zOiNyN6t/6uAC5IozpZjkEgVHq+73vhM=;
	b=U/UlZyeGfum/W+5vIaBe9PaTkgcCpxSet4bJh+rJrLos/b/XiDqLgCCoO2hLksES672Tmt
	gEg86aWiQgo/LX4yv0SdHL+efwWLipO/Gt3RBzvhpNmi4dG2wHe3Fs8b4POXh32NoBGfi2
	WjUNNFtCqeX3YksY9SW2l9g461saFic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736407067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRqju7CtJh3zOiNyN6t/6uAC5IozpZjkEgVHq+73vhM=;
	b=WzQtFmuzWx6nxUK0JZ3Vno+d5V92u+K4ZUwgbqh95ob0C/wFT2cM9ehwvSwrtKx41KwU0S
	UDVfG1+uVti3XeBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8ADD13876;
	Thu,  9 Jan 2025 07:17:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SKjlMRp4f2eiVQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 09 Jan 2025 07:17:46 +0000
Message-ID: <0d1ec6ec-1938-419d-90ff-d4faf2ebaea6@suse.de>
Date: Thu, 9 Jan 2025 08:17:46 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear UNIT
 ATTENTION"
To: Niklas Cassel <cassel@kernel.org>, Philip Pemberton <lists@philpem.me.uk>
Cc: linux-ide@vger.kernel.org
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36GMwr49ihd2nAG@ryzen>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z36GMwr49ihd2nAG@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1418C1F385
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 1/8/25 15:05, Niklas Cassel wrote:
> On Wed, Jan 08, 2025 at 12:52:50PM +0000, Philip Pemberton wrote:
>> I'm trying to connect an old Iomega Zip 100 ATAPI to a B550-chipset Ryzen
>> system, to exchange files with an even older system. The Gigabyte B550 AORUS
>> ELITE AX V2 rev1.3 motherboard doesn't have any PATA ports, so I'm using a
>> SATA to PATA adapter.
>>
>> Sadly it will not work in the B550 system (Kernel 6.8.0-51-generic x86_64,
>> Linux Mint 21.3 based on Ubuntu 22.04). When I have the Zip drive connected,
>> I get the following in dmesg and the sd device never appears:
>>
>> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata3.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max PIO3, CDB intr,
>> DMADIR
>> ata3.00: applying bridge limits
>> ata3.00: configured for PIO0
>> ata3.00: qc timeout after 5000 msecs (cmd 0xa0)
>> ata3.00: failed to clear UNIT ATTENTION (err_mask=0x5)
> 
> Since we see that the drive name is printed, the ATAPI IDENTIFY command
> succeded (ATA_CMD_ID_ATAPI (0xA1)).
> 
> The command that timed out is ATA_CMD_PACKET 0xA0, so a regular ATAPI command.
> 
> The UNIT ATTENTION print is just from atapi_eh_clear_ua(), which seems to be
> called by ata_eh_recover() unconditionally for ATAPI devices, because they
> always need to clear UNIT ATTENTION after a reset:
> https://github.com/torvalds/linux/blob/v6.8/drivers/ata/libata-eh.c#L3232-L3234
> 
> But the reset is of course only triggered because a command has timed out.
> 
Which makes me wonder: does the SATA-to-PATA support ATAPI? It has been 
removed from recent ATA specifications, so there's a chance the bridge 
simply doesn't implement it ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
