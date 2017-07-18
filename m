From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/14] proc/kcore: hide a harmless warning
Date: Tue, 18 Jul 2017 21:53:40 +0200
Message-ID: <CAK8P3a3qrkZLkL=PuUHkaq9p021-Y+odTj5UrdM=dZw8L=oM8g@mail.gmail.com>
References: <20170714092540.1217397-1-arnd@arndb.de>
 <20170714092540.1217397-8-arnd@arndb.de>
 <CAKv+Gu9+0H9w8z8_Zedd-RxXt89Y7sJ=57_ZTThfDpFe4H0uXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAKv+Gu9+0H9w8z8_Zedd-RxXt89Y7sJ=57_ZTThfDpFe4H0uXg@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Pratyush Anand <panand@redhat.com>, Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, IDE-ML <linux-ide@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

T24gRnJpLCBKdWwgMTQsIDIwMTcgYXQgMjoyOCBQTSwgQXJkIEJpZXNoZXV2ZWwKPGFyZC5iaWVz
aGV1dmVsQGxpbmFyby5vcmc+IHdyb3RlOgo+IE9uIDE0IEp1bHkgMjAxNyBhdCAxMDoyNSwgQXJu
ZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gd3JvdGU6Cj4+IGdjYyB3YXJucyB3aGVuIE1PRFVM
RVNfVkFERFIvRU5EIGlzIGRlZmluZWQgdG8gdGhlIHNhbWUgdmFsdWUgYXMKPj4gVk1BTExPQ19T
VEFSVC9WTUFMTE9DX0VORCwgZS5nLiBvbiB4ODYtMzI6Cj4+Cj4+IGZzL3Byb2Mva2NvcmUuYzog
SW4gZnVuY3Rpb24g4oCYYWRkX21vZHVsZXNfcmFuZ2XigJk6Cj4+IGZzL3Byb2Mva2NvcmUuYzo2
MjI6MTYxOiBlcnJvcjogc2VsZi1jb21wYXJpc29uIGFsd2F5cyBldmFsdWF0ZXMgdG8gZmFsc2Ug
Wy1XZXJyb3I9dGF1dG9sb2dpY2FsLWNvbXBhcmVdCj4+ICAgaWYgKC8qTU9EVUxFU19WQUREUiAh
PSBWTUFMTE9DX1NUQVJUICYmICovTU9EVUxFU19FTkQgIT0gVk1BTExPQ19FTkQpIHsKPj4KPgo+
IERvZXMgaXQgb2NjdXIgZm9yIHN1YnRyYWN0aW9uIGFzIHdlbGw/IE9yIG9ubHkgZm9yIGNvbXBh
cmlzb24/CgpUaGlzIHJlcGxhY2VtZW50IHBhdGNoIHdvdWxkIGFsc28gYWRkcmVzcyB0aGUgd2Fy
bmluZzoKCmRpZmYgLS1naXQgYS9mcy9wcm9jL2tjb3JlLmMgYi9mcy9wcm9jL2tjb3JlLmMKaW5k
ZXggNDU2MjlmNGI1NDAyLi4zNTgyNGU5ODZjMmMgMTAwNjQ0Ci0tLSBhL2ZzL3Byb2Mva2NvcmUu
YworKysgYi9mcy9wcm9jL2tjb3JlLmMKQEAgLTYyMyw3ICs2MjMsNyBAQCBzdGF0aWMgdm9pZCBf
X2luaXQgcHJvY19rY29yZV90ZXh0X2luaXQodm9pZCkKIHN0cnVjdCBrY29yZV9saXN0IGtjb3Jl
X21vZHVsZXM7CiBzdGF0aWMgdm9pZCBfX2luaXQgYWRkX21vZHVsZXNfcmFuZ2Uodm9pZCkKIHsK
LSAgICAgICBpZiAoTU9EVUxFU19WQUREUiAhPSBWTUFMTE9DX1NUQVJUICYmIE1PRFVMRVNfRU5E
ICE9IFZNQUxMT0NfRU5EKSB7CisgICAgICAgaWYgKE1PRFVMRVNfVkFERFIgLSBWTUFMTE9DX1NU
QVJUICYmIE1PRFVMRVNfRU5EIC0gVk1BTExPQ19FTkQpIHsKICAgICAgICAgICAgICAgIGtjbGlz
dF9hZGQoJmtjb3JlX21vZHVsZXMsICh2b2lkICopTU9EVUxFU19WQUREUiwKICAgICAgICAgICAg
ICAgICAgICAgICAgTU9EVUxFU19FTkQgLSBNT0RVTEVTX1ZBRERSLCBLQ09SRV9WTUFMTE9DKTsK
ICAgICAgICB9CgpJIGhhdmUgYWxzbyB2ZXJpZmllZCB0aGF0IGZvdXIgb2YgdGhlIDE0IHBhdGNo
ZXMgYXJlIG5vdCBuZWVkZWQgd2hlbiBidWlsZGluZwp3aXRob3V0IGNjYWNoZSwgdGhpcyBpcyBv
bmUgb2YgdGhlbToKCiBhY3BpOiB0aGVybWFsOiBmaXggZ2NjLTYvY2NhY2hlIHdhcm5pbmcKIHBy
b2Mva2NvcmU6IGhpZGUgYSBoYXJtbGVzcyB3YXJuaW5nCiBTRkk6IGZpeCB0YXV0b2xvZ2ljYWwt
Y29tcGFyZSB3YXJuaW5nCiBbbWVkaWFdIGZpeCB3YXJuaW5nIG9uIHY0bDJfc3ViZGV2X2NhbGwo
KSByZXN1bHQgaW50ZXJwcmV0ZWQgYXMgYm9vbAoKTm90IHN1cmUgd2hhdCB0byBkbyB3aXRoIHRo
b3NlLCB3ZSBjb3VsZCBlaXRoZXIgaWdub3JlIHRoZW0gYWxsIGFuZApub3QgY2FyZSBhYm91dCBj
Y2FjaGUsIG9yIHdlIHRyeSB0byBhZGRyZXNzIHRoZW0gYWxsIGluIHNvbWUgd2F5LgoKICAgICAg
ICBBcm5kCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
