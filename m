From: Martin Hicks <mort@bork.org>
Subject: [PATCH] sata-fsl: Apply link speed limits
Date: Thu, 19 Feb 2015 15:05:47 -0500
Message-ID: <20150219200547.GA25730@darwin.bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Scott Wood <scottwood@freescale.com>, Kumar Gala <galak@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-ide@vger.kernel.org

CgpUaGUgZHJpdmVyIHdhcyBpZ25vcmluZyBsaW1pdHMgcmVxdWVzdGVkIGJ5IGxpYmF0YS5mb3Jj
ZS4gIFRoZSBvdXRwdXQKd291bGQgbG9vayBsaWtlOgoKZnNsLXNhdGEgZmZlMTgwMDAuc2F0YTog
U2F0YSBGU0wgUGxhdGZvcm0vQ1NCIERyaXZlciBpbml0CmF0YTE6IEZPUkNFOiBQSFkgc3BkIGxp
bWl0IHNldCB0byAxLjVHYnBzCmF0YTE6IFNBVEEgbWF4IFVETUEvMTMzIGlycSA3NAphdGExOiBT
aWduYXR1cmUgVXBkYXRlIGRldGVjdGVkIEAgMCBtc2VjcwphdGExOiBTQVRBIGxpbmsgdXAgMy4w
IEdicHMgKFNTdGF0dXMgMTIzIFNDb250cm9sIDMxMCkKClNpZ25lZC1vZmYtYnk6IE1hcnRpbiBI
aWNrcyA8bW9ydEBib3JrLm9yZz4KLS0tCiBkcml2ZXJzL2F0YS9zYXRhX2ZzbC5jIHwgICAgMiAr
KwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
YXRhL3NhdGFfZnNsLmMgYi9kcml2ZXJzL2F0YS9zYXRhX2ZzbC5jCmluZGV4IGY5MDU0Y2QuLmE5
YjU1MDggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYXRhL3NhdGFfZnNsLmMKKysrIGIvZHJpdmVycy9h
dGEvc2F0YV9mc2wuYwpAQCAtODY4LDYgKzg2OCw4IEBAIHRyeV9vZmZsaW5lX2FnYWluOgogCSAq
IFBIWSByZXNldCBzaG91bGQgcmVtYWluIGFzc2VydGVkIGZvciBhdGxlYXN0IDFtcwogCSAqLwog
CWF0YV9tc2xlZXAoYXAsIDEpOworCQorCXNhdGFfc2V0X3NwZChsaW5rKTsKIAogCS8qCiAJICog
Tm93LCBicmluZyB0aGUgaG9zdCBjb250cm9sbGVyIG9ubGluZSBhZ2FpbiwgdGhpcyBjYW4gdGFr
ZSB0aW1lCi0tIAoxLjcuMTAuNAoKCi0tIApNYXJ0aW4gSGlja3MgUC5FbmcuICAgIHwgICAgICBt
b3J0QGJvcmsub3JnCkJvcmsgQ29uc3VsdGluZyBJbmMuICAgfCAgKzEgKDYxMykgMjY2LTIyOTYK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
