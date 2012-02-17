From: Liu Qiang-B32616 <B32616@freescale.com>
Subject: RE: [PATCH V2 RESEND] fsl-sata: I/O load balancing
Date: Fri, 17 Feb 2012 03:30:36 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB702C9DB@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1329284944-17943-1-git-send-email-qiang.liu@freescale.com>
	 <1329439216.2892.36.camel@pasglop>
	 <BCB48C05FCE8BC4D9E61E841ECBE6DB702B97D@039-SN2MPN1-013.039d.mgd.msft.net>
 <1329448660.2892.42.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:39790
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751395Ab2BQDam (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Feb 2012 22:30:42 -0500
In-Reply-To: <1329448660.2892.42.camel@pasglop>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCZW5qYW1pbiBIZXJyZW5zY2ht
aWR0IFttYWlsdG86YmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnXQ0KPiBTZW50OiBGcmlkYXksIEZl
YnJ1YXJ5IDE3LCAyMDEyIDExOjE4IEFNDQo+IFRvOiBMaXUgUWlhbmctQjMyNjE2DQo+IENjOiBq
Z2FyemlrQHBvYm94LmNvbTsgbGludXgtaWRlQHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtDQo+
IGRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJFOiBbUEFUQ0ggVjIgUkVTRU5EXSBmc2wtc2F0YTogSS9PIGxvYWQgYmFsYW5jaW5n
DQo+IA0KPiBPbiBGcmksIDIwMTItMDItMTcgYXQgMDE6NTQgKzAwMDAsIExpdSBRaWFuZy1CMzI2
MTYgd3JvdGU6DQo+ID4gVGhlIGRlZmF1bHQgd2lsbCBiZSBzZXQgaW4gYSBjb21tb24gaW50ZXJm
YWNlDQo+ID4gZnNsX3NhdGFfc2V0X2lycV9jb2FsZXNjaW5nIHdoZW4gaW5pdGlhbGl6ZSB0aGUg
Y29udHJvbGxlci4gVGhpcw0KPiA+IGludGVyZmFjZSB3aWxsIGNoZWNrIHRoZSByYW5nZSBvZiBp
bnRyIGNvdW50IGFuZCB0aWNrcyBhbmQgbWFrZSBzdXJlDQo+IHRoZSB2YWx1ZXMgYXJlIHJlYXNv
bmFibHkuDQo+IA0KPiBBbGxyaWdodCwgYnV0IHRoZSBjdXJyZW50IGRlZmF1bHRzIGFyZSBiYXNp
Y2FsbHkgbm8gY29hbGVzY2luZyByaWdodCA/DQo+IA0KPiA+IEl0J3MgaGFyZCB0byBmaW5kIGEg
YWdncmVzc2l2ZSB2YWx1ZSB0byBhZGFwdCBhbGwgc2NlbmFyaW9zLCBzbyBJIHVzZQ0KPiA+IGVj
aG8gdG8gYWRqdXN0IHRoZSB2YWx1ZS4gSSByZW1lbWJlciBQNTAyMCBoYXZlIHNvbWUgcGVyZm9y
bWFuY2UgaXNzdWUsDQo+IEkgd2lsbCBjaGVjayBpdC4NCj4gPiBCVFcsIHdoaWNoIGZpbGVzeXN0
ZW0gZG8geW91IHVzZT8gRXh0MiBpcyBsb3dlciB0aGFuIGV4dDQgYmVjYXVzZQ0KPiA+IG1ldGFk
YXRhIGlzIGNvbnRpbnVvdXNseSB3cm90ZSB0byBkaXNrLiBZb3UgY2FuIHRyeSBleHQ0IG9yIHhm
cy4NCj4gDQo+IGV4dDMgYXQgdGhlIG1vbWVudCwgSSBwbGFuIHRvIHN3aXRjaCB0byBleHQ0IHdo
ZW4gSSBmaW5pc2ggdGhhdCBmc2NrIHBhc3MNCj4gd2hpY2ggaXMgdGFraW5nIGhvdXJzLi4uIEkg
YW0gbm90IGF3YXJlIG9mIHRoZSA1MDIwIHBlcmZvcm1hbmNlIGlzc3VlcywNCj4gaXMgdGhpcyBz
b21ldGhpbmcgZG9jdW1lbnRlZCBhbmQvb3IgZml4YWJsZSA/DQo+IA0KDQpNeSBwYXRjaCBtYXkg
bm90IG1lZXQgeW91ciByZXF1aXJlbWVudDooDQpGb3IgeW91ciBwZXJmb3JtYW5jZSByZXF1aXJl
bWVudCwgSSBzdWdnZXN0IHVzZSBleHQ0IGZpbGVzeXN0ZW0gYW5kIFNTRC4NCg0KVGhhbmtzLg0K
DQo+IENoZWVycywNCj4gQmVuLg0KPiANCj4gDQoNCg==

