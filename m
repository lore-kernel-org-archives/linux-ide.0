From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC 03/10] cpufreq: exynos: Remove support for Exynos5440
Date: Thu, 26 Apr 2018 10:05:06 +0900
Message-ID: <5AE125C2.70105__16560.8106567108$1524704615$gmane$org@samsung.com>
References: <20180424203239.21885-1-krzk@kernel.org>
 <CGME20180424203335epcas5p3bfd2172f68574b67818c1d2bc74041bb@epcas5p3.samsung.com>
 <20180424203239.21885-4-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20180424203239.21885-4-krzk@kernel.org>
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
bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+Cj4gLS0tCj4gIC4uLi9iaW5kaW5ncy9jcHVmcmVxL2Nw
dWZyZXEtZXh5bm9zNTQ0MC50eHQgICAgICAgIHwgIDI4IC0tCj4gIGRyaXZlcnMvY3B1ZnJlcS9L
Y29uZmlnLmFybSAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE0IC0KPiAgZHJpdmVycy9jcHVm
cmVxL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgLQo+ICBkcml2ZXJz
L2NwdWZyZXEvZXh5bm9zNTQ0MC1jcHVmcmVxLmMgICAgICAgICAgICAgICB8IDQ1MiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA0OTUgZGVsZXRpb25zKC0pCj4gIGRl
bGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJl
cS9jcHVmcmVxLWV4eW5vczU0NDAudHh0Cj4gIGRlbGV0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nw
dWZyZXEvZXh5bm9zNTQ0MC1jcHVmcmVxLmMKPiAKClJldmlld2VkLWJ5OiBDaGFud29vIENob2kg
PGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KCltzbmlwXQoKCi0tIApCZXN0IFJlZ2FyZHMsCkNoYW53
b28gQ2hvaQpTYW1zdW5nIEVsZWN0cm9uaWNzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
