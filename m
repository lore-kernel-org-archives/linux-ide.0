From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 2/7] S3C64XX: Add MEM_SYS_CFG register definition.
Date: Sun, 1 Nov 2009 13:02:28 +0000
Message-ID: <20091101130228.GH8096@trinity.fluff.org>
References: <1257051031-8074-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:43857 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614AbZKANCZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Nov 2009 08:02:25 -0500
Content-Disposition: inline
In-Reply-To: <1257051031-8074-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: ben-linux@fluff.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Nov 01, 2009 at 01:50:31PM +0900, Thomas Abraham wrote:
> This patch adds the definition of MEM_SYS_CFG register for
> S3C64xx platform.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/include/plat/regs-clock.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
> index 2c3224c..ad0823e 100644
> --- a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
> +++ b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
> @@ -15,6 +15,8 @@
>  #ifndef __PLAT_REGS_CLOCK_H
>  #define __PLAT_REGS_CLOCK_H __FILE__
>  
> +#include <plat/map-base.h>
> +

Why are you adding <plat/map-base.h> here?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

