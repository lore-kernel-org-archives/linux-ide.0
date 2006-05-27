From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
 fails: libata issue
Date: Sat, 27 May 2006 14:54:30 -0400
Message-ID: <4478A066.8090808@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org> <4477CEF5.9000908@garzik.org> <200605271423.40037.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030508080204070708000504"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:17293 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964933AbWE0Syk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 14:54:40 -0400
In-Reply-To: <200605271423.40037.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030508080204070708000504
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Mark Lord wrote:
> On Saturday 27 May 2006 00:00, Jeff Garzik wrote:
>> Although I didn't even bother to compile-test it, here is the 
>> recommended solution, as described multiple times...
> 
> ..
> 
> That patch has ZERO (positive) effect on my machine.
> It still crashes miserably with a zillion "read errors" on resume
> (drive not accessible).

Output please?  Did you get any failed-to-resume messages?


> The original "bad layering" patch still works perfectly in it's place.
> Repeated below for Linus's benefit.

Actually, unfortunately I don't see that here.  On my ICH7 in x86-64 
ata_piix combined mode, it hard locks.  In x86 mode, it appears to work 
(or at least not break anything, since resume works without the patch 
too on this box) both in combined mode and native mode.

Since this is claimed to be a regression, what was the last upstream 
kernel version that worked for you?  2.6.16.x?

Finally, if you could test the updated patch I posted, and/or the one 
that is attached, that would be preferred.

	Jeff





--------------030508080204070708000504
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9hdGFfcGlpeC5jIGIvZHJpdmVycy9zY3NpL2F0
YV9waWl4LmMKaW5kZXggNmRjODgxNC4uOTQ5ZDQ5NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9z
Y3NpL2F0YV9waWl4LmMKKysrIGIvZHJpdmVycy9zY3NpL2F0YV9waWl4LmMKQEAgLTIwMSw3
ICsyMDEsNyBAQCBzdGF0aWMgc3RydWN0IHBjaV9kcml2ZXIgcGlpeF9wY2lfZHJpdmVyCiAJ
LnByb2JlCQkJPSBwaWl4X2luaXRfb25lLAogCS5yZW1vdmUJCQk9IGF0YV9wY2lfcmVtb3Zl
X29uZSwKIAkuc3VzcGVuZAkJPSBhdGFfcGNpX2RldmljZV9zdXNwZW5kLAotCS5yZXN1bWUJ
CQk9IGF0YV9wY2lfZGV2aWNlX3Jlc3VtZSwKKwkucmVzdW1lCQkJPSBwYXRhX3BjaV9kZXZp
Y2VfcmVzdW1lLAogfTsKIAogc3RhdGljIHN0cnVjdCBzY3NpX2hvc3RfdGVtcGxhdGUgcGlp
eF9zaHQgPSB7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvbGliYXRhLWNvcmUuYyBiL2Ry
aXZlcnMvc2NzaS9saWJhdGEtY29yZS5jCmluZGV4IGZhNDc2ZTcuLjViN2FiN2IgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvc2NzaS9saWJhdGEtY29yZS5jCisrKyBiL2RyaXZlcnMvc2NzaS9s
aWJhdGEtY29yZS5jCkBAIC00ODUyLDYgKzQ4NTIsMzAgQEAgaW50IGF0YV9wY2lfZGV2aWNl
X3Jlc3VtZShzdHJ1Y3QgcGNpX2RldgogCXBjaV9zZXRfbWFzdGVyKHBkZXYpOwogCXJldHVy
biAwOwogfQorCitpbnQgcGF0YV9wY2lfZGV2aWNlX3Jlc3VtZShzdHJ1Y3QgcGNpX2RldiAq
cGRldikKK3sKKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwY2lfZGV2X3RvX2RldihwZGV2KTsK
KwlzdHJ1Y3QgYXRhX2hvc3Rfc2V0ICpob3N0X3NldCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYp
OworCXN0cnVjdCBhdGFfcG9ydCAqYXA7CisJdTggc3RhdHVzOworCWludCBpOworCisJYXRh
X3BjaV9kZXZpY2VfcmVzdW1lKHBkZXYpOworCisJbWRlbGF5KDQwMCk7CisKKwlmb3IgKGkg
PSAwOyBpIDwgaG9zdF9zZXQtPm5fcG9ydHM7IGkrKykgeworCQlhcCA9IGhvc3Rfc2V0LT5w
b3J0c1tpXTsKKworCQlzdGF0dXMgPSBhdGFfYnVzeV93YWl0KGFwLCBBVEFfQlVTWSwgMjAw
MDAwKTsKKwkJaWYgKHN0YXR1cyAmIEFUQV9CVVNZKQorCQkJcHJpbnRrKEtFUk5fRVJSICJh
dGEldTogZmFpbGVkIHRvIHJlc3VtZVxuIiwgYXAtPmlkKTsKKwl9CisKKwlyZXR1cm4gMDsK
K30KKwogI2VuZGlmIC8qIENPTkZJR19QQ0kgKi8KIAogCkBAIC00OTcwLDYgKzQ5OTQsNyBA
QCBFWFBPUlRfU1lNQk9MX0dQTChhdGFfcGNpX2luaXRfb25lKTsKIEVYUE9SVF9TWU1CT0xf
R1BMKGF0YV9wY2lfcmVtb3ZlX29uZSk7CiBFWFBPUlRfU1lNQk9MX0dQTChhdGFfcGNpX2Rl
dmljZV9zdXNwZW5kKTsKIEVYUE9SVF9TWU1CT0xfR1BMKGF0YV9wY2lfZGV2aWNlX3Jlc3Vt
ZSk7CitFWFBPUlRfU1lNQk9MX0dQTChwYXRhX3BjaV9kZXZpY2VfcmVzdW1lKTsKIEVYUE9S
VF9TWU1CT0xfR1BMKGF0YV9wY2lfZGVmYXVsdF9maWx0ZXIpOwogRVhQT1JUX1NZTUJPTF9H
UEwoYXRhX3BjaV9jbGVhcl9zaW1wbGV4KTsKICNlbmRpZiAvKiBDT05GSUdfUENJICovCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2xpYmF0YS5oIGIvaW5jbHVkZS9saW51eC9saWJh
dGEuaAppbmRleCBiODBkMmU3Li5jYWQ1MzFhIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4
L2xpYmF0YS5oCisrKyBiL2luY2x1ZGUvbGludXgvbGliYXRhLmgKQEAgLTUxNiw2ICs1MTYs
NyBAQCBleHRlcm4gaW50IGF0YV9wY2lfaW5pdF9vbmUgKHN0cnVjdCBwY2lfCiBleHRlcm4g
dm9pZCBhdGFfcGNpX3JlbW92ZV9vbmUgKHN0cnVjdCBwY2lfZGV2ICpwZGV2KTsKIGV4dGVy
biBpbnQgYXRhX3BjaV9kZXZpY2Vfc3VzcGVuZChzdHJ1Y3QgcGNpX2RldiAqcGRldiwgcG1f
bWVzc2FnZV90IHN0YXRlKTsKIGV4dGVybiBpbnQgYXRhX3BjaV9kZXZpY2VfcmVzdW1lKHN0
cnVjdCBwY2lfZGV2ICpwZGV2KTsKK2V4dGVybiBpbnQgcGF0YV9wY2lfZGV2aWNlX3Jlc3Vt
ZShzdHJ1Y3QgcGNpX2RldiAqcGRldik7CiBleHRlcm4gaW50IGF0YV9wY2lfY2xlYXJfc2lt
cGxleChzdHJ1Y3QgcGNpX2RldiAqcGRldik7CiAjZW5kaWYgLyogQ09ORklHX1BDSSAqLwog
ZXh0ZXJuIGludCBhdGFfZGV2aWNlX2FkZChjb25zdCBzdHJ1Y3QgYXRhX3Byb2JlX2VudCAq
ZW50KTsK
--------------030508080204070708000504--
