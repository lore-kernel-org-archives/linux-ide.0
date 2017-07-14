From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 06/14] acpi: thermal: fix gcc-6/ccache warning
Date: Fri, 14 Jul 2017 11:25:18 +0200
Message-ID: <20170714092540.1217397-7-arnd@arndb.de>
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
To: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

SW4gc29tZSBjb25maWd1cmF0aW9ucywgdG9wb2xvZ3lfcGh5c2ljYWxfcGFja2FnZV9pZCgpIGlz
IHRyaXZpYWxseQpkZWZpbmVkIGFzICctMScgZm9yIGFueSBpbnB1dCwgcmVzdWx0aW5nIGEgY29t
cGFyaXNvbiB0aGF0IGlzCmFsd2F5cyB0cnVlOgoKZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl90aGVy
bWFsLmM6IEluIGZ1bmN0aW9uIOKAmGNwdWZyZXFfc2V0X2N1cl9zdGF0ZeKAmToKZHJpdmVycy9h
Y3BpL3Byb2Nlc3Nvcl90aGVybWFsLmM6MTM3OjM2OiBlcnJvcjogc2VsZi1jb21wYXJpc29uIGFs
d2F5cyBldmFsdWF0ZXMgdG8gdHJ1ZSBbLVdlcnJvcj10YXV0b2xvZ2ljYWwtY29tcGFyZV0KCkJ5
IGludHJvZHVjaW5nIGEgdGVtcG9yYXJ5IHZhcmlhYmxlLCB3ZSBjYW4gdGVsbCBnY2MgdGhhdCB0
aGlzIGlzCmludGVudGlvbmFsLgoKU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBh
cm5kYi5kZT4KLS0tCiBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX3RoZXJtYWwuYyB8IDYgKysrKy0t
CiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfdGhlcm1hbC5jIGIvZHJpdmVycy9hY3BpL3By
b2Nlc3Nvcl90aGVybWFsLmMKaW5kZXggNTljM2E1ZDFlNjAwLi40MTFmM2E3ZjRhN2MgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfdGhlcm1hbC5jCisrKyBiL2RyaXZlcnMvYWNw
aS9wcm9jZXNzb3JfdGhlcm1hbC5jCkBAIC0xMjIsMjAgKzEyMiwyMiBAQCBzdGF0aWMgaW50IGNw
dWZyZXFfZ2V0X2N1cl9zdGF0ZSh1bnNpZ25lZCBpbnQgY3B1KQogc3RhdGljIGludCBjcHVmcmVx
X3NldF9jdXJfc3RhdGUodW5zaWduZWQgaW50IGNwdSwgaW50IHN0YXRlKQogewogCWludCBpOwor
CWludCBpZDsKIAogCWlmICghY3B1X2hhc19jcHVmcmVxKGNwdSkpCiAJCXJldHVybiAwOwogCiAJ
cmVkdWN0aW9uX3BjdGcoY3B1KSA9IHN0YXRlOwogCisJaWQgPSB0b3BvbG9neV9waHlzaWNhbF9w
YWNrYWdlX2lkKGNwdSk7CisKIAkvKgogCSAqIFVwZGF0ZSBhbGwgdGhlIENQVXMgaW4gdGhlIHNh
bWUgcGFja2FnZSBiZWNhdXNlIHRoZXkgYWxsCiAJICogY29udHJpYnV0ZSB0byB0aGUgdGVtcGVy
YXR1cmUgYW5kIG9mdGVuIHNoYXJlIHRoZSBzYW1lCiAJICogZnJlcXVlbmN5LgogCSAqLwogCWZv
cl9lYWNoX29ubGluZV9jcHUoaSkgewotCQlpZiAodG9wb2xvZ3lfcGh5c2ljYWxfcGFja2FnZV9p
ZChpKSA9PQotCQkgICAgdG9wb2xvZ3lfcGh5c2ljYWxfcGFja2FnZV9pZChjcHUpKQorCQlpZiAo
dG9wb2xvZ3lfcGh5c2ljYWxfcGFja2FnZV9pZChpKSA9PSBpZCkKIAkJCWNwdWZyZXFfdXBkYXRl
X3BvbGljeShpKTsKIAl9CiAJcmV0dXJuIDA7Ci0tIAoyLjkuMAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
