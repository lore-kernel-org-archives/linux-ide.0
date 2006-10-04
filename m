From: "James E. Jarvis" <jjarvis@staffmail.ed.ac.uk>
Subject: 2.4.33 ata_piix patch for Intel 82801GBM/GHM (ICH7) SATA
Date: Wed, 4 Oct 2006 16:53:44 +0100 (BST)
Message-ID: <Pine.GSO.4.64.0610041644010.9352@holyrood.ed.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lawnmarket.ucs.ed.ac.uk ([129.215.166.63]:49802 "EHLO
	lawnmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S1161260AbWJDPxr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Oct 2006 11:53:47 -0400
Received: from holyrood.ed.ac.uk (holyrood.ed.ac.uk [129.215.16.14])
	by lawnmarket.ucs.ed.ac.uk (8.13.8/8.13.6) with ESMTP id k94Frj7r019160
	for <linux-ide@vger.kernel.org>; Wed, 4 Oct 2006 16:53:45 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This patch needs testing. I do not have access (other than intermittent 
ssh access) to a Fujitsu Siemens Pi 1505 laptop running 2.4.33 Linux 
Kernel.

The following is a patch for the Intel Corporation 82801GBM/GHM (ICH7 
Family) Serial ATA Storage Controllers cc=AHCI (rev 02)
pc id = 8086:27c5 in the Linux 2.4.33 kernel

--- drivers/scsi/ata_piix.c~    Fri Aug 11 05:18:20 2006
+++ drivers/scsi/ata_piix.c     Wed Oct  4 16:11:36 2006
@@ -115,6 +115,7 @@
         { 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
         { 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
         { 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
+       { 0x8086, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
         { 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, esb2_sata },

         { }     /* terminate list */


There was nothing obvious to update in quirks.c to my naive eyes.

    ----------------------------------
          James Jarvis BSc., PhD
       The University of Edinburgh
             0131 651 3095
     email 'james.jarvis@ed.ac.uk'
    http://homepages.ed.ac.uk/jjarvis/
    ----------------------------------
