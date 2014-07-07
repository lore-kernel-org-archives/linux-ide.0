From: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>
Subject: [PATCH v9 4/7] ata: ahci_platform: add a generic AHCI compatible
Date: Mon,  7 Jul 2014 12:16:10 +0200
Message-ID: <1404728173-20263-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
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

VGhlIGFoY2lfcGxhdGZvcm0gZHJpdmVyIGlzIGEgZ2VuZXJpYyBkcml2ZXIgdXNpbmcgdGhlIGxp
YmFoY2lfcGxhdGZvcm0KZnVuY3Rpb25zLiBBZGQgYSBnZW5lcmljIGNvbXBhdGlibGUgdG8gYXZv
aWQgaGF2aW5nIGFuIGVuZGxlc3MgbGlzdCBvZgpjb21wYXRpYmxlcyB3aXRoIG5vIGRpZmZlcmVu
Y2VzIGZvciB0aGUgc2FtZSBkcml2ZXIuCgpTaWduZWQtb2ZmLWJ5OiBBbnRvaW5lIFTDqW5hcnQg
PGFudG9pbmUudGVuYXJ0QGZyZWUtZWxlY3Ryb25zLmNvbT4KLS0tCiBkcml2ZXJzL2F0YS9haGNp
X3BsYXRmb3JtLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9hdGEvYWhjaV9wbGF0Zm9ybS5jIGIvZHJpdmVycy9hdGEvYWhjaV9w
bGF0Zm9ybS5jCmluZGV4IGViZTUwNWMxNzc2My4uYTMwY2VjZDY4NjA5IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2F0YS9haGNpX3BsYXRmb3JtLmMKKysrIGIvZHJpdmVycy9hdGEvYWhjaV9wbGF0Zm9y
bS5jCkBAIC03OCw2ICs3OCw4IEBAIHN0YXRpYyBTSU1QTEVfREVWX1BNX09QUyhhaGNpX3BtX29w
cywgYWhjaV9wbGF0Zm9ybV9zdXNwZW5kLAogCQkJIGFoY2lfcGxhdGZvcm1fcmVzdW1lKTsKIAog
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYWhjaV9vZl9tYXRjaFtdID0geworCXsg
LmNvbXBhdGlibGUgPSAiZ2VuZXJpYy1haGNpIiwgfSwKKwkvKiBLZWVwIHRoZSBmb2xsb3dpbmcg
Y29tcGF0aWJsZXMgZm9yIGRldmljZSB0cmVlIGNvbXBhdGliaWxpdHkgKi8KIAl7IC5jb21wYXRp
YmxlID0gInNucHMsc3BlYXItYWhjaSIsIH0sCiAJeyAuY29tcGF0aWJsZSA9ICJzbnBzLGV4eW5v
czU0NDAtYWhjaSIsIH0sCiAJeyAuY29tcGF0aWJsZSA9ICJpYm0sNDc2Z3RyLWFoY2kiLCB9LAot
LSAKMS45LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
