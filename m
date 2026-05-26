Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542201B4224
	for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808566; cv=none; b=JahNbtqOoXIeiiCHxzrx0y/VkhHdd/Tfr/S5LASRT4U3INq1qPmKoDgrSp6TAdqFqqGSvY/wsJ5Rvrg2BHFNXBnZb/t976dxhboWakdgpybPpmfWbQPX0trFvExpU1sqsd/BIOjlCIj+n+f/8VpCJe7ZsiJYln0g8bkwd9vcTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808566; c=relaxed/simple;
	bh=2myz3cy/Qh1SydbvP1j4AuX5pOKOEqDmf7ns7fDHSGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1SQWV5XKwO3bPXvZ/dO5CIXez3F7x2aIfGPzBdQFOFDoG122xJzEfcIW1XksADKzhjTN2CoAVLufgATx+Sbgr+8n12Eds0YqoYkrBrQAG16lLZyyXfQw/qLwqmvbNXJUwlxD5DB2VtigZz/x4+6mxD4S7I8GRlm1fG1u5zXFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jA6ZM3v6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jA6ZM3v6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447001F00A3A;
	Tue, 26 May 2026 15:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808565;
	bh=0w0imiKoZGZGlW1f1Amzr7Psr7YzcOXnTm6SlSBiRfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jA6ZM3v6JbaQ2DTciuEpPTY3ihBKVAYfQnGWF41Rr+1jNcb58kaqBA2mwiK6GTAhy
	 inAsThvDyUwvBdbKa5dBt4SRcZ/P8pIBol7LHsHcDsIkKCUeSsZnam7dtfhKGiAmwY
	 Uk0FuGRxjWRpvG9JGsXbOaJYFNTcT8BfSvxdBSPjKhJ6QzkKgLKZr8SCxH7GU9P8db
	 NUnglPzAnqZkvEWVpyWCzM+mlTdUXo7lObDghegVesqH6r2WQ14yFfm186ZrL9aKhJ
	 biri2DSVAVtNDMcnIC/R8uhJjbN97XGflIMrNwsD/02MhaMFzAqgsNv03cbx4VJ4qJ
	 hCFwWvAYhgODw==
Date: Tue, 26 May 2026 17:16:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Mikael Pettersson <mikpelinux@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v2 9/9] ata: Annotate the code that uses the host lock
Message-ID: <ahW5MI_05l2bpKBN@ryzen>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-10-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521173347.2079560-10-bvanassche@acm.org>

Hello Bart,

On Thu, May 21, 2026 at 10:33:37AM -0700, Bart Van Assche wrote:
> @@ -5162,6 +5165,10 @@ void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
>  	struct ata_link *link = qc->dev->link;
>  	u8 prot = qc->tf.protocol;
>  
> +	/* Tell the compiler that qc->ap == qc->dev->link->ap->lock == ap. */
> +	__assume_ctx_lock(qc->ap->lock);
> +	__assume_ctx_lock(qc->dev->link->ap->lock);

When I look at the definition of lockdep_assert_held(), when building with
lockdep:
https://github.com/torvalds/linux/blob/v7.1-rc5/include/linux/lockdep.h#L284-L285

When building without lockdep:
https://github.com/torvalds/linux/blob/v7.1-rc5/include/linux/lockdep.h#L392

Even in the case where we don't build with lockdep, we will call
__assume_ctx_lock(l);

So my question is, why don't we instead add:
lockdep_assert_held(qc->ap->lock);
lockdep_assert_held(qc->dev->link->ap->lock);

Right now, there seems to be very few __assume_ctx_lock() in the code base,
would it not be more consistent to add lockdep_assert_held() calls instead?


> @@ -1149,6 +1154,9 @@ static void __ata_port_freeze(struct ata_port *ap)
>   */
>  int ata_port_freeze(struct ata_port *ap)
>  {
> +	/* TO DO: fix all callers of this function that do not hold ap->lock. */

Please write this as one word, i.e. TODO:



Kind regards,
Niklas
