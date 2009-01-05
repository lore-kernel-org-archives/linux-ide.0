From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: can't use SSD/non-rotational queue flag for all CFA devices
Date: Mon, 5 Jan 2009 19:51:28 +0100
Message-ID: <200901051951.29692.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: base64
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:42420 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbZAESxW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 13:53:22 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

RnJvbTogQmFydGxvbWllaiBab2xuaWVya2lld2ljeiA8YnpvbG5pZXJAZ21haWwuY29tPgpTdWJq
ZWN0OiBbUEFUQ0hdIGlkZTogY2FuJ3QgdXNlIFNTRC9ub24tcm90YXRpb25hbCBxdWV1ZSBmbGFn
IGZvciBhbGwgQ0ZBIGRldmljZXMKClNvbWUgcm90YXRpbmcgZGlza3MgYWxzbyBwcmVzZW50IHRo
ZW1zZWx2ZXMgYXMgQ0ZBIGRldmljZXMuCgpSZXBvcnRlZC1ieTogQWxhbiBDb3ggPGFsYW5AbHhv
cmd1ay51a3V1Lm9yZy51az4KU2lnbmVkLW9mZi1ieTogQmFydGxvbWllaiBab2xuaWVya2lld2lj
eiA8YnpvbG5pZXJAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvaWRlL2lkZS1kaXNrLmMgfCAgICAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCkluZGV4
OiBiL2RyaXZlcnMvaWRlL2lkZS1kaXNrLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gYS9kcml2ZXJzL2lkZS9p
ZGUtZGlzay5jCisrKyBiL2RyaXZlcnMvaWRlL2lkZS1kaXNrLmMKQEAgLTYzMyw3ICs2MzMsNyBA
QCBzdGF0aWMgdm9pZCBpZGVfZGlza19zZXR1cChpZGVfZHJpdmVfdCAqCiAJcHJpbnRrKEtFUk5f
SU5GTyAiJXM6IG1heCByZXF1ZXN0IHNpemU6ICVkS2lCXG4iLCBkcml2ZS0+bmFtZSwKIAkJcS0+
bWF4X3NlY3RvcnMgLyAyKTsKIAotCWlmIChhdGFfaWRfaXNfc3NkKGlkKSB8fCBhdGFfaWRfaXNf
Y2ZhKGlkKSkKKwlpZiAoYXRhX2lkX2lzX3NzZChpZCkpCiAJCXF1ZXVlX2ZsYWdfc2V0X3VubG9j
a2VkKFFVRVVFX0ZMQUdfTk9OUk9ULCBxKTsKIAogCS8qIGNhbGN1bGF0ZSBkcml2ZSBjYXBhY2l0
eSwgYW5kIHNlbGVjdCBMQkEgaWYgcG9zc2libGUgKi8KAAo=
