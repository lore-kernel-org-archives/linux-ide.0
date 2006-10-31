From: "Conke Hu" <conke.hu@amd.com>
Subject: AHCI should try to claim all AHCI controllers
Date: Tue, 31 Oct 2006 23:06:32 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F358602F2CE9E@shacnexch2.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-res.frontbridge.com ([63.161.60.49]:56565 "EHLO
	outbound2-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1423472AbWJaPI1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 10:08:27 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi all,
	According to PCI 3.0 spec, ACHI's PCI class code is 0x010601,
and I suggest the ahci driver had better try to claim all ahci
controllers, pls see the following patch:

diff -Nur linux-2.6.17/drivers/scsi/ahci.c
linux-2.6.17-ahci/drivers/scsi/ahci.c
--- linux-2.6.17/drivers/scsi/ahci.c	2006-06-18 09:49:35.000000000
+0800
+++ linux-2.6.17-ahci/drivers/scsi/ahci.c	2006-10-31
22:50:54.000000000 +0800
@@ -296,6 +296,11 @@
 	  board_ahci }, /* ATI SB600 non-raid */
 	{ PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ATI SB600 raid */
+	/* Claim all AHCI controllers not listed above. 
+	 * According to PCI 3.0, AHCI's class code is 0x010601 
+        */
+	{ PCI_AND_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, 0x010601,
0xffffff, 
+	board_ahci },
 	{ }	/* terminate list */
 };


Best regards,
Conke @ AMD, Inc.




