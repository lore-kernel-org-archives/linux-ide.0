Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0208423AB88;
	Tue, 10 Jun 2025 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561564; cv=none; b=U5iSRtgo2fm1qrukmsCrqgTrXgC0QRSaUBjdl+TOXjSWHCHghw/2Pac/dgK6Iv3MIIWkklbDtsbGC/DSSqEVm5xNa/A1M13zHZadnRyzAsHXFxl+oQwQOlNtI2rfGy8meAjWJuitt5ibzj5pClrvn2sn/jvRjmjzTryeONDimKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561564; c=relaxed/simple;
	bh=KK0HnPM4C+YEJJoBL+zjgqef7iTP3bf2uEjdrH8lgdc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gVvmn+fEX8kXMCF7QG2gE/U3Jn0mFc6ZSVVkmHqk+qb8wYcZVp0syEHu2hy38zfbmm82ozVElfnxblRJg1dlECSlv7BwJ3W2OXF/hsqLil0fZEAEzCMDk/3S6dg4Xk1L+7ceJB6D63BbmnhAmoOn4zeGFknuBa4rKlD/1Tumg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uGH2Vukm; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uGH2Vukm"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bGqBY0Kx8z9t00;
	Tue, 10 Jun 2025 15:19:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749561557; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KK0HnPM4C+YEJJoBL+zjgqef7iTP3bf2uEjdrH8lgdc=;
	b=uGH2Vukm670FUTYNfVgoEOMSswXnQVWcpfOyrmI1t68otVZImRZCkHpvZZ3MeuE5GHwo/m
	Rs7h5HGrZ0z4q4p0czQoVq0YmXRtjeRZ4jCYz8CFJddPKBUM78B8coJzk4qISiGFZY+RTf
	6GaN32avTmRhhCnywuAoDLYNBymaW6RgNA6FLFQExbZHrkmaOZhZkJXJHVG7HT8x2vqEyL
	8ky2ZsnRb4fCLuFJ4n+pc41obAk0xm5YfOydHwXMwcIjjBTmc11Fb7RIAp0tGZ0o/v2IYE
	sn4Kf05sWUCySNwTLBzBnNX1XRB7s+FWDyiTPnBuXzDqDdIfcGC3mJxsI25Ggg==
Message-ID: <5f8155b300f5b1fe9155f36c6385c940dc8ca42d.camel@mailbox.org>
Subject: Re: [PATCH] ata: macio: Use non-hybrid PCI devres API
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Niklas Cassel <cassel@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 10 Jun 2025 15:19:14 +0200
In-Reply-To: <aEglmHpvqZhbG_AX@ryzen>
References: <20250604113423.138595-2-phasta@kernel.org>
	 <aEglmHpvqZhbG_AX@ryzen>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: ymy9ndgq5bq9iczyc1dz154ym4rqkygo
X-MBO-RS-ID: 6c8ab586ae85f3ae1ce

On Tue, 2025-06-10 at 14:31 +0200, Niklas Cassel wrote:
> Hello Philipp,
>=20
> On Wed, Jun 04, 2025 at 01:34:24PM +0200, Philipp Stanner wrote:
> > macio enables its PCI device with pcim_enable_device(). This,
> > implicitly, switches the function pci_request_regions() into
> > managed
> > mode, where it becomes a devres function.
> >=20
> > The PCI subsystem wants to remove this hybrid nature from its
> > interfaces. To do so, users of the aforementioned combination of
> > functions must be ported to non-hybrid functions.
> >=20
> > Replace the call to sometimes-managed pci_request_regions() with
> > one to
> > the always-managed pcim_request_all_regions().
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > Hi,
> > seems I forgot sending this patch out a while ago. Mea culpa.
> >=20
> > PCI has currently chained the changes mentioned above queued up for
>=20
> chained?

"Queued up for the merge window".

Now it's already in Linus's tree.

>=20
>=20
> > Linus, so it's probably a good idea to get this into macio
> > relatively
> > soonish. Otherwise the driver would likely fail to reload in v6.16,
> > because the device's PCI regions remain blocked.
>=20
> I can queue this up for 6.16, but then I think you need to rewrite
> the
> commit message to motivate why it is a fix (i.e. why it deserves to
> go
> in to 6.16-rc2).
>=20
> Or, I can just queue it up for 6.17.

No, this needs to go into 6.16. As I state above, all kernels from 6.16
onwards which don't have this patch will see pata_macio fail in case of
a driver-reload, because the PCI regions remain blocked.

I can fish out the commit ID and provide an adjusted descrption with
Fixes: tag as a v2.

Thx
P.

>=20
> What do you prefer?
>=20
>=20
> Kind regards,
> Niklas

