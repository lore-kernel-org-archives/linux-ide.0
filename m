Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936919;
	b=NKCirCqRLu+5N+MdYnPZxrLTFCGBFAVaH/2jcz7To9gpO97jD8/3Ip1QWbQQWETTkq3t
	 p5ilF7Mrk4MnZB+KG6HRrO7ISGMb3VbRQOx5hRO0uaq5hSXQoUbRQhuGFkpJjvUudPWyS
	 zYSsHte7hsR6FgYG4uUDh7GaTZvX8uPeNnwz88mpAhCviixrG+CWAbcGmFpYorL5BxKpE
	 +IWVhuemF9TX1YGtVl4C8LvMY2T36koc9mtkZXabVT4sez8XGAMmRYf1EvcLIOkhJ1D1F
	 kldHiq3F0aBmOaVJB8O5CXA/64P/CZg74ZzT4w4zEy/NWMkczLT1vhIDfYEiZIo7N1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936919;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xdxs12743NDoNJxbnDGKAhLTeXv90Ow3q001NJmFiRo=;
	b=WnJGq3S9tckLug8osN0gkkWrws5lK0+glUUtgLtBKECTihIJi3gqBnvnVaoLNagaEDoI
	 sBhzkAWfXWH3SzRJ7ZeT3DnzOrArrFqFz52sl6Dj2tL1khfWKSZJzo7ve5JyxMZPHqg3n
	 InuQojdWxg1MFJxL9yTz3dRIDR6HU9Acsar66DRNr2A8mUGddmHgm7Qwsnw+RnaAmdnJX
	 DfA+G9+gMVyQ95c8nW+2KaPOSlG1FQnImQ3PhUaMX5IGcNtjvSpcc6mFphGasWbA2lgdB
	 fHQgLFVZTdsVH3Ct/ahkPrg9T9wwvSBqVd2sVDWasMKXex3g7P+NZ6KksOHlqLUpNJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iY0cVogF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDD8606A8A8;
	Tue, 17 Nov 2026 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iY0cVogF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D83F1F000D1;
	Tue, 17 Nov 2026 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936918;
	bh=xdxs12743NDoNJxbnDGKAhLTeXv90Ow3q001NJmFiRo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iY0cVogFK/z7QGVoaMgG1ymZmRQqjTfWjlHGqoCcByQxgAvsVAZ7t5hqehI6aIttK
	 HN6yNEXIeFfeP7d31+Ez6PRir/PwO1eGDDZfZ4/yLTuk7PbZyQK5GwT3i0RLvefNHQ
	 NYoj68Q9/p/Wihb7mjz0Z+A+XLBt7p6ITbtSQQajvohhh1GTprobAJLtVMlYTD7LkJ
	 BT5Ryo8OSIOX+KIds3Hxljd8OMS7SFHIRmcJgoVRIj5+5yRh2cKtJpha2PJXeSAbXw
	 JKX2F6ns4aVnI6NuVe0s7IX4lolK29oe5rxex/zIVt2XO0WExtllhcpKiB2oXC2A7P
	 944yyN522tkfQ==
Subject: Re: [PATCH 6/9] soc: rockchip: grf: Restore the RK3588 PHP StreamIDs
 after system suspend
From: netdev-bot+sashiko@kernel.org
To: aiyengar1990@gmail.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, david.wu@rock-chips.com,
 dlemoal@kernel.org, cassel@kernel.org, fancer.lancer@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, praan@google.com,
 will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 shawn.lin@rock-chips.com, sebastian.reichel@collabora.com
Date: Tue, 17 Nov 2026 17:35:16 +0000
Message-ID: <179493691692.3136.5141582035448551878@kernel.org>
In-Reply-To: <20261113-mmu600-php-v1-6-231196049a3b@gmail.com>
References: <20261113-mmu600-php-v1-6-231196049a3b@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The concern: the commit message says that 'The SMMU aborts a
  master whose StreamID was lost', but at this commit mmu600_php is…

--

soc: rockchip: grf: Restore the RK3588 PHP StreamIDs after system suspend

This commit keeps the RK3588 PHP GRF StreamID table after init. It also
registers a syscore resume op that rewrites any StreamIDs lost when PD_PHP
is powered off during system suspend. The op is only registered when the
GRF node has a clocks property.

> The PHP GRF is in PD_PHP, which firmware may power off in system
> suspend. The SMMU aborts a master whose StreamID was lost.

[Severity: Low]
Is this description accurate for the tree at this commit?

In arch/arm64/boot/dts/rockchip/rk3588-base.dtsi the mmu600_php node is
still disabled at this point:

    mmu600_php: ...
        ...
        status = "disabled";

None of usb3otg2, gmac0/1 or sata0-2 point at it with an iommus property
yet. That means the SMMU abort described above can't happen in-tree with
this patch alone, and rockchip_grf_resume() has no visible effect yet.

Two later patches in the series fix that:

  "arm64: dts: rockchip: Attach the masters of the RK3588 PHP SMMU"
  adds iommus = <&mmu600_php N> to the six masters.

  "arm64: dts: rockchip: Enable the RK3588 PHP SMMU" removes the
  status = "disabled" line.

So by the end of the series the restore does take effect.

Could the commit message say that this patch prepares for those later DTS
changes? Or could the patch be moved after them in the series?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mmu600-php-v1-0-231196049a3b%40gmail.com
