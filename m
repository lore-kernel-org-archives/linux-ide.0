From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] cy82c693: fix PCI device selection
Date: Wed, 12 Oct 2011 16:52:10 +0200
Message-ID: <201110121652.10495.bzolnier@gmail.com>
References: <201110111937.32501.bzolnier@gmail.com> <20111011.152040.662786307819949300.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111011.152040.662786307819949300.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

David Miller wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Tue, 11 Oct 2011 19:37:32 +0200
> 
> > While at it remove redundant pci_get_slot() call as cy82c693_init_one()
> > already takes care of keeping the reference on the second port's PCI
> > device.
> 
> Please do not submit unrelated changes with a bug fix, and as IDE is
> in long-term maintainence I would not accept a risky refinement like
> this anyways.

Removed code is just bogus, we cannot fail in ->set_pio_mode method.

Please take a look at the code:
 
-	/* select primary or secondary channel */
-	if (hwif->index > 0) {  /* drive is on the secondary channel */
-		dev = pci_get_slot(dev->bus, dev->devfn+1);
-		if (!dev) {
-			printk(KERN_ERR "%s: tune_drive: "
-				"Cannot find secondary interface!\n",
-				drive->name);
-			return;
-		}
-	}

Please apply the patch, libata's pata_cypress doesn't support secondary
port currently and cy82c693 driver is the only way to use this hardware.
