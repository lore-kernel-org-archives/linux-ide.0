From: Mark Lord <liml@rtr.ca>
Subject: re: [PATCH 14/14] sata_mv Comments and version bump (v.2)
Date: Fri, 25 Jan 2008 14:38:11 -0500
Message-ID: <479A3AA3.7050304@rtr.ca>
References: <4798FB68.70400@rtr.ca> <4798FD5D.4050209@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2283 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014AbYAYTiO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2008 14:38:14 -0500
In-Reply-To: <4798FD5D.4050209@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> sata_mv Comments and version bump.
> 
> Remove some obsolete comments, and bump up the driver version number.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
..

Mmm.. something weird happened with that original patch,
in that it somehow also had this:

> -    int want_ncq = ata_is_ncq(protocol);
> +    int want_ncq = (protocol == ATA_PROT_NCQ); 
..

Reposting it again here, without that extra fragment:
* * * * *

sata_mv Comments and version bump.

Remove some obsolete comments, and bump up the driver version number.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-24 15:09:31.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-24 15:41:17.000000000 -0500
@@ -29,8 +29,6 @@
   I distinctly remember a couple workarounds (one related to PCI-X)
   are still needed.
 
-  4) Add NCQ support (easy to intermediate, once new-EH support appears)
-
   5) Investigate problems with PCI Message Signalled Interrupts (MSI).
 
   6) Add port multiplier support (intermediate)
@@ -53,8 +51,6 @@
   Target mode, for those without docs, is the ability to directly
   connect two SATA controllers.
 
-  13) Verify that 7042 is fully supported.  I only have a 6042.
-
 */
 
 
@@ -73,7 +69,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"1.01"
+#define DRV_VERSION	"1.20"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
