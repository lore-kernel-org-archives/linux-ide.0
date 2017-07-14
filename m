From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 04/14] x86: math-emu: avoid -Wint-in-bool-context warning
Date: Fri, 14 Jul 2017 11:25:16 +0200
Message-ID: <20170714092540.1217397-5-arnd@arndb.de>
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
To: linux-kernel@vger.kernel.org, Bill Metzenthen <billm@melbpc.org.au>, x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

VGhlIHNldHNpZ24oKSBtYWNybyBnZXRzIGNhbGxlZCB3aXRoIGFuIGludGVnZXIgYXJndW1lbnQg
aW4gYQpmZXcgcGxhY2VzLCBsZWFkaW5nIHRvIGEgaGFybWxlc3Mgd2FybmluZyBpbiBnY2MtNzoK
CmFyY2gveDg2L21hdGgtZW11L3JlZ19hZGRfc3ViLmM6IEluIGZ1bmN0aW9uICdGUFVfYWRkJzoK
YXJjaC94ODYvbWF0aC1lbXUvcmVnX2FkZF9zdWIuYzo4MDo0ODogZXJyb3I6ID86IHVzaW5nIGlu
dGVnZXIgY29uc3RhbnRzIGluIGJvb2xlYW4gY29udGV4dCBbLVdlcnJvcj1pbnQtaW4tYm9vbC1j
b250ZXh0XQoKVGhpcyB0dXJucyB0aGUgaW50ZWdlciBpbnRvIGEgYm9vbGVhbiBleHByZXNzaW9u
IGJ5IGNvbXBhcmluZyBpdAp0byB6ZXJvLgoKU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8
YXJuZEBhcm5kYi5kZT4KLS0tCiBhcmNoL3g4Ni9tYXRoLWVtdS9mcHVfZW11LmggfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9tYXRoLWVtdS9mcHVfZW11LmggYi9hcmNoL3g4Ni9tYXRoLWVtdS9mcHVfZW11
LmgKaW5kZXggYWZiYzRkODA1ZDY2Li5jOWMzMjBkY2NjYTEgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2
L21hdGgtZW11L2ZwdV9lbXUuaAorKysgYi9hcmNoL3g4Ni9tYXRoLWVtdS9mcHVfZW11LmgKQEAg
LTE1Nyw3ICsxNTcsNyBAQCBleHRlcm4gdV9jaGFyIGNvbnN0IGRhdGFfc2l6ZXNfMTZbMzJdOwog
CiAjZGVmaW5lIHNpZ25ieXRlKGEpICgoKHVfY2hhciAqKShhKSlbOV0pCiAjZGVmaW5lIGdldHNp
Z24oYSkgKHNpZ25ieXRlKGEpICYgMHg4MCkKLSNkZWZpbmUgc2V0c2lnbihhLGIpIHsgaWYgKGIp
IHNpZ25ieXRlKGEpIHw9IDB4ODA7IGVsc2Ugc2lnbmJ5dGUoYSkgJj0gMHg3ZjsgfQorI2RlZmlu
ZSBzZXRzaWduKGEsYikgeyBpZiAoKGIpICE9IDApIHNpZ25ieXRlKGEpIHw9IDB4ODA7IGVsc2Ug
c2lnbmJ5dGUoYSkgJj0gMHg3ZjsgfQogI2RlZmluZSBjb3B5c2lnbihhLGIpIHsgaWYgKGdldHNp
Z24oYSkpIHNpZ25ieXRlKGIpIHw9IDB4ODA7IFwKICAgICAgICAgICAgICAgICAgICAgICAgIGVs
c2Ugc2lnbmJ5dGUoYikgJj0gMHg3ZjsgfQogI2RlZmluZSBjaGFuZ2VzaWduKGEpIHsgc2lnbmJ5
dGUoYSkgXj0gMHg4MDsgfQotLSAKMi45LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaS1kZXZlbAo=
