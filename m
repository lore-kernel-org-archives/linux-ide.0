From: Jens Axboe <axboe@suse.de>
Subject: Re: sata_sil problem / oops
Date: Thu, 2 Jun 2005 21:30:38 +0200
Message-ID: <20050602193037.GB13964@suse.de>
References: <20050602100358.GA28855@suse.de> <200506021847.j52IlYi28562@epz01.nefonline.de> <20050602192327.GA13964@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:10638 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261255AbVFBT3m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jun 2005 15:29:42 -0400
Content-Disposition: inline
In-Reply-To: <20050602192327.GA13964@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniela Engert <dani@ngrt.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, meissner@suse.de, Jeff Garzik <jgarzik@pobox.com>

On Thu, Jun 02 2005, Jens Axboe wrote:
> On Thu, Jun 02 2005, Daniela Engert wrote:
> > On Thu, 2 Jun 2005 12:03:58 +0200, Marcus Meissner wrote:
> > 
> > >We see a problem in the sata_sil driver. The code looks like this:
> > >
> > >	 cls=sil_get_device_cache_line(pdev);
> > >	 cls >>= 3;
> > >	 cls++;  /* cls = (line_size/8)+1 */
> > >	 writeb(cls, mmio_base + SIL_FIFO_R0);
> > >	 writeb(cls, mmio_base + SIL_FIFO_W0);
> > >	 writeb(cls, mmio_base + SIL_FIFO_R1);
> > >	 writeb(cls, mmio_base + SIL_FIFO_W2);
> > >
> > >We have a device where mmio_base is only 0x200 byte long, so
> > >the access to SIL_FIFO_W2 (offset 0x241) causes an Oops.
> > >
> > >- Should it perhaps be W1 instead of W2?
> > >- If not, does it need a range check?
> > 
> > My OS/2 driver and the Windows driver write to the following locations:
> > 
> > SiI3112: BAR5+0x40, BAR5+0x41, BAR5+0x44, BAR5+0x45
> > SiI3114: BAR5+0x40, BAR5+0x41, BAR5+0x44, BAR5+0x45,
> > 	 BAR5+0x240, BAR5+0x241, BAR5+0x244, BAR5+0x245
> 
> Does the 3112 have two ports and the 3114 four?

Seems that is so, from looking at the driver. If I were to guess at a
fix for this, it would be as follows.

diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -432,7 +432,13 @@ static int sil_init_one (struct pci_dev 
 		writeb(cls, mmio_base + SIL_FIFO_R0);
 		writeb(cls, mmio_base + SIL_FIFO_W0);
 		writeb(cls, mmio_base + SIL_FIFO_R1);
-		writeb(cls, mmio_base + SIL_FIFO_W2);
+		writeb(cls, mmio_base + SIL_FIFO_W1);
+		if (ent->driver_data == sil_3114) {
+			writeb(cls, mmio_base + SIL_FIFO_R2);
+			writeb(cls, mmio_base + SIL_FIFO_W2);
+			writeb(cls, mmio_base + SIL_FIFO_R3);
+			writeb(cls, mmio_base + SIL_FIFO_W3);
+		}
 	} else
 		printk(KERN_WARNING DRV_NAME "(%s): cache line size not set.  Driver may not function\n",
 			pci_name(pdev));

-- 
Jens Axboe

