From: "Dorau, Lukasz" <lukasz.dorau@intel.com>
Subject: RE: Support for 4 KiB disk sectors in Linux kernel
Date: Fri, 27 Apr 2012 12:14:58 +0000
Message-ID: <D9FFE20C522965449E182ACE73889AEB1860718E@IRSMSX101.ger.corp.intel.com>
References: <4F9170FB.7080208@intel.com>
 <yq17gxa1iwc.fsf@sermon.lab.mkp.net> <4F919B55.2020802@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:4258 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565Ab2D0MPH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Apr 2012 08:15:07 -0400
In-Reply-To: <4F919B55.2020802@fold.natur.cuni.cz>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

T24gRnJpZGF5LCBBcHJpbCAyMCwgMjAxMiA3OjIyIFBNIE1hcnRpbiBNb2tyZWpzIHdyb3RlOg0K
PiANCj4gTWFydGluIEsuIFBldGVyc2VuIHdyb3RlOg0KPiA+Pj4+Pj4gIkx1a2FzeiIgPT0gTHVr
YXN6IERvcmF1IDxsdWthc3ouZG9yYXVAaW50ZWwuY29tPiB3cml0ZXM6DQo+ID4NCj4gPiBMdWth
c3o+IFdoZXJlIGNhbiBJIGZpbmQgaW5mb3JtYXRpb24gYWJvdXQgY3VycmVudCBzdGF0dXMgb2Yg
c3VwcG9ydCBmb3INCj4gPiBMdWthc3o+IDQgS2lCIGRpc2sgc2VjdG9ycyBpbiBMaW51eCBrZXJu
ZWw/ICBJcyB0aGVyZSBhDQo+ID4gTHVrYXN6PiBsZWFkZXIvbWFpbnRhaW5lciBvZiB0aGlzIGlz
c3VlIGluIGNvbW11bml0eT8NCj4gPg0KPiA+IFdlIGhhdmUgc3VwcG9ydGVkIDRLbiBmb3IgYSBk
ZWNhZGUuIDUxMmUgb2J2aW91c2x5IHdvcmtzIG91dCBvZiB0aGUNCj4gPiBib3guIEhvd2V2ZXIs
IGZpbGVzeXN0ZW0vcGFydGl0aW9uL0RNIHRvb2xpbmcgaGFzIGJlZW4gdXBkYXRlZCB0byBhbGln
bg0KPiA+IGNvcnJlY3RseSBvbiA1MTJlIGRldmljZXMuDQo+ID4NCg0KRG9lcyBpdCBtZWFuIHRo
YXQgSSBjYW4ganVzdCBwbHVnIHRoZSA0SyBIREQgaW4gYW5kIGl0IHdpbGwgd29yayB3aXRob3V0
IG1ha2luZyBhbnkgY2hhbmdlcyBpbiBrZXJuZWw/DQoNCkx1a2Fzeg0KDQo+ID4gU2VlOg0KPiA+
DQo+ID4gCWh0dHA6Ly9vc3Mub3JhY2xlLmNvbS9+bWtwL2RvY3MvbGludXgtYWR2YW5jZWQtc3Rv
cmFnZS5wZGYNCj4gDQo+IEFsc286DQo+IA0KPiBodHRwczovL2F0YS53aWtpLmtlcm5lbC5vcmcv
YXJ0aWNsZXMvYS90L2EvQVRBXzRfS2lCX3NlY3Rvcl9pc3N1ZXNfZDRiOC5odA0KPiBtbA0KPiBo
dHRwOi8vc291cmNlZm9yZ2UubmV0L2FwcHMvbWVkaWF3aWtpL2Jvb3RpbmZvc2NyaXB0L2luZGV4
LnBocD90aXRsZT1Cb290DQo+IF9Qcm9ibGVtczpXaW5kb3dzX1dyaXRlc19Ub19NQlINCj4gaHR0
cHM6Ly9oZWxwLnVidW50dS5jb20vY29tbXVuaXR5L0dydWIyDQo+IA0KPiANCj4gSSBhZ3JlZSB0
aGVyZSBpcyBub3RoaW5nIGFib3V0IHVuZGVyIERvY3VtZW50YXRpb24vIGluIGtlcm5lbCBzb3Vy
Y2VzLCBhdA0KPiBsZWFzdA0KPiBmcm9tIHVzZXJzIHBvaW50IG9mIHZpZXcuDQo+IE1hcnRpbg0K
PiAtLQ0KPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5z
dWJzY3JpYmUgbGludXgtaWRlIiBpbg0KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jk
b21vQHZnZXIua2VybmVsLm9yZw0KPiBNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdl
ci5rZXJuZWwub3JnL21ham9yZG9tby1pbmZvLmh0bWwNCg==
