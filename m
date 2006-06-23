From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.16-rc5 1/2] ahci: add another JMicron pci id
Date: Thu, 22 Jun 2006 23:19:57 -0400
Message-ID: <449B5DDD.2090007@pobox.com>
References: <OF133C6180.50F304D2-ON4825718F.0009B817-4825718F.000B5E73@jmicron.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080901060405090003070305"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:64646 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751169AbWFWDUA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jun 2006 23:20:00 -0400
In-Reply-To: <OF133C6180.50F304D2-ON4825718F.0009B817-4825718F.000B5E73@jmicron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: justin@jmicron.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080901060405090003070305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Just to speed things along, I applied the attached patch...

	Jeff




--------------080901060405090003070305
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

8fa29b23d9e0ef976dc578aab98297d4f24f70da
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 82ecdef..df779ba 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -320,8 +320,14 @@ static const struct pci_device_id ahci_p
 	/* JMicron */
 	{ 0x197b, 0x2360, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* JMicron JMB360 */
+	{ 0x197b, 0x2361, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* JMicron JMB361 */
 	{ 0x197b, 0x2363, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* JMicron JMB363 */
+	{ 0x197b, 0x2365, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* JMicron JMB365 */
+	{ 0x197b, 0x2366, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* JMicron JMB366 */
 
 	/* ATI */
 	{ PCI_VENDOR_ID_ATI, 0x4380, PCI_ANY_ID, PCI_ANY_ID, 0, 0,

--------------080901060405090003070305--
