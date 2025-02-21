Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E314A2505A0
	for <linux-ide@vger.kernel.org>; Fri, 21 Feb 2025 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158659; cv=none; b=YWfJ3KrdHC0NvAeHx82Au+9vU7S5kR7bpINm5azlc29gM4XVyNrL9Ads4U3kvs1zWMgxvay7RTSvuK9UB30YyLO5ZxvgN4VYKy9iITWkMD8QKGCUOWPxpOE7YZeXqDPOJ8mwhTBF2SOfGTXeQcosCTgAt+O62fw03CvOnziHwhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158659; c=relaxed/simple;
	bh=wj035GWVmBsgbf6BULjvPL2uWLZgRrU9n4Z9KrxSV2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0QFu8og/CbkfaoUbChlCKcmDMDGKEeC5V5+axgK2er5a2r1drXJRLEtv5DUPVj4nOt8CLk7d9tWBv1VtUAjCHgqBuB7L9bn0RtiUp2zCqXlZSfa3oc/6x9dRCrT1Qq5TBXMCEBh5Pisv61yp51C5nOCmU/CCyiy+Ov65bYT2cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/QVxfb8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/QVxfb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4731C4CEE4;
	Fri, 21 Feb 2025 17:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740158658;
	bh=wj035GWVmBsgbf6BULjvPL2uWLZgRrU9n4Z9KrxSV2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/QVxfb8bpICcick5Ay+OYeTWqkMsODwTzsY+dcBEhK5bSonD8HtzKo+OGPKKNLRe
	 JyIsD3AG8+ialeVGLkI08/aYeTnWaynCdjlpVRbcAg6sfjUyxkLkh8Ggac+7T5Oug0
	 FkN4nfzVIg187DIFQFqtV4uoicF3Pi1Ta3LSgg5hzUd5rUJd3vtKlZ654/PZPbBYfm
	 g06QK8UnBHfmN1nxlQ9u4dQHKYLF2m5k0/vYQPTpHEccPKjG5gqRHPrHlXir1etih8
	 is+Y4NR/uQde3diaXRBStit5u1ArFiyN9ggiq7SERY7YqIO5BmFyAkb/l4jKAtVXj1
	 oT2ATFg0gDJwg==
Date: Fri, 21 Feb 2025 18:24:15 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Philip Pemberton <lists@philpem.me.uk>
Cc: linux-ide@vger.kernel.org
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear
 UNIT ATTENTION"
Message-ID: <Z7i2v8Nyetfx29zx@ryzen>
References: <e1b79ece-b4b2-42e5-b259-290820324b5e@philpem.me.uk>
 <Z4pdD1Z2mJnF7N3O@ryzen>
 <2bb1510c-c42f-468b-a8cb-70603bee846b@philpem.me.uk>
 <Z5NlVjIMp6Wo8dQd@ryzen>
 <9253b1b9-0f92-45ab-8b8a-44064ffa9cd9@philpem.me.uk>
 <Z7X9aPpgBjNln9CJ@ryzen>
 <Z7YAnqGsrWSzBirf@ryzen>
 <27dbfb0f-2dfb-4f4a-bc5c-bb53a9f1eef5@philpem.me.uk>
 <Z7fdfX6GD6D98UPp@ryzen>
 <62cd0608-8089-4c1e-b44d-699f1409dccb@philpem.me.uk>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62cd0608-8089-4c1e-b44d-699f1409dccb@philpem.me.uk>

On Fri, Feb 21, 2025 at 05:08:21PM +0000, Philip Pemberton wrote:
> On 21/02/2025 01:57, Niklas Cassel wrote:
> > Please try this patch:
> > https://lore.kernel.org/linux-ide/20250221015422.20687-2-cassel@kernel.org/T/#u
> > 
> > and see if it fixes your problem.
> > 
> > Please also make sure to check that you can still write and read back what
> > you wrote to the device (with the read data matching the written data).
> 
> I can confirm the patch works!

Thanks for testing, and thanks for actually taking the time to debug this!


> Dump the original contents of the disk:
> # ddrescue /dev/sdb zip_orig
> GNU ddrescue 1.27
> Press Ctrl-C to interrupt
>      ipos:  100597 kB, non-trimmed:        0 B,  current rate:    589 kB/s
>      opos:  100597 kB, non-scraped:        0 B,  average rate:    792 kB/s
> non-tried:        0 B,  bad-sector:        0 B,    error rate:       0 B/s
>   rescued:  100663 kB,   bad areas:        0,        run time:      2m  6s
> pct rescued:  100.00%, read errors:        0,  remaining time:         n/a
>                               time since last successful read:         n/a
> Copying non-tried blocks... Pass 1 (forwards)
> Finished
> 
> Create 100MB of randomness, write it to the disk:
> # dd if=/dev/urandom of=ziptest bs=512 count=196608
> 196608+0 records in
> 196608+0 records out
> 100663296 bytes (101 MB, 96 MiB) copied, 2.74086 s, 36.7 MB/s
> # dd if=ziptest of=/dev/sdb bs=512
> 196608+0 records in
> 196608+0 records out
> 100663296 bytes (101 MB, 96 MiB) copied, 226.022 s, 445 kB/s
> 
> Read it back:
> # ddrescue /dev/sdb ziptest_read
> GNU ddrescue 1.27
> Press Ctrl-C to interrupt
>      ipos:  100597 kB, non-trimmed:        0 B,  current rate:    196 kB/s
>      opos:  100597 kB, non-scraped:        0 B,  average rate:   1059 kB/s
> non-tried:        0 B,  bad-sector:        0 B,    error rate:       0 B/s
>   rescued:  100663 kB,   bad areas:        0,        run time:      1m 34s
> pct rescued:  100.00%, read errors:        0,  remaining time:         n/a
>                               time since last successful read:         n/a
> Copying non-tried blocks... Pass 1 (forwards)
> Finished
> 
> Compare:
> # md5sum ziptest*
> f132f7ad38beef40d45ce9f96a6e9f92  ziptest
> f132f7ad38beef40d45ce9f96a6e9f92  ziptest_read

Certainly good enough for me, I will add your Tested-by tag!

Considering that this has been broken for 19 years, a few more weeks
will be quick in comparison. I will queue it for 6.15 just to get some
extra testing.


Kind regards,
Niklas
