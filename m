From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH] AHCI: Fix threaded interrupt setup
Date: Mon, 27 Oct 2014 13:20:49 +0000
Message-ID: <20141027132045.GA30198@agordeev.usersys.redhat.com>
References: <1414082970-20775-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52442 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836AbaJ0NMr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2014 09:12:47 -0400
Content-Disposition: inline
In-Reply-To: <1414082970-20775-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Tejun Heo <tj@kernel.org>, linux-sunxi@googlegroups.com, linux-ide@vger.kernel.org

On Thu, Oct 23, 2014 at 05:49:30PM +0100, Marc Zyngier wrote:
> Commit 18dcf433f3de (AHCI: Optimize single IRQ interrupt processing)
> switched the single IRQ case of the AHCI driver to use threaded
> threaded interrupts.
> 
> During this conversion, only the IRQF_SHARED flag was provided. The net
> effect of this in the presence of level interrupts is that the
> interrupt will not be masked during the execution of the treaded
> handler, leading to a screaming interrupt if the thread is not
> scheduled quickly enough, specially in error conditions:

[...]

> Not good. The culprit is a missing IRQF_ONESHOT flag, which addition
> solves the problem entierly. The number of interrupts drops radically:

I worried how many devices hanging off the same IRQ line in legacy mode
would fail to initialize after this update due to IRQF_ONESHOT mismatch.

Given that I did not observe nor anticipate this kind of problem and
LKP test shows a perf drop I am thinking may be we need to revert 18dcf43
for now.

Tejun?

> [Booting Debian Jessie to a prompt]
> Before fix:
>  88:       3562          0       GIC  88  ahci-sunxi
> After fix:
>  88:       1992          0       GIC  88  ahci-sunxi
> 
> Tested on a A20 board (ahci-sunxi).
> 
> Cc: Alexander Gordeev <agordeev@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/ata/libahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 5eb61c9..49c649f 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2492,7 +2492,7 @@ static int ahci_host_activate_single_irq(struct ata_host *host, int irq,
>  		return rc;
>  
>  	rc = devm_request_threaded_irq(host->dev, irq, ahci_single_irq_intr,
> -				       ahci_thread_fn, IRQF_SHARED,
> +				       ahci_thread_fn, IRQF_SHARED | IRQF_ONESHOT,
>  				       dev_driver_string(host->dev), host);
>  	if (rc)
>  		return rc;
> -- 
> 2.0.4
> 

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
