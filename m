From: "Andy Falanga (afalanga)" <afalanga@micron.com>
Subject: how to issue an ATA command
Date: Mon, 22 Jun 2015 19:02:41 +0000
Message-ID: <1434999754.17290.8.camel@afalanga4.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.micron.com ([137.201.242.129]:25572 "EHLO
	mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbbFVTCo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jun 2015 15:02:44 -0400
Received: from mail.micron.com (ntxboicas01.micron.com [137.201.84.60])
	by mailout.micron.com (8.14.4/8.14.6) with ESMTP id t5MJ2goG020436
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Mon, 22 Jun 2015 13:02:43 -0600
Content-Language: en-US
Content-ID: <37EEE608C991EA46BC1FF1AE32AA35B1@micron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>

SGksDQoNCkknbSB3cml0aW5nIGEgY2hhcmFjdGVyIGRyaXZlciB3aGljaCBpcyBtZWFudCB0byBh
Y3QgYXMgYSBwYXNzLXRocm91Z2gNCmZyb20gdXNlciBzcGFjZSB0byB0aGUgYWhjaSBkcml2ZXIu
ICBVc2luZyB0aGUgMi42LjMyIGtlcm5lbCAoQ2VudE9TIDYpLA0KSSd2ZSBleHBvcnRlZCBhaGNp
X3FjX2lzc3VlKCkgKGluIGFoY2kuYyB0aGUgTExERCwgd2hpY2ggYXBwZWFycyB0byBiZQ0Kc29t
ZXRoaW5nIFJIIGJhY2twb3J0ZWQgYmVjYXVzZSBJJ20gbm90IGZpbmRpbmcgdGhlIHN5bWJvbCBh
dCB0aGUgbHhyDQpzaXRlIEkgdXNlIGZvciAyLjYuMzIpIHNvIHRoYXQgbXkgdXBwZXIgbGF5ZXIg
ZHJpdmVyIGNhbiB0YWxrIHRvIHRoZSBMTC4NCkkndmUgbW9kaWZpZWQgZW5vdWdoIHRoYXQgSSBj
YW4gcGVlay9wb2tlIHJlZ2lzdGVycyBvbiB0aGUgSEJBIHVzaW5nDQppb2N0bHMuICBOb3csIGl0
J3Mgb250byB0aGUgbmV4dCB0YXNrIHdoaWNoIGlzIGFsbG93aW5nIHVzZXJzIHRvIGlzc3VlDQpB
VEEgY29tbWFuZHMgdGhyb3VnaCB0aGlzIGRyaXZlci4gIEkgbmVlZCB0byBiZSBhYmxlIHRvIGRv
IHNvIHVzaW5nDQp0aGlzLCBhcyBvcHBvc2VkIHRvIHNnLCBiZWNhdXNlIHdlIHRydWx5IHdhbnQg
YSBwYXNzLXRocm91Z2ggZHJpdmVyDQp3aGljaCB3aWxsIGJ5IHBhc3MgdGhlIHJlc3Qgb2YgdGhl
IGtlcm5lbCBpbiB0aGlzIGFyZWEuICBXZSBhbHNvIGhhdmUgYQ0KbmVlZCBmb3IgaXNzdWluZyBj
b21tYW5kcyB1bmRlciBjaXJjdW1zdGFuY2VzIHdoaWNoIHByZXZlbnQgdGhlIGV4aXN0aW5nDQpk
cml2ZXJzIGZyb20gbWFraW5nIGRldmljZSBub2RlcyAoaS5lLiAvZGV2L3NnTikgZm9yIHRoZSBk
cml2ZSB1bmRlcg0Kc2NydXRpbnkuICBUaHVzLCBteSB1cHBlciBsYXllciBkcml2ZXIgbWFrZXMg
YSBkZXZpY2Ugbm9kZSBmb3IgZWFjaCBwb3J0DQpvbiB0aGUgSEJBLg0KDQpOb3csIEknbSBleGFt
aW5pbmcgdGhlIGF0YV9xdWV1ZWRfY21kIHN0cnVjdHVyZQ0KaHR0cDovL2x4ci5mcmVlLWVsZWN0
cm9ucy5jb20vc291cmNlL2luY2x1ZGUvbGludXgvbGliYXRhLmg/dj0yLjYuMzIjTDU0MSBidXQg
dGhpcyByYWlzZXMgbWFueSBxdWVzdGlvbnMuICBXaGljaCBmaWVsZHMgbXVzdCBJIGNoZWNrL3Nl
dD8gIFdoYXQgaXMgbmVjZXNzYXJ5IGFuZCB3aGF0IG1heSBiZSBpZ25vcmVkPyAgQW55IGhlbHAv
Z3VpZGFuY2Ugb24gdGhpcyBpcyBncmVhdGx5IGFwcHJlY2lhdGVkLg0KDQpBbmR5DQo=
--
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
