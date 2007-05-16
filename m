From: "Henry Su" <henry.su@amd.com>
Subject: =?utf-7?B?K0FGcy1QQVRDSCAzLzQrQUYwLWFkZCB0aGUgSURFIGRldmljZSBJRA==?=
	=?utf-7?B?IGZvciBBVEkgU0I3MDA=?=
Date: Wed, 16 May 2007 14:50:05 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F35860201A4D65F@shacnexch2.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:60590 "EHLO
	outbound3-sin-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752276AbXEPG5x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 02:57:53 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.comBartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

From: henry.su+AEA-amd.com
add the IDE device ids to atiixp+AF8-pci+AF8-tbl struct in atiixp.c for ATI SB700.
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

diff -Nur linux-2.6.21.1.orig/drivers/ide/pci/atiixp.c linux-2.6.21.1/drivers/ide/pci/atiixp.c
--- linux-2.6.21.1.orig/drivers/ide/pci/atiixp.c        2007-05-16 13:27:53.671011000 +-0800
+-+-+- linux-2.6.21.1/drivers/ide/pci/atiixp.c     2007-05-16 13:43:51.952261000 +-0800
+AEAAQA- -353,6 +-353,7 +AEAAQA-
        +AHs- PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP300+AF8-IDE, PCI+AF8-ANY+AF8-ID, PCI+AF8-ANY+AF8-ID, 0, 0, 0+AH0-,
        +AHs- PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP400+AF8-IDE, PCI+AF8-ANY+AF8-ID, PCI+AF8-ANY+AF8-ID, 0, 0, 0+AH0-,
        +AHs- PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-IDE, PCI+AF8-ANY+AF8-ID, PCI+AF8-ANY+AF8-ID, 0, 0, 1+AH0-,
+-       +AHs- PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-IDE, PCI+AF8-ANY+AF8-ID, PCI+AF8-ANY+AF8-ID, 0, 0, 1+AH0-,
        +AHs- 0, +AH0-,
 +AH0AOw-
 MODULE+AF8-DEVICE+AF8-TABLE(pci, atiixp+AF8-pci+AF8-tbl)+ADs-

