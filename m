From: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>
Subject: [PATCH 4/6] ARM: berlin: enable the eSATA interface on the BG2Q DMP
Date: Tue, 22 Apr 2014 17:38:23 +0200
Message-ID: <1398181105-19714-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
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

VGhlIEJHMlEgaGFzIGFuIEFIQ0kgU0FUQSBjb250cm9sbGVyIHdpdGggYW4gZVNBVEEgaW50ZXJm
YWNlLiBFbmFibGUgaXQuCgpTaWduZWQtb2ZmLWJ5OiBBbnRvaW5lIFTDqW5hcnQgPGFudG9pbmUu
dGVuYXJ0QGZyZWUtZWxlY3Ryb25zLmNvbT4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9iZXJsaW4y
cS1tYXJ2ZWxsLWRtcC5kdHMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYmVybGluMnEtbWFydmVsbC1kbXAu
ZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYmVybGluMnEtbWFydmVsbC1kbXAuZHRzCmluZGV4IDJk
YTljNDFlMjlkOC4uMjYwNDdjZWVkNjAzIDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290L2R0cy9i
ZXJsaW4ycS1tYXJ2ZWxsLWRtcC5kdHMKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYmVybGluMnEt
bWFydmVsbC1kbXAuZHRzCkBAIC0yNiwzICsyNiw4IEBACiAmdWFydDAgewogCXN0YXR1cyA9ICJv
a2F5IjsKIH07CisKKyZhaGNpIHsKKwlzdGF0dXMgPSAib2theSI7CisJbWFydmVsbCxmb3JjZS1w
b3J0LW1hcCA9IDwxPjsKK307Ci0tIAoxLjguMy4yCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
