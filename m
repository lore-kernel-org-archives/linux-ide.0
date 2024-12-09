Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB61FB3;
	Mon,  9 Dec 2024 01:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733706889; cv=none; b=Qhyfo1cEBogJ31BJtLUIuIsqSU4f0xk5sA4A9jdpGu5iSpTd+3owwM1sPq98JFomm045CTQXfQwL+0UxSVECAxztUVooIWjQ4wspfZWvWqRnMsiGJO9tGHIMGsbjtbrSRSjC6kLAjiGMj9LWaG+p0Ov6Q5poVSDFTUjUpYXGjyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733706889; c=relaxed/simple;
	bh=ZtTDcvzOIYHGQGMSxYfM2HcfFnOfvSC95OTzy5bAPTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQcdk4UZCLnjC6eEO/f03nXYXyJxyuf535mcgy+oh++sNhiVZ5D7lG07LewdS/tnmk1PBXlUajXMdFrEas+CLhuVGLlQd/JPS/MkJfs/V6ExsWNCiT/AovuRvYZxv8UIdxWU87mdQ21h2ayu2vM0OAVClmACbgjMXL3PZZlZ6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPWbGfeT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPWbGfeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891E2C4CED2;
	Mon,  9 Dec 2024 01:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733706889;
	bh=ZtTDcvzOIYHGQGMSxYfM2HcfFnOfvSC95OTzy5bAPTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UPWbGfeTUm95ED9Iv7Vr5O5Ew51eg1Ak6rLzc/rdtsAjHKq1dF44X355STZsdFX3c
	 4R/fLxR+XlWuHyMEtiEA9VtstaYgURUKfgwXqcoN+0CZMP3uZCZxB9m1Us95q1shwd
	 FfTC2O/kI6v4W/ZRVa2ZkhTCQ4Buff0zbw99NjKAUmUyyfPIIwzsDlZHTgwCPujyvL
	 vbcZZZc5THw92CC/XMdZ+O77Kpa3K/Wlw1TN0bcY7vQEextB+pBK4JzwaUIOZJ32CF
	 BSfCtjQ+cA87QSM5rAziXjhszn90Om+6Pg2Yk4CdOxLHm7YioekVWrEejv5P/ducrq
	 fv7zGNePWHHtw==
Message-ID: <973b3b99-77eb-4a27-9a4a-8547d2a2cc76@kernel.org>
Date: Mon, 9 Dec 2024 10:14:47 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] ATA: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>, Niklas Cassel <cassel@kernel.org>,
 Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241204171033.86804-2-pstanner@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241204171033.86804-2-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 02:10, Philipp Stanner wrote:
> Hi,
> 
> many of you probably know that I'm trying to remove pcim_iomap_regions()
> from the kernel. One of the more difficult users is ATA, because it's
> the only subsystem I've seen so far that accesses that table
> pcim_iomap_table() administrates.
> 
> This series only builds as a whole because of patch 1. That's why I
> submit it as an RFC.
> 
> I want to know whether you agree with the basic idea, and whether your
> subsystem wants this series to be squashed into a single commit that
> builds.

Overall, looks OK to me. But I think that at least patches 1 and 2 need to be
squashed together. For patch 3, if you can have a minimal "make it compile"
change in patch 2, you can keep the cleanup separate. Otherwise, squashing all
patches together seems fine too.

> Another solution would be to provide a struct ata_host.iomap2 or
> something like that, phase out the pcim_iomap_regions() users, and then
> remove iomap2 again.

That seems unnecessary.

> 
> Please tell me your preferred way.
> 
> (This is the revived version of an old series from August. In case
> someone is wondering)
> 
> Thx,
> P.
> 
> Philipp Stanner (3):
>   ata: Allocate PCI iomap table statically
>   ata: Replace deprecated PCI functions
>   libata-sff: Simplify request of PCI resources
> 
>  drivers/ata/ata_piix.c      |   7 +-
>  drivers/ata/libata-sff.c    | 130 +++++++++++++++++++++++-------------
>  drivers/ata/pata_atp867x.c  |  13 ++--
>  drivers/ata/pata_hpt3x3.c   |  10 +--
>  drivers/ata/pata_ninja32.c  |  11 +--
>  drivers/ata/pata_pdc2027x.c |  11 ++-
>  drivers/ata/pata_sil680.c   |  12 ++--
>  drivers/ata/pdc_adma.c      |   9 ++-
>  drivers/ata/sata_inic162x.c |  10 ++-
>  drivers/ata/sata_mv.c       |   9 +--
>  drivers/ata/sata_nv.c       |   8 +--
>  drivers/ata/sata_promise.c  |   8 ++-
>  drivers/ata/sata_qstor.c    |   7 +-
>  drivers/ata/sata_sil.c      |   8 ++-
>  drivers/ata/sata_sil24.c    |  20 +++---
>  drivers/ata/sata_sis.c      |   8 +--
>  drivers/ata/sata_svw.c      |  10 +--
>  drivers/ata/sata_sx4.c      |  19 +++++-
>  drivers/ata/sata_via.c      |  31 +++++----
>  drivers/ata/sata_vsc.c      |   8 ++-
>  include/linux/libata.h      |   7 +-
>  21 files changed, 216 insertions(+), 140 deletions(-)
> 


-- 
Damien Le Moal
Western Digital Research
