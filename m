From: Tejun Heo <htejun@gmail.com>
Subject: Re: long boot delay for SATA cdrom on current 2.6.17-git
Date: Fri, 30 Jun 2006 14:26:33 +0900
Message-ID: <20060630052633.GF23844@htj.dyndns.org>
References: <20060630025341.GA4675@kroah.com> <20060630044912.GA2592@htj.dyndns.org> <20060630052021.GA4722@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.192]:16834 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751057AbWF3F0J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jun 2006 01:26:09 -0400
Received: by nz-out-0102.google.com with SMTP id z31so128621nzd
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 22:26:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060630052021.GA4722@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Thu, Jun 29, 2006 at 10:20:22PM -0700, Greg KH wrote:
> On Fri, Jun 30, 2006 at 01:49:12PM +0900, Tejun Heo wrote:
> > On Thu, Jun 29, 2006 at 07:53:41PM -0700, Greg KH wrote:
> > > This laptop does not have a SATA hard drive, only a SATA cdrom drive.
> > > I've included the boot log below and trimmed it after the delay
> > > happened, as I doubt anything after it would be relevant.
> > > 
> > > Is there any patch I can test to help fix this?
> > 
> > This seems to be the ghost device problem which occurs when the first
> > device is ATAPI but the second slot is empty.
> > 
> > > My .config is also attached, if that helps any.
> > 
> > Please try the following patch.
> 
> Yeah, that worked great, no timeout issues anymore!  Do you want to see
> the boot log again from this?

Great.  :-)

I don't need the successful boot log but I want to see why it wasn't a
problem in 2.6.17.  Can you apply the following patch to 2.6.17 and
post the result?

Thanks.

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b046ffa..35f4721 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2193,7 +2193,7 @@ int ata_std_softreset(struct ata_port *a
 	unsigned int devmask = 0, err_mask;
 	u8 err;
 
-	DPRINTK("ENTER\n");
+	DPRINTK("ENTER ata%u\n", ap->id);
 
 	if (ap->ops->scr_read && !sata_dev_present(ap)) {
 		classes[0] = ATA_DEV_NONE;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b80d2e7..b6b21f6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -38,7 +38,7 @@ #include <linux/workqueue.h>
  * compile-time options: to be removed as soon as all the drivers are
  * converted to the new debugging mechanism
  */
-#undef ATA_DEBUG		/* debugging output */
+#define ATA_DEBUG		/* debugging output */
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */
