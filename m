Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1C634E777
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975299; cv=none; b=o/869OCk5GDN48CipUWvITDgRoCpB93z7EJci3yIiVNaz1b2R6U5bo1VesB+m/9NGnSZoAnfv+pSjI4n91nBz9oWCH3xp4pt/WEzXbjLvyc3/M7lW5+LwG5xJYzldykGzQOxPdTBTmFCTdaNdaaZIFwdLoAfJWTyzUSQ+L4hz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975299; c=relaxed/simple;
	bh=QoplbqtGfzbX2B9n6A50NY3VluflBcJYKCWl9HxGOz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gAxO+8UFY1M7e/Y3K6C7YYNo5FBdLNss7uhChZXAgv0Vda30RMCJlAYpRN+6T7AHJQ8QPActwFiGEVyoXu1j1Uuaj79n5wE94JLl3u+HIfCSwnjh+3tcoCVoe795a05MQXj8TLaaKmr5kZ8Kk3Pszxs0duzZt+EDLLjYdTYNyQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HmR5cprt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JUim0JLO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hNh/pYFS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cFSQx5Gh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HmR5cprt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JUim0JLO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hNh/pYFS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cFSQx5Gh"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB6D275BB1;
	Thu,  2 Jul 2026 06:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782975291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ln8uaRlhW8zgndLuwatW2BWIviJ2Ua63qIXg0KBccXI=;
	b=HmR5cprtr6ZtYbXEzL/sEUKPNdCvaBcdqXl8rCpsX2qoSxbfE6qfVrdoyqj33n86Q+GHsF
	zLDMXVfKCp+L2k3nVkEmhFZld499r+SPiCXG23wznsdRtBdKL/jeWdJfTqJJAdVsQhf+45
	kMWJheb2dulsQ9JBsgX+esH4h3zEu30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782975291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ln8uaRlhW8zgndLuwatW2BWIviJ2Ua63qIXg0KBccXI=;
	b=JUim0JLOChhVnoLEPi3zc7iTrNCchofcnMVTHDvRaADo5qEX/JpU/MSNmEia/oJxZcPPTb
	WoRrGloJF1lhJyDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="hNh/pYFS";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cFSQx5Gh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782975289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ln8uaRlhW8zgndLuwatW2BWIviJ2Ua63qIXg0KBccXI=;
	b=hNh/pYFSfLoeeNcBlOG3yOXlqCbk80fjXQaTI0PX0F0RE3BEP9zl3cuZB2VmLNw7tFueEM
	KPkrGIsyaHQAX6JH3yVSw83Nj4jnm7IE1/VekzQwVOQ54Gd24XyW5bWBPqdgvS/YArOOX3
	io8QVaHK/ZKxUjT4T41xkyPsqU4ZYyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782975289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ln8uaRlhW8zgndLuwatW2BWIviJ2Ua63qIXg0KBccXI=;
	b=cFSQx5GhvWNSB0ket3VZfySuv9dHhvu/4A3ecVXBgmG/j5Etrt71AMHG859yn8GQmLCdWF
	DA6b5fRetuCvl1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89968779AA;
	Thu,  2 Jul 2026 06:54:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sFUNIDkLRmodXwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 02 Jul 2026 06:54:49 +0000
Message-ID: <4ce39b7c-8d8d-4334-ab3f-5c59a9f80270@suse.de>
Date: Thu, 2 Jul 2026 08:54:49 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] ata: libata-scsi: support the all command format
 for reporting supported commands
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-6-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260702063412.1892584-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AB6D275BB1
X-Spam-Score: -4.51

On 7/2/26 8:34 AM, Damien Le Moal wrote:
> Add support to ata_scsi_report_supported_opcodes() for the all command
> format indicated with a reporting option of 0. The function
> ata_scsi_report_all_supported_opcodes() is introduced to implement this
> support. This function operates by testing all commands of the
> ata_supported_cmds array and testing them using
> ata_scsi_cmd_is_supported(), filling rbuf as it loops through all the
> commands that libata can emulate or translate.
> 
> With this change, sg_opcodes /dev/sdX is able to list all commands
> supported by libata and a device. An example below is shown for a SATA
> disk also supporting CDL:
> 
>    # sg_opcodes /dev/sda
>      ATA       WDC  WUH722626AL  WZ41
>      Peripheral device type: disk
> 
>    Opcode  Service    CDB  RWCDLP,  Name
>    (hex)   action(h)  size   CDLP
>    -----------------------------------------------
>     00                  6    0,0    Test Unit Ready
>     01                  6    0,0    Rezero Unit
>     03                  6    0,0    Request Sense
>     08                  6    0,0    Read(6)
>     0a                  6    0,0    Write(6)
>     0b                  6    0,0    Seek(6)
>     12                  6    0,0    Inquiry
>     15                  6    0,0    Mode select(6)
>     1a                  6    0,0    Mode sense(6)
>     1b                  6    0,0    Start stop unit
>     1d                  6    0,0    Send diagnostic
>     25                 10    0,0    Read capacity(10)
>     28                 10    0,0    Read(10)
>     2a                 10    0,0    Write(10)
>     2b                 10    0,0    Seek(10)
>     2f                 10    0,0    Verify(10)
>     35                 10    0,0    Synchronize cache(10)
>     55                 10    0,0    Mode select(10)
>     5a                 10    0,0    Mode sense(10)
>     7f     1ff0        32    0,0    ATA pass-through(32)
>     85                 16    0,0    ATA pass-through(16)
>     88                 16    1,1    Read(16)
>     8a                 16    1,2    Write(16)
>     8f                 16    0,0    Verify(16)
>     91                 16    0,0    Synchronize cache(16)
>     93                 16    0,0    Write same(16)
>     9e       10        16    0,0    Read capacity(16)
>     a0                 12    0,0    Report luns
>     a1                 12    0,0    ATA pass-through(12)
>     a3        c        12    0,0    Report supported operation codes
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
