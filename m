From: Dave <dave.jiang@gmail.com>
Subject: [PATCH] updates to Vitesse SATA driver
Date: Tue, 21 Sep 2004 14:16:46 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <8746466a04092114163b3c0618@mail.gmail.com>
Reply-To: Dave <dave.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_64_23713316.1095801406075"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.204]:61280 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268001AbUIUVQr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Sep 2004 17:16:47 -0400
Received: by mproxy.gmail.com with SMTP id 73so1389972rnk
        for <linux-ide@vger.kernel.org>; Tue, 21 Sep 2004 14:16:46 -0700 (PDT)
List-Id: linux-ide@vger.kernel.org
To: jeremy.higdon@sgi.com
Cc: linux-ide@vger.kernel.org

------=_Part_64_23713316.1095801406075
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Dave Jiang (dave.jiang@gmail.com)
Patch attached, diffed against 2.6.8.1.

I was trying to get the Vitesse SATA driver running on XScale platform
and encountered the problem during identify device where when
vsc_intr_mask_update() was called the irq mask register never seem to
change. It seems that on certain XScale platforms doing a writeb() to
a 32bit register (instead of writel()) doesn't seem to do anything.  I
updated the code to do writel() instead so that other platforms
besides IA32 would work.

After getting that working I noticed that the last_ctl value gets
changed back by the LIBATA core and the Vitesse SATA driver depends on
the previous value in order to unmask the interrupt. So it seems that
there's no need to set/unset the interrupt masks in the first place if
we set the CTL register with ATA_NIEN directly, which I believe is
probably the way LIBATA intended the driver to do. After doing that
everything seems to be working great. So I suppose
vsc_intr_mask_update() is no longer needed probably.

I also added some code to enable the per port LEDs on the HBA during
initialization. Perviously all activities goes to port 0 LED.

-- 
-= Dave =-

Software Engineer - Advanced Development Engineering Team 
Storage Component Division - Intel Corp. 
----
The views expressed in this email are
mine alone and do not necessarily 
reflect the views of my employer
(Intel Corp.).

------=_Part_64_23713316.1095801406075
Content-Type: application/octet-stream; name="patch-sata"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-sata"

LS0tIGxpbnV4LTIuNi44LjEtaW9wMy9kcml2ZXJzL3Njc2kvc2F0YV92c2MuYwkyMDA0LTA4LTE0
IDAzOjU1OjMzLjAwMDAwMDAwMCAtMDcwMAorKysgZGpfYmt0cmVlLTIuNi44LjEvZHJpdmVycy9z
Y3NpL3NhdGFfdnNjLmMJMjAwNC0wOS0xNyAxNTo0MzoxMi42ODgyMTI5MjggLTA3MDAKQEAgLTgw
LDYgKzgwLDcgQEAKIAogc3RhdGljIHZvaWQgdnNjX2ludHJfbWFza191cGRhdGUoc3RydWN0IGF0
YV9wb3J0ICphcCwgdTggY3RsKQogeworI2lmIDAKIAl1bnNpZ25lZCBsb25nIG1hc2tfYWRkcjsK
IAl1OCBtYXNrOwogCkBAIC05MSw2ICs5MiwyNiBAQAogCWVsc2UKIAkJbWFzayAmPSAweDdGOwog
CXdyaXRlYihtYXNrLCBtYXNrX2FkZHIpOworI2VuZGlmIAorICAgIHUzMiBtYXNrID0gMDsKKyAg
ICB1MzIgcmVndmFsOyAKKworICAgIHJlZ3ZhbCA9IHJlYWRsKGFwLT5ob3N0X3NldC0+bW1pb19i
YXNlICsgVlNDX1NBVEFfSU5UX01BU0tfT0ZGU0VUKTsKKyAgICAKKworICAgIG1hc2sgPSAoMHg4
MCA8PCAoOCAqIGFwLT5wb3J0X25vKSk7CisgICAgCisgICAgaWYoY3RsICYgQVRBX05JRU4pCisg
ICAgeworICAgICAgICBtYXNrID0gfm1hc2s7CisgICAgICAgIG1hc2sgPSByZWd2YWwgJiBtYXNr
OworICAgIH0KKyAgICBlbHNlCisgICAgeworICAgICAgICBtYXNrID0gcmVndmFsIHwgbWFzazsK
KyAgICB9CisKKyAgICB3cml0ZWwobWFzaywgYXAtPmhvc3Rfc2V0LT5tbWlvX2Jhc2UgKyBWU0Nf
U0FUQV9JTlRfTUFTS19PRkZTRVQpOwogfQogCiAKQEAgLTEwNSw4ICsxMjYsMTAgQEAKIAkgKiBI
b3dldmVyLCBpZiBBVEFfTklFTiBpcyBjaGFuZ2VkLCB0aGVuIHdlIG5lZWQgdG8gY2hhbmdlIHRo
ZSBpbnRlcnJ1cHQgcmVnaXN0ZXIuCiAJICovCiAJaWYgKCh0Zi0+Y3RsICYgQVRBX05JRU4pICE9
IChhcC0+bGFzdF9jdGwgJiBBVEFfTklFTikpIHsKKyAgICAgICAgd3JpdGViKHRmLT5jdGwsIGlv
YWRkci0+Y3RsX2FkZHIpOwogCQlhcC0+bGFzdF9jdGwgPSB0Zi0+Y3RsOwotCQl2c2NfaW50cl9t
YXNrX3VwZGF0ZShhcCwgdGYtPmN0bCAmIEFUQV9OSUVOKTsKKyAgICAgICAgYXRhX3dhaXRfaWRs
ZShhcCk7CisvLyAgICAgIHZzY19pbnRyX21hc2tfdXBkYXRlKGFwLCB0Zi0+Y3RsICYgQVRBX05J
RU4pOwogCX0KIAlpZiAoaXNfYWRkciAmJiAodGYtPmZsYWdzICYgQVRBX1RGTEFHX0xCQTQ4KSkg
ewogCQl3cml0ZXcodGYtPmZlYXR1cmUgfCAoKCh1MTYpdGYtPmhvYl9mZWF0dXJlKSA8PCA4KSwg
aW9hZGRyLT5mZWF0dXJlX2FkZHIpOwpAQCAtMzMwLDYgKzM1MywxOSBAQAogCiAJcGNpX3NldF9t
YXN0ZXIocGRldik7CiAKKyAgICAvKiBzZXQgcGVyIHBvcnQgTEVEcyAqLworICAgIHsKKyAgICAg
ICAgdW5zaWduZWQgbG9uZyBtYXNrOyAKKyAgICAgICAgdW5zaWduZWQgaW50IHJlZ3ZhbDsKKwor
ICAgICAgICBzZXRfYml0KDI4LCAmbWFzayk7CisgICAgICAgIG1hc2sgPSB+bWFzazsKKyAgICAg
ICAgCisgICAgICAgIHBjaV9yZWFkX2NvbmZpZ19kd29yZChwZGV2LCAweDk4LCAmcmVndmFsKTsK
KyAgICAgICAgcmVndmFsID0gcmVndmFsICYgbWFzazsKKyAgICAgICAgcGNpX3dyaXRlX2NvbmZp
Z19kd29yZChwZGV2LCAweDk4LCByZWd2YWwpOworICAgIH0KKwogCS8qIEZJWE1FOiBjaGVjayBh
dGFfZGV2aWNlX2FkZCByZXR1cm4gdmFsdWUgKi8KIAlhdGFfZGV2aWNlX2FkZChwcm9iZV9lbnQp
OwogCWtmcmVlKHByb2JlX2VudCk7Cg==
------=_Part_64_23713316.1095801406075--
