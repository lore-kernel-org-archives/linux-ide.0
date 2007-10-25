From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [IDE] Fix build bug
Date: Thu, 25 Oct 2007 23:41:38 +0200
Message-ID: <200710252341.38902.bzolnier@gmail.com>
References: <20071025135334.GA23272@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:56119 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836AbXJYVql (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 17:46:41 -0400
Received: by nf-out-0910.google.com with SMTP id g13so609597nfb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 14:46:39 -0700 (PDT)
In-Reply-To: <20071025135334.GA23272@linux-mips.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mips@linux-mips.org, Martijn Uffing <mp3project@sarijopen.student.utwente.nl>


Hi,

On Thursday 25 October 2007, Ralf Baechle wrote:
>   CC      drivers/ide/pci/generic.o
> drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
> +section type conflict
> 
> This sort of build error is becoming a regular issue.  Either all or non
> of the elements that go into a particular section of a compilation unit
> need to be const.  Or an error may result such as in this case if
> CONFIG_HOTPLUG is unset.
> 
> Maybe worth a check in checkpatch.pl - but certainly gcc's interolerance
> is also being less than helpful here.
> 
> ---
>  drivers/ide/pci/generic.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
> index f44d708..0047684 100644
> --- a/drivers/ide/pci/generic.c
> +++ b/drivers/ide/pci/generic.c
> @@ -67,7 +67,7 @@ MODULE_PARM_DESC(all_generic_ide, "IDE generic will claim all unknown PCI IDE st
>  		.udma_mask	= ATA_UDMA6, \
>  	}
>  
> -static const struct ide_port_info generic_chipsets[] __devinitdata = {
> +static struct ide_port_info generic_chipsets[] __devinitdata = {
>  	/*  0 */ DECLARE_GENERIC_PCI_DEV("Unknown",	0),
>  
>  	{	/* 1 */

I would prefer to not remove const from generic_chipsets[] so:

[PATCH] drivers/ide/pci/generic: fix build for CONFIG_HOTPLUG=n

It turns out that const and __{dev}initdata cannot be mixed currently
and that generic IDE PCI host driver is also affected by the same issue:

On Thursday 25 October 2007, Ralf Baechle wrote:
>   CC      drivers/ide/pci/generic.o
> drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
> +section type conflict

[ Also reported by Martijn Uffing <mp3project@sarijopen.student.utwente.nl>. ]

This patch workarounds the problem in a bit hackish way but without
removing const from generic_chipsets[] (it adds const to __setup() so
__setup_str_ide_generic_all becomes const).

Now all __{dev}initdata data in generic IDE PCI host driver are read-only
so it builds again (driver's .init.data section gets marked as READONLY).

Cc: Martijn Uffing <mp3project@sarijopen.student.utwente.nl>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/pci/generic.c
===================================================================
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -49,7 +49,7 @@ static int __init ide_generic_all_on(cha
 	printk(KERN_INFO "IDE generic will claim all unknown PCI IDE storage controllers.\n");
 	return 1;
 }
-__setup("all-generic-ide", ide_generic_all_on);
+const __setup("all-generic-ide", ide_generic_all_on);
 #endif
 module_param_named(all_generic_ide, ide_generic_all, bool, 0444);
 MODULE_PARM_DESC(all_generic_ide, "IDE generic will claim all unknown PCI IDE storage controllers.");
