Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEDA19B59C
	for <linux-ide@vger.kernel.org>; Wed, 29 Jan 2025 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738144652; cv=none; b=AdJsf4l59iW3nVrrwIxQGW8M1hfmBeQyi4q3YYQ684xjiLTfs18FxDyd5MoTKHs7yUsNf/jAXObFJQ5+rzNeG+b4N8j7NmQWSgrAkaLDsWBDd+HRikjklyOjEXq04BINQpLR0tsmuk8ApWbp9r5vlmO8hvQfI86Uko1YmzF4ldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738144652; c=relaxed/simple;
	bh=4abC71XSuDoif4FkCCMB2M6wZuevlhNOKqARU7Jo+ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqJ/noaDLCcqB7vLiF/PMmc9i/B7NSHQzsyfxZM7UUZOCVGsjCbX3fuaU5I8N76lcZDX3rvA/SIdvSi4lRNQvHNsrqOaVMSZIBBtqeLwW6mPk4QgnbnSm2id4UR28++iNQqyFZTbiySoVGUy/KtsXHGKKuVqQy45LuN/YNoJfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJ61vyDs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJ61vyDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5F7C4CED3;
	Wed, 29 Jan 2025 09:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738144651;
	bh=4abC71XSuDoif4FkCCMB2M6wZuevlhNOKqARU7Jo+ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJ61vyDsFTdLUb1Ne5yO5rHQUMNM6UdCmBXfzgRKWtIEe6m8q9loWc1hy4umGF2GJ
	 yFVDPEWzMg1XNR7+IlQC8LsBVQjabJ+0NS+Gj82TtCNMLXcqCKnYzj+QjxW0+cNFFa
	 TjD1vpiBQYeN1Tmg0E/58prNBsEONYDbDXOGKoxLcvjuOTwmYYxoNyVPiwqO5Ykpo4
	 d9Ix3INX3cgA64mDTx4fYy9yB2s3iwqDqFTm7//9OMyHfQklA+JR69ANC4M92nQ7gG
	 n52+xOWxtaojYBz517klSXSsaijdZWmZSCiq/swCqJtZESZYSTi+yWDp/is3yth6eX
	 nT2E64rvAAjww==
Date: Wed, 29 Jan 2025 10:57:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	reveliofuzzing <reveliofuzzing@gmail.com>
Subject: Re: out-of-bounds write in the function ata_pio_sector
Message-ID: <Z5n7hl0JX1kqsFa4@ryzen>
References: <CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com>
 <Z5EHwRtTL1Oy6T8_@ryzen>
 <yq1wmees4lw.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq1wmees4lw.fsf@ca-mkp.ca.oracle.com>

Hello Martin,

On Tue, Jan 28, 2025 at 10:09:35PM -0500, Martin K. Petersen wrote:
> 
> Niklas,
> 
> Sorry about the delay, was out for a few days.
> 
> > I was kind of expecting some upper layer, SCSI or block, to have rejected
> > an operation that is not a multiple of the sector size.
> >
> > Is that a silly assumption?
> 
> Not all SCSI commands operate on logical blocks. Plus even if they do
> the actual data transfer could still be larger than one block due to PI
> or long writes.
> 
> That's all a bit theoretical in the context of the archaic
> sg_scsi_ioctl() call since that only takes a single page and has little
> practical use. But in general we can't assume that everything is a
> multiple of 512 bytes.

Thank you.

I basically came to the same conclusion.
(We can't assume that everything is a multiple of 512 bytes.)


Looking at ACS-6, Table A.2 — Command codes (sorted by command code)
and looking at all commands that are of type:
PIO Data-In and PIO Data-Out.

Most commands use the COUNT field to mean a unit in either sectors or log
page count (which is also a multiple of sectors), but some commands, e.g.
TRUSTED RECEIVE 5Ch and TRUSTED SEND 5Eh, it means TRANSFER LENGTH, which
is security protocol specific.

Looking at TCG (SIIS), TRANSFER LENGTH is a multiple of sectors.
I don't know about other security protocols (if any).


It is probably quite safe to make the assumption that the COUNT field in
ACS will always be a multiple of sectors for PIO Data-In and PIO Data-Out
commands, so we probably could add a check in generic libata code
somewhere... but by adding such a check in generic libata code, for it to
be simple, it would probably need to apply to more than just PIO Data-In
and PIO Data-Out commands, and I'm not sure if we can make such an
assumption.

Thus, I'm happy with the fix:
https://lore.kernel.org/linux-ide/20250127154303.15567-2-cassel@kernel.org/
for now.


Kind regards,
Niklas
