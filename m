From: "Yasuhiro Harada" <poplife.h@gmail.com>
Subject: VT8237A SATA and VT8521 PATA
Date: Thu, 28 Dec 2006 18:40:11 +0900
Message-ID: <34c008b80612280140y13b315e1p7389935c89a85a20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_115035_21066620.1167298811453"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:34777 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932805AbWL1JkM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Dec 2006 04:40:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4088935uga
        for <linux-ide@vger.kernel.org>; Thu, 28 Dec 2006 01:40:11 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

------=_Part_115035_21066620.1167298811453
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I checked ECS P4M900T(VT8237A) mainboard,
This mainboad has SATA controller vt8237a,
and my SATA HDD was not found.

I checked sata_via.c and result of lspci,
and seems it doesn't have pci_device_id.
I add pci_device_id 0x5337 to sata_via.c.
it works very fine.


and I also checked ASUS P5V800MX REV1.04G (vt8521)
PATA CDROM was not found on this mainboard.
I tried same way, add pci_device_id, works well too.


attempt patch to kernel 2.6.19 .
if you have same problem, try to this patch.


Yasuhiro Harada

------=_Part_115035_21066620.1167298811453
Content-Type: text/x-patch; name=pata_via.c.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ew8zfwzs
Content-Disposition: attachment; filename="pata_via.c.patch"

LS0tIGxpbnV4LTIuNi4xOS9kcml2ZXJzL2F0YS9wYXRhX3ZpYS5jLm9sZAkyMDA2LTExLTMwIDA2
OjU3OjM3LjAwMDAwMDAwMCArMDkwMAorKysgbGludXgtMi42LjE5L2RyaXZlcnMvYXRhL3BhdGFf
dmlhLmMJMjAwNi0xMi0yOCAxNzo1OToxMC4wMDAwMDAwMDAgKzA5MDAKQEAgLTk0LDYgKzk0LDcg
QEAKIAl1OCByZXZfbWF4OwogCXUxNiBmbGFnczsKIH0gdmlhX2lzYV9icmlkZ2VzW10gPSB7CisJ
eyAidnQ4MjUxIiwJUENJX0RFVklDRV9JRF9WSUFfODI1MSwgICAgIDB4MDAsIDB4MmYsIFZJQV9V
RE1BXzEzMyB8IFZJQV9CQURfQVNUIH0sCiAJeyAiY3g3MDAiLAlQQ0lfREVWSUNFX0lEX1ZJQV9D
WDcwMCwgICAgMHgwMCwgMHgyZiwgVklBX1VETUFfMTMzIHwgVklBX0JBRF9BU1QgfSwKIAl7ICJ2
dDY0MTAiLAlQQ0lfREVWSUNFX0lEX1ZJQV82NDEwLCAgICAgMHgwMCwgMHgyZiwgVklBX1VETUFf
MTMzIHwgVklBX0JBRF9BU1QgfCBWSUFfTk9fRU5BQkxFU30sCiAJeyAidnQ4MjM3YSIsCVBDSV9E
RVZJQ0VfSURfVklBXzgyMzdBLCAgICAweDAwLCAweDJmLCBWSUFfVURNQV8xMzMgfCBWSUFfQkFE
X0FTVCB9LAo=
------=_Part_115035_21066620.1167298811453
Content-Type: text/x-patch; name=sata_via.c.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ew8zg3gt
Content-Disposition: attachment; filename="sata_via.c.patch"

LS0tIGxpbnV4LTIuNi4xOS9kcml2ZXJzL2F0YS9zYXRhX3ZpYS5jLm9sZAkyMDA2LTEyLTI4IDE3
OjQ5OjU1LjAwMDAwMDAwMCArMDkwMAorKysgbGludXgtMi42LjE5L2RyaXZlcnMvYXRhL3NhdGFf
dmlhLmMJMjAwNi0xMi0yOCAxNzo1MTozOC4wMDAwMDAwMDAgKzA5MDAKQEAgLTc3LDYgKzc3LDcg
QEAKIHN0YXRpYyB2b2lkIHZ0NjQyMF9lcnJvcl9oYW5kbGVyKHN0cnVjdCBhdGFfcG9ydCAqYXAp
OwogCiBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgc3ZpYV9wY2lfdGJsW10gPSB7
CisJeyBQQ0lfVkRFVklDRShWSUEsIDB4NTMzNyksIHZ0NjQyMCB9LAogCXsgUENJX1ZERVZJQ0Uo
VklBLCAweDA1OTEpLCB2dDY0MjAgfSwKIAl7IFBDSV9WREVWSUNFKFZJQSwgMHgzMTQ5KSwgdnQ2
NDIwIH0sCiAJeyBQQ0lfVkRFVklDRShWSUEsIDB4MzI0OSksIHZ0NjQyMSB9LAo=
------=_Part_115035_21066620.1167298811453--
