Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF26539B954;
	Fri, 24 Apr 2026 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777028857; cv=none; b=f4Qo4p6fTXNIXlyM555XHuPck1ddUS3mq21PjaV1Svq7xOhntK1Z5qpQRR2I08D6gXKp9b36yiBfB6AVbMx95iWiUbTpNOe6wXQEMwkw85s5KNL4bCVRKS1XSGgps8+4IAxHU4s1TjgP8Ti0kYkr5qZxEgkSkcioD0u47jTDo6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777028857; c=relaxed/simple;
	bh=mIR0peDwdRYwZv2Q08RXvRy/ZU5/bXi9cPLTnr7Tp1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzH7xyV9c+Rto0AbmXathZxBnata4EkdLV9Rjbh8ABby3ap3Aem2Qk/VXN/SZduQFUHkCe/9NWqcmW3ihCRJv1m1s9PEdmetBNHp9y8n2zj+AC4AVMwPDnponllJjod7LfKJJ3ei/8G7l5l11/DYgOQpztMWlNSzIJvTqBww+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f26RMxG9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f26RMxG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5600EC19425;
	Fri, 24 Apr 2026 11:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777028857;
	bh=mIR0peDwdRYwZv2Q08RXvRy/ZU5/bXi9cPLTnr7Tp1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f26RMxG9c/jHpE4+8LoewPFwEWSPZRtZx+9bcrFxnm0bf3BvymGEcAQpVSH2+jics
	 sDRs092qeYxAX0eL3w+dqdBFiK8jHpfDh7BocYD0/xjJLaEa+cfSo+Y9WzyvZgPKtw
	 IYMIpoR88kFC3fP+DS3oXjOvPF33qD0+99pat6azKTVV4zQFkcq9dD48lPG94Tx4KK
	 RuDtWe5njPG4yS+NOXoBgkp8taYNrSs//ZWMOLGedPIJkesx6ICm+I92rD8tgpwLto
	 L6ANj9QiQ83kyOpkIvqSnC7OE3qNbo4M0c177XjFCcDEjWoIZNj7rS9j2Hr+yqxC1A
	 5RJLfm+Y4pW4Q==
Date: Fri, 24 Apr 2026 13:07:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: =?utf-8?B?5p2O5L2R6bi/?= <dayou5941@163.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, liyouhong@kylinos.cn
Subject: Re: Re: [PATCH] ata: libahci: fix panic when accessing ports beyond
 MMIO region
Message-ID: <aetO9e7Kf5DZK0QH@ryzen>
References: <20260422080322.1006592-1-dayou5941@163.com>
 <aejc_kqSuU60oRka@ryzen>
 <55809835.8838.19db9be1205.Coremail.dayou5941@163.com>
 <aepUh_p0Jkw0XQ7N@ryzen>
 <e4280e3b-b02a-4c4d-97dd-1bd49daad2fd@kernel.org>
 <13d7d471.6389.19dbe594e14.Coremail.dayou5941@163.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13d7d471.6389.19dbe594e14.Coremail.dayou5941@163.com>

On Fri, Apr 24, 2026 at 03:16:56PM +0800, 李佑鸿  wrote:
> At 2026-04-24 10:43:11, "Damien Le Moal" <dlemoal@kernel.org> wrote:
> >
> >What I am surprised of here is that we even see that device on the PCI bus at
> >all when it is disabled in the BIOs. If that device is disabled, why are we even
> >seeing it by scanning the PCI ports ? The adapter should simply not be visible
> >at all.

I agree.
E.g. both AMD and Intel make sure that the AHCI controller PCI device does
not show up on the PCI bus if you disable it using the BIOS.

It would have been nice if the Phytium BIOS also worked like that.


> 3. **BAR Size Mismatch**: `CAP.NP` indicates more ports than physically fit in the BAR
> - If CAP claims 32 ports but BAR is only 4KB, this is physically impossible
> - 32 ports require at least 0x1100 bytes (0x100 + 32 * 0x80)

The reason why I did not suggest failing the probe() originally, was because
李佑鸿 sent a patch with a Fixes tag, so I assumed that he considered it a
regression, and wanted the hardware to continue working, even though it was
marked as disabled in BIOS, because that is how it was before the commit in
the Fixes tag was introduced.

That said, I fully agree that I think it is better to modify the AHCI driver
to fail the probe() for this AHCI controller when it has not been properly
initialized (because it is marked as disabled in BIOS).

I prefer option 3.
Look at CAP.NP and look at the BAR size, if it is too small, just fail the
probe().


Kind regards,
Niklas
