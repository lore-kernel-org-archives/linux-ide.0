From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC 06/10] thermal: samsung: Remove support for Exynos5440
Date: Thu, 26 Apr 2018 10:41:30 +0900
Message-ID: <5AE12E4A.90907__49249.4360114962$1524706825$gmane$org@samsung.com>
References: <20180424203239.21885-1-krzk@kernel.org>
 <CGME20180424203603epcas5p4cdd2039eabe7039e4daf286ed4c1ecc0@epcas5p4.samsung.com>
 <20180424203239.21885-7-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20180424203239.21885-7-krzk@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Russell King <linux@armlinux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devic
Cc: Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-ide@vger.kernel.org

SGkgS3J6eXN6dG9mLAoKT24gMjAxOOuFhCAwNOyblCAyNeydvCAwNTozMiwgS3J6eXN6dG9mIEtv
emxvd3NraSB3cm90ZToKPiBUaGUgRXh5bm9zNTQ0MCBpcyBub3QgYWN0aXZlbHkgZGV2ZWxvcGVk
LCB0aGVyZSBhcmUgbm8gZGV2ZWxvcG1lbnQKPiBib2FyZHMgYXZhaWxhYmxlIGFuZCBwcm9iYWJs
eSB0aGVyZSBhcmUgbm8gcmVhbCBwcm9kdWN0cyB3aXRoIGl0Lgo+IFJlbW92ZSB3aWRlLXRyZWUg
c3VwcG9ydCBmb3IgRXh5bm9zNTQ0MC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296
bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+Cj4gLS0tCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3RoZXJtYWwvZXh5bm9zLXRoZXJtYWwudHh0IHwgIDE0ICstCj4gIGRyaXZlcnMvdGhlcm1hbC9z
YW1zdW5nL2V4eW5vc190bXUuYyAgICAgICAgICAgICAgIHwgMTU1ICstLS0tLS0tLS0tLS0tLS0t
LS0tLQo+ICBkcml2ZXJzL3RoZXJtYWwvc2Ftc3VuZy9leHlub3NfdG11LmggICAgICAgICAgICAg
ICB8ICAgMSAtCj4gIDMgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxNjYgZGVsZXRp
b25zKC0pCgoKQWZ0ZXIgYXBwbGllZCB0aGlzIHBhdGNoLCBJIHRlc3RlZCB0aGUgYnVpbGQgYW5k
IGZvdW5kIG91dAonZXh5bm9zNTQ0MCcga2V5d29yZC4gVGhlcmUgaXMgb25lIGNvbW1lbnQgaW5j
bHVkaW5nICdleHlub3M1NDQwJyBhcyBmb2xsb3dpbmc6CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90
aGVybWFsL3NhbXN1bmcvZXh5bm9zX3RtdS5jIGIvZHJpdmVycy90aGVybWFsL3NhbXN1bmcvZXh5
bm9zX3RtdS5jCmluZGV4IGY5MmY0NzBiY2UyMS4uY2I1MjUyMjhjZmUxIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3RoZXJtYWwvc2Ftc3VuZy9leHlub3NfdG11LmMKKysrIGIvZHJpdmVycy90aGVybWFs
L3NhbXN1bmcvZXh5bm9zX3RtdS5jCkBAIC05NDMsNyArOTQzLDcgQEAgc3RhdGljIHZvaWQgZXh5
bm9zNDIxMF90bXVfY2xlYXJfaXJxcyhzdHJ1Y3QgZXh5bm9zX3RtdV9kYXRhICpkYXRhKQogICAg
ICAgICAqIEV4eW5vczMyNTAsIEV4eW5vczQ0MTIsIEV4eW5vczUyNTAgYW5kIEV4eW5vczUyNjAg
aW5jb3JyZWN0bHkKICAgICAgICAgKiBzdGF0ZXMgdGhhdCBJTlRDTEVBUiByZWdpc3RlciBoYXMg
YSBkaWZmZXJlbnQgcGxhY2luZyBvZiBiaXRzCiAgICAgICAgICogcmVzcG9uc2libGUgZm9yIEZB
TEwgSVJRcyB0aGFuIElOVFNUQVQgcmVnaXN0ZXIuICBFeHlub3M1NDIwCi0gICAgICAgICogYW5k
IEV4eW5vczU0NDAgZG9jdW1lbnRhdGlvbiBpcyBjb3JyZWN0IChFeHlub3M0MjEwIGRvZXNuJ3QK
KyAgICAgICAgKiBkb2N1bWVudGF0aW9uIGlzIGNvcnJlY3QgKEV4eW5vczQyMTAgZG9lc24ndAog
ICAgICAgICAqIHN1cHBvcnQgRkFMTCBJUlFzIGF0IGFsbCkuCiAgICAgICAgICovCiAgICAgICAg
d3JpdGVsKHZhbF9pcnEsIGRhdGEtPmJhc2UgKyB0bXVfaW50Y2xlYXIpOwoKQWZ0ZXIgcmVtb3Zp
bmcgaXQsIGxvb2tzIGdvb2QgdG8gbWUuClJldmlld2VkLWJ5OiBDaGFud29vIENob2kgPGN3MDAu
Y2hvaUBzYW1zdW5nLmNvbT4KCi0tIApCZXN0IFJlZ2FyZHMsCkNoYW53b28gQ2hvaQpTYW1zdW5n
IEVsZWN0cm9uaWNzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
