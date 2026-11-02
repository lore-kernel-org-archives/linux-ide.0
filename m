Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616775;
	b=i84twVpXn6I2R2JWiWx6kENK+2qLYiOejGS8rMrhhlWEtaS2K2yHkD78mpYg2jdLWNKC
	 LBs0CgAoX/TEstbMh091UOl5UVSIYxSec2HT03KOUK7DyjtFUNKu6oXEx04kg+ny7YMsY
	 v0mSoDvPYj21WADAJca1Vg/gIb6TbElEzGOpSV8GA5Tr+k+/LIBJKltFUgbwvrLfjCqtG
	 BwlhRpS+D74iu6FpKcZTwGGhQNwEebNGoJS8r38WC0ffDitOHsU5Y3UvbIi9BN3/WRKAt
	 +v7eJLNnmfNmbmaPlIHnJ3zRFndb7RaRz6ksFYc8SlKA2zaHlFvpYqsYWq0iybeBQiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616775;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=llfb2OtZT92YwA3l6kRheKIisH4jidqaDq38VH5NsGg=;
	b=tz2bjjs1Lftc773zWCXtGXrNH2qYzW35N34HObf5+GWtRwRaJdLGJipUIxpraS5GnUvj
	 ccs8gE9p47Z57SKOW77I+4cZLiQBGMNWlBuNcvRPdiPo6vn610OlYFsPDPtyA33rCILeZ
	 Rpuj+b/ZM1/gGIUNPpJ0W3WDl9LNQQi8dTPgW/LBn98FccRF9EPnChMnNhui/TaegB22x
	 mygRM0qNzhXe3hhzB3LlPOFt8zaXh5Vfst3j8N59PBFtHJFhy/iUwQEPIe0A6R4n/VWqt
	 AKcns+LdtGdzalZwP6Ynw+fbgQm9Mp9Um4aw7NbcI3yjsWeUfBtWeGhafU1/s/EFxXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwiBnlb9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F12606A324;
	Mon,  2 Nov 2026 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwiBnlb9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1181F00A16;
	Mon,  2 Nov 2026 10:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793616774;
	bh=llfb2OtZT92YwA3l6kRheKIisH4jidqaDq38VH5NsGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WwiBnlb9XHjGBfvORmKspGmu7IF/PXwyUCm8b8xZLkBsQgsRotJE8HAWNgBJ1QVHv
	 Ip+ox++tUGPJsXkE2PqPR2YfxV+eSeBLnVjIi6h+zBKYZGnRrpRe6qqGY91uDxV5K2
	 coRarLYzKPx+W09yjAv7icqicSe93D0QTKr55meqhB8d++uXUQZnwA0ii1raKwmLOk
	 CdcubIZUjMn/JjObEk4K3PK2fW6r9ec4IKTBGq+REM1Ipjh1R/5xotIa1W0vQeCl/l
	 Y8ai2gfMCpbOSr687kEKY+ltargnEPpqCYKeaECE1VEl8dkjy1k45CSO1JgEdfGvDh
	 Msvsd17aN6pnw==
Date: Mon, 2 Nov 2026 11:52:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Daniel Palmer <daniel@0x0f.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, dlemoal@kernel.org,
	linux-sh@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Florian Fuchs <fuchsfl@gmail.com>
Subject: Re: [PATCH v2 1/2] ata: pata_artop: read the ATP865 mode register
 through pci_iomap
Message-ID: <auhrgteGO3TwU3HD@ryzen>
References: <20261025034410.808796-1-daniel@0x0f.com>
 <20261025034410.808796-2-daniel@0x0f.com>
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
In-Reply-To: <20261025034410.808796-2-daniel@0x0f.com>

Hello Daniel,

On Sun, Oct 25, 2026 at 12:44:09PM +0900, Daniel Palmer wrote:
> artop_init_one() probes the 6280's "fast" bit with inb() on the raw
> start address of BAR 4.  That address is a PCI I/O address, which is
> only a usable port number on platforms whose I/O port base maps PCI I/O
> space one to one.  On an SH7751 LANDISK (identity io_port_base, PCI I/O
> window at 0xfe240000) the resource starts at 0x1400 and inb(0x1400)
> dereferences that address:
> 
>   BUG: unable to handle kernel paging request at 00001400
>   PC is at artop_init_one+0x10e/0x170
> 
> Map the BAR with pci_iomap() and use ioread8(), as libata-sff does for
> the BMDMA registers later on.
> 
> Tested-by: Florian Fuchs <fuchsfl@gmail.com> # on PX-EH40L (LANDISK HDL-U, ATP865 1191:0009 rev 10)
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Since your cover letter says that this fixes a regression,
I think we should add a Fixes-tag.


Kind regards,
Niklas
