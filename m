From: Go Taniguchi <go@turbolinux.co.jp>
Subject: piix dma setup code
Date: Tue, 18 May 2004 20:19:44 +0900
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A9F150.4070209@turbolinux.co.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010003080306050208050705"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.turbolinux.co.jp ([210.171.55.67]:49933 "EHLO
	mail.turbolinux.co.jp") by vger.kernel.org with ESMTP
	id S263059AbUERLUk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 May 2004 07:20:40 -0400
Received: from turbolinux.co.jp (tlgw1.turbolinux.co.jp [210.171.55.80])
	by mail.turbolinux.co.jp (8.9.3p2+3.2W/mail_no1) with ESMTP id UAA04539
	for <linux-ide@vger.kernel.org>; Tue, 18 May 2004 20:20:38 +0900
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010003080306050208050705
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I think that there are some problems in piix dma setup code.

At function piix_set_udmamode in ata_piix.c.These is same code in piix.c.


//        if (!(reg48 & u_flag))
//                pci_write_config_word(dev, 0x48, reg48|u_flag);

ICH PCI register offset 48 "Synchronous DMA Control Register" register size is
8bit. pci_write_config_byte is better.


//        if (speed == XFER_UDMA_5) {

If speed is XFER_UDMA_6, base clock is set to low base clock.
It should be "speed >= XFER_UDMA_5". My ICH6 system reported XFER_UDMA_6,


//                pci_write_config_byte(dev, 0x55, (u8) reg55|w_flag);
//        } else {
//                pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
//        }
//        if (!(reg4a & u_speed)) {

If u_speed is 0, It is always the TRUE.
And I think that this 2bit comparison is wrong.
Probably It is "(reg4a & a_speed) != u_speed"

//                pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
This set-up is done overwrite of with next line.
//                pci_write_config_word(dev, 0x4a, reg4a|u_speed);
We should do and/or with original data.
So, these are pci_write_config_word(dev, 0x4a, (reg4a & ~a_speed) | u_speed);

//        }
//        if (speed > XFER_UDMA_2) {
//                if (!(reg54 & v_flag)) {
                        pci_write_config_word(dev, 0x54, reg54|v_flag);
If word accesses to reg54, reg55 is overwritten by old original data.
reg55 set already fails. It should be byte access.


//                }
//        } else {
//                pci_write_config_word(dev, 0x54, reg54 & ~v_flag);
//        }

I attched patch file.
Two registers changed it in 8bit access and removed reg44 which was not used.

Sorry for my very poor English.

--------------010003080306050208050705
Content-Type: text/plain;
 name="piix-dma-setmode.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="piix-dma-setmode.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNi42Lm9yaWcvZHJpdmVycy9pZGUvcGNpL3BpaXguYyBsaW51
eC0yLjYuNi9kcml2ZXJzL2lkZS9wY2kvcGlpeC5jCi0tLSBsaW51eC0yLjYuNi5vcmlnL2Ry
aXZlcnMvaWRlL3BjaS9waWl4LmMJMjAwNC0wNS0xNyAxOTowOTozMy4xMzIyMzg4NjQgKzA5
MDAKKysrIGxpbnV4LTIuNi42L2RyaXZlcnMvaWRlL3BjaS9waWl4LmMJMjAwNC0wNS0xNyAx
OTowODo1Ny43Nzg2MTM0MzIgKzA5MDAKQEAgLTQzNiwxNSArNDM2LDE0IEBACiAJaW50IHdf
ZmxhZwkJPSAweDEwIDw8IGRyaXZlLT5kbjsKIAlpbnQgdV9zcGVlZAkJPSAwOwogCWludAkJ
CXNpdHJlOwotCXUxNgkJCXJlZzQwNDIsIHJlZzQ0LCByZWc0OCwgcmVnNGEsIHJlZzU0Owot
CXU4CQkJcmVnNTU7CisJdTE2CQkJcmVnNDA0MiwgcmVnNGE7CisJdTgJCQlyZWc0OCwgcmVn
NTQsIHJlZzU1OwogCiAJcGNpX3JlYWRfY29uZmlnX3dvcmQoZGV2LCBtYXNsYXZlLCAmcmVn
NDA0Mik7CiAJc2l0cmUgPSAocmVnNDA0MiAmIDB4NDAwMCkgPyAxIDogMDsKLQlwY2lfcmVh
ZF9jb25maWdfd29yZChkZXYsIDB4NDQsICZyZWc0NCk7Ci0JcGNpX3JlYWRfY29uZmlnX3dv
cmQoZGV2LCAweDQ4LCAmcmVnNDgpOworCXBjaV9yZWFkX2NvbmZpZ19ieXRlKGRldiwgMHg0
OCwgJnJlZzQ4KTsKIAlwY2lfcmVhZF9jb25maWdfd29yZChkZXYsIDB4NGEsICZyZWc0YSk7
Ci0JcGNpX3JlYWRfY29uZmlnX3dvcmQoZGV2LCAweDU0LCAmcmVnNTQpOworCXBjaV9yZWFk
X2NvbmZpZ19ieXRlKGRldiwgMHg1NCwgJnJlZzU0KTsKIAlwY2lfcmVhZF9jb25maWdfYnl0
ZShkZXYsIDB4NTUsICZyZWc1NSk7CiAKIAlzd2l0Y2goc3BlZWQpIHsKQEAgLTQ2NiwzMCAr
NDY1LDI5IEBACiAKIAlpZiAoc3BlZWQgPj0gWEZFUl9VRE1BXzApIHsKIAkJaWYgKCEocmVn
NDggJiB1X2ZsYWcpKQotCQkJcGNpX3dyaXRlX2NvbmZpZ193b3JkKGRldiwgMHg0OCwgcmVn
NDh8dV9mbGFnKTsKKwkJCXBjaV93cml0ZV9jb25maWdfYnl0ZShkZXYsIDB4NDgsIHJlZzQ4
fHVfZmxhZyk7CiAJCWlmIChzcGVlZCA9PSBYRkVSX1VETUFfNSkgewogCQkJcGNpX3dyaXRl
X2NvbmZpZ19ieXRlKGRldiwgMHg1NSwgKHU4KSByZWc1NXx3X2ZsYWcpOwogCQl9IGVsc2Ug
ewogCQkJcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGRldiwgMHg1NSwgKHU4KSByZWc1NSAmIH53
X2ZsYWcpOwogCQl9Ci0JCWlmICghKHJlZzRhICYgdV9zcGVlZCkpIHsKLQkJCXBjaV93cml0
ZV9jb25maWdfd29yZChkZXYsIDB4NGEsIHJlZzRhICYgfmFfc3BlZWQpOwotCQkJcGNpX3dy
aXRlX2NvbmZpZ193b3JkKGRldiwgMHg0YSwgcmVnNGF8dV9zcGVlZCk7CisJCWlmICgocmVn
NGEgJiBhX3NwZWVkKSAhPSB1X3NwZWVkKSB7CisJCQlwY2lfd3JpdGVfY29uZmlnX3dvcmQo
ZGV2LCAweDRhLCAocmVnNGEgJiB+YV9zcGVlZCkgfCB1X3NwZWVkKTsKIAkJfQogCQlpZiAo
c3BlZWQgPiBYRkVSX1VETUFfMikgewogCQkJaWYgKCEocmVnNTQgJiB2X2ZsYWcpKSB7Ci0J
CQkJcGNpX3dyaXRlX2NvbmZpZ193b3JkKGRldiwgMHg1NCwgcmVnNTR8dl9mbGFnKTsKKwkJ
CQlwY2lfd3JpdGVfY29uZmlnX2J5dGUoZGV2LCAweDU0LCByZWc1NHx2X2ZsYWcpOwogCQkJ
fQogCQl9IGVsc2UgewotCQkJcGNpX3dyaXRlX2NvbmZpZ193b3JkKGRldiwgMHg1NCwgcmVn
NTQgJiB+dl9mbGFnKTsKKwkJCXBjaV93cml0ZV9jb25maWdfYnl0ZShkZXYsIDB4NTQsIHJl
ZzU0ICYgfnZfZmxhZyk7CiAJCX0KIAl9IGVsc2UgewogCQlpZiAocmVnNDggJiB1X2ZsYWcp
Ci0JCQlwY2lfd3JpdGVfY29uZmlnX3dvcmQoZGV2LCAweDQ4LCByZWc0OCAmIH51X2ZsYWcp
OworCQkJcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGRldiwgMHg0OCwgcmVnNDggJiB+dV9mbGFn
KTsKIAkJaWYgKHJlZzRhICYgYV9zcGVlZCkKIAkJCXBjaV93cml0ZV9jb25maWdfd29yZChk
ZXYsIDB4NGEsIHJlZzRhICYgfmFfc3BlZWQpOwogCQlpZiAocmVnNTQgJiB2X2ZsYWcpCi0J
CQlwY2lfd3JpdGVfY29uZmlnX3dvcmQoZGV2LCAweDU0LCByZWc1NCAmIH52X2ZsYWcpOwor
CQkJcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGRldiwgMHg1NCwgcmVnNTQgJiB+dl9mbGFnKTsK
IAkJaWYgKHJlZzU1ICYgd19mbGFnKQogCQkJcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGRldiwg
MHg1NSwgKHU4KSByZWc1NSAmIH53X2ZsYWcpOwogCX0KZGlmZiAtdXJOIGxpbnV4LTIuNi42
Lm9yaWcvZHJpdmVycy9zY3NpL2F0YV9waWl4LmMgbGludXgtMi42LjYvZHJpdmVycy9zY3Np
L2F0YV9waWl4LmMKLS0tIGxpbnV4LTIuNi42Lm9yaWcvZHJpdmVycy9zY3NpL2F0YV9waWl4
LmMJMjAwNC0wNS0xNyAxOTowOTozMy4xNDcyMzY1ODQgKzA5MDAKKysrIGxpbnV4LTIuNi42
L2RyaXZlcnMvc2NzaS9hdGFfcGlpeC5jCTIwMDQtMDUtMTcgMTk6MDg6MTMuODYxMjg5ODgw
ICswOTAwCkBAIC00MjQsMTYgKzQyNCwxNSBAQAogCWludCB3X2ZsYWcJCT0gMHgxMCA8PCBk
cml2ZV9kbjsKIAlpbnQgdV9zcGVlZAkJPSAwOwogCWludAkJCXNpdHJlOwotCXUxNgkJCXJl
ZzQwNDIsIHJlZzQ0LCByZWc0OCwgcmVnNGEsIHJlZzU0OwotCXU4CQkJcmVnNTU7CisJdTE2
CQkJcmVnNDA0MiwgcmVnNGE7CisJdTgJCQlyZWc0OCwgcmVnNTQsIHJlZzU1OwogCiAJcGNp
X3JlYWRfY29uZmlnX3dvcmQoZGV2LCBtYXNsYXZlLCAmcmVnNDA0Mik7CiAJRFBSSU5USygi
cmVnNDA0MiA9IDB4JTA0eFxuIiwgcmVnNDA0Mik7CiAJc2l0cmUgPSAocmVnNDA0MiAmIDB4
NDAwMCkgPyAxIDogMDsKLQlwY2lfcmVhZF9jb25maWdfd29yZChkZXYsIDB4NDQsICZyZWc0
NCk7Ci0JcGNpX3JlYWRfY29uZmlnX3dvcmQoZGV2LCAweDQ4LCAmcmVnNDgpOworCXBjaV9y
ZWFkX2NvbmZpZ19ieXRlKGRldiwgMHg0OCwgJnJlZzQ4KTsKIAlwY2lfcmVhZF9jb25maWdf
d29yZChkZXYsIDB4NGEsICZyZWc0YSk7Ci0JcGNpX3JlYWRfY29uZmlnX3dvcmQoZGV2LCAw
eDU0LCAmcmVnNTQpOworCXBjaV9yZWFkX2NvbmZpZ19ieXRlKGRldiwgMHg1NCwgJnJlZzU0
KTsKIAlwY2lfcmVhZF9jb25maWdfYnl0ZShkZXYsIDB4NTUsICZyZWc1NSk7CiAKIAlzd2l0
Y2goc3BlZWQpIHsKQEAgLTQ1MCwyMiArNDQ5LDIxIEBACiAJfQogCiAJaWYgKCEocmVnNDgg
JiB1X2ZsYWcpKQotCQlwY2lfd3JpdGVfY29uZmlnX3dvcmQoZGV2LCAweDQ4LCByZWc0OHx1
X2ZsYWcpOwotCWlmIChzcGVlZCA9PSBYRkVSX1VETUFfNSkgeworCQlwY2lfd3JpdGVfY29u
ZmlnX2J5dGUoZGV2LCAweDQ4LCByZWc0OHx1X2ZsYWcpOworCWlmIChzcGVlZCA+PSBYRkVS
X1VETUFfNSkgewogCQlwY2lfd3JpdGVfY29uZmlnX2J5dGUoZGV2LCAweDU1LCAodTgpIHJl
ZzU1fHdfZmxhZyk7CiAJfSBlbHNlIHsKIAkJcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGRldiwg
MHg1NSwgKHU4KSByZWc1NSAmIH53X2ZsYWcpOwogCX0KLQlpZiAoIShyZWc0YSAmIHVfc3Bl
ZWQpKSB7Ci0JCXBjaV93cml0ZV9jb25maWdfd29yZChkZXYsIDB4NGEsIHJlZzRhICYgfmFf
c3BlZWQpOwotCQlwY2lfd3JpdGVfY29uZmlnX3dvcmQoZGV2LCAweDRhLCByZWc0YXx1X3Nw
ZWVkKTsKKwlpZiAoKHJlZzRhICYgYV9zcGVlZCkgIT0gdV9zcGVlZCkgeworCQlwY2lfd3Jp
dGVfY29uZmlnX3dvcmQoZGV2LCAweDRhLCAocmVnNGEgJiB+YV9zcGVlZCkgfCB1X3NwZWVk
KTsKIAl9CiAJaWYgKHNwZWVkID4gWEZFUl9VRE1BXzIpIHsKIAkJaWYgKCEocmVnNTQgJiB2
X2ZsYWcpKSB7Ci0JCQlwY2lfd3JpdGVfY29uZmlnX3dvcmQoZGV2LCAweDU0LCByZWc1NHx2
X2ZsYWcpOworCQkJcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGRldiwgMHg1NCwgcmVnNTR8dl9m
bGFnKTsKIAkJfQogCX0gZWxzZSB7Ci0JCXBjaV93cml0ZV9jb25maWdfd29yZChkZXYsIDB4
NTQsIHJlZzU0ICYgfnZfZmxhZyk7CisJCXBjaV93cml0ZV9jb25maWdfYnl0ZShkZXYsIDB4
NTQsIHJlZzU0ICYgfnZfZmxhZyk7CiAJfQogfQogCg==
--------------010003080306050208050705--

