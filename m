From: Aleksandar Radovanovic <biblbroks@sezampro.yu>
Subject: [PATCH 2.6.24-rc3] aec62xx: Fix kernel oops in driver's probe function
Date: Sat, 17 Nov 2007 22:43:56 +0100
Message-ID: <200711172243.57087.biblbroks@sezampro.yu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.sezampro.yu ([77.105.0.24]:3213 "HELO asus.sezampro.yu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751977AbXKQWQK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Nov 2007 17:16:10 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org

From: Aleksandar Radovanovic <biblbroks@sezampro.yu>

Add pci_enable_device() to aec62xx probe function
before doing any I/O.

Original probe function tries to read from device's
PCI region 4 before calling ide_setup_pci_device().
Since the device is not enabled at this point,
on machines that have no firmware PCI initialization
(e.g. ASUS WL-700gE router), corresponding PCI BAR 
is 0 and the following inb() causes a kernel oops.

Signed-off-by: Aleksandar Radovanovic <biblbroks@sezampro.yu>

---

 aec62xx.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

The patch has been tested and merged
in the trunk of the OpenWrt distribution
(on 2.6.23.1).

Anyway, should be a fairly obvious fix.

diff -Npur linux-2.6.24-rc3.orig/drivers/ide/pci/aec62xx.c linux-2.6.24-rc3/drivers/ide/pci/aec62xx.c
--- linux-2.6.24-rc3.orig/drivers/ide/pci/aec62xx.c	2007-11-17 21:33:59.000000000 +0100
+++ linux-2.6.24-rc3/drivers/ide/pci/aec62xx.c	2007-11-17 20:55:12.000000000 +0100
@@ -260,6 +260,11 @@ static int __devinit aec62xx_init_one(st
 {
 	struct ide_port_info d;
 	u8 idx = id->driver_data;
+	int err;
+
+	err = pci_enable_device(dev);
+	if (err)
+		return err;

 	d = aec62xx_chipsets[idx];

@@ -272,7 +277,11 @@ static int __devinit aec62xx_init_one(st
 		}
 	}

-	return ide_setup_pci_device(dev, &d);
+	err = ide_setup_pci_device(dev, &d);
+	if (err)
+		pci_disable_device(dev);
+
+	return err;
 }

 static const struct pci_device_id aec62xx_pci_tbl[] = {


