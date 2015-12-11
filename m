From: "Andy Falanga (afalanga)" <afalanga@micron.com>
Subject: pointer arithmetic on void *
Date: Fri, 11 Dec 2015 00:42:09 +0000
Message-ID: <566A1B99.6040200@micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.micron.com ([137.201.242.129]:31595 "EHLO
	mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbbLKAmM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Dec 2015 19:42:12 -0500
Received: from mail.micron.com (bowex36-c.micron.com [137.201.85.143])
	by mailout.micron.com (8.14.4/8.14.6) with ESMTP id tBB0gAoI019870
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Thu, 10 Dec 2015 17:42:10 -0700
Content-Language: en-US
Content-ID: <6A20649C7E9A2E43B9A1C1829D2C729E@micron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

SSdtIHdvcmtpbmcgb24gdW5kZXJzdGFuZGluZyB0aGUgZmluYWwgcmVzdWx0IG9mIHRoaXMgY29k
ZSBmcm9tIGFoY2kuYyANCihpdCdzIGxpYmFoY2kuYyBpbiBuZXdlciBrZXJuZWxzKToNCg0Kc3Ry
dWN0IGF0YV9xdWV1ZWRfY21kIHsNCiAgICAgLi4uDQogICAgIHVuc2lnbmVkIGludCB0YWc7DQog
ICAgIC4uLg0KfTsNCg0Kc3RydWN0IGFoY2lfcG9ydF9wcml2IHsNCiAgICAgLi4uDQogICAgIHZv
aWQgKmNtZF90Ymw7DQogICAgIGRtYV9hZGRyX3QgY21kX3RibF9kbWE7DQogICAgIC4uLg0KfTsN
Cg0Kc3RhdGljIHZvaWQgIGFoY2lfcWNfcHJlcCggc3RydWN0IGF0YV9xdWV1ZWRfY21kICpxYykN
CnsNCiAgICAgLi4uDQogICAgIGNtZF90YmwgPSBwcC0+Y21kX3RibCArIHFjLT50YWcgKiBBSENJ
X0NNRF9UQkxfU1o7DQogICAgIC4uLg0KfQ0KDQpxYyBpcyBhIHN0cnVjdCBhdGFfcXVldWVkX2Nt
ZCBvYmplY3QuICBJJ20gYXNzdW1pbmcgcWMtPnRhZyBpcyB0aGUgUHhDSSANCnNsb3QgbnVtYmVy
IHdoaWNoIHdhcyBmb3VuZCB0byBiZSBmcmVlIGZvciB0aGlzIGNvbW1hbmQuIFBsZWFzZSBjb3Jy
ZWN0IA0KbWUgaWYgSSdtIHdyb25nLiAgRnVydGhlcm1vcmUsIEFIQ0lfQ01EX1RCTF9TWiBpcyBk
ZWZpbmVkIGFzDQoNCmVudW0gew0KICAgICAuLi4NCiAgICAgQUhDSV9NQVhfU0cgICAgICAgID0g
MTY4LCAvKiBoYXJkd2FyZSBtYXggaXMgNjRLICovDQogICAgIC4uLg0KICAgICBBSENJX0NNRF9U
QkxfSERSX1NaICAgID0gMHg4MCwNCiAgICAgQUhDSV9DTURfVEJMX1NaICAgICAgICA9IEFIQ0lf
Q01EX1RCTF9IRFJfU1ogKyAoQUhDSV9NQVhfU0cgKiAxNiksDQogICAgIC4uLg0KfQ0KDQpUaGUg
Zmlyc3QgcXVlc3Rpb24gaXMsIGdpdmVuIHRoZSBhYm92ZSBkZWZpbml0aW9uIGZvciBBSENJX01B
WF9TRywgaXMgDQp0aGlzIGEgbGltaXRhdGlvbiBmcm9tIHdpdGhpbiB0aGUgTGludXgga2VybmVs
PyAgVGhlIGNvbW1lbnQgYWxsdWRlcyB0byANCnRoaXMgYW5kIHRoZSBzcGVjIHNheXMgNjRrIGFy
ZSBhbGxvd2VkLg0KDQpOZXh0LCBpcyBxYy0+dGFnIHRoZSBQeENJIHNsb3QgKG9wZW4gY29tbWFu
ZCBzbG90KT8gIFNlY29uZCwgaXMgdGhpcyANCmFyaXRobWV0aWMgc3VwcG9zZWQgdG8gZ2V0IG1l
IHRvIHRoZSBzdGFydCBvZiBhIG5ldyBjb21tYW5kPw0KDQpBbmR5
