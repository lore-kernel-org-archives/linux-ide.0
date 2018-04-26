From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC 04/10] clk: samsung: Remove support for Exynos5440
Date: Thu, 26 Apr 2018 09:58:41 +0900
Message-ID: <5AE12441.2090506__14438.9295754538$1524704236$gmane$org@samsung.com>
References: <20180424203239.21885-1-krzk@kernel.org>
 <CGME20180424203341epcas5p3a6db7d58b0ce8940d03711823fbf6e41@epcas5p3.samsung.com>
 <20180424203239.21885-5-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20180424203239.21885-5-krzk@kernel.org>
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
L2Nsb2NrL2V4eW5vczU0NDAtY2xvY2sudHh0IHwgIDI4IC0tLS0KPiAgZHJpdmVycy9jbGsvc2Ft
c3VuZy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgLQo+ICBkcml2ZXJzL2Ns
ay9zYW1zdW5nL2Nsay1leHlub3M1NDQwLmMgICAgICAgICAgICAgICB8IDE2NyAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0KPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9leHlub3M1NDQwLmggICAg
ICAgICAgICAgfCAgNDQgLS0tLS0tCj4gIDQgZmlsZXMgY2hhbmdlZCwgMjQwIGRlbGV0aW9ucygt
KQo+ICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2Nsb2NrL2V4eW5vczU0NDAtY2xvY2sudHh0Cj4gIGRlbGV0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L2Nsay9zYW1zdW5nL2Nsay1leHlub3M1NDQwLmMKPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvZHQtYmluZGluZ3MvY2xvY2svZXh5bm9zNTQ0MC5oCj4gCgpMb29rcyBnb29kIHRvIG1lLiBU
aGFua3MuCgpBY2tlZC1ieTogQ2hhbndvbyBDaG9pIDxjdzAwLmNob2lAc2Ftc3VuZy5jb20+Cgpb
c25pcF0KCi0tIApCZXN0IFJlZ2FyZHMsCkNoYW53b28gQ2hvaQpTYW1zdW5nIEVsZWN0cm9uaWNz
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
