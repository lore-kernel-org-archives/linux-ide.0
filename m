Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638386;
	b=vseZj3kKO53CNWRnsUloQR4rLmw+O0Np4cfeCG9VxM8jul+3mZnScWxCUbzpbaY0xzfS
	 rtookwHmYtMviyk36bRTJUuggHNEmG5H3OZycu6eQc+3zBE7QsNy56F3tG/2ohmVMC+bv
	 CbRlV3O62QcLojSP9nqPeUiNtIBo9JmKhzPGauFwwLfDzd7m7EE9gFM4yfFkZBkyrdAKq
	 YFWmLVGtHVqCukeVBDN5AyByJtUMM+wGAy1VcKGneWuwB1865hujP3I3xlDYOKl5KRd5s
	 4JEk3/I9GXtRPRRP7wJqY57C2aB8BJHjz1qZnD+L1OFH9jhBZGbvFMK4N8YVaLVv7Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638386;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4hSSmxRQOYQLc9X1LIBh+NOmGHv/RzthQxE33huemtQ=;
	b=fKoDSZAwAUd3VIfgw1Nz1gFtpc7sBJNe5aW9P9/P7KbUgGlTbbw4HmYjMHCGpy2G53gC
	 0tNiGMy3+f2Ne5uVQtsZc7+NpproHOUAX+K7lRRj18phq6vPRKj+tbwGKr1sXohb1T5eE
	 6+nS5mhGfFY6xnaDU4Ct/wj0hosLxwgwNU78htLPcQHHRaviy+q5YaaOeZefSIhRlnu7N
	 JHM29tiYphAeeIUlnBLi56pHIiXDM+FYOWvCz2I50YF47vmEEnI3+ASYeyF6nv32Y6acv
	 /mCC/5/YhVA7rI9BKe7yHIkxfD/pBfhRt1JHHV3Q7w2aR7ZJk9Zuqo9RN8nJeDsudMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hd1iJO17;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914F6078267;
	Mon,  2 Nov 2026 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hd1iJO17
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2421F00A1D;
	Mon,  2 Nov 2026 16:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793638385;
	bh=4hSSmxRQOYQLc9X1LIBh+NOmGHv/RzthQxE33huemtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hd1iJO17zYx5UbfD1AhdqZ0MOToj3xpVgH9dJStKut9idV8JWyc1ZpdH0d8UtMuD3
	 8mjxtC+Wq5QGHqs/r1p2+7cFiFoWTNXb0nNE3Lh/FYOZ98Z/hfCC9lFRgSpgMyqLF3
	 t9Oyvu70FzchK/LPHyEmXnhjQqa/MyDp8OOx79xK4NZVyTE6YykGqVeyLisI2VrlfK
	 Vr5danEHRYbxmSDW1IUajEX5QjqRCoW0SQzXMNtD3r87C4jbVzJRWXX5KfPBDQQQgW
	 QDMreyeCPukHqU0TXae1qzbsoLU+2vwFEiCBes8iWrL+ePfuyLaVc1LBJz2lvbRf9Q
	 0M8cieXD54jEA==
Date: Mon, 2 Nov 2026 17:52:59 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:BROADCOM IPROC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v4 0/6] Fix SATA support for NSP SoCs
Message-ID: <aui_68Kxlpr7zdyn@ryzen>
References: <20261029212513.4126083-1-florian.fainelli@broadcom.com>
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
In-Reply-To: <20261029212513.4126083-1-florian.fainelli@broadcom.com>

Hello Florian,

On Thu, Oct 29, 2026 at 02:25:07PM -0700, Florian Fainelli wrote:
> This patch series fixes SATA on the Northstar Plus (BCM58xxx/8831x)
> which was broken due to a number of things:
> 
> - the SATA PHY assumed separate PCB windows when a shared one is used
>   for this generation of SoCs
> - the clock/reset (IDM) was not being configured by the driver which
>   meant that depending upon what the boot loader did, or did not, we
>   could have had the AHCI controller still in reset by then
> - on some reference boards, the AHCI controller is not DMA coherent,
>   assuming so leads to all sorts of timeouts, data corruption, etc.
> 
> Since this touches several subsystems: DT, PHY, AHCI and DTS, I would be
> keen on having Damien merge all of those via his tree if acceptable by
> the DT and PHY maintainers, I am OK either way for Broadcom SoC.

Patch 2 (after we get an R-b from DT maintainers) and patch 3 can go via
libata tree, but the normal way would be for phy changes to go via PHY
tree and device tree changes usually go via arm-soc (and lately it seems
to go via a broadcom specific tree first).


Kind regards,
Niklas
