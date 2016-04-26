From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 06/23] ata: sata_dwc_460ex: select only core part of DMA
 driver
Date: Tue, 26 Apr 2016 12:03:07 +0300
Message-ID: <1461661404-1952-7-git-send-email-andriy.shevchenko@linux.intel.com>
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

VGhlcmUgaXMgbm8gbmVlZCB0byBoYXZlIGEgcGxhdGZvcm0gZHJpdmVyIGNvbXBpbGVkIHNpbmNl
IHRoZSBETUEgZHJpdmVyIGlzCnVzZWQgYXMgYSBsaWJyYXJ5LgoKVGVzdGVkLWJ5OiBDaHJpc3Rp
YW4gTGFtcGFydGVyIDxjaHVua2VleUBnb29nbGVtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQW5k
eSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+Ci0tLQogZHJp
dmVycy9hdGEvS2NvbmZpZyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL0tjb25maWcgYi9kcml2ZXJz
L2F0YS9LY29uZmlnCmluZGV4IGNmYTkzNmEuLjdjNmU0M2EgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
YXRhL0tjb25maWcKKysrIGIvZHJpdmVycy9hdGEvS2NvbmZpZwpAQCAtMzE0LDcgKzMxNCw3IEBA
IGNvbmZpZyBBVEFfUElJWAogY29uZmlnIFNBVEFfRFdDCiAJdHJpc3RhdGUgIkRlc2lnbldhcmUg
Q29yZXMgU0FUQSBzdXBwb3J0IgogCWRlcGVuZHMgb24gNDYwRVgKLQlzZWxlY3QgRFdfRE1BQwor
CXNlbGVjdCBEV19ETUFDX0NPUkUKIAloZWxwCiAJICBUaGlzIG9wdGlvbiBlbmFibGVzIHN1cHBv
cnQgZm9yIHRoZSBvbi1jaGlwIFNBVEEgY29udHJvbGxlciBvZiB0aGUKIAkgIEFwcGxpZWRNaWNy
byBwcm9jZXNzb3IgNDYwRVguCi0tIAoyLjguMC5yYzMKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhw
cGMtZGV2QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZv
L2xpbnV4cHBjLWRldg==
