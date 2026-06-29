Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1202933ADAC;
	Mon, 29 Jun 2026 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782721317; cv=none; b=F1kNHM1SrFnbStNYP1KMFuWLeOkGLkG3r5FQXODsGiVBaWoa23VrDgPrjo4aJCI41vvLe+M9eyAAGDewUJ3QixUXWJ2kF8Uod+8F8yvvPtG0Y+NltvnRreMLqRnPpna+l1oN7nsLRO8SkkUr28ZBBxcb1ZT/KDXdqdVCrlZbRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782721317; c=relaxed/simple;
	bh=vWA9SFkf8hoKr2LfhJIsONzMd5u/OMty3MaeQJvyMxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxDXIBOa5XAa3u33KOMk3LDbyZOknRn0/izQEFtWpsV/Qs9qRN12ijBPHdPyYB1iH2GeZePgzmMH3JVs+FiXxN6EMjDvN8WkpKZgUu6wswWV3Q7r/JI54boO2K0HHJMGzgBVhe1fq9R+MTNSYcpUT/IB9ZEBwvdrfEZT1aoFp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJp2+//o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJp2+//o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A041F00A3A;
	Mon, 29 Jun 2026 08:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782721314;
	bh=MKz3LhSP1uf6Ea23U4xuwCEWmaH5qO7dwoNDs/aS54M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FJp2+//o32scspMkMgw0WQNAbkJNybp/10Iy92iUcdIi+Xqf1OQ4V6LPq9+x7I2ed
	 V0zEruJgCooObMIo85KtjojsakkAWci80DFiJfuU5jRVpcw7M/YQV++Kwn8lhu0O1B
	 bJ6S/bZQ4vZGS5q4QVaVRC45n7SD/ksOjFFNEyaS/Wv1/8qV79r6Q7WV86OcIHzdBC
	 JHFPkxr+VFIsaPwTpRaOh6JRcTGEZDpkoIZ1LS8EZnmn1ZUSdw0k3g1P+HChLJjqw5
	 sAeI4wYVqkViKWFIdRD0QpfAV2sDbPuiyTjzVo74plYv52xA3IP4SlJeUbVasRoaqE
	 lpbikbg3Tr8bw==
Date: Mon, 29 Jun 2026 10:21:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
Message-ID: <akIrHlIWLhhGNMnU@ryzen>
References: <20260628230310.1214770-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628230310.1214770-1-rosenp@gmail.com>

On Sun, Jun 28, 2026 at 04:03:10PM -0700, Rosen Penev wrote:
> Replace irq_of_parse_and_map() with platform_get_irq() in both
> sata_dwc_dma_init_old() and sata_dwc_probe(). This is the preferred
> way to obtain IRQs for platform devices and provides better error
> reporting.  Remove the now-unnecessary #include <linux/of_irq.h>.
> 
> irq_of_parse_and_map() requires irq_dispose_mapping(), which is missing.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
