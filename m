Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214C375F96
	for <linux-ide@vger.kernel.org>; Wed,  4 Mar 2026 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623386; cv=none; b=b7lgMJLJG8BdKeT5jKPTXVOrFEPz1vuk2kvJsc8D3nQpHUtg+CO8Om6Rsav8HYNLhX9nUcZZ93dP1C8AGq43F316kN1uEtJjBUJVU0qeHK18Gd1lbbFSkBdsMK3Q01sAXho9VPfuDOAQfVU/SkpO48Tm+5yTYti8ZZ/69pSeadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623386; c=relaxed/simple;
	bh=klNZp1yFeLvKDQV+i1oeRcsHOmwfx2pnaLKX4uWTWYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqCk9Dmvwvfp6E+dktCAojIUcdy1VzGfll2P2WIHrklIsVWF+aJageV4ajM96RMZxmKgZ2xubo94DT8DFm4U/8tYICj4rUC9WKgaJ1R2lqTzIqNWXkS/MxRjN952GQxWM1XzyVYrkL3g8TLa454QEuBB2+WpZAaxtjFs9NAX53w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CeoQ+6ED; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PmDXB3/v; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CeoQ+6ED; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PmDXB3/v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CeoQ+6ED";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PmDXB3/v";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CeoQ+6ED";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PmDXB3/v"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6ED4D3F84F;
	Wed,  4 Mar 2026 11:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772623383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fd1P99/ha8u8Vi9h9y+nN54TsZhSsRCOkF5GTtubNNE=;
	b=CeoQ+6EDsy6yj4DviZTvh5LhWQCHKKYJ8raQMAlyXnyvpkUOiG8Wu4Jg4bRt8AahWJwroL
	H0GXMr1gamGQaTMIhOpLwqZAmogcvsenRT51iYFFM2bx48kmjf6o6J2konbYEg4ewAJT1M
	VKS5h5fAJ+GE5j6JIr5zQ0kuy/TVAXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772623383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fd1P99/ha8u8Vi9h9y+nN54TsZhSsRCOkF5GTtubNNE=;
	b=PmDXB3/v22njJDV2RwK1Qa+SyZHccY7+PekV0nqc3wAG1sNS79LDddMK8CxixxlCUl3bxI
	Sohx7PumdHRxySDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772623383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fd1P99/ha8u8Vi9h9y+nN54TsZhSsRCOkF5GTtubNNE=;
	b=CeoQ+6EDsy6yj4DviZTvh5LhWQCHKKYJ8raQMAlyXnyvpkUOiG8Wu4Jg4bRt8AahWJwroL
	H0GXMr1gamGQaTMIhOpLwqZAmogcvsenRT51iYFFM2bx48kmjf6o6J2konbYEg4ewAJT1M
	VKS5h5fAJ+GE5j6JIr5zQ0kuy/TVAXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772623383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fd1P99/ha8u8Vi9h9y+nN54TsZhSsRCOkF5GTtubNNE=;
	b=PmDXB3/v22njJDV2RwK1Qa+SyZHccY7+PekV0nqc3wAG1sNS79LDddMK8CxixxlCUl3bxI
	Sohx7PumdHRxySDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C15F3EA69;
	Wed,  4 Mar 2026 11:23:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lw0nOxYWqGl0RwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 04 Mar 2026 11:23:02 +0000
Date: Wed, 4 Mar 2026 11:23:01 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add BRIDGE_OK quirk for QEMU drives
Message-ID: <azwfeaf5hdn5g2vutuhzkjl42ld52vyjs4go2coer3yuagiep2@r5hejnknuwj2>
References: <20260303183337.1013474-1-pfalcato@suse.de>
 <aaf5f1_131S1aVnm@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf5f1_131S1aVnm@ryzen>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed, Mar 04, 2026 at 10:21:03AM +0100, Niklas Cassel wrote:
> Hello Pedro,
> 
> On Tue, Mar 03, 2026 at 06:33:37PM +0000, Pedro Falcato wrote:
> > Currently, whenever you boot with a QEMU drive over an AHCI interface,
> > you get:
> > [    1.632121] ata1.00: applying bridge limits
> > 
> > This happens due to the kernel not believing the given drive is SATA,
> > since word 93 of IDENTIFY (ATA_ID_HW_CONFIG) is non-zero. The result is
> > a pretty severe limit in max_hw_sectors_kb, which limits our IO sizes.
> > 
> > QEMU shares IDENTIFY data between PATA/SATA drives (and the corresponding
> > emulation of IDE/AHCI) but does not, in any way, emulate any of these
> > real hardware details. There is no PATA drive and no SATA cable.
> > 
> > As such, add a BRIDGE_OK quirk for QEMU HARDDISK. This results in the
> > max_hw_sectors being limited solely by the controller interface's limits.
> > Which, for AHCI controllers, takes it from 128KB to 32767KB.
> > 
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > ---
> > Note: This may be ok for stable, but I'll leave it up to you. There is
> > obviously no Fixes: here that doesn't go back 20 years.
> >  drivers/ata/libata-core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index d61846f03edc..70703432063a 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -4231,6 +4231,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
> >  	/* Devices that do not need bridging limits applied */
> >  	{ "MTRON MSP-SATA*",		NULL,	ATA_QUIRK_BRIDGE_OK },
> >  	{ "BUFFALO HD-QSU2/R5",		NULL,	ATA_QUIRK_BRIDGE_OK },
> > +	{ "QEMU HARDDISK",		NULL,	ATA_QUIRK_BRIDGE_OK },
> >  
> >  	/* Devices which aren't very happy with higher link speeds */
> >  	{ "WD My Book",			NULL,	ATA_QUIRK_1_5_GBPS },
> > -- 
> > 2.53.0
> > 
> 
> I think you should just fix QEMU.
> 
> Quirks are added for devices where we will never get a firmware update.
> 
> QEMU if FLOSS. QEMU has stable releases just like the kernel.
> 
> Why should the kernel carry this extra code just because of an issue in
> another FLOSS project?
> 
> 
> The fix in QEMU should be trivial.
> The argument in the commit log does not make sense, as QEMU already
> protects certain SATA only features with if (s->ncq_queues):
> https://github.com/qemu/qemu/blob/v10.2.1/hw/ide/core.c#L181
> 
> PATA does not support NCQ, so you could use that guard also to set the bit
> in word 93.
> 
> 
> That said, I understand that certain distros will might not ship with the
> latest QEMU stable release, so we could carry a quirk even for QEMU just to
> be nice to the distros, but not an unconditional quirk (FW version == NULL).

Yeah, that's why I went for the quirk, it seeemed more far reaching than just
patching QEMU.

So, does this look better?

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d61846f03edc..c57e35ccc092 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4231,6 +4231,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
        /* Devices that do not need bridging limits applied */
        { "MTRON MSP-SATA*",            NULL,   ATA_QUIRK_BRIDGE_OK },
        { "BUFFALO HD-QSU2/R5",         NULL,   ATA_QUIRK_BRIDGE_OK },
+       { "QEMU HARDDISK",              "2.5+", ATA_QUIRK_BRIDGE_OK },
 
        /* Devices which aren't very happy with higher link speeds */
        { "WD My Book",                 NULL,   ATA_QUIRK_1_5_GBPS },

and I then patch QEMU to provide a correct word 93. Sounds good?
(note: the quirk above does not cover QEMU older than 2.5 I believe, but we
probably don't care about that, it's already 10+ years old...)

> 
> In my QEMU I have:
> $ lsblk -o MODEL,REV
> MODEL          REV
> QEMU HARDDISK 2.5+
> 
> Which comes from:
> include/qemu/hw-version.h: * Starting on QEMU 2.5, qemu_hw_version() returns "2.5+" by default
> 
> The comment in include/qemu/hw-version.h says that the version should not be
> increased, but QEMU already overloads this value if dev->version is set:
> https://github.com/qemu/qemu/blob/v10.2.1/hw/ide/core.c#L2660-L2664
> 
> So I suggest that you also send a patch to sets a default value to
> dev->version:
> https://github.com/qemu/qemu/blob/v10.2.1/hw/ide/ide-dev.c#L125-L127
> to some default value larger than 2.5+, unless an explicit value was
> provided by the user.

Yep, this is reasonable, thanks for the suggestion.

-- 
Pedro
