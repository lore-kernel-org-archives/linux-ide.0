From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4 01/10] ata: libahci: Ensure the host interrupt status
 bits are cleared
Date: Wed, 29 May 2019 12:08:33 +0200
Message-ID: <20190529120833.29334c70@xps13>
References: <20190521143023.31810-1-miquel.raynal@bootlin.com>
 <20190521143023.31810-2-miquel.raynal@bootlin.com>
 <CAHG4imNxsdzjzRpFWnL+PuznjdOU4hsp2E-g1bt4WVJeokfT3w@mail.gmail.com>
 <53ce8c5b-46fc-c969-5168-18e4bcc62cde@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <53ce8c5b-46fc-c969-5168-18e4bcc62cde@arm.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, raymond pang <raymondpangxd@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, Baruch Siach <baruch@tkos.co.il>, Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

SGkgTWFyYyAmIFJheW1vbmQsCgpNYXJjIFp5bmdpZXIgPG1hcmMuenluZ2llckBhcm0uY29tPiB3
cm90ZSBvbiBUaHUsIDIzIE1heSAyMDE5IDEwOjI2OjAxCiswMTAwOgoKPiBPbiAyMy8wNS8yMDE5
IDA0OjExLCByYXltb25kIHBhbmcgd3JvdGU6Cj4gPiBIaSBNaXF1ZWwsCj4gPiAKPiA+IFRoaXMg
cGF0Y2ggYWRkcyBjbGVhcmluZyBHSEMuSVMgaW50byBob3QgcGF0aCwgY291bGQgeW91IGV4cGxh
aW4gaG93Cj4gPiBpcnEgc3Rvcm0gaXMgZ2VuZXJhdGVkPyB0aGFua3MKPiA+IEFjY29yZGluZyB0
byBBSENJIFNwZWMsIEhCQSBzaG91bGQgbm90IHJlZmVyIHRvIEdIQy5JUyB0byBnZW5lcmF0ZQo+
ID4gTVNJIHdoZW4gYXBwbHlpbmcgbXVsdGlwbGUgTVNJcy4gIAo+IAo+IFdlbGwgc3BvdHRlZC4K
PiAKPiBJIGhhdmUgdGhlIHVnbHkgZmVlbGluZyB0aGF0IHRoaXMgaXMgYmVjYXVzZSB0aGUgTWFy
dmVsbCBBSENJCj4gaW1wbGVtZW50YXRpb24gaXMgbm90IHVzaW5nIE1TSXMgYXQgYWxsLCBidXQg
aW5zdGVhZCBhIHBhaXIgb2Ygd2lyZWQKPiBpbnRlcnJ1cHRzICh3aGljaCBhcmUgbGV2ZWwgdHJp
Z2dlcmVkIGluc3RlYWQgb2YgZWRnZSwgaGVuY2UgdGhlCj4gc2NyZWFtaW5nIGludGVycnVwdHMp
Lgo+IAo+IFRoZSBjaGFuZ2VzIGluIHRoZSBmb2xsb3dpbmcgcGF0Y2hlcyBhYnVzZSB0aGUgcmVz
dCBvZiB0aGUgZHJpdmVyIGJ5Cj4gcHJldGVuZGluZyB0aGlzIGlzIGEgYSBtdWx0aS1NU0kgc2V0
dXAsIHdoaWxlIGl0IGNsZWFybHkgZG9lc24ndCBtYXRjaAo+IHRoZSBleHBlY3RhdGlvbiBvZiB0
aGUgQUhDSSBzcGVjIGZvciBNU0lzLgo+IAo+IEl0IGxvb2tzIGxpa2UgdGhpcyBzaG91bGRuJ3Qg
YmUgaW1wb3NlZCBvbiBvdGhlciB1bnN1c3BlY3RpbmcKPiBpbXBsZW1lbnRhdGlvbnMgd2hpY2gg
Y29ycmVjdGx5IHVzZSBlZGdlLXRyaWdnZXJlZCBNU0lzIGFuZCBkbyBub3QKPiByZXF1aXJlIHN1
Y2ggYW4gTU1JTyBhY2Nlc3MuCgpJIHVuZGVyc3RhbmQgeW91ciBjb25jZXJuLCBsZXQgbWUgYWRk
IGEgQUhDSV9IRkxBR19MRVZFTF9NU0kgaW4KaHByaXYtPmZsYWdzIHdoaWNoIHdpbGwgYmUgdXNl
ZCBieSB0aGUgbXZlYnVfYWhjaS5jIGRyaXZlciB0byByZXF1ZXN0CmZvciB0aGlzIE1NSU8gYWNj
ZXNzLiBUaGlzIHdheSwgdGhlIGhvdCBwYXRoIHJlbWFpbnMgdGhlIHNhbWUuCgoKVGhhbmtzLApN
aXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
