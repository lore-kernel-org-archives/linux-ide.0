From: Tejun Heo <htejun@gmail.com>
Subject: Re: [3/6] 2.6.21-rc2: known regressions
Date: Tue, 13 Mar 2007 21:41:38 +0900
Message-ID: <45F69C02.2020206@gmail.com>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org> <20070305015036.GH3441@stusta.de> <45EE9E39.3010800@garzik.org> <45F20541.9090208@crans.org> <45F53B60.8020908@gmail.com> <45F69989.70702@crans.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080708000805060406020507"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:39436 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbXCMMlq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 08:41:46 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1518730nze
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 05:41:45 -0700 (PDT)
In-Reply-To: <45F69989.70702@crans.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TWF0aGlldSBCw6lyYXJk?= <Mathieu.Berard@crans.org>
Cc: Jeff Garzik <jeff@garzik.org>, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Michal Jaegermann <michal@ellpspace.math.ualberta.ca>, Fabio Comolli <fabio.comolli@gmail.com>, Janosch Machowinski <jmachowinski@gmx.de>, Lukas Hejtmanek <xhejtman@fi.muni.cz>, Meelis Roos <mroos@linux.ee>, Olivier Mondoloni <darkcore71@yahoo.fr>, Thomas Renninger <trenn@suse.de>, Robert Moore <robert.moore@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080708000805060406020507
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Can you apply the attached patch and report what the kernel says with
ACPI turned on?

-- 
tejun

--------------080708000805060406020507
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmF0YS1hY3BpLmMgYi9kcml2ZXJzL2F0YS9s
aWJhdGEtYWNwaS5jCmluZGV4IDAxOWQ4ZmYuLjZhMjdhN2YgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvYXRhL2xpYmF0YS1hY3BpLmMKKysrIGIvZHJpdmVycy9hdGEvbGliYXRhLWFjcGkuYwpA
QCAtNDczLDggKzQ3Myw4IEBAIHN0YXRpYyB2b2lkIHRhc2tmaWxlX2xvYWRfcmF3KHN0cnVj
dCBhdGFfcG9ydCAqYXAsCiAJc3RydWN0IGF0YV90YXNrZmlsZSB0ZjsKIAl1bnNpZ25lZCBp
bnQgZXJyOwogCi0JaWYgKGF0YV9tc2dfcHJvYmUoYXApKQotCQlhdGFfZGV2X3ByaW50ayhh
dGFkZXYsIEtFUk5fREVCVUcsICIlczogKDB4MWYxLTFmNyk6IGhleDogIgorCWlmICgxIHx8
IGF0YV9tc2dfcHJvYmUoYXApKQorCQlhdGFfZGV2X3ByaW50ayhhdGFkZXYsIEtFUk5fSU5G
TywgIiVzOiAoMHgxZjEtMWY3KTogaGV4OiAiCiAJCQkiJTAyeCAlMDJ4ICUwMnggJTAyeCAl
MDJ4ICUwMnggJTAyeFxuIiwKIAkJCV9fRlVOQ1RJT05fXywKIAkJCWd0Zi0+dGZhWzBdLCBn
dGYtPnRmYVsxXSwgZ3RmLT50ZmFbMl0sCg==
--------------080708000805060406020507--
