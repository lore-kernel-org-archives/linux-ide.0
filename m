Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26FC53370;
	Mon, 12 Aug 2024 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467189; cv=none; b=cZyanbEb3ypjJEWu4IcdwjZJM9XxwiI/TgAJFjs8788+qCigaATAJUAHqyGhZSZvLacaULyXzEYZvHUj6npW0qNoW7Kx3BDz3hJh69fHK/napSRG3HVZZZ7RDtopB+cgmvO1tBR8d9S4xLqvFxt6i7JAgtsOUdM0fc8ISmMciIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467189; c=relaxed/simple;
	bh=q8tFVz/lZ5nIvzB8ohe8PHJFR6cM7/UC9D+nI6PE7+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S0za1ba4DFJXvzaLDbPM5YrDaRrWpxJBt+IacrJc5XlHeGWIUPocqn+qzDZ1qHNKRQgftQ8UmH+VeJm+Qn5u+x3KUHOeDyjBzR5pYKSHIWd2zt5Z8a47rej4UM5m6BRIQ1/bO55BlTH6L3RRLOE8pWgT6gTFgX9EIRcVhVgIZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTxJlyK9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTxJlyK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB116C32782;
	Mon, 12 Aug 2024 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723467189;
	bh=q8tFVz/lZ5nIvzB8ohe8PHJFR6cM7/UC9D+nI6PE7+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lTxJlyK9zrCIZs+t+mzylWBiFgcc8gAE0DhBBvql7BmPgWiugCoKQOb/Yuu8lCptH
	 mIhsJDoBKtW8MIZ0Wvo0YiuEcToJpBlcFMPRtpD0zQJixr/ZsYt1BoFh31j5P/m0/9
	 FroEUPRM8nNl5BLC48VG+MI/2LxlKpy56YWCneDoqYPz0n3eit525AcIMEamDN08st
	 IwrsglBlf+mqxxN5DNJkUNN8ejfa1te+u0CxArdG6kKPAuY5Lv5Xhg+2aMcTM35r/J
	 TOQ5uZgWX1PKOJR2XAqxptStIoVqfSA2H2Cmbn6NKBIUIydmjjYuIH4caNV9gqMLFc
	 5T95uqLCV/BdA==
From: Niklas Cassel <cassel@kernel.org>
To: tj@kernel.org, dlemoal@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 festevam@gmail.com, Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, kernel@pengutronix.de
In-Reply-To: <1723428055-27021-1-git-send-email-hongxing.zhu@nxp.com>
References: <1723428055-27021-1-git-send-email-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v6 0/5] Refine i.MX8QM SATA based on generic PHY
 callbacks
Message-Id: <172346718567.916777.975536718860014441.b4-ty@kernel.org>
Date: Mon, 12 Aug 2024 14:53:05 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

On Mon, 12 Aug 2024 10:00:50 +0800, Richard Zhu wrote:
> V6 main changes:
> - Add Frank's reviewed tag.
> - Drop 32bit DMA limit commit, since the "dma-ranges" of DT can overcome
>   this limitation.
> - Correct the email-lists, incorrect used in v5.
> 
> V5 main changes:
> Thanks for Niklas' kind help.
> - Drop 32bit DMA limit commit, since the "dma-ranges" of DT can overcome
>   this limitation.
> 
> [...]

Applied to libata/linux.git (for-6.12), thanks!

[1/5] dt-bindings: ata: Add i.MX8QM AHCI compatible string
      https://git.kernel.org/libata/linux/c/5ff80684
[2/5] ata: ahci_imx: Clean up code by using i.MX8Q HSIO PHY driver
      https://git.kernel.org/libata/linux/c/4147e9d2
[3/5] ata: ahci_imx: AHB clock rate setting is not required on i.MX8QM AHCI SATA
      https://git.kernel.org/libata/linux/c/3156e1b2
[4/5] ata: ahci_imx: Enlarge RX water mark for i.MX8QM SATA
      https://git.kernel.org/libata/linux/c/803f9fb8
[5/5] ata: ahci_imx: Correct the email address
      https://git.kernel.org/libata/linux/c/6773e058

Kind regards,
Niklas

