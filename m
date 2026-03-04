Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A643E3CCA05
	for <linux-ide@vger.kernel.org>; Wed,  4 Mar 2026 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652874; cv=none; b=me7nzTGKbqpjpjA8iNRNDdvovqP7IjFisMhcW17wyqJY5wc/gcAMEqMIEj5fJUufU95+t6IvrLer8lIFxyY+WMLK7VA2N/kAVxLAEb/WqO2+3rd6aGLTZue/PhUKA0f9toW0mG4M0IipGHzWom2iEox8/fDjWA3iYd/e6DBxNGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652874; c=relaxed/simple;
	bh=1n2ZLVNlSZ9oWqqr/u3nCOSnwOJ52ZaOMIUONysvq/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bsfh7D9Cbhi/uftu7ixlm8myZNtFR9L3AVY2HfBWD/dFFIXBdspMLLp/OOlbDt17glUc766UGlyWVVFPQ0x5PqR/YRVsejPZIN+uSFxcNmosXC4Gjihtpv4HhqNWsAqgh/chHXjDElOeYzKUV88uSA49E6YJ5lvJaaksmKaX3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DDamY4Mu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8GZ0uLsY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DDamY4Mu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8GZ0uLsY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DDamY4Mu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8GZ0uLsY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DDamY4Mu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8GZ0uLsY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E09485BE38;
	Wed,  4 Mar 2026 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772652871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7P/G3ZBIljBGr6ffX88fTYoGxNHQOgiI1zH9dBAzoG4=;
	b=DDamY4Mue2xM5PzPQW9hRUS6KumWWddzP1rKcEavwCK/q6jpxt05VZEe5B1ePwVqpOAqNw
	Y2+4WMt89MhJvxz6K0+EDRnr3WJ5rqe2jgpcd/m2W2evEtQeMRyVCw0edHJx/ajSpySqNR
	lEdmHHzuOX3pUTcNJjl05T89aKrxMgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772652871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7P/G3ZBIljBGr6ffX88fTYoGxNHQOgiI1zH9dBAzoG4=;
	b=8GZ0uLsYgZjx7vCocKk6/qyIZsF7Cj2HoKvwyX+2ct8G2/iO5l8GVbFTjMo+Iigp/2E2N+
	JSJleKPehnzwjvBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DDamY4Mu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8GZ0uLsY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772652871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7P/G3ZBIljBGr6ffX88fTYoGxNHQOgiI1zH9dBAzoG4=;
	b=DDamY4Mue2xM5PzPQW9hRUS6KumWWddzP1rKcEavwCK/q6jpxt05VZEe5B1ePwVqpOAqNw
	Y2+4WMt89MhJvxz6K0+EDRnr3WJ5rqe2jgpcd/m2W2evEtQeMRyVCw0edHJx/ajSpySqNR
	lEdmHHzuOX3pUTcNJjl05T89aKrxMgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772652871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7P/G3ZBIljBGr6ffX88fTYoGxNHQOgiI1zH9dBAzoG4=;
	b=8GZ0uLsYgZjx7vCocKk6/qyIZsF7Cj2HoKvwyX+2ct8G2/iO5l8GVbFTjMo+Iigp/2E2N+
	JSJleKPehnzwjvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88CA53EA69;
	Wed,  4 Mar 2026 19:34:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z4oDHkeJqGkUVwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 04 Mar 2026 19:34:31 +0000
Date: Wed, 4 Mar 2026 19:34:29 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add BRIDGE_OK quirk for QEMU drives
Message-ID: <bkkhps3grvckjjvw6ncgygb3qxqrftlwnmixmv3ibe726kc35o@uih2pher4s6e>
References: <20260303183337.1013474-1-pfalcato@suse.de>
 <aaf5f1_131S1aVnm@ryzen>
 <azwfeaf5hdn5g2vutuhzkjl42ld52vyjs4go2coer3yuagiep2@r5hejnknuwj2>
 <aaggw9ezzeY2_aEO@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaggw9ezzeY2_aEO@ryzen>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E09485BE38

On Wed, Mar 04, 2026 at 01:08:35PM +0100, Niklas Cassel wrote:
> Hello Pedro,
> 
> On Wed, Mar 04, 2026 at 11:23:01AM +0000, Pedro Falcato wrote:
> 
> (snip)
> 
> > So, does this look better?
> > 
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index d61846f03edc..c57e35ccc092 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -4231,6 +4231,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
> >         /* Devices that do not need bridging limits applied */
> >         { "MTRON MSP-SATA*",            NULL,   ATA_QUIRK_BRIDGE_OK },
> >         { "BUFFALO HD-QSU2/R5",         NULL,   ATA_QUIRK_BRIDGE_OK },
> > +       { "QEMU HARDDISK",              "2.5+", ATA_QUIRK_BRIDGE_OK },
> 
> Yes, I would prefer that.
> 
> When booting a device that has quirks applied, we will get prints in dmesg
> showing which quirks were applied.

Yeah, makes sense. Can you use this diff and add Cc: stable when applying,
or do you want me to send a v2?

> 
> It would be nice if we could avoid applying quirks for QEMU when (sometime
> in the future) a newer version of QEMU is available that does the right
> thing.

On it :)

Thanks!
-- 
Pedro
