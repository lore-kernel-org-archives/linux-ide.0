Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3D6EB64D9
	for <linux-ide@archiver.kernel.org>; Thu, 15 Jun 2023 09:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbjFOJ2y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 15 Jun 2023 05:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244584AbjFOJ2f (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jun 2023 05:28:35 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FCBD1FC2;
        Thu, 15 Jun 2023 02:28:34 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1q9jHN-0005NH-00; Thu, 15 Jun 2023 11:28:33 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id DCCC8C02FB; Thu, 15 Jun 2023 11:11:12 +0200 (CEST)
Date:   Thu, 15 Jun 2023 11:11:12 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: octeon: Fix cvmx_writeq_csr/cvmx_readq_csr on
 32-bit builds
Message-ID: <20230615091112.GA8680@alpha.franken.de>
References: <20230614173633.2430653-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614173633.2430653-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Jun 14, 2023 at 11:36:31AM -0600, Rob Herring wrote:
> Test 32-bit builds have an error in cvmx_writeq_csr/cvmx_readq_csr:
> 
> arch/mips/include/asm/octeon/cvmx.h:282:24: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
> 
> As the default for allyesconfig/allmodconfig is 32-bit, fixing these
> functions for 32-bit is needed to enable Cavium Octeon drivers for
> COMPILE_TEST.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/mips/include/asm/octeon/cvmx.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
> index 72e775bf31e6..2265a92995a8 100644
> --- a/arch/mips/include/asm/octeon/cvmx.h
> +++ b/arch/mips/include/asm/octeon/cvmx.h
> @@ -279,7 +279,7 @@ static inline void cvmx_write_csr(uint64_t csr_addr, uint64_t val)
>  
>  static inline void cvmx_writeq_csr(void __iomem *csr_addr, uint64_t val)
>  {
> -	cvmx_write_csr((__force uint64_t)csr_addr, val);
> +	cvmx_write_csr((__force uintptr_t)csr_addr, val);
>  }
>  
>  static inline void cvmx_write_io(uint64_t io_addr, uint64_t val)
> @@ -296,7 +296,7 @@ static inline uint64_t cvmx_read_csr(uint64_t csr_addr)
>  
>  static inline uint64_t cvmx_readq_csr(void __iomem *csr_addr)
>  {
> -	return cvmx_read_csr((__force uint64_t) csr_addr);
> +	return cvmx_read_csr((__force uintptr_t) csr_addr);
>  }
>  
>  static inline void cvmx_send_single(uint64_t data)
> -- 
> 2.39.2

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
