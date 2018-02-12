From: Preetham Chandru <pchandru@nvidia.com>
Subject: RE: [PATCH V6 6/7] ata: ahci_tegra: disable DIPM
Date: Mon, 12 Feb 2018 17:12:23 +0000
Message-ID: <b0175fc58f5640b0be3b382f6ad79ff8@bgmail102.nvidia.com>
References: <1515482234-24716-1-git-send-email-pchandru@nvidia.com>
 <1515482234-24716-7-git-send-email-pchandru@nvidia.com>
 <cdff68f3-9a4c-3591-0882-073ffad16e5e@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18312 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbeBLRMa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2018 12:12:30 -0500
In-Reply-To: <cdff68f3-9a4c-3591-0882-073ffad16e5e@kapsi.fi>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Perttunen <cyndis@kapsi.fi>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "tj@kernel.org" <tj@kernel.org>
Cc: "preetham260@gmail.com" <preetham260@gmail.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Pavan Kunapuli <pkunapuli@nvidia.com>

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1pa2tvIFBlcnR0dW5lbiBb
bWFpbHRvOmN5bmRpc0BrYXBzaS5maV0NCj5TZW50OiBUdWVzZGF5LCBKYW51YXJ5IDIzLCAyMDE4
IDk6MjMgUE0NCj5UbzogUHJlZXRoYW0gQ2hhbmRydSA8cGNoYW5kcnVAbnZpZGlhLmNvbT47IHRo
aWVycnkucmVkaW5nQGdtYWlsLmNvbTsNCj50akBrZXJuZWwub3JnDQo+Q2M6IHByZWV0aGFtMjYw
QGdtYWlsLmNvbTsgbGludXgtdGVncmFAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5pZGVAdmdl
ci5rZXJuZWwub3JnOyBWZW51IEJ5cmF2YXJhc3UgPHZieXJhdmFyYXN1QG52aWRpYS5jb20+OyBQ
YXZhbg0KPkt1bmFwdWxpIDxwa3VuYXB1bGlAbnZpZGlhLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BB
VENIIFY2IDYvN10gYXRhOiBhaGNpX3RlZ3JhOiBkaXNhYmxlIERJUE0NCj4NCj5PbiAwMS8wOS8y
MDE4IDA5OjE3IEFNLCBQcmVldGhhbSBDaGFuZHJ1IFJhbWNoYW5kcmEgd3JvdGU6DQo+PiBGcm9t
OiBQcmVldGhhbSBSYW1jaGFuZHJhIDxwY2hhbmRydUBudmlkaWEuY29tPg0KPj4NCj4+IHRlZ3Jh
IGRvZXMgbm90IHN1cHBvcnQgRElQTSBhbmQgaXQgc2hvdWxkIGJlIGRpc2FibGVkDQo+DQo+Tml0
OiBUZWdyYSBzaG91bGQgYmUgY2FwaXRhbGl6ZWQNCj4NCm9rYXkNCj5vdGhlcndpc2UsDQo+UmV2
aWV3ZWQtYnk6IE1pa2tvIFBlcnR0dW5lbiA8bXBlcnR0dW5lbkBudmlkaWEuY29tPg0KPg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFByZWV0aGFtIENoYW5kcnUgUiA8cGNoYW5kcnVAbnZpZGlhLmNv
bT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2F0YS9haGNpX3RlZ3JhLmMgfCAyICstDQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2F0YS9haGNpX3RlZ3JhLmMgYi9kcml2ZXJzL2F0YS9haGNpX3RlZ3Jh
LmMgaW5kZXgNCj4+IGE1OWE5N2IxYjJlNS4uMDEzODgwZGU2NDEyIDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9hdGEvYWhjaV90ZWdyYS5jDQo+PiArKysgYi9kcml2ZXJzL2F0YS9haGNpX3RlZ3Jh
LmMNCj4+IEBAIC00NjAsNyArNDYwLDcgQEAgc3RhdGljIHN0cnVjdCBhdGFfcG9ydF9vcGVyYXRp
b25zIGFoY2lfdGVncmFfcG9ydF9vcHMNCj49IHsNCj4+ICAgfTsNCj4+DQo+PiAgIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgYXRhX3BvcnRfaW5mbyBhaGNpX3RlZ3JhX3BvcnRfaW5mbyA9IHsNCj4+IC0J
LmZsYWdzCQk9IEFIQ0lfRkxBR19DT01NT04sDQo+PiArCS5mbGFncwkJPSBBSENJX0ZMQUdfQ09N
TU9OIHwgQVRBX0ZMQUdfTk9fRElQTSwNCj4+ICAgCS5waW9fbWFzawk9IEFUQV9QSU80LA0KPj4g
ICAJLnVkbWFfbWFzawk9IEFUQV9VRE1BNiwNCj4+ICAgCS5wb3J0X29wcwk9ICZhaGNpX3RlZ3Jh
X3BvcnRfb3BzLA0KPj4NCg==
