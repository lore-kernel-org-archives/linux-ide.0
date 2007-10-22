From: "Kuan Luo" <kluo@nvidia.com>
Subject: [PATCH] ata:  sata_nv MCP61 using GENERIC instead of SWNCQ
Date: Mon, 22 Oct 2007 14:00:56 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B059FE1CF@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C81470.E9292213"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.112.145]:7667 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXJVGBJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Oct 2007 02:01:09 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C81470.E9292213
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

hi,=20
=09The mcp61 has bug with ncq. The patch only changes SWNCQ to
GENERIC  on MCP61 in nv_pci_tbl structure.

Best regards,
Kuan Luo

-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

------_=_NextPart_001_01C81470.E9292213
Content-Type: application/octet-stream;
	name="sata_nv-mcp61-generic-patch"
Content-Transfer-Encoding: base64
Content-Description: sata_nv-mcp61-generic-patch
Content-Disposition: attachment;
	filename="sata_nv-mcp61-generic-patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL3NhdGFfbnYuYyBiL2RyaXZlcnMvYXRhL3NhdGFfbnYu
YwppbmRleCAyNDBhODkyLi44ZTU1OTdhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2F0YS9zYXRhX252
LmMKKysrIGIvZHJpdmVycy9hdGEvc2F0YV9udi5jCkBAIC0zNjUsOSArMzY1LDkgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIG52X3BjaV90YmxbXSA9IHsKIAl7IFBDSV9WREVW
SUNFKE5WSURJQSwgUENJX0RFVklDRV9JRF9OVklESUFfTkZPUkNFX01DUDUxX1NBVEEyKSwgU1dO
Q1EgfSwKIAl7IFBDSV9WREVWSUNFKE5WSURJQSwgUENJX0RFVklDRV9JRF9OVklESUFfTkZPUkNF
X01DUDU1X1NBVEEpLCBTV05DUSB9LAogCXsgUENJX1ZERVZJQ0UoTlZJRElBLCBQQ0lfREVWSUNF
X0lEX05WSURJQV9ORk9SQ0VfTUNQNTVfU0FUQTIpLCBTV05DUSB9LAotCXsgUENJX1ZERVZJQ0Uo
TlZJRElBLCBQQ0lfREVWSUNFX0lEX05WSURJQV9ORk9SQ0VfTUNQNjFfU0FUQSksIFNXTkNRIH0s
Ci0JeyBQQ0lfVkRFVklDRShOVklESUEsIFBDSV9ERVZJQ0VfSURfTlZJRElBX05GT1JDRV9NQ1A2
MV9TQVRBMiksIFNXTkNRIH0sCi0JeyBQQ0lfVkRFVklDRShOVklESUEsIFBDSV9ERVZJQ0VfSURf
TlZJRElBX05GT1JDRV9NQ1A2MV9TQVRBMyksIFNXTkNRIH0sCisJeyBQQ0lfVkRFVklDRShOVklE
SUEsIFBDSV9ERVZJQ0VfSURfTlZJRElBX05GT1JDRV9NQ1A2MV9TQVRBKSwgR0VORVJJQyB9LAor
CXsgUENJX1ZERVZJQ0UoTlZJRElBLCBQQ0lfREVWSUNFX0lEX05WSURJQV9ORk9SQ0VfTUNQNjFf
U0FUQTIpLCBHRU5FUklDIH0sCisJeyBQQ0lfVkRFVklDRShOVklESUEsIFBDSV9ERVZJQ0VfSURf
TlZJRElBX05GT1JDRV9NQ1A2MV9TQVRBMyksIEdFTkVSSUMgfSwKIAogCXsgfSAvKiB0ZXJtaW5h
dGUgbGlzdCAqLwogfTsK

------_=_NextPart_001_01C81470.E9292213--
