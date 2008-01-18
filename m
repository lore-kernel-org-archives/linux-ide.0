From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_mv oops on module removal
Date: Fri, 18 Jan 2008 13:23:15 +0900
Message-ID: <479029B3.5070506@gmail.com>
References: <478F5F1C.80608@wpkg.org> <478F6DB5.4080308@rtr.ca> <478F8A5A.3030003@wpkg.org> <478FFA0A.4060008@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040000090005090007010403"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:8091 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbYAREXV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jan 2008 23:23:21 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1484224wah.23
        for <linux-ide@vger.kernel.org>; Thu, 17 Jan 2008 20:23:20 -0800 (PST)
In-Reply-To: <478FFA0A.4060008@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tomasz Chmielewski <mangoo@wpkg.org>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040000090005090007010403
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Mark Lord wrote:
> Tejun,
> 
> This Oops (2.6.23.13) looks very much like the same bug
> you fixed recently for me in 2.6.24.
> 
> The bug was with sata_qstor and other drivers, in that
> devres/libata were freeing the I/O resources before invoking
> the LLD's host/port_stop routines .. which still need the I/O.
> 
> Did that patch get backported to 2.6.23 yet ?

No, it's not but yeah it probably should have.  Tomasz, can you please
test whether the attached patch fixes the problem?

-- 
tejun

--------------040000090005090007010403
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch"

SW5kZXg6IHRyZWUwL2RyaXZlcnMvYXRhL2xpYmF0YS1jb3JlLmMKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQot
LS0gdHJlZTAub3JpZy9kcml2ZXJzL2F0YS9saWJhdGEtY29yZS5jCisrKyB0cmVlMC9kcml2
ZXJzL2F0YS9saWJhdGEtY29yZS5jCkBAIC02MTIxLDE5ICs2MTIxLDYgQEAgc3RhdGljIHZv
aWQgYXRhX2hvc3RfcmVsZWFzZShzdHJ1Y3QgZGV2aQogCQlpZiAoIWFwKQogCQkJY29udGlu
dWU7CiAKLQkJaWYgKChob3N0LT5mbGFncyAmIEFUQV9IT1NUX1NUQVJURUQpICYmIGFwLT5v
cHMtPnBvcnRfc3RvcCkKLQkJCWFwLT5vcHMtPnBvcnRfc3RvcChhcCk7Ci0JfQotCi0JaWYg
KChob3N0LT5mbGFncyAmIEFUQV9IT1NUX1NUQVJURUQpICYmIGhvc3QtPm9wcy0+aG9zdF9z
dG9wKQotCQlob3N0LT5vcHMtPmhvc3Rfc3RvcChob3N0KTsKLQotCWZvciAoaSA9IDA7IGkg
PCBob3N0LT5uX3BvcnRzOyBpKyspIHsKLQkJc3RydWN0IGF0YV9wb3J0ICphcCA9IGhvc3Qt
PnBvcnRzW2ldOwotCi0JCWlmICghYXApCi0JCQljb250aW51ZTsKLQogCQlpZiAoYXAtPnNj
c2lfaG9zdCkKIAkJCXNjc2lfaG9zdF9wdXQoYXAtPnNjc2lfaG9zdCk7CiAKQEAgLTYyNTgs
NiArNjI0NSwyNCBAQCBzdHJ1Y3QgYXRhX2hvc3QgKmF0YV9ob3N0X2FsbG9jX3BpbmZvKHN0
CiAJcmV0dXJuIGhvc3Q7CiB9CiAKK3N0YXRpYyB2b2lkIGF0YV9ob3N0X3N0b3Aoc3RydWN0
IGRldmljZSAqZ2VuZGV2LCB2b2lkICpyZXMpCit7CisJc3RydWN0IGF0YV9ob3N0ICpob3N0
ID0gZGV2X2dldF9kcnZkYXRhKGdlbmRldik7CisJaW50IGk7CisKKwlXQVJOX09OKCEoaG9z
dC0+ZmxhZ3MgJiBBVEFfSE9TVF9TVEFSVEVEKSk7CisKKwlmb3IgKGkgPSAwOyBpIDwgaG9z
dC0+bl9wb3J0czsgaSsrKSB7CisJCXN0cnVjdCBhdGFfcG9ydCAqYXAgPSBob3N0LT5wb3J0
c1tpXTsKKworCQlpZiAoYXAtPm9wcy0+cG9ydF9zdG9wKQorCQkJYXAtPm9wcy0+cG9ydF9z
dG9wKGFwKTsKKwl9CisKKwlpZiAoaG9zdC0+b3BzLT5ob3N0X3N0b3ApCisJCWhvc3QtPm9w
cy0+aG9zdF9zdG9wKGhvc3QpOworfQorCiAvKioKICAqCWF0YV9ob3N0X3N0YXJ0IC0gc3Rh
cnQgYW5kIGZyZWV6ZSBwb3J0cyBvZiBhbiBBVEEgaG9zdAogICoJQGhvc3Q6IEFUQSBob3N0
IHRvIHN0YXJ0IHBvcnRzIGZvcgpAQCAtNjI3Niw2ICs2MjgxLDggQEAgc3RydWN0IGF0YV9o
b3N0ICphdGFfaG9zdF9hbGxvY19waW5mbyhzdAogICovCiBpbnQgYXRhX2hvc3Rfc3RhcnQo
c3RydWN0IGF0YV9ob3N0ICpob3N0KQogeworCWludCBoYXZlX3N0b3AgPSAwOworCXZvaWQg
KnN0YXJ0X2RyID0gTlVMTDsKIAlpbnQgaSwgcmM7CiAKIAlpZiAoaG9zdC0+ZmxhZ3MgJiBB
VEFfSE9TVF9TVEFSVEVEKQpAQCAtNjI4Nyw2ICs2Mjk0LDIyIEBAIGludCBhdGFfaG9zdF9z
dGFydChzdHJ1Y3QgYXRhX2hvc3QgKmhvc3QKIAkJaWYgKCFob3N0LT5vcHMgJiYgIWF0YV9w
b3J0X2lzX2R1bW15KGFwKSkKIAkJCWhvc3QtPm9wcyA9IGFwLT5vcHM7CiAKKwkJaWYgKGFw
LT5vcHMtPnBvcnRfc3RvcCkKKwkJCWhhdmVfc3RvcCA9IDE7CisJfQorCisJaWYgKGhvc3Qt
Pm9wcy0+aG9zdF9zdG9wKQorCQloYXZlX3N0b3AgPSAxOworCisJaWYgKGhhdmVfc3RvcCkg
eworCQlzdGFydF9kciA9IGRldnJlc19hbGxvYyhhdGFfaG9zdF9zdG9wLCAwLCBHRlBfS0VS
TkVMKTsKKwkJaWYgKCFzdGFydF9kcikKKwkJCXJldHVybiAtRU5PTUVNOworCX0KKworCWZv
ciAoaSA9IDA7IGkgPCBob3N0LT5uX3BvcnRzOyBpKyspIHsKKwkJc3RydWN0IGF0YV9wb3J0
ICphcCA9IGhvc3QtPnBvcnRzW2ldOworCiAJCWlmIChhcC0+b3BzLT5wb3J0X3N0YXJ0KSB7
CiAJCQlyYyA9IGFwLT5vcHMtPnBvcnRfc3RhcnQoYXApOwogCQkJaWYgKHJjKSB7CkBAIC02
Mjk5LDYgKzYzMjIsOCBAQCBpbnQgYXRhX2hvc3Rfc3RhcnQoc3RydWN0IGF0YV9ob3N0ICpo
b3N0CiAJCWF0YV9laF9mcmVlemVfcG9ydChhcCk7CiAJfQogCisJaWYgKHN0YXJ0X2RyKQor
CQlkZXZyZXNfYWRkKGhvc3QtPmRldiwgc3RhcnRfZHIpOwogCWhvc3QtPmZsYWdzIHw9IEFU
QV9IT1NUX1NUQVJURUQ7CiAJcmV0dXJuIDA7CiAKQEAgLTYzMDksNiArNjMzNCw3IEBAIGlu
dCBhdGFfaG9zdF9zdGFydChzdHJ1Y3QgYXRhX2hvc3QgKmhvc3QKIAkJaWYgKGFwLT5vcHMt
PnBvcnRfc3RvcCkKIAkJCWFwLT5vcHMtPnBvcnRfc3RvcChhcCk7CiAJfQorCWRldnJlc19m
cmVlKHN0YXJ0X2RyKTsKIAlyZXR1cm4gcmM7CiB9CiAK
--------------040000090005090007010403--
