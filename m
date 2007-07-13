From: "Henry Su" <henry.su@amd.com>
Subject: =?utf-7?B?K0FGcy1wYXRjaCtBRjAtIEFkZCBtb3JlIGRldmljZSBJRHMgZm9yIA==?=
	=?utf-7?B?c3VwcG9ydGluZyBBVEkgU0I3MDAgU0FUQSBjb250cm8=?=
	=?utf-7?B?bGxlciBjb21wbGV0ZWx5IA==?=
Date: Fri, 13 Jul 2007 11:08:12 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F35860202098043@shacnexch2.atitech.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C7C4FB.0CB390CF"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:57486 "EHLO
	outbound1-blu-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754957AbXGMDKD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jul 2007 23:10:03 -0400
Received: from outbound1-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound1-blu-R.bigfish.com (Postfix) with ESMTP id 1E82C1288519
	for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 03:08:44 +0000 (UTC)
Received: from mail19-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound1-blu.bigfish.com (Postfix) with ESMTP id 0D8CF12E004C
	for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 03:08:44 +0000 (UTC)
Received: from mail19-blu (localhost.localdomain [127.0.0.1])
	by mail19-blu-R.bigfish.com (Postfix) with ESMTP id C3379E38146
	for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 03:08:43 +0000 (UTC)
Received: from mail4.ati.com (h209-50-91-134.gtconnect.net [209.50.91.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail19-blu.bigfish.com (Postfix) with ESMTP id 8609810067
	for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 03:08:29 +0000 (UTC)
Received: from ltmailgen01.ati.com (ltmailgen01.ati.com [172.24.7.235])
	by mail4.ati.com (8.13.1/8.13.1) with ESMTP id l6D38H0X012082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 12 Jul 2007 23:08:17 -0400
Received: from torcaexgw4.atitech.com (torcaexgw4.atitech.com [172.24.5.245])
	by ltmailgen01.ati.com (8.13.1/8.13.1) with ESMTP id l6D38Hp9030996
	for <linux-ide@vger.kernel.org>; Thu, 12 Jul 2007 23:08:17 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7C4FB.0CB390CF
Content-Type: text/plain;
	charset="utf-7"
Content-Transfer-Encoding: 7bit

From: henry.su+AEA-amd.com

The sata controller device ID will be different according to the onchip
 sata type setting in system BIOS:
Device                                                                 Device ID
SATA in IDE mode                                             0x4390
SATA in AHCI mode                                           0x4391
SATA in RAID mode with non-Raid 5 driver  0x4392
SATA in RAID mode with Raid 5 driver          0x4393

Signed-off-by: henry.su+AEA-amd.com
----------------------------------------------
diff -Nur linux-2.6.22.1.orig/drivers/ata/ahci.c linux-2.6.22.1/drivers/ata/ahci.c
--- linux-2.6.22.1.orig/drivers/ata/ahci.c      2007-07-13 10:39:27.854093200 +-0800
+-+-+- linux-2.6.22.1/drivers/ata/ahci.c   2007-07-13 10:52:58.625022700 +-0800
+AEAAQA- -399,7 +-399,10 +AEAAQA-

        /+ACo- ATI +ACo-/
        +AHs- PCI+AF8-VDEVICE(ATI, 0x4380), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB600 +ACo-/
-       +AHs- PCI+AF8-VDEVICE(ATI, 0x4390), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB700 +ACo-/
+-       +AHs- PCI+AF8-VDEVICE(ATI, 0x4390), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB700 IDE +ACo-/
+-       +AHs- PCI+AF8-VDEVICE(ATI, 0x4391), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB700 AHCI +ACo-/
+-       +AHs- PCI+AF8-VDEVICE(ATI, 0x4392), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB700 nor-raid5 +ACo-/
+-       +AHs- PCI+AF8-VDEVICE(ATI, 0x4393), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB700 raid5 +ACo-/

        /+ACo- VIA +ACo-/
        +AHs- PCI+AF8-VDEVICE(VIA, 0x3349), board+AF8-ahci+AF8-vt8251 +AH0-, /+ACo- VIA VT8251 +ACo-/

------_=_NextPart_001_01C7C4FB.0CB390CF
Content-Type: application/octet-stream;
	name="sb700sataids.patch"
Content-Transfer-Encoding: base64
Content-Description: sb700sataids.patch
Content-Disposition: attachment;
	filename="sb700sataids.patch"

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

------_=_NextPart_001_01C7C4FB.0CB390CF--

