From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 05/23] ata: sata_dwc_460ex: DMA is always a flow controller
Date: Tue, 26 Apr 2016 12:03:06 +0300
Message-ID: <1461661404-1952-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
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
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

SW4gdGhlIG9yaWdpbmFsIGNvZGUgdGhlIERNQSBpcyBhbHdheXMgYSBmbG93IGNvbnRyb2xsZXIu
IFNldCB0aGlzIGFjY29yZGluZ2x5CmluIHVwZGF0ZWQgY29kZS4KClRlc3RlZC1ieTogQ2hyaXN0
aWFuIExhbXBhcnRlciA8Y2h1bmtlZXlAZ29vZ2xlbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEFu
ZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPgotLS0KIGRy
aXZlcnMvYXRhL3NhdGFfZHdjXzQ2MGV4LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2F0YS9zYXRhX2R3
Y180NjBleC5jIGIvZHJpdmVycy9hdGEvc2F0YV9kd2NfNDYwZXguYwppbmRleCA0Y2FjMjdkLi4x
MjUwZTE4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2F0YS9zYXRhX2R3Y180NjBleC5jCisrKyBiL2Ry
aXZlcnMvYXRhL3NhdGFfZHdjXzQ2MGV4LmMKQEAgLTMxMSw3ICszMTEsNyBAQCBzdGF0aWMgc3Ry
dWN0IGRtYV9hc3luY190eF9kZXNjcmlwdG9yICpkbWFfZHdjX3hmZXJfc2V0dXAoc3RydWN0IGF0
YV9xdWV1ZWRfY21kCiAKIAlpZiAocWMtPmRtYV9kaXIgPT0gRE1BX0RFVl9UT19NRU0pIHsKIAkJ
c2NvbmYuc3JjX2FkZHIgPSBhZGRyOwotCQlzY29uZi5kZXZpY2VfZmMgPSB0cnVlOworCQlzY29u
Zi5kZXZpY2VfZmMgPSBmYWxzZTsKIAl9IGVsc2UgewkvKiBETUFfTUVNX1RPX0RFViAqLwogCQlz
Y29uZi5kc3RfYWRkciA9IGFkZHI7CiAJCXNjb25mLmRldmljZV9mYyA9IGZhbHNlOwotLSAKMi44
LjAucmMzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0
dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
