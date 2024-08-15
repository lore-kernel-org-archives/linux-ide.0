Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABB11AC8A2;
	Thu, 15 Aug 2024 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723722371; cv=none; b=YBtIG3zvuet/9MCX6EPEF59cnEr16GJEyBk9qRNhh195wqXbJip9hrQms5hPn7OmBKfryaR907izigcNpkj61iIrB2uCTcMNXSm/QCBSWWc7PWh+8kI4eObHLZt1G3SoylgnQx8a5+y0hx+jI4HqrZVRS9+OzK9bgk6mJUScvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723722371; c=relaxed/simple;
	bh=0qeKYNWlnJYCbTXO4RZUvA/261w2T+ltf05RwHKc550=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E1X59C+Twfq8zhbnBmjX5FQNo4s9Np0jHj1VcW05GDAhHw+HWLWrjoZTaz9yyJrHdkMSpKHrHVQQdYY+rSBIwhOA2m2WVZJsG0/n4bZK652iGVJQvJQ7u/AF9hZ4GF0t2QsxfTyVieoGG/DODHDkgk3A4WxsSEJKw0DnxeqB5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hz90JBsn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hz90JBsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58964C4AF0A;
	Thu, 15 Aug 2024 11:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723722371;
	bh=0qeKYNWlnJYCbTXO4RZUvA/261w2T+ltf05RwHKc550=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Hz90JBsndLOBSyqpK01DM+pOE5qkHNiLhKpKK4T6+324pOteZn7wh2c23gJlgVkSu
	 CPCfhxbRzkq+cykGKSO5aRX9lTqQSXzz36eDNW9I7o82M0sLx0PK7sAdcY7oa8xzK5
	 DWUGZUED7heWeEwsSl4KgXhpmKdpsj0W/Aueld9UhdjoN5wLpCuCy74MDjEO9Y0tWO
	 8T0PLP51iPStd71HFPMYDgU2APfkZOL/LP/W3gJ0ZmCkqqwPWcO/45/ArL75pv+Sd1
	 Sdreg1rlUbV0AKhrX2UQSg1x94rpYewjlLGzmpKZlUbzl3cKG7lcxKwio24mxzbopi
	 Gtwt8AF0/0kIw==
From: Niklas Cassel <cassel@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 linux-ide@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <cbcbdfc2-ddc7-4684-8ad4-018227823546@stanley.mountain>
References: <cbcbdfc2-ddc7-4684-8ad4-018227823546@stanley.mountain>
Subject: Re: [PATCH] ata: ahci_imx: Fix error code in probe()
Message-Id: <172372236807.1345373.6405219104137659637.b4-ty@kernel.org>
Date: Thu, 15 Aug 2024 13:46:08 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

On Thu, 15 Aug 2024 14:25:08 +0300, Dan Carpenter wrote:
> Return a negative error code if devm_clk_get() fails.  Don't return
> success.
> 
> 

Applied to libata/linux.git (for-6.12), thanks!

[1/1] ata: ahci_imx: Fix error code in probe()
      https://git.kernel.org/libata/linux/c/66afec7c

Kind regards,
Niklas

