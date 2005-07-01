From: Tejun <htejun@gmail.com>
Subject: Re: [PATCH Linux 2.6.12 00/09] NCQ: generic NCQ completion/error-handling
Date: Fri, 1 Jul 2005 09:20:35 +0900
Message-ID: <20050701002035.GA24878@htj.dyndns.org>
References: <20050626152105.D86561FB@htj.dyndns.org> <20050627143344.GI11633@suse.de> <20050630073633.GF2243@suse.de> <42C3CEA5.9040509@gmail.com> <20050630152620.GZ2243@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:18397 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263146AbVGAAUq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jun 2005 20:20:46 -0400
Received: by wproxy.gmail.com with SMTP id i11so219541wra
        for <linux-ide@vger.kernel.org>; Thu, 30 Jun 2005 17:20:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20050630152620.GZ2243@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Thu, Jun 30, 2005 at 05:26:20PM +0200, Jens Axboe wrote:
> On Thu, Jun 30 2005, Tejun Heo wrote:
> > Jens Axboe wrote:
> > >On Mon, Jun 27 2005, Jens Axboe wrote:
> > >
> > >>On Mon, Jun 27 2005, Tejun Heo wrote:
> > >>
> > >>>Hello, Jeff.
> > >>>Hello, Jens.
> > >>>
> > >>>This patchset implements generic completion and error-handling for
> > >>>NCQ commands.  This patchset assumes that the previous six misc
> > >>>patches to NCQ are applied.
> > >>
> > >>Excellent, much needed work in that area. I will give it a test spin
> > >>here as well, I have one drive that likes to barf with ncq occasionally.
> > >
> > >
> > >Ok, I've run with this for a few days and finally hit the
> > >drive-stops-responding condition yesterday afternoon. Error recovery
> > >worked a lot better than before, but eventually went down anyways. But
> > >now I got a better look at the error, and it's the drive throwing an
> > >ICRC (error 0x80). Very odd. I've never seen this happen with non-NCQ
> > >operations, however I've seen it now a few times using NCQ. Any ideas?
> > >
> > 
> >  Hello, Jens.
> > 
> >  Can you please describe how the drive went down in detail?  If 
> > possible, log messages w/ the debug message patch applied would be 
> > great.  As the EH now resets both the controller (on entry to EH) and 
> > the drive (on timeout), we should be able to recover unless something 
> > goes very strange.
> 
> I'm pretty sure it wasn't the fault of the error handling, although I
> cannot say for sure of course. I don't have the log safed, but what
> happened was that the drive threw an 0x80 icrc error, drive was
> COMRESET, io was errored, and then nothing happened after that. Access
> to the drive hung.
> 
> I will save the log the next time it occurs, I could not this time since
> I was working on the machine remotely and needed it rebooted.
> 
> >  I'm currently trying to rewrite sil24 driver to make it look saner and 
> > support NCQ.  Once I'm done with it (maybe one or two more days... I 
> > hope), I'll do the second take of generic NCQ patches including ATAPI EH 
> > fix and stuff and it would be great to have your failure log message 
> > before doing that.
> 
> It should trigger again within a day or two, I will send it when it
> does. Can you resend the debug patch?
> 
> -- 
> Jens Axboe


 Hi, Jens.

 I converted most of debug messages I've used during development into
warning messages when posting the patchset and forgot about it, so
I've never posted the debug patch.  Sorry about that.  Here's a small
patch which adds some more messages though.  The following patch also
adds printk'ing FIS on each command issue in ahci.c:ahci_qc_issue(),
if you think it would fill your log excessively, feel free to turn it
off.  It wouldn't probably matter anyway.


Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-07-01 08:41:17.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-07-01 09:18:34.000000000 +0900
@@ -635,8 +635,14 @@ static inline int ahci_host_intr(struct 
 		if (ap->sactive ||
 		    (readl(cmd_issue) & (1 << ap->active_tag)) == 0)
 			ata_ncq_complete(ap);
-	} else
+	} else {
+		printk("AHCI: ata%u: error irq, status=%08x stat=%02x err=%02x sstat=%08x serr=%08x\n",
+		       ap->id, status,
+		       ahci_check_status(ap), ahci_check_err(ap),
+		       readl(port_mmio + PORT_SCR_STAT),
+		       readl(port_mmio + PORT_SCR_ERR));
 		ata_ncq_abort(ap);
+	}
 
 	return 1;
 }
@@ -696,6 +702,15 @@ static int ahci_qc_issue(struct ata_queu
 	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
 	unsigned int tag = ata_qc_to_tag(qc);
 
+#if 1
+	{
+		struct ahci_port_priv *pp = qc->ap->private_data;
+		unsigned *fis = pp->cmd_tbl + (tag * AHCI_CMD_TOTAL);
+		printk("AHCI: ata%u: FIS(tag%02u): %08x %08x %08x %08x %08x\n",
+		       ap->id, tag, fis[0], fis[1], fis[2], fis[3], fis[4]);
+	}
+#endif
+
 	if (qc->flags & ATA_QCFLAG_NCQ) {
 		writel(1 << tag, port_mmio + PORT_SCR_ACT);
 		readl(port_mmio + PORT_SCR_ACT);
Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-07-01 08:41:17.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-07-01 08:49:42.000000000 +0900
@@ -1485,6 +1485,7 @@ void __sata_phy_reset(struct ata_port *a
 	}
 	scr_write_flush(ap, SCR_CONTROL, 0x300); /* phy wake/clear reset */
 
+	printk("ata%u: started resetting...\n", ap->id);
 	/* wait for phy to become ready, if necessary */
 	do {
 		msleep(200);
@@ -1492,6 +1493,7 @@ void __sata_phy_reset(struct ata_port *a
 		if ((sstatus & 0xf) != 1)
 			break;
 	} while (time_before(jiffies, timeout));
+	printk("ata%u: end resetting, sstatus=%08x\n", ap->id, sstatus);
 
 	/* TODO: phy layer with polling, timeouts, etc. */
 	if (sata_dev_present(ap))
