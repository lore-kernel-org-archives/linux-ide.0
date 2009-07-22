From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/3] ide-tape: fix handling of postponed rqs
Date: Tue, 21 Jul 2009 20:47:04 -0700 (PDT)
Message-ID: <20090721.204704.123531717.davem@davemloft.net>
References: <1247910917-5237-1-git-send-email-petkovbb@gmail.com>
	<1247910917-5237-4-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42707
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755933AbZGVDq7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jul 2009 23:46:59 -0400
In-Reply-To: <1247910917-5237-4-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

RnJvbTogQm9yaXNsYXYgUGV0a292IDxwZXRrb3ZiYkBnb29nbGVtYWlsLmNvbT4NCkRhdGU6IFNh
dCwgMTggSnVsIDIwMDkgMTE6NTU6MTcgKzAyMDANCg0KPiBpZGUtdGFwZSB1c2VkIHRvIGhpdA0K
PiANCj4gWyAgIDU4LjYxNDg1NF0gaWRlLXRhcGU6IGh0MDogQlVHOiBUd28gRFNDIHJlcXVlc3Rz
IHF1ZXVlZCENCj4gDQo+IGR1ZSB0byB0aGUgZmFjdCB0aGF0IGFub3RoZXIgcnEgd2FzIGJlaW5n
IGlzc3VlZCB3aGlsZSB0aGUgZHJpdmVyIHdhcw0KPiB3YWl0aW5nIGZvciBEU0MgdG8gZ2V0IHNl
dCBmb3IgdGhlIGRldmljZSBleGVjdXRpbmcgQVRBUEkgY29tbWFuZHMgd2hpY2gNCj4gc2V0IHRo
ZSBEU0MgdG8gMSB0byBpbmRpY2F0ZSBjb21wbGV0aW9uLg0KPiANCj4gSGVyZSdzIGEgc2FtcGxl
IG91dHB1dCBvZiB0aGF0IGNhc2U6DQoNCkRvIHlvdSBldmVuIGNvbXBpbGUgdGhlIGNvZGUgeW91
IHNlbmQgbWUgYW5kIGxvb2sgdG8gc2VlIGlmIHRoZXJlIGFyZQ0KYW55IG5ldyB3YXJuaW5ncyBn
ZW5lcmF0ZWQgb3IgYW55dGhpbmcgbGlrZSB0aGF0Pw0KDQpkcml2ZXJzL2lkZS9pZGUtdGFwZS5j
OiBJbiBmdW5jdGlvbiDigJhpZGVfdGFwZV9zdGFsbF9xdWV1ZeKAmToNCmRyaXZlcnMvaWRlL2lk
ZS10YXBlLmM6Mzc5OiB3YXJuaW5nOiB1bnVzZWQgdmFyaWFibGUg4oCYcnHigJkNCg0KRml4IHRo
aXMuDQo=
