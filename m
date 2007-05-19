From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement ata_wait_after_reset()
Date: Sat, 19 May 2007 21:04:56 +0200
Message-ID: <464F4A58.2050607@gmail.com>
References: <20070510072005.GA27316@linux-sh.org>    <464301D3.5060306@gmail.com> <464307CC.40701@gmail.com>    <20070510124645.GA18534@linux-sh.org> <4643196B.7070806@gmail.com>    <20070511005217.GA23186@li <464B3505.20004@gmail.com> <2229.81.207.0.53.1179592754.squirrel@secure.samage.net> <464F4548.6020101@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030605080502040608030402"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:62439 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757560AbXESTFL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 May 2007 15:05:11 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1705950nza
        for <linux-ide@vger.kernel.org>; Sat, 19 May 2007 12:05:10 -0700 (PDT)
In-Reply-To: <464F4548.6020101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Indan Zupancic <indan@nul.nu>, Paul Mundt <lethal@linux-sh.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, garyhade@us.ibm.com

This is a multi-part message in MIME format.
--------------030605080502040608030402
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Yeah, if SCR registers are accessible, 0xff doesn't indicate the device
> isn't there, so the whole skip-0xff logic probably shouldn't apply in
> such cases, but we can also achieve pretty good result by just making
> the first reset tries a bit more aggressive.

So, here's the patch.

Paul, can you please test this patch without the previous patch?  Indan,
this should reduce the resume delay.  Please test.  But you'll still
feel some added delay compared to 2.6.20 due to the mentioned
suspend/resume change.

Thanks.

-- 
tejun

--------------030605080502040608030402
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmF0YS1jb3JlLmMgYi9kcml2ZXJzL2F0YS9s
aWJhdGEtY29yZS5jCmluZGV4IGQ1OTM5ZTYuLjI3ZGRjMzkgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvYXRhL2xpYmF0YS1jb3JlLmMKKysrIGIvZHJpdmVycy9hdGEvbGliYXRhLWNvcmUuYwpA
QCAtMzAzMSw3ICszMDMxLDcgQEAgaW50IGF0YV93YWl0X3JlYWR5KHN0cnVjdCBhdGFfcG9y
dCAqYXAsCiAKIAkJaWYgKCEoc3RhdHVzICYgQVRBX0JVU1kpKQogCQkJcmV0dXJuIDA7Ci0J
CWlmIChzdGF0dXMgPT0gMHhmZikKKwkJaWYgKCFhdGFfcG9ydF9vbmxpbmUoYXApICYmIHN0
YXR1cyA9PSAweGZmKQogCQkJcmV0dXJuIC1FTk9ERVY7CiAJCWlmICh0aW1lX2FmdGVyKG5v
dywgZGVhZGxpbmUpKQogCQkJcmV0dXJuIC1FQlVTWTsK
--------------030605080502040608030402--
