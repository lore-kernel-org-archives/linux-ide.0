From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 7/7] net: stmmac: dwmac-meson8b: use xxxsetbits32
Date: Tue, 25 Sep 2018 09:53:22 +0200
Message-ID: <6af26377-e2b8-3a1c-ca17-4932f636e01d@baylibre.com>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
 <a8d06d0a-b13b-384c-ade6-b0a3b0ee61f6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <a8d06d0a-b13b-384c-ade6-b0a3b0ee61f6@gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Florian Fainelli <f.fainelli@gmail.com>, Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net, galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com, maxime.ripard@bootlin.com, michal.lkml@markovi.net, mpe@ellerman.id.au, mporter@kernel.crashing.org, nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

SGkgRmxvcmlhbiwKCk9uIDI0LzA5LzIwMTggMjE6MTcsIEZsb3JpYW4gRmFpbmVsbGkgd3JvdGU6
Cj4gT24gMDkvMjQvMjAxOCAxMjowNCBQTSwgQ29yZW50aW4gTGFiYmUgd3JvdGU6Cj4+IFRoaXMg
cGF0Y2ggY29udmVydCBtZXNvbiBzdG1tYWMgZ2x1ZSBkcml2ZXIgdG8gdXNlIGFsbCB4eHhzZXRi
aXRzMzIgZnVuY3Rpb25zLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBDb3JlbnRpbiBMYWJiZSA8Y2xh
YmJlQGJheWxpYnJlLmNvbT4KPj4gLS0tCj4+ICAuLi4vbmV0L2V0aGVybmV0L3N0bWljcm8vc3Rt
bWFjL2R3bWFjLW1lc29uOGIuYyAgICB8IDU2ICsrKysrKysrKy0tLS0tLS0tLS0tLS0KPj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlvbnMoLSkKPj4KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjLW1lc29u
OGIuYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjLW1lc29uOGIu
Ywo+PiBpbmRleCBjNTk3OTU2OWZkNjAuLmFiY2Y2NTU4ODU3NiAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWMtbWVzb244Yi5jCj4+ICsrKyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjLW1lc29uOGIuYwo+PiBA
QCAtMjMsNiArMjMsNyBAQAo+PiAgI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4KPj4gICNp
bmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KPj4gICNpbmNsdWRlIDxsaW51eC9zdG1t
YWMuaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9zZXRiaXRzLmg+Cj4+ICAKPj4gICNpbmNsdWRlICJz
dG1tYWNfcGxhdGZvcm0uaCIKPj4gIAo+PiBAQCAtNzUsMTggKzc2LDYgQEAgc3RydWN0IG1lc29u
OGJfZHdtYWNfY2xrX2NvbmZpZ3Mgewo+PiAgCXN0cnVjdCBjbGtfZ2F0ZQkJcmdtaWlfdHhfZW47
Cj4+ICB9Owo+PiAgCj4+IC1zdGF0aWMgdm9pZCBtZXNvbjhiX2R3bWFjX21hc2tfYml0cyhzdHJ1
Y3QgbWVzb244Yl9kd21hYyAqZHdtYWMsIHUzMiByZWcsCj4+IC0JCQkJICAgIHUzMiBtYXNrLCB1
MzIgdmFsdWUpCj4+IC17Cj4+IC0JdTMyIGRhdGE7Cj4+IC0KPj4gLQlkYXRhID0gcmVhZGwoZHdt
YWMtPnJlZ3MgKyByZWcpOwo+PiAtCWRhdGEgJj0gfm1hc2s7Cj4+IC0JZGF0YSB8PSAodmFsdWUg
JiBtYXNrKTsKPj4gLQo+PiAtCXdyaXRlbChkYXRhLCBkd21hYy0+cmVncyArIHJlZyk7Cj4+IC19
Cj4gCj4gV2h5IG5vdCBtYWtlIG1zZW9uOGJfZHdtYWNfbWFza19iaXRzKCkgYSB3cmFwcGVyIGFy
b3VuZAo+IGNscnNldGJpdHNfbGUzMigpIHdob3NlIHB1cnBvc2UgaXMgb25seSB0byBkZXJlZmVy
ZW5jZSBkd21hYy0+cmVncyBhbmQKPiBwYXNzIGl0IHRvIGNscnNldGJpdHNfbGUzMigpPyBUaGF0
IHdvdWxkIGJlIGZhciBsZXNzIGNoYW5nZXMgdG8gcmV2aWV3Cj4gYW5kIGF1ZGl0IGZvciBjb3Jy
ZWN0bmVzcywgc2FtZSBnb2VzIHdpdGggZXZlcnkgb3RoZXIgcGF0Y2ggaW4gdGhpcwo+IHNlcmll
cyB0b3VjaGluZyB0aGUgbWVzb24gZHJpdmVycy4KPiAKClBlcnNvbmFsbHksIEknbGwgcHJlZmVy
IGRyb3BwaW5nIG15IGN1c3RvbSB3cml0ZWxfYml0c19yZWxheGVkKCkgd2l0aCBzb21ldGhpbmcK
bW9yZSBmdXR1cmUgcHJvb2YgKEkgYWxzbyB1c2UgaXQgaW4gc3BpLW1lc29uLXNwaWNjIGFuZCBh
by1jZWMpLAphbmQgSSB0aGluayB0aGUgc2FtZSBmb3IgZHdtYWMtbWVzb244Yi5jCgpOZWlsCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
