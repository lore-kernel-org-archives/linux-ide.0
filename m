From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 2/5] ata: libahci_platform: Support per-port interrupts
Date: Fri, 22 Feb 2019 16:31:14 +0100
Message-ID: <20190222163114.0f4488fe@xps13>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-3-miquel.raynal@bootlin.com>
 <5040d4cf-7da1-eefa-a8a3-bc4054d528da@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5040d4cf-7da1-eefa-a8a3-bc4054d528da@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>, Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

SGkgSGFucywKCkhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+IHdyb3RlIG9uIEZy
aSwgMjIgRmViIDIwMTkgMTY6MjY6MDEKKzAxMDA6Cgo+IEhpLAo+IAo+IE9uIDIvMjIvMTkgMzo1
MyBQTSwgTWlxdWVsIFJheW5hbCB3cm90ZToKPiA+IFJpZ2h0IG5vdyB0aGUgQVRBIGNvcmUgb25s
eSBhbGxvd3MgSVBzIHRvIHVzZSBhIHNpbmdsZSBpbnRlcnJ1cHQuIFNvbWUKPiA+IG9mIHRoZW0g
KGZvciBpbnN0YW5jZSB0aGUgQXJtYWRhLUNQMTEwIG9uZSkgYWN0dWFsbHkgaGFzIG9uZSBpbnRl
cnJ1cHQKPiA+IHBlciBwb3J0LiBBZGQgc29tZSBsb2dpYyB0byBzdXBwb3J0IHN1Y2ggc2l0dWF0
aW9uLgo+ID4gCj4gPiBXZSBjb25zaWRlciB0aGF0IGVpdGhlciB0aGVyZSBpcyBvbmUgc2luZ2xl
IGludGVycnVwdCBkZWNsYXJlZCBpbiB0aGUKPiA+IG1haW4gSVAgbm9kZSwgb3IgdGhlcmUgYXJl
IHBlci1wb3J0IGludGVycnVwdHMsIGVhY2ggb2YgdGhlbSBiZWluZwo+ID4gZGVjbGFyZWQgaW4g
dGhlIHBvcnQgc3ViLW5vZGVzLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFs
IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvYXRhL2Fj
YXJkLWFoY2kuYyAgICAgICB8ICAyICstCj4gPiAgIGRyaXZlcnMvYXRhL2FoY2kuYyAgICAgICAg
ICAgICB8ICAyICstCj4gPiAgIGRyaXZlcnMvYXRhL2FoY2kuaCAgICAgICAgICAgICB8ICAzICst
Cj4gPiAgIGRyaXZlcnMvYXRhL2xpYmFoY2kuYyAgICAgICAgICB8ICAyICstCj4gPiAgIGRyaXZl
cnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYyB8IDY2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0KPiA+ICAgZHJpdmVycy9hdGEvc2F0YV9oaWdoYmFuay5jICAgIHwgIDIgKy0KPiA+
ICAgNiBmaWxlcyBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKPiA+
IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2FjYXJkLWFoY2kuYyBiL2RyaXZlcnMvYXRh
L2FjYXJkLWFoY2kuYwo+ID4gaW5kZXggNTgzZTM2NmJlN2UyLi45NDE0YjgxZTk5NGMgMTAwNjQ0
Cj4gPiAtLS0gYS9kcml2ZXJzL2F0YS9hY2FyZC1haGNpLmMKPiA+ICsrKyBiL2RyaXZlcnMvYXRh
L2FjYXJkLWFoY2kuYwo+ID4gQEAgLTQzNCw3ICs0MzQsNyBAQCBzdGF0aWMgaW50IGFjYXJkX2Fo
Y2lfaW5pdF9vbmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNl
X2lkCj4gPiAgIAlpZiAoIWhwcml2KQo+ID4gICAJCXJldHVybiAtRU5PTUVNOyAgCj4gPiAgID4g
LQlocHJpdi0+aXJxID0gcGRldi0+aXJxOyAgCj4gPiArCWhwcml2LT5pcnFzWzBdID0gcGRldi0+
aXJxOwo+ID4gICAJaHByaXYtPmZsYWdzIHw9ICh1bnNpZ25lZCBsb25nKXBpLnByaXZhdGVfZGF0
YTsKPiA+ICAgICAKPiBXaGF0IGNvZGUtcGF0aCBpcyBnb2luZyB0byBhbGxvYyBocHJpdi0+aXJx
cyBmb3IgZHJpdmVycyB1c2luZyB0aGlzIGNvZGUtcGF0aAo+IHdoaWNoIGFyZSBub3QgdXNpbmcg
bGliYWhjaV9wbGF0Zm9ybSAuYyA/CgpJIGRvbid0IHVuZGVyc3RhbmQgdGhlIHF1ZXN0aW9uIChv
ciB0aGUgcmVtYXJrIGJlaGluZCB0aGUgcXVlc3Rpb24pLApjYW4geW91IGV4cGxhaW4gYSBsaXR0
bGUgYml0IG1vcmUgd2hhdCB5b3UgaGF2ZSBpbiBtaW5kPwoKClRoYW5rcywKTWlxdcOobAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
