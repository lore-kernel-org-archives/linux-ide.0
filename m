Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561AA54937D;
	Tue, 22 Sep 2026 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082160; cv=none; b=pD3wmUq8he4nuC734KnVUSxH7xUwm45+VXmRvFNp1E6OUX2FyC+e2fUrYQaqRn3+9YpjU9cJdo7o+VD86CrJd6Be3DkHzdGbJNfynAt+c8hnEYe0Pb9eBk4tF3pksMYhdIJ6I2ynyYq0frWV7FT6+NPW3p6RKg/a/7uUpIktvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082160; c=relaxed/simple;
	bh=VxsSOy30Z65jo59L+8C2jj+y0OaHh8r9pkoNUtul+Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXOyYsUD+J8T3BATVyOTjWdv+a/SMrVhCikMTpefNdnbS87ludadPpzAsoFOnF+YWKtkyPqBUUKhM1WOcFZoD64HyVmVDRNNPMY5GKDYS2ee8Rqv07GEbkuzpcI+HxshFecyztclVaArPlmqkltKAIfsoL/vcrwHyDZ+iVPRAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjZNHd5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjZNHd5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECDF1F000FF;
	Tue, 22 Sep 2026 13:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082159;
	bh=Y3Xa4aAFFbs1cbiDD1IeBBn8Jort13uwZBooPijgiEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IjZNHd5MkaqLNWqHGf8p1CUSVgGnDZa1C62T5C5Mmt+b6N3OydoIn+9bhL2Hkj2jn
	 G9vL08Y3Tb8Z1RGvcK5xDn377JSRVnZILpfuDz3KT9uncce+tlw0nf2q3ixuzvsK2e
	 0rEempIozAeI5WgBA6n3VXZs05XKNUaArd431ly+nClrvcpDEDbL4zBd1meHrBFyE8
	 ZwhbUzhkZBw0zw+1PP+shIUk0c/vABkjsgw6DFwsve6W9Pn+ngK2PRjBvb9/ZlpH4E
	 XxnlHkEEcAaFbFbHE9g/3qnf0iDCSXzrA1IpMqSs0J5vPaOOTCX3YUBHIpEZGj621D
	 +ZxLMKbHlgw1Q==
Date: Tue, 22 Sep 2026 15:02:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-sff: replace kmap_atomic() with
 kmap_local_page()
Message-ID: <arJ8a__3EwMBnTs0@ryzen>
References: <20260921182448.194307-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921182448.194307-1-danishkhateeb03@gmail.com>

On Mon, Sep 21, 2026 at 01:24:48PM -0500, Danish Khateeb wrote:
> kmap_atomic() is deprecated in favour of kmap_local_page(), as described
> in Documentation/mm/highmem.rst.
> 
> ata_pio_xfer() and __atapi_pio_bytes() each map a single page, pass the
> address to ->sff_data_xfer() for one transfer and unmap it again, so the
> mapping never leaves the function that created it.
> 
> Neither needs the pagefault_disable() and preempt_disable() implied by
> kmap_atomic(). ->sff_data_xfer() only moves data between the device and
> the mapped buffer, and both functions are reached only through
> ata_sff_hsm_move() with the host lock held, whether from the PIO task,
> an interrupt handler or EH. kmap_local_page() is fine in all of these.

> 
> Tested on i386 with CONFIG_HIGHMEM4G and CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
> under QEMU, with the PIIX IDE controller limited to PIO by
> libata.force=pio4: O_DIRECT and buffered reads from an ATA disk and an
> ATAPI CD-ROM, and O_DIRECT writes to the disk, all checked against the
> image files. The O_DIRECT buffers were in highmem. Both call sites ran
> in hardirq context, and ata_pio_xfer() also from the PIO task. No
> warnings with lockdep and CONFIG_DEBUG_ATOMIC_SLEEP enabled.

Testing instructions are usually written after "---", or in the cover-letter,
so that they are not picked up by git am.

No need to send a v2, I will fix up when applying.

When applying with b4 -sl, which adds a Link: tag, the patch, including
additional notes (and cover-letter etc) can still easily be found.


Kind regards,
Niklas
