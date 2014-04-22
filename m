From: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>
Subject: [PATCH 6/6] ARM: berlin: add the AHCI node for the BG2CD
Date: Tue, 22 Apr 2014 17:38:25 +0200
Message-ID: <1398181105-19714-7-git-send-email-antoine.tenart@free-electrons.com>
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

VGhlIEJHMkNEIGhhcyBhbiBBSENJIFNBVEEgY29udHJvbGxlci4gQWRkIHRoZSBjb3JyZXNwb25k
aW5nIG5vZGUKaW4gaXRzIGRldmljZSB0cmVlLgoKU2lnbmVkLW9mZi1ieTogQW50b2luZSBUw6lu
YXJ0IDxhbnRvaW5lLnRlbmFydEBmcmVlLWVsZWN0cm9ucy5jb20+Ci0tLQogYXJjaC9hcm0vYm9v
dC9kdHMvYmVybGluMmNkLmR0c2kgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9iZXJsaW4yY2QuZHRzaSBi
L2FyY2gvYXJtL2Jvb3QvZHRzL2JlcmxpbjJjZC5kdHNpCmluZGV4IDA5NDk2OGMyNzUzMy4uMzk3
NGE1Y2FmY2NmIDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290L2R0cy9iZXJsaW4yY2QuZHRzaQor
KysgYi9hcmNoL2FybS9ib290L2R0cy9iZXJsaW4yY2QuZHRzaQpAQCAtMTY5LDYgKzE2OSwxMyBA
QAogCQkJfTsKIAkJfTsKIAorCQlhaGNpOiBzYXRhQGU5MDAwMCB7CisJCQljb21wYXRpYmxlID0g
Im1hcnZlbGwsYmVybGluLWFoY2kiOworCQkJcmVnID0gPDB4ZTkwMDAwIDB4MTAwMDA+OworCQkJ
aW50ZXJydXB0cyA9IDxHSUNfU1BJIDcgSVJRX1RZUEVfTEVWRUxfSElHSD47CisJCQlzdGF0dXMg
PSAiZGlzYWJsZSI7CisJCX07CisKIAkJYXBiQGZjMDAwMCB7CiAJCQljb21wYXRpYmxlID0gInNp
bXBsZS1idXMiOwogCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47Ci0tIAoxLjguMy4yCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
