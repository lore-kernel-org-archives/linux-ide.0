From: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>
Subject: [PATCH 0/6] ARM: berlin: add AHCI support
Date: Tue, 22 Apr 2014 17:38:19 +0200
Message-ID: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org
Cc: zmxu@marvell.com, jszhang@marvell.com, devicetree@vger.kernel.org, =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

VGhpcyBzZXJpZXMgYWRkcyB0aGUgc3VwcG9ydCBmb3IgQmVybGluIFNvQ3MgQUhDSSBjb250cm9s
bGVycy4gVGhlCmNvbnRyb2xsZXIgYWxsb3dzIHRvIHVzZSB0aGUgU0FUQSBob3N0IGludGVyZmFj
ZSBhbmQsIGZvciBleGFtcGxlLCB0aGUKZVNBVEEgcG9ydCBvbiB0aGUgQkcyUS4KCkFsc28gZW5h
YmxlIHRoZSBlU0FUQSBpbnRlcmZhY2Ugb24gdGhlIEJHMlEgRE1QLgoKVGVzdGVkIG9uIHRoZSBC
RzJRIERNUC4KCkFudG9pbmUgVMOpbmFydCAoNik6CiAgYXRhOiBhaGNpOiBhZGQgQUhDSSBzdXBw
b3J0IGZvciBCZXJsaW4gU29DcwogIERvY3VtZW50YXRpb246IGJpbmRpbmdzOiBhZGQgdGhlIGJl
cmxpbi1hY2hpIGNvbXBhdGlibGUgdG8gdGhlIGFoY2kKICAgIHBsYXRmb3JtCiAgQVJNOiBiZXJs
aW46IGFkZCB0aGUgQUhDSSBub2RlIGZvciB0aGUgQkcyUQogIEFSTTogYmVybGluOiBlbmFibGUg
dGhlIGVTQVRBIGludGVyZmFjZSBvbiB0aGUgQkcyUSBETVAKICBBUk06IGJlcmxpbjogYWRkIHRo
ZSBBSENJIG5vZGUgZm9yIHRoZSBCRzIKICBBUk06IGJlcmxpbjogYWRkIHRoZSBBSENJIG5vZGUg
Zm9yIHRoZSBCRzJDRAoKIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2F0YS9haGNpLXBsYXRmb3Jt
LnR4dCAgICAgIHwgICAzICstCiBhcmNoL2FybS9ib290L2R0cy9iZXJsaW4yLmR0c2kgICAgICAg
ICAgICAgICAgICAgICB8ICAgNyArCiBhcmNoL2FybS9ib290L2R0cy9iZXJsaW4yY2QuZHRzaSAg
ICAgICAgICAgICAgICAgICB8ICAgNyArCiBhcmNoL2FybS9ib290L2R0cy9iZXJsaW4ycS1tYXJ2
ZWxsLWRtcC5kdHMgICAgICAgICB8ICAgNSArCiBhcmNoL2FybS9ib290L2R0cy9iZXJsaW4ycS5k
dHNpICAgICAgICAgICAgICAgICAgICB8ICAxMiArKwogZHJpdmVycy9hdGEvS2NvbmZpZyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKysKIGRyaXZlcnMvYXRhL01ha2VmaWxl
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKIGRyaXZlcnMvYXRhL2FoY2lf
YmVybGluLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTc1ICsrKysrKysrKysrKysrKysr
KysrKwogOCBmaWxlcyBjaGFuZ2VkLCAyMTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvYXRhL2FoY2lfYmVybGluLmMKCi0tIAoxLjguMy4y
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
