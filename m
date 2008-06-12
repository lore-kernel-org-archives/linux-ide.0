From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.25: sata_sil freezes, hard resets port.
Date: Thu, 12 Jun 2008 10:46:14 +0900
Message-ID: <48507FE6.5010009@gmail.com>
References: <4846F3EA.2050408@bredband.net> <484DF2A2.103@gmail.com> <48501C89.2040402@bredband.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060709070506040909080907"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:45871 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbYFLBqW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2008 21:46:22 -0400
Received: by ti-out-0910.google.com with SMTP id b6so893908tic.23
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 18:46:20 -0700 (PDT)
In-Reply-To: <48501C89.2040402@bredband.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Henry <adhenry@bredband.net>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060709070506040909080907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Andrew Henry wrote:
> Tejun Heo wrote:
>>   Can you please
>> post the outputs of dmesg after the wake up failure (fdisk -l) and
>> "hdparm --Istdout /dev/sdX"?
>>   
> Yepp.  Here is the hdparm result (identical for both drives), followed
> by the full dmesg output from boot until one of the drives starts
> failing and then all the messages that come for a while after failure.
> By the way, these are not the latest 'green' drives by Western Digital
> that you hinted at.  They are one generation below the green drives, but
> maybe they do have an updated standby feature.

I see.  Those green drives do strange things with advanced power
management feature and end up drastically reduce the lifetime.  I
wouldn't be too surprised to see its predecessor doing weird things.

> [root@k2 Desktop]# hdparm --Istdout /dev/sdb
> 0040 3fff c837 0010 0000 0000 003f 0000
> 0000 0000 2020 2020 2057 442d 5743 4153
> 5530 3230 3638 3733 0000 0000 0000 3031
> 2e30 3142 3031 5744 204d 7920 426f 6f6b
> 2020 2020 2020 2020 2020 2020 2020 2020
> 2020 2020 2020 2020 2020 2020 2020 8001
> 0000 0b00 4001 0000 0000 0007 3fff 0010
> 003f fc10 00fb 0100 ffff 0fff 0000 0007
> 0003 0078 0078 0078 0078 0000 0000 0000
> 0000 0000 0000 0000 0106 0000 0000 0000
> 0070 001c 0029 7400 4002 0029 3400 4002
> 207f 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 6030 3a38 0000 0000
> 0000 0000 4000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 ab12 8004 c000 0001 0002 0001 0001
> 0000 0002 0000 0000 0000 0000 0001 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0001 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000

Hmmm.. it's not setting any serial ata features including DIPM.  The
drive shouldn't put the link into powersave mode.

> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata2.00: status: { DRDY }
> ata2: port is slow to respond, please be patient (Status 0xd8)
> ata2: device not ready (errno=-16), forcing hardreset
> ata2: hard resetting link
> ata2: port is slow to respond, please be patient (Status 0xff)
> ata2: COMRESET failed (errno=-16)
> ata2: hard resetting link
> ata2: port is slow to respond, please be patient (Status 0xff)
> ata2: COMRESET failed (errno=-16)
> ata2: hard resetting link
> ata2: port is slow to respond, please be patient (Status 0xff)
> ata2: COMRESET failed (errno=-16)
> ata2: hard resetting link
> ata2: COMRESET failed (errno=-16)
> ata2: reset failed, giving up
> ata2.00: disabled

Hmmm... it never sends the first D2H FIS.  Can you please test the
attached patch and report the kernel log after failure?

Thanks.

-- 
tejun

--------------060709070506040909080907
Content-Type: text/plain;
 name="wd.debug"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="wd.debug"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmF0YS1jb3JlLmMgYi9kcml2ZXJzL2F0YS9s
aWJhdGEtY29yZS5jCmluZGV4IDkyN2I2OTIuLjk3NDkzYjggMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvYXRhL2xpYmF0YS1jb3JlLmMKKysrIGIvZHJpdmVycy9hdGEvbGliYXRhLWNvcmUuYwpA
QCAtMzQ3Nyw3ICszNDc3LDcgQEAgaW50IHNhdGFfbGlua19yZXN1bWUoc3RydWN0IGF0YV9s
aW5rICpsaW5rLCBjb25zdCB1bnNpZ25lZCBsb25nICpwYXJhbXMsCiAJaWYgKChyYyA9IHNh
dGFfc2NyX3JlYWQobGluaywgU0NSX0NPTlRST0wsICZzY29udHJvbCkpKQogCQlyZXR1cm4g
cmM7CiAKLQlzY29udHJvbCA9IChzY29udHJvbCAmIDB4MGYwKSB8IDB4MzAwOworCXNjb250
cm9sID0gKHNjb250cm9sICYgMHgwZjApLyogfCAweDMwMCovOwogCiAJaWYgKChyYyA9IHNh
dGFfc2NyX3dyaXRlKGxpbmssIFNDUl9DT05UUk9MLCBzY29udHJvbCkpKQogCQlyZXR1cm4g
cmM7CkBAIC0zNTMyLDYgKzM1MzIsMTAgQEAgaW50IGF0YV9zdGRfcHJlcmVzZXQoc3RydWN0
IGF0YV9saW5rICpsaW5rLCB1bnNpZ25lZCBsb25nIGRlYWRsaW5lKQogCWNvbnN0IHVuc2ln
bmVkIGxvbmcgKnRpbWluZyA9IHNhdGFfZWhjX2RlYl90aW1pbmcoZWhjKTsKIAlpbnQgcmM7
CiAKKwkvKiBwcmludCBsaW5rIHN0YXR1cyAqLworCXByaW50aygiUFJFUkVTRVQ6ICIpOwor
CXNhdGFfcHJpbnRfbGlua19zdGF0dXMobGluayk7CisKIAkvKiBpZiB3ZSdyZSBhYm91dCB0
byBkbyBoYXJkcmVzZXQsIG5vdGhpbmcgbW9yZSB0byBkbyAqLwogCWlmIChlaGMtPmkuYWN0
aW9uICYgQVRBX0VIX0hBUkRSRVNFVCkKIAkJcmV0dXJuIDA7Cg==
--------------060709070506040909080907--
