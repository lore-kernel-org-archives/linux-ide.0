From: "su henry" <henry.su.ati@gmail.com>
Subject: [patch] add more device IDs for supporting SB700 (resend)
Date: Mon, 16 Jul 2007 22:59:43 +0800
Message-ID: <c660f0910707160759m384f46b3s310cf833db305cb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_37311_29284429.1184597983326"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:52685 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758231AbXGPO7o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 10:59:44 -0400
Received: by ug-out-1314.google.com with SMTP id j3so993553ugf
        for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 07:59:43 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff <jeff@garzik.org>, jgarzik <jgarzik@pobox.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, bzolnier <bzolnier@gmail.com>, htejun <htejun@gmail.com>, greg <greg@kroah.com>, henry.su@amd.com

------=_Part_37311_29284429.1184597983326
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: henry.su.ati@gmail.com
The SATA controller device ID is different according to
the onchip SATA type set in the system BIOS:
Device                              Device ID
SATA in IDE mode             0x4390
SATA in AHCI mode           0x4391
SATA in non-raid5 driver     0x4392
SATA in raid5 driver           0x4393

Although the device ID is different, they use the same AHCI driver
.The attached file is the patch for adding these device
IDs for ATI SB700.

Signed-off-by: henry.su.ati@gmail.com
-----------------------------------
diff -Nur a/drivers/ata/ahci.c b/drivers/ata/ahci.c
--- a/drivers/ata/ahci.c	2007-07-13 10:39:27.854093200 +0800
+++ b/drivers/ata/ahci.c	2007-07-13 10:52:58.625022700 +0800
@@ -399,7 +399,10 @@

 	/* ATI */
 	{ PCI_VDEVICE(ATI, 0x4380), board_ahci_sb600 }, /* ATI SB600 */
-	{ PCI_VDEVICE(ATI, 0x4390), board_ahci_sb600 }, /* ATI SB700 */
+	{ PCI_VDEVICE(ATI, 0x4390), board_ahci_sb600 }, /* ATI SB700 IDE */
+	{ PCI_VDEVICE(ATI, 0x4391), board_ahci_sb600 }, /* ATI SB700 AHCI */
+	{ PCI_VDEVICE(ATI, 0x4392), board_ahci_sb600 }, /* ATI SB700 nraid5 */
+	{ PCI_VDEVICE(ATI, 0x4393), board_ahci_sb600 }, /* ATI SB700 raid5 */

 	/* VIA */
 	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */

------=_Part_37311_29284429.1184597983326
Content-Type: text/plain; name=sb700sataids.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f472s2bl
Content-Disposition: attachment; filename="sb700sataids.patch"

ZGlmZiAtTnVyIGEvZHJpdmVycy9hdGEvYWhjaS5jIGIvZHJpdmVycy9hdGEvYWhjaS5jCi0tLSBh
L2RyaXZlcnMvYXRhL2FoY2kuYwkyMDA3LTA3LTEzIDEwOjM5OjI3Ljg1NDA5MzIwMCArMDgwMAor
KysgYi9kcml2ZXJzL2F0YS9haGNpLmMJMjAwNy0wNy0xMyAxMDo1Mjo1OC42MjUwMjI3MDAgKzA4
MDAKQEAgLTM5OSw3ICszOTksMTAgQEAKIAogCS8qIEFUSSAqLwogCXsgUENJX1ZERVZJQ0UoQVRJ
LCAweDQzODApLCBib2FyZF9haGNpX3NiNjAwIH0sIC8qIEFUSSBTQjYwMCAqLwotCXsgUENJX1ZE
RVZJQ0UoQVRJLCAweDQzOTApLCBib2FyZF9haGNpX3NiNjAwIH0sIC8qIEFUSSBTQjcwMCAqLwor
CXsgUENJX1ZERVZJQ0UoQVRJLCAweDQzOTApLCBib2FyZF9haGNpX3NiNjAwIH0sIC8qIEFUSSBT
QjcwMCBJREUgKi8KKwl7IFBDSV9WREVWSUNFKEFUSSwgMHg0MzkxKSwgYm9hcmRfYWhjaV9zYjYw
MCB9LCAvKiBBVEkgU0I3MDAgQUhDSSAqLworCXsgUENJX1ZERVZJQ0UoQVRJLCAweDQzOTIpLCBi
b2FyZF9haGNpX3NiNjAwIH0sIC8qIEFUSSBTQjcwMCBucmFpZDUgKi8KKwl7IFBDSV9WREVWSUNF
KEFUSSwgMHg0MzkzKSwgYm9hcmRfYWhjaV9zYjYwMCB9LCAvKiBBVEkgU0I3MDAgcmFpZDUgKi8K
IAogCS8qIFZJQSAqLwogCXsgUENJX1ZERVZJQ0UoVklBLCAweDMzNDkpLCBib2FyZF9haGNpX3Z0
ODI1MSB9LCAvKiBWSUEgVlQ4MjUxICovCgo=
------=_Part_37311_29284429.1184597983326--
