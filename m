Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449987;
	b=gwTf5DCJvOuNyyBYcfATkynVXE4fmjJgWDRM6/XCvrCSPAXeIyPYAv5zqw/fm8t+b+6U
	 prkuoxLgR8Dj8dy7zlOc4+tZU/Pvn3DEcz81ImQF9omujy7/t9CIUChOSHUAqRP+Y19F3
	 nqjEDSKj/MNrjWQRzm6aNxLXpxdC38VB9mqpU3rT/ecYqhU4hI+Hq6llkfcZO6Yh8D0wK
	 bGvHBQIfTp+b8nUId3CsPnxyV2QX83EIixd0THqrwYEQz6lWS9dOqTrKP2VNGEyYKjjuY
	 jFlKxcgiICcFaH/DBkr3oUDeDlPwEJWWlMnE2dTPR5OTeoxahixePOQHBRLYoKmUv8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449987;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=bQB57YHJuSU7y+p9K3IgANjz1Zr9QyTIdR3LXMCxl28=;
	b=JxvZNPR9Dfc17UaNdHIZl8yHeOZqS7hW1AWsbkzuaw/Q3O+ipgPWvV7ei8XstjclaHmS
	 CT1Rh7bmwzNSwTbYfZ8nMSQoGeaxK8YssMgp88iRAboyBe0ZyKv0WFQMjgZUxBkQE0sOW
	 h4GKyKk2enEnWDR9TumGjXsd2pumEOop6lb7zasWlWXD+mX+eLqSiN4JKpNefcPyegbZI
	 YyyYyPkYy+6hhurtcioAJgmpak+Nz93T3cySdxHmAFphK4cwos7yUFjuSV5+BG20ovQTk
	 m2Gez833eiFeMX9JFGWr+LFtp4KByl/hx1S2BPBpCzjwB+p2WmAdDO58zxjcVAFMYqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osh0+YvU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55183606A31F;
	Mon, 23 Nov 2026 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osh0+YvU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A86C1F000CF;
	Mon, 23 Nov 2026 16:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449987;
	bh=bQB57YHJuSU7y+p9K3IgANjz1Zr9QyTIdR3LXMCxl28=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=osh0+YvU9TjNyTg/rCIIiY47awwTryiBiPfiPhJ7yBp0aITc/OY4s9NpodGHJMHVx
	 TiovNZvUBm9uiBc0c9KMuW/uR+KGQ3fbjrJkw5LHXPqOER5wM/ZruS1rd9gGPs8bzE
	 JxqlOU+vhs1lAAXwVo1X4juPOn/u/yMnFKOH2YzdgY5mepPKJRmTLbUbjMJfodAuT2
	 viw1ovmG3R0qdfguGnGHGVZzIoeblEm1ZnMQb9ron9NUNf5s04LzrVhAOWbCGyTiUd
	 ZhNUgG2KbnIU7XbR1DHf1q+F1nMjGjn0+CrGS0NKowYbxRlbYjDbTxI6Ff86uQnEH6
	 U9hMcQFyuYjIg==
From: Vinod Koul <vkoul@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, 
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
In-Reply-To: <20261029212513.4126083-1-florian.fainelli@broadcom.com>
References: <20261029212513.4126083-1-florian.fainelli@broadcom.com>
Subject: Re: (subset) [PATCH v4 0/6] Fix SATA support for NSP SoCs
Message-Id: <179544998187.275844.18441245364658646762.b4-ty@kernel.org>
Date: Mon, 23 Nov 2026 21:36:21 +0530
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

Applied, thanks!

[1/6] phy: broadcom: brcm-sata: Keep NSP ports in the shared PCB window
      commit: 2a27baf6e203af422db2d84f9f382153612679a9

Best regards,
-- 
~Vinod


