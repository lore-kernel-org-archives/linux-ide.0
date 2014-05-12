From: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>
Subject: [PATCH v2 2/6] Documentation: bindings: add the Berlin SATA PHY
Date: Mon, 12 May 2014 11:16:53 +0200
Message-ID: <1399886217-20474-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1399886217-20474-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1399886217-20474-1-git-send-email-antoine.tenart@free-electrons.com>
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
dGVyZmFjZSBhbmQKYWxsb3dzIHRvIHBvd2VyIHVwL2Rvd24gZWFjaCBQSFkgaW5kZXBlbmRlbnRs
eS4gQWRkIHRoZSBjb3JyZXNwb25kaW5nCmRvY3VtZW50YXRpb24uCgpTaWduZWQtb2ZmLWJ5OiBB
bnRvaW5lIFTDqW5hcnQgPGFudG9pbmUudGVuYXJ0QGZyZWUtZWxlY3Ryb25zLmNvbT4KLS0tCiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L2Jlcmxpbi1zYXRhLXBoeS50eHQg
fCAxNSArKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspCiBj
cmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9i
ZXJsaW4tc2F0YS1waHkudHh0CgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9iZXJsaW4tc2F0YS1waHkudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BoeS9iZXJsaW4tc2F0YS1waHkudHh0Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDAwMDAwMDAwMDAwMC4uNmQxY2Y1ZTExY2ZjCi0tLSAvZGV2L251bGwKKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9iZXJsaW4tc2F0YS1waHkudHh0CkBA
IC0wLDAgKzEsMTUgQEAKK0JlcmxpbiBTQVRBIFBIWQorLS0tLS0tLS0tLS0tLS0tCisKK1JlcXVp
cmVkIHByb3BlcnRpZXM6CistIGNvbXBhdGlibGU6ICJtYXJ2ZWxsLGJlcmxpbi1zYXRhLXBoeSIK
Ky0gI3BoeS1jZWxsczogZnJvbSB0aGUgZ2VuZXJpYyBQSFkgYmluZGluZ3MsIG11c3QgYmUgMQor
LSByZWc6IGFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgcmVnaXN0ZXIKKworRXhhbXBsZToKKwlz
YXRhX3BoeTA6IHBoeUBmN2U5MDBhMCB7CisJCWNvbXBhdGlibGUgPSAibWFydmVsbCxiZXJsaW4t
c2F0YS1waHkiOworCQlyZWcgPSA8MHhmN2U5MDBhMCAweDEwPjsKKwkJI3BoeS1jZWxscyA9IDwx
PjsKKwkJc3RhdHVzID0gIm9rYXkiOworCX07Ci0tIAoxLjkuMQoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
