Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159EE13AD09;
	Thu, 22 Aug 2024 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295606; cv=none; b=kYyGhs+kCkHQqDUzlVH/R14Rwga0Gg3iQSJbXi17Y0W7FLax1Ri9x6pQLa4c5laa2GxkdVrDt3mKOt+39O2DWZ3/SFQ7xHKqyHAL8cB6K2j3Vv/9klsDWtLgv4NSdev6LVl6r5a0DOfLZK0rfQCpIKbpBE5aeAvyVbsh0Xj5x0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295606; c=relaxed/simple;
	bh=MiLS6QNJIotafRSJtcVlL+FuD4p7HukeuznkH6hVuas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWez2t92CK5vahrElJvQse/mbXz3sCZX1wRS7MtjsBCyz+CVLuv6YKRCII2+vlDgemAg1qQeJKh8CNZOm9K4sdzwnI9xe8OZm3onlX1T29Ebr960szCwYcqavIZeJ01aSxxGLUp9E2t+Y+sQMCz61jvT2ITNJg2MbZNBPV0fm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C504227A8E; Thu, 22 Aug 2024 04:59:53 +0200 (CEST)
Date: Thu, 22 Aug 2024 04:59:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, cassel@kernel.org,
	dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	hch@lst.de, linux-ppc@kolla.no, vidra@ufal.mff.cuni.cz
Subject: Re: [PATCH v2] ata: pata_macio: Use WARN instead of BUG
Message-ID: <20240822025952.GA32067@lst.de>
References: <20240820030407.627785-1-mpe@ellerman.id.au> <6b2208d1-c18f-14d5-e6d0-acd5c82b4db1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b2208d1-c18f-14d5-e6d0-acd5c82b4db1@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 22, 2024 at 12:13:52AM +0300, Sergei Shtylyov wrote:
> On 8/20/24 6:04 AM, Michael Ellerman wrote:
> 
> > The overflow/underflow conditions in pata_macio_qc_prep() should never
> > happen. But if they do there's no need to kill the system entirely, a
> > WARN and failing the IO request should be sufficient and might allow the
> > system to keep running.
> 
>    WARN*() can kill your system with panic_on_warn -- Android is particularly
> fond of this kernel parameter but I guess it's not your case... :-)
>    Greg KH usually advices against using these macros. :-)

And in this case he is simply totally wrong.  The whole poing of WARN_ON
is to have a standardized way to assert conditions.

