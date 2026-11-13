Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586120;
	b=WOd0JwzerhW8d6D95rzxPfDju7hUQ5n95cQvNcdZxowwrqiCDJZmZqDnVcta82RYc4al
	 Ug6Mw0vDgBY5EllEBsAC8IXaTMTScV4QhpzoFYqZIep88f4LpPzHLZGVLgZSi5tPtfsQ4
	 Bb81ddkIrm2/mB2Fb0107sj5utoal38t7OA9epM8A6T5xGJIrX6xVWfq/j+zDN26g4NFw
	 T+FVuH948nsgEInEBMLUmE7xstcTq7AbE67uckbj6Zxn88/qDTRSh3Ked7tz7tekXaRu3
	 GIgWqur/fP4NQc4yW8RPVLn8TKp98rdpIIPXIfQsyMLJ2hTVXacrpksnuH6nwVAT8Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586120;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HbVfBGF5i6NrBYQHNTc1RyxivmXC34Bel18CQsY9ZRc=;
	b=VeLA0DONzI/k2/CmQU+MnWKxy0M+XbpIh8xP5zdcXAEL+OEoLm1SVBWPY85C2AwpeCfg
	 YTyObJksCsUgJcOWnUvKEs3R5RXtSQCXMI8pOQYd8NeHpczSv+teBClPiIqEZyiV6R9oD
	 6nO/OInVBcBmwgM606XcI93AvjvIK42sOEObHXJM7WM+n0skvoDD2pplVd6OCXO7xtiog
	 f8XbTUJvwGhl7j4pDDkTy6ppiKC5CI9QkNo9D3N3IolGekUC1kkHWD4+cqc1I6ZCWLI62
	 d9eKUNcxNKhbADrprLXd/sgzwHs8jgxvttz3YOQlkoM9CNV9ICBi5OII5wYPT/0a/Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrEQGM0c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E6606AE05
	for <linux-ide@vger.kernel.org>; Fri, 13 Nov 2026 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrEQGM0c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97231F000C4;
	Fri, 13 Nov 2026 16:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794586120;
	bh=HbVfBGF5i6NrBYQHNTc1RyxivmXC34Bel18CQsY9ZRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MrEQGM0cStIPfedHVA/3CVoP4tTqo4alrhfPBxjcR4//m+ntumu0e8nwrWsZjQ+m8
	 4/i4UB1+ICeSvvdPBIdGYkDb1g+FS7mnHRUAL0Nrcz2Es6sxpEoA0MIRY3uGjvNT+Y
	 CXs8OQ5bgLRSIWBNFVKBRVJysA7l4BY9iRypscZzBwSzkFctPI83mww4u0scLJUwx2
	 O4IX6ZQnxYHAnh7NHlGnZ/ac6/3eu8cQ4J9WoP02Rr9tS+brjalXDKO4B8hHOLxMsc
	 ynCnEtBfsFFaw3XutjA4MeDEDF0rxeljzM7sGMMvSJQG0QPFx7NkMqgJ33DvY8xz6k
	 Y4vPJhoH05kJg==
Date: Fri, 13 Nov 2026 17:08:37 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libahci: Stop the SW activity blink timers on port
 suspend
Message-ID: <avc2BVUyA7rKqA7-@ryzen>
References: <20261110135615.291884-2-cassel@kernel.org>
 <0ce11245-3da6-423c-9f54-175eed413182@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce11245-3da6-423c-9f54-175eed413182@kernel.org>

On Thu, Nov 12, 2026 at 08:35:56AM +0900, Damien Le Moal wrote:
> On 11/10/26 22:56, Niklas Cassel wrote:
> > +	/*
> > +	 * Stop the SW activity blink timers, so that they cannot fire while
> > +	 * the port is suspended. ahci_init_sw_activity() sets them up again
> > +	 * on resume.
> > +	 */
> > +	for (i = 0; i < EM_MAX_SLOTS; i++) {
> > +		struct ahci_em_priv *emp = &pp->em_priv[i];
> > +
> > +		if (emp->timer.function)
> > +			timer_delete_sync(&emp->timer);
> 
> Looks OK. Did you check that the timer handler does not restart/requeue the
> timer? timer_delete_sync() states that it should not.

The handler does re-arm itself, but timer_delete_sync() handles that.
It waits for a running handler, then dequeues the re-armed timer.

The rule is about re-arming from other code, and the only other path,
ahci_qc_issue(), is not called once EH has frozen the port and called
->port_suspend().

So we should be good.


Kind regards,
Niklas
