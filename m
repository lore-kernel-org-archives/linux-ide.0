Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F93A1E71
	for <linux-ide@vger.kernel.org>; Wed, 14 Jan 2026 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407911; cv=none; b=bbSq9WbQw1ZyjXYiJru+lAK4EWssrwvvhoY9voWsNKW5LiPPWbq/VeXJHcBxSRs4lhtJcanvrjd8hHd6JMDovgTtxSF5c45fAWnZQAayyqVI/YwdQ6dLKcrFxuoaf3yGN0QMW9y73VpXGG+i7UORHH2Rb/qavvEaWrovJN1ngFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407911; c=relaxed/simple;
	bh=7axy5Ujtl+85/UQgkxRbuYqk8MNK91eI/THV8lmVkk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtZvcT1+kpTsHKOpeyAQF7qDjQiWDljMtbni4gi4rzP36QbiA8doGv+jxQ8gv+9qXq/7PxnEx0h+bJvY/o2bvFxUYfoYXcpzbe342gz+SfZgua/dlCK1GpTY8/WR2i0HLkfSewfeBXbOOF0APbcmtyq+QCu00g8mfCMd51M0+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDugAJTa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDugAJTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01A4C16AAE;
	Wed, 14 Jan 2026 16:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768407911;
	bh=7axy5Ujtl+85/UQgkxRbuYqk8MNK91eI/THV8lmVkk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDugAJTaZTzLAbYIzCe3EQrZe2Wb/SXT8nkJAI5OV+xj1Lpvp0JFk7hJdqRiPeem9
	 8q0om+hUxE1+gNclr3fbsDxGiMe9V+/i86uJ8APJlqSMWSC1IoYsKzSPoh3bI2aazC
	 qJy+YiEJCWcglueC1VG4gMxwF+dELTJ2lEITxqr1pdeMsBbyZd1nG5sX2v/AwrEnjg
	 CsReAyUluWH6txoAKY33HMoVgZftRbbr4CyRj8JXw/qR1cx6LQb7rfdTVyCW1waxXh
	 U+7BWMFRxpasyuklhzYN1wiGnFciuHyuymsjXo5xRh7JVe44KT259l0H3w2yN1DRUY
	 7+sqPGZQ1ur1w==
Date: Wed, 14 Jan 2026 17:25:05 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Wolf <snow.wolf.29@proton.me>, dlemoal@kernel.org
Cc: 1120831@bugs.debian.org, linux-ide@vger.kernel.org
Subject: Re: [regression] failed command: READ FPDMA QUEUED after boot for
 INTEL SSDSC2KG480G8, XCV10120 after 9b8b84879d4a ("block: Increase
 BLK_DEF_MAX_SECTORS_CAP")
Message-ID: <aWfDYaZU7nYtcH0b@fedora>
References: <176839089913.2398366.61500945766820256@eldamar.lan>
 <aWelaQYNJyulLBVc@ryzen>
 <kkJPUUv8aExqrXPkwlzwEJV7Ywy3ogYCeTawLZZJm3wHBYylIhyCUeIKVFg6PWku-5BbspvtELJC6Tok6ens7Ib26hFkuSKKSm8NEwigRYo=@proton.me>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kkJPUUv8aExqrXPkwlzwEJV7Ywy3ogYCeTawLZZJm3wHBYylIhyCUeIKVFg6PWku-5BbspvtELJC6Tok6ens7Ib26hFkuSKKSm8NEwigRYo=@proton.me>

Hello Wolf,

On Wed, Jan 14, 2026 at 03:11:50PM +0000, Wolf wrote:
> Here is find-max-sectors.sh output:
> 
> Drive model:
> INTEL SSDSC2KG480G8
> 
> Drive firmware:
> XCV10120
> 
> SATA / AHCI controller:
> 00:17.0 SATA controller [0106]: Intel Corporation Cannon Lake Mobile PCH SATA AHCI Controller [8086:a353] (rev 10)
> 
> Drive values before running the test:
> /sys/block/sda/queue/max_hw_sectors_kb:32767
> /sys/block/sda/queue/max_sectors_kb:1280
> /sys/block/sda/queue/read_ahead_kb:128
> 
> Running test with max_sectors 128 KiB
> Test: PASS
> 
> Running test with max_sectors 1024 KiB
> Test: PASS
> 
> Running test with max_sectors 2048 KiB
> Test: PASS
> 
> Running test with max_sectors 3072 KiB
> Test: PASS
> 
> Running test with max_sectors 4095 KiB
> Test: PASS
> 
> Running test with max_sectors 4096 KiB
> Test: PASS

It is quite unexpected that 4096 KiB passes.

find-max-sectors.sh performs reads.

The commands that timed out according to dmesg shared were
also reads:

Dec 10 18:58:49 kernel: ata1.00: failed command: READ FPDMA QUEUED
Dec 10 18:58:49 kernel: ata1.00: cmd 60/00:18:50:4a:4c/20:00:0c:00:00/40 tag 3 ncq dma 4194304 in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

And also of size 4194304 == 4096 KiB.


The script has been able to detect different limits for other
"broken" drives, and was used to get the quirk value for e.g.
commit 2e9832713631 ("ata: libata-core: Quirk DELLBOSS VD max_sectors"),
so I wonder why it is not workin here (why 4 MiB reads passes).

Damien, ideas?


Kind regards,
Niklas
