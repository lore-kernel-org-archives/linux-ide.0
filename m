From: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>
Subject: [PATCH 3/6] ARM: berlin: add the AHCI node for the BG2Q
Date: Tue, 22 Apr 2014 17:38:22 +0200
Message-ID: <1398181105-19714-4-git-send-email-antoine.tenart@free-electrons.com>
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

VGhlIEJHMlEgaGFzIGFuIEFIQ0kgU0FUQSBjb250cm9sbGVyLiBBZGQgdGhlIGNvcnJlc3BvbmRp
bmcgbm9kZQppbiBpdHMgZGV2aWNlIHRyZWUuCgpTaWduZWQtb2ZmLWJ5OiBBbnRvaW5lIFTDqW5h
cnQgPGFudG9pbmUudGVuYXJ0QGZyZWUtZWxlY3Ryb25zLmNvbT4KLS0tCiBhcmNoL2FybS9ib290
L2R0cy9iZXJsaW4ycS5kdHNpIHwgMTIgKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTIg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2JlcmxpbjJxLmR0
c2kgYi9hcmNoL2FybS9ib290L2R0cy9iZXJsaW4ycS5kdHNpCmluZGV4IDA3NDUyYTc0ODNmYS4u
OGU1OGFhZTczMzY1IDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290L2R0cy9iZXJsaW4ycS5kdHNp
CisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2JlcmxpbjJxLmR0c2kKQEAgLTE4Myw2ICsxODMsMTgg
QEAKIAkJCX07CiAJCX07CiAKKwkJYWhjaTogc2F0YUBlOTAwMDAgeworCQkJY29tcGF0aWJsZSA9
ICJtYXJ2ZWxsLGJlcmxpbi1haGNpIjsKKwkJCXJlZyA9IDwweGU5MDAwMCAweDEwMDAwPjsKKwkJ
CWludGVycnVwdHMgPSA8R0lDX1NQSSA3IElSUV9UWVBFX0xFVkVMX0hJR0g+OworCQkJc3RhdHVz
ID0gImRpc2FibGUiOworCQl9OworCisJCWdlbmVyaWMtcmVnc0BlYTAxMTAgeworCQkJY29tcGF0
aWJsZSA9ICJtYXJ2ZWxsLGJlcmxpbi1nZW5lcmljLXJlZ3MiLCAic3lzY29uIjsKKwkJCXJlZyA9
IDwweGVhMDExMCAweDEwPjsKKwkJfTsKKwogCQlhcGJAZmMwMDAwIHsKIAkJCWNvbXBhdGlibGUg
PSAic2ltcGxlLWJ1cyI7CiAJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKLS0gCjEuOC4zLjIKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
