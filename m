From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2] ata: ahci_brcmstb: Fix misuse of IS_ENABLED
Date: Thu, 06 Aug 2015 11:10:34 -0700
Message-ID: <55C3A31A.6090103@gmail.com>
References: <1438835298.28215.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35165 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbbHFSMp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Aug 2015 14:12:45 -0400
Received: by pdrg1 with SMTP id g1so35280693pdr.2
        for <linux-ide@vger.kernel.org>; Thu, 06 Aug 2015 11:12:45 -0700 (PDT)
In-Reply-To: <1438835298.28215.1.camel@ingics.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Tejun Heo <tj@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/08/15 21:28, Axel Lin wrote:
> While IS_ENABLED() is perfectly fine for CONFIG_* symbols, it is not
> for other symbols such as __BIG_ENDIAN that is provided directly by
> the compiler.
> 
> Switch to use CONFIG_CPU_BIG_ENDIAN instead of __BIG_ENDIAN.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
> v2:
> Based on Florian's comment:
> Switch to use CONFIG_CPU_BIG_ENDIAN instead of __BIG_ENDIAN.
> 
>  drivers/ata/ahci_brcmstb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
> index 42b6cf4..14b7305 100644
> --- a/drivers/ata/ahci_brcmstb.c
> +++ b/drivers/ata/ahci_brcmstb.c
> @@ -92,7 +92,7 @@ static inline u32 brcm_sata_readreg(void __iomem *addr)
>  	 * Other architectures (e.g., ARM) either do not support big endian, or
>  	 * else leave I/O in little endian mode.
>  	 */
> -	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
> +	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>  		return __raw_readl(addr);
>  	else
>  		return readl_relaxed(addr);
> @@ -101,7 +101,7 @@ static inline u32 brcm_sata_readreg(void __iomem *addr)
>  static inline void brcm_sata_writereg(u32 val, void __iomem *addr)
>  {
>  	/* See brcm_sata_readreg() comments */
> -	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
> +	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>  		__raw_writel(val, addr);
>  	else
>  		writel_relaxed(val, addr);
> 


-- 
Florian
