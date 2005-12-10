From: Thibaut VARENE <T-Bone@parisc-linux.org>
Subject: [PATCH] Restore support for AEC6280M cards in aec62xx.c
Date: Sun, 11 Dec 2005 00:05:36 +0100
Message-ID: <20051211000536.5bd822dd@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_P3cvmp5Lje5MfKytZPLbyvJ
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1-g19.free.fr ([212.27.42.27]:51880 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S932085AbVLJXFy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Dec 2005 18:05:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: akpm@osdl.org, bzolnier@gmail.com, benh@kernel.crashing.org

--MP_P3cvmp5Lje5MfKytZPLbyvJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

This patch was initially sent to linux-ide about a month ago, and was
supposed to hit -mm, see:

http://marc.theaimsgroup.com/?l=linux-ide&m=113161988518500&w=2

As I didn't see this happening, I'm resending the patch, diff'd against
2.6.15-rc5. It fixes a serious bug that has been in the kernel for ages,
preventing users of Macintosh-flavoured AEC cards to use them with Linux.
The code has been brought up with the help of Benh.

HTH

T-Bone

ide-pci-aec62xx-maccards.diff:
  This patch adds missing initialization sequence, necessary to get the
  "Macintosh" version of AEC6280 cards to work in Linux. Without this
  patch, the driver hangs for several minutes trying to initialize the
  card and the kernel is left in an unstable state. This patch has been
  tested fine on ppc and i386.

Signed-off-by: Thibaut VARENE <varenet@parisc-linux.org>

 drivers/ide/pci/aec62xx.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--MP_P3cvmp5Lje5MfKytZPLbyvJ
Content-Type: text/x-patch; name=ide-pci-aec62xx-maccards.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=ide-pci-aec62xx-maccards.diff

--- linux-2.6.15-rc5/drivers/ide/pci/aec62xx.c.orig	2005-12-10 23:47:10.000000000 +0100
+++ linux-2.6.15-rc5/drivers/ide/pci/aec62xx.c	2005-12-10 23:48:51.000000000 +0100
@@ -262,6 +262,21 @@
 	else
 		pci_set_drvdata(dev, (void *) aec6xxx_34_base);
 
+	/* These are necessary to get AEC6280 Macintosh cards to work */
+	if ((dev->device == PCI_DEVICE_ID_ARTOP_ATP865) ||
+	    (dev->device == PCI_DEVICE_ID_ARTOP_ATP865R)) {
+		u8 reg49h = 0, reg4ah = 0;
+		/* Clear reset and test bits.  */
+		pci_read_config_byte(dev, 0x49, &reg49h);
+		pci_write_config_byte(dev, 0x49, reg49h & ~0x30);
+		/* Enable chip interrupt output.  */
+		pci_read_config_byte(dev, 0x4a, &reg4ah);
+		pci_write_config_byte(dev, 0x4a, reg4ah & ~0x01);
+		/* Enable burst mode. */
+		pci_read_config_byte(dev, 0x4a, &reg4ah);
+		pci_write_config_byte(dev, 0x4a, reg4ah | 0x80);
+	}
+
 	return dev->irq;
 }
 

--MP_P3cvmp5Lje5MfKytZPLbyvJ--
