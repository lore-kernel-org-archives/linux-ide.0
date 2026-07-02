Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D1D451044;
	Thu,  2 Jul 2026 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992479; cv=none; b=IMldEVHHRXhL/h6CSL3DBhbtGE1zXcLANu6UNfV79Q0nYurqCjfwfaJdkm7+KekZB1/fzF/pPvBYFqkkyuWrlUgB7BQqXAhGWwZVzTKV/1gFyD7lBUZr+32JuQULNPDxhF0UGpJWVlmGusuWTeBYjkqWT1QdRxWtVJb0agIaNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992479; c=relaxed/simple;
	bh=NaljxfbwKveQgZl04GNEtaf7mZ8dXc5VmLIJwAzSZXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/G4kLGgcv7gwbf19Z1OkV8WnAHjoOKvWq0wd4BPAsIHPjHkSOv+dxPK3G1fbkt5GU2a0iW3XclVAeB58Riq2xsPX8FNjNe+hpjZln5lQI/eFjXVZUXTiMcAvB5CNzu/bnMkYXL1veTgxLp8bdIVIJ+3w5cHqDjN8Fktz2bIMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeG2w74j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeG2w74j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA45A1F000E9;
	Thu,  2 Jul 2026 11:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782992477;
	bh=gk08zULYzIqIZrpS2MTJq9V+P2zVX7Y2PpKzYZOpiYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UeG2w74jqmAV+xqkVNGx2PrK2mBtkHn972ObiZa0H7qQWEA+PCMfN5eSP0//FB2yA
	 psNsRSFotJJ/me5/5whwPZiADlLVe2AJCxnMjIAV0+lB93jZyCPWMUsu+rmW3c6sS2
	 K0gcjvTgn19UkLu8hDjubHvYhSFv/WnyuJEeq0/bIfaVTCrOF8+y+H6ra9ua5QeBBk
	 3sbo6sPG7Um3ULyH/RCNbrrMnCE+Uk2TOEzTRAgfiQO5y9K0nGSRfwoAyXOuMvph59
	 WWu0Vvc9dygdeqGHZ+APdh3gHtYmVgTvVmp/qd+qJ8P/w9lwwB08Qx04SK1q3qwRwC
	 LRSALo/0Ld+dw==
Date: Thu, 2 Jul 2026 13:41:14 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 4/5] ata: libata-scsi: support reporting options 2 in
 REPORT SUPPORTED OPERATION CODES
Message-ID: <akZOWmrdZF8LrfEA@ryzen>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-5-dlemoal@kernel.org>
 <20260702065227.EA8671F000E9@smtp.kernel.org>
 <3acde700-be7c-4ca0-b646-1dc5f6976cad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3acde700-be7c-4ca0-b646-1dc5f6976cad@kernel.org>

On Thu, Jul 02, 2026 at 04:00:18PM +0900, Damien Le Moal wrote:
> > According to SPC-5, option 2 queries for unsupported commands (and similarly,
> > option 1 queries for commands with service actions) must return SUPPORT=001b.
> > Instead, this implementation erroneously aborts the command by calling
> > ata_scsi_set_invalid_field(), preventing the code from falling through and
> > correctly populating the response buffer.
> 
> Sashiko, please reread the SPC specifications. It says:
> 
> If the REQUESTED OPERATION CODE field specifies an operation code for
> which the device server does not implement service actions a, then the
> device server shall terminate the command with CHECK CONDITION
> status, with the sense key set to ILLEGAL REQUEST, and the additional
> sense code set to INVALID FIELD IN CDB.
> 
> Which is exactly what we are testing here.

This is a bit funny :D

It would be nice if Sashiko actually listened (like a real AI agent),
re-read the spec, and updated posted an updated review comment :)

Perhaps try to include the SPC spec excerpt in the commit message for V3,
and see if that helps Sashiko parse the spec correctly ? :)


Kind regards,
Niklas
