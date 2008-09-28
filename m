From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2] IDE: Fix platform device registration in Swarm IDE
 driver
Date: Mon, 29 Sep 2008 01:51:30 +0400
Message-ID: <48DFFC62.9050300@ru.mvista.com>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com> <200809271859.55304.bzolnier@gmail.com> <20080928113931.GA9207@linux-mips.org> <20080928175450.GA8478@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:16333 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752732AbYI1Vvh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Sep 2008 17:51:37 -0400
In-Reply-To: <20080928175450.GA8478@linux-mips.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org

Hello.

Ralf Baechle wrote:

> The Swarm IDE driver uses a release method which is defined in the driver
> itself thus potentially oopsable.  The simple fix would be to just leak
> the device but this patch goes the full length and moves the entire
> handling of the platform device in the platform code and retains only
> the platform driver code in drivers/ide/mips/swarm.c.
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: linux-mips/arch/mips/sibyte/swarm/platform.c
> ===================================================================
> --- /dev/null
> +++ linux-mips/arch/mips/sibyte/swarm/platform.c
> @@ -0,0 +1,81 @@
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/ata_platform.h>
> +
> +#include <asm/sibyte/board.h>
> +#include <asm/sibyte/sb1250_genbus.h>
> +#include <asm/sibyte/sb1250_regs.h>
> +
> +#define DRV_NAME	"pata-swarm"
>   

   Hm, what driver? This is just a platform code. :-)

> +
> +#define SWARM_IDE_SHIFT	5
> +#define SWARM_IDE_BASE	0x1f0
> +#define SWARM_IDE_CTRL	0x3f6
> +
> +static struct resource swarm_pata_resource[] = {
> +	{
> +		.name	= "Swarm GenBus IDE",
> +		.flags	= IORESOURCE_MEM,
> +	}, {
> +		.name	= "Swarm GenBus IDE",
> +		.flags	= IORESOURCE_MEM,
> +	}, {
> +		.name	= "Swarm GenBus IDE",
> +		.flags	= IORESOURCE_IRQ,
> +		.start	= K_INT_GB_IDE,
> +		.end	= K_INT_GB_IDE,
>   

   Giving the resources similar names is pointless. You can just leave 
the 'name' field uninitialized.

MBR, Sergei


