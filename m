From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH] libata-pmp: add schedule timeout to support some PMP
 cards
Date: Fri, 16 Dec 2011 10:58:09 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11652B7B@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1320033440-1106-1-git-send-email-r66093@freescale.com>
 <20111103160759.GI4417@google.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11617501@039-SN1MPN1-005.039d.mgd.msft.net>
 <20111110152036.GB27258@google.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F1161C24D@039-SN1MPN1-005.039d.mgd.msft.net>
 <20111115145111.GK30922@google.com> <4EC2844B.9050904@teksavvy.com>
 <4EC28D7E.7010703@teksavvy.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F1161DF3C@039-SN1MPN1-005.039d.mgd.msft.net>
 <4EC3C6AD.9070706@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:27037
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750921Ab1LPK6O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Dec 2011 05:58:14 -0500
In-Reply-To: <4EC3C6AD.9070706@teksavvy.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

SGksIGhhdmUgeW91IGFueSBmZWVkYmFjayBhYm91dCB5b3VyIFBNUCBjYXJkcz8NCg0KTm93IEkg
bXVzdCBzZW5kIG91dCB0aGUgcGF0Y2ggdG8gc3VwcG9ydCB0aGUgSk1QMzkzIFBNUCBjYXJkLg0K
TWF5YmUgSSB3aWxsIHNpbXBseSB0byBkZWxheSB0aGUgZW5vdWdoIHRpbWUgZm9yIFBNUCBTQ1Ig
YXMgdGhlIGJlbG93Og0KDQpzZXRfY3VycmVudF9zdGF0ZShUQVNLX0lOVEVSUlVQVElCTEUpOw0K
c2NoZWR1bGVfdGltZW91dChtc2Vjc190b19qaWZmaWVzKDUwKSk7IC8qIHNsZWVwIDUwIG1zZWNv
bmQgKi8NCg0KZXJyX21hc2sgPSBzYXRhX3BtcF9yZWFkKGxpbmssIHJlZywgcl92YWwpOw0KDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyayBMb3JkIFttYWlsdG86
a2VybmVsQHRla3NhdnZ5LmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxNiwgMjAx
MSAxMDoyMCBQTQ0KPiBUbzogSHVhbmcgQ2hhbmdtaW5nLVI2NjA5Mw0KPiBDYzogVGVqdW4gSGVv
OyBsaW51eC1pZGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGxpYmF0
YS1wbXA6IGFkZCBzY2hlZHVsZSB0aW1lb3V0IHRvIHN1cHBvcnQgc29tZSBQTVANCj4gY2FyZHMN
Cj4gDQo+IE9uIDExLTExLTE2IDA0OjAwIEFNLCBIdWFuZyBDaGFuZ21pbmctUjY2MDkzIHdyb3Rl
Og0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBNYXJrIExvcmQg
W21haWx0bzprZXJuZWxAdGVrc2F2dnkuY29tXQ0KPiAuLg0KPiA+Pj4gV2hhdCdzIHRoZSBwYXRj
aCB0aGF0IEkgbmVlZCB0byB0ZXN0ID8NCj4gPj4NCj4gPj4gRm91bmQgaXQsIHRyaWVkIGl0LCBz
dGlsbCBoYXZlIGEgTGludXggZG9vcnN0b3AuDQo+ID4+IFdvcmtzIGZpbmUgdW5kZXIgdGhhdCBv
dGhlciBPL1MgdGhvdWdoLg0KPiA+Pg0KPiA+IFRoYXTigJlzIGEgYmFkIG5ld3MuIEkgdGhpbmsg
d2UgbmVlZCBvbmUgd29ya2Fyb3VuZCB0byBmaXggaXQuDQo+ID4gSSB0ZXN0ZWQgdGhlIG90aGVy
IHR3byBQTVAgY2FyZHMsIHRoZXkgd29yayB3ZWxsIG9uIEZyZWVzY2FsZSdzIGJvYXJkOg0KPiA+
IFBvcnQgTXVsdGlwbGllciAxLjEsIDB4MTA5NToweDQ3MjYgcjMxLCA3IHBvcnRzLCBmZWF0IDB4
MS8weDkgKFNpbGljb24NCj4gSW1hZ2UpDQo+ID4gUG9ydCBNdWx0aXBsaWVyIDEuMiwgMHgxOTdi
OjB4MDMyMSByMCwgNSBwb3J0cywgZmVhdCAweDUvMHhmIChKTUIzOTEpDQo+IA0KPiANCj4gTm8g
d29ycmllcyAtLSBJJ20ganVzdCB0cnlpbmcgdG8gZ2V0IG15IEpNQiBQTVAgdG8gd29yayBvbiB4
ODYuDQo+IFlvdXIgcGF0Y2ggbWF5IHN0aWxsIGJlIGdvb2QgYW5kIG5lY2Vzc2FyeSBmb3IgRnJl
ZXNjYWxlOyBkdW5uby4NCj4gDQo+IENoZWVycw0KDQo=

