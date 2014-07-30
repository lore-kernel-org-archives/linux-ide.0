From: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>
Subject: [PATCH v14 7/8] ARM: berlin: add the AHCI node for the BG2Q
Date: Wed, 30 Jul 2014 20:14:00 +0200
Message-ID: <1406744041-1269-8-git-send-email-antoine.tenart@free-electrons.com>
References: <1406744041-1269-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1406744041-1269-1-git-send-email-antoine.tenart@free-electrons.com>
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
Cc: thomas.petazzoni@free-electrons.com, zmxu@marvell.com, =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

VGhlIEJHMlEgaGFzIGFuIEFIQ0kgU0FUQSBjb250cm9sbGVyLiBBZGQgdGhlIGNvcnJlc3BvbmRp
bmcgbm9kZXMKKEFIQ0ksIFBIWSkgaW50byBpdHMgZGV2aWNlIHRyZWUuCgpTaWduZWQtb2ZmLWJ5
OiBBbnRvaW5lIFTDqW5hcnQgPGFudG9pbmUudGVuYXJ0QGZyZWUtZWxlY3Ryb25zLmNvbT4KLS0t
CiBhcmNoL2FybS9ib290L2R0cy9iZXJsaW4ycS5kdHNpIHwgMzkgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2JlcmxpbjJxLmR0c2kgYi9hcmNoL2FybS9i
b290L2R0cy9iZXJsaW4ycS5kdHNpCmluZGV4IDYzNWExNmE2NGNiNC4uNjU4OTc1ZDIyZGY3IDEw
MDY0NAotLS0gYS9hcmNoL2FybS9ib290L2R0cy9iZXJsaW4ycS5kdHNpCisrKyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2JlcmxpbjJxLmR0c2kKQEAgLTMwMyw2ICszMDMsNDUgQEAKIAkJCWNsb2NrLW5h
bWVzID0gInJlZmNsayI7CiAJCX07CiAKKwkJYWhjaTogc2F0YUBlOTAwMDAgeworCQkJY29tcGF0
aWJsZSA9ICJtYXJ2ZWxsLGJlcmxpbjJxLWFoY2kiLCAiZ2VuZXJpYy1haGNpIjsKKwkJCXJlZyA9
IDwweGU5MDAwMCAweDEwMDA+OworCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDcgSVJRX1RZUEVf
TEVWRUxfSElHSD47CisJCQljbG9ja3MgPSA8JmNoaXAgQ0xLSURfU0FUQT47CisJCQkjYWRkcmVz
cy1jZWxscyA9IDwxPjsKKwkJCSNzaXplLWNlbGxzID0gPDA+OworCisJCQlzYXRhMDogc2F0YS1w
b3J0QDAgeworCQkJCXJlZyA9IDwwPjsKKwkJCQlwaHlzID0gPCZzYXRhX3BoeSAwPjsKKwkJCQlz
dGF0dXMgPSAiZGlzYWJsZWQiOworCQkJfTsKKworCQkJc2F0YTE6IHNhdGEtcG9ydEAxIHsKKwkJ
CQlyZWcgPSA8MT47CisJCQkJcGh5cyA9IDwmc2F0YV9waHkgMT47CisJCQkJc3RhdHVzID0gImRp
c2FibGVkIjsKKwkJCX07CisJCX07CisKKwkJc2F0YV9waHk6IHBoeUBlOTAwYTAgeworCQkJY29t
cGF0aWJsZSA9ICJtYXJ2ZWxsLGJlcmxpbjJxLXNhdGEtcGh5IjsKKwkJCXJlZyA9IDwweGU5MDBh
MCAweDIwMD47CisJCQljbG9ja3MgPSA8JmNoaXAgQ0xLSURfU0FUQT47CisJCQkjYWRkcmVzcy1j
ZWxscyA9IDwxPjsKKwkJCSNzaXplLWNlbGxzID0gPDA+OworCQkJI3BoeS1jZWxscyA9IDwxPjsK
KwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7CisKKwkJCXNhdGEtcGh5QDAgeworCQkJCXJlZyA9IDww
PjsKKwkJCX07CisKKwkJCXNhdGEtcGh5QDEgeworCQkJCXJlZyA9IDwxPjsKKwkJCX07CisJCX07
CisKIAkJYXBiQGZjMDAwMCB7CiAJCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOwogCQkJI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47Ci0tIAoxLjkuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
