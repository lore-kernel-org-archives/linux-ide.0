From: Jason Gaston <jason.d.gaston@intel.com>
Subject: [PATCH 2.6.23-rc4] ahci: RAID mode SATA patch for Intel Tolapai
Date: Thu, 30 Aug 2007 15:41:14 -0700
Message-ID: <200708301541.15111.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55203 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757393AbXH3WjG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Aug 2007 18:39:06 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, jason.d.gaston@intel.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

This patch adds the Intel Tolapai RAID controller DID's for SATA suppor=
t.

Signed-off-by: =A0Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.23-rc4/drivers/ata/ahci.c.orig	2007-08-27 18:32:35.000000=
000=20
-0700
+++ linux-2.6.23-rc4/drivers/ata/ahci.c	2007-08-28 16:58:11.000000000 -=
0700
@@ -411,6 +411,8 @@
 	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_pi }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci_pi }, /* ICH9 */
 	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_pi }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
+	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
=20
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
