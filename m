From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH] doc: kernel-parameters.txt: Add ide-generic.probe-mask
Date: Sat, 25 Oct 2014 17:03:52 +0100 (BST)
Message-ID: <alpine.LFD.2.11.1410251638230.21390@eddie.linux-mips.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Not much to say beyond the subject.  Noticed while fiddling with a plain 
ISA multi-I/O card (remember those?) having a single IDE channel only, as 
usually with them, to avoid errors like:

ide1: unexpected interrupt, status=0xff, count=11

popping up in the kernel log -- presumably coming from noise on the 
floating IRQ15 line or maybe spurious interrupts triggered by another 
device (the slave 8259A delivers them like IRQ15 and they can be told 
apart by internal PIC status, but we don't check it if the line is 
enabled, for performance reasons).

 Please apply.

  Maciej

linux-doc-ide-generic.patch
Index: linux-3.16-dolch/Documentation/kernel-parameters.txt
===================================================================
--- linux-3.16-dolch.orig/Documentation/kernel-parameters.txt
+++ linux-3.16-dolch/Documentation/kernel-parameters.txt
@@ -1263,6 +1263,17 @@ bytes respectively. Such letter suffixes
 			.cdrom .chs .ignore_cable are additional options
 			See Documentation/ide/ide.txt.
 
+	ide-generic.probe-mask= [HW] (E)IDE subsystem
+			Format: <int>
+			Probe mask for legacy ISA IDE ports.  Depending on
+			platform up to 6 ports are supported, enabled by
+			setting corresponding bits in the mask to 1.  The
+			default value is 0x0, that is special and on systems
+			that have PCI triggers scanning the PCI bus for the
+			first and the second port, which are then probed.
+			On systems without PCI the value of 0x0 enables
+			probing the two first ports as if it was 0x3.
+
 	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
 			Claim all unknown PCI IDE storage controllers.
 
