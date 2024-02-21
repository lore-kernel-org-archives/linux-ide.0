Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2942A8B
	for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2024 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539369; cv=none; b=Sqsh4IDn7AM7WUBV4V6rFfWhod2Gfunh0CJdjcR+SSCD8nRENEoZn1EW71U8ggK93zCzvCBCs4OEPibPkT2MZSVxTswSvyHwf6dAqD1K5UZSfvA6gCZlv+ykrrYg4l3UW/VhU+u1HV34DXaqPaful934F07dIfKu0SFlwDAKESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539369; c=relaxed/simple;
	bh=xQo/aOepzEmn/JKr15xX/kvoUcIhTO/g7ldYGUxWwJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/4aV/E31mhYDMYz4NR1KQCBTeqtbu6G0A1lzmijijU7+9a36rsJaWSskd2t1vPulM1fNilRLOA7jgfe54GF82y32u/uW9fh9FtNNWApMMbJ5f60E95orCgZaEPpY2c36UYj4IWzXOK7HsCapTqJdNBAOwqTZUSlwF0L+oW96/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk9wGWyJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk9wGWyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA8DC433C7;
	Wed, 21 Feb 2024 18:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708539369;
	bh=xQo/aOepzEmn/JKr15xX/kvoUcIhTO/g7ldYGUxWwJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fk9wGWyJ2zUGybPhLPOjtBZkSBtsK3G4hp8Ben7f7zsBEPjDjgAydUdQSqIWr64xf
	 6DFytF8UiQado/umemOk+R0C8x/ugoCO2UEKUiTtkqeEewj1s7XcPC4ot9rq7HWgwT
	 QSYepQhLBPTxJyC5i8eAgKY6d/UPzzckPKKJ0RxPbb5ROfGnr7IMhDXBvWZP2Zoq20
	 XBY4u1JYnnt0ngKH6FoYVWsn+sttyJwa337gJyHboONYykJY4OECFm11vQrJ7oWpzi
	 lwH0vm9ygV9Iom3PzOSeRVOMDYRFDnguNOqMfMANLWIl9vjY7nOBJU/P5hDLElp2li
	 188i4i1YimTug==
Date: Wed, 21 Feb 2024 19:16:04 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	Andrey Melnikov <temnota.am@gmail.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v3] ahci: print the number of implemented ports
Message-ID: <ZdY95AS6jtFf2zjq@fedora>
References: <20240219204744.1365567-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219204744.1365567-1-cassel@kernel.org>

On Mon, Feb 19, 2024 at 09:47:43PM +0100, Niklas Cassel wrote:
> We are currently printing the CAP.NP field.
> CAP.NP is a 0's based value indicating the maximum number of ports
> supported by the HBA silicon. Note that the number of ports indicated
> in this field may be more than the number of ports indicated in the
> PI (ports implemented) register. (See AHCI 1.3.1, section 3.1.1 -
> Offset 00h: CAP – HBA Capabilities.)
> 
> PI (ports implemented) register is a field that has a bit set to '1'
> if that specific port is implemented. This register is allowed to have
> zeroes mixed with ones, i.e. a port in the middle is allowed to be
> unimplemented. (See AHCI 1.3.1, section 3.1.4 - Offset 0Ch: PI – Ports
> Implemented.)
> 
> Since the number of ports implemented might be smaller than the maximum
> number of ports supported by the HBA silicon, print the number of
> implemented ports as well.
> 
> While at it, clarify the properties being printed, and add a separator
> (,), as that is currently missing, making it very easy to get confused
> if the number before or after <property> belongs to <property>.
> 
> before:
> ahci 0000:00:03.0: masking port_map 0x3f -> 0x2f
> ahci 0000:00:03.0: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x2f impl SATA mode
> ahci 0000:00:03.0: flags: 64bit ncq only
> 
> after:
> ahci 0000:00:03.0: masking port_map 0x3f -> 0x2f
> ahci 0000:00:03.0: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
> ahci 0000:00:03.0: 5/6 ports implemented (port mask 0x2f)
> ahci 0000:00:03.0: flags: 64bit ncq only
> 
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.9
