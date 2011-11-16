From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH] libata-pmp: add schedule timeout to support some PMP
 cards
Date: Wed, 16 Nov 2011 09:13:46 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1161DF90@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1320033440-1106-1-git-send-email-r66093@freescale.com>
 <20111103160759.GI4417@google.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11617501@039-SN1MPN1-005.039d.mgd.msft.net>
 <20111110152036.GB27258@google.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F1161C24D@039-SN1MPN1-005.039d.mgd.msft.net>
 <20111115145111.GK30922@google.com> <4EC2844B.9050904@teksavvy.com>
 <4EC28D7E.7010703@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-va3.bigfish.com ([216.32.180.10]:29456 "EHLO
	VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754771Ab1KPJRI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2011 04:17:08 -0500
Received: from mail51-va3 (localhost [127.0.0.1])	by mail51-va3-R.bigfish.com
 (Postfix) with ESMTP id 8439B400393	for <linux-ide@vger.kernel.org>; Wed, 16
 Nov 2011 09:14:03 +0000 (UTC)
Received: from VA3EHSMHS030.bigfish.com (unknown [10.7.14.247])	by
 mail51-va3.bigfish.com (Postfix) with ESMTP id 5C838640043	for
 <linux-ide@vger.kernel.org>; Wed, 16 Nov 2011 09:10:44 +0000 (UTC)
In-Reply-To: <4EC28D7E.7010703@teksavvy.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

DQoNClRoYW5rcyBhbmQgQmVzdCBSZWdhcmRzDQpKZXJyeSBIdWFuZw0KDQoNCj4tLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1hcmsgTG9yZCBbbWFpbHRvOmtlcm5lbEB0ZWtzYXZ2
eS5jb21dDQo+U2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxNiwgMjAxMSAxMjowNCBBTQ0KPlRv
OiBUZWp1biBIZW8NCj5DYzogSHVhbmcgQ2hhbmdtaW5nLVI2NjA5MzsgbGludXgtaWRlQHZnZXIu
a2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGxpYmF0YS1wbXA6IGFkZCBzY2hlZHVs
ZSB0aW1lb3V0IHRvIHN1cHBvcnQgc29tZQ0KPlBNUCBjYXJkcw0KPg0KPk9uIDExLTExLTE1IDEw
OjI0IEFNLCBNYXJrIExvcmQgd3JvdGU6DQo+PiBPbiAxMS0xMS0xNSAwOTo1MSBBTSwgVGVqdW4g
SGVvIHdyb3RlOg0KPj4+IEhlbGxvLA0KPj4+DQo+Pj4gT24gVHVlLCBOb3YgMTUsIDIwMTEgYXQg
MDg6NDM6MDJBTSArMDAwMCwgSHVhbmcgQ2hhbmdtaW5nLVI2NjA5Mw0KPndyb3RlOg0KPj4+PiBU
aGUgUE1QIGNhcmQgd2UgYXJlIHRhbGtpbmcgYWJvdXQgaXMgSk1CMzkzOg0KPj4+PiBQb3J0IE11
bHRpcGxpZXIgMS4yLCAweDE5N2I6MHgwMzI1IHIwLCAxNSBwb3J0cywgZmVhdCAweDUvMHhmLg0K
Pj4+Pg0KPj4+PiBUaGlzIGlzc3VlIGlzIG9ic2VydmVkIG9uIEZyZWVzY2FsZSdzIFNhdGEgY29u
dHJvbGxlciwgaW5jbHVkaW5nDQo+cDEwMjBlIGFuZCBtcGM4Mzd4ZS4NCj4+Pg0KPj4+IENhbiB5
b3UgcGxlYXNlIHRyeSBkaWZmZXJlbnQgY29tYmluYXRpb25zPyAgaWUuIGZyZWVzY2FsZSBzYXRh
ICsNCj4+PiBvdGhlciBQTVAgYW5kIGptYjM5MyArIG90aGVyIHNhdGEgY29udHJvbGxlcnMuICBX
ZSBuZWVkIHRvIGtub3cgbW9yZQ0KPj4+IGJlZm9yZSBhZGRpbmcgd29ya2Fyb3VuZHMgdG8gdXBz
dHJlYW0uICBBbHNvLCB3b3VsZCB5b3UgbWluZCBpZiBJIGNjDQo+Pj4gam1pY3JvbiBwcGw/DQo+
Pg0KPj4NCj4+IEknbSBsYXRlIHR1bmluZyBpbiBoZXJlLCBidXQgSSBoYXZlIGEgSk1CMzkzIGRv
b3JzdG9wIGhlcmUgYW5kIHdvdWxkDQo+PiBsb3ZlIHRvIGhhdmUgaXQgYWN0dWFsbHkgd29yayB3
aXRoIExpbnV4Lg0KPj4gSXQgZmFpbHMgd2l0aCBhbGwgb2YgbXkgc2F0YV9zaWwsIHNhdGFfc2ls
MjQgYW5kIEFIQ0kgKGluY2x1ZGluZyBKTUIpDQo+Y29udHJvbGxlcnMuDQo+Pg0KPj4gV2hhdCdz
IHRoZSBwYXRjaCB0aGF0IEkgbmVlZCB0byB0ZXN0ID8NCj4NCj5Gb3VuZCBpdCwgdHJpZWQgaXQs
IHN0aWxsIGhhdmUgYSBMaW51eCBkb29yc3RvcC4NCj5Xb3JrcyBmaW5lIHVuZGVyIHRoYXQgb3Ro
ZXIgTy9TIHRob3VnaC4NCj4NClRoYXTigJlzIGEgYmFkIG5ld3MuIEkgdGhpbmsgd2UgbmVlZCBv
bmUgd29ya2Fyb3VuZCB0byBmaXggaXQuDQpJIHRlc3RlZCB0aGUgb3RoZXIgdHdvIFBNUCBjYXJk
cywgdGhleSB3b3JrIHdlbGwgb24gRnJlZXNjYWxlJ3MgYm9hcmQ6DQpQb3J0IE11bHRpcGxpZXIg
MS4xLCAweDEwOTU6MHg0NzI2IHIzMSwgNyBwb3J0cywgZmVhdCAweDEvMHg5IChTaWxpY29uIElt
YWdlKQ0KUG9ydCBNdWx0aXBsaWVyIDEuMiwgMHgxOTdiOjB4MDMyMSByMCwgNSBwb3J0cywgZmVh
dCAweDUvMHhmIChKTUIzOTEpDQo=

