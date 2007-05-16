From: "Henry Su" <henry.su@amd.com>
Subject: =?utf-7?B?K0FGcy1QQVRDSCAxLzQrQUYwLSBhZGQgdGhlIFNNQnVzIGRldmljZQ==?=
	=?utf-7?B?IElEIGZvciBBVEkgU0I3MDA=?=
Date: Wed, 16 May 2007 14:40:41 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F35860201A4D655@shacnexch2.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:22083 "EHLO
	outbound3-dub-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759374AbXEPGkv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 02:40:51 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: khali@linux-fr.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, =?utf-7?B?Z21haWwrQUY4LWF0aQ==?= <henry.su.ati@gmail.com>

From: henry.su+AEA-amd.com
add the SMBUS device id for ATI SB700.
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

diff -Nur linux-2.6.21.1.orig/drivers/i2c/busses/i2c-piix4.c linux-2.6.21.1/drivers/i2c/busses/i2c-piix4.c
--- linux-2.6.21.1.orig/drivers/i2c/busses/i2c-piix4.c  2007-05-16 13:27:53.014761000 +-0800
+-+-+- linux-2.6.21.1/drivers/i2c/busses/i2c-piix4.c       2007-05-16 13:40:21.546011000 +-0800
+AEAAQA- -23,7 +-23,7 +AEAAQA-
    Supports:
        Intel PIIX4, 440MX
        Serverworks OSB4, CSB5, CSB6, HT-1000
-       ATI IXP200, IXP300, IXP400, SB600
+-       ATI IXP200, IXP300, IXP400, SB600, SB700
        SMSC Victory66

    Note: we assume there can only be one device, with one SMBus interface.
+AEAAQA- -399,6 +-399,8 +AEAAQA-
          .driver+AF8-data +AD0- 0 +AH0-,
        +AHs- PCI+AF8-DEVICE(PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-SMBUS),
          .driver+AF8-data +AD0- 0 +AH0-,
+-       +AHs- PCI+AF8-DEVICE(PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-SMBUS),
+-         .driver+AF8-data +AD0- 0 +AH0-,
        +AHs- PCI+AF8-DEVICE(PCI+AF8-VENDOR+AF8-ID+AF8-SERVERWORKS, PCI+AF8-DEVICE+AF8-ID+AF8-SERVERWORKS+AF8-OSB4),
          .driver+AF8-data +AD0- 0 +AH0-,
        +AHs- PCI+AF8-DEVICE(PCI+AF8-VENDOR+AF8-ID+AF8-SERVERWORKS, PCI+AF8-DEVICE+AF8-ID+AF8-SERVERWORKS+AF8-CSB5),

