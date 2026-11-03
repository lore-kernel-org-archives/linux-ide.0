Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699246;
	b=xv0bhEBQgUXkteXlYWekRG333cE8+IY+G7LrFsspKu5uxbFFvTnAXfC9NhpBHq8MSwqG
	 A+yfkir0X+afqD/VLtczsAga9inlKBkdErTSe4E/8Oqkiw/HUy5Ke2Qv9IdBhFWYxwrLS
	 knMGT0wlzm+E54CfX2RwQXzmZ+sPstsVVpFDvSlLWN1Q6SV3ntpN1E9eXCnqkI2/+OCTe
	 fUbMcHPdIeQWnybIsgOM3DW6rFSTIZ2kG5REInusYBmaywXIsp+Hk5Ju3tRtd3+3mCKOA
	 EtIw+ZqUd8Phblj02iixfrH2x4OV2olqVMiDGIPbpXSx6C9VIxu3/MQ16FK9TuaztmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699246;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=FicnvFKxeSZZxDsqkATTizCSYcpguqKwirBa2ehbQWc=;
	b=Ki3PkVaIx6ldzNZ/5vBz8YhR8tOxtCSaLMBbcS6+7dmh+E2XZxJ+khy5WR8aTbW9mv9l
	 QZT23aO0wedusaVmS4/xbaLl2k2MYwV3CmPgH/xp/7ib9t0WoHJ4qioq2jX1Mcvz8aGr0
	 hgOiMmdIx6iW2ho5qNCbwCMYNpyoZQucvpSQu9kWn4OcV3AYn3TFQyJ9Z6mwKW4poAOiA
	 l3WuDnHmyBMn9GZhtDewSkbVNifsOU51meq6ZC9M6JZVsrCjPmiD8OxL3wZhk+pxvyu+2
	 LczMVYocyfHl0KX+nnf6b0DckHf39yvPiSN3n7ig02zplziSalHkNYcKyVJIPlNlhZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vqb4EMaI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384E606D822;
	Tue,  3 Nov 2026 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vqb4EMaI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998221F000C1;
	Tue,  3 Nov 2026 09:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793699246;
	bh=FicnvFKxeSZZxDsqkATTizCSYcpguqKwirBa2ehbQWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Vqb4EMaIZjfRUOXG0g9LrY7EG6YCjSMm4DFAAOJh/vqHoJeVp8GTErtbqT0mfsg9f
	 aV7DHYXxtw7KsFDULksJ7PW3Z8a9OAcaef9z1PV68ghzMbM1QgWjBYk498jLOnPUDj
	 4PK/XoD7ZgeVAqnJpOj3/Rf7JRNsvEKz7qpb2VgHtfgpnlVyFCYr5dskbH5v2EMhcg
	 pArk4KxjxJf5/KwWzEwXebwErJ5XUzvZyN3ODa1V+X5+v3y2kcK1w0Isgqf1c16NnV
	 Dzyv1Z0aw7XT8ZzL66NiCbaKvNmi9e7+Y/gxTJzkYIpwQ85AkCqWv5Ky8UXDw90z7i
	 iNaFbW4W55YVA==
From: Niklas Cassel <cassel@kernel.org>
To: Viresh Kumar <vireshk@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20261102163141.3812536-1-Frank.Li@oss.nxp.com>
References: <20261102163141.3812536-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH 1/1] ata: use dmaengine_desc_set_callback()
Message-Id: <179369924435.1823794.16997924682170944810.b4-ty@kernel.org>
Date: Tue, 03 Nov 2026 10:47:24 +0100
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

On Mon, 02 Nov 2026 11:31:40 -0500, Frank.Li@oss.nxp.com wrote:
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper.
> 
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[1/1] ata: use dmaengine_desc_set_callback()
      https://git.kernel.org/libata/linux/c/6ba53556

Kind regards,
Niklas

