From: Jens Axboe <axboe@suse.de>
Subject: Re: sata_sil: Fix FIFO PCI Bus Arbitration KERNEL OOPS!
Date: Wed, 8 Jun 2005 13:02:25 +0200
Message-ID: <20050608110225.GD18490@suse.de>
References: <200506081234.14415.navarro_ser@gva.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:3007 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262164AbVFHLBl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2005 07:01:41 -0400
Content-Disposition: inline
In-Reply-To: <200506081234.14415.navarro_ser@gva.es>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergio Navarro i Fajardo <navarro_ser@gva.es>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Wed, Jun 08 2005, Sergio Navarro i Fajardo wrote:
> Hi!
> Kernel 2.6.12-rc5 includes patch references on mail:
> --
> Re: [RFT, PATCH] sata_sil corruption / lockup fix
> http://marc.theaimsgroup.com/?l=linux-ide&m=111818249232162&w=2
> [PATCH] sata_sil: Fix FIFO PCI Bus Arbitration
> --
> But, this patch produces an oops on load modules sata_sil on my system:
> sata_sil version 0.9

Please try with attached patch.

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

