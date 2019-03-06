From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 10/10] arm64: dts: marvell: armada-cp110: Switch to
 per-port SATA interrupts
Date: Wed, 6 Mar 2019 11:34:31 +0100
Message-ID: <20190306113431.3ea27949@xps13>
References: <20190306102146.13005-1-miquel.raynal@bootlin.com>
 <20190306102146.13005-11-miquel.raynal@bootlin.com>
 <20190306103039.35cfzanu3mprlcja@sapphire.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190306103039.35cfzanu3mprlcja@sapphire.tkos.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>, Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

SGkgQmFydWNoLAoKQmFydWNoIFNpYWNoIDxiYXJ1Y2hAdGtvcy5jby5pbD4gd3JvdGUgb24gV2Vk
LCA2IE1hciAyMDE5IDEyOjMwOjM5CiswMjAwOgoKPiBIaSBNaXF1ZWwsCj4gCj4gT24gV2VkLCBN
YXIgMDYsIDIwMTkgYXQgMTE6MjE6NDZBTSArMDEwMCwgTWlxdWVsIFJheW5hbCB3cm90ZToKPiA+
IEZyb206IFRob21hcyBQZXRhenpvbmkgPHRob21hcy5wZXRhenpvbmlAYm9vdGxpbi5jb20+Cj4g
PiAKPiA+IFRoZXJlIGFyZSB0d28gU0FUQSBwb3J0cyBwZXIgQ1AxMTAuIEVhY2ggb2YgdGhlbSBo
YXMgYSBkZWRpY2F0ZWQKPiA+IGludGVycnVwdC4gRGVzY3JpYmUgdGhlIHJlYWwgaGFyZHdhcmUg
YnkgYWRkaW5nIHR3byBTQVRBIHBvcnRzIHRvIHRoZQo+ID4gQ1AxMTAgU0FUQSBub2RlIGFuZCBl
bmFibGluZyB0aGVtIGluIGFsbCB0aGUgRFRzIGluY2x1ZGluZyBpdAo+ID4gKDcwNDAtZGIvODA0
MC1kYi84MDQwLWNsZWFyZm9nKS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFBldGF6
em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IE1p
cXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+Cj4gPiAtLS0KPiA+ICBhcmNo
L2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTcwNDAtZGIuZHRzICAgfCAgNyArKysrKyst
Cj4gPiAgLi4uL2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLWNsZWFyZm9nLWd0LThrLmR0cyAgIHwg
IDUgKysrKy0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTgwNDAtZGIu
ZHRzICAgfCAxNCArKysrKysrKysrKystLQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVs
bC9hcm1hZGEtY3AxMTAuZHRzaSAgICB8IDE2ICsrKysrKysrKysrKysrLS0gIAo+IAo+IFdoYXQg
YWJvdXQgYXJtYWRhLTgwNDAtbWNiaW4uZHRzaT8KPiAKCkkgb25seSBjaGVja2VkIGZpbmFsIC5k
dHMgZmlsZXMgYnV0IGluZGVlZCB0aGUgU0FUQSBub2RlIGlzIGVuYWJsZWQgaW4KdGhlIG1jYmlu
IC5kdHNpLiBJIHdpbGwgd2FpdCBhIGJpdCBmb3Igb3RoZXIgcmV2aWV3cywgaWYgdGhlcmUgaXMg
bm8KbmVlZCB0byBzZW5kIGEgdjMgZm9yIHRoZSBTQVRBIHBhdGNoZXMgSSB3aWxsIGp1c3QgcmVz
ZW5kIHRoZSBEVApwYXRjaGVzIGZvciBHcmVnb3J5IGluIGEgdjMuCgoKVGhhbmtzLApNaXF1w6hs
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
