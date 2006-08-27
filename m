From: Tejun Heo <htejun@gmail.com>
Subject: Re: Libata-tj-stable patch /w sil3124 and PMP... 'device or resource
 busy'
Date: Sun, 27 Aug 2006 18:35:12 +0900
Message-ID: <44F16750.5080100@gmail.com>
References: <44E105A7.3030900@grokthis.net> <44E1C43E.1020302@gmail.com> <44E28313.7050601@grokthis.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090200080109080705060105"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:64715 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751083AbWH0JfT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Aug 2006 05:35:19 -0400
Received: by py-out-1112.google.com with SMTP id n25so2035663pyg
        for <linux-ide@vger.kernel.org>; Sun, 27 Aug 2006 02:35:18 -0700 (PDT)
In-Reply-To: <44E28313.7050601@grokthis.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eric Windisch <eric@grokthis.net>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090200080109080705060105
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Eric Windisch wrote:
>> Can you post the result of 'dmesg'
> 
> Attached as dmesg.log
> 
>> 'cat /proc/mounts' and 
> 
> Attached as proc.mounts.txt
> 
> 
>> 'fuser -v /dev/sdX#'?
> 
> root@san001:~# fuser -v /dev/sda1
> root@san001:~# fuser -v /dev/sdb1
> root@san001:~# fuser -v /dev/sdc1
> root@san001:~# fuser -v /dev/sdd1
> root@san001:~# fuser -v /dev/sde1
> root@san001:~# fuser -v /dev/sde
> root@san001:~# fuser -v /dev/sdd
> root@san001:~# fuser -v /dev/sdc
> root@san001:~# fuser -v /dev/sdb
> root@san001:~# fuser -v /dev/sda
> root@san001:~# fuser -v /dev/sd*
> root@san001:~#
> 
> And for good measure...
> 
> root@san001:~# lsof /dev/sd*
> root@san001:~#

Can you apply the attached patch and report what the kernel says?

Thanks.

-- 
tejun

--------------090200080109080705060105
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch"

ZGlmZiAtLWdpdCBhL2ZzL2Jsb2NrX2Rldi5jIGIvZnMvYmxvY2tfZGV2LmMKaW5kZXggZjU5
NThmNC4uYzRmYWUxNyAxMDA2NDQKLS0tIGEvZnMvYmxvY2tfZGV2LmMKKysrIGIvZnMvYmxv
Y2tfZGV2LmMKQEAgLTQ1MiwxNiArNDUyLDIzIEBAIGludCBiZF9jbGFpbShzdHJ1Y3QgYmxv
Y2tfZGV2aWNlICpiZGV2LCAKIAkvKiBmaXJzdCBkZWNpZGUgcmVzdWx0ICovCiAJaWYgKGJk
ZXYtPmJkX2hvbGRlciA9PSBob2xkZXIpCiAJCXJlcyA9IDA7CSAvKiBhbHJlYWR5IGEgaG9s
ZGVyICovCi0JZWxzZSBpZiAoYmRldi0+YmRfaG9sZGVyICE9IE5VTEwpCisJZWxzZSBpZiAo
YmRldi0+YmRfaG9sZGVyICE9IE5VTEwpIHsKKwkJcHJpbnRrKCJYWFggYmRfY2xhaW0gJWQ6
JWQgZmFpbGVkICVkQCVwXG4iLAorCQkgICAgICAgTUFKT1IoYmRldi0+YmRfZGV2KSwgTUlO
T1IoYmRldi0+YmRfZGV2KSwKKwkJICAgICAgIGJkZXYtPmJkX2hvbGRlcnMsIGJkZXYtPmJk
X2hvbGRlcik7CiAJCXJlcyA9IC1FQlVTWTsgCSAvKiBoZWxkIGJ5IHNvbWVvbmUgZWxzZSAq
LworCX0KIAllbHNlIGlmIChiZGV2LT5iZF9jb250YWlucyA9PSBiZGV2KQogCQlyZXMgPSAw
OyAgCSAvKiBpcyBhIHdob2xlIGRldmljZSB3aGljaCBpc24ndCBoZWxkICovCiAKIAllbHNl
IGlmIChiZGV2LT5iZF9jb250YWlucy0+YmRfaG9sZGVyID09IGJkX2NsYWltKQogCQlyZXMg
PSAwOyAJIC8qIGlzIGEgcGFydGl0aW9uIG9mIGEgZGV2aWNlIHRoYXQgaXMgYmVpbmcgcGFy
dGl0aW9uZWQgKi8KLQllbHNlIGlmIChiZGV2LT5iZF9jb250YWlucy0+YmRfaG9sZGVyICE9
IE5VTEwpCisJZWxzZSBpZiAoYmRldi0+YmRfY29udGFpbnMtPmJkX2hvbGRlciAhPSBOVUxM
KSB7CisJCXByaW50aygiWFhYIGJkX2NsYWltICVkOiVkIGZhaWxlZCAlZEAlcCAocGFydCBv
ZiBhIGhlbGQgZGV2KVxuIiwKKwkJICAgICAgIE1BSk9SKGJkZXYtPmJkX2RldiksIE1JTk9S
KGJkZXYtPmJkX2RldiksCisJCSAgICAgICBiZGV2LT5iZF9ob2xkZXJzLCBiZGV2LT5iZF9o
b2xkZXIpOwogCQlyZXMgPSAtRUJVU1k7CSAvKiBpcyBhIHBhcnRpdGlvbiBvZiBhIGhlbGQg
ZGV2aWNlICovCi0JZWxzZQorCX0gZWxzZQogCQlyZXMgPSAwOwkgLyogaXMgYSBwYXJ0aXRp
b24gb2YgYW4gdW4taGVsZCBkZXZpY2UgKi8KIAogCS8qIG5vdyBpbXBvc2UgY2hhbmdlICov
CkBAIC00NzQsNiArNDgxLDE0IEBAIGludCBiZF9jbGFpbShzdHJ1Y3QgYmxvY2tfZGV2aWNl
ICpiZGV2LCAKIAkJYmRldi0+YmRfY29udGFpbnMtPmJkX2hvbGRlciA9IGJkX2NsYWltOwog
CQliZGV2LT5iZF9ob2xkZXJzKys7CiAJCWJkZXYtPmJkX2hvbGRlciA9IGhvbGRlcjsKKwkJ
cHJpbnRrKCJYWFggYmRfY2xhaW0gJWQ6JWQvJWQ6JWQgJWRAJXAgJWRAJXBcbiIsCisJCSAg
ICAgICBNQUpPUihiZGV2LT5iZF9kZXYpLCBNSU5PUihiZGV2LT5iZF9kZXYpLAorCQkgICAg
ICAgTUFKT1IoYmRldi0+YmRfY29udGFpbnMtPmJkX2RldiksCisJCSAgICAgICBNSU5PUihi
ZGV2LT5iZF9jb250YWlucy0+YmRfZGV2KSwKKwkJICAgICAgIGJkZXYtPmJkX2hvbGRlcnMs
IGJkZXYtPmJkX2hvbGRlciwKKwkJICAgICAgIGJkZXYtPmJkX2NvbnRhaW5zLT5iZF9ob2xk
ZXJzLAorCQkgICAgICAgYmRldi0+YmRfY29udGFpbnMtPmJkX2hvbGRlcik7CisJCWR1bXBf
c3RhY2soKTsKIAl9CiAJc3Bpbl91bmxvY2soJmJkZXZfbG9jayk7CiAJcmV0dXJuIHJlczsK
QEAgLTQ4NCw2ICs0OTksMTIgQEAgRVhQT1JUX1NZTUJPTChiZF9jbGFpbSk7CiB2b2lkIGJk
X3JlbGVhc2Uoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldikKIHsKIAlzcGluX2xvY2soJmJk
ZXZfbG9jayk7CisJcHJpbnRrKCJYWFggYmRfcmVsZWFzZSAlZDolZC8lZDolZCAlZEAlcCAl
ZEAlcFxuIiwKKwkgICAgICAgTUFKT1IoYmRldi0+YmRfZGV2KSwgTUlOT1IoYmRldi0+YmRf
ZGV2KSwKKwkgICAgICAgTUFKT1IoYmRldi0+YmRfY29udGFpbnMtPmJkX2RldiksCisJICAg
ICAgIE1JTk9SKGJkZXYtPmJkX2NvbnRhaW5zLT5iZF9kZXYpLAorCSAgICAgICBiZGV2LT5i
ZF9ob2xkZXJzLCBiZGV2LT5iZF9ob2xkZXIsCisJICAgICAgIGJkZXYtPmJkX2NvbnRhaW5z
LT5iZF9ob2xkZXJzLCBiZGV2LT5iZF9jb250YWlucy0+YmRfaG9sZGVyKTsKIAlpZiAoIS0t
YmRldi0+YmRfY29udGFpbnMtPmJkX2hvbGRlcnMpCiAJCWJkZXYtPmJkX2NvbnRhaW5zLT5i
ZF9ob2xkZXIgPSBOVUxMOwogCWlmICghLS1iZGV2LT5iZF9ob2xkZXJzKQo=
--------------090200080109080705060105--
