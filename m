From: "Peer Chen" <pchen@nvidia.com>
Subject: [Patch] SCSI: Add nvidia AHCI controllers of MCP67 support to ahci.c
Date: Tue, 31 Oct 2006 16:03:31 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C42D59F@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate01.nvidia.com ([216.228.112.170]:10258 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1422957AbWJaIHW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 03:07:22 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Add the support for AHCI controllers of MCP67.
The following ahci.c patch is based on kernel 2.6.18.

Signed-off by: Peer Chen <pchen@nvidia.com>
===================================

--- ahci.c.orig	2006-10-31 13:55:47.000000000 +0800
+++ ahci.c	2006-10-31 13:56:54.000000000 +0800
@@ -349,6 +349,22 @@ static const struct pci_device_id ahci_p
 	  board_ahci },		/* MCP65 */
 	{ PCI_VENDOR_ID_NVIDIA, 0x044f, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci },		/* MCP65 */
+	{ PCI_VENDOR_ID_NVIDIA, 0x0554, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },		/* MCP67 */
+	{ PCI_VENDOR_ID_NVIDIA, 0x0555, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },		/* MCP67 */
+	{ PCI_VENDOR_ID_NVIDIA, 0x0556, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },		/* MCP67 */
+	{ PCI_VENDOR_ID_NVIDIA, 0x0557, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },		/* MCP67 */	  
+	{ PCI_VENDOR_ID_NVIDIA, 0x0558, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },		/* MCP67 */
+	{ PCI_VENDOR_ID_NVIDIA, 0x0559, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },		/* MCP67 */
+	{ PCI_VENDOR_ID_NVIDIA, 0x055a, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },		/* MCP67 */
+	{ PCI_VENDOR_ID_NVIDIA, 0x055b, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },		/* MCP67 */	  	  
 
 	{ }	/* terminate list */
 };
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
