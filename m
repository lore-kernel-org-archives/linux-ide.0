Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809FB16FF44;
	Wed, 12 Mar 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792412; cv=none; b=aqw6v2GFhELaK3z3+MDMWbKkSzbuyDfugT2hxzPXp2UknuBCDWM0v7bJXiXtotTt422p1UmXDOgOQ2nNm/IANbcpZFUB+RxoNsz7WGdrWuKcVgcPvbmDcJjzPKn/r1srDaaUt9QSy+C9nFp4ZPvv8bxF15ccs1w804mxE8kn8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792412; c=relaxed/simple;
	bh=NfYIPDL/R5XU9ENmAwbJywG6k5yNmixA59CUlFuwHPo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KjDetCdM+iZ/Gy3o62IVij3iJDEBRFL6Mya+KaDn5dgZ+ZgUhK/YSWFZ8cIkwV8l4/x+6XVKenUEkCpW7Uji4q3/r4Co5HoLCqqc8rQYNUAJfrZDfg17XSYIkghbCshSE+cJpso++2EQE11CpD0yqWDo05zW8n6Ed6NWK0kpqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW9D3b3F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW9D3b3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B953BC4CEDD;
	Wed, 12 Mar 2025 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741792412;
	bh=NfYIPDL/R5XU9ENmAwbJywG6k5yNmixA59CUlFuwHPo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NW9D3b3FU4fX3QtjTLAnFvyyn3Kk26sXPf05cMKvp85ll2b1wbDhGgWx1JQw7VZzh
	 Z/XZzKt3+Q8AE3swOVxzmqAmPsIkUHhRtK47WVnIlhW86R1DoQvPU/x+MP4b2eTwjU
	 hNih9pFTDHSQwz2/QIuTMYhAytLcl3/VRrUUrcTrZSxqRMSIRSEyp7+2YyvuRqAJcB
	 iAJ7PkMhishhDYNaavzD5uW+E9QIBOW/1SNn50LZxGCRAbENZUI4fODZunyZideioH
	 qrfLspYGewKhaS9CAr6uoE6qIYhReU0B1trxghTp8DNVncvK9+2vjXl7QR4tUkCNkf
	 /MA2Zpeo70ExQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-ide@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, 
 Xuerui Wang <kernel@xen0n.name>, Daniel Kral <d.kral@proxmox.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250312133954.6666-1-chenhuacai@loongson.cn>
References: <20250312133954.6666-1-chenhuacai@loongson.cn>
Subject: Re: [PATCH] ata: libata: Return -EOPNOTSUPP instead of 1 in
 atapi_check_dma()
Message-Id: <174179241047.984574.18019635919979994622.b4-ty@kernel.org>
Date: Wed, 12 Mar 2025 16:13:30 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 12 Mar 2025 21:39:54 +0800, Huacai Chen wrote:
> -EOPNOTSUPP means not supported, so return -EOPNOTSUPP instead of 1 is
> more suitable if ATAPI DMA is not supported in atapi_check_dma().
> 
> 

Applied to libata/linux.git (for-6.15), thanks!

[1/1] ata: libata: Return -EOPNOTSUPP instead of 1 in atapi_check_dma()
      https://git.kernel.org/libata/linux/c/725ad028

Kind regards,
Niklas

