From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 12/14] drm/nouveau/clk: fix gcc-7 -Wint-in-bool-context warning
Date: Fri, 14 Jul 2017 11:31:05 +0200
Message-ID: <20170714093129.1366900-3-arnd@arndb.de>
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
To: linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, nouveau@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Z2NjIHRoaW5rcyB0aGF0IGludGVycHJldGluZyBhIG11bHRpcGxpY2F0aW9uIHJlc3VsdCBhcyBh
IGJvb2wKaXMgY29uZnVzaW5nOgoKZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbnZrbS9zdWJkZXYv
Y2xrL2d0MjE1LmM6IEluIGZ1bmN0aW9uICdyZWFkX3BsbCc6CmRyaXZlcnMvZ3B1L2RybS9ub3V2
ZWF1L252a20vc3ViZGV2L2Nsay9ndDIxNS5jOjEzMzo4OiBlcnJvcjogJyonIGluIGJvb2xlYW4g
Y29udGV4dCwgc3VnZ2VzdCAnJiYnIGluc3RlYWQgWy1XZXJyb3I9aW50LWluLWJvb2wtY29udGV4
dF0KCkluIHRoaXMgaW5zdGFuY2UsIEkgdGhpbmsgdXNpbmcgbXVsdGlwbGljYXRpb24gaXMgbW9y
ZSBpbnR1aXRpdmUKdGhhbiAnJiYnLCBzbyBJJ20gYWRkaW5nIGEgY29tcGFyaXNvbiB0byB6ZXJv
IGluc3RlYWQgdG8gc2h1dCB1cAp0aGUgd2FybmluZy4gVG8gZnVydGhlciBpbXByb3ZlIHJlYWRh
YmlsaXR5LCBJIGFsc28gbWFrZSB0aGUKZXJyb3IgY2FzZSBpbmRlbnRlZCBhbmQgbGVhdmUgdGhl
IG5vcm1hbCBjYXNlIGFzIHRoZSBmaW5hbCAncmV0dXJuJwpzdGF0ZW1lbnQuCgpGaXhlczogNzYz
MmIzMGU0YjhiICgiZHJtL25vdXZlYXUvY2xrOiBuYW1lc3BhY2UgKyBudmlkaWEgZ3B1IG5hbWVz
IChubyBiaW5hcnkgY2hhbmdlKSIpClNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRA
YXJuZGIuZGU+Ci0tLQogZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbnZrbS9zdWJkZXYvY2xrL2d0
MjE1LmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9udmttL3N1YmRl
di9jbGsvZ3QyMTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L252a20vc3ViZGV2L2Nsay9n
dDIxNS5jCmluZGV4IDk2ZTA5NDFjOGVkZC4uMDRiNGY0Y2NmMTg2IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbm91dmVhdS9udmttL3N1YmRldi9jbGsvZ3QyMTUuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vbm91dmVhdS9udmttL3N1YmRldi9jbGsvZ3QyMTUuYwpAQCAtMTMwLDEwICsxMzAs
MTAgQEAgcmVhZF9wbGwoc3RydWN0IGd0MjE1X2NsayAqY2xrLCBpbnQgaWR4LCB1MzIgcGxsKQog
CQlzY2xrID0gcmVhZF9jbGsoY2xrLCAweDEwICsgaWR4LCBmYWxzZSk7CiAJfQogCi0JaWYgKE0g
KiBQKQotCQlyZXR1cm4gc2NsayAqIE4gLyAoTSAqIFApOworCWlmIChNICogUCA9PSAwKQorCQly
ZXR1cm4gMDsKIAotCXJldHVybiAwOworCXJldHVybiBzY2xrICogTiAvIChNICogUCk7CiB9CiAK
IHN0YXRpYyBpbnQKLS0gCjIuOS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWwK
