From: TAKADA Yoshihito <takada@mbf.nifty.com>
Subject: IDE driver assined IRQ for disabled IDE channel
Date: Fri, 25 Jul 2008 14:31:28 +0900 (JST)
Message-ID: <20080725.143128.193681587.takada@mbf.nifty.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pxy2nd.nifty.com ([202.248.175.14]:39493 "HELO pxy2nd.nifty.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750934AbYGYFjT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jul 2008 01:39:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi.
In kernel 2.6.26, I disable the secoundary IDE via BIOS. But kernel assigned IRQ to secondary IDE.
I saw /proc/interrupts:
  - /proc/interrupts of 2.6.25
           CPU0       
  0:     232213    XT-PIC-XT        timer
  1:        388    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  3:          1    XT-PIC-XT      
  4:        305    XT-PIC-XT      
  5:          1    XT-PIC-XT      
  7:          1    XT-PIC-XT      
  8:          0    XT-PIC-XT        rtc0
  9:          1    XT-PIC-XT      
 10:          1    XT-PIC-XT      
 11:          1    XT-PIC-XT      
 12:        110    XT-PIC-XT        i8042
 14:       5640    XT-PIC-XT        ide0
 15:         35    XT-PIC-XT        yenta, ohci_hcd:usb1
NMI:          0   Non-maskable interrupts
TRM:          0   Thermal event interrupts
SPU:          0   Spurious interrupts
ERR:          0

IRQ15 doesn't assigned for ide1.

  - /proc/interrupts of 2.6.26
           CPU0       
  0:     213884    XT-PIC-XT        timer
  1:        197    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  3:          1    XT-PIC-XT      
  4:        309    XT-PIC-XT      
  5:          1    XT-PIC-XT      
  7:          2    XT-PIC-XT      
  8:          0    XT-PIC-XT        rtc0
  9:          1    XT-PIC-XT      
 10:          1    XT-PIC-XT      
 11:          1    XT-PIC-XT      
 12:        110    XT-PIC-XT        i8042
 14:       5621    XT-PIC-XT        ide0
 15:          0    XT-PIC-XT        ide1
NMI:          0   Non-maskable interrupts
TRM:          0   Thermal event interrupts
SPU:          0   Spurious interrupts
ERR:          1

However, kernel 2.6.26 assinged IRQ15 for ide1. And yenta and ohci
(USB host controller) couldn't assign an IRQ.

dmesg are:
Yenta: CardBus bridge found at 0000:00:01.0 [0000:0000]
Yenta: no PCI IRQ, CardBus support disabled for this socket.
Yenta: check your BIOS CardBus, BIOS IRQ or ACPI settings.

ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: request interrupt 15 failed
ohci_hcd 0000:00:13.0: USB bus 1 deregistered
ohci_hcd 0000:00:13.0: init 0000:00:13.0 fail, -16
ohci_hcd: probe of 0000:00:13.0 failed with error -16

Signed-off-by: TAKADA Yoshihito <takada@mbf.nifty.com>

diff -Narup a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2008-07-25 13:21:37.000000000 +0900
+++ b/drivers/ide/ide-probe.c	2008-07-25 13:42:38.000000000 +0900
@@ -1546,6 +1546,8 @@ int ide_device_add_all(u8 *idx, const st
 			continue;
 
 		hwif = &ide_hwifs[idx[i]];
+		if (!hwif->present)
+			continue;
 
 		if (hwif_init(hwif) == 0) {
 			printk(KERN_INFO "%s: failed to initialize IDE "
@@ -1582,12 +1584,11 @@ int ide_device_add_all(u8 *idx, const st
 			continue;
 
 		hwif = &ide_hwifs[idx[i]];
-
-		ide_sysfs_register_port(hwif);
-		ide_proc_register_port(hwif);
-
-		if (hwif->present)
+		if (hwif->present) {
+			ide_sysfs_register_port(hwif);
+			ide_proc_register_port(hwif);
 			ide_proc_port_register_devices(hwif);
+		}
 	}
 
 	return rc;
