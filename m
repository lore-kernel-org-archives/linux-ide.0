From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 03/23] ata: sata_dwc_460ex: set dma_boundary to 0x1fff
Date: Tue, 26 Apr 2016 12:03:04 +0300
Message-ID: <1461661404-1952-4-git-send-email-andriy.shevchenko@linux.intel.com>
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

VGhlIG9yaWdpbmFsIGNvZGUgc3RhdGVzOgoKCU1ha2Ugc3VyZSBhIExMSSBibG9jayBpcyBub3Qg
Y3JlYXRlZCB0aGF0IHdpbGwgc3BhbiA4SyBtYXggRklTCglib3VuZGFyeS4gSWYgdGhlIGJsb2Nr
IHNwYW5zIHN1Y2ggYSBGSVMgYm91bmRhcnksIHRoZXJlIGlzIGEgY2hhbmNlCgl0aGF0IGEgRE1B
IGJ1cnN0IHdpbGwgY3Jvc3MgdGhhdCBib3VuZGFyeSAtLSB0aGlzIHJlc3VsdHMgaW4gYW4gZXJy
b3IKCWluIHRoZSBob3N0IGNvbnRyb2xsZXIuCgpTaW5jZSB3ZSBoYXZlIHN3aXRjaGVkIHRvIGdl
bmVyaWMgRE1BZW5naW5lIEFQSSB3ZSBzYXRpc2Z5IGFib3ZlIGJ5IHNldHRpbmcKZG1hX2JvdW5k
YXJ5IHZhbHVlIHRvIDB4MWZmZi4KClN1Z2dlc3RlZC1ieTogTWFucyBSdWxsZ2FyZCA8bWFuc0Bt
YW5zci5jb20+ClRlc3RlZC1ieTogQ2hyaXN0aWFuIExhbXBhcnRlciA8Y2h1bmtlZXlAZ29vZ2xl
bWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVu
a29AbGludXguaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvYXRhL3NhdGFfZHdjXzQ2MGV4LmMgfCA4
ICsrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvc2F0YV9kd2NfNDYwZXguYyBiL2RyaXZlcnMvYXRh
L3NhdGFfZHdjXzQ2MGV4LmMKaW5kZXggN2Y5NTM4OS4uYWVlODg3MyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9hdGEvc2F0YV9kd2NfNDYwZXguYworKysgYi9kcml2ZXJzL2F0YS9zYXRhX2R3Y180NjBl
eC5jCkBAIC0xMTUxLDcgKzExNTEsMTMgQEAgc3RhdGljIHN0cnVjdCBzY3NpX2hvc3RfdGVtcGxh
dGUgc2F0YV9kd2Nfc2h0ID0gewogCSAqLwogCS5zZ190YWJsZXNpemUJCT0gTElCQVRBX01BWF9Q
UkQsCiAJLyogLmNhbl9xdWV1ZQkJPSBBVEFfTUFYX1FVRVVFLCAqLwotCS5kbWFfYm91bmRhcnkJ
CT0gQVRBX0RNQV9CT1VOREFSWSwKKwkvKgorCSAqIE1ha2Ugc3VyZSBhIExMSSBibG9jayBpcyBu
b3QgY3JlYXRlZCB0aGF0IHdpbGwgc3BhbiA4SyBtYXggRklTCisJICogYm91bmRhcnkuIElmIHRo
ZSBibG9jayBzcGFucyBzdWNoIGEgRklTIGJvdW5kYXJ5LCB0aGVyZSBpcyBhIGNoYW5jZQorCSAq
IHRoYXQgYSBETUEgYnVyc3Qgd2lsbCBjcm9zcyB0aGF0IGJvdW5kYXJ5IC0tIHRoaXMgcmVzdWx0
cyBpbiBhbgorCSAqIGVycm9yIGluIHRoZSBob3N0IGNvbnRyb2xsZXIuCisJICovCisJLmRtYV9i
b3VuZGFyeQkJPSAweDFmZmYgLyogQVRBX0RNQV9CT1VOREFSWSAqLywKIH07CiAKIHN0YXRpYyBz
dHJ1Y3QgYXRhX3BvcnRfb3BlcmF0aW9ucyBzYXRhX2R3Y19vcHMgPSB7Ci0tIAoyLjguMC5yYzMK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4cHBj
LWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9s
aXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldg==
