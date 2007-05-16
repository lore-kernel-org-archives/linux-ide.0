From: "Henry Su" <henry.su@amd.com>
Subject: =?utf-7?B?K0FGcy1QQVRDSCAyLzQrQUYwLSBhZGQgdGhlIElERSBhbmQgU0FUQQ==?=
	=?utf-7?B?IGRldmljZSBJRHMgZm9yIEFUSSBTQjcwMC4=?=
Date: Wed, 16 May 2007 14:47:36 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F35860201A4D65B@shacnexch2.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:32585 "EHLO
	outbound2-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755103AbXEPGro (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 02:47:44 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

From: henry.su+AEA-amd.com
add the IDE and SATA device ids for ATI SB700.
Signed-off-by: Luugi Marsan +ADw-luugi.marsan+AEA-amd.com+AD4-
-----------------------------------------------------
diff -Nur linux-2.6.21.1.orig/include/linux/pci+AF8-ids.h linux-2.6.21.1/include/linux/pci+AF8-ids.h
--- linux-2.6.21.1.orig/include/linux/pci+AF8-ids.h 2007-05-16 13:28:54.405386000 +-0800
+-+-+- linux-2.6.21.1/include/linux/pci+AF8-ids.h      2007-05-16 13:45:29.936636000 +-0800
+AEAAQA- -371,6 +-371,9 +AEAAQA-
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-SRAID 0x4381
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-SMBUS 0x4385
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-IDE   0x438c
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-SATA  0x4390
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-SMBUS 0x4395
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-IDE   0x439c

 +ACM-define PCI+AF8-VENDOR+AF8-ID+AF8-VLSI             0x1004
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-VLSI+AF8-82C592      0x0005

diff -Nur linux-2.6.21.1.orig/drivers/ata/pata+AF8-atiixp.c linux-2.6.21.1/drivers/ata/pata+AF8-atiixp.c
--- linux-2.6.21.1.orig/drivers/ata/pata+AF8-atiixp.c       2007-05-16 13:27:49.764761000 +-0800
+-+-+- linux-2.6.21.1/drivers/ata/pata+AF8-atiixp.c    2007-05-16 13:37:47.014761000 +-0800
+AEAAQA- -283,6 +-283,7 +AEAAQA-
        +AHs- PCI+AF8-VDEVICE(ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP300+AF8-IDE), +AH0-,
        +AHs- PCI+AF8-VDEVICE(ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP400+AF8-IDE), +AH0-,
        +AHs- PCI+AF8-VDEVICE(ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-IDE), +AH0-,
+-       +AHs- PCI+AF8-VDEVICE(ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-IDE), +AH0-,

        +AHs- +AH0-,
 +AH0AOw-

diff -Nur linux-2.6.21.1.orig/drivers/ata/ahci.c linux-2.6.21.1/drivers/ata/ahci.c
--- linux-2.6.21.1.orig/drivers/ata/ahci.c      2007-05-16 13:27:49.717886000 +-0800
+-+-+- linux-2.6.21.1/drivers/ata/ahci.c   2007-05-16 13:42:40.155386000 +-0800
+AEAAQA- -415,6 +-415,7 +AEAAQA-
        /+ACo- ATI +ACo-/
        +AHs- PCI+AF8-VDEVICE(ATI, 0x4380), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB600 non-raid +ACo-/
        +AHs- PCI+AF8-VDEVICE(ATI, 0x4381), board+AF8-ahci +AH0-, /+ACo- ATI SB600 raid +ACo-/
+-       +AHs- PCI+AF8-VDEVICE(ATI, 0x4390), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB700 non-raid +ACo-/

        /+ACo- VIA +ACo-/
        +AHs- PCI+AF8-VDEVICE(VIA, 0x3349), board+AF8-ahci+AF8-vt8251 +AH0-, /+ACo- VIA VT8251 +ACo-/

