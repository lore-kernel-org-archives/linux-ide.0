From: "su henry" <henry.su.ati@gmail.com>
Subject: [patch] Add more device IDs for supporting ATI SB700
Date: Sun, 15 Jul 2007 10:39:54 +0800
Message-ID: <c660f0910707141939v1daaff5ei285072dc80df5e4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_44654_22151002.1184467194819"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:43587 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbXGOCj4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jul 2007 22:39:56 -0400
Received: by ug-out-1314.google.com with SMTP id j3so786238ugf
        for <linux-ide@vger.kernel.org>; Sat, 14 Jul 2007 19:39:55 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, jeff@garzik.org
Cc: linux-ide@vger.kernel.org, henry.su@amd.com, bzolnier@gmail.com, greg@kroah.com, htejun@gmail.com

------=_Part_44654_22151002.1184467194819
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: henry.su.ati@google.com
The SATA controller device ID will be different according to
the onchip SATA type set in the system BIOS:
Device                                Device ID
SATA in IDE mode              0x4390
SATA in AHCI mode            0x4391
SATA in non-raid5 driver     0x4392
SATA in raid5 driver            0x4393

Although the device ID is different, they use the AHCI driver
together.The attached file is the patch for adding these device
IDs for ATI SB700.

Signed-off-by: henry.su.ati@google.com
-----------------------------------
diff -Nur linux-2.6.22.1.orig/drivers/ata/ahci.c
linux-2.6.22.1/drivers/ata/ahci.c
--- linux-2.6.22.1.orig/drivers/ata/ahci.c      2007-07-13
10:39:27.854093200 +0800
+++ linux-2.6.22.1/drivers/ata/ahci.c   2007-07-13 10:52:58.625022700 +0800
@@ -399,7 +399,10 @@

        /* ATI */
        { PCI_VDEVICE(ATI, 0x4380), board_ahci_sb600 }, /* ATI SB600 */
-       { PCI_VDEVICE(ATI, 0x4390), board_ahci_sb600 }, /* ATI SB700 */
+       { PCI_VDEVICE(ATI, 0x4390), board_ahci_sb600 }, /* ATI SB700 IDE */
+       { PCI_VDEVICE(ATI, 0x4391), board_ahci_sb600 }, /* ATI SB700 AHCI */
+       { PCI_VDEVICE(ATI, 0x4392), board_ahci_sb600 }, /* ATI SB700
nor-raid5 */
+       { PCI_VDEVICE(ATI, 0x4393), board_ahci_sb600 }, /* ATI SB700 raid5 */

        /* VIA */
        { PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */

------=_Part_44654_22151002.1184467194819
Content-Type: text/x-patch; name=sb700sataids.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f44wiymg
Content-Disposition: attachment; filename="sb700sataids.patch"

ZGlmZiAtTnVyIGxpbnV4LTIuNi4yMi4xLm9yaWcvZHJpdmVycy9hdGEvYWhjaS5jIGxpbnV4LTIu
Ni4yMi4xL2RyaXZlcnMvYXRhL2FoY2kuYwotLS0gbGludXgtMi42LjIyLjEub3JpZy9kcml2ZXJz
L2F0YS9haGNpLmMJMjAwNy0wNy0xMyAxMDozOToyNy44NTQwOTMyMDAgKzA4MDAKKysrIGxpbnV4
LTIuNi4yMi4xL2RyaXZlcnMvYXRhL2FoY2kuYwkyMDA3LTA3LTEzIDEwOjUyOjU4LjYyNTAyMjcw
MCArMDgwMApAQCAtMzk5LDcgKzM5OSwxMCBAQAogCiAJLyogQVRJICovCiAJeyBQQ0lfVkRFVklD
RShBVEksIDB4NDM4MCksIGJvYXJkX2FoY2lfc2I2MDAgfSwgLyogQVRJIFNCNjAwICovCi0JeyBQ
Q0lfVkRFVklDRShBVEksIDB4NDM5MCksIGJvYXJkX2FoY2lfc2I2MDAgfSwgLyogQVRJIFNCNzAw
ICovCisJeyBQQ0lfVkRFVklDRShBVEksIDB4NDM5MCksIGJvYXJkX2FoY2lfc2I2MDAgfSwgLyog
QVRJIFNCNzAwIElERSAqLworCXsgUENJX1ZERVZJQ0UoQVRJLCAweDQzOTEpLCBib2FyZF9haGNp
X3NiNjAwIH0sIC8qIEFUSSBTQjcwMCBBSENJICovCisJeyBQQ0lfVkRFVklDRShBVEksIDB4NDM5
MiksIGJvYXJkX2FoY2lfc2I2MDAgfSwgLyogQVRJIFNCNzAwIG5vci1yYWlkNSAqLworCXsgUENJ
X1ZERVZJQ0UoQVRJLCAweDQzOTMpLCBib2FyZF9haGNpX3NiNjAwIH0sIC8qIEFUSSBTQjcwMCBy
YWlkNSAqLwogCiAJLyogVklBICovCiAJeyBQQ0lfVkRFVklDRShWSUEsIDB4MzM0OSksIGJvYXJk
X2FoY2lfdnQ4MjUxIH0sIC8qIFZJQSBWVDgyNTEgKi8KCg==
------=_Part_44654_22151002.1184467194819--
