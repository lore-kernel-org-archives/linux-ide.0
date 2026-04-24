Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2A39A81E;
	Fri, 24 Apr 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777028847; cv=none; b=hnTpkhMwJyIotBjYsb59SmwbjlrgGh590NULGPvvpBp6fBGgdaBrNCREeeRfcuO7RxWeao3in76yhUrvNszJ1EFTmy3JzA+tjhu8QHS9TqKQbOG2Yv3yZtW0ruCTvY59RyCKG5VpeX9pD0fDRFBCbJT1QnDF6SCsggrA/+XslXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777028847; c=relaxed/simple;
	bh=k8vAAtuJcoZXX8qHacx5f4W28DGOhG9gUiM82r3VbX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dc+SEwIHybg24HLJtGuRcxxR8ApLw6ipBeJyUPQGo6UL82cTdi0ZRUE0iSpkU3+PvHWLlSWDIsKOxoTA2LClA8KucbtmSvddN43Ys6F2mAwZM8icsFV+zYoAVHXaJB3dX9H09C4Pm6e1/mlcJ3tsoGlz0lkC8pT5VKGG0ebvo9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RACIy21n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RACIy21n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3033FC19425;
	Fri, 24 Apr 2026 11:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777028847;
	bh=k8vAAtuJcoZXX8qHacx5f4W28DGOhG9gUiM82r3VbX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RACIy21nrRV+KP05OvAPxTvqpUvf0WKcMw9LHqfVc0IUy6NfemLCedTe5wZKWBz2+
	 mJXmBks00wNDEUXPjb02K4DV6pwb55o95PVW4GHy91tAg4ikT+y9tdTe+2lK9wEJ8k
	 4xaAypyB7yS2h9vip0K859FmdjiHFV7KAV/xTPGzzFLCwa1aa+I8DwZlr4gnpsFG+m
	 Oh0zfmT9tl6Uv+SoLapkylgYWvvYkKLwx47wOfq8wzxQu4749/Wc56zRaUIdFylKgg
	 7J05QuEUiED1LLITK5IEi2+0RH9rZR0BN2dgjlSLcuz3jE6aD3z6nkP+D3R54H/7Ns
	 QRyvs6HswkNhw==
Date: Fri, 24 Apr 2026 13:07:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: =?utf-8?B?5p2O5L2R6bi/?= <dayou5941@163.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, liyouhong@kylinos.cn
Subject: Re: Re: Re: [PATCH] ata: libahci: fix panic when accessing ports
 beyond MMIO region
Message-ID: <aetO6yuzx5MZF-ZZ@ryzen>
References: <20260422080322.1006592-1-dayou5941@163.com>
 <aejc_kqSuU60oRka@ryzen>
 <55809835.8838.19db9be1205.Coremail.dayou5941@163.com>
 <aepUh_p0Jkw0XQ7N@ryzen>
 <26f59adf.571d.19dbe310f41.Coremail.dayou5941@163.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26f59adf.571d.19dbe310f41.Coremail.dayou5941@163.com>

On Fri, Apr 24, 2026 at 02:32:59PM +0800, 李佑鸿  wrote:
> However, in the following code:
> cap = readl(mmio + HOST_CAP); /* When cap = 0xFFFFFFFF */
> if (hpriv->saved_cap)
>     cap = (cap & ~(HOST_CAP_SSS | HOST_CAP_MPS)) | hpriv->saved_cap; /* When hpriv->saved_cap = 0xEF36FF81 */

Sorry for that. From the name hpriv->saved_cap, I assumed that it would
actually override hpriv->cap, but it seems that it only allows you to
set additional caps, not to override/clear caps that are broken...

I guess we could theoretically do:

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1d73a53370cf..94c3c740134a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2003,6 +2003,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
        if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
                hpriv->irq_handler = ahci_thunderx_irq_handler;
+
+       /* Phytium SATA controller has bogus CAP register */
+       if (pdev->vendor == 0x1db7 && pdev->device == 0xd001)
+               writel(0xEF36FF81, hpriv->mmio + HOST_CAP);
 #endif
 
        /* save initial config */



However, that said, I agree with Damien, I think a better solution is to
fail the probe(). Will reply to that mail with more details.


Kind regards,
Niklas
