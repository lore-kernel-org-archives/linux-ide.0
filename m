From: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>
Subject: [PATCH v4 4/7] ata: ahci_platform: add the Marvell Berlin AHCI
 compatible
Date: Tue, 20 May 2014 11:04:32 +0200
Message-ID: <1400576675-25265-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
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

VGhlIE1hcnZlbGwgQmVybGluIEFIQ0kgaGFzIGFsbCBoaXMgc3BlY2lmaWMgaW4gdGhlIFBIWSBk
cml2ZXIuIEl0IHRoZW4Kb25seSBuZWVkIHRvIHVzZSB0aGUgbGliYWhjaSBmdW5jdGlvbnMgdG8g
d29yayBwcm9wZXJseS4KCkFkZCBpdHMgY29tcGF0aWJsZSBpbnRvIHRoZSBsaWJhaGNpX3BsYXRm
b3JtIGRyaXZlci4KClNpZ25lZC1vZmYtYnk6IEFudG9pbmUgVMOpbmFydCA8YW50b2luZS50ZW5h
cnRAZnJlZS1lbGVjdHJvbnMuY29tPgotLS0KIGRyaXZlcnMvYXRhL2FoY2lfcGxhdGZvcm0uYyB8
IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9hdGEvYWhjaV9wbGF0Zm9ybS5jIGIvZHJpdmVycy9hdGEvYWhjaV9wbGF0Zm9ybS5jCmluZGV4
IGVmNjdlNzk5NDRmOS4uYmMwNTBhYWJmMjA2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2F0YS9haGNp
X3BsYXRmb3JtLmMKKysrIGIvZHJpdmVycy9hdGEvYWhjaV9wbGF0Zm9ybS5jCkBAIC03Niw2ICs3
Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGFoY2lfb2ZfbWF0Y2hbXSA9
IHsKIAl7IC5jb21wYXRpYmxlID0gInNucHMsZXh5bm9zNTQ0MC1haGNpIiwgfSwKIAl7IC5jb21w
YXRpYmxlID0gImlibSw0NzZndHItYWhjaSIsIH0sCiAJeyAuY29tcGF0aWJsZSA9ICJzbnBzLGR3
Yy1haGNpIiwgfSwKKwl7IC5jb21wYXRpYmxlID0gIm1hcnZlbGwsYmVybGluLWFoY2kiLCB9LAog
CXt9LAogfTsKIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGFoY2lfb2ZfbWF0Y2gpOwotLSAKMS45
LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
