From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [PATCH] IDE: Unregister devices if initialization fails.
Date: Fri, 30 Jan 2009 17:19:03 +0000
Message-ID: <1233335943.9970.28.camel@zakaz.uk.xensource.com>
References: <1232715869-31039-1-git-send-email-Ian.Campbell@citrix.com>
	 <200901271741.44704.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:45975 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbZA3RTg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jan 2009 12:19:36 -0500
In-Reply-To: <200901271741.44704.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tue, 2009-01-27 at 17:41 +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On Friday 23 January 2009, Ian Campbell wrote:
> > On reboot the loop in device_shutdown gets confused by these devices
> > and goes into an infinite loop. I think this is because they don't
> > have dev->bus or dev->driver which is because hwif_register_devices
> > doesn't get called if !hwif->present.
> > 
> > Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> > Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/ide-probe.c |   10 ++++++----
> >  1 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> > index 312127e..120f65b 100644
> > --- a/drivers/ide/ide-probe.c
> > +++ b/drivers/ide/ide-probe.c
> > @@ -1520,6 +1520,8 @@ int ide_host_register(struct ide_host *host, const struct ide_port_info *d,
> >  		if (hwif_init(hwif) == 0) {
> >  			printk(KERN_INFO "%s: failed to initialize IDE "
> >  					 "interface\n", hwif->name);
> > +			device_unregister(&hwif->gendev);
> > +			device_destroy(ide_port_class, MKDEV(0, 0));
> >  			hwif->present = 0;
> 
> I've been wondering about this a bit and I think that we should just nuke
> port from struct ide_host in such situation so I added ide_disable_port()
> helper for this (+ fixed ide_register_port() handling while at it).
> 
> Could you please re-base your fix on top of attached patch?

Sure.

Subject: IDE: Disable and unregister devices if initialization fails.

On reboot the loop in device_shutdown gets confused by these partially
initialized devices and goes into an infinite loop. Therefore disable
and unregister these devices.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>

---
 drivers/ide/ide-probe.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff -r 12d1a7848ddf drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Fri Jan 30 16:37:15 2009 +0000
+++ b/drivers/ide/ide-probe.c	Fri Jan 30 17:00:08 2009 +0000
@@ -1549,6 +1549,8 @@
 		if (hwif_init(hwif) == 0) {
 			printk(KERN_INFO "%s: failed to initialize IDE "
 					 "interface\n", hwif->name);
+			ide_disable_port(hwif);
+			device_unregister(&hwif->gendev);
 			hwif->present = 0;
 			continue;
 		}


