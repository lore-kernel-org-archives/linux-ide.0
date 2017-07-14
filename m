From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 14/14] [media] fix warning on v4l2_subdev_call() result
 interpreted as bool
Date: Fri, 14 Jul 2017 21:32:25 +0200
Message-ID: <CAK8P3a1ckDk2VEhK9EWXU7ZWqh1UoZVMac9j3-1KGioj8EE+kw@mail.gmail.com>
References: <20170714092540.1217397-1-arnd@arndb.de>
 <20170714093938.1469319-1-arnd@arndb.de>
 <20170714120512.ioe67nnloqivtbr7@mwanda>
 <CAK8P3a0f84OPcCK1r3P9inGYDJC2KaAO4mjE2vn+vCws-oo_bw@mail.gmail.com>
 <20170714125525.kjemhcn4poon6r3i@mwanda>
 <20170714130955.zqe26g6zpixr3xj2@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170714130955.zqe26g6zpixr3xj2@mwanda>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daeseok Youn <daeseok.youn@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, adi-buildroot-devel@lists.sourceforge.net, Hans Verkuil <hverkuil@xs4all.nl>, IDE-ML <linux-ide@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

T24gRnJpLCBKdWwgMTQsIDIwMTcgYXQgMzowOSBQTSwgRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBl
bnRlckBvcmFjbGUuY29tPiB3cm90ZToKPiBPbiBGcmksIEp1bCAxNCwgMjAxNyBhdCAwMzo1NToy
NlBNICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOgo+PiBJIGRvbid0IGFncmVlIHdpdGggaXQg
YXMgYSBzdGF0aWMgYW5hbHlzaXMgZGV2Li4uCj4KPiBXaGF0IEkgbWVhbiBpcyBpZiBpdCdzIGEg
bWFjcm8gdGhhdCByZXR1cm5zIC1FTk9ERVYgb3IgYSBmdW5jdGlvbiB0aGF0Cj4gcmV0dXJucyAt
RU5PREVWLCB0aGV5IHNob3VsZCBib3RoIGJlIHRyZWF0ZWQgdGhlIHNhbWUuICBUaGUgb3RoZXIK
PiB3YXJuaW5ncyB0aGlzIGNoZWNrIHByaW50cyBhcmUgcXVpdGUgY2xldmVyLgoKSSB0aGluayB0
aGlzIGlzIHdoYXQgZ2NjIHRyaWVzIHRvIGRvLCBhbmQgaXQgc2hvdWxkIHdvcmsgbm9ybWFsbHks
IGJ1dCBpdApmYWlscyB3aGVuIHVzaW5nIGNjYWNoZS4gSSBrbm93IEkgaGFkIGNhc2VzIGxpa2Ug
dGhhdCwgbm90IGVudGlyZWx5IHN1cmUKaWYgdGhpcyBpcyBvbmUgb2YgdGhlbS4gTWF5YmUgaXQg
anVzdCBtZWFucyBJIHNob3VsZCBnaXZlIHVwIG9uIHVzaW5nCmNjYWNoZSBpbiBwcmVwcm9jZXNz
b3IgbW9kZS4KCiAgICAgICBBcm5kCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbAo=
