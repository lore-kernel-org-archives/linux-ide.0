From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] Fix the case of multiple HPT3xx chips present
Date: Wed, 03 May 2006 02:26:31 +0400
Message-ID: <4457DC97.3010807@ru.mvista.com>
References: <444B3BDE.1030106@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070300070105070509070906"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965019AbWEBW1n@vger.kernel.org>
In-Reply-To: <444B3BDE.1030106@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070300070105070509070906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    init_chipset_hpt366() modifies some fields of the ide_pci_device_t 
structure depending on the chip's revision, so pass it a copy of the structure 
to avoid issues when multiple different chips are present.
    Should apply on top of the hotswap fix.

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------070300070105070509070906
Content-Type: text/plain;
 name="HPT3xx-fix-case-of-multiple-chips.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT3xx-fix-case-of-multiple-chips.patch"

Index: linus/drivers/ide/pci/hpt366.c
===================================================================
--- linus.orig/drivers/ide/pci/hpt366.c
+++ linus/drivers/ide/pci/hpt366.c
@@ -73,6 +73,8 @@
  *   really for 50 MHz; switch to using HPT372 tables for HPT374...
  * - fix the hotswap code:  it caused RESET- to glitch when tristating the bus,
  *   and for HPT36x the obsolete HDIO_TRISTATE_HWIF handler was called instead
+ * - pass to init_chipset() handlers a copy of the IDE PCI device structure as
+ *   they tamper with its fields
  *		<source@mvista.com>
  *
  */
@@ -1621,13 +1623,16 @@ static ide_pci_device_t hpt366_chipsets[
  *
  *	Called when the PCI registration layer (or the IDE initialization)
  *	finds a device matching our IDE device tables.
+ *
+ *	NOTE: since we'll have to modify some fields of the ide_pci_device_t
+ *	structure depending on the chip's revision, we'd better pass a local
+ *	copy down the call chain...
  */
- 
 static int __devinit hpt366_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &hpt366_chipsets[id->driver_data];
+	ide_pci_device_t d = hpt366_chipsets[id->driver_data];
 
-	return d->init_setup(dev, d);
+	return d.init_setup(dev, &d);
 }
 
 static struct pci_device_id hpt366_pci_tbl[] = {



--------------070300070105070509070906--
