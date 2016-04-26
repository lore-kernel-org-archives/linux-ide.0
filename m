From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 08/23] ata: sata_dwc_460ex: don't call ata_sff_qc_issue()
 on DMA commands
Date: Tue, 26 Apr 2016 12:03:09 +0300
Message-ID: <1461661404-1952-9-git-send-email-andriy.shevchenko@linux.intel.com>
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

YXRhX3NmZl9xY19pc3N1ZSgpIGNhbid0IGhhbmRsZSBETUEgY29tbWFuZHMgYW5kIHRodXMgd2Ug
aGF2ZSB0byBhdm9pZCBpdCBmb3IKdGhlbS4gRG8gY2FsbCBhdGFfYm1kbWFfcWNfaXNzdWUoKSBp
bnN0ZWFkIGZvciB0aGlzIGNhc2UuIE5vdGUgdGhhdCB0aGUgZm9ybWVyCm9uZSBkaXN0aW5ndWlz
aGVzIFBJTyBhbmQgRE1BIG1vZGUgYW5kIGJlaGF2ZXMgYWNjb3JkaW5nbHkuCgpTdWdnZXN0ZWQt
Ynk6IENocmlzdGlhbiBMYW1wYXJ0ZXIgPGNodW5rZWV5QGdvb2dsZW1haWwuY29tPgpTaWduZWQt
b2ZmLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNv
bT4KLS0tCiBkcml2ZXJzL2F0YS9zYXRhX2R3Y180NjBleC5jIHwgNCArKy0tCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYXRhL3NhdGFfZHdjXzQ2MGV4LmMgYi9kcml2ZXJzL2F0YS9zYXRhX2R3Y180NjBleC5jCmlu
ZGV4IDAzOGU1ZmIuLmYxYTRkNDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYXRhL3NhdGFfZHdjXzQ2
MGV4LmMKKysrIGIvZHJpdmVycy9hdGEvc2F0YV9kd2NfNDYwZXguYwpAQCAtMTA2MSwxMCArMTA2
MSwxMCBAQCBzdGF0aWMgdW5zaWduZWQgaW50IHNhdGFfZHdjX3FjX2lzc3VlKHN0cnVjdCBhdGFf
cXVldWVkX2NtZCAqcWMpCiAJCQlfX2Z1bmNfXywgdGFnLCBxYy0+YXAtPmxpbmsuc2FjdGl2ZSwg
c2FjdGl2ZSk7CiAKIAkJYXAtPm9wcy0+c2ZmX3RmX2xvYWQoYXAsICZxYy0+dGYpOwotCQlzYXRh
X2R3Y19leGVjX2NvbW1hbmRfYnlfdGFnKGFwLCAmcWMtPnRmLCBxYy0+dGFnLAorCQlzYXRhX2R3
Y19leGVjX2NvbW1hbmRfYnlfdGFnKGFwLCAmcWMtPnRmLCB0YWcsCiAJCQkJCSAgICAgU0FUQV9E
V0NfQ01EX0lTU1VFRF9QRU5EKTsKIAl9IGVsc2UgewotCQlhdGFfc2ZmX3FjX2lzc3VlKHFjKTsK
KwkJcmV0dXJuIGF0YV9ibWRtYV9xY19pc3N1ZShxYyk7CiAJfQogCXJldHVybiAwOwogfQotLSAK
Mi44LjAucmMzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3Jn
Cmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
