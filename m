From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata Sil3512 bug?;  Promise SATA300 TX4
Date: Sat, 20 Oct 2007 08:58:15 +0900
Message-ID: <47194497.3040101@gmail.com>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl> <47160601.80506@lxnt.info> <1785297944.20071017170444@zonnet.nl> <4717CB10.3080509@lxnt.info> <471807DF.8010100@gmail.com> <47191C3A.5040909@lxnt.info>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040209020305030107000305"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:36354 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760932AbXJSX6V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 19:58:21 -0400
Received: by rv-out-0910.google.com with SMTP id k20so598903rvb
        for <linux-ide@vger.kernel.org>; Fri, 19 Oct 2007 16:58:21 -0700 (PDT)
In-Reply-To: <47191C3A.5040909@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Sabourenkov <screwdriver@lxnt.info>
Cc: linux-ide@vger.kernel.org, MisterE <MisterE2002@zonnet.nl>, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, jgarzik@pobox.com, jeff@garzik.org

This is a multi-part message in MIME format.
--------------040209020305030107000305
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Alexander Sabourenkov wrote:
> Hello.
> 
>> So, my bet for your second report is your hardware went through
>> something similar as above.
>>
> 
> Thanks for the insight. Let's dismiss it then.
> 
> Back to the TX4, I tried libata-dev.git cloned at about 20:00 UTC 19.10,
>   no perceived difference - parallel read from two drives causes a lot
> of  errors.
> 
> dmesgs  with boot and errors are at http://lxnt.info/linux/libata-dev/
> 
> I don't know what to try next. Any ideas?
> 

Does the attached patch help?

-- 
tejun

--------------040209020305030107000305
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="limit-PHY-to-1.5Gbps.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="limit-PHY-to-1.5Gbps.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmF0YS1jb3JlLmMgYi9kcml2ZXJzL2F0YS9s
aWJhdGEtY29yZS5jCmluZGV4IDY4Njk5YjMuLjRjOTNmZWUgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvYXRhL2xpYmF0YS1jb3JlLmMKKysrIGIvZHJpdmVycy9hdGEvbGliYXRhLWNvcmUuYwpA
QCAtNjQzNSw2ICs2NDM1LDcgQEAgaW50IHNhdGFfbGlua19pbml0X3NwZChzdHJ1Y3QgYXRh
X2xpbmsgKmxpbmspCiAJc3BkID0gKHNjb250cm9sID4+IDQpICYgMHhmOwogCWlmIChzcGQp
CiAJCWxpbmstPmh3X3NhdGFfc3BkX2xpbWl0ICY9ICgxIDw8IHNwZCkgLSAxOworCWxpbmst
Pmh3X3NhdGFfc3BkX2xpbWl0ID0gMTsKIAogCWxpbmstPnNhdGFfc3BkX2xpbWl0ID0gbGlu
ay0+aHdfc2F0YV9zcGRfbGltaXQ7CiAK
--------------040209020305030107000305--
