Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F333D3D75C0;
	Thu, 14 May 2026 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778742604; cv=none; b=qR7mfswxXEKrj6nxgi9UrKPI5Y52Pnx5Nk+QQToljjFgqG8xI/I9Juqvj/KWr/E3WW9jC3r3O5cu4gkuZfqGHMMkEMSYlLEnpuYKVsW9+5SHSMXrZVz34FkVIUUx/gYE4Hu9llPcYM4HTNQ9SJz+XFr92NDyFVVu5fZpFEVuugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778742604; c=relaxed/simple;
	bh=O+VSaZj4E+4rmKFQV+o7QJuUEtZYgWAoAeG3mLNHHvs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JhdSU9NYlnN+mG6cGALB9ocAFViuHO1apTEGWpqK1jKqTxib74WnAcWdBxB68fcs7FYWNYrPonPGFUGpsWYvJtbmPLqLrA9PJoCNCn8sC2wPwJ3OPCjumHRfnKsSa2CyT179ETr/FU9Mv7wckE4H0KpGDdJghxO0Nx40Chib8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGVMsFOw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGVMsFOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68B0C2BCB7;
	Thu, 14 May 2026 07:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778742603;
	bh=O+VSaZj4E+4rmKFQV+o7QJuUEtZYgWAoAeG3mLNHHvs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tGVMsFOwx90gXKzCnbszhadD/USf71KJVCd1JHxs5KP97uguScmJD+gPcJdQ6snS4
	 fSmf7nbFzP0Mr0521MZzacRpiJCP1MKifhJb3adi+l1wc0rZBMnIhA/YP8Phfx11yR
	 RtYcrGv/f0XMmslCKJMqX9JmtkI9PrUl/PkCqDbGRTaUTWRqZ/d0x30KD0xPgNbyFR
	 RQ4l5sXZQJ4W9PCObJgpbUgMEyutjsjnqINAkfjjbuRSWcaJc9LYOD72zQ2wlzC5dj
	 wzanM685OZmVbhBdgrrmr+kumpjIPEOuWg4YKHzDgDUXCe8gM2+kXqTJFU1v9zQcEU
	 JaiBdH+ZZqgMQ==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260512202255.18484-1-rosenp@gmail.com>
References: <20260512202255.18484-1-rosenp@gmail.com>
Subject: Re: [PATCHv2] ata: pata_arasan_cf: simplify ioremap
Message-Id: <177874260241.1169940.2193474450218590272.b4-ty@b4>
Date: Thu, 14 May 2026 09:10:02 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Tue, 12 May 2026 13:22:55 -0700, Rosen Penev wrote:
> Use devm_platform_get_and_ioremap_resource() to combine
> platform_get_resource, request_mem_region, and ioremap.

Applied to libata/linux.git (for-next), thanks!

[1/1] ata: pata_arasan_cf: simplify ioremap
      https://git.kernel.org/libata/linux/c/0926c1b7

Kind regards,
Niklas

