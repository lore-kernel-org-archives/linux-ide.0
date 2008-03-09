From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA HDD password problem
Date: Sun, 09 Mar 2008 14:13:25 +0900
Message-ID: <47D371F5.1020804@gmail.com>
References: <Pine.LNX.4.64.0803051143450.27209@Soyuz-KT.TeNet.Odessa.UA> <47CE9264.1010600@garzik.org> <Pine.LNX.4.64.0803051443500.28213@Soyuz-KT.TeNet.Odessa.UA> <47CFBDB6.8040400@gmail.com> <Pine.LNX.4.64.0803061417540.5200@Soyuz-KT.TeNet.Odessa.UA> <47D0BC5A.9000208@gmail.com> <Pine.LNX.4.64.0803071038380.12026@Soyuz-KT.TeNet.Odessa.UA> <47D1E91D.8090704@gmail.com> <Pine.LNX.4.64.0803081801120.23474@Soyuz-KT.TeNet.Odessa.UA>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030706000106080201080108"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:49122 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbYCIFNd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 00:13:33 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1548119wah.23
        for <linux-ide@vger.kernel.org>; Sat, 08 Mar 2008 21:13:32 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0803081801120.23474@Soyuz-KT.TeNet.Odessa.UA>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

This is a multi-part message in MIME format.
--------------030706000106080201080108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Rus V. Brushkoff wrote:
> On Sat, 8 Mar 2008, Tejun Heo wrote:
> 
> 	Hi,
> 
> :Rus V. Brushkoff wrote:
> :> :This is weird.  The drive should have stayed unlocked over
> :> :initialization sequence as SSP is in effect.  Either the BIOS is turning
> :> :off SSP during POST or the drive isn't preserving security mode state
> :> :although SSP is in effect.  Testing who's to blame can be a bit
> :> :cumbersome and involves removing power from the drive while the rest of
> :> :the system is running.  Can you do that?
> :> 
> :>  Sure - I can simply hot-unplug/hot-plug hdd from laptop. For now I've 
> :Okay, here's the sequence.
> :1. Boot w/o password set.  hdparm -I will show that security feature is
> :not enabled.
> :2. Execute "hdparm --user-master u --security-set-pass PASSWORD
> :/dev/sda".  hdparm -I will show that security is enabled but not locked.
> :3. Remove power from the drive and reapply.  Now hdparm -I will show
> :that security is enabled and locked and dd'ing from the drive will fail.
> :4. Execute "hdparm --user-master -u --security-unlock PASSWORD
> :/dev/sda".  hdparm -I will show security enabled but unlocked and you'll
> :be able to access the drive again.
> :5. Unload and reload ahci.  This will trigger controller initialization
> :causing hardresets on the ports.  Execute hdparm -I and see whether the
> :drive is still unlocked and verify that you can read from the drive.
> 
>  I've used debian live-cd, which has achi compiled as module (booted with 
> acpi=off because of the 2.6.22 kernel problems with 8254 timer), uname -a :
> 
> Linux debian 2.6.22-3-486 #1 Mon Nov 12 07:53:08 UTC 2007 i686 unknown
> 
> files with 'hdpam -I' output is attached, numerating by the said sequence, 
> boot.pass is the output booted with bios enabled password. Shortly diffs 
> between stages are :

Unless I'm mistaken, this means that the BIOS is disabling SSP during
POST, which it really shouldn't.  There's no guarantee that a hardreset
won't occur even if the OS doesn't do it explicitly and when that
happens the drive will get locked and OS can't unlock it without asking
the user for password.  Eeeeek, ugly.

 specified, The attached patch implements ahci.skip_host_reset module
parameter.  If specified, host reset is skipped during controller
initialization.  Does this work around the problem?

Thanks.

-- 
tejun

--------------030706000106080201080108
Content-Type: text/x-patch;
 name="ahci-implement-skip-host-reset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ahci-implement-skip-host-reset.patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 70a0f07..fb1af0f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -49,6 +49,10 @@
 #define DRV_NAME	"ahci"
 #define DRV_VERSION	"3.0"
 
+static int ahci_skip_host_reset;
+module_param_named(skip_host_reset, ahci_skip_host_reset, int, 0444);
+MODULE_PARM_DESC(skip_host_reset, "skip global host reset (0=don't skip, 1=skip)");
+
 static int ahci_enable_alpm(struct ata_port *ap,
 		enum link_pm policy);
 static void ahci_disable_alpm(struct ata_port *ap);
@@ -1057,29 +1061,35 @@ static int ahci_reset_controller(struct ata_host *host)
 	ahci_enable_ahci(mmio);
 
 	/* global controller reset */
-	tmp = readl(mmio + HOST_CTL);
-	if ((tmp & HOST_RESET) == 0) {
-		writel(tmp | HOST_RESET, mmio + HOST_CTL);
-		readl(mmio + HOST_CTL); /* flush */
-	}
+	if (!ahci_skip_host_reset) {
+		tmp = readl(mmio + HOST_CTL);
+		if ((tmp & HOST_RESET) == 0) {
+			writel(tmp | HOST_RESET, mmio + HOST_CTL);
+			readl(mmio + HOST_CTL); /* flush */
+		}
 
-	/* reset must complete within 1 second, or
-	 * the hardware should be considered fried.
-	 */
-	ssleep(1);
+		/* reset must complete within 1 second, or
+		 * the hardware should be considered fried.
+		 */
+		ssleep(1);
 
-	tmp = readl(mmio + HOST_CTL);
-	if (tmp & HOST_RESET) {
-		dev_printk(KERN_ERR, host->dev,
-			   "controller reset failed (0x%x)\n", tmp);
-		return -EIO;
-	}
+		tmp = readl(mmio + HOST_CTL);
+		if (tmp & HOST_RESET) {
+			dev_printk(KERN_ERR, host->dev,
+				   "controller reset failed (0x%x)\n", tmp);
+			return -EIO;
+		}
 
-	/* turn on AHCI mode */
-	ahci_enable_ahci(mmio);
+		/* turn on AHCI mode */
+		ahci_enable_ahci(mmio);
 
-	/* some registers might be cleared on reset.  restore initial values */
-	ahci_restore_initial_config(host);
+		/* Some registers might be cleared on reset.  Restore
+		 * initial values.
+		 */
+		ahci_restore_initial_config(host);
+	} else
+		dev_printk(KERN_INFO, host->dev,
+			   "skipping global host reset\n");
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
 		u16 tmp16;

--------------030706000106080201080108--
