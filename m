From: "Carlos Pardo" <Carlos.Pardo@siliconimage.com>
Subject: [PATCH 2.6.11.5 ] sata_sil: Fix FIFO PCI Bus Arbitration
Date: Wed, 23 Mar 2005 09:11:19 -0800
Message-ID: <2E9B8131C44AF746B1E06BF9B15A434B045D7EF5@zima.siliconimage.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C52FCB.54EFE624"
Received: from mail.siimage.com ([12.24.47.101]:14597 "EHLO mail.siimage.com")
	by vger.kernel.org with ESMTP id S261699AbVCWRKU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2005 12:10:20 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C52FCB.54EFE624
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This patch set default values for the FIFO PCI Bus Arbitration to avoid =
data corruption. The root cause is due to our PCI bus master handling =
mismatch with the chipset PCI bridge during DMA xfer (write data to the =
device). The patch is to setup the DMA fifo threshold so that there is =
no chance for the DMA engine to change protocol. We have seen this =
problem only on one motherboard.

Signed-off-by: Silicon Image Corporation <cpardo@siliconimage.com>

------_=_NextPart_001_01C52FCB.54EFE624
Content-Type: application/octet-stream;
	name="patch-a-sata_sil-FIFO-26114"
Content-Transfer-Encoding: base64
Content-Description: patch-a-sata_sil-FIFO-26114
Content-Disposition: attachment;
	filename="patch-a-sata_sil-FIFO-26114"

LS0tIGEvZHJpdmVycy9zY3NpL3NhdGFfc2lsLmMJMjAwNS0wMy0yMiAxNToyODo0MS4wMDAwMDAw
MDAgLTA4MDAKKysrIGIvZHJpdmVycy9zY3NpL3NhdGFfc2lsLmMJMjAwNS0wMy0yMiAxNToyODo0
Mi4wMDAwMDAwMDAgLTA4MDAKQEAgLTM4LDEyICszOCwyMSBAQAogI2luY2x1ZGUgPGxpbnV4L2xp
YmF0YS5oPgogCiAjZGVmaW5lIERSVl9OQU1FCSJzYXRhX3NpbCIKLSNkZWZpbmUgRFJWX1ZFUlNJ
T04JIjAuOCIKKyNkZWZpbmUgRFJWX1ZFUlNJT04JIjAuOSIKIAogZW51bSB7CiAJc2lsXzMxMTIJ
CT0gMCwKIAlzaWxfMzExNAkJPSAxLAogCisJU0lMX0ZJRk9fUjAJCT0gMHg0MCwKKwlTSUxfRklG
T19XMAkJPSAweDQxLAorCVNJTF9GSUZPX1IxCQk9IDB4NDQsCisJU0lMX0ZJRk9fVzEJCT0gMHg0
NSwKKwlTSUxfRklGT19SMgkJPSAweDI0MCwKKwlTSUxfRklGT19XMgkJPSAweDI0MSwKKwlTSUxf
RklGT19SMwkJPSAweDI0NCwKKwlTSUxfRklGT19XMwkJPSAweDI0NSwKKwogCVNJTF9TWVNDRkcJ
CT0gMHg0OCwKIAlTSUxfTUFTS19JREUwX0lOVAk9ICgxIDw8IDIyKSwKIAlTSUxfTUFTS19JREUx
X0lOVAk9ICgxIDw8IDIzKSwKQEAgLTE5OCw2ICsyMDcsMTMgQEAgTU9EVUxFX0xJQ0VOU0UoIkdQ
TCIpOwogTU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIHNpbF9wY2lfdGJsKTsKIE1PRFVMRV9WRVJT
SU9OKERSVl9WRVJTSU9OKTsKIAorc3RhdGljIHVuc2lnbmVkIGNoYXIgc2lsX2dldF9kZXZpY2Vf
Y2FjaGVfbGluZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKK3sKKwl1OCBjYWNoZV9saW5lOworCXBj
aV9yZWFkX2NvbmZpZ19ieXRlKHBkZXYsIFBDSV9DQUNIRV9MSU5FX1NJWkUsICZjYWNoZV9saW5l
KTsKKwlyZXR1cm4gY2FjaGVfbGluZTsKK30KKwogc3RhdGljIHZvaWQgc2lsX3Bvc3Rfc2V0X21v
ZGUgKHN0cnVjdCBhdGFfcG9ydCAqYXApCiB7CiAJc3RydWN0IGF0YV9ob3N0X3NldCAqaG9zdF9z
ZXQgPSBhcC0+aG9zdF9zZXQ7CkBAIC0zNDAsNiArMzU2LDcgQEAgc3RhdGljIGludCBzaWxfaW5p
dF9vbmUgKHN0cnVjdCBwY2lfZGV2IAogCXVuc2lnbmVkIGludCBpOwogCWludCBwY2lfZGV2X2J1
c3kgPSAwOwogCXUzMiB0bXAsIGlycV9tYXNrOworCXU4IGNsczsKIAogCWlmICghcHJpbnRlZF92
ZXJzaW9uKyspCiAJCXByaW50ayhLRVJOX0RFQlVHIERSVl9OQU1FICIgdmVyc2lvbiAiIERSVl9W
RVJTSU9OICJcbiIpOwpAQCAtNDA0LDYgKzQyMSwxNSBAQCBzdGF0aWMgaW50IHNpbF9pbml0X29u
ZSAoc3RydWN0IHBjaV9kZXYgCiAJCWF0YV9zdGRfcG9ydHMoJnByb2JlX2VudC0+cG9ydFtpXSk7
CiAJfQogCisJLyogSW5pdGlhbGl6ZSBGSUZPIFBDSSBidXMgYXJiaXRyYXRpb24gKi8KKwljbHM9
c2lsX2dldF9kZXZpY2VfY2FjaGVfbGluZShwZGV2KTsKKwljbHMgPj49IDM7CisJY2xzKys7ICAv
KiBjbHMgPSAobGluZV9zaXplLzgpKzEgKi8KKwl3cml0ZWIoY2xzLCBtbWlvX2Jhc2UgKyBTSUxf
RklGT19SMCk7CisJd3JpdGViKGNscywgbW1pb19iYXNlICsgU0lMX0ZJRk9fVzApOworCXdyaXRl
YihjbHMsIG1taW9fYmFzZSArIFNJTF9GSUZPX1IxKTsKKwl3cml0ZWIoY2xzLCBtbWlvX2Jhc2Ug
KyBTSUxfRklGT19XMik7CisKIAlpZiAoZW50LT5kcml2ZXJfZGF0YSA9PSBzaWxfMzExNCkgewog
CQlpcnFfbWFzayA9IFNJTF9NQVNLXzRQT1JUOwogCg==

------_=_NextPart_001_01C52FCB.54EFE624--
