From: "Wolstenholme, Daniel E" <daniel.e.wolstenholme@intel.com>
Subject: RE: [PATCH] Add MSI support to sata_vsc driver
Date: Thu, 24 Aug 2006 17:58:35 -0700
Message-ID: <87840E8EE8A8D240A13F8AA92CAB07D9024C14C4@azsmsx402>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6C7E1.97DA1F37"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62891 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422796AbWHYA7a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Aug 2006 20:59:30 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jeremy Higdon <jeremy@sgi.com>, linux-ide@vger.kernel.org, "Bruns, Curt E" <curt.e.bruns@intel.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6C7E1.97DA1F37
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ok,
Here's my latest attempt.  I've added a new vsc_sata_host_priv data
structure (basically copied from the sata_mv driver) which has an
hp_flags bitfield with a bit to indicate whether MSI is being used.
This is used in the new vsc_sata_host_stop() routine to call
pci_disable_msi() if MSI is on, pci_intx() if not.

I'm still wondering if the pci_intx() stuff is needed; some SATA drivers
use it, some don't.  The intx disable bit was not set before when I had
MSI running, but it didn't seem to cause any problems, but it's still
probably good practice to set it when using MSI.  But is it needed when
in INTX mode?  Some drivers use it in the init_one() function, some
don't.

I've compiled this driver as a module and loaded and unloaded it to
verify that it indeed reuses the MSI interrupt instead of just
allocating a new one each time as it did with pci_disable_msi() missing.
However, one remaining problem (which I don't think has anything to do
with interrupts) is that when reloading the driver, it allocates all-new
port numbers:

ata5: SATA max UDMA/133 cmd 0x510A0200 ctl 0x510A0229 bmdma 0x510A0270
irq 131
ata6: SATA max UDMA/133 cmd 0x510A0400 ctl 0x510A0429 bmdma 0x510A0470
irq 131
ata7: SATA max UDMA/133 cmd 0x510A0600 ctl 0x510A0629 bmdma 0x510A0670
irq 131
ata8: SATA max UDMA/133 cmd 0x510A0800 ctl 0x510A0829 bmdma 0x510A0870
irq 131
scsi4 : sata_vsc
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: ATA-6, max UDMA/133, 72303840 sectors: LBA48
ata5.00: ata5: dev 0 multi count 0
ata5.00: applying bridge limits
ata5.00: configured for UDMA/100
scsi5 : sata_vsc
ata6: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x510A041C
scsi6 : sata_vsc
ata7: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x510A061C
scsi7 : sata_vsc
ata8: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x510A081C
  Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 35.0
  Type:   Direct-Access                      ANSI SCSI revision: 05

These were 1-4 when I first loaded the driver.  I've never seen this
before, as I've never used this driver as a module before.

Anyway, here's the new patch.

Thanks again for all the help!
Dan


-----Original Message-----
From: Jeff Garzik [mailto:jeff@garzik.org]=20
Sent: Wednesday, August 23, 2006 11:56 PM
To: Wolstenholme, Daniel E
Cc: Jeremy Higdon; linux-ide@vger.kernel.org
Subject: Re: [PATCH] Add MSI support to sata_vsc driver

two issues remain:

1) matching pci_disable_msi() is missing

2) as I mentioned previously, do not explicitly initialize irq_flags to=20
zero, they are already zero via memset(3).  Only initialize irq_flags=20
for the case where pci_enable_msi() fails.

------_=_NextPart_001_01C6C7E1.97DA1F37
Content-Type: application/octet-stream;
	name="diff.sata_vsc.2"
Content-Transfer-Encoding: base64
Content-Description: diff.sata_vsc.2
Content-Disposition: attachment;
	filename="diff.sata_vsc.2"

ZGlmZiAtTmF1ciAteCAuZ2l0IGxpbnV4LTIuNi4xOC1yYzIvZHJpdmVycy9zY3NpL3NhdGFfdnNj
LmMgbGludXgtMi42LjE4LXJjMi1NU0kvZHJpdmVycy9zY3NpL3NhdGFfdnNjLmMKLS0tIGxpbnV4
LTIuNi4xOC1yYzIvZHJpdmVycy9zY3NpL3NhdGFfdnNjLmMJMjAwNi0wOC0xNSAxNzoxMzo1My4w
MDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNi4xOC1yYzItTVNJL2RyaXZlcnMvc2NzaS9zYXRh
X3ZzYy5jCTIwMDYtMDgtMjQgMTc6NTM6NTcuMDAwMDAwMDAwIC0wNzAwCkBAIC05NCw4ICs5NCwx
NCBAQAogCQkJICAgICAgVlNDX1NBVEFfSU5UX0VSUk9SX1AgICAgfCBWU0NfU0FUQV9JTlRfRVJS
T1JfUiB8IFwKIAkJCSAgICAgIFZTQ19TQVRBX0lOVF9FUlJPUl9FICAgIHwgVlNDX1NBVEFfSU5U
X0VSUk9SX00gfCBcCiAJCQkgICAgICBWU0NfU0FUQV9JTlRfUEhZX0NIQU5HRSksCisKKwkvKiBI
b3N0IHByaXZhdGUgZmxhZ3MgKGhwX2ZsYWdzKSAqLworCVZTQ19TQVRBX0hQX0ZMQUdfTVNJCT0g
KDEgPDwgMCksCiB9OwogCitzdHJ1Y3QgdnNjX3NhdGFfaG9zdF9wcml2IHsKKwl1MzIJCQlocF9m
bGFnczsKK307CiAKICNkZWZpbmUgaXNfdnNjX3NhdGFfaW50X2Vycihwb3J0X2lkeCwgaW50X3N0
YXR1cykgXAogCSAoaW50X3N0YXR1cyAmIChWU0NfU0FUQV9JTlRfRVJST1IgPDwgKDggKiBwb3J0
X2lkeCkpKQpAQCAtMTE4LDYgKzEyNCwxOSBAQAogfQogCiAKK3N0YXRpYyB2b2lkIHZzY19zYXRh
X2hvc3Rfc3RvcChzdHJ1Y3QgYXRhX2hvc3Rfc2V0ICpob3N0X3NldCkKK3sKKwlzdHJ1Y3QgdnNj
X3NhdGFfaG9zdF9wcml2ICpocHJpdiA9IGhvc3Rfc2V0LT5wcml2YXRlX2RhdGE7CisJc3RydWN0
IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGhvc3Rfc2V0LT5kZXYpOworCisJaWYgKGhwcml2
LT5ocF9mbGFncyAmIFZTQ19TQVRBX0hQX0ZMQUdfTVNJKQorCQlwY2lfZGlzYWJsZV9tc2kocGRl
dik7CisJZWxzZQorCQlwY2lfaW50eChwZGV2LCAwKTsKKwlrZnJlZSAoaHByaXYpOworCWF0YV9w
Y2lfaG9zdF9zdG9wKGhvc3Rfc2V0KTsKK30KKwogc3RhdGljIHZvaWQgdnNjX2ludHJfbWFza191
cGRhdGUoc3RydWN0IGF0YV9wb3J0ICphcCwgdTggY3RsKQogewogCXZvaWQgX19pb21lbSAqbWFz
a19hZGRyOwpAQCAtMzIwLDcgKzMzOSw3IEBACiAJLnNjcl93cml0ZQkJPSB2c2Nfc2F0YV9zY3Jf
d3JpdGUsCiAJLnBvcnRfc3RhcnQJCT0gYXRhX3BvcnRfc3RhcnQsCiAJLnBvcnRfc3RvcAkJPSBh
dGFfcG9ydF9zdG9wLAotCS5ob3N0X3N0b3AJCT0gYXRhX3BjaV9ob3N0X3N0b3AsCisJLmhvc3Rf
c3RvcAkJPSB2c2Nfc2F0YV9ob3N0X3N0b3AsCiB9OwogCiBzdGF0aWMgdm9pZCBfX2RldmluaXQg
dnNjX3NhdGFfc2V0dXBfcG9ydChzdHJ1Y3QgYXRhX2lvcG9ydHMgKnBvcnQsIHVuc2lnbmVkIGxv
bmcgYmFzZSkKQEAgLTM0OSw2ICszNjgsNyBAQAogewogCXN0YXRpYyBpbnQgcHJpbnRlZF92ZXJz
aW9uOwogCXN0cnVjdCBhdGFfcHJvYmVfZW50ICpwcm9iZV9lbnQgPSBOVUxMOworCXN0cnVjdCB2
c2Nfc2F0YV9ob3N0X3ByaXYgKmhwcml2OwogCXVuc2lnbmVkIGxvbmcgYmFzZTsKIAlpbnQgcGNp
X2Rldl9idXN5ID0gMDsKIAl2b2lkIF9faW9tZW0gKm1taW9fYmFzZTsKQEAgLTM5MCw2ICs0MTAs
NyBAQAogCQlyYyA9IC1FTk9NRU07CiAJCWdvdG8gZXJyX291dF9yZWdpb25zOwogCX0KKwogCW1l
bXNldChwcm9iZV9lbnQsIDAsIHNpemVvZigqcHJvYmVfZW50KSk7CiAJcHJvYmVfZW50LT5kZXYg
PSBwY2lfZGV2X3RvX2RldihwZGV2KTsKIAlJTklUX0xJU1RfSEVBRCgmcHJvYmVfZW50LT5ub2Rl
KTsKQEAgLTQwMSwxOSArNDIyLDMzIEBACiAJfQogCWJhc2UgPSAodW5zaWduZWQgbG9uZykgbW1p
b19iYXNlOwogCisJaHByaXYgPSBrbWFsbG9jKHNpemVvZigqaHByaXYpLCBHRlBfS0VSTkVMKTsK
KwlpZiAoIWhwcml2KSB7CisJCXJjID0gLUVOT01FTTsKKwkJZ290byBlcnJfb3V0X2lvdW5tYXA7
CisJfQorCW1lbXNldChocHJpdiwgMCwgc2l6ZW9mKCpocHJpdikpOworCiAJLyoKIAkgKiBEdWUg
dG8gYSBidWcgaW4gdGhlIGNoaXAsIHRoZSBkZWZhdWx0IGNhY2hlIGxpbmUgc2l6ZSBjYW4ndCBi
ZSB1c2VkCiAJICovCiAJcGNpX3dyaXRlX2NvbmZpZ19ieXRlKHBkZXYsIFBDSV9DQUNIRV9MSU5F
X1NJWkUsIDB4ODApOwogCisJaWYgKHBjaV9lbmFibGVfbXNpKHBkZXYpID09IDApIHsKKwkJaHBy
aXYtPmhwX2ZsYWdzIHw9IFZTQ19TQVRBX0hQX0ZMQUdfTVNJOworCQlwY2lfaW50eChwZGV2LCAw
KTsKKwl9CisJZWxzZQorCQlwcm9iZV9lbnQtPmlycV9mbGFncyA9IElSUUZfU0hBUkVEOworCiAJ
cHJvYmVfZW50LT5zaHQgPSAmdnNjX3NhdGFfc2h0OwogCXByb2JlX2VudC0+aG9zdF9mbGFncyA9
IEFUQV9GTEFHX1NBVEEgfCBBVEFfRkxBR19OT19MRUdBQ1kgfAogCQkJCUFUQV9GTEFHX01NSU87
CiAJcHJvYmVfZW50LT5wb3J0X29wcyA9ICZ2c2Nfc2F0YV9vcHM7CiAJcHJvYmVfZW50LT5uX3Bv
cnRzID0gNDsKIAlwcm9iZV9lbnQtPmlycSA9IHBkZXYtPmlycTsKLQlwcm9iZV9lbnQtPmlycV9m
bGFncyA9IElSUUZfU0hBUkVEOwogCXByb2JlX2VudC0+bW1pb19iYXNlID0gbW1pb19iYXNlOwor
CXByb2JlX2VudC0+cHJpdmF0ZV9kYXRhID0gaHByaXY7CiAKIAkvKiBXZSBkb24ndCBjYXJlIG11
Y2ggYWJvdXQgdGhlIFBJTy9VRE1BIG1hc2tzLCBidXQgdGhlIGNvcmUgd29uJ3QgbGlrZSB1cwog
CSAqIGlmIHdlIGRvbid0IGZpbGwgdGhlc2UKQEAgLTQ0MCwxMCArNDc1LDEyIEBACiAKIAkvKiBG
SVhNRTogY2hlY2sgYXRhX2RldmljZV9hZGQgcmV0dXJuIHZhbHVlICovCiAJYXRhX2RldmljZV9h
ZGQocHJvYmVfZW50KTsKLQlrZnJlZShwcm9iZV9lbnQpOwogCisJa2ZyZWUocHJvYmVfZW50KTsK
IAlyZXR1cm4gMDsKIAorZXJyX291dF9pb3VubWFwOgorCXBjaV9pb3VubWFwKHBkZXYsIG1taW9f
YmFzZSk7CiBlcnJfb3V0X2ZyZWVfZW50OgogCWtmcmVlKHByb2JlX2VudCk7CiBlcnJfb3V0X3Jl
Z2lvbnM6Cg==

------_=_NextPart_001_01C6C7E1.97DA1F37--
