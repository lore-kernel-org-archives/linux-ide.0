From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6] SATA: OCTEON: support SATA on OCTEON platform
Date: Wed, 03 Feb 2016 14:41:10 +0100
Message-ID: <3554031.r9sGg8j827@wuerfel>
References: <1454437485-48009-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1930324.vU65IL0x0g@wuerfel> <56B1FF7A.3040906@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:62455 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbcBCNla (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2016 08:41:30 -0500
In-Reply-To: <56B1FF7A.3040906@imgtec.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: tj@kernel.org, hdegoede@redhat.com, david.daney@cavium.com, aleksey.makarov@caviumnetworks.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wednesday 03 February 2016 13:24:10 Zubair Lutfullah Kakakhel wrote:
> 
> Bitfields for both endians are used and handled by mips.
> Mainly used by cavium.
> 
> As this is a cavium driver, would it be acceptable?
> 
> Or should I replace with the following.
> 
>         v = cvmx_read_csr((uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG);
>         v &= ~(SATA_UCTL_ENDIAN_MODE_E_MASK << DMA_ENDIAN_MODE);
>         v &= ~(SATA_UCTL_ENDIAN_MODE_E_MASK << CSR_ENDIAN_MODE);
> #ifdef __BIG_ENDIAN
>         v |= SATA_UCTL_ENDIAN_MODE_E_BIG << DMA_ENDIAN_MODE;
>         v |= SATA_UCTL_ENDIAN_MODE_E_BIG << CSR_ENDIAN_MODE;
> #else
>         v |= SATA_UCTL_ENDIAN_MODE_E_LITTLE << DMA_ENDIAN_MODE;
>         v |= SATA_UCTL_ENDIAN_MODE_E_LITTLE << CSR_ENDIAN_MODE;
> #endif
>         v |= 1 << DMA_READ_CMD;
>         cvmx_write_csr((uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG, v);

I think something like this would be more conventional, yes. Or maybe
define the macros so you don't have to do the shift everywhere:

         v &= ~SATA_UCTL_ENDIAN_MODE_E_MASK | SATA_UCTL_ENDIAN_MODE | SATA_UCTL_DMA_READ_CMD;

	Arnd
