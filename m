From: Jason Gaston <jason.d.gaston@intel.com>
Subject: [PATCH 2.6.21-rc2] ahci: RAID mode SATA patch for Intel ICH9M
Date: Fri, 2 Mar 2007 17:39:46 -0800
Message-ID: <200703021739.47147.jason.d.gaston@intel.com>
References: <200611211655.58451.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27076 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992888AbXCCBi6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 20:38:58 -0500
In-Reply-To: <200611211655.58451.jason.d.gaston@intel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, jason.d.gaston@intel.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

This patch adds the Intel ICH9M RAID controller DID for SATA support.

Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.21-rc2/drivers/ata/ahci.c.orig	2007-03-02 17:28:00.000000000 
-0800
+++ linux-2.6.21-rc2/drivers/ata/ahci.c	2007-03-02 17:28:30.000000000 -0800
@@ -380,6 +380,7 @@
 	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_pi }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_pi }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_pi }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_pi }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_pi }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci_pi }, /* ICH9 */
 	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_pi }, /* ICH9M */
