From: "Shane Huang" <Shane.Huang@amd.com>
Subject: About forcing 32bit DMA patch for AMD690G(SB600)
Date: Wed, 23 Jan 2008 15:44:16 +0800
Message-ID: <B90463BC30D2E446BA423D888DC85E501BF3CB@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----_=_NextPart_001_01C85D93.C1F4B7AB"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:17993 "EHLO
	outbound10-sin-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755646AbYAWHpS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jan 2008 02:45:18 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sriharivijayaraghavan@yahoo.com.au, Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Shane Huang <Shane.Huang@amd.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C85D93.C1F4B7AB
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Resending this mail and adding linux-ide mail list...


Quoting Tejun:
> Uh-oh, wait a bit. Nope. Until we figure out what the something else
is
> and positively verify 64bit DMA works fine, the quirk stays in.

Our HW engineer has confirmed that our SB600 SATA controller indeed has
some MSI issue, and we do not have any workaround.

The workaround "quirk_msi_intx_disable_bug" to SB700 SATA controller
can NOT work to SB600 SATA controller in my debug, while disablement to
RS690 MSI in kernel source can fix it.

As to the SB600 64 bit DMA capacity, do you have any methods to do
further
verification? I do NOT find any problem in my debug after I disabled
RS690
MSI in kernel 2.6.24-rc7.



Thanks

Best Regards
Shane


-----Original Message-----
From: Shane Huang=20
Sent: Wednesday, January 23, 2008 2:56 PM
To: sriharivijayaraghavan@yahoo.com.au
Cc: 'Tejun Heo'; Shane Huang
Subject: About forcing 32bit DMA patch for AMD690G(SB600)
Importance: High

Hi Srihari:

This Shane @ AMD. I'm sorry to disturb you.

I find that there is one patch which forces SB600 use 32bit DMA:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmi
t;h=3Dc7a42156d99bcea7f8173ba7a6034bbaa2ecb77c

This patch was submitted by Tejun to fix one issue on your platform:
http://marc.info/?l=3Dlinux-ide&m=3D117810966106759&w=3D2

But after a discussion with our hardware engineers, Tejun(the patch
author),
and some debugging, we believe that that SB600 can support 64 bit DMA,
the root cause should be something else, while disablement to RS690 MSI
in kernel source can be the workaround.
So, we are going withdraw Tejun's patch ASAP.

I wonder whether you still have that AMD690G platform or not?
Are you able to help to do further confirmation before we withdraw it?

You can just download kernel 2.6.21.1(which was used when you reported
the bug), apply the attached disable_RS690_MSI.patch, and build the
kernel.
Please tell me if that patch can fix your issue without Tejun's patch.
This patch has been proved to work on my RS690+SB600 under Fedora7
x86_64.

You can also try my another disable_MSI_and_withdraw_32bit.patch
under linux kernel 2.6.24-rc7, to see whether this patch can fix your
issue too. This method also can work on my RS690+SB600 platform.


Thanks & waiting for your test result~~~ :-)


Best Regards
Shane


------_=_NextPart_001_01C85D93.C1F4B7AB
Content-Type: application/octet-stream;
 name=disable_RS690_MSI.patch
Content-Transfer-Encoding: base64
Content-Description: disable_RS690_MSI.patch
Content-Disposition: attachment;
 filename=disable_RS690_MSI.patch

ZGlmZiAtcnVOIGxpbnV4LTIuNi4yMS4xX29yZy9kcml2ZXJzL3BjaS9xdWlya3MuYyBsaW51eC0y
LjYuMjEuMV9uZXcvZHJpdmVycy9wY2kvcXVpcmtzLmMKLS0tIGxpbnV4LTIuNi4yMS4xX29yZy9k
cml2ZXJzL3BjaS9xdWlya3MuYwkyMDA4LTAxLTIzIDE0OjIyOjI1LjAwMDAwMDAwMCArMDgwMAor
KysgbGludXgtMi42LjIxLjFfbmV3L2RyaXZlcnMvcGNpL3F1aXJrcy5jCTIwMDgtMDEtMjMgMTQ6
MjI6NDQuMDAwMDAwMDAwICswODAwCkBAIC0xNzQzLDEyICsxNzQzLDEzIEBACiAgKiBJbnN0ZWFk
IG9mIHNldHRpbmcgdGhlIGZsYWcgb24gYWxsIGJ1c3NlcyBpbiB0aGUgbWFjaGluZSwgc2ltcGx5
IGRpc2FibGUgTVNJCiAgKiBnbG9iYWxseS4KICAqLwotc3RhdGljIHZvaWQgX19pbml0IHF1aXJr
X3N2d19tc2koc3RydWN0IHBjaV9kZXYgKmRldikKK3N0YXRpYyB2b2lkIF9faW5pdCBxdWlya19k
aXNhYmxlX2FsbF9tc2koc3RydWN0IHBjaV9kZXYgKmRldikKIHsKIAlwY2lfbm9fbXNpKCk7CiAJ
cHJpbnRrKEtFUk5fV0FSTklORyAiUENJOiBNU0kgcXVpcmsgZGV0ZWN0ZWQuIE1TSSBkZWFjdGl2
YXRlZC5cbiIpOwogfQotREVDTEFSRV9QQ0lfRklYVVBfRklOQUwoUENJX1ZFTkRPUl9JRF9TRVJW
RVJXT1JLUywgUENJX0RFVklDRV9JRF9TRVJWRVJXT1JLU19HQ05CX0xFLCBxdWlya19zdndfbXNp
KTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfU0VSVkVSV09SS1MsIFBD
SV9ERVZJQ0VfSURfU0VSVkVSV09SS1NfR0NOQl9MRSwgcXVpcmtfZGlzYWJsZV9hbGxfbXNpKTsK
K0RFQ0xBUkVfUENJX0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfQVRJLCAweDc5MTAsIHF1aXJr
X2Rpc2FibGVfYWxsX21zaSk7Ly9SUzY5MAogCiAvKiBEaXNhYmxlIE1TSSBvbiBjaGlwc2V0cyB0
aGF0IGFyZSBrbm93biB0byBub3Qgc3VwcG9ydCBpdCAqLwogc3RhdGljIHZvaWQgX19kZXZpbml0
IHF1aXJrX2Rpc2FibGVfbXNpKHN0cnVjdCBwY2lfZGV2ICpkZXYpCg==

------_=_NextPart_001_01C85D93.C1F4B7AB
Content-Type: application/octet-stream;
 name=disable_MSI_and_withdraw_32bit.patch
Content-Transfer-Encoding: base64
Content-Description: disable_MSI_and_withdraw_32bit.patch
Content-Disposition: attachment;
 filename=disable_MSI_and_withdraw_32bit.patch

ZGlmZiAtcnVOIGxpbnV4LTIuNi4yNC1yYzdfb3JnL2RyaXZlcnMvYXRhL2FoY2kuYyBsaW51eC0y
LjYuMjQtcmM3X25ldy9kcml2ZXJzL2F0YS9haGNpLmMKLS0tIGxpbnV4LTIuNi4yNC1yYzdfb3Jn
L2RyaXZlcnMvYXRhL2FoY2kuYwkyMDA4LTAxLTIzIDE0OjQzOjU3LjAwMDAwMDAwMCArMDgwMAor
KysgbGludXgtMi42LjI0LXJjN19uZXcvZHJpdmVycy9hdGEvYWhjaS5jCTIwMDgtMDEtMjMgMTQ6
NDQ6MDguMDAwMDAwMDAwICswODAwCkBAIC00MjQsNyArNDI0LDcgQEAKIAkvKiBib2FyZF9haGNp
X3NiNjAwICovCiAJewogCQlBSENJX0hGTEFHUwkoQUhDSV9IRkxBR19JR05fU0VSUl9JTlRFUk5B
TCB8Ci0JCQkJIEFIQ0lfSEZMQUdfMzJCSVRfT05MWSB8IEFIQ0lfSEZMQUdfTk9fUE1QKSwKKwkJ
CQkgQUhDSV9IRkxBR19OT19QTVApLAogCQkuZmxhZ3MJCT0gQUhDSV9GTEFHX0NPTU1PTiwKIAkJ
LmxpbmtfZmxhZ3MJPSBBSENJX0xGTEFHX0NPTU1PTiwKIAkJLnBpb19tYXNrCT0gMHgxZiwgLyog
cGlvMC00ICovCmRpZmYgLXJ1TiBsaW51eC0yLjYuMjQtcmM3X29yZy9kcml2ZXJzL3BjaS9xdWly
a3MuYyBsaW51eC0yLjYuMjQtcmM3X25ldy9kcml2ZXJzL3BjaS9xdWlya3MuYwotLS0gbGludXgt
Mi42LjI0LXJjN19vcmcvZHJpdmVycy9wY2kvcXVpcmtzLmMJMjAwOC0wMS0yMyAxNDo0NDo1My4w
MDAwMDAwMDAgKzA4MDAKKysrIGxpbnV4LTIuNi4yNC1yYzdfbmV3L2RyaXZlcnMvcGNpL3F1aXJr
cy5jCTIwMDgtMDEtMjMgMTQ6NDU6MDAuMDAwMDAwMDAwICswODAwCkBAIC0xNjIzLDYgKzE2MjMs
NyBAQAogREVDTEFSRV9QQ0lfRklYVVBfRklOQUwoUENJX1ZFTkRPUl9JRF9TRVJWRVJXT1JLUywg
UENJX0RFVklDRV9JRF9TRVJWRVJXT1JLU19HQ05CX0xFLCBxdWlya19kaXNhYmxlX2FsbF9tc2kp
OwogREVDTEFSRV9QQ0lfRklYVVBfRklOQUwoUENJX1ZFTkRPUl9JRF9BVEksIFBDSV9ERVZJQ0Vf
SURfQVRJX1JTNDAwXzIwMCwgcXVpcmtfZGlzYWJsZV9hbGxfbXNpKTsKIERFQ0xBUkVfUENJX0ZJ
WFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfQVRJLCBQQ0lfREVWSUNFX0lEX0FUSV9SUzQ4MCwgcXVp
cmtfZGlzYWJsZV9hbGxfbXNpKTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1Jf
SURfQVRJLCAweDc5MTAsIHF1aXJrX2Rpc2FibGVfYWxsX21zaSk7Ly9SUzY5MAogREVDTEFSRV9Q
Q0lfRklYVVBfRklOQUwoUENJX1ZFTkRPUl9JRF9WSUEsIFBDSV9ERVZJQ0VfSURfVklBX1ZUMzM1
MSwgcXVpcmtfZGlzYWJsZV9hbGxfbXNpKTsKIAogLyogRGlzYWJsZSBNU0kgb24gY2hpcHNldHMg
dGhhdCBhcmUga25vd24gdG8gbm90IHN1cHBvcnQgaXQgKi8K

------_=_NextPart_001_01C85D93.C1F4B7AB--


