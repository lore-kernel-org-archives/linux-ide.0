From: Andy Warner <andyw@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Wed, 6 Oct 2004 21:47:46 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041006214746.A18793@florence.linkmargin.com>
References: <20041001123951.A23006@florence.linkmargin.com> <415DA2C0.3060600@pobox.com> <20041001141244.B23006@florence.linkmargin.com> <415DB03E.5090005@pobox.com> <20041004155647.A9589@florence.linkmargin.com> <4161BB01.5080607@pobox.com> <20041006173656.A18221@florence.linkmargin.com> <416496CC.4090105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:31909 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S269659AbUJGCtd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Oct 2004 22:49:33 -0400
Content-Disposition: inline
In-Reply-To: <416496CC.4090105@pobox.com>; from jgarzik@pobox.com on Wed, Oct 06, 2004 at 09:07:24PM -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> [...]
> > If they need to be called from a helper-thread, I can do
> > that - just looking for ground rules.
> 
> Correct, they must be called from process context.

Thanks for the confirmation - I can take it from there..
Does anyone have any opinions/advice about reusing existing
helper tasks ?

Also - I need help from someone with access to Promise
chip manuals. I have Silicon Image docs, and am able
to enable interrupts on PHY status changes by setting
the correct bit in the SEIN register(s). This patchette
shows what I do:

===== drivers/scsi/sata_sil.c 1.35 vs edited =====
--- 1.35/drivers/scsi/sata_sil.c	2004-09-16 01:45:15 -05:00
+++ edited/drivers/scsi/sata_sil.c	2004-10-06 21:20:42 -05:00
@@ -415,9 +415,10 @@
 	}
 
 	/* mask all SATA phy-related interrupts */
-	/* TODO: unmask bit 6 (SError N bit) for hotplug */
-	for (i = 0; i < probe_ent->n_ports; i++)
-		writel(0, mmio_base + sil_port[i].sien);
+	/* except (SError N bit) for hotplug */
+	for (i = 0; i < probe_ent->n_ports; i++) {
+		writel(SCR_DIAG_N, mmio_base + sil_port[i].sien);
+	}
 
 	pci_set_master(pdev);
 
[NOTE: SCR_DIAG_N is (1 << 16)]

If anyone can provide me with either the promise Tx2/4 docs,
or a corresponding patch for sata_promise.c, I'd be most
grateful.

The handling of the SATA error/status registers is all
standardised, and taken care of by me. I just need to
enable SATA PHY interrupts from the promise chips.

I can only test with SiI/Promise right now, I have Marvell
and 3124 hardware, but libata drivers for them are not
available yet (*please* correct me if I'm wrong.)
For anyone with access to the right docs, adding matching
functionality to sata_vsc.c etc will be trivial once I
get past calling scsi_add/remove_device() correctly.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
