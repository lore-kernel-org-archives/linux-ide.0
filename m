Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6823F254848;
	Tue, 29 Apr 2025 21:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745961985; cv=none; b=uoIsxtJMRHfAwpqAVYejhygmChazYP8Z8kgAbfQpKGavg/MZT6umhNIC0zWFxRvdagnU3indk3vKGFRHXEY9VHx/wxIK3w98i9hkeELXvyeE/uZN8fubqbiXfCv5XZRXIPHC1qASEQL6xayz2C+6CN0jzZXaQrnwQMAIcBGkTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745961985; c=relaxed/simple;
	bh=JJKYQPbX0oS2edgtN/JiR8K5u2DsChTbCg12PVfbFcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FX7VudlFkb9CEoN0B3ZP8UDsBejM+af+PT/vZZV9ECVyGfvxH94XL3lnfavwENJHwobuKwegUzuIbGxS5sQD2rDo+vYFnPI0Y/RR8iaCtLUStlkdQSDzXuG9oJVMeQgP4MTDLLZlVXl2G05RrSdgQ9SjvxuIwhyRXdvf+qR1DvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=O8BwmQCo; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="O8BwmQCo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+SGSB4/+nlLFVQyK8SYD92uIgww4SyT7f0UDpG1s4xk=; b=O8BwmQCopy+yAIs0PC3ozSdz11
	gSfGlzpYnSLJ9S+QMILMlUgY7xpn4dkO36BCISW3XbaY/I9fu3blr6BiMyr1OR4bn8hWkwhob7y0O
	lGvHX7rr8cX9XjQb85McsZx/ZhGjNyl07wtSIiCwe5syx/fJyvy78P8txx2XqB7m2zkpqBIXYx2rp
	F8Xe7UOx27ts9Wt20/QJRRCGSAENq1/e4jI3dUfiWw/wScqIIvVuOWkwMZqAF9OMvTTmRzj39L0fJ
	x+X05eb7aPiYuwYqO8ZbH9konGVSN56TkvNYBkFHQQXV5b1W8WAssroADmFrOmUM6oM08nE8YdeJn
	a49Nts2A==;
Received: from i53875aba.versanet.de ([83.135.90.186] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1u9sSs-0008Pg-B3; Tue, 29 Apr 2025 23:26:06 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	kernel@collabora.com,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] RK3576 SATA Enablement
Date: Tue, 29 Apr 2025 23:25:48 +0200
Message-ID: <174596194661.227689.3642609522784038361.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250424-rk3576-sata-v1-0-23ee89c939fe@collabora.com>
References: <20250424-rk3576-sata-v1-0-23ee89c939fe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 24 Apr 2025 20:52:21 +0200, Nicolas Frattaroli wrote:
> This is a tiny series to enable SATA on RK3576. It consists of a patch
> to add the compatible to the bindings, and a second patch to add the
> nodes to the SoC .dtsi.
> 
> I've only been able to test sata0 on my board (Sige5), but the
> successful test gave me confidence that downstream's "dma-coherent"
> property here is appropriate and true.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: rockchip: add SATA nodes to RK3576
      commit: 24d8127d801560c8fa811d554e8ab5db7e51511c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
