From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
Subject: Re: [PATCH] Fix interface autodetection in legacy IDE driver
Date: Tue, 9 Aug 2016 20:51:07 -0300
Message-ID: <20160809235107.GA11332@giustizia>
References: <1370547790.13391287.1470739631878.JavaMail.yahoo.ref@mail.yahoo.com>
 <1370547790.13391287.1470739631878.JavaMail.yahoo@mail.yahoo.com>
 <041bab68-35ac-a319-e353-a48ce43eafb8@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm23-vm1.bullet.mail.bf1.yahoo.com ([98.139.213.141]:59778 "EHLO
	nm23-vm1.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750909AbcHIX4p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Aug 2016 19:56:45 -0400
Content-Disposition: inline
In-Reply-To: <041bab68-35ac-a319-e353-a48ce43eafb8@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Sergei:

Many thanks for your patience and careful review! I apologize for
those mistakes.

Here I'll send a hopefully corrected version:





This patch fixes the automatic setting of ide_generic.probe_mask,
when it is set to zero (like when default options are used) AND
the PCI subsystem has detected primary and/or secondary interfaces.

The effect is that those IDE interfaces go undetected under those
conditions.

The former implementation misunderstands the information detected by
the PCI subsystem, and may only work if one use ide_generic.probe_mask
set to 0x3f (or 0x03, minimally), like the suggestion echoed to the
console.

Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
---
 drivers/ide/ide-generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
index 54d7c4685d23aa5e62ce606e7b994a57bb54b08a..419818a39c270d3ad219e8f7b5df56a9aea3d640 100644
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -96,10 +96,10 @@ static int __init ide_generic_init(void)
 		printk(KERN_INFO DRV_NAME ": please use \"probe_mask=0x3f\" "
 		     "module parameter for probing all legacy ISA IDE ports\n");
 
-		if (primary == 0)
+		if (primary)
 			probe_mask |= 0x1;
 
-		if (secondary == 0)
+		if (secondary)
 			probe_mask |= 0x2;
 	} else
 		printk(KERN_INFO DRV_NAME ": enforcing probing of I/O ports "
-- 
2.8.2



On Tue, Aug 09, 2016 at 04:50:15PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 08/09/2016 01:47 PM, lramos.prof@yahoo.com.br wrote:
> 
> >This patch fixes the automatic setting of ide_generic.probe_mask,
> >when it is set to zero (like when default options are used) AND
> >the PCI subsystem has detected primary and/or secondary interfaces.
> >
> >The effect is that those interfaces go undetected under those
> >conditions.
> >
> >The former implementation misunderstands the information detected by
> >the PCI subsystem, and may only work if one use ide_generic.probe_mask
> >set to 0x3f (or 0x03, minimally), like the suggestion echoed to the
> >console.
> >
> >Probably this has been stayed under the radar because everybody
> 
>    Has stayed, maybe?
> 
> >migrated to libata. Anyway, IMHO it's worth to fix it, as the code isn't
> >entirely dead.
> >
> >If I'm not wrong, this change applies to kernels from 2009 up to now.
> >
> >Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> >---
> >diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
> >index 54d7c4685d23aa5e62ce606e7b994a57bb54b08a..419818a39c270d3ad219e8f7b5df56a9aea3d640 100644
> >--- a/drivers/ide/ide-generic.c
> >+++ b/drivers/ide/ide-generic.c
> >@@ -96,10 +96,10 @@ static int __init ide_generic_init(void)
> >printk(KERN_INFO DRV_NAME ": please use \"probe_mask=0x3f\" "
> >"module parameter for probing all legacy ISA IDE ports\n");
> >
> >-               if (primary == 0)
> >+               if (primary)
> >probe_mask |= 0x1;
> 
>    Your patch is line wrapped...
> 
> >
> >-               if (secondary == 0)
> >+               if (secondary)
> >probe_mask |= 0x2;
> >} else
> >printk(KERN_INFO DRV_NAME ": enforcing probing of I/O ports "
> 
>    ... and whitespace damaged too. :-(
> 
> MBR, Sergei
> 
