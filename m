From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 10/14] staging:iio:resolver:ad2s1210 fix negative IIO_ANGL_VEL
 read
Date: Fri, 14 Jul 2017 11:31:03 +0200
Message-ID: <20170714093129.1366900-1-arnd@arndb.de>
References: <20170714092540.1217397-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170714092540.1217397-1-arnd@arndb.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, stable@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Z2NjLTcgcG9pbnRzIG91dCBhbiBvbGRlciByZWdyZXNzaW9uOgoKZHJpdmVycy9zdGFnaW5nL2lp
by9yZXNvbHZlci9hZDJzMTIxMC5jOiBJbiBmdW5jdGlvbiAnYWQyczEyMTBfcmVhZF9yYXcnOgpk
cml2ZXJzL3N0YWdpbmcvaWlvL3Jlc29sdmVyL2FkMnMxMjEwLmM6NTE1OjQyOiBlcnJvcjogJzw8
JyBpbiBib29sZWFuIGNvbnRleHQsIGRpZCB5b3UgbWVhbiAnPCcgPyBbLVdlcnJvcj1pbnQtaW4t
Ym9vbC1jb250ZXh0XQoKVGhlIG9yaWdpbmFsIGNvZGUgaGFkICd1bnNpZ25lZCBzaG9ydCcgaGVy
ZSwgYnV0IGluY29ycmVjdGx5IGdvdApjb252ZXJ0ZWQgdG8gJ2Jvb2wnLiBUaGlzIHJldmVydHMg
dGhlIHJlZ3Jlc3Npb24gYW5kIHVzZXMgYSBub3JtYWwKdHlwZSBpbnN0ZWFkLgoKRml4ZXM6IDI5
MTQ4NTQzYzUyMSAoInN0YWdpbmc6aWlvOnJlc29sdmVyOmFkMnMxMjEwIG1pbmltYWwgY2hhbiBz
cGVjIGNvbnZlcnNpb24uIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1i
eTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KLS0tCiBkcml2ZXJzL3N0YWdpbmcvaWlv
L3Jlc29sdmVyL2FkMnMxMjEwLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlvL3Jlc29s
dmVyL2FkMnMxMjEwLmMgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL3Jlc29sdmVyL2FkMnMxMjEwLmMK
aW5kZXggYTZhODM5M2Q2NjY0Li4zZTAwZGY3NGIxOGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3Rh
Z2luZy9paW8vcmVzb2x2ZXIvYWQyczEyMTAuYworKysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL3Jl
c29sdmVyL2FkMnMxMjEwLmMKQEAgLTQ3Miw3ICs0NzIsNyBAQCBzdGF0aWMgaW50IGFkMnMxMjEw
X3JlYWRfcmF3KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsCiAJCQkgICAgIGxvbmcgbSkKIHsK
IAlzdHJ1Y3QgYWQyczEyMTBfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsKLQlib29s
IG5lZ2F0aXZlOworCXUxNiBuZWdhdGl2ZTsKIAlpbnQgcmV0ID0gMDsKIAl1MTYgcG9zOwogCXMx
NiB2ZWw7Ci0tIAoyLjkuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCg==
