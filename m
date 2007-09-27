From: "Shane Huang" <Shane.Huang@amd.com>
Subject: [patch] SB700 contains more than one IDE channel
Date: Thu, 27 Sep 2007 17:04:23 +0800
Message-ID: <5CAB7B5D6F8AB84AA868A46B47A5070544C164@sshaexmb1.amd.com>
References: <FFECF24D2A7F6D418B9511AF6F3586020209802C@shacnexch2.atitech.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----_=_NextPart_001_01C800E5.65BAF83A"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:51740 "EHLO
	outbound4-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753131AbXI0JEg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 05:04:36 -0400
Content-class: urn:content-classes:message
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F3586020209802C@shacnexch2.atitech.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, gregkh@suse.de, "Su, Henry" <Henry.Su@amd.com>, Shane Huang <Shane.Huang@amd.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C800E5.65BAF83A
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

From: shane.huang@amd.com

SB700 supports one physical IDE channel, but SB700 SATA controller
supports combined mode. When the SATA combined mode is enabled,
two SATA ports(port4 and port5) share one IDE channel from IDE
controller, and PATA will share the other IDE channel.

Our previous patch adding SB700 IDE device ID only support one
IDE channel, which contains bug. The attached patch fix the bug.


Signed-off-by: shane.huang@amd.com
----------------------------------------------
diff -ruN linux-2.6.23-rc5_orig/drivers/ide/pci/atiixp.c
linux-2.6.23-rc5/drivers/ide/pci/atiixp.c
--- linux-2.6.23-rc5_orig/drivers/ide/pci/atiixp.c	2007-09-01
14:08:24.000000000 +0800
+++ linux-2.6.23-rc5/drivers/ide/pci/atiixp.c	2007-09-28
00:35:55.000000000 +0800
@@ -325,7 +325,7 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 1},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);




------_=_NextPart_001_01C800E5.65BAF83A
Content-Type: application/octet-stream;
 name=SB700_2_IDE_Channels.patch
Content-Transfer-Encoding: base64
Content-Description: SB700_2_IDE_Channels.patch
Content-Disposition: attachment;
 filename=SB700_2_IDE_Channels.patch

ZGlmZiAtcnVOIGxpbnV4LTIuNi4yMy1yYzVfb3JpZy9kcml2ZXJzL2lkZS9wY2kvYXRpaXhwLmMg
bGludXgtMi42LjIzLXJjNS9kcml2ZXJzL2lkZS9wY2kvYXRpaXhwLmMKLS0tIGxpbnV4LTIuNi4y
My1yYzVfb3JpZy9kcml2ZXJzL2lkZS9wY2kvYXRpaXhwLmMJMjAwNy0wOS0wMSAxNDowODoyNC4w
MDAwMDAwMDAgKzA4MDAKKysrIGxpbnV4LTIuNi4yMy1yYzUvZHJpdmVycy9pZGUvcGNpL2F0aWl4
cC5jCTIwMDctMDktMjggMDA6MzU6NTUuMDAwMDAwMDAwICswODAwCkBAIC0zMjUsNyArMzI1LDcg
QEAKIAl7IFBDSV9WRU5ET1JfSURfQVRJLCBQQ0lfREVWSUNFX0lEX0FUSV9JWFAzMDBfSURFLCBQ
Q0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCAwfSwKIAl7IFBDSV9WRU5ET1JfSURfQVRJLCBQ
Q0lfREVWSUNFX0lEX0FUSV9JWFA0MDBfSURFLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAw
LCAwfSwKIAl7IFBDSV9WRU5ET1JfSURfQVRJLCBQQ0lfREVWSUNFX0lEX0FUSV9JWFA2MDBfSURF
LCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCAxfSwKLQl7IFBDSV9WRU5ET1JfSURfQVRJ
LCBQQ0lfREVWSUNFX0lEX0FUSV9JWFA3MDBfSURFLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAw
LCAwLCAxfSwKKwl7IFBDSV9WRU5ET1JfSURfQVRJLCBQQ0lfREVWSUNFX0lEX0FUSV9JWFA3MDBf
SURFLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCAwfSwKIAl7IDAsIH0sCiB9OwogTU9E
VUxFX0RFVklDRV9UQUJMRShwY2ksIGF0aWl4cF9wY2lfdGJsKTsK

------_=_NextPart_001_01C800E5.65BAF83A--


