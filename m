From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.27-rc3: IP: [<ffffffffa0038b77>] init_irq+0x18d/0x31c [ide_core]
Date: Mon, 25 Aug 2008 21:11:22 +0200
Message-ID: <200808252111.22940.bzolnier@gmail.com>
References: <20080820173122.GA7335@deprecation.cyrius.com> <48ADAC7C.7040003@lwfinger.net> <20080825110241.GI2606@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:54755 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434AbYHYUcH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Aug 2008 16:32:07 -0400
Received: by yx-out-2324.google.com with SMTP id 8so960515yxm.1
        for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 13:32:07 -0700 (PDT)
In-Reply-To: <20080825110241.GI2606@deprecation.cyrius.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org

On Monday 25 August 2008, Martin Michlmayr wrote:
> * Larry Finger <Larry.Finger@lwfinger.net> [2008-08-21 12:57]:
> > Do you have a git tree, or have you downloaded snapshots? If the
> > former, a bisection would be useful.
> 
> I've bisected it down to this change: ide: set hwif->dev in ide_init_port_hw() (take 2)
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c56c5648a3bd15ff14c50f284b261140cd5b5472

Thanks for tracing it down and sorry for the bug.

> I cannot revert this from current git because there were too many
> changes but when I go to 5b664cb235e97afbf34db9c4d77f08ebd725335e (a
> random point that shows the oops) and apply the following (which is
> basically a partial revert of the c56c5648a3bd15ff14c50f284b261140cd5b5472)
> then it works:
> 
> --- a/drivers/ide/ide.c
> +++ b/drivers/ide/ide.c
> @@ -284,7 +284,6 @@ void ide_init_port_hw(ide_hwif_t *hwif, hw_regs_t *hw)
>  	memcpy(&hwif->io_ports, &hw->io_ports, sizeof(hwif->io_ports));
>  	hwif->irq = hw->irq;
>  	hwif->chipset = hw->chipset;
> -	hwif->dev = hw->dev;
>  	hwif->gendev.parent = hw->parent ? hw->parent : hw->dev;
>  	hwif->ack_intr = hw->ack_intr;
>  }
> diff --git a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
> index 65fc08b..187b7b1 100644
> --- a/drivers/ide/setup-pci.c
> +++ b/drivers/ide/setup-pci.c
> @@ -339,6 +339,8 @@ static ide_hwif_t *ide_hwif_configure(struct pci_dev *dev,
>  
>  	ide_init_port_hw(hwif, &hw);
>  
> +	hwif->dev = &dev->dev;
> +
>  	return hwif;
>  }

Unfortunately we cannot apply the partial revert either because it
will break device tree registration for non-PCI/PCMCIA controllers
(+ we really want to have PCMCIA controllers registered with the
device tree).

Hmm, I suspect that the root cause of the problem is actually in
hwif_to_node() assuming that hwif->dev always belongs to a PCI device.

Does the following patch help?

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix hwif_to_node()

hwif_to_node() incorrectly assumes that hwif->dev always belongs to
a PCI device.  This results in ide-cs oopsing in init_irq() after
commit c56c5648a3bd15ff14c50f284b261140cd5b5472 accidentally fixed
device tree registration for ide-cs.  Fix it by using dev_to_node().

Thanks to Martin Michlmayr and Larry Finger for help with debugging
the issue.

Reported-by: Martin Michlmayr <tbm@cyrius.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1448,8 +1448,7 @@ static inline void ide_dump_identify(u8 
 
 static inline int hwif_to_node(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	return hwif->dev ? pcibus_to_node(dev->bus) : -1;
+	return hwif->dev ? dev_to_node(hwif->dev) : -1;
 }
 
 static inline ide_drive_t *ide_get_paired_drive(ide_drive_t *drive)
