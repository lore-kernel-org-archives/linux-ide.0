From: Tejun Heo <htejun@gmail.com>
Subject: Re: 40-wire cable detected when directly connected
Date: Sat, 12 Jan 2008 12:26:48 +0900
Message-ID: <47883378.9060507@gmail.com>
References: <200801101824.04863.Tobias_Mueller@twam.info> <4786E82A.7010208@gmail.com> <47875755.4000109@twam.info>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020709090409050304070201"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:63101 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757556AbYALD0z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 22:26:55 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2144522wah.23
        for <linux-ide@vger.kernel.org>; Fri, 11 Jan 2008 19:26:53 -0800 (PST)
In-Reply-To: <47875755.4000109@twam.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?VG9iaWFzIE3DvGxsZXI=?= <Tobias_Mueller@twam.info>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------020709090409050304070201
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[cc'ing Alan, thanks for the information on the other message]

Tobias Müller wrote:
> Tejun Heo schrieb:
>> I don't know very well about CF but does it even fill UDMA/33?  What
>> does 'dd if=/dev/sdc of=/dev/null bs=1M count=16 iflag=direct' say?  You
>> can increase count for more reliable result.
> 
> 16+0 Datensätze ein
> 16+0 Datensätze aus
> 16777216 Bytes (17 MB) kopiert, 0,561688 s, 29,9 MB/s

Hmmm... yeah, it almost fills UDMA/33.  I wonder whether it would go higher.

> And hdparm -I /dev/sdc says it should be compatible to udma5.
> 
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4

Please apply the attached patch and specify libata.force_cbl=80 as
kernel boot parameter.  If you load libata from initrd or after boot you
need to pass 'force_cbl=80' as module parameter.  How you do it depends
on your distro.

Thanks.

-- 
tejun

--------------020709090409050304070201
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmF0YS1jb3JlLmMgYi9kcml2ZXJzL2F0YS9s
aWJhdGEtY29yZS5jCmluZGV4IDQ3NTNhMTguLjhjOTM4NzggMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvYXRhL2xpYmF0YS1jb3JlLmMKKysrIGIvZHJpdmVycy9hdGEvbGliYXRhLWNvcmUuYwpA
QCAtMTE5LDYgKzExOSwxMCBAQCBpbnQgbGliYXRhX25vYWNwaSA9IDA7CiBtb2R1bGVfcGFy
YW1fbmFtZWQobm9hY3BpLCBsaWJhdGFfbm9hY3BpLCBpbnQsIDA0NDQpOwogTU9EVUxFX1BB
Uk1fREVTQyhub2FjcGksICJEaXNhYmxlcyB0aGUgdXNlIG9mIEFDUEkgaW4gcHJvYmUvc3Vz
cGVuZC9yZXN1bWUgd2hlbiBzZXQiKTsKIAoraW50IGxpYmF0YV9mb3JjZV9jYmwgPSAwOwor
bW9kdWxlX3BhcmFtX25hbWVkKGZvcmNlX2NibCwgbGliYXRhX2ZvcmNlX2NibCwgaW50LCAw
NjQ0KTsKK01PRFVMRV9QQVJNX0RFU0MoZm9yY2VfY2JsLCAiZm9yY2UgUEFUQSBjYWJsZSB0
eXBlICgwPWtlZXAsIDQwPTQwYywgODA9ODBjKSIpOworCiBNT0RVTEVfQVVUSE9SKCJKZWZm
IEdhcnppayIpOwogTU9EVUxFX0RFU0NSSVBUSU9OKCJMaWJyYXJ5IG1vZHVsZSBmb3IgQVRB
IGRldmljZXMiKTsKIE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYXRhL2xpYmF0YS1laC5jIGIvZHJpdmVycy9hdGEvbGliYXRhLWVoLmMKaW5kZXggMjFh
ODFjZC4uN2U1MzIxNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9hdGEvbGliYXRhLWVoLmMKKysr
IGIvZHJpdmVycy9hdGEvbGliYXRhLWVoLmMKQEAgLTIyOTYsOSArMjI5NiwyNyBAQCBzdGF0
aWMgaW50IGF0YV9laF9yZXZhbGlkYXRlX2FuZF9hdHRhY2goc3RydWN0IGF0YV9saW5rICps
aW5rLAogCiAJLyogUERJQUctIHNob3VsZCBoYXZlIGJlZW4gcmVsZWFzZWQsIGFzayBjYWJs
ZSB0eXBlIGlmIHBvc3QtcmVzZXQgKi8KIAlpZiAoYXRhX2lzX2hvc3RfbGluayhsaW5rKSAm
JiBhcC0+b3BzLT5jYWJsZV9kZXRlY3QgJiYKLQkgICAgKGVoYy0+aS5mbGFncyAmIEFUQV9F
SElfRElEX1JFU0VUKSkKKwkgICAgKGVoYy0+aS5mbGFncyAmIEFUQV9FSElfRElEX1JFU0VU
KSkgewogCQlhcC0+Y2JsID0gYXAtPm9wcy0+Y2FibGVfZGV0ZWN0KGFwKTsKIAorCQlpZiAo
IShhcC0+ZmxhZ3MgJiBBVEFfRkxBR19TQVRBKSAmJiBsaWJhdGFfZm9yY2VfY2JsKSB7CisJ
CQlzd2l0Y2ggKGxpYmF0YV9mb3JjZV9jYmwpIHsKKwkJCWNhc2UgNDA6CisJCQkJYXRhX3Bv
cnRfcHJpbnRrKGFwLCBLRVJOX0lORk8sICJmb3JjaW5nIDQwY1xuIik7CisJCQkJYXAtPmNi
bCA9IEFUQV9DQkxfUEFUQTQwOworCQkJCWJyZWFrOworCQkJY2FzZSA4MDoKKwkJCQlhdGFf
cG9ydF9wcmludGsoYXAsIEtFUk5fSU5GTywgImZvcmNpbmcgODBjXG4iKTsKKwkJCQlhcC0+
Y2JsID0gQVRBX0NCTF9QQVRBODA7CisJCQkJYnJlYWs7CisJCQlkZWZhdWx0OgorCQkJCWF0
YV9wb3J0X3ByaW50ayhhcCwgS0VSTl9XQVJOSU5HLAorCQkJCQkJImludmFsaWQgZm9yY2Vf
Y2JsIHZhbHVlICVkXG4iLAorCQkJCQkJbGliYXRhX2ZvcmNlX2NibCk7CisJCQl9CisJCX0K
Kwl9CisKIAkvKiBDb25maWd1cmUgbmV3IGRldmljZXMgZm9yd2FyZCBzdWNoIHRoYXQgdXNl
ciBkb2Vzbid0IHNlZQogCSAqIGRldmljZSBkZXRlY3Rpb24gbWVzc2FnZXMgYmFja3dhcmRz
LgogCSAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvbGliYXRhLmggYi9kcml2ZXJzL2F0
YS9saWJhdGEuaAppbmRleCBiYmU1OWMyLi5iOTkwYThkIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2F0YS9saWJhdGEuaAorKysgYi9kcml2ZXJzL2F0YS9saWJhdGEuaApAQCAtNjAsNiArNjAs
NyBAQCBleHRlcm4gaW50IGF0YXBpX2RtYWRpcjsKIGV4dGVybiBpbnQgYXRhcGlfcGFzc3Ro
cnUxNjsKIGV4dGVybiBpbnQgbGliYXRhX2Z1YTsKIGV4dGVybiBpbnQgbGliYXRhX25vYWNw
aTsKK2V4dGVybiBpbnQgbGliYXRhX2ZvcmNlX2NibDsKIGV4dGVybiBzdHJ1Y3QgYXRhX3F1
ZXVlZF9jbWQgKmF0YV9xY19uZXdfaW5pdChzdHJ1Y3QgYXRhX2RldmljZSAqZGV2KTsKIGV4
dGVybiBpbnQgYXRhX2J1aWxkX3J3X3RmKHN0cnVjdCBhdGFfdGFza2ZpbGUgKnRmLCBzdHJ1
Y3QgYXRhX2RldmljZSAqZGV2LAogCQkJICAgdTY0IGJsb2NrLCB1MzIgbl9ibG9jaywgdW5z
aWduZWQgaW50IHRmX2ZsYWdzLAo=
--------------020709090409050304070201--
