Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A923A25A354;
	Thu, 23 Apr 2026 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776964746; cv=none; b=FSS3DqZg9yohmDAN77KbysQycTI7Hy+l/cc/S3IRSfu2XELb8BhxP/sbIZC+oiWr149i1HKOUTb89kxg0BPqfK/yN0M2fkOUC3lqbANybFvLETlw5pExvLyhz6MOEDcav8fsu4Z5O/KVtQP5XQnwjIvCYTTLhu4lomMSbjiY8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776964746; c=relaxed/simple;
	bh=d5UYlJ8k7jcHhLx/XvbI67yu5dOc3PnMumj3dCibn5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew39W383iFR1TXjI4quaG2BS3knwjIF7d/FJEW7fFGJTsOwZRJeK+abAWO88wTBQqE2dhPH7B8sVcO5QFcTOAlH7XFzP2ETD4bBbQYeI+b3Gb6ikI+4gw1cZYR6dLMqtKpnLZZpLGKIxBk0HjyNWW2oYkOgEDGYfDDxYJvWQL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAvuLZ4Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAvuLZ4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9F9C2BCAF;
	Thu, 23 Apr 2026 17:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776964746;
	bh=d5UYlJ8k7jcHhLx/XvbI67yu5dOc3PnMumj3dCibn5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAvuLZ4ZYahQjl/DNYbDEJqpOncDhIp7AesGrx4V1vctkLEpK9iqMA46oTrW2zA/P
	 TAP7AUpbD2gjJbOh+ZhvaowQ/N339WZ91nnWfmmqWilWsS9tChsJHFFQeebPzzlWLo
	 FuJRGItwkiDdifEadiV1r+JojX6tMcDEapGHiARwhpx1niRC8cBxzKrJk+EXuwP1Oi
	 ytKFaxCv0ntcPsWKI8DVeWXwanB/sZxYlQehO1ksKlgXez8x/Cuhi2btfG8fDwrgm1
	 /c4af+w+nMuwji2irjH4AHb/LW07Q8RU8JfCGVjSap/5sDQE5lzEjkEmw5DgOwg8c5
	 YVVop/xYzMTrA==
Date: Thu, 23 Apr 2026 19:19:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: =?utf-8?B?5p2O5L2R6bi/?= <dayou5941@163.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, liyouhong@kylinos.cn
Subject: Re: Re: [PATCH] ata: libahci: fix panic when accessing ports beyond
 MMIO region
Message-ID: <aepUh_p0Jkw0XQ7N@ryzen>
References: <20260422080322.1006592-1-dayou5941@163.com>
 <aejc_kqSuU60oRka@ryzen>
 <55809835.8838.19db9be1205.Coremail.dayou5941@163.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55809835.8838.19db9be1205.Coremail.dayou5941@163.com>

Hello liyouhong,

On Thu, Apr 23, 2026 at 05:48:54PM +0800, 李佑鸿  wrote:
> However, I have already confirmed with the BIOS supplier that when the 
> BIOS disables all SATA ports, it does indeed initialize the values of 
> the HOST_CAP and HOSTPorts_IMPL registers in accordance with the specifications.
> 
> 
> /* Register values after disabling SATA in BIOS */
> HOST_CAP (0x00) = 0xffffffff
> HOST_PORTS_IMPL (0x0c) = 0xffffffff
> HOST_VERSION (0x10) = 0xffffffff
> MMIO_SIZE = 4096

I am actually very surprised to see e.g. CAP (0x00) and AHCI VERSION (0x10)
being uninitialized.

These registers are not mentioned in:
AHCI 1.3.1 - 10.1.1 Firmware Specific Initialization

And I would have expected them to have fixed value regardless if BIOS
has enabled the controller or not, because e.g. CAP.NP (number of ports)
and the AHCI version must obviously be known when synthesizing the IP.


> lspci -vvvnns 05:00.0
> 05:00.0 SATA controller [0106]: Phytium Technology Co., Ltd. Device [1db7:d001] (rev 01) (prog-if 01 [AHCI 1.0])
> Region 5: Memory at 5b800000 (32-bit, non-prefetchable) [size=4K]

So the BAR size is 4K (when the controller is disabled).

Could you please enable the controller in BIOS, and then dump the value of
the CAP (0x00) register.

And also double check that the BAR size is still 4K when the controller is
enabled?

We could then add a quirk to drivers/ata/ahci.c, something like:

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1d73a53370cf..e7250781e9b7 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2003,6 +2003,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
        if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
                hpriv->irq_handler = ahci_thunderx_irq_handler;
+
+       /* Phytium SATA controller has empty CAP register */
+       if (pdev->vendor == 0x1db7 && pdev->device == 0xd001)
+               hpriv->saved_cap = 0xC734FF02;
 #endif
 
        /* save initial config */


Where you replace 0xC734FF02 with whatever you get when reading the
CAP (0x00) register when the controller is enabled.


Kind regards,
Niklas
