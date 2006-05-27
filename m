From: Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM) fails:  libata issue
Date: Sat, 27 May 2006 08:29:50 +0200
Message-ID: <20060527062950.GC23315@suse.de>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <20060526230534.GA3640@suse.de> <4477C60E.1070106@rtr.ca> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:1054 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751411AbWE0GaE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 02:30:04 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Fri, May 26 2006, Linus Torvalds wrote:
> 
> 
> On Fri, 26 May 2006, Mark Lord wrote:
> > 
> > Well, this problem has been with us all for a year now,
> > and at this point it impacts practically *every* new "centrino"
> > notebook out there.
> > 
> > We have a very simple workaround (previous post) that addresses it
> > for 2.6.17, and it's about damn time it got fixed.
> > 
> > If there's a better solution for *2.6.17*, then *please* post it.
> > Otherwise, we have a fix.  Maybe Linus or Andrew should just apply it?
> 
> I'm definitely in the "at some point, protesting a patch that works 
> becomes an untenably position to take, no matter _how_ ugly the patch is" 
> camp.
> 
> If the people who complain that it is ugly cannot come up with an 
> alternate solution that works and isn't ugly, at some point the "ugly" 
> complaint just becomes totally pointless. 

If that wasn't the case, then we wouldn't even have basic sata suspend
support in the Linus kernels right now... So agreed.

> Of course, I'm not on linux-ide, and I didn't see this particular 
> discussion from the start (or even the alledged simple workaround in the 
> "previous post"), but can people please fill me in? And if the choice is 
> not between "ugly" vs "pretty", but between "ugly" vs "nonworking", I 
> think we know what the answer should be.

There was no real discussion on this issue yet. I think we all agree
that the functionality of the patch (waiting for BSY clear on resume) is
the right thing to do. This posted patch moved SCSI stuff into ata_piix,
which isn't really very nice. Jeff wants to do it from the pci resume,
which just seems wrong to me since it's a device (disk) condition not a
"host" condition. FWIW, here's what I had in mind as suggested in the
original reply. Not tested at all for functionality, but it compiles.

diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 6dc8814..103afc3 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -151,6 +151,7 @@ static int piix_pata_probe_reset(struct 
 static int piix_sata_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
+static int piix_port_resume(struct ata_port *ap);
 
 static unsigned int in_module_init = 1;
 
@@ -250,6 +251,7 @@ static const struct ata_port_operations 
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.port_resume		= piix_port_resume,
 	.host_stop		= ata_host_stop,
 };
 
@@ -738,6 +740,16 @@ static int piix_disable_ahci(struct pci_
 	return rc;
 }
 
+static int piix_port_resume(struct ata_port *ap)
+{
+	u8 status = ata_busy_wait(ap, ATA_BUSY, 200000);
+
+	if (status & ATA_BUSY)
+		return 1;
+
+	return 0;
+}
+
 /**
  *	piix_check_450nx_errata	-	Check for problem 450NX setup
  *	@ata_dev: the PCI device to check
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fa476e7..ae7fac1 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4298,6 +4298,8 @@ int ata_device_resume(struct ata_port *a
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
+		if (ap->ops->port_resume)
+			ap->ops->port_resume(ap);
 		ata_set_mode(ap);
 	}
 	if (!ata_dev_present(dev))
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b80d2e7..0be5d02 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -461,6 +461,7 @@ struct ata_port_operations {
 
 	int (*port_start) (struct ata_port *ap);
 	void (*port_stop) (struct ata_port *ap);
+	int (*port_resume) (struct ata_port *ap);
 
 	void (*host_stop) (struct ata_host_set *host_set);
 

-- 
Jens Axboe

