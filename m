From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] mn10300: add pci_get_legacy_ide_irq() to <asm/pci.h>
Date: Mon, 19 Jan 2009 14:04:51 +0100
Message-ID: <200901191404.51686.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: base64
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:42026 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759914AbZASNJ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 08:09:26 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, David Howells <dhowells@redhat.com>

RnJvbTogQmFydGxvbWllaiBab2xuaWVya2lld2ljeiA8YnpvbG5pZXJAZ21haWwuY29tPgpTdWJq
ZWN0OiBbUEFUQ0hdIG1uMTAzMDA6IGFkZCBwY2lfZ2V0X2xlZ2FjeV9pZGVfaXJxKCkgdG8gPGFz
bS9wY2kuaD4KCkFkZCBtaXNzaW5nIHBjaV9nZXRfbGVnYWN5X2lkZV9pcnEoKSBpbXBsZW1lbnRh
dGlvbgpiZWZvcmUgaXQgYmVjb21lcyByZXF1aXJlZCBieSBjb3JlIElERSBQQ0kgY29kZS4KCkNj
OiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBCYXJ0
bG9taWVqIFpvbG5pZXJraWV3aWN6IDxiem9sbmllckBnbWFpbC5jb20+Ci0tLQogaW5jbHVkZS9h
c20tbW4xMDMwMC9wY2kuaCB8ICAgIDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKykKCkluZGV4OiBiL2luY2x1ZGUvYXNtLW1uMTAzMDAvcGNpLmgKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0g
YS9pbmNsdWRlL2FzbS1tbjEwMzAwL3BjaS5oCisrKyBiL2luY2x1ZGUvYXNtLW1uMTAzMDAvcGNp
LmgKQEAgLTEyMSw0ICsxMjEsOSBAQCBwY2liaW9zX3NlbGVjdF9yb290KHN0cnVjdCBwY2lfZGV2
ICpwZGV2CiAKICNkZWZpbmUgcGNpYmlvc19zY2FuX2FsbF9mbnMoYSwgYikJMAogCitzdGF0aWMg
aW5saW5lIGludCBwY2lfZ2V0X2xlZ2FjeV9pZGVfaXJxKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGlu
dCBjaGFubmVsKQoreworCXJldHVybiBjaGFubmVsID8gMTUgOiAxNDsKK30KKwogI2VuZGlmIC8q
IF9BU01fUENJX0ggKi8KAAo=
