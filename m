From: Tejun Heo <tj@kernel.org>
Subject: Re: Intel AHCI ICH9R not detecting devices
Date: Mon, 01 Sep 2008 11:13:44 +0200
Message-ID: <48BBB248.7090904@kernel.org>
References: <WorldClient-F200808221729.AA29360172@butn.net> <48B92399.6010808@kernel.org> <WorldClient-F200808302142.AA42270030@butn.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060409070507000509080201"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51930 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbYIAJPN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Sep 2008 05:15:13 -0400
In-Reply-To: <WorldClient-F200808302142.AA42270030@butn.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: xerces8 <xerces8@butn.net>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, stein@hermes.si

This is a multi-part message in MIME format.
--------------060409070507000509080201
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

xerces8 wrote:
>> This looks like resource conflict to me, which could have resulted
>> from ahci trying to grab all resources.  Can you please post the
>> result of "cat /proc/ioports" and "cat /proc/iomem"?
> 
> I noticed that in IDE mode the same happens (32bit kernel has problems,
> 64bit kernel has not), so here is dmesg, iomem and ioports for all 4
> combinations.

Can you please try the attached debug patch and report boot log.  All
resources look fine.

Thanks.

-- 
tejun

--------------060409070507000509080201
Content-Type: text/plain;
 name="debug"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="debug"

LS0tCiBkcml2ZXJzL2F0YS9haGNpLmMgfCAgIDIxICsrKysrKysrKysrKysrKystLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpJbmRl
eDogdHJlZTAvZHJpdmVycy9hdGEvYWhjaS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHRyZWUwLm9y
aWcvZHJpdmVycy9hdGEvYWhjaS5jCisrKyB0cmVlMC9kcml2ZXJzL2F0YS9haGNpLmMKQEAg
LTIyNDAsOCArMjI0MCwxMCBAQCBzdGF0aWMgaW50IGFoY2lfaW5pdF9vbmUoc3RydWN0IHBj
aV9kZXYKIAogCS8qIGFjcXVpcmUgcmVzb3VyY2VzICovCiAJcmMgPSBwY2ltX2VuYWJsZV9k
ZXZpY2UocGRldik7Ci0JaWYgKHJjKQorCWlmIChyYykgeworCQlkZXZfcHJpbnRrKEtFUk5f
V0FSTklORywgJnBkZXYtPmRldiwgInBjaW1fZW5hYmxlX2RldmljZSBmYWlsZWQgJWRcbiIs
IHJjKTsKIAkJcmV0dXJuIHJjOworCX0KIAogCS8qIEFIQ0kgY29udHJvbGxlcnMgb2Z0ZW4g
aW1wbGVtZW50IFNGRiBjb21wYXRpYmxlIGludGVyZmFjZS4KIAkgKiBHcmFiIGFsbCBQQ0kg
QkFScyBqdXN0IGluIGNhc2UuCkBAIC0yMjQ5LDggKzIyNTEsMTAgQEAgc3RhdGljIGludCBh
aGNpX2luaXRfb25lKHN0cnVjdCBwY2lfZGV2CiAJcmMgPSBwY2ltX2lvbWFwX3JlZ2lvbnNf
cmVxdWVzdF9hbGwocGRldiwgMSA8PCBBSENJX1BDSV9CQVIsIERSVl9OQU1FKTsKIAlpZiAo
cmMgPT0gLUVCVVNZKQogCQlwY2ltX3Bpbl9kZXZpY2UocGRldik7Ci0JaWYgKHJjKQorCWlm
IChyYykgeworCQlkZXZfcHJpbnRrKEtFUk5fV0FSTklORywgJnBkZXYtPmRldiwgInBjaW1f
aW9tYXBfcmVnaW9uc19yZXF1ZXN0X2FsbCgpIGZhaWxlZCAlZFxuIiwgcmMpOwogCQlyZXR1
cm4gcmM7CisJfQogCiAJaWYgKHBkZXYtPnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0lOVEVM
ICYmCiAJICAgIChwZGV2LT5kZXZpY2UgPT0gMHgyNjUyIHx8IHBkZXYtPmRldmljZSA9PSAw
eDI2NTMpKSB7CkBAIC0yMzI0LDE5ICsyMzI4LDI2IEBAIHN0YXRpYyBpbnQgYWhjaV9pbml0
X29uZShzdHJ1Y3QgcGNpX2RldgogCiAJLyogaW5pdGlhbGl6ZSBhZGFwdGVyICovCiAJcmMg
PSBhaGNpX2NvbmZpZ3VyZV9kbWFfbWFza3MocGRldiwgaHByaXYtPmNhcCAmIEhPU1RfQ0FQ
XzY0KTsKLQlpZiAocmMpCisJaWYgKHJjKSB7CisJCWRldl9wcmludGsoS0VSTl9XQVJOSU5H
LCAmcGRldi0+ZGV2LCAiYWhjaV9jb25maWd1cmVfZG1hX21hc2tzKCkgZmFpbGVkICVkXG4i
LCByYyk7CiAJCXJldHVybiByYzsKKwl9CiAKIAlyYyA9IGFoY2lfcmVzZXRfY29udHJvbGxl
cihob3N0KTsKLQlpZiAocmMpCisJaWYgKHJjKSB7CisJCWRldl9wcmludGsoS0VSTl9XQVJO
SU5HLCAmcGRldi0+ZGV2LCAiYWhjaV9yZXNldF9jb250cm9sbGVyKCkgZmFpbGVkICVkXG4i
LCByYyk7CiAJCXJldHVybiByYzsKKwl9CiAKIAlhaGNpX2luaXRfY29udHJvbGxlcihob3N0
KTsKIAlhaGNpX3ByaW50X2luZm8oaG9zdCk7CiAKIAlwY2lfc2V0X21hc3RlcihwZGV2KTsK
LQlyZXR1cm4gYXRhX2hvc3RfYWN0aXZhdGUoaG9zdCwgcGRldi0+aXJxLCBhaGNpX2ludGVy
cnVwdCwgSVJRRl9TSEFSRUQsCisJcmMgPSBhdGFfaG9zdF9hY3RpdmF0ZShob3N0LCBwZGV2
LT5pcnEsIGFoY2lfaW50ZXJydXB0LCBJUlFGX1NIQVJFRCwKIAkJCQkgJmFoY2lfc2h0KTsK
KwlpZiAocmMpCisJCWRldl9wcmludGsoS0VSTl9XQVJOSU5HLCAmcGRldi0+ZGV2LCAiYWhj
aV9ob3N0X2FjdGl2YXRlKCkgZmFpbGVkICVkXG4iLCByYyk7CisJcmV0dXJuIHJjOwogfQog
CiBzdGF0aWMgaW50IF9faW5pdCBhaGNpX2luaXQodm9pZCkK
--------------060409070507000509080201--
