From: Marcin Kuk <marcin.kuk@gmail.com>
Subject: Re: toshiba ide - ide dma setting
Date: Tue, 8 Feb 2005 22:57:53 +0100
Message-ID: <28d670ae0502081357acc70ae@mail.gmail.com>
References: <28d670ae0502081139464d51c@mail.gmail.com>
	 <58cb370e050208124447c7b1e@mail.gmail.com>
	 <28d670ae0502081341467eb64f@mail.gmail.com>
Reply-To: Marcin Kuk <marcin.kuk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from rproxy.gmail.com ([64.233.170.198]:26615 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261644AbVBHV5z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2005 16:57:55 -0500
Received: by rproxy.gmail.com with SMTP id c51so1111109rne
        for <linux-ide@vger.kernel.org>; Tue, 08 Feb 2005 13:57:54 -0800 (PST)
In-Reply-To: <28d670ae0502081341467eb64f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> Have you tried "Generic PCI IDE Chipset Support" ?

I thing that you are about:
generic / default IDE chipset support (kernel 2.6.10) ?
Probably in 2.4 series the name was as you quoted.
Yes. This option was compiled in kernel.

All kernels were compiled with setting all chipsets.
I cared about set all of options responsible for IDE.
All IDE drivers was compiled into kernel (not modules).

Part of my last config (2.6.10):
......
#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
.....
#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_OPTI621=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_ATIIXP=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=y
CONFIG_BLK_DEV_CY82C693=y
CONFIG_BLK_DEV_CS5520=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
CONFIG_HPT34X_AUTODMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_SC1200=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_NS87415=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_IDE_CHIPSETS=y

I think that the solution of my problem is here:
http://marc.theaimsgroup.com/?l=linux-ide&m=109967556605057&w=2
and here is your response:
http://marc.theaimsgroup.com/?l=linux-ide&m=109969178814722&w=2

"AFAICS this option allows users to use generic code for
unknown/unsupported devices which can result in unpredictable results
(hangs, data corruptions)." BZ

So I tried to apply this patch to 2.6.10rc1 kernel but there was a
problem to compile it. I couldn't compile even clean 2.6.10rc1 without
this patch.
I analised this patch and changed manualy
drivers/ide/pci/generic.c
drivers/ide/pci/generic.h
from vanilla 2.6.10.
And ... nothing happend. The kernel was compiled cleanly without
errors, but this didn't solve my problem.

Any suggestion?

Marcin Kuk
