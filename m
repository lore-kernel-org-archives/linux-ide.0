From: Dave Jones <davej@redhat.com>
Subject: correct kernel parameter in documentation.
Date: Thu, 27 Sep 2007 11:50:13 -0400
Message-ID: <20070927155013.GA20219@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:36848 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753147AbXI0PuW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Sep 2007 11:50:22 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Jeff Garzik <jeff@garzik.org>

'noacpi' isn't a standalone parameter, give it its prefix.

Signed-off-by: Dave Jones <davej@redhat.com>

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 4d175c7..a87bc58 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -863,6 +863,10 @@ and is between 256 and 4096 characters. It is defined in the file
 	lasi=		[HW,SCSI] PARISC LASI driver for the 53c700 chip
 			Format: addr:<io>,irq:<irq>
 
+	libata.noacpi	[LIBATA] Disables use of ACPI in libata suspend/resume
+			when set.
+			Format: <int>
+
 	load_ramdisk=	[RAM] List of ramdisks to load from floppy
 			See Documentation/ramdisk.txt.
 
@@ -1079,10 +1083,6 @@ and is between 256 and 4096 characters. It is defined in the file
 			emulation library even if a 387 maths coprocessor
 			is present.
 
-	noacpi		[LIBATA] Disables use of ACPI in libata suspend/resume
-			when set.
-			Format: <int>
-
 	noaliencache	[MM, NUMA, SLAB] Disables the allocation of alien
 			caches in the slab allocator.  Saves per-node memory,
 			but will impact performance.
-- 
http://www.codemonkey.org.uk
