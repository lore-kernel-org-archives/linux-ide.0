Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3425E821;
	Mon, 28 Apr 2025 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745829726; cv=none; b=NnIfFQPpKXVYFdNyHgbMfUCufhYy79qahjjTMVrrmarnLZ2nrVETgbMWDxzzOswNsJBHXKsE4ablspLQ06pjonClVeJBkvJnHe7UN/BHTcGox7vRpQee8GQ/pCdnjcSGvrF5ykmckZanm3ztJGPmR2uE+LBxPCxHI4k7JoJrEdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745829726; c=relaxed/simple;
	bh=bEhWigbCGAEUWFJ8JkgGyCA/a4Jw1TYA21NKw6cRiPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ao5++WPbiB+/NAbkHp+rmCU6WhIdlPqesclcQOjurBoOz0YQmfHk1wirn6g1h6zB+kfv131+QohqBpJUAkzCJ2GDeAFUGQnnCg3jOSz7sUMN2N5Dkuqi+X1f3YJ0USSS/WxqJRUdXjdTBJNRkft9rPVJKRbWR3ztwBZ0r2RKU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/Gg3E3f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/Gg3E3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966BBC4CEEC;
	Mon, 28 Apr 2025 08:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745829725;
	bh=bEhWigbCGAEUWFJ8JkgGyCA/a4Jw1TYA21NKw6cRiPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/Gg3E3fhyeQLQVMiNG1WHtkk53Qf5q9PVGm54dj42RztAU2xCtIsDNi8tWVa33QZ
	 qVaQ0Vx5Thv6Z+BRv8GJDt6m91NDyHFaD+2eyfMDXuQMNfcqBVEiVc/JtADE97rCLJ
	 /1eoeiP72GuEn3gshvawW/CvYdWipskarCM7wH68m+7CRbyyzSvggEiiP5LoM8eJYc
	 MIUExiVVOxLWm2mszicYR4iYigJ9PZ4xvenUIjaQ0AfceCDOqgYR3jSChSSmLLC3mg
	 ztdpKRZYbenHiqWvY9YDuMVOqnb1jOMCvCcZgSy12VlDNSIVef8SW7FmfR9NQE8rGf
	 4bIl3NOmzQRfw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	kernel@collabora.com,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] RK3576 SATA Enablement
Date: Mon, 28 Apr 2025 10:41:32 +0200
Message-ID: <174582939239.704591.18413477868629759543.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424-rk3576-sata-v1-0-23ee89c939fe@collabora.com>
References: <20250424-rk3576-sata-v1-0-23ee89c939fe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=687; i=cassel@kernel.org; h=from:subject:message-id; bh=bEhWigbCGAEUWFJ8JkgGyCA/a4Jw1TYA21NKw6cRiPc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL47e3WNM4Q6W/6UpNetH99SP87w9LUbD7DNzLnI4wbz XfxunzvKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwEQq7jL8FbKwWjHbfNr8siOi CbMcpWyvMvvfPsXqs+3ao0a9jh+c3Ax/xVfyO7EcLtyfLmQTljxh3Zcs/3TDHFGZkvZD3/tPZNu xAAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
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

Applied to libata/linux.git (for-6.16), thanks!

[1/2] dt-bindings: ata: rockchip-dwc-ahci: add RK3576 compatible
      https://git.kernel.org/libata/linux/c/b8ed9475


I'm assuming that Heiko will pick up patch [2/2].


Kind regards,
Niklas
