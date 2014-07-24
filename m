From: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>
Subject: [PATCH v11 2/8] Documentation: bindings: add the Berlin SATA PHY
Date: Thu, 24 Jul 2014 11:17:24 +0200
Message-ID: <1406193450-17283-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1406193450-17283-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1406193450-17283-1-git-send-email-antoine.tenart@free-electrons.com>
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
LS0tCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvYmVybGluLXNhdGEtcGh5LnR4dCAgICB8
IDM0ICsrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25z
KCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BoeS9iZXJsaW4tc2F0YS1waHkudHh0CgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BoeS9iZXJsaW4tc2F0YS1waHkudHh0IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9iZXJsaW4tc2F0YS1waHkudHh0Cm5ldyBmaWxlIG1vZGUg
MTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uY2RhNGExMDBiMDBmCi0tLSAvZGV2L251bGwKKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9iZXJsaW4tc2F0YS1waHku
dHh0CkBAIC0wLDAgKzEsMzQgQEAKK0JlcmxpbiBTQVRBIFBIWQorLS0tLS0tLS0tLS0tLS0tCisK
K1JlcXVpcmVkIHByb3BlcnRpZXM6CistIGNvbXBhdGlibGU6IHNob3VsZCBiZSAibWFydmVsbCxi
ZXJsaW4ycS1zYXRhLXBoeSIKKy0gI2FkZHJlc3MtY2VsbHM6IHNob3VsZCBiZSAxCistICNzaXpl
LWNlbGxzOiBzaG91bGQgYmUgMAorLSAjcGh5LWNlbGxzOiBmcm9tIHRoZSBnZW5lcmljIFBIWSBi
aW5kaW5ncywgbXVzdCBiZSAxCistIHJlZzogYWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSByZWdp
c3RlcgorLSBjbG9ja3M6IHJlZmVyZW5jZSB0byB0aGUgY2xvY2sgZW50cnkKKworU3ViLW5vZGVz
OgorRWFjaCBQSFkgc2hvdWxkIGJlIHJlcHJlc2VudGVkIGFzIGEgc3ViLW5vZGUuCisKK1N1Yi1u
b2RlcyByZXF1aXJlZCBwcm9wZXJ0aWVzOgorLSByZWc6IHRoZSBQSFkgbnVtYmVyCisKK0V4YW1w
bGU6CisJc2F0YV9waHk6IHBoeUBmN2U5MDBhMCB7CisJCWNvbXBhdGlibGUgPSAibWFydmVsbCxi
ZXJsaW4ycS1zYXRhLXBoeSI7CisJCXJlZyA9IDwweGY3ZTkwMGEwIDB4MjAwPjsKKwkJY2xvY2tz
ID0gPCZjaGlwIENMS0lEX1NBVEE+OworCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKKwkJI3NpemUt
Y2VsbHMgPSA8MD47CisJCSNwaHktY2VsbHMgPSA8MT47CisKKwkJc2F0YS1waHlAMCB7CisJCQly
ZWcgPSA8MD47CisJCX07CisKKwkJc2F0YS1waHlAMSB7CisJCQlyZWcgPSA8MT47CisJCX07CisJ
fTsKLS0gCjEuOS4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
