From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH 2.6.14.3] Necessary evil to get sata_vsc to initialize with Intel iq3124h hba
Date: Wed, 4 Jan 2006 23:57:32 -0800
Message-ID: <20060105075732.GA323621@sgi.com>
References: <20051214201049.GA20640@dwillia2-linux.ch.intel.com> <20051218091904.GA39033@sgi.com> <e9c3a7c20512271127v36eb56c9m54568a79784412e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx3-ext.sgi.com ([192.48.171.26]:198 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1752109AbWAEH5j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jan 2006 02:57:39 -0500
Content-Disposition: inline
In-Reply-To: <e9c3a7c20512271127v36eb56c9m54568a79784412e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tue, Dec 27, 2005 at 12:27:57PM -0700, Dan Williams wrote:
> On 12/18/05, Jeremy Higdon <jeremy@sgi.com> wrote:
> >
> > I don't think I fully understand the problem you're trying to solve, but
> > the gist seems to be that you're taking endless interrupts even when
> > ATA_NIEN is set.
> Yes...
> 
> > So you add the dummy ata_chk_status call to clear
> > interrupts that the libata core isn't interested in.  But ata_chk_status
> > doesn't actually clear it unless you first write to the SCR_ERROR
> > register above?
> 
> Actually I added the dummy ata_chk_status because just clearing the
> SCR_ERROR bits did not stop the stream of interrupts.  Upon further
> investigation it appears that clearing the SCR_ERRORS is not
> _required_ and all that is necessary is the ata_chk_status() call. 
> however not clearing the SCR_ERROR results in the error interrupt
> recurring everytime the disk is accessed.
> 
> For example:
> vsc_sata_interrupt: clearing interrupt, status 30383; sata err status 50002
> vsc_sata_interrupt: clearing interrupt, status 30383; sata err status 50002
> Adding 136512k swap on /dev/sda1.  Priority:-1 extents:1 across:136512k
> vsc_sata_interrupt: clearing interrupt, status 38303; sata err status 50002
> vsc_sata_interrupt: clearing interrupt, status 38303; sata err status 50002
> Adding 125456k swap on /dev/sdb1.  Priority:-2 extents:1 across:125456k
> vsc_sata_interrupt: clearing interrupt, status 830303; sata err status 50002
> vsc_sata_interrupt: clearing interrupt, status 830303; sata err status 50002
> Adding 136512k swap on /dev/sdc1.  Priority:-3 extents:1 across:136512k
> 
> > FWIW, on my Vitesse chip, the int_status and SCR_ERROR bits that are set and
> > when this code is called this code are 0x83 and 0x50002, respectively.  But
> > not clearing them doesn't seem to cause a problem . . . this must be different
> > behavior in your chip (presumably the Intel branch).
> 
> Yes, with your patch I get the same output, perhaps the Vitesse part
> does not tie these bits to the error interrupt, or they are masked by
> default?

Dan, please trim trailing whitespace from your patch, if you would.  Other
than that, your patch to sata_vsc.c and Kconfig looks fine to me.  I'm not sure
about the patch to libata-scsi.c, but jgarzik can review that one.

I checked both the Intel and Vitesse documentation, and they both indicate
that the error interrupts are masked by default.  Perhaps your PROM/BIOS
software is enabling them.  Ours does not, and the sata_vsc driver doesn't
either.  Perhaps it should -- though since we're just ignoring them, that
doesn't make much sense.  Maybe we should explicitly mask them off?  Or
explicitly enable them, rather than leaving the chip in whatever state
the PROM/BIOS leaves it.  Perhaps this patch is all you really need.
Can you try it?

--- linux-2.6.15/drivers/scsi/sata_vsc.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15-mask/drivers/scsi/sata_vsc.c	2006-01-04 23:55:16.000000000 -0800
@@ -108,9 +108,9 @@
 		VSC_SATA_INT_MASK_OFFSET + ap->port_no;
 	mask = readb(mask_addr);
 	if (ctl & ATA_NIEN)
-		mask |= 0x80;
+		mask = 0x80;
 	else
-		mask &= 0x7F;
+		mask = 0;
 	writeb(mask, mask_addr);
 }
 

jeremy
