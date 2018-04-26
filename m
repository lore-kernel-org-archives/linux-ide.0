From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC 07/10] pinctrl: samsung: Remove support for Exynos5440
Date: Thu, 26 Apr 2018 10:15:21 +0900
Message-ID: <5AE12829.4090607__44651.1547700085$1524705231$gmane$org@samsung.com>
References: <20180424203239.21885-1-krzk@kernel.org>
 <CGME20180424203539epcas2p4e099df5797adb9a49c0d49bbfc829543@epcas2p4.samsung.com>
 <20180424203239.21885-8-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20180424203239.21885-8-krzk@kernel.org>
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

SGksCgpPbiAyMDE464WEIDA07JuUIDI17J28IDA1OjMyLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOgo+IFRoZSBFeHlub3M1NDQwIGlzIG5vdCBhY3RpdmVseSBkZXZlbG9wZWQsIHRoZXJlIGFy
ZSBubyBkZXZlbG9wbWVudAo+IGJvYXJkcyBhdmFpbGFibGUgYW5kIHByb2JhYmx5IHRoZXJlIGFy
ZSBubyByZWFsIHByb2R1Y3RzIHdpdGggaXQuCj4gUmVtb3ZlIHdpZGUtdHJlZSBzdXBwb3J0IGZv
ciBFeHlub3M1NDQwLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGty
emtAa2VybmVsLm9yZz4KPiAtLS0KPiAgZHJpdmVycy9waW5jdHJsL3NhbXN1bmcvS2NvbmZpZyAg
ICAgICAgICAgICAgfCAgIDEwICstCj4gIGRyaXZlcnMvcGluY3RybC9zYW1zdW5nL01ha2VmaWxl
ICAgICAgICAgICAgIHwgICAgMSAtCj4gIGRyaXZlcnMvcGluY3RybC9zYW1zdW5nL3BpbmN0cmwt
ZXh5bm9zNTQ0MC5jIHwgMTAwNSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAzIGZpbGVz
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMTAxNCBkZWxldGlvbnMoLSkKPiAgZGVsZXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvcGluY3RybC9zYW1zdW5nL3BpbmN0cmwtZXh5bm9zNTQ0MC5jCgpM
b29rcyBnb29kIHRvIG1lLgpSZXZpZXdlZC1ieTogQ2hhbndvbyBDaG9pIDxjdzAwLmNob2lAc2Ft
c3VuZy5jb20+CgotLSAKQmVzdCBSZWdhcmRzLApDaGFud29vIENob2kKU2Ftc3VuZyBFbGVjdHJv
bmljcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
