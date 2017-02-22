From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
Subject: Re: [PATCH 2/2] ide-generic: added messages in case of PCI IDE
 devices
Date: Tue, 21 Feb 2017 21:38:31 -0300
Message-ID: <20170222003831.GA14251@giustizia>
References: <20170221142249.GC11234@giustizia>
 <418946e5-38e6-ca97-fce1-543988a5f06d@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm44-vm9.bullet.mail.bf1.yahoo.com ([216.109.115.45]:34980 "EHLO
        nm44-vm9.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752298AbdBVAih (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Feb 2017 19:38:37 -0500
Content-Disposition: inline
In-Reply-To: <418946e5-38e6-ca97-fce1-543988a5f06d@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Miller <davem@davemloft.net>, petkovbb@gmail.com

Hello, Sergei!

I have a question or two about checkpatch.pl results below.

On Tue, Feb 21, 2017 at 06:52:13PM +0300, Sergei Shtylyov wrote:
> On 02/21/2017 05:22 PM, Luiz Carlos Ramos wrote:
> 
> >Two messages are now displayed (at "warn" level) to make sure the user
> >is aware that PCI IDE devices were detected at common addresses (0x1f0
> >and 0x170) and that they will not be managed by ide-generic, but rather
> >delegated to its specific driver.
> >
> >Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> >---
> > drivers/ide/ide-generic.c | 10 ++++++++++
> > 1 file changed, 10 insertions(+)
> >
> >diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
> >index ee11edcdba3170c077381d603918498d79ffa3bb..2204819ef73612deed4ebfe58c69cdadb40fa53b 100644
> >--- a/drivers/ide/ide-generic.c
> >+++ b/drivers/ide/ide-generic.c
> >@@ -125,9 +125,19 @@ static int __init ide_generic_init(void)
> >
> > 		if (primary == 0)
> > 			probe_mask |= 0x1;
> >+		else {
> >+			printk(KERN_WARN DRV_NAME ": PCI IDE device detected at 0x%4.4x."
> 
>    Also, please use pr_warn().
> 

This code is quite old, and it is in deep maintenance phase.

Every other message in ide-generic.c is implemented as printk(...),
but to be fair, there are not so many of them.

Given that fact, would it be better to change these two ones to be
inserted to pr_warn() as suggested (and then having a mix of printk()
and pr_warn() in the code), or to "allow" two more printk() in the code
and having checkpatck.pl complaining?

I really don't know what is better or worse. Both can be implemented,
and there are a mix of advantages and disadvantages in each side.

I'd like to hear from you and colleagues about how to proceed.

> >+			     " ide-generic will not grab this device, delegating it to"
> >+			     " the driver of its specific chipset\n", 0x1f0);
> >+		}
> >
> > 		if (secondary == 0)
> > 			probe_mask |= 0x2;
> >+		else {
> >+			printk(KERN_WARN DRV_NAME ": PCI IDE device detected at 0x%4.4x."
> 
>    Likewise.
> 
> >+			     " ide-generic will not grab this device, delegating it to"
> >+			     " the driver of its specific chipset\n", 0x170);
> >+		}
> > 	} else
> > 		printk(KERN_INFO DRV_NAME ": enforcing probing of I/O ports "
> > 			"upon user request\n");
> 
> MBR, Sergei
> 

Best regards,

Luiz Carlos Ramos

