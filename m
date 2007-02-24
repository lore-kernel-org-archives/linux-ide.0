From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: Patch: slight shrink of vt6421_init_addrs()
Date: Sat, 24 Feb 2007 08:23:41 +0800
Message-ID: <20070224082341.A12719@freya>
References: <20070216194656.A4375@freya> <45DEC22B.3010005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [61.48.52.181] ([61.48.52.181]:49986 "EHLO freya.yggdrasil.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933297AbXBXAiK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Feb 2007 19:38:10 -0500
Content-Disposition: inline
In-Reply-To: <45DEC22B.3010005@pobox.com>; from jgarzik@pobox.com on Fri, Feb 23, 2007 at 05:30:03AM -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

On Fri, Feb 23, 2007 at 05:30:03AM -0500, Jeff Garzik wrote:
> Adam J. Richter wrote:
> > Hi Tejun and Jeff,
> > 
> > 	The discussion about the vt6421 problems caused me to glance
> > at the code and try a very minor clean-up to vt6421_init_addrs().
> > Please note that I don't have a vt6421, so this patch is UNTESTED.
> > The patch does two things:
> > 
> > 	1. Elminate the bmdma_addr variable, which was only used once,
> > 	   in an assignment to a field also named bmdma_addr.  So having
> > 	   a separate variable served no documentary purpose.  This change
> > 	   causes the value to be computed a little later, so please make
> > 	   sure that that is OK.  The effect is just to make the source
> > 	   code one line smaller.  The binary size is unchanged by this
> > 	   modification, at least on my x86 configuration, which has
> > 	   SMP and lots of debugging options activated.
> > 
> > 	2. Add a variable ata_ports, to replace the six times the
> > 	   same value appeared to be computed.  I assume the compiler
> > 	   was smart enough to avoid most of the recomputation, but
> > 	   this change shrinks the .text by 7 bytes in my configuration,
> > 	   makes the routine more readable and reduces opportunities for
> > 	   typos.
> > 
> > 	If it looks OK to everyone, please forward it upstream as
> > appropriate.
> > 
> > Adam Richter
> 
> Patch seems OK in theory, except for two procedural stumbling blocks:
> 
> 1) always always always include a signed-off-by line in your kernel 
> patches.  see http://linux.yyz.us/patch-format.html or 
> Documentation/SubmittingPatches in the kernel tree.

OK.

> 2) this was stirred a bit more by recent changes, so a rediff + resend 
> would be appreciated

The original patch applies perfectly cleanly to 2.6.21-rc1-git1, and
compiles without complaint, but here is a rediff specifically against
2.6.21-rc1-git1, using "diff -up" and in "a/... vs. b/..." format,
just to be more conformant to the documents you mentioned.  If there
is some other tree you wanted me to diff against, just let me know.

By the way, your remark that there have been recent changes to
sata_via.c is at least a hopeful sign, as I was about to look into
why why the vt6420 fix did not get into Linus's "release candidate"
2.6.21-rc1 or the latest git snapshot, 2.6.21-rc1-git1.  If there is
still a problem vt6421, I patch that only fixes vt6420 I think would
still be a big improvement.  Anyhow, if you're using a different
sata_via.c, I'm guessing you're about to submit a fix along those
lines.

Anyhow, here is my attempt at closer conformance to the two sets of
instructions you mentioned.  For the benefit of anyone tracking this
thread by subject, I have not changed the subject line to the format
specified in http://linux.yyz.us/patch-format.html, but I expect
to use that format in the future.





        Developer's Certificate of Origin 1.1

        By making a contribution to this project, I certify that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

        (d) I understand and agree that this project and the contribution
            are public and that a record of the contribution (including all
            personal information I submit with it, including my sign-off) is
            maintained indefinitely and may be redistributed consistent with
            this project or the open source license(s) involved.

---

Signed-off-by: Adam J. Richter <adam@yggdrasil.com>


--- a/drivers/ata/sata_via.c	2007-02-21 18:22:08.000000000 +0800
+++ b/drivers/ata/sata_via.c	2007-02-24 07:44:20.000000000 +0800
@@ -407,16 +407,16 @@ static void vt6421_init_addrs(struct ata
 			      void __iomem * const *iomap, unsigned int port)
 {
 	void __iomem *reg_addr = iomap[port];
-	void __iomem *bmdma_addr = iomap[4] + (port * 8);
+	struct ata_ioports *ata_ports = &probe_ent->port[port];
 
-	probe_ent->port[port].cmd_addr = reg_addr;
-	probe_ent->port[port].altstatus_addr =
-	probe_ent->port[port].ctl_addr = (void __iomem *)
+	ata_ports->cmd_addr = reg_addr;
+	ata_ports->altstatus_addr =
+	ata_ports->ctl_addr = (void __iomem *)
 		((unsigned long)(reg_addr + 8) | ATA_PCI_CTL_OFS);
-	probe_ent->port[port].bmdma_addr = bmdma_addr;
-	probe_ent->port[port].scr_addr = vt6421_scr_addr(iomap[5], port);
+	ata_ports->bmdma_addr = iomap[4] + (port * 8);
+	ata_ports->scr_addr = vt6421_scr_addr(iomap[5], port);
 
-	ata_std_ports(&probe_ent->port[port]);
+	ata_std_ports(ata_ports);
 }
 
 static struct ata_probe_ent *vt6420_init_probe_ent(struct pci_dev *pdev)
