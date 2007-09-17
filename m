From: "su henry" <henry.su.ati@gmail.com>
Subject: [patch] Add device IDs for supporting ATI/AMD SB800 SATA controller
Date: Mon, 17 Sep 2007 22:32:55 +0800
Message-ID: <c660f0910709170732s3c7dcfb3p66ba5b9f30a57b9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_12637_15986271.1190039575792"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:5047 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469AbXIQOc5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 10:32:57 -0400
Received: by py-out-1112.google.com with SMTP id u77so3175838pyb
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 07:32:56 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, gregkh@suse.de, "henry. su" <henry.su@amd.com>, jgarzik@pobox.com

------=_Part_12637_15986271.1190039575792
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: henry su<henry.su.ati@gmail.com>

ATI/AMD SB800 shares some device IDs with SB700,
and SB800 adds two more device IDs:0x4394,0x4395.

Signed-off-by:  henry su<henry.su.ati@gmail.com>
---------------------------
diff -Nur a/drivers/ata/ahci.c b/drivers/ata/ahci.c
--- a/drivers/ata/ahci.c        2007-09-17 22:07:04.000000000 +0800
+++ b/drivers/ata/ahci.c        2007-09-17 22:10:46.000000000 +0800
@@ -399,10 +399,12 @@

        /* ATI */
        { PCI_VDEVICE(ATI, 0x4380), board_ahci_sb600 }, /* ATI SB600 */
-       { PCI_VDEVICE(ATI, 0x4390), board_ahci_sb600 }, /* ATI SB700 IDE */
-       { PCI_VDEVICE(ATI, 0x4391), board_ahci_sb600 }, /* ATI SB700 AHCI */
-       { PCI_VDEVICE(ATI, 0x4392), board_ahci_sb600 }, /* ATI SB700 nraid5 */
-       { PCI_VDEVICE(ATI, 0x4393), board_ahci_sb600 }, /* ATI SB700 raid5 */
+       { PCI_VDEVICE(ATI, 0x4390), board_ahci_sb600 }, /* ATI SB700/800 */
+       { PCI_VDEVICE(ATI, 0x4391), board_ahci_sb600 }, /* ATI SB700/800 */
+       { PCI_VDEVICE(ATI, 0x4392), board_ahci_sb600 }, /* ATI SB700/800 */
+       { PCI_VDEVICE(ATI, 0x4393), board_ahci_sb600 }, /* ATI SB700/800 */
+       { PCI_VDEVICE(ATI, 0x4394), board_ahci_sb600 }, /* ATI SB700/800 */
+       { PCI_VDEVICE(ATI, 0x4395), board_ahci_sb600 }, /* ATI SB700/800 */

        /* VIA */
        { PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */

------=_Part_12637_15986271.1190039575792
Content-Type: text/x-patch; name="sb800sata.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sb800sata.patch"
X-Attachment-Id: f_f6p2lv2e

ZGlmZiAtTnVyIGEvZHJpdmVycy9hdGEvYWhjaS5jIGIvZHJpdmVycy9hdGEvYWhjaS5jCi0tLSBh
L2RyaXZlcnMvYXRhL2FoY2kuYwkyMDA3LTA5LTE3IDIyOjA3OjA0LjAwMDAwMDAwMCArMDgwMAor
KysgYi9kcml2ZXJzL2F0YS9haGNpLmMJMjAwNy0wOS0xNyAyMjoxMDo0Ni4wMDAwMDAwMDAgKzA4
MDAKQEAgLTM5OSwxMCArMzk5LDEyIEBACiAKIAkvKiBBVEkgKi8KIAl7IFBDSV9WREVWSUNFKEFU
SSwgMHg0MzgwKSwgYm9hcmRfYWhjaV9zYjYwMCB9LCAvKiBBVEkgU0I2MDAgKi8KLQl7IFBDSV9W
REVWSUNFKEFUSSwgMHg0MzkwKSwgYm9hcmRfYWhjaV9zYjYwMCB9LCAvKiBBVEkgU0I3MDAgSURF
ICovCi0JeyBQQ0lfVkRFVklDRShBVEksIDB4NDM5MSksIGJvYXJkX2FoY2lfc2I2MDAgfSwgLyog
QVRJIFNCNzAwIEFIQ0kgKi8KLQl7IFBDSV9WREVWSUNFKEFUSSwgMHg0MzkyKSwgYm9hcmRfYWhj
aV9zYjYwMCB9LCAvKiBBVEkgU0I3MDAgbnJhaWQ1ICovCi0JeyBQQ0lfVkRFVklDRShBVEksIDB4
NDM5MyksIGJvYXJkX2FoY2lfc2I2MDAgfSwgLyogQVRJIFNCNzAwIHJhaWQ1ICovCisJeyBQQ0lf
VkRFVklDRShBVEksIDB4NDM5MCksIGJvYXJkX2FoY2lfc2I2MDAgfSwgLyogQVRJIFNCNzAwLzgw
MCAqLworCXsgUENJX1ZERVZJQ0UoQVRJLCAweDQzOTEpLCBib2FyZF9haGNpX3NiNjAwIH0sIC8q
IEFUSSBTQjcwMC84MDAgKi8KKwl7IFBDSV9WREVWSUNFKEFUSSwgMHg0MzkyKSwgYm9hcmRfYWhj
aV9zYjYwMCB9LCAvKiBBVEkgU0I3MDAvODAwICovCisJeyBQQ0lfVkRFVklDRShBVEksIDB4NDM5
MyksIGJvYXJkX2FoY2lfc2I2MDAgfSwgLyogQVRJIFNCNzAwLzgwMCAqLworCXsgUENJX1ZERVZJ
Q0UoQVRJLCAweDQzOTQpLCBib2FyZF9haGNpX3NiNjAwIH0sIC8qIEFUSSBTQjcwMC84MDAgKi8K
Kwl7IFBDSV9WREVWSUNFKEFUSSwgMHg0Mzk1KSwgYm9hcmRfYWhjaV9zYjYwMCB9LCAvKiBBVEkg
U0I3MDAvODAwICovCiAKIAkvKiBWSUEgKi8KIAl7IFBDSV9WREVWSUNFKFZJQSwgMHgzMzQ5KSwg
Ym9hcmRfYWhjaV92dDgyNTEgfSwgLyogVklBIFZUODI1MSAqLwo=
------=_Part_12637_15986271.1190039575792--
