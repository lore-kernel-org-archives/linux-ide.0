From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] ia64: add pci_get_legacy_ide_irq() (was: [2.6 patch] let BLK_DEV_AMD74XX depend on X86)
Date: Fri, 12 Jan 2007 00:39:54 +0100
Message-ID: <20070111233954.GA7469@stusta.de>
References: <45A65C8A.9080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2659 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030304AbXAKXju (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2007 18:39:50 -0500
Content-Disposition: inline
In-Reply-To: <45A65C8A.9080601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 04:49:30PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Adrian Bunk wrote:
> > 
> > It's unlikely that this driver will ever be of any use on other
> > architectures.
> 
> It is already used on PPC.
> 
> [ see arch/powerpc/platforms/maple/pci.c:maple_pci_get_legacy_ide_irq() ]

You can call me surprised.

>...
> Does the following patch fix the problem?
>...

Yes, it fixes the compilation.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

