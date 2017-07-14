From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 14/14] [media] fix warning on v4l2_subdev_call() result
 interpreted as bool
Date: Fri, 14 Jul 2017 14:27:19 +0200
Message-ID: <CAK8P3a0f84OPcCK1r3P9inGYDJC2KaAO4mjE2vn+vCws-oo_bw@mail.gmail.com>
References: <20170714092540.1217397-1-arnd@arndb.de>
 <20170714093938.1469319-1-arnd@arndb.de>
 <20170714120512.ioe67nnloqivtbr7@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170714120512.ioe67nnloqivtbr7@mwanda>
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

T24gRnJpLCBKdWwgMTQsIDIwMTcgYXQgMjowNSBQTSwgRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBl
bnRlckBvcmFjbGUuY29tPiB3cm90ZToKPiBDaGFuZ2luZzoKPgo+IC0gaWYgKCFmcm9iKCkpIHsK
PiArIGlmIChmcm9iKCkgPT0gMCkgewo+Cj4gaXMgYSB0b3RhbGx5IHBvaW50bGVzcyBjaGFuZ2Uu
ICBUaGV5J3JlIGJvdGggYmFkLCBiZWNhdXNlIHRoZXkncmUgZG9pbmcKPiBzdWNjZXNzIHRlc3Rp
bmcgaW5zdGVhZCBvZiBmYWlsdXJlIHRlc3RpbmcsIGJ1dCBwcm9iYWJseSB0aGUgc2Vjb25kIG9u
ZQo+IGlzIHNsaWdodGx5IHdvcnNlLgo+Cj4gVGhpcyB3YXJuaW5nIHNlZW1zIGR1bWIuICBJIGNh
bid0IGltYWdpbmUgaXQgaGFzIGV2ZW4gYSAxMCUgc3VjY2VzcyByYXRlCj4gYXQgZmluZGluZyBy
ZWFsIGJ1Z3MuICBKdXN0IGRpc2FibGUgaXQuCj4KPiBDaGFuZ2luZyB0aGUgY29kZSB0byBwcm9w
YWdhdGUgZXJyb3IgY29kZXMsIGlzIHRoZSByaWdodCB0aGluZyBvZiBjb3Vyc2UKPiBzbyBsb25n
IGFzIGl0IGRvZXNuJ3QgaW50cm9kdWNlIGJ1Z3MuCgpJdCBmb3VuZCBhIHR3byBvZiBidWdzIHRo
YXQgSSBmaXhlZCBlYXJsaWVyOgoKZjBlOGZhYTdhNWU4ICgiQVJNOiB1eDUwMDogZml4IHByY211
X2lzX2NwdV9pbl93ZmkoKSBjYWxjdWxhdGlvbiIpCmFmMTU3NjlmZmFiMSAoInNjc2k6IG12c2Fz
OiBmaXggY29tbWFuZF9hY3RpdmUgdHlwbyIpCgpwbHVzIHRocmVlIHBhdGNoZXMgZnJvbSB0aGlz
IHNlcmllczoKCjEuIHN0YWdpbmc6aWlvOnJlc29sdmVyOmFkMnMxMjEwIGZpeCBuZWdhdGl2ZSBJ
SU9fQU5HTF9WRUwgcmVhZAoyLiBpc2RuOiBpc2RubG9vcDogc3VwcHJlc3MgYSBnY2MtNyB3YXJu
aW5nIChteSBwYXRjaCBpcyB3cm9uZywKICAgYXMgSm9lIHBvaW50ZWQgb3V0IHRoZXJlIGlzIGEg
cmVhbCBidWcpCjMuIGRybS92bXdnZng6IGF2b2lkIGdjYy03IHBhcmVudGhlc2VzIChoZXJlLCBM
aW51cyBoYWQgYSBiZXR0ZXIKICAgYW5hbHlzaXMgb2YgdGhlIHByb2JsZW0sIHNvIHdlIHNob3Vs
ZCBjb25zaWRlciB0aGF0IGEgYnVnIGFzIHdlbGwpCgpJIHdvdWxkIGVzdGltYXRlIGFyb3VuZCAy
NSUgc3VjY2VzcyByYXRlIGhlcmUsIHdoaWNoIGlzbid0IHRoYXQKYmFkIGZvciBhIG5ldyB3YXJu
aW5nLgoKSSBhZ3JlZSB0aGF0IG1vc3Qgb2YgdGhlIGZhbHNlIHBvc2l0aXZlcyBhcmUgcmVhbGx5
IGR1bWIgdGhvdWdoLgoKICAgICAgIEFybmQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVsCg==
