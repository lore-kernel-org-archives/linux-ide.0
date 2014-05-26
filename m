From: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>
Subject: [PATCH v5 2/7] Documentation: bindings: add the Berlin SATA PHY
Date: Mon, 26 May 2014 16:51:43 +0200
Message-ID: <1401115908-2742-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1401115908-2742-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401115908-2742-1-git-send-email-antoine.tenart@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: thomas.petazzoni@free-electrons.com, zmxu@marvell.com, devicetree@vger.kernel.org, =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

VGhlIEJlcmxpbiBTQVRBIFBIWSBkcml2ZXMgdGhlIFBIWSByZWxhdGVkIHRvIHRoZSBTQVRBIGlu
dGVyZmFjZS4gQWRkCnRoZSBjb3JyZXNwb25kaW5nIGRvY3VtZW50YXRpb24uCgpTaWduZWQtb2Zm
LWJ5OiBBbnRvaW5lIFTDqW5hcnQgPGFudG9pbmUudGVuYXJ0QGZyZWUtZWxlY3Ryb25zLmNvbT4K
LS0tCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L2Jlcmxpbi1zYXRhLXBo
eS50eHQgfCAxNCArKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMo
KykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGh5L2Jlcmxpbi1zYXRhLXBoeS50eHQKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGh5L2Jlcmxpbi1zYXRhLXBoeS50eHQgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGh5L2Jlcmxpbi1zYXRhLXBoeS50eHQKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi43MjY0NmRiMmY1ZmMKLS0tIC9kZXYvbnVsbAorKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L2Jlcmxpbi1zYXRhLXBoeS50
eHQKQEAgLTAsMCArMSwxNCBAQAorQmVybGluIFNBVEEgUEhZCistLS0tLS0tLS0tLS0tLS0KKwor
UmVxdWlyZWQgcHJvcGVydGllczoKKy0gY29tcGF0aWJsZTogIm1hcnZlbGwsYmVybGluLXNhdGEt
cGh5IgorLSBwaHktY2VsbHM6IGZyb20gdGhlIGdlbmVyaWMgUEhZIGJpbmRpbmdzLCBtdXN0IGJl
IDEKKy0gcmVnOiBhZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIHJlZ2lzdGVyCisKK0V4YW1wbGU6
CisJc2F0YV9waHk6IHBoeUBmN2U5MDBhMCB7CisJCWNvbXBhdGlibGUgPSAibWFydmVsbCxiZXJs
aW4tc2F0YS1waHkiOworCQlyZWcgPSA8MHhmN2U5MDBhMCAweDIwMD47CisJCSNwaHktY2VsbHMg
PSA8MT47CisJfTsKLS0gCjEuOS4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
