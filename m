Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794055558;
	b=wSQFXdNicIfnlk0lfsCV8mATr9t/XZj8OOpJ2KMjEbAdGMPxJtxCr19C/24OstAGaUHy
	 ouDjIS08aF8Xst3zLEIweBr0fRoMtI+54LIOyECU8oO6kVtngovDq+HqU0vCoYKJ5hjbu
	 2Bd5bday7IvJiEfjOR+oNROMq/WL763A8tPMBLpxBMcirqDw51/fQYZjJaVMDHuBMSO+O
	 Jy6b4OnQaeZQVMcb+63zh+TFp22VlG0QKpXNXREJgEB8DObACDQkuIv0uiiYYX9BGahl2
	 4OI4gpOK9USBtHtpHe0ZNICoBBw2PKIQHfNvNikVIpV9Z6Z+aq4+LzF24GGUmE8/K/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794055558;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=CiL1HQxfgsOcvm9vKFk1DVPeae6fGl4/cDDijU+Teks=;
	b=2jA0/+N9VcMpWKlf+JTdbd5YPeyySyH3Y80NUQ6nbOH44TXEQN67av36lbkrqzwJMYfO
	 UbUx9in8lusRPOpCAQx9ioqJo5ZUeIEBX8rVTRMNg3yjPzrQE/t/1zvknyggpnJL07Lp4
	 ItAQ3nkLxWJwN6IlLLNLuC8s9Dr6GEU/YHu3ncKlC6/DRyFsbzQ0T4t2LI8pWlF+dqjNb
	 Oajtjg8ZHSU3o2WDGij8RFFZBgBPWp8HZKBQZdgs3h90KwkfTukTIbS1fTmSVlVp/4eeX
	 vYGOU0cfKlS7ZRz87va6ScjPc97BdaNRiaVSrMAEH2GlQEC22IjAyckreRsiol1qgJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asZGQ3aT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1E606A326;
	Sat,  7 Nov 2026 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asZGQ3aT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9201F0089F;
	Sat,  7 Nov 2026 12:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794055557;
	bh=CiL1HQxfgsOcvm9vKFk1DVPeae6fGl4/cDDijU+Teks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=asZGQ3aTW9/wx50mVmL+G2Ag83l/u/ystE8ygXlcryWvsuZcC5vngRH9EwK7E6gWq
	 7u5dCW5hg+lyGKdAkG/Vx+ZZOJCG3IB8oUXTChL8zXvM9zQOE4CTyxvES7CS6qNNZ/
	 oxiYbI1Nn3ZxDOhRqe0FbX3oJir7kmjAPTpFV3SlufjiKH0yvxCYnfBvfePpyPbeil
	 iT6Q2T3Lu/39C+0VJBYOWcnkNzynnLjVaXzQ3f5tv8eH3qlJ2FYGjbHLoYX2q1N3Hk
	 NE/Fkka48M/NpXxRVeiZBQxlSuEsgYs/HDqfbQMO17wKvLpHGtuPT9VLQSMW847JgJ
	 kTefC58ivt7lg==
From: Niklas Cassel <cassel@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, 
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
In-Reply-To: <20261029212513.4126083-1-florian.fainelli@broadcom.com>
References: <20261029212513.4126083-1-florian.fainelli@broadcom.com>
Subject: Re: (subset) [PATCH v4 0/6] Fix SATA support for NSP SoCs
Message-Id: <179405555432.938034.8271032337892944854.b4-ty@kernel.org>
Date: Sat, 07 Nov 2026 13:45:54 +0100
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Thu, 29 Oct 2026 14:25:07 -0700, Florian Fainelli wrote:
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
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[2/6] dt-bindings: ata: sata-brcm: Describe the NSP IDM registers
      https://git.kernel.org/libata/linux/c/262e3bbc
[3/6] ata: ahci_brcm: Initialize the NSP interface clock and reset
      https://git.kernel.org/libata/linux/c/14d30246

Kind regards,
Niklas

