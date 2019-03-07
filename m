From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 01/10] ata: libahci: Ensure the host interrupt status
 bits are cleared
Date: Thu, 7 Mar 2019 18:19:30 +0100
Message-ID: <20190307181930.7142a9d7@xps13>
References: <20190306102146.13005-1-miquel.raynal@bootlin.com>
 <20190306102146.13005-2-miquel.raynal@bootlin.com>
 <57c2d67c-7411-0fca-933e-a76379f3165c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <57c2d67c-7411-0fca-933e-a76379f3165c@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

SGkgTWFyYywKCk1hcmMgWnluZ2llciA8bWFyYy56eW5naWVyQGFybS5jb20+IHdyb3RlIG9uIFRo
dSwgNyBNYXIgMjAxOSAxNjoyNTowMgorMDAwMDoKCj4gT24gMDYvMDMvMjAxOSAxMDoyMSwgTWlx
dWVsIFJheW5hbCB3cm90ZToKPiA+IGFoY2lfbXVsdGlfaXJxc19pbnRyX2hhcmQoKSBpcyBnb2lu
ZyB0byBiZSB1c2VkIGFzIGludGVycnVwdCBoYW5kbGVyCj4gPiB0byBzdXBwb3J0IFNBVEEgcGVy
LXBvcnQgaW50ZXJydXB0cy4gVGhlIGN1cnJlbnQgbG9naWMgaXMgdG8gY2hlY2sgYW5kCj4gPiBj
bGVhciB0aGUgU0FUQSBwb3J0IGludGVycnVwdCBzdGF0dXMgcmVnaXN0ZXIgb25seS4gVG8gYXZv
aWQgc3B1cmlvdXMKPiA+IElSUXMgYW5kIGludGVycnVwdCBzdG9ybXMsIGl0IHdpbGwgYmUgbmVl
ZGVkIHRvIGNsZWFyIHRoZSBwb3J0Cj4gPiBpbnRlcnJ1cHQgYml0IGluIHRoZSBob3N0IGludGVy
cnVwdCBzdGF0dXMgcmVnaXN0ZXIgYXMgd2VsbC4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTWlx
dWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4KPiA+IC0tLQo+ID4gIGRyaXZl
cnMvYXRhL2xpYmFoY2kuYyB8IDcgKysrKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmFoY2kuYyBiL2Ry
aXZlcnMvYXRhL2xpYmFoY2kuYwo+ID4gaW5kZXggYjVmNTdjNjljNDg3Li42NmQ0OTA2YTUwMTMg
MTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2F0YS9saWJhaGNpLmMKPiA+ICsrKyBiL2RyaXZlcnMv
YXRhL2xpYmFoY2kuYwo+ID4gQEAgLTE5MTIsNyArMTkxMiwxMCBAQCBzdGF0aWMgdm9pZCBhaGNp
X3BvcnRfaW50cihzdHJ1Y3QgYXRhX3BvcnQgKmFwKQo+ID4gIHN0YXRpYyBpcnFyZXR1cm5fdCBh
aGNpX211bHRpX2lycXNfaW50cl9oYXJkKGludCBpcnEsIHZvaWQgKmRldl9pbnN0YW5jZSkKPiA+
ICB7Cj4gPiAgCXN0cnVjdCBhdGFfcG9ydCAqYXAgPSBkZXZfaW5zdGFuY2U7Cj4gPiArCXN0cnVj
dCBhdGFfaG9zdCAqaG9zdCA9IGFwLT5ob3N0Owo+ID4gKwlzdHJ1Y3QgYWhjaV9ob3N0X3ByaXYg
Kmhwcml2ID0gaG9zdC0+cHJpdmF0ZV9kYXRhOwo+ID4gIAl2b2lkIF9faW9tZW0gKnBvcnRfbW1p
byA9IGFoY2lfcG9ydF9iYXNlKGFwKTsKPiA+ICsJdm9pZCBfX2lvbWVtICptbWlvID0gaHByaXYt
Pm1taW87Cj4gPiAgCXUzMiBzdGF0dXM7Cj4gPiAgCj4gPiAgCVZQUklOVEsoIkVOVEVSXG4iKTsK
PiA+IEBAIC0xOTI0LDYgKzE5MjcsMTAgQEAgc3RhdGljIGlycXJldHVybl90IGFoY2lfbXVsdGlf
aXJxc19pbnRyX2hhcmQoaW50IGlycSwgdm9pZCAqZGV2X2luc3RhbmNlKQo+ID4gIAlhaGNpX2hh
bmRsZV9wb3J0X2ludGVycnVwdChhcCwgcG9ydF9tbWlvLCBzdGF0dXMpOwo+ID4gIAlzcGluX3Vu
bG9jayhhcC0+bG9jayk7Cj4gPiAgCj4gPiArCXNwaW5fbG9jaygmaG9zdC0+bG9jayk7Cj4gPiAr
CXdyaXRlbChCSVQoYXAtPnBvcnRfbm8pLCBtbWlvICsgSE9TVF9JUlFfU1RBVCk7Cj4gPiArCXNw
aW5fdW5sb2NrKCZob3N0LT5sb2NrKTsgIAo+IAo+IFdoYXQncyBub3QgY2xlYXIgaGVyZSBpcyB1
bmRlciB3aGljaCBjaXJjdW1zdGFuY2VzIHRoaXMgaXMgcmVxdWlyZWQuCj4gVGhpcyB3cml0ZSBz
aG91bGQgYmUgYXRvbWljIChpZiBpdCBpc24ndCwgeW91IGhhdmUgYmlnZ2VyIHByb2JsZW1zKSwg
YW5kCj4gaXQgaXMgYXQgYmVzdCB1bmNsZWFyIHdoYXQgeW91J3JlIGF2b2lkaW5nIGJ5IHRha2lu
ZyB0aGUgaG9zdCBsb2NrLgoKWW91J3JlIHJpZ2h0LCB0YWtpbmcgdGhlIGxvY2sgaXMgbm90IG5l
ZWRlZC4gSXQgaXMgYSByZWxpY3Qgb2YgYQpwcmV2aW91cyBpbXBsZW1lbnRhdGlvbiBhbnl3YXku
CgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
