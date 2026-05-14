Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E18D308F0A
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778740934; cv=none; b=hqaN6TEd08YSck1UJogzMzdSI2xfHVXv73tkPj7LjoZqqtjYXbQUwcEx7nLZd125Tg//d6CATvM98vbirUuvM70NY4amSYTcc+PfxsY3ghMif0U6xKhQl+mPUu/FqbXwejTPDqYe48nj9PwnHxnk/RTrSksa+TfQ0Z5CuKvCqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778740934; c=relaxed/simple;
	bh=oJfdHFqNkPARus8iN+S/eKZnhRXaL/n1XNA74Cj3MNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OulFMuCizSnx5117tyv2bC6RRhSmxWfO1+IrO8fCt0X/Jnz6Ffgi2SlBwUDmWxVQUrfoGBA9ylXbtpK+OOFnCCq5wQOXxBvlTubrIYUW3Lv2bfQLBQ5XsN+hQUvTdTFJjC+47EuXMgzMXZq5YC3270+qHPOpimJEMrH+r3ch0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjWdFhoe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjWdFhoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED2EC2BCC6;
	Thu, 14 May 2026 06:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778740933;
	bh=oJfdHFqNkPARus8iN+S/eKZnhRXaL/n1XNA74Cj3MNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjWdFhoeZjK87Z8whu8qO2RWSw+0L30Pqfc14YICHKHrl1Cd4dM3pCsM4hmUhHZBK
	 ges1M2XkRqMdVxtHaz9O/qS1qefo+BzevxM7LeY8yi/6hYTqqKiwc9pi4HYJ+A9AY2
	 FG3gwTvzxFKbHLieRXsR5LWo2CGrg6eE5ksM7RgJQ0zDXhHMMClthHXd/HYn0TdQRX
	 tmRNEPhmNvtHrtJIifyA56XQ72pmYq/3FAXHZUGNFsa9jE8cxVTh6CpMugT8wOCNCM
	 5EudYJ0fueXCCtHaxTH+MkPKJ/umBEvAoEZkGa4DauU40wO7hxQjsHT0iShNXlfnKq
	 HAveSAXcSPRDg==
Date: Thu, 14 May 2026 08:42:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 0/4] ata: fix deferred QC handling for port multipliers
Message-ID: <agVuwX1I1CX5EBMP@fedora>
References: <20260513151359.1075403-6-cassel@kernel.org>
 <5ef17ab9-5941-4268-b537-9e4f6cf7e602@tkel.ly>
 <4b37d9a7-0083-4bb6-ba38-cc243afe0305@tkel.ly>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b37d9a7-0083-4bb6-ba38-cc243afe0305@tkel.ly>

Hello Tommy,

On Wed, May 13, 2026 at 09:42:35PM -0700, Tommy Kelly wrote:
> 
> > U-Boot 2026.07-rc2-dirty
> > kernel: Linux version 7.1.0-0.rc3.1d5dcaa3bd65.25.test.fc44.aarch64
> > [ 1539.481926] BTRFS error (device nvme0n1p4 state EA): run_delalloc_nocow failed, root=5 inode=103820306 start=274432 len=4096 cur_offset=274432 oe_cleanup=274432 oe_cleanup_len=0 untouched_start=274432 untouched_len=4096: -5
> > [ 1539.483785] BTRFS error (device nvme0n1p4 state EA): failed to run delalloc range, root=5 ino=103820306 folio=274432 submit_bitmap=0 start=274432 len=4096: -5
> > [ 1596.136409] systemd-journald[800]: Failed to rotate /var/log/journal/c5b05402ed674946a0b721d8b2c649d1/system.journal: Read-only file system (Dropped 122276 similar message(s))
> 
> Those 2 `BTRFS error` lines repeated over and over every couple seconds.
> 
> This one seems to happen randomly, unable to reproduce consistently.
> No idea why its happening.
> But it has happened with both patched and un-patched u-boot devicetree.

Thanks a lot for testing!

The problem with PMP CBS is my fault, I made a mistake when creating V4.

The btrfs bug seems to be unrelated, even though it seems very bad.

It is good that you have UART so you could see what was going on.

Perhaps you could test on v7.0 (hopefully btrfs is more stable here) +
v5 of this patch series (once I've sent it out).

I'm sorry for my mistake... hopefully it will not go beyond v5.


Kind regards,
Niklas
